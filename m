From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 27 Jul 2013 13:31:53 +0200
Subject: [PATCH v10 4/7] ASoC: fsl-ssi: Add support for imx-pcm-fiq
In-Reply-To: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1374924716-23475-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for non-dma pcm for imx platforms with imx-pcm-fiq support.
Instead of imx-pcm-audio, in this case imx-pcm-fiq-audio device is added
and the SIER flags are set differently.

We need imx-pcm-fiq for some boards that use an incompatible codec.
imx-pcm-fiq handles those codecs differently and allows to operate with
them. DMA is not possible because some data sent by the codecs, e.g.
wm9712, is not in the datastream. Also some data is mixed up in the
fifos, so that we need to sort them out manually.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Tested-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/sound/fsl,ssi.txt          |  4 ++
 sound/soc/fsl/fsl_ssi.c                            | 79 ++++++++++++++++++----
 2 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
index 5ff76c9..e45cbce 100644
--- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
@@ -47,6 +47,10 @@ Optional properties:
 - codec-handle:     Phandle to a 'codec' node that defines an audio
                     codec connected to this SSI.  This node is typically
                     a child of an I2C or other control node.
+- fsl,fiq-stream-filter: Bool property. Disabled DMA and use FIQ instead to
+		    filter the codec stream. This is necessary for some boards
+		    where an incompatible codec is connected to this SSI, e.g.
+		    on pca100 and pcm043.
 
 Child 'codec' node required properties:
 - compatible:       Compatible list, contains the name of the codec
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 4d78df7..8b075ef 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -8,6 +8,26 @@
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
+ *
+ *
+ * Some notes why imx-pcm-fiq is used instead of DMA on some boards:
+ *
+ * The i.MX SSI core has some nasty limitations in AC97 mode. While most
+ * sane processor vendors have a FIFO per AC97 slot, the i.MX has only
+ * one FIFO which combines all valid receive slots. We cannot even select
+ * which slots we want to receive. The WM9712 with which this driver
+ * was developed with always sends GPIO status data in slot 12 which
+ * we receive in our (PCM-) data stream. The only chance we have is to
+ * manually skip this data in the FIQ handler. With sampling rates different
+ * from 48000Hz not every frame has valid receive data, so the ratio
+ * between pcm data and GPIO status data changes. Our FIQ handler is not
+ * able to handle this, hence this driver only works with 48000Hz sampling
+ * rate.
+ * Reading and writing AC97 registers is another challenge. The core
+ * provides us status bits when the read register is updated with *another*
+ * value. When we read the same register two times (and the register still
+ * contains the same value) these status bits are not set. We work
+ * around this by not polling these bits but only wait a fixed delay.
  */
 
 #include <linux/init.h>
@@ -121,11 +141,13 @@ struct fsl_ssi_private {
 
 	bool new_binding;
 	bool ssi_on_imx;
+	bool use_dma;
 	struct clk *clk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct imx_dma_data filter_data_tx;
 	struct imx_dma_data filter_data_rx;
+	struct imx_pcm_fiq_params fiq_params;
 
 	struct {
 		unsigned int rfrc;
@@ -355,7 +377,12 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
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
@@ -543,7 +570,7 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(dai);
 
-	if (ssi_private->ssi_on_imx) {
+	if (ssi_private->ssi_on_imx && ssi_private->use_dma) {
 		dai->playback_dma_data = &ssi_private->dma_params_tx;
 		dai->capture_dma_data = &ssi_private->dma_params_rx;
 	}
@@ -683,6 +710,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	strcpy(ssi_private->name, p);
 
+	ssi_private->use_dma = !of_property_read_bool(np,
+			"fsl,fiq-stream-filter");
+
 	/* Initialize this copy of the CPU DAI driver structure */
 	memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
 	       sizeof(fsl_ssi_dai_template));
@@ -707,12 +737,16 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	/* The 'name' should not have any slashes in it. */
-	ret = devm_request_irq(&pdev->dev, ssi_private->irq, fsl_ssi_isr, 0,
-			       ssi_private->name, ssi_private);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not claim irq %u\n", ssi_private->irq);
-		goto error_irqmap;
+	if (ssi_private->use_dma) {
+		/* The 'name' should not have any slashes in it. */
+		ret = devm_request_irq(&pdev->dev, ssi_private->irq,
+					fsl_ssi_isr, 0, ssi_private->name,
+					ssi_private);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "could not claim irq %u\n",
+					ssi_private->irq);
+			goto error_irqmap;
+		}
 	}
 
 	/* Are the RX and the TX clocks locked? */
@@ -766,7 +800,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		 */
 		ret = of_property_read_u32_array(pdev->dev.of_node,
 					"fsl,ssi-dma-events", dma_events, 2);
-		if (ret) {
+		if (ret && !ssi_private->use_dma) {
 			dev_err(&pdev->dev, "could not get dma events\n");
 			goto error_clk;
 		}
@@ -805,9 +839,30 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	if (ssi_private->ssi_on_imx) {
-		ret = imx_pcm_dma_init(pdev);
-		if (ret)
-			goto error_dev;
+		if (!ssi_private->use_dma) {
+
+			/*
+			 * Some boards use an incompatible codec. To get it
+			 * working, we are using imx-fiq-pcm-audio, that
+			 * can handle those codecs. DMA is not possible in this
+			 * situation.
+			 */
+
+			ssi_private->fiq_params.irq = ssi_private->irq;
+			ssi_private->fiq_params.base = ssi_private->ssi;
+			ssi_private->fiq_params.dma_params_rx =
+				&ssi_private->dma_params_rx;
+			ssi_private->fiq_params.dma_params_tx =
+				&ssi_private->dma_params_tx;
+
+			ret = imx_pcm_fiq_init(pdev, &ssi_private->fiq_params);
+			if (ret)
+				goto error_dev;
+		} else {
+			ret = imx_pcm_dma_init(pdev);
+			if (ret)
+				goto error_dev;
+		}
 	}
 
 	/*
-- 
1.8.3.2
