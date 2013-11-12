From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 12 Nov 2013 12:17:36 +0100
Subject: [PATCH] ASoC: fsl-ssi: fix SDMA starvation
Message-ID: <1384255056-25673-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Juergen Beisert <jbe@pengutronix.de>

In cases when capturing is already running and someone enables also
playback, the SDMA unit of the i.MX SoC does not see an edge on its TX DMA
request line. This is due to the TX FIFOs are empty, and this request line is
active all the time, when the CCSR_SSI_SIER_TDMAE bit is set.
In this case also the TX FIFO underrun interrupt will flood the system forever.

To ensure the first edge happens after enabling the TX side of the SSI unit and
to trigger the SDMA unit successfully enable the CCSR_SSI_SIER_TDMAE on
demand only. To be sure, this patch does the same for the CCSR_SSI_SIER_RDMAE
(RX side) bit.

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
Cc: stable at vger.kernel.org
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
Hi,

The patch is based on Mark's "fix/fsl" branch.

Regards,

Markus Pargmann


 sound/soc/fsl/fsl_ssi.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 6b81d0c..8c94632 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -107,10 +107,9 @@ static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
 #endif
 
 /* SIER bitflag of interrupts to enable */
-#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TDMAE | \
-		    CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TUE0_EN | \
-		    CCSR_SSI_SIER_TUE1_EN | CCSR_SSI_SIER_RFRC_EN | \
-		    CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE | \
+#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TIE | \
+		    CCSR_SSI_SIER_TUE0_EN | CCSR_SSI_SIER_TUE1_EN | \
+		    CCSR_SSI_SIER_RFRC_EN | CCSR_SSI_SIER_RIE | \
 		    CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN)
 
 /**
@@ -548,6 +547,9 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
  *
  * The DMA channel is in external master start and pause mode, which
  * means the SSI completely controls the flow of data.
+ *
+ * To use the i.MX's SDMA unit it is important to create an edge on the
+ * corresponding request line. Otherwise the request will be ignored!
  */
 static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 			   struct snd_soc_dai *dai)
@@ -580,20 +582,26 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			write_ssi_mask(&ssi->scr, 0,
 				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_TE);
-		else
+			write_ssi_mask(&ssi->sier, 0, CCSR_SSI_SIER_TDMAE);
+		} else {
 			write_ssi_mask(&ssi->scr, 0,
 				CCSR_SSI_SCR_SSIEN | CCSR_SSI_SCR_RE);
+			write_ssi_mask(&ssi->sier, 0, CCSR_SSI_SIER_RDMAE);
+		}
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TE, 0);
-		else
+			write_ssi_mask(&ssi->sier, CCSR_SSI_SIER_TDMAE, 0);
+		} else {
 			write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_RE, 0);
+			write_ssi_mask(&ssi->sier, CCSR_SSI_SIER_RDMAE, 0);
+		}
 
 		if (!ssi_private->imx_ac97 && (read_ssi(&ssi->scr) &
 					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0)
-- 
1.8.4.2
