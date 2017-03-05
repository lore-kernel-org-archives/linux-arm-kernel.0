From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun,  5 Mar 2017 21:36:59 +0800
Subject: [PATCH v2 02/12] ASoC: sun8i-codec-analog: split out line in
In-Reply-To: <20170305133709.6288-1-icenowy@aosc.xyz>
References: <20170305133709.6288-1-icenowy@aosc.xyz>
Message-ID: <20170305133709.6288-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s features an analog codec without LINEIN.

Split out this part, in order to prepare for the V3s analog codec.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 sound/soc/sunxi/sun8i-codec-analog.c | 76 ++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec-analog.c b/sound/soc/sunxi/sun8i-codec-analog.c
index b95ff045cd7f..6c17c99c2c8d 100644
--- a/sound/soc/sunxi/sun8i-codec-analog.c
+++ b/sound/soc/sunxi/sun8i-codec-analog.c
@@ -252,10 +252,7 @@ static const DECLARE_TLV_DB_RANGE(sun8i_codec_mic_gain_scale,
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
@@ -289,9 +286,6 @@ static const struct snd_soc_dapm_widget sun8i_codec_common_widgets[] = {
 	 * stream widgets at the card level.
 	 */
 
-	/* Line In */
-	SND_SOC_DAPM_INPUT("LINEIN"),
-
 	/* Microphone input */
 	SND_SOC_DAPM_INPUT("MIC1"),
 
@@ -330,25 +324,21 @@ static const struct snd_soc_dapm_route sun8i_codec_common_routes[] = {
 	/* Left Mixer Routes */
 	{ "Left Mixer", "DAC Playback Switch", "Left DAC" },
 	{ "Left Mixer", "DAC Reversed Playback Switch", "Right DAC" },
-	{ "Left Mixer", "Line In Playback Switch", "LINEIN" },
 	{ "Left Mixer", "Mic1 Playback Switch", "Mic1 Amplifier" },
 
 	/* Right Mixer Routes */
 	{ "Right Mixer", "DAC Playback Switch", "Right DAC" },
 	{ "Right Mixer", "DAC Reversed Playback Switch", "Left DAC" },
-	{ "Right Mixer", "Line In Playback Switch", "LINEIN" },
 	{ "Right Mixer", "Mic1 Playback Switch", "Mic1 Amplifier" },
 
 	/* Left ADC Mixer Routes */
 	{ "Left ADC Mixer", "Mixer Capture Switch", "Left Mixer" },
 	{ "Left ADC Mixer", "Mixer Reversed Capture Switch", "Right Mixer" },
-	{ "Left ADC Mixer", "Line In Capture Switch", "LINEIN" },
 	{ "Left ADC Mixer", "Mic1 Capture Switch", "Mic1 Amplifier" },
 
 	/* Right ADC Mixer Routes */
 	{ "Right ADC Mixer", "Mixer Capture Switch", "Right Mixer" },
 	{ "Right ADC Mixer", "Mixer Reversed Capture Switch", "Left Mixer" },
-	{ "Right ADC Mixer", "Line In Capture Switch", "LINEIN" },
 	{ "Right ADC Mixer", "Mic1 Capture Switch", "Mic1 Amplifier" },
 
 	/* ADC Routes */
@@ -484,6 +474,61 @@ static int sun8i_codec_add_hmic(struct snd_soc_component *cmpnt)
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
@@ -632,6 +677,7 @@ static int sun8i_codec_add_mic2(struct snd_soc_component *cmpnt)
 struct sun8i_codec_analog_quirks {
 	bool has_headphone;
 	bool has_hmic;
+	bool has_linein;
 	bool has_lineout;
 	bool has_mic2;
 };
@@ -639,10 +685,12 @@ struct sun8i_codec_analog_quirks {
 static const struct sun8i_codec_analog_quirks sun8i_a23_quirks = {
 	.has_headphone	= true,
 	.has_hmic	= true,
+	.has_linein	= true,
 	.has_mic2	= true,
 };
 
 static const struct sun8i_codec_analog_quirks sun8i_h3_quirks = {
+	.has_linein	= true,
 	.has_lineout	= true,
 	.has_mic2	= true,
 };
@@ -674,6 +722,12 @@ static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
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
-- 
2.11.1
