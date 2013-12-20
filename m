From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 20 Dec 2013 14:11:34 +0100
Subject: [PATCH v4 7/9] ASoC: fsl-ssi: Move RX/TX configuration to seperate
 functions
In-Reply-To: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1387545096-2334-8-git-send-email-mpa@pengutronix.de>
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
 sound/soc/fsl/fsl_ssi.c | 89 +++++++++++++++++++++++++------------------------
 1 file changed, 46 insertions(+), 43 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 70bb466..c25f593 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -108,13 +108,6 @@ static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
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
@@ -584,6 +577,41 @@ static void fsl_ssi_tx_config(struct fsl_ssi_private *ssi_private, bool enable)
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
+	reg->rx.sier |= FSLSSI_SIER_DBG_RX_FLAGS;
+	reg->tx.sier |= FSLSSI_SIER_DBG_TX_FLAGS;
+}
+
 static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
 {
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
@@ -620,6 +648,8 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
 	u8 wm;
 	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates;
 
+	fsl_ssi_setup_reg_vals(ssi_private);
+
 	if (ssi_private->imx_ac97)
 		ssi_private->i2s_mode = CCSR_SSI_SCR_I2S_MODE_NORMAL | CCSR_SSI_SCR_NET;
 	else
@@ -643,13 +673,12 @@ static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
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
@@ -1023,51 +1052,26 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
-	unsigned int sier_bits;
 	unsigned long flags;
 
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
-
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
+			fsl_ssi_rx_config(ssi_private, false);
 
 		if (!ssi_private->imx_ac97 && (read_ssi(&ssi->scr) &
 					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0) {
-			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
 			spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
 			ssi_private->baudclk_locked = false;
 			spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
@@ -1078,7 +1082,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		return -EINVAL;
 	}
 
-	write_ssi(sier_bits, &ssi->sier);
 
 	return 0;
 }
-- 
1.8.5.1
