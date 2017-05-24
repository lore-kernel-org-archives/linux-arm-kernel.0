From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 24 May 2017 18:05:59 +0800
Subject: [PATCH v3 1/9] ASoC: sun8i-codec-analog: split out mbias
In-Reply-To: <20170524100607.29790-1-icenowy@aosc.io>
References: <20170524100607.29790-1-icenowy@aosc.io>
Message-ID: <20170524100607.29790-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.xyz>

Allwinner V3s features an analog codec without MBIAS pin.

Split out this part, in order to prepare for the V3s analog codec.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v3:
- Fixed a missing line in v2.

 sound/soc/sunxi/sun8i-codec-analog.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i-codec-analog.c
index 6c17c99c2c8d..edcc3eb7cd9a 100644
--- a/sound/soc/sunxi/sun8i-codec-analog.c
+++ b/sound/soc/sunxi/sun8i-codec-analog.c
@@ -289,11 +289,6 @@ static const struct snd_soc_dapm_widget sun8i_codec_common_widgets[] = {
 	/* Microphone input */
 	SND_SOC_DAPM_INPUT("MIC1"),
 
-	/* Microphone Bias */
-	SND_SOC_DAPM_SUPPLY("MBIAS", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
-			    SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MMICBIASEN,
-			    0, NULL, 0),
-
 	/* Mic input path */
 	SND_SOC_DAPM_PGA("Mic1 Amplifier", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
 			 SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MIC1AMPEN, 0, NULL, 0),
@@ -453,6 +448,27 @@ static int sun8i_codec_add_headphone(struct snd_soc_component *cmpnt)
 	return 0;
 }
 
+/* mbias specific widget */
+static const struct snd_soc_dapm_widget sun8i_codec_mbias_widgets[] = {
+	SND_SOC_DAPM_SUPPLY("MBIAS", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
+			    SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MMICBIASEN,
+			    0, NULL, 0),
+};
+
+static int sun8i_codec_add_mbias(struct snd_soc_component *cmpnt)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(cmpnt);
+	struct device *dev = cmpnt->dev;
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(dapm, sun8i_codec_mbias_widgets,
+					ARRAY_SIZE(sun8i_codec_mbias_widgets));
+	if (ret)
+		dev_err(dev, "Failed to add MBIAS DAPM widgets: %d\n", ret);
+
+	return ret;
+}
+
 /* hmic specific widget */
 static const struct snd_soc_dapm_widget sun8i_codec_hmic_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("HBIAS", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
@@ -679,6 +695,7 @@ struct sun8i_codec_analog_quirks {
 	bool has_hmic;
 	bool has_linein;
 	bool has_lineout;
+	bool has_mbias;
 	bool has_mic2;
 };
 
@@ -686,12 +703,14 @@ static const struct sun8i_codec_analog_quirks sun8i_a23_quirks = {
 	.has_headphone	= true,
 	.has_hmic	= true,
 	.has_linein	= true,
+	.has_mbias	= true,
 	.has_mic2	= true,
 };
 
 static const struct sun8i_codec_analog_quirks sun8i_h3_quirks = {
 	.has_linein	= true,
 	.has_lineout	= true,
+	.has_mbias	= true,
 	.has_mic2	= true,
 };
 
@@ -734,6 +753,12 @@ static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
 			return ret;
 	}
 
+	if (quirks->has_mbias) {
+		ret = sun8i_codec_add_mbias(cmpnt);
+		if (ret)
+			return ret;
+	}
+
 	if (quirks->has_mic2) {
 		ret = sun8i_codec_add_mic2(cmpnt);
 		if (ret)
-- 
2.12.2
