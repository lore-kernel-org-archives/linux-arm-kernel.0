From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  3 Oct 2016 19:07:58 +0800
Subject: [PATCH 06/12] ASoC: sun4i-codec: Add support for A31 Line In playback
In-Reply-To: <20161003110804.28235-1-wens@csie.org>
References: <20161003110804.28235-1-wens@csie.org>
Message-ID: <20161003110804.28235-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 integrated codec has a stereo "Line In" input. Add support for
it to the playback paths.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/sunxi/sun4i-codec.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 9916714ecb71..d9ec8215c1f9 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -747,6 +747,10 @@ static const struct snd_kcontrol_new sun6i_codec_mixer_controls[] = {
 			SUN6I_CODEC_OM_DACA_CTRL,
 			SUN6I_CODEC_OM_DACA_CTRL_LMIX_DACR,
 			SUN6I_CODEC_OM_DACA_CTRL_RMIX_DACL, 1, 0),
+	SOC_DAPM_DOUBLE("Line In Playback Switch",
+			SUN6I_CODEC_OM_DACA_CTRL,
+			SUN6I_CODEC_OM_DACA_CTRL_LMIX_LINEINL,
+			SUN6I_CODEC_OM_DACA_CTRL_RMIX_LINEINR, 1, 0),
 };
 
 /* headphone controls */
@@ -767,6 +771,8 @@ static const struct snd_kcontrol_new sun6i_codec_hp_src[] = {
 /* volume / mute controls */
 static const DECLARE_TLV_DB_SCALE(sun6i_codec_dvol_scale, -7308, 116, 0);
 static const DECLARE_TLV_DB_SCALE(sun6i_codec_hp_vol_scale, -6300, 100, 1);
+static const DECLARE_TLV_DB_SCALE(sun6i_codec_out_mixer_pregain_scale,
+				  -450, 150, 0);
 
 static const struct snd_kcontrol_new sun6i_codec_codec_widgets[] = {
 	SOC_SINGLE_TLV("DAC Playback Volume", SUN4I_CODEC_DAC_DPC,
@@ -780,9 +786,16 @@ static const struct snd_kcontrol_new sun6i_codec_codec_widgets[] = {
 		   SUN6I_CODEC_OM_DACA_CTRL,
 		   SUN6I_CODEC_OM_DACA_CTRL_LHPPAMUTE,
 		   SUN6I_CODEC_OM_DACA_CTRL_RHPPAMUTE, 1, 0),
+	/* Mixer pre-gains */
+	SOC_SINGLE_TLV("Line In Playback Volume",
+		       SUN6I_CODEC_OM_PA_CTRL, SUN6I_CODEC_OM_PA_CTRL_LINEING,
+		       0x7, 0, sun6i_codec_out_mixer_pregain_scale),
 };
 
 static const struct snd_soc_dapm_widget sun6i_codec_codec_dapm_widgets[] = {
+	/* Line In */
+	SND_SOC_DAPM_INPUT("LINEIN"),
+
 	/* Digital parts of the DACs */
 	SND_SOC_DAPM_SUPPLY("DAC Enable", SUN4I_CODEC_DAC_DPC,
 			    SUN4I_CODEC_DAC_DPC_EN_DA, 0,
@@ -818,10 +831,12 @@ static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
 	/* Left Mixer Routes */
 	{ "Left Mixer", "DAC Playback Switch", "Left DAC" },
 	{ "Left Mixer", "DAC Reversed Playback Switch", "Right DAC" },
+	{ "Left Mixer", "Line In Playback Switch", "LINEIN" },
 
 	/* Right Mixer Routes */
 	{ "Right Mixer", "DAC Playback Switch", "Right DAC" },
 	{ "Right Mixer", "DAC Reversed Playback Switch", "Left DAC" },
+	{ "Right Mixer", "Line In Playback Switch", "LINEIN" },
 
 	/* Headphone Routes */
 	{ "Headphone Source Playback Route", "DAC", "Left DAC" },
-- 
2.9.3
