From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 26 Jul 2012 02:59:51 +0200
Subject: [PATCH 3/7] MTD: pxa3xx-nand: add devicetree bindings
In-Reply-To: <1343233066-15397-4-git-send-email-zonque@gmail.com>
References: <1343233066-15397-1-git-send-email-zonque@gmail.com>
 <1343233066-15397-4-git-send-email-zonque@gmail.com>
Message-ID: <201207260259.51511.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Daniel Mack,

> This patch contains a hack to get the DMA resources of the device when
> probed from a devicetree node. This can be removed once a generic DMA
> controller framework lands.
> 
> A mtd_part_parser_data is passed mtd_device_parse_register which
> contains a reference to the device node, so MTD partitions can be
> added as children.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> ---
>  .../devicetree/bindings/mtd/pxa3xx-nand.txt        |   31 ++++++++
>  drivers/mtd/nand/pxa3xx_nand.c                     |   83
> ++++++++++++++++---- 2 files changed, 100 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
> b/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt new file mode
> 100644
> index 0000000..6e28cef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/pxa3xx-nand.txt
> @@ -0,0 +1,31 @@
> +PXA3xx NAND DT bindings
> +
> +Required properties:
> +
> + - compatible:		Should be "mrvl,pxa3xx-nand"
> + - reg: 		The register base for the controller
> + - interrupts:		The interrupt to map
> + - #address-cells:	Set to <1> if the node includes partitions
> +
> +Optional properties:
> +
> + - mrvl,nand-enable-arbiter:	Set to enable the bus arbiter
> + - mrvl,nand-keep-config:	Set to keep the NAND controller config as set
> +				by the bootloader
> + - num-cs:			Number of chipselect lines to usw
> +
> +Example:
> +
> +	nand0: nand at 43100000 {
> +		compatible = "mrvl,pxa3xx-nand";
> +		reg = <0x43100000 90> ;

0x90 maybe?

> +		interrupts = <45>;
> +		#address-cells = <1>;
> +
> +		mrvl,nand-enable-arbiter;
> +		mrvl,nand-keep-config;
> +		num-cs = <1>;
> +
> +		/* partitions (optional) */
> +	};
> +
> diff --git a/drivers/mtd/nand/pxa3xx_nand.c
> b/drivers/mtd/nand/pxa3xx_nand.c index 252aaef..fb592a9 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -22,6 +22,8 @@
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> 
>  #include <mach/dma.h>
>  #include <plat/pxa3xx_nand.h>
> @@ -1081,21 +1083,29 @@ static int alloc_nand_resource(struct
> platform_device *pdev) }
>  	clk_enable(info->clk);
> 
> -	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> -	if (r == NULL) {
> -		dev_err(&pdev->dev, "no resource defined for data DMA\n");
> -		ret = -ENXIO;
> -		goto fail_put_clk;
> -	}
> -	info->drcmr_dat = r->start;
> +	/*
> +	 * This is a dirty hack to make this driver work from devicetree
> +	 * bindings. It can be removed once we have a prober DMA controller
> +	 * framework for DT.
> +	 */
> +	if (pdev->dev.of_node && cpu_is_pxa3xx()) {
> +		info->drcmr_dat = 97;
> +		info->drcmr_cmd = 99;

cpu_is_() stuff should begone ... besides, what are these numbers here?

> +	} else {
> +		r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
> +		if (r == NULL) {
> +			dev_err(&pdev->dev, "no resource defined for data 
DMA\n");
> +			ret = -ENXIO;
> +			goto fail_put_clk;
> +		}
> 
> -	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
> -	if (r == NULL) {
> -		dev_err(&pdev->dev, "no resource defined for command DMA\n");
> -		ret = -ENXIO;
> -		goto fail_put_clk;
> +		r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
> +		if (r == NULL) {
> +			dev_err(&pdev->dev, "no resource defined for command 
DMA\n");
> +			ret = -ENXIO;
> +			goto fail_put_clk;
> +		}
>  	}
> -	info->drcmr_cmd = r->start;
> 
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> @@ -1200,12 +1210,55 @@ static int pxa3xx_nand_remove(struct
> platform_device *pdev) return 0;
>  }
> 
> +#ifdef CONFIG_OF
> +static struct of_device_id pxa3xx_nand_dt_ids[] = {
> +	{ .compatible = "mrvl,pxa3xx-nand" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, i2c_pxa_dt_ids);
> +
> +static int pxa3xx_nand_probe_dt(struct platform_device *pdev)
> +{
> +	struct pxa3xx_nand_platform_data *pdata;
> +	struct device_node *np = pdev->dev.of_node;
> +	const struct of_device_id *of_id =
> +			of_match_device(pxa3xx_nand_dt_ids, &pdev->dev);
> +
> +	if (!of_id)
> +		return 0;
> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	if (of_get_property(np, "mrvl,nand-enable-arbiter", NULL))
> +		pdata->enable_arbiter = 1;
> +	if (of_get_property(np, "mrvl,nand-keep-config", NULL))

of_property_read_bool() please.

> +		pdata->keep_config = 1;
> +	of_property_read_u32(np, "num-cs", &pdata->num_cs);
> +
> +	pdev->dev.platform_data = pdata;
> +
> +	return 0;
> +}
> +#else
> +static inline int pxa3xx_nand_probe_dt(struct platform_device *)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int pxa3xx_nand_probe(struct platform_device *pdev)
>  {
>  	struct pxa3xx_nand_platform_data *pdata;
> +	struct mtd_part_parser_data ppdata = {};
>  	struct pxa3xx_nand_info *info;
>  	int ret, cs, probe_success;
> 
> +	ret = pxa3xx_nand_probe_dt(pdev);
> +	if (ret)
> +		return ret;
> +
>  	pdata = pdev->dev.platform_data;
>  	if (!pdata) {
>  		dev_err(&pdev->dev, "no platform data defined\n");
> @@ -1229,8 +1282,9 @@ static int pxa3xx_nand_probe(struct platform_device
> *pdev) continue;
>  		}
> 
> +		ppdata.of_node = pdev->dev.of_node;
>  		ret = mtd_device_parse_register(info->host[cs]->mtd, NULL,
> -						NULL, pdata->parts[cs],
> +						&ppdata, pdata->parts[cs],
>  						pdata->nr_parts[cs]);
>  		if (!ret)
>  			probe_success = 1;
> @@ -1306,6 +1360,7 @@ static int pxa3xx_nand_resume(struct platform_device
> *pdev) static struct platform_driver pxa3xx_nand_driver = {
>  	.driver = {
>  		.name	= "pxa3xx-nand",
> +		.of_match_table = of_match_ptr(pxa3xx_nand_dt_ids),
>  	},
>  	.probe		= pxa3xx_nand_probe,
>  	.remove		= pxa3xx_nand_remove,
