From: flatmax@flatmax.org (Matt Flax)
Date: Tue,  7 Feb 2017 10:09:36 +1100
Subject: [PATCH] ASoC: bcm2835: Add 8 channel (multitrack) capability
Message-ID: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds 8 channel capability by allowing DSP modes. It
also increases the channels_max (in the bcm2835_i2s_dai structure)
to 8.

The driver guards against multitrack mode when the codec isn't
master. The driver guards against multitrack capability when in
I2S mode.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 6ba2049..022ca13 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -276,11 +276,16 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 		/* otherwise calculate a fitting block ratio */
 		bclk_ratio = 2 * data_length;
 
-	/* Clock should only be set up here if CPU is clock master */
+	/* Clock should only be set up here if CPU is clock master.
+	   If codec isn't master guard against multichannel mode. */
 	switch (dev->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 	case SND_SOC_DAIFMT_CBS_CFM:
 		clk_set_rate(dev->clk, sampling_rate * bclk_ratio);
+	case SND_SOC_DAIFMT_CBM_CFS:
+		/* Codec must be master in multichannel mode */
+		if (params_channels(params) > 2)
+			return -EINVAL;
 		break;
 	default:
 		break;
@@ -294,8 +299,14 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	format |= BCM2835_I2S_CHWID((data_length-8)&0xf);
 
+	/* Default data delay to 1 bit.
+	   In I2S mode, we must have 2 channels */
 	switch (dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
+		if (params_channels(params) != 2)
+			return -EINVAL;
+	case SND_SOC_DAIFMT_DSP_A:
+	case SND_SOC_DAIFMT_DSP_B:
 		data_delay = 1;
 		break;
 	default:
@@ -312,6 +323,7 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_channels(params)) {
 	case 2:
+	case 8:
 		format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
 		format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
 		format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
@@ -577,7 +589,7 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
 	.probe	= bcm2835_i2s_dai_probe,
 	.playback = {
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 8,
 		.rates =	SNDRV_PCM_RATE_8000_192000,
 		.formats =	SNDRV_PCM_FMTBIT_S16_LE
 				| SNDRV_PCM_FMTBIT_S24_LE
@@ -585,7 +597,7 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
 		},
 	.capture = {
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 8,
 		.rates =	SNDRV_PCM_RATE_8000_192000,
 		.formats =	SNDRV_PCM_FMTBIT_S16_LE
 				| SNDRV_PCM_FMTBIT_S24_LE
-- 
2.7.4
