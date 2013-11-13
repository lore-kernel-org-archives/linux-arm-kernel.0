From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 13 Nov 2013 14:12:10 +0100
Subject: [PATCH] ASoC: fsl-ssi: Fix interrupt enable/disable
Message-ID: <1384348330-23117-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The fsl_ssi_trigger function enables all interrupts (for RX and TX) when a stream is
started. The enabled interrupts are never cleared. We don't need all
interrupts enabled for one active stream, e.g. RX interrupts are not
necessary for playback. Next to the interrupts, the DMA enable bits are
set at the same time. This can lead to lost DMA requests and SDMA
starvation.

This patch seperates the SIER flags into DMA_TX and DMA_RX flags to
seperatly enable/disable the TX/RX channels.

Based on J?rgen Beisert's patch 'ASoC: fsl-ssi: fix SDMA starvation'.

Cc: J?rgen Beisert <jbe@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 6b81d0c..905b8db 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -107,11 +107,18 @@ static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
 #endif
 
 /* SIER bitflag of interrupts to enable */
-#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TDMAE | \
-		    CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TUE0_EN | \
-		    CCSR_SSI_SIER_TUE1_EN | CCSR_SSI_SIER_RFRC_EN | \
-		    CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE | \
-		    CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN)
+#define FSLSSI_TX_SIER_FLAGS (CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TFE0_EN)
+#define FSLSSI_RX_SIER_FLAGS (CCSR_SSI_SIER_RIE | CCSR_SSI_SIER_RFF0_EN)
+
+#define FSLSSI_DMA_TX_SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | \
+		CCSR_SSI_SIER_TDMAE | CCSR_SSI_SIER_TIE | \
+		CCSR_SSI_SIER_TUE0_EN | CCSR_SSI_SIER_TUE1_EN)
+#define FSLSSI_DMA_RX_SIER_FLAGS (CCSR_SSI_SIER_RFRC_EN | \
+		CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE | \
+		CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN)
+
+#define FSLSSI_SISR_MASK (FSLSSI_TX_SIER_FLAGS | FSLSSI_RX_SIER_FLAGS | \
+		FSLSSI_DMA_TX_SIER_FLAGS | FSLSSI_DMA_RX_SIER_FLAGS)
 
 /**
  * fsl_ssi_private: per-SSI private data
@@ -201,7 +208,7 @@ static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
 	   were interrupted for.  We mask it with the Interrupt Enable register
 	   so that we only check for events that we're interested in.
 	 */
-	sisr = read_ssi(&ssi->sisr) & SIER_FLAGS;
+	sisr = read_ssi(&ssi->sisr) & FSLSSI_SISR_MASK;
 
 	if (sisr & CCSR_SSI_SISR_RFRC) {
 		ssi_private->stats.rfrc++;
@@ -567,19 +574,20 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (ssi_private->use_dma)
-			sier_bits = SIER_FLAGS;
+			sier_bits = FSLSSI_DMA_TX_SIER_FLAGS;
 		else
-			sier_bits = CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TFE0_EN;
+			sier_bits = FSLSSI_TX_SIER_FLAGS;
 	} else {
 		if (ssi_private->use_dma)
-			sier_bits = SIER_FLAGS;
+			sier_bits = FSLSSI_DMA_RX_SIER_FLAGS;
 		else
-			sier_bits = CCSR_SSI_SIER_RIE | CCSR_SSI_SIER_RFF0_EN;
+			sier_bits = FSLSSI_RX_SIER_FLAGS;
 	}
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		write_ssi_mask(&ssi->sier, 0, sier_bits);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			write_ssi_mask(&ssi->scr, 0,
 				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE);
@@ -590,6 +598,7 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		write_ssi_mask(&ssi->sier, sier_bits, 0);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TE, 0);
 		else
@@ -604,8 +613,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		return -EINVAL;
 	}
 
-	write_ssi(sier_bits, &ssi->sier);
-
 	return 0;
 }
 
@@ -801,7 +808,7 @@ static struct snd_ac97_bus_ops fsl_ssi_ac97_ops = {
  */
 #define SIER_SHOW(flag, name) \
 	do { \
-		if (SIER_FLAGS & CCSR_SSI_SIER_##flag) \
+		if (FSLSSI_SISR_MASK & CCSR_SSI_SIER_##flag) \
 			length += sprintf(buf + length, #name "=%u\n", \
 				ssi_private->stats.name); \
 	} while (0)
-- 
1.8.4.2
