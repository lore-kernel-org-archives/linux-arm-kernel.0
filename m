From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Nov 2016 15:55:50 +0800
Subject: [PATCH v2 08/14] ASoC: sun4i-codec: Add support for A31 Line Out
 playback
In-Reply-To: <20161103075556.29018-1-wens@csie.org>
References: <20161103075556.29018-1-wens@csie.org>
Message-ID: <20161103075556.29018-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 integrated codec has a second "Line Out" output which does not
include an integrated amplifier in its path. This path does have a
separate volume control.

This patch adds support for the playback path from the DAC to the Line
Out pins.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/sunxi/sun4i-codec.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 4abac9962165..8ba7804a68ed 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -796,11 +796,31 @@ static const struct snd_kcontrol_new sun6i_codec_hp_src[] = {
 		      sun6i_codec_hp_src_enum),
 };
 
+/* line out controls */
+static const char * const sun6i_codec_lineout_src_enum_text[] = {
+	"Stereo", "Mono Differential",
+};
+
+static SOC_ENUM_DOUBLE_DECL(sun6i_codec_lineout_src_enum,
+			    SUN6I_CODEC_MIC_CTRL,
+			    SUN6I_CODEC_MIC_CTRL_LINEOUTLSRC,
+			    SUN6I_CODEC_MIC_CTRL_LINEOUTRSRC,
+			    sun6i_codec_lineout_src_enum_text);
+
+static const struct snd_kcontrol_new sun6i_codec_lineout_src[] = {
+	SOC_DAPM_ENUM("Line Out Source Playback Route",
+		      sun6i_codec_lineout_src_enum),
+};
+
 /* volume / mute controls */
 static const DECLARE_TLV_DB_SCALE(sun6i_codec_dvol_scale, -7308, 116, 0);
 static const DECLARE_TLV_DB_SCALE(sun6i_codec_hp_vol_scale, -6300, 100, 1);
 static const DECLARE_TLV_DB_SCALE(sun6i_codec_out_mixer_pregain_scale,
 				  -450, 150, 0);
+static const DECLARE_TLV_DB_RANGE(sun6i_codec_lineout_vol_scale,
+	0, 1, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
+	2, 31, TLV_DB_SCALE_ITEM(-4350, 150, 0),
+);
 
 static const struct snd_kcontrol_new sun6i_codec_codec_widgets[] = {
 	SOC_SINGLE_TLV("DAC Playback Volume", SUN4I_CODEC_DAC_DPC,
@@ -810,10 +830,18 @@ static const struct snd_kcontrol_new sun6i_codec_codec_widgets[] = {
 		       SUN6I_CODEC_OM_DACA_CTRL,
 		       SUN6I_CODEC_OM_DACA_CTRL_HPVOL, 0x3f, 0,
 		       sun6i_codec_hp_vol_scale),
+	SOC_SINGLE_TLV("Line Out Playback Volume",
+		       SUN6I_CODEC_MIC_CTRL,
+		       SUN6I_CODEC_MIC_CTRL_LINEOUTVC, 0x1f, 0,
+		       sun6i_codec_lineout_vol_scale),
 	SOC_DOUBLE("Headphone Playback Switch",
 		   SUN6I_CODEC_OM_DACA_CTRL,
 		   SUN6I_CODEC_OM_DACA_CTRL_LHPPAMUTE,
 		   SUN6I_CODEC_OM_DACA_CTRL_RHPPAMUTE, 1, 0),
+	SOC_DOUBLE("Line Out Playback Switch",
+		   SUN6I_CODEC_MIC_CTRL,
+		   SUN6I_CODEC_MIC_CTRL_LINEOUTLEN,
+		   SUN6I_CODEC_MIC_CTRL_LINEOUTREN, 1, 0),
 	/* Mixer pre-gains */
 	SOC_SINGLE_TLV("Line In Playback Volume",
 		       SUN6I_CODEC_OM_PA_CTRL, SUN6I_CODEC_OM_PA_CTRL_LINEING,
@@ -855,6 +883,11 @@ static const struct snd_soc_dapm_widget sun6i_codec_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_REG(snd_soc_dapm_supply, "HPCOM", SUN6I_CODEC_OM_PA_CTRL,
 			 SUN6I_CODEC_OM_PA_CTRL_HPCOM_CTL, 0x3, 0x3, 0),
 	SND_SOC_DAPM_OUTPUT("HP"),
+
+	/* Line Out path */
+	SND_SOC_DAPM_MUX("Line Out Source Playback Route",
+			 SND_SOC_NOPM, 0, 0, sun6i_codec_lineout_src),
+	SND_SOC_DAPM_OUTPUT("LINEOUT"),
 };
 
 static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
@@ -880,6 +913,12 @@ static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
 	{ "Headphone Amp", NULL, "Headphone Source Playback Route" },
 	{ "HP", NULL, "Headphone Amp" },
 	{ "HPCOM", NULL, "HPCOM Protection" },
+
+	/* Line Out Routes */
+	{ "Line Out Source Playback Route", "Stereo", "Left Mixer" },
+	{ "Line Out Source Playback Route", "Stereo", "Right Mixer" },
+	{ "Line Out Source Playback Route", "Mono Differential", "Left Mixer" },
+	{ "LINEOUT", NULL, "Line Out Source Playback Route" },
 };
 
 static struct snd_soc_codec_driver sun6i_codec_codec = {
-- 
2.10.2
