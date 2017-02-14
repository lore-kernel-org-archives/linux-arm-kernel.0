From: flatmax@flatmax.org (Matt Flax)
Date: Wed, 15 Feb 2017 07:52:59 +1100
Subject: [PATCH v3] ASoC: bcm2835: Add 8 channel (multitrack) capability
In-Reply-To: <1486942035-24038-1-git-send-email-flatmax@flatmax.org>
References: <1486942035-24038-1-git-send-email-flatmax@flatmax.org>
Message-ID: <1487105579-3728-1-git-send-email-flatmax@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds multitrack capability if in DSP mode A and the
codec is master.

In bcm2835_i2s_startup, snd_pcm_hw_constraint_minmax is used to set
max channels to 8 if both SND_SOC_DAIFMT_CBM_CFM and
SND_SOC_DAIFMT_DSP_A are set. Otherwise, max channels is set to 2.
Min channels is always set to 2. These settings are accomplished
using the SNDRV_PCM_HW_PARAM_CHANNELS variable.

In bcm2835_i2s_shutdown max channels is set to 2 by default.

In bcm2835_i2s_hw_params, DSP mode A format is now an option.
Before replicating the format variable (from ch2 to ch1) for
register loading, requested channels are checked to be either 2 or 8.
This can be expaneded later to accomodate other channel counts if
supported by the sound card hardware.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 6ba2049..300516d 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -296,6 +296,7 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	switch (dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_DSP_A:
 		data_delay = 1;
 		break;
 	default:
@@ -312,6 +313,7 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_channels(params)) {
 	case 2:
+	case 8:
 		format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
 		format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
 		format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
@@ -526,7 +528,16 @@ static int bcm2835_i2s_startup(struct snd_pcm_substream *substream,
 	regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
 			BCM2835_I2S_STBY, BCM2835_I2S_STBY);
 
-	return 0;
+	/* Set the max channels to 8 if the codec is master and
+	 * we are in DSP A mode. Otherwise only allow 2 channels.
+	 */
+	if (dev->fmt &
+		(SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_DSP_A))
+		return snd_pcm_hw_constraint_single(substream->runtime,
+			SNDRV_PCM_HW_PARAM_CHANNELS, 8);
+	else
+		return snd_pcm_hw_constraint_single(substream->runtime,
+			SNDRV_PCM_HW_PARAM_CHANNELS, 2);
 }
 
 static void bcm2835_i2s_shutdown(struct snd_pcm_substream *substream,
@@ -549,6 +560,10 @@ static void bcm2835_i2s_shutdown(struct snd_pcm_substream *substream,
 	 * not stop the clock when SND_SOC_DAIFMT_CONT
 	 */
 	bcm2835_i2s_stop_clock(dev);
+
+	/* Default to 2 channels */
+	snd_pcm_hw_constraint_single(substream->runtime,
+			SNDRV_PCM_HW_PARAM_CHANNELS, 2);
 }
 
 static const struct snd_soc_dai_ops bcm2835_i2s_dai_ops = {
@@ -576,16 +591,12 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
 	.name	= "bcm2835-i2s",
 	.probe	= bcm2835_i2s_dai_probe,
 	.playback = {
-		.channels_min = 2,
-		.channels_max = 2,
 		.rates =	SNDRV_PCM_RATE_8000_192000,
 		.formats =	SNDRV_PCM_FMTBIT_S16_LE
 				| SNDRV_PCM_FMTBIT_S24_LE
 				| SNDRV_PCM_FMTBIT_S32_LE
 		},
 	.capture = {
-		.channels_min = 2,
-		.channels_max = 2,
 		.rates =	SNDRV_PCM_RATE_8000_192000,
 		.formats =	SNDRV_PCM_FMTBIT_S16_LE
 				| SNDRV_PCM_FMTBIT_S24_LE
-- 
2.7.4
