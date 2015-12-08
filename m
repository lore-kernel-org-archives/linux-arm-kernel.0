From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Tue, 8 Dec 2015 04:20:13 +0100
Subject: [PATCH v5] sun4i-codec: add inputs
Message-ID: <20151208042013.11d31f09@dayas>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is the fifth version of the patch that adds inputs to sun4i-codec.
(Previous versions have been on the linux-sunxi mailing list only)

The inputs added are:
- FM-In Left and Right
- Line-In Left and Right
- Mic1-In
- Mic2-In

Changes compared to v4 are:
- Mic preamplifier controls have more common names now.
- Mic preamplifier scale has a 0 dB entry as well now, as documented in the 
  A20 user manual.
- Mic preamplifier has special cases for A20 and A10 now.
- Gain controls have "Gain" in the name now.

I successfully tested it on an A20 board using alsamixer, headphones, a radio and 
my ears.
Note that because of missing capturing support I tested only the mixing, 
for Mic, Line, and FM.

The patches are on top of <git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git>, 
branch "sunxi/for-next".

Regards,
   Danny

Danny (1):
 b/sound/soc/sunxi/sun4i-codec.c |  153 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 150 insertions(+), 3 deletions(-)

Signed-off-by: Danny Milosavljevic <dannym+a@scratchpost.org>
---
diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index bcbf4da..106b568 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -57,9 +57,20 @@
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
@@ -84,8 +95,11 @@
 #define SUN4I_CODEC_ADC_ACTL_PREG1EN			(29)
 #define SUN4I_CODEC_ADC_ACTL_PREG2EN			(28)
 #define SUN4I_CODEC_ADC_ACTL_VMICEN			(27)
+#define SUN4I_CODEC_ADC_ACTL_PREG1_A10			(25)
+#define SUN4I_CODEC_ADC_ACTL_PREG2_A10			(23)
 #define SUN4I_CODEC_ADC_ACTL_VADCG			(20)
 #define SUN4I_CODEC_ADC_ACTL_ADCIS			(17)
+#define SUN4I_CODEC_ADC_ACTL_LNRDF			(16)
 #define SUN4I_CODEC_ADC_ACTL_PA_EN			(4)
 #define SUN4I_CODEC_ADC_ACTL_DDE			(3)
 #define SUN4I_CODEC_ADC_DEBUG			(0x2c)
@@ -94,7 +108,18 @@
 #define SUN4I_CODEC_DAC_TXCNT			(0x30)
 #define SUN4I_CODEC_ADC_RXCNT			(0x34)
 #define SUN4I_CODEC_AC_SYS_VERI			(0x38)
-#define SUN4I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
+
+/* MIC_PHONE_CAL register offsets and bit fields (A20 only) */
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1      (29)
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2      (26)
+/* note: no idea where the output pins for the following are. */
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTG  (5)
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTEN (4)
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS3 (3)
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS2 (2)
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS1 (1)
+#define SUN7I_CODEC_AC_MIC_PHONE_CAL_PHONEOUTS0 (0)
 
 struct sun4i_codec {
 	struct device	*dev;
@@ -402,16 +427,94 @@ static const struct snd_kcontrol_new sun4i_codec_pa_mute =
 			SUN4I_CODEC_DAC_ACTL_PA_MUTE, 1, 0);
 
 static DECLARE_TLV_DB_SCALE(sun4i_codec_pa_volume_scale, -6300, 100, 1);
+static DECLARE_TLV_DB_SCALE(sun4i_codec_linein_loopback_gain_scale, -150, 150, 0);
+static DECLARE_TLV_DB_SCALE(sun4i_codec_fmin_loopback_gain_scale, -450, 150, 0);
+static DECLARE_TLV_DB_SCALE(sun4i_codec_micin_loopback_gain_scale, -450, 150, 0);
+static DECLARE_TLV_DB_RANGE(sun7i_codec_micin_preamp_gain_scale,
+	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+	1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0)
+);
+static DECLARE_TLV_DB_RANGE(sun4i_codec_micin_preamp_gain_scale_a10,
+	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+	1, 7, TLV_DB_SCALE_ITEM(3500, 300, 0)
+);
+
+struct snd_kcontrol_new sun7ionly_codec_widgets[] = {
+	SOC_SINGLE_TLV("Mic1-In Boost Gain",
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL,
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG1,
+		       7,
+		       0,
+		       sun7i_codec_micin_preamp_gain_scale),
+	SOC_SINGLE_TLV("Mic2-In Boost Gain",
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL,
+		       SUN7I_CODEC_AC_MIC_PHONE_CAL_PREG2,
+		       7,
+		       0,
+		       sun7i_codec_micin_preamp_gain_scale),
+};
 
