From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 25 Nov 2013 12:13:45 +0100
Subject: [PATCH v2 9/9] ASoC: fsl-ssi: Drop AC97 debug register usage
In-Reply-To: <1385378025-1262-1-git-send-email-mpa@pengutronix.de>
References: <1385378025-1262-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1385378025-1262-10-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In i.MX27 reference manual the SOR register is listed for debugging
purpose only. In mx50 and later, this register is not even listed
anymore. We shouldn't use a debug register for normal operation.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index cf55da0..befe1ed 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -620,8 +620,6 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
 	 */
 	write_ssi_mask(&ssi->scr, 0, CCSR_SSI_SCR_SSIEN |
 			CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE);
-
-	write_ssi(CCSR_SSI_SOR_WAIT(3), &ssi->sor);
 }
 
 static int fsl_ssi_setup(struct fsl_ssi_private *ssi_private)
@@ -850,13 +848,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		return -EINVAL;
 	}
 
-	if (ssi_private->imx_ac97) {
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			write_ssi(CCSR_SSI_SOR_TX_CLR, &ssi->sor);
-		else
-			write_ssi(CCSR_SSI_SOR_RX_CLR, &ssi->sor);
-	}
-
 	return 0;
 }
 
-- 
1.8.4.2
