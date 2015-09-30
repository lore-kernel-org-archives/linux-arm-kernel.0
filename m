From: b38343@freescale.com (Robin Gong)
Date: Wed, 30 Sep 2015 16:51:59 +0800
Subject: [PATCH v2 6/8] spi: imx: return error from dma channel request
In-Reply-To: <2d4cc8c07de8e90b76763d2c40aea57c598ee1a1.1442923630.git.anton_bondarenko@mentor.com>
References: <cover.1442923630.git.anton_bondarenko@mentor.com>
 <2d4cc8c07de8e90b76763d2c40aea57c598ee1a1.1442923630.git.anton_bondarenko@mentor.com>
Message-ID: <20150930085158.GF2709@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 07:57:13PM +0200, Anton Bondarenko wrote:
> On SDMA initialization return exactly the same error, which is
> reported by dma_request_slave_channel_reason(), it is a preceding
> change to defer SPI DMA initialization, if SDMA module is not yet
> available.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Signed-off-by: Anton Bondarenko <anton_bondarenko@mentor.com>
> ---
>  drivers/spi/spi-imx.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 4b3c16e..44d3cf0 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -929,18 +929,20 @@ static int spi_imx_sdma_init(struct device *dev, struct spi_imx_data *spi_imx,
>  	spi_imx->wml = spi_imx_get_fifosize(spi_imx) / 2;
>  
>  	/* Prepare for TX DMA: */
> -	master->dma_tx = dma_request_slave_channel(dev, "tx");
> -	if (!master->dma_tx) {
> -		dev_err(dev, "cannot get the TX DMA channel!\n");
> -		ret = -EINVAL;
> +	master->dma_tx = dma_request_slave_channel_reason(dev, "tx");
> +	if (IS_ERR(master->dma_tx)) {
> +		dev_info(dev, "cannot get the TX DMA channel!\n");
> +		ret = PTR_ERR(master->dma_tx);
> +		master->dma_tx = NULL;
>  		goto err;
>  	}
>  
>  	/* Prepare for RX : */
> -	master->dma_rx = dma_request_slave_channel(dev, "rx");
> -	if (!master->dma_rx) {
> -		dev_dbg(dev, "cannot get the DMA channel.\n");
> -		ret = -EINVAL;
> +	master->dma_rx = dma_request_slave_channel_reason(dev, "rx");
> +	if (IS_ERR(master->dma_rx)) {
> +		dev_info(dev, "cannot get the DMA channel.\n");
> +		ret = PTR_ERR(master->dma_rx);
> +		master->dma_rx = NULL;
>  		goto err;
>  	}
>  
> -- 
> 2.5.2
> 