-static const struct snd_kcontrol_new sun4i_codec_widgets[] = {
+/* Note: this is modified by the sun4i_codec_probe() function. */
+static struct snd_kcontrol_new sun4i_codec_widgets[] = {
 	SOC_SINGLE_TLV("PA Volume", SUN4I_CODEC_DAC_ACTL,
 		       SUN4I_CODEC_DAC_ACTL_PA_VOL, 0x3F, 0,
 		       sun4i_codec_pa_volume_scale),
+	/* Line-In, FM-In, Mic1-In, Mic2-In */
+	SOC_SINGLE_TLV("Line-In Playback Gain",
+		       SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_LNG,
+		       1,
+		       0,
+		       sun4i_codec_linein_loopback_gain_scale),
+	SOC_SINGLE_TLV("FM-In Playback Gain",
+		       SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_FMG,
+		       3,
+		       0,
+		       sun4i_codec_fmin_loopback_gain_scale),
+	SOC_SINGLE_TLV("Mic-In Playback Gain",
+		       SUN4I_CODEC_DAC_ACTL,
+		       SUN4I_CODEC_DAC_ACTL_MICG,
+		       7,
+		       0,
+		       sun4i_codec_micin_loopback_gain_scale),
+	SOC_SINGLE_TLV("Mic1-In Boost Gain",
+		       SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_PREG1_A10,
+		       3,
+		       0,
+		       sun4i_codec_micin_preamp_gain_scale_a10),
+	SOC_SINGLE_TLV("Mic2-In Boost Gain",
+		       SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_PREG2_A10,
+		       3,
+		       0,
+		       sun4i_codec_micin_preamp_gain_scale_a10),
+	SOC_SINGLE_TLV("Mic1-In Boost Switch",
+		       SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_PREG1EN,
+		       1,
+		       0,
+		       NULL),
+	SOC_SINGLE_TLV("Mic2-In Boost Switch",
+		       SUN4I_CODEC_ADC_ACTL,
+		       SUN4I_CODEC_ADC_ACTL_PREG2EN,
+		       1,
+		       0,
+		       NULL),
 };
 
 static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
 	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
+	SOC_DAPM_SINGLE("Left Line-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_LLNS, 1, 0),
+	SOC_DAPM_SINGLE("Left FM-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_LFMS, 1, 0),
+	SOC_DAPM_SINGLE("Mic1-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_MIC1LS, 1, 0),
+	SOC_DAPM_SINGLE("Mic2-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_MIC2LS, 1, 0),
 };
 
 static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
@@ -419,6 +522,14 @@ static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
 			SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
 	SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
 			SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
+	SOC_DAPM_SINGLE("Right Line-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_RLNS, 1, 0),
+	SOC_DAPM_SINGLE("Right FM-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),
+	SOC_DAPM_SINGLE("Mic1-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),
+	SOC_DAPM_SINGLE("Mic2-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
+			SUN4I_CODEC_DAC_ACTL_MIC2RS, 1, 0),
 };
 
 static const struct snd_kcontrol_new sun4i_codec_pa_mixer_controls[] = {
@@ -462,8 +573,16 @@ static const struct snd_soc_dapm_widget sun4i_codec_dapm_widgets[] = {
 
 	SND_SOC_DAPM_OUTPUT("HP Right"),
 	SND_SOC_DAPM_OUTPUT("HP Left"),
+
+	SND_SOC_DAPM_INPUT("Line-In Right"),
+	SND_SOC_DAPM_INPUT("Line-In Left"),
+	SND_SOC_DAPM_INPUT("FM-In Right"),
+	SND_SOC_DAPM_INPUT("FM-In Left"),
+	SND_SOC_DAPM_INPUT("Mic1-In"),
+	SND_SOC_DAPM_INPUT("Mic2-In"),
 };
 
+/* {sink, control, source} */
 static const struct snd_soc_dapm_route sun4i_codec_dapm_routes[] = {
 	/* Left DAC Routes */
 	{ "Left DAC", NULL, "DAC" },
@@ -490,6 +609,20 @@ static const struct snd_soc_dapm_route sun4i_codec_dapm_routes[] = {
 	{ "Pre-Amplifier Mute", "Switch", "Pre-Amplifier" },
 	{ "HP Right", NULL, "Pre-Amplifier Mute" },
 	{ "HP Left", NULL, "Pre-Amplifier Mute" },
+
+	/* Line-In, FM-In */
+	{ "Right Mixer", "Right Line-In Playback Switch", "Line-In Right" },
+	{ "Left Mixer", "Left Line-In Playback Switch", "Line-In Left" },
+	{ "Right Mixer", "Right FM-In Playback Switch", "FM-In Right" },
+	{ "Left Mixer", "Left FM-In Playback Switch", "FM-In Left" },
+
+	/* Mic1-In */
+	{ "Right Mixer", "Mic1-In Playback Switch", "Mic1-In" },
+	{ "Left Mixer", "Mic1-In Playback Switch", "Mic1-In" },
+
+	/* Mic2-In */
+	{ "Right Mixer", "Mic2-In Playback Switch", "Mic2-In" },
+	{ "Left Mixer", "Mic2-In Playback Switch", "Mic2-In" },
 };
 
 static struct snd_soc_codec_driver sun4i_codec_codec = {
@@ -537,7 +670,7 @@ static const struct regmap_config sun4i_codec_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
 	.val_bits	= 32,
-	.max_register	= SUN4I_CODEC_AC_MIC_PHONE_CAL,
+	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
 };
 
 static const struct of_device_id sun4i_codec_of_match[] = {
@@ -594,6 +727,20 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret;
 
+	if (of_device_is_compatible(pdev->dev.of_node, "allwinner,sun7i-a20-codec")) {
+		size_t i, j;
+		for (i = 0; i < ARRAY_SIZE(sun7ionly_codec_widgets); ++i) {
+			struct snd_kcontrol_new *new_kcontrol;
+			new_kcontrol = &sun7ionly_codec_widgets[i];
+			for (j = 0; j < ARRAY_SIZE(sun4i_codec_widgets); ++j) {
+				struct snd_kcontrol_new *kcontrol;
+				kcontrol = &sun4i_codec_widgets[j];
+				if (strcmp(kcontrol->name, new_kcontrol->name) == 0)
+					memcpy(kcontrol, new_kcontrol, sizeof(*kcontrol));
+			}
+		}
+	}
+
 	scodec = devm_kzalloc(&pdev->dev, sizeof(*scodec), GFP_KERNEL);
 	if (!scodec)
 		return -ENOMEM;
