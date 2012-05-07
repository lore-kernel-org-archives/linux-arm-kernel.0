From: marex@denx.de (Marek Vasut)
Date: Tue, 8 May 2012 01:39:35 +0200
Subject: [PATCH 4/6] dma: mxs-dma: add device tree probe support
In-Reply-To: <1336400595-12964-5-git-send-email-shawn.guo@linaro.org>
References: <1336400595-12964-1-git-send-email-shawn.guo@linaro.org>
 <1336400595-12964-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <201205080139.36079.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Rob Landley <rob@landley.net>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Huang Shijie <b32955@freescale.com>
> Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

Acked-by: Marek Vasut <marex@denx.de>

> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../devicetree/bindings/dma/fsl-mxs-dma.txt        |   19 +++++++++++++
>  drivers/dma/mxs-dma.c                              |   29
> ++++++++++++++++--- 2 files changed, 43 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
> b/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt new file mode
> 100644
> index 0000000..ded0398
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/fsl-mxs-dma.txt
> @@ -0,0 +1,19 @@
> +* Freescale MXS DMA
> +
> +Required properties:
> +- compatible : Should be "fsl,<chip>-dma-apbh" or "fsl,<chip>-dma-apbx"
> +- reg : Should contain registers location and length
> +
> +Supported chips:
> +imx23, imx28.
> +
> +Examples:
> +dma-apbh at 80004000 {
> +	compatible = "fsl,imx28-dma-apbh";
> +	reg = <0x80004000 2000>;
> +};
> +
> +dma-apbx at 80024000 {
> +	compatible = "fsl,imx28-dma-apbx";
> +	reg = <0x80024000 2000>;
> +};
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index 5d9813c..fe8c498 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -22,8 +22,11 @@
>  #include <linux/platform_device.h>
>  #include <linux/dmaengine.h>
>  #include <linux/delay.h>
> +#include <linux/module.h>
>  #include <linux/fsl/mxs-dma.h>
>  #include <linux/stmp_device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> 
>  #include <asm/irq.h>
>  #include <mach/mxs.h>
> @@ -173,6 +176,15 @@ static struct platform_device_id mxs_dma_ids[] = {
>  	}
>  };
> 
> +static const struct of_device_id mxs_dma_dt_ids[] = {
> +	{ .compatible = "fsl,imx23-dma-apbh", .data = &mxs_dma_ids[0], },
> +	{ .compatible = "fsl,imx23-dma-apbx", .data = &mxs_dma_ids[1], },
> +	{ .compatible = "fsl,imx28-dma-apbh", .data = &mxs_dma_ids[2], },
> +	{ .compatible = "fsl,imx28-dma-apbx", .data = &mxs_dma_ids[3], },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mxs_dma_dt_ids);
> +
>  static struct mxs_dma_chan *to_mxs_dma_chan(struct dma_chan *chan)
>  {
>  	return container_of(chan, struct mxs_dma_chan, chan);
> @@ -648,10 +660,9 @@ err_out:
> 
>  static int __init mxs_dma_probe(struct platform_device *pdev)
>  {
> -	const struct platform_device_id *id_entry =
> -				platform_get_device_id(pdev);
> -	const struct mxs_dma_type *dma_type =
> -			(struct mxs_dma_type *)id_entry->driver_data;
> +	const struct platform_device_id *id_entry;
> +	const struct of_device_id *of_id;
> +	const struct mxs_dma_type *dma_type;
>  	struct mxs_dma_engine *mxs_dma;
>  	struct resource *iores;
>  	int ret, i;
> @@ -660,8 +671,15 @@ static int __init mxs_dma_probe(struct platform_device
> *pdev) if (!mxs_dma)
>  		return -ENOMEM;
> 
> -	mxs_dma->dev_id = dma_type->id;
> +	of_id = of_match_device(mxs_dma_dt_ids, &pdev->dev);
> +	if (of_id)
> +		id_entry = of_id->data;
> +	else
> +		id_entry = platform_get_device_id(pdev);
> +
> +	dma_type = (struct mxs_dma_type *)id_entry->driver_data;
>  	mxs_dma->type = dma_type->type;
> +	mxs_dma->dev_id = dma_type->id;
> 
>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 
> @@ -747,6 +765,7 @@ err_request_region:
>  static struct platform_driver mxs_dma_driver = {
>  	.driver		= {
>  		.name	= "mxs-dma",
> +		.of_match_table = mxs_dma_dt_ids,
>  	},
>  	.id_table	= mxs_dma_ids,
>  };

Best regards,
Marek Vasut
