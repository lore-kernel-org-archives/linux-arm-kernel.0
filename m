From: broonie@kernel.org (Mark Brown)
Date: Wed, 09 Nov 2016 14:59:14 +0000
Subject: Applied "ASoC: sun4i-codec: Add support for A31 ADC capture path" to
 the asoc tree
In-Reply-To: <20161003110804.28235-10-wens@csie.org>
Message-ID: <E1c4ULK-0002e1-Qj@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-codec: Add support for A31 ADC capture path

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 24c99f843208df70ec7d1e04aa405f7e4c36f228 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 7 Nov 2016 18:06:59 +0800
Subject: [PATCH] ASoC: sun4i-codec: Add support for A31 ADC capture path

The A31's internal codec capture path has a mixer in front of the ADC
for each channel, capable of selecting various inputs, including
microphones, line in, phone in, and the main output mixer.

This patch adds the various controls, widgets and routes needed for
audio capture from the already supported inputs on the A31.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 65 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 1934db29b2b5..735115244b17 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -786,6 +786,30 @@ static const struct snd_kcontrol_new sun6i_codec_mixer_controls[] = {
 			SUN6I_CODEC_OM_DACA_CTRL_RMIX_MIC2, 1, 0),
 };
 
+/* ADC mixer controls */
+static const struct snd_kcontrol_new sun6i_codec_adc_mixer_controls[] = {
+	SOC_DAPM_DOUBLE("Mixer Capture Switch",
+			SUN6I_CODEC_ADC_ACTL,
+			SUN6I_CODEC_ADC_ACTL_LADCMIX_OMIXL,
+			SUN6I_CODEC_ADC_ACTL_RADCMIX_OMIXR, 1, 0),
+	SOC_DAPM_DOUBLE("Mixer Reversed Capture Switch",
+			SUN6I_CODEC_ADC_ACTL,
+			SUN6I_CODEC_ADC_ACTL_LADCMIX_OMIXR,
+			SUN6I_CODEC_ADC_ACTL_RADCMIX_OMIXL, 1, 0),
+	SOC_DAPM_DOUBLE("Line In Capture Switch",
+			SUN6I_CODEC_ADC_ACTL,
+			SUN6I_CODEC_ADC_ACTL_LADCMIX_LINEINL,
+			SUN6I_CODEC_ADC_ACTL_RADCMIX_LINEINR, 1, 0),
+	SOC_DAPM_DOUBLE("Mic1 Capture Switch",
+			SUN6I_CODEC_ADC_ACTL,
+			SUN6I_CODEC_ADC_ACTL_LADCMIX_MIC1,
+			SUN6I_CODEC_ADC_ACTL_RADCMIX_MIC1, 1, 0),
+	SOC_DAPM_DOUBLE("Mic2 Capture Switch",
+			SUN6I_CODEC_ADC_ACTL,
+			SUN6I_CODEC_ADC_ACTL_LADCMIX_MIC2,
+			SUN6I_CODEC_ADC_ACTL_RADCMIX_MIC2, 1, 0),
+};
+
 /* headphone controls */
 static const char * const sun6i_codec_hp_src_enum_text[] = {
 	"DAC", "Mixer",
@@ -885,6 +909,10 @@ static const struct snd_kcontrol_new sun6i_codec_codec_widgets[] = {
 	SOC_SINGLE_TLV("Mic2 Boost Volume", SUN6I_CODEC_MIC_CTRL,
 		       SUN6I_CODEC_MIC_CTRL_MIC2BOOST, 0x7, 0,
 		       sun6i_codec_mic_gain_scale),
+	SOC_DOUBLE_TLV("ADC Capture Volume",
+		       SUN6I_CODEC_ADC_ACTL, SUN6I_CODEC_ADC_ACTL_ADCLG,
+		       SUN6I_CODEC_ADC_ACTL_ADCRG, 0x7, 0,
+		       sun6i_codec_out_mixer_pregain_scale),
 };
 
 static const struct snd_soc_dapm_widget sun6i_codec_codec_dapm_widgets[] = {
@@ -910,6 +938,23 @@ static const struct snd_soc_dapm_widget sun6i_codec_codec_dapm_widgets[] = {
 	/* Line In */
 	SND_SOC_DAPM_INPUT("LINEIN"),
 
+	/* Digital parts of the ADCs */
+	SND_SOC_DAPM_SUPPLY("ADC Enable", SUN6I_CODEC_ADC_FIFOC,
+			    SUN6I_CODEC_ADC_FIFOC_EN_AD, 0,
+			    NULL, 0),
+
+	/* Analog parts of the ADCs */
+	SND_SOC_DAPM_ADC("Left ADC", "Codec Capture", SUN6I_CODEC_ADC_ACTL,
+			 SUN6I_CODEC_ADC_ACTL_ADCLEN, 0),
+	SND_SOC_DAPM_ADC("Right ADC", "Codec Capture", SUN6I_CODEC_ADC_ACTL,
+			 SUN6I_CODEC_ADC_ACTL_ADCREN, 0),
+
+	/* ADC Mixers */
+	SOC_MIXER_ARRAY("Left ADC Mixer", SND_SOC_NOPM, 0, 0,
+			sun6i_codec_adc_mixer_controls),
+	SOC_MIXER_ARRAY("Right ADC Mixer", SND_SOC_NOPM, 0, 0,
+			sun6i_codec_adc_mixer_controls),
+
 	/* Digital parts of the DACs */
 	SND_SOC_DAPM_SUPPLY("DAC Enable", SUN4I_CODEC_DAC_DPC,
 			    SUN4I_CODEC_DAC_DPC_EN_DA, 0,
@@ -973,6 +1018,20 @@ static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
 	{ "Right Mixer", "Mic1 Playback Switch", "Mic1 Amplifier" },
 	{ "Right Mixer", "Mic2 Playback Switch", "Mic2 Amplifier" },
 
+	/* Left ADC Mixer Routes */
+	{ "Left ADC Mixer", "Mixer Capture Switch", "Left Mixer" },
+	{ "Left ADC Mixer", "Mixer Reversed Capture Switch", "Right Mixer" },
+	{ "Left ADC Mixer", "Line In Capture Switch", "LINEIN" },
+	{ "Left ADC Mixer", "Mic1 Capture Switch", "Mic1 Amplifier" },
+	{ "Left ADC Mixer", "Mic2 Capture Switch", "Mic2 Amplifier" },
+
+	/* Right ADC Mixer Routes */
+	{ "Right ADC Mixer", "Mixer Capture Switch", "Right Mixer" },
+	{ "Right ADC Mixer", "Mixer Reversed Capture Switch", "Left Mixer" },
+	{ "Right ADC Mixer", "Line In Capture Switch", "LINEIN" },
+	{ "Right ADC Mixer", "Mic1 Capture Switch", "Mic1 Amplifier" },
+	{ "Right ADC Mixer", "Mic2 Capture Switch", "Mic2 Amplifier" },
+
 	/* Headphone Routes */
 	{ "Headphone Source Playback Route", "DAC", "Left DAC" },
 	{ "Headphone Source Playback Route", "DAC", "Right DAC" },
@@ -987,6 +1046,12 @@ static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
 	{ "Line Out Source Playback Route", "Stereo", "Right Mixer" },
 	{ "Line Out Source Playback Route", "Mono Differential", "Left Mixer" },
 	{ "LINEOUT", NULL, "Line Out Source Playback Route" },
+
+	/* ADC Routes */
+	{ "Left ADC", NULL, "ADC Enable" },
+	{ "Right ADC", NULL, "ADC Enable" },
+	{ "Left ADC", NULL, "Left ADC Mixer" },
+	{ "Right ADC", NULL, "Right ADC Mixer" },
 };
 
 static struct snd_soc_codec_driver sun6i_codec_codec = {
-- 
2.10.2
