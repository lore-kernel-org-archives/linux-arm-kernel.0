From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Apr 2013 21:25:15 +0200
Subject: [PATCH v2 05/11] ASoC: fsl-ssi: Add support for imx-pcm-fiq
In-Reply-To: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365362721-3731-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for non-dma pcm for imx platforms with imx-pcm-fiq support.
Instead of imx-pcm-audio, in this case imx-pcm-fiq-audio device is added
and the SIER flags are set differently.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 70 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 7decbd9..afb5a23 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -120,10 +120,12 @@ struct fsl_ssi_private {
 
 	bool new_binding;
 	bool ssi_on_imx;
+	bool dma;
 	struct clk *clk;
 	struct platform_device *imx_pcm_pdev;
 	struct imx_pcm_dma_params dma_params_tx;
 	struct imx_pcm_dma_params dma_params_rx;
+	struct imx_pcm_fiq_params fiq_params;
 
 	struct {
 		unsigned int rfrc;
@@ -353,7 +355,8 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		 */
 
 		/* Enable the interrupts and DMA requests */
-		write_ssi(SIER_FLAGS, &ssi->sier);
+		if (ssi_private->dma)
+			write_ssi(SIER_FLAGS, &ssi->sier);
 
 		/*
 		 * Set the watermark for transmit FIFI 0 and receive FIFO 0. We
@@ -520,6 +523,18 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		return -EINVAL;
 	}
 
+	if (!ssi_private->dma) {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			write_ssi(CCSR_SSI_SOR_TX_CLR, &ssi->sor);
+			write_ssi(CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TFE0_EN,
+					&ssi->sier);
+		} else {
+			write_ssi(CCSR_SSI_SOR_RX_CLR, &ssi->sor);
+			write_ssi(CCSR_SSI_SIER_RIE | CCSR_SSI_SIER_RFF0_EN,
+					&ssi->sier);
+		}
+	}
+
 	return 0;
 }
 
@@ -680,6 +695,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	       sizeof(fsl_ssi_dai_template));
 	ssi_private->cpu_dai_drv.name = ssi_private->name;
 
+	ssi_private->dma = !of_property_read_bool(np, "fsl,imx-fiq");
+
 	/* Get the addresses and IRQ */
 	ret = of_address_to_resource(np, 0, &res);
 	if (ret) {
@@ -701,12 +718,15 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		goto error_iomap;
 	}
 
-	/* The 'name' should not have any slashes in it. */
-	ret = request_irq(ssi_private->irq, fsl_ssi_isr, 0, ssi_private->name,
-			  ssi_private);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not claim irq %u\n", ssi_private->irq);
-		goto error_irqmap;
+	if (ssi_private->dma) {
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
@@ -789,12 +809,38 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	if (ssi_private->ssi_on_imx) {
-		ssi_private->imx_pcm_pdev =
-			platform_device_register_simple("imx-pcm-audio",
+		if (!ssi_private->dma) {
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
