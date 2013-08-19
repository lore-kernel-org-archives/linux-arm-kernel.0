From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 19 Aug 2013 17:06:00 +0200
Subject: [PATCH v11 7/8] ASoC: fsl-ssi: imx-pcm-fiq bugfix
In-Reply-To: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1376924761-4054-8-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

imx-pcm-fiq is checking for TE RE bits, so enable them only if
necessary.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 3af15e9..8407d59 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -383,30 +383,11 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 		&ssi->sfcsr);
 
 	/*
-	 * For non-ac97 setups, we keep the SSI disabled because if we enable
-	 * it, then the DMA controller will start. It's not supposed to start
-	 * until the SCR.TE (or SCR.RE) bit is set, but it does anyway. The DMA
-	 * controller will transfer one "BWC" of data (i.e. the amount of data
-	 * that the MR.BWC bits are set to). The reason this is bad is because
-	 * at this point, the PCM driver has not finished initializing the DMA
-	 * controller.
-	 */
-
-
-	/*
 	 * For ac97 interrupts are enabled with the startup of the substream
 	 * because it is also running without an active substream. Normally SSI
 	 * is only enabled when there is a substream.
 	 */
-	if (!ssi_private->imx_ac97) {
-		/* Enable the interrupts and DMA requests */
-		if (ssi_private->use_dma)
-			write_ssi(SIER_FLAGS, &ssi->sier);
-		else
-			write_ssi(CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TFE0_EN |
-					CCSR_SSI_SIER_RIE |
-					CCSR_SSI_SIER_RFF0_EN, &ssi->sier);
-	} else {
+	if (ssi_private->imx_ac97) {
 		/*
 		 * Setup the clock control register
 		 */
@@ -574,6 +555,27 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	unsigned int sier_bits;
+
+	/*
+	 *  Enable only the interrupts and DMA requests
+	 *  that are needed for the channel. As the fiq
+	 *  is polling for this bits, we have to ensure
+	 *  that this are aligned with the preallocated
+	 *  buffers
+	 */
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		if (ssi_private->use_dma)
+			sier_bits = SIER_FLAGS;
+		else
+			sier_bits = CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TFE0_EN;
+	} else {
+		if (ssi_private->use_dma)
+			sier_bits = SIER_FLAGS;
+		else
+			sier_bits = CCSR_SSI_SIER_RIE | CCSR_SSI_SIER_RFF0_EN;
+	}
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -602,6 +604,8 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		return -EINVAL;
 	}
 
+	write_ssi(sier_bits, &ssi->sier);
+
 	return 0;
 }
 
-- 
1.8.4.rc3
