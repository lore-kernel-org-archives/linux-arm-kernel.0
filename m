From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Oct 2018 12:53:00 +0100 (BST)
Subject: Applied "ASoC: sun8i-codec: Don't hardcode BCLK / LRCK ratio" to the
 asoc tree
In-Reply-To: <20181017073813.14127-3-anarsoul@gmail.com>
Message-ID: <20181017115300.2BFDB11224C4@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun8i-codec: Don't hardcode BCLK / LRCK ratio

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 13c3bf174becfb8b55adcfeb6f01724dc99347f0 Mon Sep 17 00:00:00 2001
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Wed, 17 Oct 2018 00:38:06 -0700
Subject: [PATCH] ASoC: sun8i-codec: Don't hardcode BCLK / LRCK ratio

BCLK / LRCK ratio should be sample size * channels, but it was
hardcoded to 32 (0x1 is 32 as per A33 and A64 datasheets).

Calculate it basing on sample size and number of channels.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index fb37dd927e33..522a72fde78d 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/log2.h>
 
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -52,7 +53,6 @@
 #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV		13
 #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV		9
 #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV		6
-#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16		(1 << 6)
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ		4
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_16		(1 << 4)
 #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT		2
@@ -300,12 +300,23 @@ static u8 sun8i_codec_get_bclk_div(struct sun8i_codec *scodec,
 	return best_val;
 }
 
+static int sun8i_codec_get_lrck_div(unsigned int channels,
+				    unsigned int word_size)
+{
+	unsigned int div = word_size * channels;
+
+	if (div < 16 || div > 256)
+		return -EINVAL;
+
+	return ilog2(div) - 4;
+}
+
 static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
 	struct sun8i_codec *scodec = snd_soc_component_get_drvdata(dai->component);
-	int sample_rate;
+	int sample_rate, lrck_div;
 	u8 bclk_div;
 
 	/*
@@ -321,9 +332,14 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 			   SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
 			   bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
 
+	lrck_div = sun8i_codec_get_lrck_div(params_channels(params),
+					    params_physical_width(params));
+	if (lrck_div < 0)
+		return lrck_div;
+
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK,
-			   SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16);
+			   lrck_div << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
 
 	sample_rate = sun8i_codec_get_hw_rate(params);
 	if (sample_rate < 0)
-- 
2.19.0.rc2
