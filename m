From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Jun 2013 15:20:23 +0200
Subject: [PATCH v9 04/10] ASoC: fsl-ssi: Add support for imx-pcm-fiq
In-Reply-To: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1371734429-6081-5-git-send-email-mpa@pengutronix.de>
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

Notes:
    Changes in v4:
     - Add a comment about the reason why we add a imx-pcm-fiq device.
     - Change commit message to include information about the usage of imx-pcm-fiq
    
    Changes in v3:
     - Rename bool "dma" to "use_dma"

 sound/soc/fsl/fsl_ssi.c | 77 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index db55499..2fe4dbd 100644
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
@@ -549,7 +576,7 @@ static int fsl_ssi_dai_probe(struct snd_soc_dai *dai)
 {
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(dai);
 
-	if (ssi_private->ssi_on_imx) {
+	if (ssi_private->ssi_on_imx && ssi_private->use_dma) {
 		dai->playback_dma_data = &ssi_private->dma_params_tx;
 		dai->capture_dma_data = &ssi_private->dma_params_rx;
 	}
@@ -702,6 +729,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	       sizeof(fsl_ssi_dai_template));
 	ssi_private->cpu_dai_drv.name = ssi_private->name;
 
+	ssi_private->use_dma = !of_property_read_bool(np, "fsl,imx-fiq");
+
 	/* Get the addresses and IRQ */
 	ret = of_address_to_resource(np, 0, &res);
 	if (ret) {
@@ -723,12 +752,15 @@ static int fsl_ssi_probe(struct platform_device *pdev)
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
@@ -777,7 +809,7 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		 */
 		ret = of_property_read_u32_array(pdev->dev.of_node,
 					"fsl,ssi-dma-events", dma_events, 2);
-		if (ret) {
+		if (ret && !ssi_private->use_dma) {
 			dev_err(&pdev->dev, "could not get dma events\n");
 			goto error_clk;
 		}
@@ -816,9 +848,30 @@ static int fsl_ssi_probe(struct platform_device *pdev)
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
1.8.2.1
