From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Tue, 30 Aug 2016 07:44:03 +0200
Subject: [PATCH v9 2/2] Add mixer controls: Line-In, FM-In, Mic 2,
 Capture Source, Differential Line-In.
In-Reply-To: <20160830054403.7878-1-dannym@scratchpost.org>
References: <20160830054403.7878-1-dannym@scratchpost.org>
Message-ID: <20160830054403.7878-3-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note: Mic1 Capture Volume is in a different register on A20 than on A10.
Note: Mic2 Capture Volume is in a different register on A20 than on A10.
---
 sound/soc/sunxi/sun4i-codec.c | 256 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 236 insertions(+), 20 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 30f4ea2..f510e6d 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -59,9 +59,20 @@
 #define SUN4I_CODEC_DAC_ACTL_DACAENR			(31)
 #define SUN4I_CODEC_DAC_ACTL_DACAENL			(30)
 #define SUN4I_CODEC_DAC_ACTL_MIXEN			(29)
+#define SUN4I_CODEC_DAC_ACTL_LNG			(26)
+#define SUN4I_CODEC_DAC_ACTL_FMG			(23)
+#define SUN4I_CODEC_DAC_ACTL_MICG			(20)
+#define SUN4I_CODEC_DAC_ACTL_LLNS			(19)
+#define SUN4I_CODEC_DAC_ACTL_RLNS			(18)
+#define SUN4I_CODEC_DAC_ACTL_LFMS			(17)
+#define SUN4I_CODEC_DAC_ACTL_RFMS			(16)
 #define SUN4I_CODEC_DAC_ACTL_LDACLMIXS			(15)
 #define SUN4I_CODEC_DAC_ACTL_RDACRMIXS			(14)
 #define SUN4I_CODEC_DAC_ACTL_LDACRMIXS			(13)
+#define SUN4I_CODEC_DAC_ACTL_MIC1LS			(12)
+#define SUN4I_CODEC_DAC_ACTL_MIC1RS			(11)
+#define SUN4I_CODEC_DAC_ACTL_MIC2LS			(10)
+#define SUN4I_CODEC_DAC_ACTL_MIC2RS			(9)
 #define SUN4I_CODEC_DAC_ACTL_DACPAS			(8)
 #define SUN4I_CODEC_DAC_ACTL_MIXPAS			(7)
 #define SUN4I_CODEC_DAC_ACTL_PA_MUTE			(6)
@@ -87,8 +98,12 @@
 #define SUN4I_CODEC_ADC_ACTL_PREG1EN			(29)
 #define SUN4I_CODEC_ADC_ACTL_PREG2EN			(28)
 #define SUN4I_CODEC_ADC_ACTL_VMICEN			(27)
-#define SUN4I_CODEC_ADC_ACTL_VADCG			(20)
+#define SUN4I_CODEC_ADC_ACTL_PREG1			(25)
+#define SUN4I_CODEC_ADC_ACTL_PREG2			(23)
+#define SUN4I_CODEC_ADC_ACTL_ADCG			(20)
 #define SUN4I_CODEC_ADC_ACTL_ADCIS			(17)
+#define SUN4I_CODEC_ADC_ACTL_LNRDF			(16)
+#define SUN4I_CODEC_ADC_ACTL_LNPREG			(13)
 #define SUN4I_CODEC_ADC_ACTL_PA_EN			(4)
 #define SUN4I_CODEC_ADC_ACTL_DDE			(3)
 #define SUN4I_CODEC_ADC_DEBUG			(0x2c)
@@ -100,6 +115,9 @@
 #define SUN7I_CODEC_AC_DAC_CAL			(0x38)
 #define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
 
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1      (29)
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2      (26)
+
 struct sun4i_codec {
 	struct device	*dev;
 	struct regmap	*regmap;
@@ -509,23 +527,142 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 			SUN4I_CODEC_DAC_ACTL_PA_MUTE, 1, 0);
 
 static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
