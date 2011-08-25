From: vinod.koul@intel.com (Koul, Vinod)
Date: Thu, 25 Aug 2011 19:07:58 +0530
Subject: [PATCH v2 3/3] dmaengine: imx-sdma: add device tree probe support
In-Reply-To: <1312430234.1536.552.camel@vkoul-udesk3>
References: <1310723066-567-1-git-send-email-shawn.guo@linaro.org>
	<1310723066-567-4-git-send-email-shawn.guo@linaro.org>
	<1312430234.1536.552.camel@vkoul-udesk3>
Message-ID: <1314279478.1606.35.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-08-04 at 09:27 +0530, Koul, Vinod wrote:
> On Fri, 2011-07-15 at 17:44 +0800, Shawn Guo wrote:
> > It adds device tree probe support for imx-sdma driver.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> I need an ack from Grant before I can apply this series
I don't think I heard back from Grant on this.
Grant let me know if you are okay with this patch

-- 
~Vinod

> >  .../devicetree/bindings/dma/fsl-imx-sdma.txt       |   17 ++++++++
> >  drivers/dma/imx-sdma.c                             |   41 ++++++++++++++++++-
> >  2 files changed, 55 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> > new file mode 100644
> > index 0000000..d1e3f44
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> > @@ -0,0 +1,17 @@
> > +* Freescale Smart Direct Memory Access (SDMA) Controller for i.MX
> > +
> > +Required properties:
> > +- compatible : Should be "fsl,<chip>-sdma"
> > +- reg : Should contain SDMA registers location and length
> > +- interrupts : Should contain SDMA interrupt
> > +- fsl,sdma-ram-script-name : Should contain the full path of SDMA RAM
> > +  scripts firmware
> > +
> > +Examples:
> > +
> > +sdma at 83fb0000 {
> > +	compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
> > +	reg = <0x83fb0000 0x4000>;
> > +	interrupts = <6>;
> > +	fsl,sdma-ram-script-name = "sdma-imx51.bin";
> > +};
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index 6b839a2..20504f0 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -32,6 +32,8 @@
> >  #include <linux/slab.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/dmaengine.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> >  
> >  #include <asm/irq.h>
> >  #include <mach/sdma.h>
> > @@ -331,6 +333,12 @@ static struct platform_device_id sdma_devtypes[] = {
> >  	}
> >  };
> >  
> > +static const struct of_device_id sdma_dt_ids[] = {
> > +	{ .compatible = "fsl,imx31-sdma", .data = &sdma_devtypes[IMX31_SDMA], },
> > +	{ .compatible = "fsl,imx35-sdma", .data = &sdma_devtypes[IMX35_SDMA], },
> > +	{ /* sentinel */ }
> > +};
> > +
> >  #define SDMA_H_CONFIG_DSPDMA	(1 << 12) /* indicates if the DSPDMA is used */
> >  #define SDMA_H_CONFIG_RTD_PINS	(1 << 11) /* indicates if Real-Time Debug pins are enabled */
> >  #define SDMA_H_CONFIG_ACR	(1 << 4)  /* indicates if AHB freq /core freq = 2 or 1 */
> > @@ -1249,6 +1257,10 @@ err_dma_alloc:
> >  
> >  static int __init sdma_probe(struct platform_device *pdev)
> >  {
> > +	const struct of_device_id *of_id =
> > +			of_match_device(sdma_dt_ids, &pdev->dev);
> > +	struct device_node *np = pdev->dev.of_node;
> > +	const char *fw_name;
> >  	int ret;
> >  	int irq;
> >  	struct resource *iores;
> > @@ -1264,7 +1276,7 @@ static int __init sdma_probe(struct platform_device *pdev)
> >  
> >  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	irq = platform_get_irq(pdev, 0);
> > -	if (!iores || irq < 0 || !pdata) {
> > +	if (!iores || irq < 0) {
> >  		ret = -EINVAL;
> >  		goto err_irq;
> >  	}
> > @@ -1294,6 +1306,8 @@ static int __init sdma_probe(struct platform_device *pdev)
> >  	if (!sdma->script_addrs)
> >  		goto err_alloc;
> >  
> > +	if (of_id)
> > +		pdev->id_entry = of_id->data;
> >  	sdma->devtype = pdev->id_entry->driver_data;
> >  
> >  	dma_cap_set(DMA_SLAVE, sdma->dma_device.cap_mask);
> > @@ -1324,10 +1338,30 @@ static int __init sdma_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		goto err_init;
> >  
> > -	if (pdata->script_addrs)
> > +	if (pdata && pdata->script_addrs)
> >  		sdma_add_scripts(sdma, pdata->script_addrs);
> >  
> > -	sdma_get_firmware(sdma, pdata->fw_name);
> > +	if (pdata) {
> > +		sdma_get_firmware(sdma, pdata->fw_name);
> > +	} else {
> > +		/*
> > +		 * Because that device tree does not encode ROM script address,
> > +		 * the RAM script in firmware is mandatory for device tree
> > +		 * probe, otherwise it fails.
> > +		 */
> > +		ret = of_property_read_string(np, "fsl,sdma-ram-script-name",
> > +					      &fw_name);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "failed to get firmware name\n");
> > +			goto err_init;
> > +		}
> > +
> > +		ret = sdma_get_firmware(sdma, fw_name);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "failed to get firmware\n");
> > +			goto err_init;
> > +		}
> > +	}
> >  
> >  	sdma->dma_device.dev = &pdev->dev;
> >  
> > @@ -1375,6 +1409,7 @@ static int __exit sdma_remove(struct platform_device *pdev)
> >  static struct platform_driver sdma_driver = {
> >  	.driver		= {
> >  		.name	= "imx-sdma",
> > +		.of_match_table = sdma_dt_ids,
> >  	},
> >  	.id_table	= sdma_devtypes,
> >  	.remove		= __exit_p(sdma_remove),
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
