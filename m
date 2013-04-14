From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 14 Apr 2013 13:42:53 +0200
Subject: [PATCH v3 09/15] ASoC: fsl-ssi: Add support for imx-pcm-fiq
In-Reply-To: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365939779-4507-10-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for non-dma pcm for imx platforms with imx-pcm-fiq support.
Instead of imx-pcm-audio, in this case imx-pcm-fiq-audio device is added
and the SIER flags are set differently.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
    Changes in v3:
     - Rename bool "dma" to "use_dma"

 sound/soc/fsl/fsl_ssi.c | 66 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0f0bed6..6a9be9c 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -121,12 +121,14 @@ struct fsl_ssi_private {
 
 	bool new_binding;
 	bool ssi_on_imx;
+	bool use_dma;
 	struct clk *clk;
 	struct platform_device *imx_pcm_pdev;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct imx_dma_data filter_data_tx;
 	struct imx_dma_data filter_data_rx;
+	struct imx_pcm_fiq_params fiq_params;
 
 	struct {
 		unsigned int rfrc;
@@ -356,7 +358,12 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 */
 
 		/* Enable the interrupts and DMA requests */
-		write_ssi(SIER_FLAGS, &ssi->sier);
+		if (ssi_private->use_dma)
+			write_ssi(SIER_FLAGS, &ssi->sier);
+		else
+			write_ssi(CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TFE0_EN |
+					CCSR_SSI_SIER_RIE |
+					CCSR_SSI_SIER_RFF0_EN, &ssi->sier);
 
 		/*
 		 * Set the watermark for transmit FIFI 0 and receive FIFO 0. We
@@ -550,7 +557,7 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(dai);
 
-	if (ssi_private->ssi_on_imx) {
+	if (ssi_private->ssi_on_imx && ssi_private->use_dma) {
 		dai->playback_dma_data = &ssi_private->dma_params_tx;
 		dai->capture_dma_data = &ssi_private->dma_params_rx;
 	}
@@ -695,6 +702,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	       sizeof(fsl_ssi_dai_template));
 	ssi_private->cpu_dai_drv.name = ssi_private->name;
 
+	ssi_private->use_dma = !of_property_read_bool(np, "fsl,imx-fiq");
+
 	/* Get the addresses and IRQ */
 	ret = of_address_to_resource(np, 0, &res);
 	if (ret) {
@@ -716,12 +725,15 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		goto error_iomap;
 	}
 
-	/* The 'name' should not have any slashes in it. */
-	ret = request_irq(ssi_private->irq, fsl_ssi_isr, 0, ssi_private->name,
-			  ssi_private);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not claim irq %u\n", ssi_private->irq);
-		goto error_irqmap;
+	if (ssi_private->use_dma) {
+		/* The 'name' should not have any slashes in it. */
+		ret = request_irq(ssi_private->irq, fsl_ssi_isr, 0,
+				ssi_private->name, ssi_private);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "could not claim irq %u\n",
+					ssi_private->irq);
+			goto error_irqmap;
+		}
 	}
 
 	/* Are the RX and the TX clocks locked? */
@@ -770,7 +782,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		 */
 		ret = of_property_read_u32_array(pdev->dev.of_node,
 					"fsl,ssi-dma-events", dma_events, 2);
-		if (ret) {
+		if (ret && !ssi_private->use_dma) {
 			dev_err(&pdev->dev, "could not get dma events\n");
 			goto error_clk;
 		}
@@ -809,12 +821,38 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	if (ssi_private->ssi_on_imx) {
-		ssi_private->imx_pcm_pdev =
-			platform_device_register_simple("imx-pcm-audio",
+		if (!ssi_private->use_dma) {
+			ssi_private->imx_pcm_pdev = platform_device_alloc(
+							"imx-fiq-pcm-audio",
+							pdev->id);
+			if (!ssi_private->imx_pcm_pdev) {
+				ret = -ENOMEM;
+				goto error_dev;
+			}
+
+			ssi_private->fiq_params.irq = ssi_private->irq;
+			ssi_private->fiq_params.base = ssi_private->ssi;
+			ssi_private->fiq_params.dma_params_rx =
+				&ssi_private->dma_params_rx;
+			ssi_private->fiq_params.dma_params_tx =
+				&ssi_private->dma_params_tx;
+
+			platform_set_drvdata(ssi_private->imx_pcm_pdev,
+					&ssi_private->fiq_params);
+			ret = platform_device_add(ssi_private->imx_pcm_pdev);
+			if (ret) {
+				dev_err(&pdev->dev, "Failed to add imx-fiq-pcm-audio device\n");
+				platform_device_put(ssi_private->imx_pcm_pdev);
+				goto error_dev;
+			}
+		} else {
+			ssi_private->imx_pcm_pdev =
+				platform_device_register_simple("imx-pcm-audio",
 							-1, NULL, 0);
-		if (IS_ERR(ssi_private->imx_pcm_pdev)) {
-			ret = PTR_ERR(ssi_private->imx_pcm_pdev);
-			goto error_dev;
+			if (IS_ERR(ssi_private->imx_pcm_pdev)) {
+				ret = PTR_ERR(ssi_private->imx_pcm_pdev);
+				goto error_dev;
+			}
 		}
 	}
 
-- 
1.8.1.5
