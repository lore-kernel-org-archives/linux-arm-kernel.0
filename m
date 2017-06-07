From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Wed,  7 Jun 2017 09:27:18 +0200
Subject: [PATCH v10] sun4i-codec: Add mixer controls: Line-In, FM-In, Mic  2,
 Capture Source, Differential Line-In.
In-Reply-To: <20170607072718.18017-1-dannym@scratchpost.org>
References: <20170607072718.18017-1-dannym@scratchpost.org>
Message-ID: <20170607072718.18017-2-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds support for some mixer controls to sun4i-codec:
 - Line-In
 - FM-In
 - Mic 2
 - Capture Source
 - Differential Line-In

It also adds a mux for the capture source and the PGA for the MIC2 preamp.

Where possible, it uses SOC_DAPM_DOUBLE in order to cut down on the number
of distinct controls in alsamixer.

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 296 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 269 insertions(+), 27 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 1500699..6b8a543 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -64,9 +64,20 @@
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
@@ -94,8 +105,12 @@
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
@@ -110,6 +125,9 @@
 /* Microphone controls (sun7i only) */
 #define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
 
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1      (29)
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2      (26)
+
 /*
  * sun6i specific registers
  *
@@ -643,22 +661,157 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
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
+
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
 
 static const struct snd_kcontrol_new sun4i_codec_controls[] = {
 	SOC_SINGLE_TLV("Power Amplifier Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
 		       sun4i_codec_pa_volume_scale),
+	SOC_SINGLE_TLV("Headphone Playback Volume", SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
+		       sun4i_codec_pa_volume_scale),
+	/* Line, FM, Mic1, Mic2 */
+	SOC_SINGLE_TLV("Line Playback Volume",
+		       SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_LNG,
+		       1,
+		       0,
+		       sun4i_codec_linein_loopback_gain_scale),
+	SOC_SINGLE_TLV("FM Playback Volume",
+		       SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_FMG,
+		       3,
+		       0,
+		       sun4i_codec_fmin_loopback_gain_scale),
+	SOC_SINGLE_TLV("Mic Playback Volume",
+		       SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_MICG,
+		       7,
+		       0,
+		       sun4i_codec_micin_loopback_gain_scale),
+	/* ADC */
+	SOC_SINGLE_TLV("Capture Volume",
+		       SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_ADCG,
+		       4,
+		       0,
+		       sun4i_codec_adc_gain_scale),
+	SOC_SINGLE_TLV("Line Capture Volume",
+		       SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_LNPREG,
+		       7,
+		       0,
+		       sun4i_codec_linein_preamp_gain_scale),
+};
+
+static const struct snd_kcontrol_new sun4i_codec_extra_controls[] = {
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
 
-static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
-			SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
+static const struct snd_kcontrol_new sun7i_codec_extra_controls[] = {
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
 
-static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
-	SOC_DAPM_SINGLE("Right DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
+static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
+	SOC_DAPM_DOUBLE("DAC Playback Switch",
+			SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_LDACLMIXS,
 			SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
-	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
+	SOC_DAPM_DOUBLE("Line Playback Switch",
+			SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_LLNS,
+			SUN4I_CODEC_DAC_ACTL_RLNS, 1, 0),
+	SOC_DAPM_DOUBLE("FM Playback Switch",
+			SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_LFMS,
+			SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),
+	SOC_DAPM_DOUBLE("Mic1 Playback Switch",
+			SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_MIC1LS,
+			SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),
+	SOC_DAPM_DOUBLE("Mic2 Playback Switch",
+			SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_MIC2LS,
+			SUN4I_CODEC_DAC_ACTL_MIC2RS, 1, 0),
+	/* Right Mixer: */
+	SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
 };
 
@@ -694,11 +847,11 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 
 	/* Mixers */
 	SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
-			   sun4i_codec_left_mixer_controls,
-			   ARRAY_SIZE(sun4i_codec_left_mixer_controls)),
+			   sun4i_codec_mixer_controls,
+			   ARRAY_SIZE(sun4i_codec_mixer_controls)),
 	SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
-			   sun4i_codec_right_mixer_controls,
-			   ARRAY_SIZE(sun4i_codec_right_mixer_controls)),
+			   sun4i_codec_mixer_controls,
+			   ARRAY_SIZE(sun4i_codec_mixer_controls)),
 
 	/* Global Mixer Enable */
 	SND_SOC_DAPM_SUPPLY("Mixer Enable", SUN4I_CODEC_DAC_ACTL,
@@ -712,6 +865,9 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("MIC1 Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
 			 SUN4I_CODEC_ADC_ACTL_PREG1EN, 0, NULL, 0),
 
+	SND_SOC_DAPM_PGA("MIC2 Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
+			 SUN4I_CODEC_ADC_ACTL_PREG2EN, 0, NULL, 0),
+
 	/* Power Amplifier */
 	SND_SOC_DAPM_MIXER("Power Amplifier", SUN4I_CODEC_ADC_ACTL,
 			   SUN4I_CODEC_ADC_ACTL_PA_EN, 0,
@@ -720,8 +876,25 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SWITCH("Power Amplifier Mute", SND_SOC_NOPM, 0, 0,
 			    &sun4i_codec_pa_mute),
 
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
@@ -735,14 +908,22 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right ADC", NULL, "ADC" },
 	{ "Right DAC", NULL, "DAC" },
 
-	/* Right Mixer Routes */
-	{ "Right Mixer", NULL, "Mixer Enable" },
-	{ "Right Mixer", "Left DAC Playback Switch", "Left DAC" },
-	{ "Right Mixer", "Right DAC Playback Switch", "Right DAC" },
-
 	/* Left Mixer Routes */
 	{ "Left Mixer", NULL, "Mixer Enable" },
-	{ "Left Mixer", "Left DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "DAC Playback Switch", "Left DAC" },
+	{ "Left Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
+	{ "Left Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
+	{ "Left Mixer", "Line Playback Switch", "Line Left" },
+	{ "Left Mixer", "FM Playback Switch", "FM Left" },
+
+	/* Right Mixer Routes */
+	{ "Right Mixer", NULL, "Mixer Enable" },
+	{ "Right Mixer", "Right Mixer Left DAC Playback Switch", "Left DAC" },
+	{ "Right Mixer", "DAC Playback Switch", "Right DAC" },
+	{ "Right Mixer", "Mic1 Playback Switch", "MIC1 Pre-Amplifier" },
+	{ "Right Mixer", "Mic2 Playback Switch", "MIC2 Pre-Amplifier" },
+	{ "Right Mixer", "Line Playback Switch", "Line Right" },
+	{ "Right Mixer", "FM Playback Switch", "FM Right" },
 
 	/* Power Amplifier Routes */
 	{ "Power Amplifier", "Mixer Playback Switch", "Left Mixer" },
@@ -760,9 +941,76 @@ static const struct snd_soc_dapm_route sun4i_codec_codec_dapm_routes[] = {
 	{ "Right ADC", NULL, "MIC1 Pre-Amplifier" },
 	{ "MIC1 Pre-Amplifier", NULL, "Mic1"},
 	{ "Mic1", NULL, "VMIC" },
+
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
 
+struct sun4i_codec_quirks {
+	const struct regmap_config *regmap_config;
+	const struct snd_soc_codec_driver *codec;
+	struct snd_soc_card * (*create_card)(struct device *dev);
+	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
+	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
+	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
+	bool has_reset;
+	const struct snd_kcontrol_new *controls;
+	unsigned int num_controls;
+};
+
+static int sun4i_codec_codec_probe(struct snd_soc_codec *scodec)
+{
+	const struct sun4i_codec_quirks *quirks;
+
+	quirks = of_device_get_match_data(scodec->dev);
+	return snd_soc_add_codec_controls(scodec,
+					  quirks->controls,
+					  quirks->num_controls);
+}
+
 static struct snd_soc_codec_driver sun4i_codec_codec = {
+	.probe = sun4i_codec_codec_probe,
 	.component_driver = {
 		.controls		= sun4i_codec_controls,
 		.num_controls		= ARRAY_SIZE(sun4i_codec_controls),
@@ -1419,16 +1667,6 @@ static const struct regmap_config sun8i_v3s_codec_regmap_config = {
 	.max_register	= SUN8I_H3_CODEC_ADC_DBG,
 };
 
-struct sun4i_codec_quirks {
-	const struct regmap_config *regmap_config;
-	const struct snd_soc_codec_driver *codec;
-	struct snd_soc_card * (*create_card)(struct device *dev);
-	struct reg_field reg_adc_fifoc;	/* used for regmap_field */
-	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
-	unsigned int reg_adc_rxdata;	/* RX FIFO offset for DMA config */
-	bool has_reset;
-};
-
 static const struct sun4i_codec_quirks sun4i_codec_quirks = {
 	.regmap_config	= &sun4i_codec_regmap_config,
 	.codec		= &sun4i_codec_codec,
@@ -1436,6 +1674,8 @@ static const struct sun4i_codec_quirks sun4i_codec_quirks = {
 	.reg_adc_fifoc	= REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
+	.controls = sun4i_codec_extra_controls,
+	.num_controls = ARRAY_SIZE(sun4i_codec_extra_controls),
 };
 
 static const struct sun4i_codec_quirks sun6i_a31_codec_quirks = {
@@ -1455,6 +1695,8 @@ static const struct sun4i_codec_quirks sun7i_codec_quirks = {
 	.reg_adc_fifoc	= REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
 	.reg_dac_txdata	= SUN4I_CODEC_DAC_TXDATA,
 	.reg_adc_rxdata	= SUN4I_CODEC_ADC_RXDATA,
+	.controls = sun7i_codec_extra_controls,
+	.num_controls = ARRAY_SIZE(sun7i_codec_extra_controls),
 };
 
 static const struct sun4i_codec_quirks sun8i_a23_codec_quirks = {
-- 
2.1.4
