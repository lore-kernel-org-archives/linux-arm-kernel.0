From: broonie@kernel.org (Mark Brown)
Date: Thu, 09 Nov 2017 17:44:33 +0000
Subject: Applied "ASoC: sun8i-codec: Set the BCLK divider" to the asoc tree
In-Reply-To: <20171109093924.12803-1-maxime.ripard@free-electrons.com>
Message-ID: <E1eCqsT-0006kU-9P@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun8i-codec: Set the BCLK divider

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

>From 316b7758c998fb13371d14bb6c9e45ab129c19a7 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 9 Nov 2017 10:39:24 +0100
Subject: [PATCH] ASoC: sun8i-codec: Set the BCLK divider

While the current code was reporting to be able to work in master mode, it
failed to do so because the BCLK divider wasn't programmed, meaning that
the BCLK would run at the PLL's frequency no matter the sample rate.

It was obviously a bit too fast.

Add support to retrieve the divider to use, and set it. Since our PLL is
not always able to generate a perfect multiple of the sample rate, we'll
have to choose the closest divider that matches our setup.

Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 038107baf414..50a9e077f01b 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -73,6 +73,7 @@
 #define SUN8I_SYS_SR_CTRL_AIF2_FS_MASK		GENMASK(11, 8)
 #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK	GENMASK(5, 4)
 #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK	GENMASK(8, 6)
+#define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK	GENMASK(12, 9)
 
 struct sun8i_codec {
 	struct device	*dev;
@@ -226,12 +227,57 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+struct sun8i_codec_clk_div {
+	u8	div;
+	u8	val;
+};
+
+static const struct sun8i_codec_clk_div sun8i_codec_bclk_div[] = {
+	{ .div = 1,	.val = 0 },
+	{ .div = 2,	.val = 1 },
+	{ .div = 4,	.val = 2 },
+	{ .div = 6,	.val = 3 },
+	{ .div = 8,	.val = 4 },
+	{ .div = 12,	.val = 5 },
+	{ .div = 16,	.val = 6 },
+	{ .div = 24,	.val = 7 },
+	{ .div = 32,	.val = 8 },
+	{ .div = 48,	.val = 9 },
+	{ .div = 64,	.val = 10 },
+	{ .div = 96,	.val = 11 },
+	{ .div = 128,	.val = 12 },
+	{ .div = 192,	.val = 13 },
+};
+
+static u8 sun8i_codec_get_bclk_div(struct sun8i_codec *scodec,
+				   unsigned int rate,
+				   unsigned int word_size)
+{
+	unsigned long clk_rate = clk_get_rate(scodec->clk_module);
+	unsigned int div = clk_rate / rate / word_size / 2;
+	unsigned int best_val = 0, best_diff = ~0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sun8i_codec_bclk_div); i++) {
+		const struct sun8i_codec_clk_div *bdiv = &sun8i_codec_bclk_div[i];
+		unsigned int diff = abs(bdiv->div - div);
+
+		if (diff < best_diff) {
+			best_diff = diff;
+			best_val = bdiv->val;
+		}
+	}
+
+	return best_val;
+}
+
 static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
 	struct sun8i_codec *scodec = snd_soc_codec_get_drvdata(dai->codec);
 	int sample_rate;
+	u8 bclk_div;
 
 	/*
 	 * The CPU DAI handles only a sample of 16 bits. Configure the
@@ -241,6 +287,11 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 			   SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK,
 			   SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_16);
 
+	bclk_div = sun8i_codec_get_bclk_div(scodec, params_rate(params), 16);
+	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
+			   SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
+			   bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
+
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK,
 			   SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16);
-- 
2.15.0
