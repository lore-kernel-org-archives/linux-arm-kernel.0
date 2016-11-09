From: broonie@kernel.org (Mark Brown)
Date: Wed, 09 Nov 2016 14:59:36 +0000
Subject: Applied "ASoC: sunxi: i2s: Implement set_sysclk" to the asoc tree
In-Reply-To: <e86d676f28ff62bc0a56741f76afb2cbdfedbdd8.1478524066.git-series.maxime.ripard@free-electrons.com>
Message-ID: <E1c4ULg-0002gc-Hx@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sunxi: i2s: Implement set_sysclk

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

>From b2b7b56f713ab833413548b119c53bbe2a9a9f8f Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 7 Nov 2016 14:08:19 +0100
Subject: [PATCH] ASoC: sunxi: i2s: Implement set_sysclk

In our i2s driver, we were previously trying to guess which oversample the
user wanted to use by looking at the rate and trying to max it.

However, the cards, and especially simple-card with its mclk-fs property
will already provide the expected oversample ratio by using the set_sysclk
callback.

We can thus implement it and remove the logic to deal with the runtime
guess.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 53 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a7653114e895..f24d19526603 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -93,6 +93,8 @@ struct sun4i_i2s {
 	struct clk	*mod_clk;
 	struct regmap	*regmap;
 
+	unsigned int	mclk_freq;
+
 	struct snd_dmaengine_dai_dma_data	capture_dma_data;
 	struct snd_dmaengine_dai_dma_data	playback_dma_data;
 };
@@ -158,14 +160,24 @@ static int sun4i_i2s_get_mclk_div(struct sun4i_i2s *i2s,
 }
 
 static int sun4i_i2s_oversample_rates[] = { 128, 192, 256, 384, 512, 768 };
+static bool sun4i_i2s_oversample_is_valid(unsigned int oversample)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sun4i_i2s_oversample_rates); i++)
+		if (sun4i_i2s_oversample_rates[i] == oversample)
+			return true;
+
+	return false;
+}
 
 static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
 				  unsigned int rate,
 				  unsigned int word_size)
 {
-	unsigned int clk_rate;
+	unsigned int oversample_rate, clk_rate;
 	int bclk_div, mclk_div;
-	int ret, i;
+	int ret;
 
 	switch (rate) {
 	case 176400:
@@ -197,21 +209,18 @@ static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
 	if (ret)
 		return ret;
 
-	/* Always favor the highest oversampling rate */
-	for (i = (ARRAY_SIZE(sun4i_i2s_oversample_rates) - 1); i >= 0; i--) {
-		unsigned int oversample_rate = sun4i_i2s_oversample_rates[i];
-
-		bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
-						  word_size);
-		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
-						  clk_rate,
-						  rate);
+	oversample_rate = i2s->mclk_freq / rate;
+	if (!sun4i_i2s_oversample_is_valid(oversample_rate))
+		return -EINVAL;
 
-		if ((bclk_div >= 0) && (mclk_div >= 0))
-			break;
-	}
+	bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
+					  word_size);
+	if (bclk_div < 0)
+		return -EINVAL;
 
-	if ((bclk_div < 0) || (mclk_div < 0))
+	mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
+					  clk_rate, rate);
+	if (mclk_div < 0)
 		return -EINVAL;
 
 	regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
@@ -481,9 +490,23 @@ static void sun4i_i2s_shutdown(struct snd_pcm_substream *substream,
 	regmap_write(i2s->regmap, SUN4I_I2S_CTRL_REG, 0);
 }
 
+static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+				unsigned int freq, int dir)
+{
+	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
+
+	if (clk_id != 0)
+		return -EINVAL;
+
+	i2s->mclk_freq = freq;
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
 	.hw_params	= sun4i_i2s_hw_params,
 	.set_fmt	= sun4i_i2s_set_fmt,
+	.set_sysclk	= sun4i_i2s_set_sysclk,
 	.shutdown	= sun4i_i2s_shutdown,
 	.startup	= sun4i_i2s_startup,
 	.trigger	= sun4i_i2s_trigger,
-- 
2.10.2
