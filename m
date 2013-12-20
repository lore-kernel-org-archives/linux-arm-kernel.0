From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 20 Dec 2013 14:11:35 +0100
Subject: [PATCH v4 8/9] ASoC: fsl-ssi: Drop ac97 specific trigger function
In-Reply-To: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1387545096-2334-9-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The normal trigger function can now be used for AC97. Drop AC97 trigger
function.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 61 +++++++------------------------------------------
 1 file changed, 8 insertions(+), 53 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c25f593..e40bce1 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1052,6 +1052,7 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
+	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 	unsigned long flags;
 
 	switch (cmd) {
@@ -1082,6 +1083,12 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		return -EINVAL;
 	}
 
+	if (ssi_private->imx_ac97) {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			write_ssi(CCSR_SSI_SOR_TX_CLR, &ssi->sor);
+		else
+			write_ssi(CCSR_SSI_SOR_RX_CLR, &ssi->sor);
+	}
 
 	return 0;
 }
@@ -1129,58 +1136,6 @@ static const struct snd_soc_component_driver fsl_ssi_component = {
 	.name		= "fsl-ssi",
 };
 
-/**
- * fsl_ssi_ac97_trigger: start and stop the AC97 receive/transmit.
- *
- * This function is called by ALSA to start, stop, pause, and resume the
- * transfer of data.
- */
-static int fsl_ssi_ac97_trigger(struct snd_pcm_substream *substream, int cmd,
-			   struct snd_soc_dai *dai)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(
-			rtd->cpu_dai);
-	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			write_ssi_mask(&ssi->sier, 0, CCSR_SSI_SIER_TIE |
-					CCSR_SSI_SIER_TFE0_EN);
-		else
-			write_ssi_mask(&ssi->sier, 0, CCSR_SSI_SIER_RIE |
-					CCSR_SSI_SIER_RFF0_EN);
-		break;
-
-	case SNDRV_PCM_TRIGGER_STOP:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			write_ssi_mask(&ssi->sier, CCSR_SSI_SIER_TIE |
-					CCSR_SSI_SIER_TFE0_EN, 0);
-		else
-			write_ssi_mask(&ssi->sier, CCSR_SSI_SIER_RIE |
-					CCSR_SSI_SIER_RFF0_EN, 0);
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		write_ssi(CCSR_SSI_SOR_TX_CLR, &ssi->sor);
-	else
-		write_ssi(CCSR_SSI_SOR_RX_CLR, &ssi->sor);
-
-	return 0;
-}
-
-static const struct snd_soc_dai_ops fsl_ssi_ac97_dai_ops = {
-	.startup	= fsl_ssi_startup,
-	.trigger	= fsl_ssi_ac97_trigger,
-};
-
 static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 	.ac97_control = 1,
 	.playback = {
@@ -1197,7 +1152,7 @@ static struct snd_soc_dai_driver fsl_ssi_ac97_dai = {
 		.rates = SNDRV_PCM_RATE_48000,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
-	.ops = &fsl_ssi_ac97_dai_ops,
+	.ops = &fsl_ssi_dai_ops,
 };
 
 
-- 
1.8.5.1
