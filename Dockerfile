# ---- Stage 1: Build Angular App ----
FROM node:18 AS build-stage

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build -- --configuration production

# ---- Stage 2: Nginx container serving Angular ----
FROM nginx:alpine

COPY --from=build-stage /app/dist/angularproject/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
