From: flatmax@flatmax.org (Matt Flax)
Date: Sat, 25 Feb 2017 16:03:14 +1100
Subject: [PATCH 3/3] ASoC: bcm2835: Add mutichannel mode in DSP and IC master
 modes.
In-Reply-To: <cover.1487997974.git.flatmax@flatmax.org>
References: <cover.1487997974.git.flatmax@flatmax.org>
Message-ID: <32f49c14cda226c5011f30522ff376e604496f1d.1487997974.git.flatmax@flatmax.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds multitrack capability if in DSP mode A and an IC
(between the SoC and codec) is master.

In bcm2835_i2s_startup, snd_pcm_hw_constraint_single is used to set
channels to 8 if both SND_SOC_DAIFMT_IBM_IFM and SND_SOC_DAIFMT_DSP_A
are set. Otherwise, channels are set to 2. These settings are
accomplished using the SNDRV_PCM_HW_PARAM_CHANNELS variable.

This patch protects against DSP mode misuse by failing if either the
SoC or Codec is master. i.e. if SND_SOC_DAIFMT_DSP_A is chosen but not
in SND_SOC_DAIFMT_IBM_IFM mode, then -EINVAL is returned.

In bcm2835_i2s_shutdown the channels are set to 2 by default.

In bcm2835_i2s_hw_params, DSP mode A format is now an option.
Before replicating the format variable (from ch2 to ch1) for
register loading, requested channels are checked to be either 2 or 8.
This can be expanded later to accomodate other channel counts if
supported by the sound card hardware.

It has been tested to work with both a regular stereo sound card and
an 8 channel sound card.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 6ba2049..dbfecb3 100644
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
@@ -526,7 +528,20 @@ static int bcm2835_i2s_startup(struct snd_pcm_substream *substream,
 	regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
 			BCM2835_I2S_STBY, BCM2835_I2S_STBY);
 
-	return 0;
+	/* Only allow 2 channels, unless in DSP mode where an IC (between 
+	 * the SoC and codec) is master.
+	 */
+	if ((dev->fmt & SND_SOC_DAIFMT_FORMAT_MASK)
+					== SND_SOC_DAIFMT_DSP_A)
+		if ((dev->fmt & SND_SOC_DAIFMT_MASTER_MASK)
+					!= SND_SOC_DAIFMT_IBM_IFM)
+			return -EINVAL;
+		else
+			return snd_pcm_hw_constraint_single(substream->runtime,
+						SNDRV_PCM_HW_PARAM_CHANNELS, 8);
+	else
+		return snd_pcm_hw_constraint_single(substream->runtime,
+			SNDRV_PCM_HW_PARAM_CHANNELS, 2);
 }
 
 static void bcm2835_i2s_shutdown(struct snd_pcm_substream *substream,
@@ -549,6 +564,10 @@ static void bcm2835_i2s_shutdown(struct snd_pcm_substream *substream,
 	 * not stop the clock when SND_SOC_DAIFMT_CONT
 	 */
 	bcm2835_i2s_stop_clock(dev);
+
+	/* Default to 2 channels */
+	snd_pcm_hw_constraint_single(substream->runtime,
+			SNDRV_PCM_HW_PARAM_CHANNELS, 2);
 }
 
 static const struct snd_soc_dai_ops bcm2835_i2s_dai_ops = {
-- 
2.7.4
