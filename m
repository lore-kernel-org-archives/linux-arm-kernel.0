From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 13 Jul 2012 07:38:38 +0900
Subject: [PATCH v5 6/6] spi: s3c64xx: add device tree support
In-Reply-To: <1342021265-11212-7-git-send-email-thomas.abraham@linaro.org>
References: <1342021265-11212-1-git-send-email-thomas.abraham@linaro.org>
 <1342021265-11212-7-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4FFF51EE.4080609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/12 00:41, Thomas Abraham wrote:
> Add support for device based discovery.
>
> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
> Acked-by: Jaswinder Singh<jaswinder.singh@linaro.org>
> Acked-by: Grant Likely<grant.likely@secretlab.ca>
> ---
>   .../devicetree/bindings/spi/spi-samsung.txt        |  113 ++++++++
>   drivers/spi/spi-s3c64xx.c                          |  305 +++++++++++++++++---
>   2 files changed, 378 insertions(+), 40 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
>

[snip]

> @@ -989,49 +1057,166 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
>   	flush_fifo(sdd);
>   }
>
> +static int __devinit s3c64xx_spi_get_dmares(
> +			struct s3c64xx_spi_driver_data *sdd, bool tx)
> +{
> +	struct platform_device *pdev = sdd->pdev;
> +	struct s3c64xx_spi_dma_data *dma_data;
> +	struct property *prop;
> +	struct resource *res;
> +	char prop_name[15], *chan_str;
> +
> +	if (tx) {
> +		dma_data =&sdd->tx_dma;
> +		dma_data->direction = DMA_TO_DEVICE;
> +		chan_str = "tx";
> +	} else {
> +		dma_data =&sdd->rx_dma;
> +		dma_data->direction = DMA_FROM_DEVICE;
> +		chan_str = "rx";
> +	}
> +
> +	if (!sdd->pdev->dev.of_node) {
> +		res = platform_get_resource(pdev, IORESOURCE_DMA, tx ? 0 : 1);
> +		if (!res) {
> +			dev_err(&pdev->dev, "Unable to get SPI-%s dma "
> +					"resource\n", chan_str);
> +			return -ENXIO;
> +		}
> +		dma_data->dmach = res->start;
> +		return 0;
> +	}
> +
> +	sprintf(prop_name, "%s-dma-channel", chan_str);
> +	prop = of_find_property(pdev->dev.of_node, prop_name, NULL);
> +	if (!prop) {
> +		dev_err(&pdev->dev, "%s dma channel property not specified\n",
> +					chan_str);
> +		return -ENXIO;
> +	}
> +
> +	dma_data->dmach = DMACH_DT_PROP;

Thomas, the DMACH_DT_PROP is available only on pl330 now. So seems occur 
following build error with s3c6400_defconfig.

drivers/spi/spi-s3c64xx.c: In function 's3c64xx_spi_get_dmares':
drivers/spi/spi-s3c64xx.c:1098: error: 'DMACH_DT_PROP' undeclared (first 
use in this function)
drivers/spi/spi-s3c64xx.c:1098: error: (Each undeclared identifier is 
reported only once
drivers/spi/spi-s3c64xx.c:1098: error: for each function it appears in.)
make[3]: *** [drivers/spi/spi-s3c64xx.o] Error 1
make[2]: *** [drivers/spi] Error 2

> +	dma_data->dma_prop = prop;
> +	return 0;
> +}

[snip]

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
