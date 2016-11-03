From: broonie@kernel.org (Mark Brown)
Date: Thu, 03 Nov 2016 14:33:32 -0600
Subject: Applied "ASoC: sun4i-codec: Add support for A31 Line In playback" to
 the asoc tree
In-Reply-To: <20161003110804.28235-7-wens@csie.org>
Message-ID: <E1c2OhY-0004Mo-Sk@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-codec: Add support for A31 Line In playback

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

>From dff5051250674fce575fa36c22b2f007363e42d0 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 3 Nov 2016 15:55:49 +0800
Subject: [PATCH] ASoC: sun4i-codec: Add support for A31 Line In playback

The A31 integrated codec has a stereo "Line In" input. Add support for
it to the playback paths.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index d4b2186b5d84..72a84f76aa57 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -772,6 +772,10 @@ static const struct snd_kcontrol_new sun6i_codec_mixer_controls[] = {
 			SUN6I_CODEC_OM_DACA_CTRL,
 			SUN6I_CODEC_OM_DACA_CTRL_LMIX_DACR,
 			SUN6I_CODEC_OM_DACA_CTRL_RMIX_DACL, 1, 0),
+	SOC_DAPM_DOUBLE("Line In Playback Switch",
+			SUN6I_CODEC_OM_DACA_CTRL,
+			SUN6I_CODEC_OM_DACA_CTRL_LMIX_LINEINL,
+			SUN6I_CODEC_OM_DACA_CTRL_RMIX_LINEINR, 1, 0),
 };
 
 /* headphone controls */
@@ -793,6 +797,8 @@ static const struct snd_kcontrol_new sun6i_codec_hp_src[] = {
 /* volume / mute controls */
 static const DECLARE_TLV_DB_SCALE(sun6i_codec_dvol_scale, -7308, 116, 0);
 static const DECLARE_TLV_DB_SCALE(sun6i_codec_hp_vol_scale, -6300, 100, 1);
+static const DECLARE_TLV_DB_SCALE(sun6i_codec_out_mixer_pregain_scale,
+				  -450, 150, 0);
 
 static const struct snd_kcontrol_new sun6i_codec_codec_widgets[] = {
 	SOC_SINGLE_TLV("DAC Playback Volume", SUN4I_CODEC_DAC_DPC,
@@ -806,9 +812,16 @@ static const struct snd_kcontrol_new sun6i_codec_codec_widgets[] = {
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
@@ -850,10 +863,12 @@ static const struct snd_soc_dapm_route sun6i_codec_codec_dapm_routes[] = {
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
2.10.1
