From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Mar 2012 16:56:43 +0800
Subject: [PATCH v5 7/8] ASoC: fsl: let fsl_ssi work with imx pcm and machine
 drivers
In-Reply-To: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1331888204-27058-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Makes necessary changes on fsl_ssi to let it work with imx pcm and
machine drivers.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c |   77 ++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index db9a734..30ff605 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -28,6 +28,7 @@
 #include <sound/soc.h>
 
 #include "fsl_ssi.h"
+#include "imx-pcm.h"
 
 #ifdef PPC
 #define read_ssi(addr)			 in_be32(addr)
@@ -116,6 +117,12 @@ struct fsl_ssi_private {
 	struct device_attribute dev_attr;
 	struct platform_device *pdev;
 
+	bool new_binding;
+	bool ssi_on_imx;
+	struct platform_device *imx_pcm_pdev;
+	struct imx_pcm_dma_params dma_params_tx;
+	struct imx_pcm_dma_params dma_params_rx;
+
 	struct {
 		unsigned int rfrc;
 		unsigned int tfrc;
@@ -413,6 +420,12 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
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
 
@@ -642,12 +655,6 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 	if (!of_device_is_available(np))
 		return -ENODEV;
 
-	/* Check for a codec-handle property. */
-	if (!of_get_property(np, "codec-handle", NULL)) {
-		dev_err(&pdev->dev, "missing codec-handle property\n");
-		return -ENODEV;
-	}
-
 	/* We only support the SSI in "I2S Slave" mode */
 	sprop = of_get_property(np, "fsl,mode", NULL);
 	if (!sprop || strcmp(sprop, "i2s-slave")) {
@@ -712,6 +719,35 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
                 /* Older 8610 DTs didn't have the fifo-depth property */
 		ssi_private->fifo_depth = 8;
 
+	if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx21-ssi")) {
+		u32 dma_events[2];
+		ssi_private->ssi_on_imx = true;
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
@@ -735,6 +771,26 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 		goto error_dev;
 	}
 
+	if (ssi_private->ssi_on_imx) {
+		ssi_private->imx_pcm_pdev =
+			platform_device_register_simple("imx-pcm-audio",
+							-1, NULL, 0);
+		if (IS_ERR(ssi_private->imx_pcm_pdev)) {
+			ret = PTR_ERR(ssi_private->imx_pcm_pdev);
+			goto error_dev;
+		}
+	}
+
+	/*
+	 * If codec-handle property is missing from SSI node, we assume
+	 * that the machine driver uses new binding which does not require
+	 * SSI driver to trigger machine driver's probe.
+	 */
+	if (!of_get_property(np, "codec-handle", NULL)) {
+		ssi_private->new_binding = true;
+		goto done;
+	}
+
 	/* Trigger the machine driver's probe function.  The platform driver
 	 * name of the machine driver is taken from /compatible property of the
 	 * device tree.  We also pass the address of the CPU DAI driver
@@ -756,9 +812,12 @@ static int __devinit fsl_ssi_probe(struct platform_device *pdev)
 		goto error_dai;
 	}
 
+done:
 	return 0;
 
 error_dai:
+	if (ssi_private->ssi_on_imx)
+		platform_device_unregister(ssi_private->imx_pcm_pdev);
 	snd_soc_unregister_dai(&pdev->dev);
 
 error_dev:
@@ -784,7 +843,10 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 {
 	struct fsl_ssi_private *ssi_private = dev_get_drvdata(&pdev->dev);
 
-	platform_device_unregister(ssi_private->pdev);
+	if (!ssi_private->new_binding)
+		platform_device_unregister(ssi_private->pdev);
+	if (ssi_private->ssi_on_imx)
+		platform_device_unregister(ssi_private->imx_pcm_pdev);
 	snd_soc_unregister_dai(&pdev->dev);
 	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
 
@@ -799,6 +861,7 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 
 static const struct of_device_id fsl_ssi_ids[] = {
 	{ .compatible = "fsl,mpc8610-ssi", },
+	{ .compatible = "fsl,imx21-ssi", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
-- 
1.7.5.4
