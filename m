From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 14 Jul 2011 20:54:13 -0600
Subject: [PATCH 2/2] dmaengine: imx-sdma: add device tree probe support
In-Reply-To: <1310660057-17953-3-git-send-email-shawn.guo@linaro.org>
References: <1310660057-17953-1-git-send-email-shawn.guo@linaro.org>
	<1310660057-17953-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110715025413.GJ2927@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 12:14:17AM +0800, Shawn Guo wrote:
> It adds device tree probe support for imx-sdma driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   55 ++++++++++++++++++++
>  drivers/dma/imx-sdma.c                             |   29 +++++++++-
>  2 files changed, 81 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> new file mode 100644
> index 0000000..71f4525
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> @@ -0,0 +1,55 @@
> +* Freescale Smart Direct Memory Access (SDMA) Controller for i.MX
> +
> +Required properties:
> +- compatible : Should be "fsl,<chip>-sdma"
> +- reg : Should contain SDMA registers location and length
> +- interrupts : Should contain SDMA interrupt
> +- fsl,sdma-script-name : Should contain the full path of SDMA RAM scripts
> +  firmware
> +- fsl,sdma-script-address : Should be an array giving entry address for each
> +  script.  The address should be 0 in case that the specified script is not
> +  included in the firmware.  See example below for the array details.
> +
> +Examples:
> +
> +sdma at 83fb0000 {
> +	compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
> +	reg = <0x83fb0000 0x4000>;
> +	interrupts = <6>;
> +	fsl,sdma-script-name = "sdma-imx51.bin";
> +	fsl,sdma-script-address = <642>,	/* ap_2_ap */
> +				  <0>,		/* ap_2_bp */
> +				  <0>,		/* ap_2_ap_fixed */
> +				  <0>,		/* bp_2_ap */
> +				  <0>,		/* loopback_on_dsp_side */
> +				  <0>,		/* mcu_interrupt_only */
> +				  <0>,		/* firi_2_per */
> +				  <0>,		/* firi_2_mcu */
> +				  <0>,		/* per_2_firi */
> +				  <0>,		/* mcu_2_firi */
> +				  <0>,		/* uart_2_per */
> +				  <817>,	/* uart_2_mcu */
> +				  <0>,		/* per_2_app */
> +				  <747>,	/* mcu_2_app */
> +				  <0>,		/* per_2_per */
> +				  <0>,		/* uartsh_2_per */
> +				  <0>,		/* uartsh_2_mcu */
> +				  <0>,		/* per_2_shp */
> +				  <961>,	/* mcu_2_shp */
> +				  <1473>,	/* ata_2_mcu */
> +				  <1392>,	/* mcu_2_ata */
> +				  <1033>,	/* app_2_per */
> +				  <683>,	/* app_2_mcu */
> +				  <1251>,	/* shp_2_per */
> +				  <892>,	/* shp_2_mcu */
> +				  <0>,		/* mshc_2_mcu */
> +				  <0>,		/* mcu_2_mshc */
> +				  <0>,		/* spdif_2_mcu */
> +				  <0>,		/* mcu_2_spdif */
> +				  <0>,		/* asrc_2_mcu */
> +				  <0>,		/* ext_mem_2_ipu */
> +				  <0>,		/* descrambler */
> +				  <0>,		/* dptc_dvfs */
> +				  <0>,		/* utra_addr */
> +				  <0>;		/* ram_code_start */

This looks icky.  Where do these numbers come from?  How are the
offsets loaded into ram?  Are they properties of the firmware blob?
If so, then maybe they should be embedded in the firmware blob instead
of encoded in a DT that may become out of sync.

> +};
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 4a7aa72..664f7bc 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -32,6 +32,8 @@
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
>  #include <linux/dmaengine.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include <asm/irq.h>
>  #include <mach/sdma.h>
> @@ -331,6 +333,12 @@ static struct platform_device_id sdma_devtypes[] = {
>  	}
>  };
>  
> +static const struct of_device_id sdma_dt_ids[] = {
> +	{ .compatible = "fsl,imx31-sdma", .data = &sdma_devtypes[IMX31_SDMA], },
> +	{ .compatible = "fsl,imx35-sdma", .data = &sdma_devtypes[IMX35_SDMA], },
> +	{ /* sentinel */ }
> +};
> +
>  #define SDMA_H_CONFIG_DSPDMA	(1 << 12) /* indicates if the DSPDMA is used */
>  #define SDMA_H_CONFIG_RTD_PINS	(1 << 11) /* indicates if Real-Time Debug pins are enabled */
>  #define SDMA_H_CONFIG_ACR	(1 << 4)  /* indicates if AHB freq /core freq = 2 or 1 */
> @@ -1257,6 +1265,10 @@ err_dma_alloc:
>  
>  static int __init sdma_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *of_id =
> +			of_match_device(sdma_dt_ids, &pdev->dev);
> +	struct device_node *np = pdev->dev.of_node;
> +	const char *fw_name;
>  	int ret;
>  	int irq;
>  	struct resource *iores;
> @@ -1272,7 +1284,7 @@ static int __init sdma_probe(struct platform_device *pdev)
>  
>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	irq = platform_get_irq(pdev, 0);
> -	if (!iores || irq < 0 || !pdata) {
> +	if (!iores || irq < 0) {
>  		ret = -EINVAL;
>  		goto err_irq;
>  	}
> @@ -1302,6 +1314,8 @@ static int __init sdma_probe(struct platform_device *pdev)
>  	if (!sdma->script_addrs)
>  		goto err_alloc;
>  
> +	if (of_id)
> +		pdev->id_entry = of_id->data;
>  	sdma->devtype = pdev->id_entry->driver_data;
>  
>  	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
> @@ -1332,10 +1346,18 @@ static int __init sdma_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_init;
>  
> -	if (pdata->script_addrs)
> +	ret = of_property_read_u32_array(np, "fsl,sdma-script-address",
> +				(u32 *) sdma->script_addrs,
> +				sizeof(*sdma->script_addrs) / sizeof(u32));
> +	if (ret < 0 && pdata && pdata->script_addrs)
>  		sdma_add_scripts(sdma, pdata->script_addrs);
>  
> -	sdma_get_firmware(sdma, pdata->fw_name);
> +	ret = of_property_read_string(np, "fsl,sdma-script-name",
> +				      &fw_name);
> +	if (!ret)
> +		sdma_get_firmware(sdma, fw_name);
> +	else if (pdata)
> +		sdma_get_firmware(sdma, pdata->fw_name);
>  
>  	sdma->dma_device.dev = &pdev->dev;
>  
> @@ -1383,6 +1405,7 @@ static int __exit sdma_remove(struct platform_device *pdev)
>  static struct platform_driver sdma_driver = {
>  	.driver		= {
>  		.name	= "imx-sdma",
> +		.of_match_table = sdma_dt_ids,
>  	},
>  	.id_table	= sdma_devtypes,
>  	.remove		= __exit_p(sdma_remove),
> -- 
> 1.7.4.1
> 
