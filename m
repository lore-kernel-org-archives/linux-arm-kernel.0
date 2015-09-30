From: b38343@freescale.com (Robin Gong)
Date: Wed, 30 Sep 2015 16:54:59 +0800
Subject: [PATCH v2 7/8] spi: imx: defer spi initialization, if DMA engine
 is pending
In-Reply-To: <42b82309e539e8a5523dca5364846c472ab9dcee.1442923630.git.anton_bondarenko@mentor.com>
References: <cover.1442923630.git.anton_bondarenko@mentor.com>
 <42b82309e539e8a5523dca5364846c472ab9dcee.1442923630.git.anton_bondarenko@mentor.com>
Message-ID: <20150930085458.GG2709@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 07:57:14PM +0200, Anton Bondarenko wrote:
> If SPI device supports DMA mode, but DMA controller is not yet
> available due to e.g. a delay in the corresponding kernel module
> initialization, retry to initialize SPI driver later on instead of
> falling back into PIO only mode.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Signed-off-by: Anton Bondarenko <anton_bondarenko@mentor.com>
> ---
>  drivers/spi/spi-imx.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 44d3cf0..1bf0739a 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1343,9 +1343,15 @@ static int spi_imx_probe(struct platform_device *pdev)
>  	 * Only validated on i.mx6 now, can remove the constrain if validated on
>  	 * other chips.
>  	 */
> -	if (is_imx5x_ecspi(spi_imx) &&
> -	    spi_imx_sdma_init(&pdev->dev, spi_imx, master))
> -		dev_err(&pdev->dev, "dma setup error,use pio instead\n");
> +	if (is_imx5x_ecspi(spi_imx)) {
> +		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master);
> +		if (ret == -EPROBE_DEFER)
> +			goto out_clk_put;
> +
> +		if (ret < 0)
> +			dev_err(&pdev->dev, "dma setup error %d, use pio\n",
> +				ret);
> +	}
>  
>  	spi_imx->devtype_data->reset(spi_imx);
>  
> -- 
> 2.5.2
> 
