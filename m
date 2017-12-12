From: andrea.bondavalli74@gmail.com (Andrea Bondavalli)
Date: Tue, 12 Dec 2017 10:14:50 +0100
Subject: [PATCH] ASoC: sun4i-codec: fix to enable 12Khz and 24Khz audio
 playback and capture sample rates
Message-ID: <20171212091450.GA13602@andrea-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H3 ASoC supports 12Khz and 24Khz audio sample rates but the current drivers doesn't advertise these rates properly and they cannot be used.

For example attempt to capture at 12Khz uses 11Khz (same applies to audio playback):
# arecord -f S16_LE -c 2 -r 12000  -D hw:0,0  -t raw /tmp/testS16_LE.raw
Recording raw data '/tmp/testS16_LE.raw' : Signed 16 bit Little Endian, Rate 12000 Hz, Stereo
Warning: rate is not accurate (requested = 12000Hz, got = 11025Hz)

This patch fixes the audio sample rates declared and supported by the driver according to the H3 data sheet.
Specifically for audio playback:
8000, 11050, 12000, 16000, 22050, 24000, 32000, 44100, 48000, 96000, 192000
and for audio capture:
8000, 11050, 12000, 16000, 22050, 24000, 32000, 44100, 48000

Signed-off-by: Andrea Bondavalli <andrea.bondavalli74@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 5da4efe..c79e8a4 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -590,12 +590,28 @@ static int sun4i_codec_hw_params(struct snd_pcm_substream *substream,
 					     hwrate);
 }
 
+
+static unsigned int sun4i_codec_src_rates[] = {
+	8000, 11025, 12000, 16000, 22050, 24000, 32000,
+	44100, 48000, 96000, 192000
+};
+
+
+static struct snd_pcm_hw_constraint_list sun4i_codec_constraints = {
+	.count  = ARRAY_SIZE(sun4i_codec_src_rates),
+	.list   = sun4i_codec_src_rates,
+};
+
+
 static int sun4i_codec_startup(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(rtd->card);
 
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_RATE, &sun4i_codec_constraints);
+
 	/*
 	 * Stop issuing DRQ when we have room for less than 16 samples
 	 * in our TX FIFO
@@ -633,9 +649,7 @@ static struct snd_soc_dai_driver sun4i_codec_dai = {
 		.channels_max	= 2,
 		.rate_min	= 8000,
 		.rate_max	= 192000,
-		.rates		= SNDRV_PCM_RATE_8000_48000 |
-				  SNDRV_PCM_RATE_96000 |
-				  SNDRV_PCM_RATE_192000,
+		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE |
 				  SNDRV_PCM_FMTBIT_S32_LE,
 		.sig_bits	= 24,
@@ -645,11 +659,8 @@ static struct snd_soc_dai_driver sun4i_codec_dai = {
 		.channels_min	= 1,
 		.channels_max	= 2,
 		.rate_min	= 8000,
-		.rate_max	= 192000,
-		.rates		= SNDRV_PCM_RATE_8000_48000 |
-				  SNDRV_PCM_RATE_96000 |
-				  SNDRV_PCM_RATE_192000 |
-				  SNDRV_PCM_RATE_KNOT,
+		.rate_max	= 48000,
+		.rates		= SNDRV_PCM_RATE_CONTINUOUS,
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE |
 				  SNDRV_PCM_FMTBIT_S32_LE,
 		.sig_bits	= 24,
@@ -1128,7 +1139,7 @@ static const struct snd_soc_component_driver sun4i_codec_component = {
 	.name = "sun4i-codec",
 };
 
-#define SUN4I_CODEC_RATES	SNDRV_PCM_RATE_8000_192000
+#define SUN4I_CODEC_RATES	SNDRV_PCM_RATE_CONTINUOUS
 #define SUN4I_CODEC_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
 				 SNDRV_PCM_FMTBIT_S32_LE)
 
-- 
2.7.4
