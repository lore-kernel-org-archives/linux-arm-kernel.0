From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 04 Aug 2013 20:33:04 +0100
Subject: [PATCH RFC 12/13] ASoC: kirkwood: add SPDIF output support
In-Reply-To: <20130804192136.GK23006@n2100.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
Message-ID: <E1V6436-0004m4-Kl@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for SPDIF output.  This is enabled via a widget being
connected to an output.  When this widget is not connected, SPDIF
output will remain disabled.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-i2s.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 3d039c3..236b0b2 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -159,7 +159,8 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S16_LE:
 		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_16;
 		ctl_play = KIRKWOOD_PLAYCTL_SIZE_16_C |
-			   KIRKWOOD_PLAYCTL_I2S_EN;
+			   KIRKWOOD_PLAYCTL_I2S_EN |
+			   KIRKWOOD_PLAYCTL_SPDIF_EN;
 		ctl_rec = KIRKWOOD_RECCTL_SIZE_16_C |
 			  KIRKWOOD_RECCTL_I2S_EN;
 		break;
@@ -169,7 +170,8 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S20_3LE:
 		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_20;
 		ctl_play = KIRKWOOD_PLAYCTL_SIZE_20 |
-			   KIRKWOOD_PLAYCTL_I2S_EN;
+			   KIRKWOOD_PLAYCTL_I2S_EN |
+			   KIRKWOOD_PLAYCTL_SPDIF_EN;
 		ctl_rec = KIRKWOOD_RECCTL_SIZE_20 |
 			  KIRKWOOD_RECCTL_I2S_EN;
 		break;
@@ -177,7 +179,8 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S24_LE:
 		i2s_value |= KIRKWOOD_I2S_CTL_SIZE_24;
 		ctl_play = KIRKWOOD_PLAYCTL_SIZE_24 |
-			   KIRKWOOD_PLAYCTL_I2S_EN;
+			   KIRKWOOD_PLAYCTL_I2S_EN |
+			   KIRKWOOD_PLAYCTL_SPDIF_EN;
 		ctl_rec = KIRKWOOD_RECCTL_SIZE_24 |
 			  KIRKWOOD_RECCTL_I2S_EN;
 		break;
@@ -374,11 +377,28 @@ static int kirkwood_i2s_play_i2s(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int kirkwood_i2s_play_spdif(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *ctl, int event)
+{
+	/* This works because the platform and cpu dai are the same dev */
+	struct kirkwood_dma_data *priv = snd_soc_platform_get_drvdata(w->platform);
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		priv->ctl_play_mask |= KIRKWOOD_PLAYCTL_SPDIF_EN;
+	else
+		priv->ctl_play_mask &= ~KIRKWOOD_PLAYCTL_SPDIF_EN;
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget widgets[] = {
 	/* These widget names come from the names from the functional spec */
 	SND_SOC_DAPM_AIF_OUT_E("i2sdo", "dma-tx",
 		0, SND_SOC_NOPM, 0, 0, kirkwood_i2s_play_i2s,
 		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_AIF_OUT_E("spdifdo", "dma-tx",
+		0, SND_SOC_NOPM, 0, 0, kirkwood_i2s_play_spdif,
+		SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 	SND_SOC_DAPM_AIF_IN("i2sdi", "dma-rx",
 		0, SND_SOC_NOPM, 0, 0),
 };
-- 
1.7.4.4
