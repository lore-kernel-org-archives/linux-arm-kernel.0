From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 4 Jul 2011 10:27:51 -0700
Subject: [PATCH] ASoC: Manage WM8731 ACTIVE bit as a supply widget
Message-ID: <mailman.3.1309800555.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we have supply widgets there's no need to open code the handling of
the ACTIVE bit.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8731.c |   29 +++--------------------------
 1 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 2dc964b..59d9e59 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -175,6 +175,7 @@ static const struct snd_kcontrol_new wm8731_input_mux_controls =
 SOC_DAPM_ENUM("Input Select", wm8731_insel_enum);
 
 static const struct snd_soc_dapm_widget wm8731_dapm_widgets[] = {
+SND_SOC_DAPM_SUPPLY("Active",WM8731_ACTIVE, 0, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("OSC", WM8731_PWR, 5, 1, NULL, 0),
 SND_SOC_DAPM_MIXER("Output Mixer", WM8731_PWR, 4, 1,
 	&wm8731_output_mixer_controls[0],
@@ -204,6 +205,8 @@ static int wm8731_check_osc(struct snd_soc_dapm_widget *source,
 static const struct snd_soc_dapm_route wm8731_intercon[] = {
 	{"DAC", NULL, "OSC", wm8731_check_osc},
 	{"ADC", NULL, "OSC", wm8731_check_osc},
+	{"DAC", NULL, "ACTIVE"},
+	{"ADC", NULL, "ACTIVE"},
 
 	/* output mixer */
 	{"Output Mixer", "Line Bypass Switch", "Line Input"},
@@ -315,29 +318,6 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int wm8731_pcm_prepare(struct snd_pcm_substream *substream,
-			      struct snd_soc_dai *dai)
-{
-	struct snd_soc_codec *codec = dai->codec;
-
-	/* set active */
-	snd_soc_write(codec, WM8731_ACTIVE, 0x0001);
-
-	return 0;
-}
-
-static void wm8731_shutdown(struct snd_pcm_substream *substream,
-			    struct snd_soc_dai *dai)
-{
-	struct snd_soc_codec *codec = dai->codec;
-
-	/* deactivate */
-	if (!codec->active) {
-		udelay(50);
-		snd_soc_write(codec, WM8731_ACTIVE, 0x0);
-	}
-}
-
 static int wm8731_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
@@ -480,7 +460,6 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 		snd_soc_write(codec, WM8731_PWR, reg | 0x0040);
 		break;
 	case SND_SOC_BIAS_OFF:
-		snd_soc_write(codec, WM8731_ACTIVE, 0x0);
 		snd_soc_write(codec, WM8731_PWR, 0xffff);
 		regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies),
 				       wm8731->supplies);
@@ -496,9 +475,7 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
 	SNDRV_PCM_FMTBIT_S24_LE)
 
 static struct snd_soc_dai_ops wm8731_dai_ops = {
-	.prepare	= wm8731_pcm_prepare,
 	.hw_params	= wm8731_hw_params,
-	.shutdown	= wm8731_shutdown,
 	.digital_mute	= wm8731_mute,
 	.set_sysclk	= wm8731_set_dai_sysclk,
 	.set_fmt	= wm8731_set_dai_fmt,
-- 
1.7.5.4
