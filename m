From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 18 Dec 2013 12:57:43 +0100
Subject: [PATCH v3 7/9] ASoC: fsl-ssi: Move RX/TX configuration to seperate
 functions
In-Reply-To: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1387367865-26391-8-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch defines the appropriate register values for different
oparation modes and IP versions. We have to handle DMA/FIQ, AC97,
DEBUG-IRQs and offline/online configuration support.

With this patch we cleanup some driver code that was not reference
manual conform and try to cleanup the whole trigger function to seperate
the actual register values from the enable/disable logic, which is now
hidden in fsl_ssi_config helpers.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 94 +++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 46 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index eabf568..26190f9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -107,13 +107,6 @@ static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
 	 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_LE)
 #endif
 
-/* SIER bitflag of interrupts to enable */
-#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TDMAE | \
-		    CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TUE0_EN | \
-		    CCSR_SSI_SIER_TUE1_EN | CCSR_SSI_SIER_RFRC_EN | \
-		    CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE | \
-		    CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN)
-
 #define FSLSSI_SIER_DBG_RX_FLAGS (CCSR_SSI_SIER_RFF0_EN | \
 		CCSR_SSI_SIER_RLS_EN | CCSR_SSI_SIER_RFS_EN | \
 		CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_RFRC_EN)
@@ -565,6 +558,43 @@ static void fsl_ssi_tx_config(struct fsl_ssi_private *ssi_private, bool enable)
 	fsl_ssi_config(ssi_private, enable, &ssi_private->rxtx_reg_val.tx);
 }
 
+/*
+ * Setup rx/tx register values used to enable/disable the streams. These will
+ * be used later in fsl_ssi_config to setup the streams without the need to
+ * check for all different SSI modes.
+ */
+static void fsl_ssi_setup_reg_vals(struct fsl_ssi_private *ssi_private)
+{
+	struct fsl_ssi_rxtx_reg_val *reg = &ssi_private->rxtx_reg_val;
+
+	reg->rx.sier = CCSR_SSI_SIER_RFF0_EN;
+	reg->rx.srcr = CCSR_SSI_SRCR_RFEN0;
+	reg->rx.scr = 0;
+	reg->tx.sier = CCSR_SSI_SIER_TFE0_EN;
+	reg->tx.stcr = CCSR_SSI_STCR_TFEN0;
+	reg->tx.scr = 0;
+
+	if (!ssi_private->imx_ac97) {
+		reg->rx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE;
+		reg->rx.sier |= CCSR_SSI_SIER_RFF0_EN;
+		reg->tx.scr = CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE;
+		reg->tx.sier |= CCSR_SSI_SIER_TFE0_EN;
+	}
+
+	if (ssi_private->use_dma) {
+		reg->rx.sier |= CCSR_SSI_SIER_RDMAE;
+		reg->tx.sier |= CCSR_SSI_SIER_TDMAE;
+	} else {
+		reg->rx.sier |= CCSR_SSI_SIER_RIE;
+		reg->tx.sier |= CCSR_SSI_SIER_TIE;
+	}
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	reg->rx.sier |= FSLSSI_SIER_DBG_RX_FLAGS;
+	reg->tx.sier |= FSLSSI_SIER_DBG_TX_FLAGS;
+#endif
+}
+
 static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
 {
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
@@ -601,6 +631,8 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 	u8 wm;
 	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates;
 
+	fsl_ssi_setup_reg_vals(ssi_private);
+
 	if (ssi_private->imx_ac97)
 		ssi_private->i2s_mode = CCSR_SSI_SCR_I2S_MODE_NORMAL | CCSR_SSI_SCR_NET;
 	else
@@ -624,13 +656,12 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 		ssi_private->i2s_mode |
 		(synchronous ? CCSR_SSI_SCR_SYN : 0));
 
-	write_ssi(CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFEN0 |
-		 CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TEFS |
-		 CCSR_SSI_STCR_TSCKP, &ssi->stcr);
+	write_ssi(CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFSI |
+			CCSR_SSI_STCR_TEFS | CCSR_SSI_STCR_TSCKP, &ssi->stcr);
+
+	write_ssi(CCSR_SSI_SRCR_RXBIT0 | CCSR_SSI_SRCR_RFSI |
+			CCSR_SSI_SRCR_REFS | CCSR_SSI_SRCR_RSCKP, &ssi->srcr);
 
-	write_ssi(CCSR_SSI_SRCR_RXBIT0 | CCSR_SSI_SRCR_RFEN0 |
-		 CCSR_SSI_SRCR_RFSI | CCSR_SSI_SRCR_REFS |
-		 CCSR_SSI_SRCR_RSCKP, &ssi->srcr);
 	/*
 	 * The DC and PM bits are only used if the SSI is the clock master.
 	 */
@@ -762,57 +793,28 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
-	unsigned int sier_bits;
-
-	/*
-	 *  Enable only the interrupts and DMA requests
-	 *  that are needed for the channel. As the fiq
-	 *  is polling for this bits, we have to ensure
-	 *  that this are aligned with the preallocated
-	 *  buffers
-	 */
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (ssi_private->use_dma)
-			sier_bits = SIER_FLAGS;
-		else
-			sier_bits = CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TFE0_EN;
-	} else {
-		if (ssi_private->use_dma)
-			sier_bits = SIER_FLAGS;
-		else
-			sier_bits = CCSR_SSI_SIER_RIE | CCSR_SSI_SIER_RFF0_EN;
-	}
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			write_ssi_mask(&ssi->scr, 0,
-				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE);
+			fsl_ssi_tx_config(ssi_private, true);
 		else
-			write_ssi_mask(&ssi->scr, 0,
-				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE);
+			fsl_ssi_rx_config(ssi_private, true);
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TE, 0);
+			fsl_ssi_tx_config(ssi_private, false);
 		else
-			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_RE, 0);
-
-		if (!ssi_private->imx_ac97 && (read_ssi(&ssi->scr) &
-					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0)
-			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
+			fsl_ssi_rx_config(ssi_private, false);
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
-	write_ssi(sier_bits, &ssi->sier);
 
 	return 0;
 }
-- 
1.8.5.1
