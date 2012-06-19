From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 19 Jun 2012 17:47:56 +0900
Subject: [PATCH 2/3] spi: Add the use of DMA config operation
In-Reply-To: <011601cd42eb$8314ab10$893e0130$%kim@samsung.com>
References: <011601cd42eb$8314ab10$893e0130$%kim@samsung.com>
Message-ID: <019301cd4df8$3a5883c0$af098b40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boojin Kim wrote:
> 
> Config operation is separated from request operation in DMA common
> operation.
> Because spi driver can change the DMA config for every transfer.
> So this patch is using the separated DMA config operation.
> 
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c |   33 +++++++++++++++++++--------------
>  1 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 15f864d..f4e2341 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -262,14 +262,24 @@ static void prepare_dma(struct s3c64xx_spi_dma_data
> *dma,
>  					unsigned len, dma_addr_t buf)
>  {
>  	struct s3c64xx_spi_driver_data *sdd;
> -	struct samsung_dma_prep_info info;
> +	struct samsung_dma_prep info;
> +	struct samsung_dma_config config;
> 
> -	if (dma->direction == DMA_DEV_TO_MEM)
> +	if (dma->direction == DMA_DEV_TO_MEM) {
>  		sdd = container_of((void *)dma,
>  			struct s3c64xx_spi_driver_data, rx_dma);
> -	else
> +		config.direction = sdd->rx_dma.direction;
> +		config.fifo = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
> +		config.width = sdd->cur_bpw / 8;
> +		sdd->ops->config(sdd->rx_dma.ch, &config);
> +	} else {
>  		sdd = container_of((void *)dma,
>  			struct s3c64xx_spi_driver_data, tx_dma);
> +		config.direction =  sdd->tx_dma.direction;
> +		config.fifo = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
> +		config.width = sdd->cur_bpw / 8;
> +		sdd->ops->config(sdd->tx_dma.ch, &config);
> +	}
> 
>  	info.cap = DMA_SLAVE;
>  	info.len = len;
> @@ -284,20 +294,15 @@ static void prepare_dma(struct s3c64xx_spi_dma_data
> *dma,
> 
>  static int acquire_dma(struct s3c64xx_spi_driver_data *sdd)
>  {
> -	struct samsung_dma_info info;
> +	struct samsung_dma_req req;
> 
>  	sdd->ops = samsung_dma_get_ops();
> 
> -	info.cap = DMA_SLAVE;
> -	info.client = &s3c64xx_spi_dma_client;
> -	info.width = sdd->cur_bpw / 8;
> -
> -	info.direction = sdd->rx_dma.direction;
> -	info.fifo = sdd->sfr_start + S3C64XX_SPI_RX_DATA;
> -	sdd->rx_dma.ch = sdd->ops->request(sdd->rx_dma.dmach, &info);
> -	info.direction =  sdd->tx_dma.direction;
> -	info.fifo = sdd->sfr_start + S3C64XX_SPI_TX_DATA;
> -	sdd->tx_dma.ch = sdd->ops->request(sdd->tx_dma.dmach, &info);
> +	req.cap = DMA_SLAVE;
> +	req.client = &s3c64xx_spi_dma_client;
> +
> +	sdd->rx_dma.ch = sdd->ops->request(sdd->rx_dma.dmach, &req);
> +	sdd->tx_dma.ch = sdd->ops->request(sdd->tx_dma.dmach, &req);
> 
>  	return 1;
>  }
> --
> 1.7.1

Hi Grant,

I think, this is needed to support Samsung SPI with DMA and this has
dependency with other patches in this series.

If you're ok on this, please reply with your ack :) so that I can take this
series together.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
