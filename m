From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 12 Mar 2012 19:58:56 +0800
Subject: [PATCH v4 09/10] ASoC: fsl: let fsl_ssi work with imx pcm and machine
 drivers
In-Reply-To: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
References: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1331553537-19789-10-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Makes necessary changes on fsl_ssi to let it work with imx pcm and
machine drivers.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/fsl_ssi.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0192c02..3cf23e5 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -28,6 +28,7 @@
 #include <sound/soc.h>
 
 #include "fsl_ssi.h"
+#include "imx-pcm.h"
 
 #ifdef PPC
 #define read_ssi(addr)			 in_be32(addr)
@@ -116,6 +117,11 @@ struct fsl_ssi_private {
 	struct device_attribute dev_attr;
 	struct platform_device *pdev;
 
+	int ssi_on_imx;
+	struct platform_device *imx_pcm_pdev;
+	struct imx_pcm_dma_params dma_params_tx;
+	struct imx_pcm_dma_params dma_params_rx;
+
 	struct {
 		unsigned int rfrc;
 		unsigned int tfrc;
@@ -413,6 +419,12 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		ssi_private->second_stream = substream;
 	}
 
+	if (ssi_private->ssi_on_imx)
+		snd_soc_dai_set_dma_data(dai, substream,
+			(substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+				&ssi_private->dma_params_tx :
+				&ssi_private->dma_params_rx);
+
 	return 0;
 }
 
@@ -706,6 +718,35 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
                 /* Older 8610 DTs didn't have the fifo-depth property */
 		ssi_private->fifo_depth = 8;
 
+	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx21-ssi")) {
+		u32 dma_events[2];
+		ssi_private->ssi_on_imx = 1;
+		/*
+		 * We have burstsize be "fifo_depth - 2" to match the SSI
+		 * watermark setting in fsl_ssi_startup().
+		 */
+		ssi_private->dma_params_tx.burstsize =
+			ssi_private->fifo_depth - 2;
+		ssi_private->dma_params_rx.burstsize =
+			ssi_private->fifo_depth - 2;
+		ssi_private->dma_params_tx.dma_addr =
+			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, stx0);
+		ssi_private->dma_params_rx.dma_addr =
+			ssi_private->ssi_phys + offsetof(struct ccsr_ssi, srx0);
+		/*
+		 * TODO: This is a temporary solution and should be changed
+		 * to use generic DMA binding later when the helplers get in.
+		 */
+		ret = of_property_read_u32_array(pdev->dev.of_node,
+					"fsl,ssi-dma-events", dma_events, 2);
+		if (ret) {
+			dev_err(&pdev->dev, "could not get dma events\n");
+			goto error_irq;
+		}
+		ssi_private->dma_params_tx.dma = dma_events[0];
+		ssi_private->dma_params_rx.dma = dma_events[1];
+	}
+
 	/* Initialize the the device_attribute structure */
 	dev_attr = &ssi_private->dev_attr;
 	sysfs_attr_init(&dev_attr->attr);
@@ -729,6 +770,24 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 		goto error_dev;
 	}
 
+	/*
+	 * In case of imx, the machine driver uses new binding which does
+	 * not require SSI driver to trigger machine driver's probe, but
+	 * the pcm device needs to be registered here.
+	 */
+	if (ssi_private->ssi_on_imx) {
+		ssi_private->imx_pcm_pdev =
+			platform_device_register_simple("imx-pcm-audio",
+							-1, NULL, 0);
+		if (IS_ERR(ssi_private->imx_pcm_pdev)) {
+			ret = PTR_ERR(ssi_private->imx_pcm_pdev);
+			goto error_dev;
+		} else {
+			/* success for imx */
+			return 0;
+		}
+	}
+
 	/* Trigger the machine driver's probe function.  The platform driver
 	 * name of the machine driver is taken from /compatible property of the
 	 * device tree.  We also pass the address of the CPU DAI driver
@@ -754,6 +813,8 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 
 error_dai:
 	snd_soc_unregister_dai(&pdev->dev);
+	if (ssi_private->ssi_on_imx)
+		platform_device_unregister(ssi_private->imx_pcm_pdev);
 
 error_dev:
 	dev_set_drvdata(&pdev->dev, NULL);
@@ -780,6 +841,8 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 
 	platform_device_unregister(ssi_private->pdev);
 	snd_soc_unregister_dai(&pdev->dev);
+	if (ssi_private->ssi_on_imx)
+		platform_device_unregister(ssi_private->imx_pcm_pdev);
 	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
 
 	free_irq(ssi_private->irq, ssi_private);
@@ -793,6 +856,7 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 
 static const struct of_device_id fsl_ssi_ids[] = {
 	{ .compatible = "fsl,mpc8610-ssi", },
+	{ .compatible = "fsl,imx21-ssi", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
-- 
1.7.5.4
