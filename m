From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 14 Jul 2011 20:54:07 -0600
Subject: [PATCH v2] mtd: dataflash: add device tree probe support
In-Reply-To: <1310658757-17018-1-git-send-email-shawn.guo@linaro.org>
References: <1310283313-32087-1-git-send-email-shawn.guo@linaro.org>
	<1310658757-17018-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110715025407.GF2927@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 11:52:37PM +0800, Shawn Guo wrote:
> It adds device tree probe support for mtd_dataflash driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> ---
> Changes since v1:
>  * Add "atmel,at45xxx" into the match table
>  * Add binding document
> 
>  .../devicetree/bindings/mtd/atmel-dataflash.txt    |   14 ++++++++++++++
>  drivers/mtd/devices/mtd_dataflash.c                |   13 ++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/atmel-dataflash.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-dataflash.txt b/Documentation/devicetree/bindings/mtd/atmel-dataflash.txt
> new file mode 100644
> index 0000000..3783962
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/atmel-dataflash.txt
> @@ -0,0 +1,14 @@
> +* Atmel Data Flash
> +
> +Required properties:
> +- compatible : "atmel,<model>", "atmel,<series>", "atmel,dataflash".
> +
> +Example:
> +
> +flash at 1 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "atmel,at45db321d", "atmel,at45xxx", "atmel,dataflash";
> +	spi-max-frequency = <25000000>;
> +	reg = <1>;
> +};
> diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
> index 8f6b02c..8e091b0 100644
> --- a/drivers/mtd/devices/mtd_dataflash.c
> +++ b/drivers/mtd/devices/mtd_dataflash.c
> @@ -24,6 +24,8 @@
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
>  
> +#include <linux/of.h>
> +#include <linux/of_device.h>

This shouldn't be separate from the regular block of #include
statements above it.
>  
>  /*
>   * DataFlash is a kind of SPI flash.  Most AT45 chips have two buffers in
> @@ -98,6 +100,12 @@ struct dataflash {
>  	struct mtd_info		mtd;
>  };
>  
> +static const struct of_device_id dataflash_dt_ids[] = {
> +	{ .compatible = "atmel,at45xxx", },
> +	{ .compatible = "atmel,dataflash", },
> +	{ /* sentinel */ }
> +};
> +

This should be protected with a #ifdef CONFIG_OF/#else/#endif, and
there should be a MODULE_DEVICE_TABLE().

>  /* ......................................................................... */
>  
>  /*
> @@ -634,6 +642,7 @@ add_dataflash_otp(struct spi_device *spi, char *name,
>  {
>  	struct dataflash		*priv;
>  	struct mtd_info			*device;
> +	struct mtd_part_parser_data	ppdata;
>  	struct flash_platform_data	*pdata = spi->dev.platform_data;
>  	char				*otp_tag = "";
>  	int				err = 0;
> @@ -675,7 +684,8 @@ add_dataflash_otp(struct spi_device *spi, char *name,
>  			pagesize, otp_tag);
>  	dev_set_drvdata(&spi->dev, priv);
>  
> -	err = mtd_device_parse_register(device, NULL, 0,
> +	ppdata.of_node = spi->dev.of_node;
> +	err = mtd_device_parse_register(device, NULL, &ppdata,
>  			pdata ? pdata->parts : NULL,
>  			pdata ? pdata->nr_parts : 0);
>  
> @@ -926,6 +936,7 @@ static struct spi_driver dataflash_driver = {
>  		.name		= "mtd_dataflash",
>  		.bus		= &spi_bus_type,
>  		.owner		= THIS_MODULE,
> +		.of_match_table = dataflash_dt_ids,
>  	},
>  
>  	.probe		= dataflash_probe,
> -- 
> 1.7.4.1
> 
