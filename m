From: broonie@kernel.org (Mark Brown)
Date: Fri, 04 Nov 2016 14:40:02 -0600
Subject: Applied "ASoC: sun4i-codec: Add support for A31 analog microphone
 inputs" to the asoc tree
In-Reply-To: <20161103075556.29018-10-wens@csie.org>
Message-ID: <E1c2lHO-0001UZ-Ss@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-codec: Add support for A31 analog microphone inputs

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

>From ecd5cdb4fd818b1cec55863d5de3683dad1c2f53 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 3 Nov 2016 15:55:51 +0800
Subject: [PATCH] ASoC: sun4i-codec: Add support for A31 analog microphone
 inputs

The A31 internal codec has 3 microphone outputs, of which MIC2 and MIC3
are muxed internally. The resulting two microphone inputs have separate
gain controls and mixer inputs.

The codec also has 2 microphone bias pins. HBIAS is specifically for the
headphone jack, which also supports headphone detection and control
buttons. These extra functions are not supported yet. The other, MBIAS,
is for all other analog microphones.

There is also mention of digital microphone support, but documentation
is scarce, and no hardware with it is available.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 70 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index a10251f4932e..f55718fe7c5b 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -776,6 +776,14 @@ static const struct snd_kcontrol_new sun6i_codec_mixer_controls[] = {
 			SUN6I_CODEC_OM_DACA_CTRL,
 			SUN6I_CODEC_OM_DACA_CTRL_LMIX_LINEINL,
 			SUN6I_CODEC_OM_DACA_CTRL_RMIX_LINEINR, 1, 0),
+	SOC_DAPM_DOUBLE("Mic1 Playback Switch",
+			SUN6I_CODEC_OM_DACA_CTRL,
+			SUN6I_CODEC_OM_DACA_CTRL_LMIX_MIC1,
+			SUN6I_CODEC_OM_DACA_CTRL_RMIX_MIC1, 1, 0),
+	SOC_DAPM_DOUBLE("Mic2 Playback Switch",
+			SUN6I_CODEC_OM_DACA_CTRL,
+			SUN6I_CODEC_OM_DACA_CTRL_LMIX_MIC2,
+			SUN6I_CODEC_OM_DACA_CTRL_RMIX_MIC2, 1, 0),
 };
 
 /* headphone controls */
@@ -794,6 +802,21 @@ static const struct snd_kcontrol_new sun6i_codec_hp_src[] = {
 		      sun6i_codec_hp_src_enum),
 };
 
