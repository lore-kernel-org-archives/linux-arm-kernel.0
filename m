From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 30 Jul 2013 11:18:52 +0100
Subject: [PATCH] ALSA: ASoC: uda134x: fix codec driver
Message-ID: <E1V4712-0007sg-Dw@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For some reason, the DAC/ADCs are not being powered up when I try and
use the UDA1341 driver; this used to work.  Looking back in the git
history, I don't see anything obvious which would cause this
regression.

However, from dumping the register writes, it seems that the codec is
powered down, and nothing calls set_bias_level to wake the codec up.

Moreover, this driver hasn't had DAPM support added to it, which
prevents platform drivers from taking advantage of DAPMs facilities.
So, let's add DAPM support to the driver.

As we move the power control for the DAC/ADC into DAPM, we no longer
need it in set_bias_level() - this function just becomes a way to
manipulate the power control and sync the register cache with the
hardware at the appropriate point.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
I noticed this while checking the Assabet audio, which uses the UDA1341.
I've also added the corresponding support to my Assabet audio driver.
If this looks like the correct thing to do to fix this, please apply.

 sound/soc/codecs/uda134x.c |   88 ++++++++++++++++++++++++++-----------------
 1 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 6d0aa44..c94d4c1 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -325,7 +325,6 @@ static int uda134x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 static int uda134x_set_bias_level(struct snd_soc_codec *codec,
 				  enum snd_soc_bias_level level)
 {
-	u8 reg;
 	struct uda134x_platform_data *pd = codec->control_data;
 	int i;
 	u8 *cache = codec->reg_cache;
@@ -334,23 +333,6 @@ static int uda134x_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		/* ADC, DAC on */
-		switch (pd->model) {
-		case UDA134X_UDA1340:
-		case UDA134X_UDA1344:
-		case UDA134X_UDA1345:
-			reg = uda134x_read_reg_cache(codec, UDA134X_DATA011);
-			uda134x_write(codec, UDA134X_DATA011, reg | 0x03);
-			break;
-		case UDA134X_UDA1341:
-			reg = uda134x_read_reg_cache(codec, UDA134X_STATUS1);
-			uda134x_write(codec, UDA134X_STATUS1, reg | 0x03);
-			break;
-		default:
-			printk(KERN_ERR "UDA134X SoC codec: "
-			       "unsupported model %d\n", pd->model);
-			return -EINVAL;
-		}
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		/* power on */
@@ -362,23 +344,6 @@ static int uda134x_set_bias_level(struct snd_soc_codec *codec,
 		}
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		/* ADC, DAC power off */
-		switch (pd->model) {
-		case UDA134X_UDA1340:
-		case UDA134X_UDA1344:
-		case UDA134X_UDA1345:
-			reg = uda134x_read_reg_cache(codec, UDA134X_DATA011);
-			uda134x_write(codec, UDA134X_DATA011, reg & ~(0x03));
-			break;
-		case UDA134X_UDA1341:
-			reg = uda134x_read_reg_cache(codec, UDA134X_STATUS1);
-			uda134x_write(codec, UDA134X_STATUS1, reg & ~(0x03));
-			break;
-		default:
-			printk(KERN_ERR "UDA134X SoC codec: "
-			       "unsupported model %d\n", pd->model);
-			return -EINVAL;
-		}
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* power off */
@@ -450,6 +415,37 @@ SOC_ENUM("PCM Playback De-emphasis", uda134x_mixer_enum[1]),
 SOC_SINGLE("DC Filter Enable Switch", UDA134X_STATUS0, 0, 1, 0),
 };
 
+/* UDA1341 has the DAC/ADC power down in STATUS1 */
+static const struct snd_soc_dapm_widget uda1341_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC", "Playback", UDA134X_STATUS1, 0, 0),
+	SND_SOC_DAPM_ADC("ADC", "Capture", UDA134X_STATUS1, 1, 0),
+};
+
+/* UDA1340/4/5 has the DAC/ADC pwoer down in DATA0 11 */
+static const struct snd_soc_dapm_widget uda1340_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("DAC", "Playback", UDA134X_DATA011, 0, 0),
+	SND_SOC_DAPM_ADC("ADC", "Capture", UDA134X_DATA011, 1, 0),
+};
+
+/* Common DAPM widgets */
+static const struct snd_soc_dapm_widget uda134x_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("VINL1"),
+	SND_SOC_DAPM_INPUT("VINR1"),
+	SND_SOC_DAPM_INPUT("VINL2"),
+	SND_SOC_DAPM_INPUT("VINR2"),
+	SND_SOC_DAPM_OUTPUT("VOUTL"),
+	SND_SOC_DAPM_OUTPUT("VOUTR"),
+};
+
+static const struct snd_soc_dapm_route uda134x_dapm_routes[] = {
+	{ "ADC", NULL, "VINL1" },
+	{ "ADC", NULL, "VINR1" },
+	{ "ADC", NULL, "VINL2" },
+	{ "ADC", NULL, "VINR2" },
+	{ "VOUTL", NULL, "DAC" },
+	{ "VOUTR", NULL, "DAC" },
+};
+
 static const struct snd_soc_dai_ops uda134x_dai_ops = {
 	.startup	= uda134x_startup,
 	.shutdown	= uda134x_shutdown,
@@ -485,6 +481,8 @@ static int uda134x_soc_probe(struct snd_soc_codec *codec)
 {
 	struct uda134x_priv *uda134x;
 	struct uda134x_platform_data *pd = codec->card->dev->platform_data;
+	const struct snd_soc_dapm_widget *widgets;
+	unsigned num_widgets;
 
 	int ret;
 
@@ -526,6 +524,22 @@ static int uda134x_soc_probe(struct snd_soc_codec *codec)
 	else
 		uda134x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
+	if (pd->model == UDA134X_UDA1341) {
+		widgets = uda1341_dapm_widgets;
+		num_widgets = ARRAY_SIZE(uda1341_dapm_widgets);
+	} else {
+		widgets = uda1340_dapm_widgets;
+		num_widgets = ARRAY_SIZE(uda1340_dapm_widgets);
+	}
+
+	ret = snd_soc_dapm_new_controls(&codec->dapm, widgets, num_widgets);
+	if (ret) {
+		printk(KERN_ERR "%s failed to register dapm controls: %d",
+			__func__, ret);
+		kfree(uda134x);
+		return ret;
+	}
+
 	switch (pd->model) {
 	case UDA134X_UDA1340:
 	case UDA134X_UDA1344:
@@ -599,6 +613,10 @@ static struct snd_soc_codec_driver soc_codec_dev_uda134x = {
 	.read = uda134x_read_reg_cache,
 	.write = uda134x_write,
 	.set_bias_level = uda134x_set_bias_level,
+	.dapm_widgets = uda134x_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(uda134x_dapm_widgets),
+	.dapm_routes = uda134x_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(uda134x_dapm_routes),
 };
 
 static int uda134x_codec_probe(struct platform_device *pdev)
-- 
1.7.4.4
