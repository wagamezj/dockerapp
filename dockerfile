# Instalar servidor de shiny con rocker
FROM rocker/shiny-verse:latest

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev 

# Bajar e instalar las librerías de R
RUN R -e "install.packages(c('shinythemes', 'DT', 'shinydashboard', 'shinyjs', 'V8', 'ggrepel','RSocrata','BatchGetSymbols','plotly','dplyr'))"
RUN R -e "devtools::install_github('andrewsali/shinycssloaders')"

# Copiar la app a la imagen

COPY app.R /srv/shiny-server/
COPY BGS_Cache /srv/shiny-server/BGS_Cache


# select port
EXPOSE 3838

# allow permission
RUN sudo chown -R shiny:shiny /srv/shiny-server

# run app
#CMD ["/usr/bin/shiny-server.sh"]