+static DECLARE_TLV_DB_SCALE(sun4i_codec_linein_loopback_gain_scale,
+			    -150,
+			    150,
+			    0);
+static DECLARE_TLV_DB_SCALE(sun4i_codec_linein_preamp_gain_scale,
+			    -1200,
+			    300,
+			    0);
+static DECLARE_TLV_DB_SCALE(sun4i_codec_fmin_loopback_gain_scale,
+			    -450,
+			    150,
+			    0);
+static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale,
+			    -450,
+			    150,
+			    0);
+static DECLARE_TLV_DB_RANGE(sun4i_codec_micin_preamp_gain_scale,
+			    0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+			    1, 7, TLV_DB_SCALE_ITEM(3500, 300, 0));
+static DECLARE_TLV_DB_SCALE(sun4i_codec_adc_gain_scale, -450, 150, 0);
+static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
+	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+	1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0)
+);
+
+static const char * const sun4i_codec_capture_source[] = {
+	"Line",
+	"FM",
+	"Mic1",
+	"Mic2",
+	"Mic1,Mic2",
+	"Mic1+Mic2",
+	"Output Mixer",
+	"Line,Mic1",
+};
+static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_capture_source,
+			    SUN4I_CODEC_ADC_ACTL,
+			    SUN4I_CODEC_ADC_ACTL_ADCIS,
+			    sun4i_codec_capture_source);
+
+static const struct snd_kcontrol_new sun4i_codec_capture_source_controls =
+	SOC_DAPM_ENUM("Capture Source", sun4i_codec_enum_capture_source);
+
+static const char * const sun4i_codec_difflinein_capture_source[] = {
+	"Non-Differential",
+	"Differential",
+};
+static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_difflinein_capture_source,
+			    SUN4I_CODEC_ADC_ACTL,
+			    SUN4I_CODEC_ADC_ACTL_ADCIS,
+			    sun4i_codec_difflinein_capture_source);
+
+static const struct snd_kcontrol_new sun4i_codec_difflinein_capture_source_controls =
+	SOC_DAPM_ENUM("Differential Line Capture Switch",
+	sun4i_codec_enum_difflinein_capture_source);
 
 #define SUN4I_COMMON_CODEC_CONTROLS \
-	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,\
-		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,\
-		       sun4i_codec_pa_volume_scale)
+	SOC_SINGLE_TLV("Headphone Playback Volume", SUN4I_CODEC_DAC_ACTL,\
+		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0, \
+		       sun4i_codec_pa_volume_scale), \
+	/* Line, FM, Mic1, Mic2 */ \
+	SOC_SINGLE_TLV("Line Playback Volume", \
+		       SUN4I_CODEC_DAC_ACTL, \
+		       SUN4I_CODEC_DAC_ACTL_LNG, \
+		       1, \
+		       0, \
+		       sun4i_codec_linein_loopback_gain_scale), \
+	SOC_SINGLE_TLV("FM Playback Volume", \
+		       SUN4I_CODEC_DAC_ACTL, \
+		       SUN4I_CODEC_DAC_ACTL_FMG, \
+		       3, \
+		       0, \
+		       sun4i_codec_fmin_loopback_gain_scale), \
+	SOC_SINGLE_TLV("Mic Playback Volume", \
+		       SUN4I_CODEC_DAC_ACTL, \
+		       SUN4I_CODEC_DAC_ACTL_MICG, \
+		       7, \
+		       0, \
+		       sun4i_codec_micin_loopback_gain_scale), \
+	/* ADC */ \
+	SOC_SINGLE_TLV("Capture Volume", \
+		       SUN4I_CODEC_ADC_ACTL, \
+		       SUN4I_CODEC_ADC_ACTL_ADCG, \
+		       4, \
+		       0, \
+		       sun4i_codec_adc_gain_scale), \
+	SOC_SINGLE_TLV("Line Capture Volume", \
+		       SUN4I_CODEC_ADC_ACTL, \
+		       SUN4I_CODEC_ADC_ACTL_LNPREG, \
+		       7, \
+		       0, \
+		       sun4i_codec_linein_preamp_gain_scale)
 
 static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SUN4I_COMMON_CODEC_CONTROLS,
+	SOC_SINGLE_TLV("Mic1 Capture Volume",
+		       SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_PREG1,
+		       3,
+		       0,
+		       sun4i_codec_micin_preamp_gain_scale),
+	SOC_SINGLE_TLV("Mic2 Capture Volume",
+		       SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_PREG2,
+		       3,
+		       0,
+		       sun4i_codec_micin_preamp_gain_scale),
 };
 
 static const struct snd_kcontrol_new sun7i_codec_controls[] = {
 	SUN4I_COMMON_CODEC_CONTROLS,
+	SOC_SINGLE_TLV("Mic1 Capture Volume",
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL,
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1,
+		       7,
+		       0,
+		       sun7i_codec_micin_preamp_gain_scale),
+	SOC_SINGLE_TLV("Mic2 Capture Volume",
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL,
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2,
+		       7,
+		       0,
+		       sun7i_codec_micin_preamp_gain_scale),
 };
 
 static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
