From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 8 Mar 2012 20:15:26 +0100
Subject: [PATCH v3 10/11] ASoC: fsl: let fsl_ssi work with imx pcm and
 machine drivers
In-Reply-To: <1331225990-27308-11-git-send-email-shawn.guo@linaro.org>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-11-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120308191526.GQ3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 12:59:49AM +0800, Shawn Guo wrote:
> Makes necessary changes on fsl_ssi to let it work with imx pcm and
> machine drivers.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  sound/soc/fsl/fsl_ssi.c |   67 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 67 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index e5903cb..c251ee9 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -29,6 +29,7 @@
>  #include <sound/soc.h>
>  
>  #include "fsl_ssi.h"
> +#include "imx-pcm.h"
>  
>  #ifdef PPC
>  #define read_ssi(addr)			 in_be32(addr)
> @@ -119,6 +120,11 @@ struct fsl_ssi_private {
>  	struct device_attribute dev_attr;
>  	struct platform_device *pdev;
>  
> +	int ssi_on_imx;
> +	struct platform_device *imx_pcm_pdev;
> +	struct imx_pcm_dma_params dma_params_tx;
> +	struct imx_pcm_dma_params dma_params_rx;
> +
>  	struct {
>  		unsigned int rfrc;
>  		unsigned int tfrc;
> @@ -416,6 +422,12 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
>  		ssi_private->second_stream = substream;
>  	}
>  
> +	if (ssi_private->ssi_on_imx)
> +		snd_soc_dai_set_dma_data(dai, substream,
> +			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
> +				&ssi_private->dma_params_tx :
> +				&ssi_private->dma_params_rx);
> +
>  	return 0;
>  }
>  
> @@ -709,6 +721,38 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
>                  /* Older 8610 DTs didn't have the fifo-depth property */
>  		ssi_private->fifo_depth = 8;
>  
> +	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx1-ssi")) {
> +		u32 dma_events[2];
> +		ssi_private->ssi_on_imx = 1;
> +		/*
> +		 * FIXME: The dma burst size must equal to ssi watermark
> +		 * setting on imx.  We have burstsize be "fifo_depth - 2"
> +		 * here because "fifo_depth - 2" rather than fifo_depth is
> +		 * being written into watermark register in fsl_ssi_startup().
> +		 * Is this something needs to be fixed for PowerPC?
> +		 */
> +		ssi_private->dma_params_tx.burstsize =
> +			ssi_private->fifo_depth - 2;
> +		ssi_private->dma_params_rx.burstsize =
> +			ssi_private->fifo_depth - 2;
> +		ssi_private->dma_params_tx.dma_addr =
> +			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, stx0);
> +		ssi_private->dma_params_rx.dma_addr =
> +			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, srx0);
> +		/*
> +		 * TODO: This is a temporary solution and should be changed
> +		 * to use generic DMA binding later when the helplers get in.
> +		 */
> +		ret = of_property_read_u32_array(pdev->dev.of_node,
> +					"fsl,ssi-dma-events", dma_events, 2);
> +		if (ret) {
> +			dev_err(&pdev->dev, "could not get dma events\n");
> +			goto error_irq;
> +		}
> +		ssi_private->dma_params_tx.dma = dma_events[0];
> +		ssi_private->dma_params_rx.dma = dma_events[1];
> +	}
> +
>  	/* Initialize the the device_attribute structure */
>  	dev_attr = &ssi_private->dev_attr;
>  	sysfs_attr_init(&dev_attr->attr);
> @@ -732,6 +776,24 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
>  		goto error_dev;
>  	}
>  
> +	/*
> +	 * In case of imx, the machine driver uses new binding which does
> +	 * not require SSI driver to trigger machine driver's probe, but
> +	 * the pcm device needs to be registered here.
> +	 */
> +	if (ssi_private->ssi_on_imx) {
> +		ssi_private->imx_pcm_pdev =
> +			platform_device_register_simple("imx-pcm-audio",
> +							-1, NULL, 0);
> +		if (IS_ERR(ssi_private->imx_pcm_pdev)) {
> +			ret = PTR_ERR(ssi_private->imx_pcm_pdev);
> +			goto error_dev;
> +		} else {
> +			/* success for imx */
> +			return 0;
> +		}
> +	}
> +
>  	/* Trigger the machine driver's probe function.  The platform driver
>  	 * name of the machine driver is taken from /compatible property of the
>  	 * device tree.  We also pass the address of the CPU DAI driver
> @@ -757,6 +819,8 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
>  
>  error_dai:
>  	snd_soc_unregister_dai(&pdev->dev);
> +	if (ssi_private->ssi_on_imx)
> +		platform_device_unregister(ssi_private->imx_pcm_pdev);
>  
>  error_dev:
>  	dev_set_drvdata(&pdev->dev, NULL);
> @@ -783,6 +847,8 @@ static int fsl_ssi_remove(struct platform_device *pdev)
>  
>  	platform_device_unregister(ssi_private->pdev);
>  	snd_soc_unregister_dai(&pdev->dev);
> +	if (ssi_private->ssi_on_imx)
> +		platform_device_unregister(ssi_private->imx_pcm_pdev);
>  	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
>  
>  	free_irq(ssi_private->irq, ssi_private);
> @@ -796,6 +862,7 @@ static int fsl_ssi_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id fsl_ssi_ids[] = {
>  	{ .compatible = "fsl,mpc8610-ssi", },
> +	{ .compatible = "fsl,imx1-ssi", },

imx1 seems wrong here. The register layout has changed significantly between
i.MX1 and i.MX21.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
