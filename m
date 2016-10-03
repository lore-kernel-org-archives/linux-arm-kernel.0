From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  3 Oct 2016 19:08:00 +0800
Subject: [PATCH 08/12] ASoC: sun4i-codec: Add support for A31 analog
 microphone inputs
In-Reply-To: <20161003110804.28235-1-wens@csie.org>
References: <20161003110804.28235-1-wens@csie.org>
Message-ID: <20161003110804.28235-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
 sound/soc/sunxi/sun4i-codec.c | 70 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 5cbbab62bfd2..727f54e3bd13 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -751,6 +751,14 @@ static const struct snd_kcontrol_new sun6i_codec_mixer_controls[] = {
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
@@ -768,6 +776,21 @@ static const struct snd_kcontrol_new sun6i_codec_hp_src[] = {
 	SOC_DAPM_ENUM("Headphone Source Playback Route", sun6i_codec_hp_src_enum),
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
@@ -790,6 +813,10 @@ static const DECLARE_TLV_DB_SCALE(sun6i_codec_hp_vol_scale, -6300, 100, 1);
 static const DECLARE_TLV_DB_SCALE(sun6i_codec_lineout_vol_scale, -4800, 150, 0);
 static const DECLARE_TLV_DB_SCALE(sun6i_codec_out_mixer_pregain_scale,
 				  -450, 150, 0);
+static const DECLARE_TLV_DB_RANGE(sun6i_codec_mic_gain_scale,
+	0, 0, TLV_DB_SCALE_ITEM(0, 0, 0),
+	1, 7, TLV_DB_SCALE_ITEM(2400, 300, 0),
+);
 
 static const struct snd_kcontrol_new sun6i_codec_codec_widgets[] = {
 	SOC_SINGLE_TLV("DAC Playback Volume", SUN4I_CODEC_DAC_DPC,
@@ -815,9 +842,42 @@ static const struct snd_kcontrol_new sun6i_codec_codec_widgets[] = {
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
 
@@ -858,15 +918,25 @@ static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
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
2.9.3