+	SOC_DAPM_SINGLE("Left Line Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_LLNS, 1, 0),
+	SOC_DAPM_SINGLE("Left FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_LFMS, 1, 0),
+	SOC_DAPM_SINGLE("Mic1 Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_MIC1LS, 1, 0),
+	SOC_DAPM_SINGLE("Mic2 Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_MIC2LS, 1, 0),
 };
 
 static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
@@ -533,6 +670,14 @@ static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
 			SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
 	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
+	SOC_DAPM_SINGLE("Right Line Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_RLNS, 1, 0),
+	SOC_DAPM_SINGLE("Right FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),
+	SOC_DAPM_SINGLE("Mic1 Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),
+	SOC_DAPM_SINGLE("Mic2 Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_MIC2RS, 1, 0),
 };
 
 static const struct snd_kcontrol_new sun4i_codec_pa_mixer_controls[] = {
@@ -565,6 +710,16 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_DAC("Right DAC", "Codec Playback", SUN4I_CODEC_DAC_ACTL,
 			 SUN4I_CODEC_DAC_ACTL_DACAENR, 0),
 
+	/* MUX */
+	SND_SOC_DAPM_MUX("Left Capture Select", SND_SOC_NOPM, 0, 0,
+			 &sun4i_codec_capture_source_controls),
+	SND_SOC_DAPM_MUX("Right Capture Select", SND_SOC_NOPM, 0, 0,
+			 &sun4i_codec_capture_source_controls),
+	SND_SOC_DAPM_MUX("Differential Line Capture Switch", SND_SOC_NOPM,
+			 0,
+			 0,
+			 &sun4i_codec_difflinein_capture_source_controls),
+
 	/* Mixers */
 	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
 			   sun4i_codec_left_mixer_controls,
@@ -584,6 +739,8 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	/* Mic Pre-Amplifiers */
 	SND_SOC_DAPM_PGA("MIC1 Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
 			 SUN4I_CODEC_ADC_ACTL_PREG1EN, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("MIC2 Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
+			 SUN4I_CODEC_ADC_ACTL_PREG2EN, 0, NULL, 0),
 
 	/* Power Amplifier */
 	SND_SOC_DAPM_MIXER("Power Amplifier", SUN4I_CODEC_ADC_ACTL,
@@ -593,8 +750,15 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Power Amplifier Mute", SND_SOC_NOPM, 0, 0,
 			    &sun4i_codec_pa_mute),
 
+	/* Inputs */
 	SND_SOC_DAPM_INPUT("Mic1"),
+	SND_SOC_DAPM_INPUT("Mic2"),
+	SND_SOC_DAPM_INPUT("Line Right"),
+	SND_SOC_DAPM_INPUT("Line Left"),
+	SND_SOC_DAPM_INPUT("FM Right"),
+	SND_SOC_DAPM_INPUT("FM Left"),
 
+	/* Outputs */
 	SND_SOC_DAPM_OUTPUT("HP Right"),
 	SND_SOC_DAPM_OUTPUT("HP Left"),
 };
@@ -608,14 +772,22 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right ADC", NULL, "ADC" },
 	{ "Right DAC", NULL, "DAC" },
 
+	/* Left Mixer Routes */
+	{ "Left Mixer", NULL, "Mixer Enable" },
+	{ "Left Mixer", "Left DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
+	{ "Left Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
+	{ "Left Mixer", "Left Line Playback Switch", "Line Left" },
+	{ "Left Mixer", "Left FM Playback Switch", "FM Left" },
+
 	/* Right Mixer Routes */
 	{ "Right Mixer", NULL, "Mixer Enable" },
 	{ "Right Mixer", "Left DAC Playback Switch", "Left DAC" },
 	{ "Right Mixer", "Right DAC Playback Switch", "Right DAC" },
-
-	/* Left Mixer Routes */
-	{ "Left Mixer", NULL, "Mixer Enable" },
-	{ "Left Mixer", "Left DAC Playback Switch", "Left DAC" },
+	{ "Right Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
+	{ "Right Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
+	{ "Right Mixer", "Right Line Playback Switch", "Line Right" },
+	{ "Right Mixer", "Right FM Playback Switch", "FM Right" },
 
 	/* Power Amplifier Routes */
 	{ "Power Amplifier", "Mixer Playback Switch", "Left Mixer" },
@@ -633,26 +805,70 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right ADC", NULL, "MIC1 Pre-Amplifier" },
 	{ "MIC1 Pre-Amplifier", NULL, "Mic1"},
 	{ "Mic1", NULL, "VMIC" },
+	/* see also Left Mixer Routes, Right Mixer Routes */
+
+	/* Mic2 Routes */
+	{ "Left ADC", NULL, "MIC2 Pre-Amplifier" },
+	{ "Right ADC", NULL, "MIC2 Pre-Amplifier" },
+	{ "MIC2 Pre-Amplifier", NULL, "Mic2"},
+	{ "Mic2", NULL, "VMIC" },
+	/* see also Left Mixer Routes, Right Mixer Routes */
+
+	/* Line, FM Routes */
+	/* see also Left Mixer Routes, Right Mixer Routes */
+
+	/* LNRDF Routes */
+	{ "Differential Line Capture Switch", "Differential", "Line Left" },
+	{ "Differential Line Capture Switch", "Differential", "Line Right" },
+	/*{ "Differential Line Capture Switch", "Non-Differential", "Line X" }, implicit */
+
+	/* Left ADC Input Routes */
+	{ "Left Capture Select", "Line", "Line Left" },
+	{ "Left Capture Select", "Line", "Differential Line Capture Switch" },
+	{ "Left Capture Select", "FM", "FM Left" },
+	{ "Left Capture Select", "Mic1", "MIC1 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic2", "MIC2 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic1,Mic2", "MIC1 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic1+Mic2", "MIC1 Pre-Amplifier" },
+	{ "Left Capture Select", "Mic1+Mic2", "MIC2 Pre-Amplifier" },
+	{ "Left Capture Select", "Output Mixer", "Left Mixer" },
+	{ "Left Capture Select", "Line,Mic1", "Line Left" },
+	{ "Left Capture Select", "Line,Mic1", "Differential Line Capture Switch" },
+	{ "Left ADC", NULL, "Left Capture Select" },
+
+	/* Right ADC Input Routes */
+	{ "Right Capture Select", "Line", "Line Right" },
+	{ "Right Capture Select", "Line", "Differential Line Capture Switch" },
+	{ "Right Capture Select", "FM", "FM Right" },
+	{ "Right Capture Select", "Mic1", "MIC1 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic2", "MIC2 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic1,Mic2", "MIC2 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic1+Mic2", "MIC2 Pre-Amplifier" },
+	{ "Right Capture Select", "Mic1+Mic2", "MIC1 Pre-Amplifier" },
+	{ "Right Capture Select", "Output Mixer", "Right Mixer" },
+	{ "Right Capture Select", "Line,Mic1", "MIC1 Pre-Amplifier" },
+	{ "Right ADC", NULL, "Right Capture Select" },
 };
 
 static struct snd_soc_codec_driver sun4i_codec_codec = {
 	.component_driver = {
-		.controls		= sun4i_codec_controls,
-		.num_controls		= ARRAY_SIZE(sun4i_codec_controls),
-		.dapm_widgets           = sun4i_codec_codec_dapm_widgets,
-		.num_dapm_widgets       = ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
-		.dapm_routes            = sun4i_codec_codec_dapm_routes,
-		.num_dapm_routes        = ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
+		.controls         = sun4i_codec_controls,
+		.num_controls     = ARRAY_SIZE(sun4i_codec_controls),
+		.dapm_widgets     = sun4i_codec_codec_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
+		.dapm_routes      = sun4i_codec_codec_dapm_routes,
+		.num_dapm_routes  = ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
 	},
 };
+
 static struct snd_soc_codec_driver sun7i_codec_codec = {
 	.component_driver = {
-		.controls               = sun7i_codec_controls,
-		.num_controls           = ARRAY_SIZE(sun7i_codec_controls),
-		.dapm_widgets		= sun4i_codec_codec_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
-		.dapm_routes		= sun4i_codec_codec_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
+		.controls         = sun7i_codec_controls,
+		.num_controls     = ARRAY_SIZE(sun7i_codec_controls),
+		.dapm_widgets     = sun4i_codec_codec_dapm_widgets,
+		.num_dapm_widgets = ARRAY_SIZE(sun4i_codec_codec_dapm_widgets),
+		.dapm_routes      = sun4i_codec_codec_dapm_routes,
+		.num_dapm_routes  = ARRAY_SIZE(sun4i_codec_codec_dapm_routes),
 	},
 };
 