+/* microphone controls */
+static const char * const sun6i_codec_mic2_src_enum_text[] = {
+	"Mic2", "Mic3",
+};
+
+static SOC_ENUM_SINGLE_DECL(sun6i_codec_mic2_src_enum,
+			    SUN6I_CODEC_MIC_CTRL,
+			    SUN6I_CODEC_MIC_CTRL_MIC2SLT,
+			    sun6i_codec_mic2_src_enum_text);
+
+static const struct snd_kcontrol_new sun6i_codec_mic2_src[] = {
+	SOC_DAPM_ENUM("Mic2 Amplifier Source Route",
+		      sun6i_codec_mic2_src_enum),
+};
+
 /* line out controls */
 static const char * const sun6i_codec_lineout_src_enum_text[] = {
 	"Stereo", "Mono Differential",
@@ -819,6 +842,10 @@ static const DECLARE_TLV_DB_RANGE(sun6i_codec_lineout_vol_scale,
 	0, 1, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
 	2, 31, TLV_DB_SCALE_ITEM(-4350, 150, 0),
 );
+static const DECLARE_TLV_DB_RANGE(sun6i_codec_mic_gain_scale,
+	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+	1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0),
+);
 
 static const struct snd_kcontrol_new sun6i_codec_codec_widgets[] = {
 	SOC_SINGLE_TLV("DAC Playback Volume", SUN4I_CODEC_DAC_DPC,
@@ -844,9 +871,42 @@ static const struct snd_kcontrol_new sun6i_codec_codec_widgets[] = {
 	SOC_SINGLE_TLV("Line In Playback Volume",
 		       SUN6I_CODEC_OM_PA_CTRL, SUN6I_CODEC_OM_PA_CTRL_LINEING,
 		       0x7, 0, sun6i_codec_out_mixer_pregain_scale),
+	SOC_SINGLE_TLV("Mic1 Playback Volume",
+		       SUN6I_CODEC_OM_PA_CTRL, SUN6I_CODEC_OM_PA_CTRL_MIC1G,
+		       0x7, 0, sun6i_codec_out_mixer_pregain_scale),
+	SOC_SINGLE_TLV("Mic2 Playback Volume",
+		       SUN6I_CODEC_OM_PA_CTRL, SUN6I_CODEC_OM_PA_CTRL_MIC2G,
+		       0x7, 0, sun6i_codec_out_mixer_pregain_scale),
+
+	/* Microphone Amp boost gains */
+	SOC_SINGLE_TLV("Mic1 Boost Volume", SUN6I_CODEC_MIC_CTRL,
+		       SUN6I_CODEC_MIC_CTRL_MIC1BOOST, 0x7, 0,
+		       sun6i_codec_mic_gain_scale),
+	SOC_SINGLE_TLV("Mic2 Boost Volume", SUN6I_CODEC_MIC_CTRL,
+		       SUN6I_CODEC_MIC_CTRL_MIC2BOOST, 0x7, 0,
+		       sun6i_codec_mic_gain_scale),
 };
 
 static const struct snd_soc_dapm_widget sun6i_codec_codec_dapm_widgets[] = {
+	/* Microphone inputs */
+	SND_SOC_DAPM_INPUT("MIC1"),
+	SND_SOC_DAPM_INPUT("MIC2"),
+	SND_SOC_DAPM_INPUT("MIC3"),
+
+	/* Microphone Bias */
+	SND_SOC_DAPM_SUPPLY("HBIAS", SUN6I_CODEC_MIC_CTRL,
+			    SUN6I_CODEC_MIC_CTRL_HBIASEN, 0, NULL, 0),
+	SND_SOC_DAPM_SUPPLY("MBIAS", SUN6I_CODEC_MIC_CTRL,
+			    SUN6I_CODEC_MIC_CTRL_MBIASEN, 0, NULL, 0),
+
+	/* Mic input path */
+	SND_SOC_DAPM_MUX("Mic2 Amplifier Source Route",
+			 SND_SOC_NOPM, 0, 0, sun6i_codec_mic2_src),
+	SND_SOC_DAPM_PGA("Mic1 Amplifier", SUN6I_CODEC_MIC_CTRL,
+			 SUN6I_CODEC_MIC_CTRL_MIC1AMPEN, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Mic2 Amplifier", SUN6I_CODEC_MIC_CTRL,
+			 SUN6I_CODEC_MIC_CTRL_MIC2AMPEN, 0, NULL, 0),
+
 	/* Line In */
 	SND_SOC_DAPM_INPUT("LINEIN"),
 
@@ -893,15 +953,25 @@ static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
 	{ "Left DAC", NULL, "DAC Enable" },
 	{ "Right DAC", NULL, "DAC Enable" },
 
+	/* Microphone Routes */
+	{ "Mic1 Amplifier", NULL, "MIC1"},
+	{ "Mic2 Amplifier Source Route", "Mic2", "MIC2" },
+	{ "Mic2 Amplifier Source Route", "Mic3", "MIC3" },
+	{ "Mic2 Amplifier", NULL, "Mic2 Amplifier Source Route"},
+
 	/* Left Mixer Routes */
 	{ "Left Mixer", "DAC Playback Switch", "Left DAC" },
 	{ "Left Mixer", "DAC Reversed Playback Switch", "Right DAC" },
 	{ "Left Mixer", "Line In Playback Switch", "LINEIN" },
+	{ "Left Mixer", "Mic1 Playback Switch", "Mic1 Amplifier" },
+	{ "Left Mixer", "Mic2 Playback Switch", "Mic2 Amplifier" },
 
 	/* Right Mixer Routes */
 	{ "Right Mixer", "DAC Playback Switch", "Right DAC" },
 	{ "Right Mixer", "DAC Reversed Playback Switch", "Left DAC" },
 	{ "Right Mixer", "Line In Playback Switch", "LINEIN" },
+	{ "Right Mixer", "Mic1 Playback Switch", "Mic1 Amplifier" },
+	{ "Right Mixer", "Mic2 Playback Switch", "Mic2 Amplifier" },
 
 	/* Headphone Routes */
 	{ "Headphone Source Playback Route", "DAC", "Left DAC" },
-- 
2.10.1
