From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 25 Feb 2017 20:30:22 +0800
Subject: [PATCH 2/9] ASoC: sun8i-codec-analog: split out linein and mic2
In-Reply-To: <20170225123029.55939-1-icenowy@aosc.xyz>
References: <20170225123029.55939-1-icenowy@aosc.xyz>
Message-ID: <20170225123029.55939-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s SoC features an analog codec without linein and mic2.

Split out them, in order to prepare for the analog codec on V3s.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 sound/soc/sunxi/sun8i-codec-analog.c | 168 +++++++++++++++++++++++++++++------
 1 file changed, 141 insertions(+), 27 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i-codec-analog.c
index 72331332b72e..6c17c99c2c8d 100644
--- a/sound/soc/sunxi/sun8i-codec-analog.c
+++ b/sound/soc/sunxi/sun8i-codec-analog.c
@@ -252,24 +252,15 @@ static const DECLARE_TLV_DB_RANGE(sun8i_codec_mic_gain_scale,
 );
 
 static const struct snd_kcontrol_new sun8i_codec_common_controls[] = {
-	/* Mixer pre-gains */
-	SOC_SINGLE_TLV("Line In Playback Volume", SUN8I_ADDA_LINEIN_GCTRL,
-		       SUN8I_ADDA_LINEIN_GCTRL_LINEING,
-		       0x7, 0, sun8i_codec_out_mixer_pregain_scale),
+	/* Mixer pre-gain */
 	SOC_SINGLE_TLV("Mic1 Playback Volume", SUN8I_ADDA_MICIN_GCTRL,
 		       SUN8I_ADDA_MICIN_GCTRL_MIC1G,
 		       0x7, 0, sun8i_codec_out_mixer_pregain_scale),
-	SOC_SINGLE_TLV("Mic2 Playback Volume",
-		       SUN8I_ADDA_MICIN_GCTRL, SUN8I_ADDA_MICIN_GCTRL_MIC2G,
-		       0x7, 0, sun8i_codec_out_mixer_pregain_scale),
 
-	/* Microphone Amp boost gains */
+	/* Microphone Amp boost gain */
 	SOC_SINGLE_TLV("Mic1 Boost Volume", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
 		       SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MIC1BOOST, 0x7, 0,
 		       sun8i_codec_mic_gain_scale),
-	SOC_SINGLE_TLV("Mic2 Boost Volume", SUN8I_ADDA_MIC2G_CTRL,
-		       SUN8I_ADDA_MIC2G_CTRL_MIC2BOOST, 0x7, 0,
-		       sun8i_codec_mic_gain_scale),
 
 	/* ADC */
 	SOC_SINGLE_TLV("ADC Gain Capture Volume", SUN8I_ADDA_ADC_AP_EN,
@@ -295,12 +286,8 @@ static const struct snd_soc_dapm_widget sun8i_codec_common_widgets[] = {
 	 * stream widgets at the card level.
 	 */
 
-	/* Line In */
-	SND_SOC_DAPM_INPUT("LINEIN"),
-
-	/* Microphone inputs */
+	/* Microphone input */
 	SND_SOC_DAPM_INPUT("MIC1"),
-	SND_SOC_DAPM_INPUT("MIC2"),
 
 	/* Microphone Bias */
 	SND_SOC_DAPM_SUPPLY("MBIAS", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
@@ -310,8 +297,6 @@ static const struct snd_soc_dapm_widget sun8i_codec_common_widgets[] = {
 	/* Mic input path */
 	SND_SOC_DAPM_PGA("Mic1 Amplifier", SUN8I_ADDA_MIC1G_MICBIAS_CTRL,
 			 SUN8I_ADDA_MIC1G_MICBIAS_CTRL_MIC1AMPEN, 0, NULL, 0),
-	SND_SOC_DAPM_PGA("Mic2 Amplifier", SUN8I_ADDA_MIC2G_CTRL,
-			 SUN8I_ADDA_MIC2G_CTRL_MIC2AMPEN, 0, NULL, 0),
 
 	/* Mixers */
 	SND_SOC_DAPM_MIXER("Left Mixer", SUN8I_ADDA_DAC_PA_SRC,
@@ -335,35 +320,26 @@ static const struct snd_soc_dapm_widget sun8i_codec_common_widgets[] = {
 static const struct snd_soc_dapm_route sun8i_codec_common_routes[] = {
 	/* Microphone Routes */
 	{ "Mic1 Amplifier", NULL, "MIC1"},
-	{ "Mic2 Amplifier", NULL, "MIC2"},
 
 	/* Left Mixer Routes */
 	{ "Left Mixer", "DAC Playback Switch", "Left DAC" },
 	{ "Left Mixer", "DAC Reversed Playback Switch", "Right DAC" },
-	{ "Left Mixer", "Line In Playback Switch", "LINEIN" },
 	{ "Left Mixer", "Mic1 Playback Switch", "Mic1 Amplifier" },
-	{ "Left Mixer", "Mic2 Playback Switch", "Mic2 Amplifier" },
 
 	/* Right Mixer Routes */
 	{ "Right Mixer", "DAC Playback Switch", "Right DAC" },
 	{ "Right Mixer", "DAC Reversed Playback Switch", "Left DAC" },
-	{ "Right Mixer", "Line In Playback Switch", "LINEIN" },
 	{ "Right Mixer", "Mic1 Playback Switch", "Mic1 Amplifier" },
-	{ "Right Mixer", "Mic2 Playback Switch", "Mic2 Amplifier" },
 
 	/* Left ADC Mixer Routes */
 	{ "Left ADC Mixer", "Mixer Capture Switch", "Left Mixer" },
 	{ "Left ADC Mixer", "Mixer Reversed Capture Switch", "Right Mixer" },
-	{ "Left ADC Mixer", "Line In Capture Switch", "LINEIN" },
 	{ "Left ADC Mixer", "Mic1 Capture Switch", "Mic1 Amplifier" },
-	{ "Left ADC Mixer", "Mic2 Capture Switch", "Mic2 Amplifier" },
 
 	/* Right ADC Mixer Routes */
 	{ "Right ADC Mixer", "Mixer Capture Switch", "Right Mixer" },
 	{ "Right ADC Mixer", "Mixer Reversed Capture Switch", "Left Mixer" },
-	{ "Right ADC Mixer", "Line In Capture Switch", "LINEIN" },
 	{ "Right ADC Mixer", "Mic1 Capture Switch", "Mic1 Amplifier" },
-	{ "Right ADC Mixer", "Mic2 Capture Switch", "Mic2 Amplifier" },
 
 	/* ADC Routes */
 	{ "Left ADC", NULL, "Left ADC Mixer" },
@@ -498,6 +474,61 @@ static int sun8i_codec_add_hmic(struct snd_soc_component *cmpnt)
 	return ret;
 }
 
+/* line in specific controls, widgets and rines */
+static const struct snd_kcontrol_new sun8i_codec_linein_controls[] = {
+	/* Mixer pre-gain */
+	SOC_SINGLE_TLV("Line In Playback Volume", SUN8I_ADDA_LINEIN_GCTRL,
+		       SUN8I_ADDA_LINEIN_GCTRL_LINEING,
+		       0x7, 0, sun8i_codec_out_mixer_pregain_scale),
+};
+
+static const struct snd_soc_dapm_widget sun8i_codec_linein_widgets[] = {
+	/* Line input */
+	SND_SOC_DAPM_INPUT("LINEIN"),
+};
+
+static const struct snd_soc_dapm_route sun8i_codec_linein_routes[] = {
+	{ "Left Mixer", "Line In Playback Switch", "LINEIN" },
+
+	{ "Right Mixer", "Line In Playback Switch", "LINEIN" },
+
+	{ "Left ADC Mixer", "Line In Capture Switch", "LINEIN" },
+
+	{ "Right ADC Mixer", "Line In Capture Switch", "LINEIN" },
+};
+
+static int sun8i_codec_add_linein(struct snd_soc_component *cmpnt)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(cmpnt);
+	struct device *dev = cmpnt->dev;
+	int ret;
+
+	ret = snd_soc_add_component_controls(cmpnt,
+					     sun8i_codec_linein_controls,
+					     ARRAY_SIZE(sun8i_codec_linein_controls));
+	if (ret) {
+		dev_err(dev, "Failed to add Line In controls: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dapm_new_controls(dapm, sun8i_codec_linein_widgets,
+					ARRAY_SIZE(sun8i_codec_linein_widgets));
+	if (ret) {
+		dev_err(dev, "Failed to add Line In DAPM widgets: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dapm_add_routes(dapm, sun8i_codec_linein_routes,
+				      ARRAY_SIZE(sun8i_codec_linein_routes));
+	if (ret) {
+		dev_err(dev, "Failed to add Line In DAPM routes: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+
 /* line out specific controls, widgets and routes */
 static const DECLARE_TLV_DB_RANGE(sun8i_codec_lineout_vol_scale,
 	0, 1, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
@@ -578,19 +609,90 @@ static int sun8i_codec_add_lineout(struct snd_soc_component *cmpnt)
 	return 0;
 }
 
+/* mic2 specific controls, widgets and routes */
+static const struct snd_kcontrol_new sun8i_codec_mic2_controls[] = {
+	/* Mixer pre-gain */
+	SOC_SINGLE_TLV("Mic2 Playback Volume",
+		       SUN8I_ADDA_MICIN_GCTRL, SUN8I_ADDA_MICIN_GCTRL_MIC2G,
+		       0x7, 0, sun8i_codec_out_mixer_pregain_scale),
+
+	/* Microphone Amp boost gain */
+	SOC_SINGLE_TLV("Mic2 Boost Volume", SUN8I_ADDA_MIC2G_CTRL,
+		       SUN8I_ADDA_MIC2G_CTRL_MIC2BOOST, 0x7, 0,
+		       sun8i_codec_mic_gain_scale),
+};
+
+static const struct snd_soc_dapm_widget sun8i_codec_mic2_widgets[] = {
+	/* Microphone input */
+	SND_SOC_DAPM_INPUT("MIC2"),
+
+	/* Mic input path */
+	SND_SOC_DAPM_PGA("Mic2 Amplifier", SUN8I_ADDA_MIC2G_CTRL,
+			 SUN8I_ADDA_MIC2G_CTRL_MIC2AMPEN, 0, NULL, 0),
+};
+
+static const struct snd_soc_dapm_route sun8i_codec_mic2_routes[] = {
+	{ "Mic2 Amplifier", NULL, "MIC2"},
+
+	{ "Left Mixer", "Mic2 Playback Switch", "Mic2 Amplifier" },
+
+	{ "Right Mixer", "Mic2 Playback Switch", "Mic2 Amplifier" },
+
+	{ "Left ADC Mixer", "Mic2 Capture Switch", "Mic2 Amplifier" },
+
+	{ "Right ADC Mixer", "Mic2 Capture Switch", "Mic2 Amplifier" },
+};
+
+static int sun8i_codec_add_mic2(struct snd_soc_component *cmpnt)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(cmpnt);
+	struct device *dev = cmpnt->dev;
+	int ret;
+
+	ret = snd_soc_add_component_controls(cmpnt,
+					     sun8i_codec_mic2_controls,
+					     ARRAY_SIZE(sun8i_codec_mic2_controls));
+	if (ret) {
+		dev_err(dev, "Failed to add MIC2 controls: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dapm_new_controls(dapm, sun8i_codec_mic2_widgets,
+					ARRAY_SIZE(sun8i_codec_mic2_widgets));
+	if (ret) {
+		dev_err(dev, "Failed to add MIC2 DAPM widgets: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dapm_add_routes(dapm, sun8i_codec_mic2_routes,
+				      ARRAY_SIZE(sun8i_codec_mic2_routes));
+	if (ret) {
+		dev_err(dev, "Failed to add MIC2 DAPM routes: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 struct sun8i_codec_analog_quirks {
 	bool has_headphone;
 	bool has_hmic;
+	bool has_linein;
 	bool has_lineout;
+	bool has_mic2;
 };
 
 static const struct sun8i_codec_analog_quirks sun8i_a23_quirks = {
 	.has_headphone	= true,
 	.has_hmic	= true,
+	.has_linein	= true,
+	.has_mic2	= true,
 };
 
 static const struct sun8i_codec_analog_quirks sun8i_h3_quirks = {
+	.has_linein	= true,
 	.has_lineout	= true,
+	.has_mic2	= true,
 };
 
 static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
@@ -620,12 +722,24 @@ static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
 			return ret;
 	}
 
+	if (quirks->has_linein) {
+		ret = sun8i_codec_add_linein(cmpnt);
+		if (ret)
+			return ret;
+	}
+
 	if (quirks->has_lineout) {
 		ret = sun8i_codec_add_lineout(cmpnt);
 		if (ret)
 			return ret;
 	}
 
+	if (quirks->has_mic2) {
+		ret = sun8i_codec_add_mic2(cmpnt);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.11.1
