From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Mar 2017 18:13:00 +0000
Subject: Applied "ASoC: sun8i-codec: Convert to use SND_SOC_DAPM_AIF_IN" to
 the asoc tree
In-Reply-To: <20170309095602.13809-3-mylene.josserand@free-electrons.com>
Message-ID: <E1coDPw-000246-Bz@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun8i-codec: Convert to use SND_SOC_DAPM_AIF_IN

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

>From 9123aa8645463ca30ac8c62a07eb23e07c3aa091 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
 <mylene.josserand@free-electrons.com>
Date: Thu, 9 Mar 2017 10:56:01 +0100
Subject: [PATCH] ASoC: sun8i-codec: Convert to use SND_SOC_DAPM_AIF_IN
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the driver to use SND_SOC_DAPM_AIF_IN instead of
SND_SOC_DAPM_DAC.
Rename the interface's widgets to be more precise on which slot
the interface is connected.

Signed-off-by: Myl??ne Josserand <mylene.josserand@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 90cda9569503..5723c3404f6b 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -281,11 +281,13 @@ static const struct snd_soc_dapm_widget sun8i_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("DAC", SUN8I_DAC_DIG_CTRL, SUN8I_DAC_DIG_CTRL_ENDA,
 			    0, NULL, 0),
 
-	/* Analog DAC */
-	SND_SOC_DAPM_DAC("Digital Left DAC", "Playback", SUN8I_AIF1_DACDAT_CTRL,
-			 SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA, 0),
-	SND_SOC_DAPM_DAC("Digital Right DAC", "Playback", SUN8I_AIF1_DACDAT_CTRL,
-			 SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA, 0),
+	/* Analog DAC AIF */
+	SND_SOC_DAPM_AIF_IN("AIF1 Slot 0 Left", "Playback", 0,
+			    SUN8I_AIF1_DACDAT_CTRL,
+			    SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA, 0),
+	SND_SOC_DAPM_AIF_IN("AIF1 Slot 0 Right", "Playback", 0,
+			    SUN8I_AIF1_DACDAT_CTRL,
+			    SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA, 0),
 
 	/* DAC Mixers */
 	SOC_MIXER_ARRAY("Left Digital DAC Mixer", SND_SOC_NOPM, 0, 0,
@@ -329,14 +331,14 @@ static const struct snd_soc_dapm_route sun8i_codec_dapm_routes[] = {
 	{ "DAC", NULL, "MODCLK DAC" },
 
 	/* DAC Routes */
-	{ "Digital Left DAC", NULL, "DAC" },
-	{ "Digital Right DAC", NULL, "DAC" },
+	{ "AIF1 Slot 0 Right", NULL, "DAC" },
+	{ "AIF1 Slot 0 Left", NULL, "DAC" },
 
 	/* DAC Mixer Routes */
 	{ "Left Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
-	  "Digital Left DAC"},
+	  "AIF1 Slot 0 Left"},
 	{ "Right Digital DAC Mixer", "AIF1 Slot 0 Digital DAC Playback Switch",
-	  "Digital Right DAC"},
+	  "AIF1 Slot 0 Right"},
 };
 
 static struct snd_soc_dai_ops sun8i_codec_dai_ops = {
-- 
2.11.0
