From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Aug 2017 17:43:22 +0100
Subject: Applied "ASoC: sun4i-i2s: Add clkdiv offsets to quirks" to the asoc
 tree
In-Reply-To: <20170812110059.5115-2-codekipper@gmail.com>
Message-ID: <E1dhISY-0005FW-Ry@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-i2s: Add clkdiv offsets to quirks

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

>From 0aef27cab880d9612331350c008aec00cbb3d247 Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper@gmail.com>
Date: Sat, 12 Aug 2017 13:00:49 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Add clkdiv offsets to quirks

The BCLKDIV and MCLKDIV found on newer SoCs start from an offset of 1.
Add the functionality to adjust the division values according to the
needs to the device being used.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d7ee7a443e4e..9a35313c4f9b 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -94,9 +94,13 @@
  * struct sun4i_i2s_quirks - Differences between SoC variants.
  *
  * @has_reset: SoC needs reset deasserted.
+ * @mclk_offset: Value by which mclkdiv needs to be adjusted.
+ * @bclk_offset: Value by which bclkdiv needs to be adjusted.
  */
 struct sun4i_i2s_quirks {
 	bool				has_reset;
+	unsigned int			mclk_offset;
+	unsigned int			bclk_offset;
 };
 
 struct sun4i_i2s {
@@ -237,6 +241,10 @@ static int sun4i_i2s_set_clk_rate(struct sun4i_i2s *i2s,
 	if (mclk_div < 0)
 		return -EINVAL;
 
+	/* Adjust the clock division values if needed */
+	bclk_div += i2s->variant->bclk_offset;
+	mclk_div += i2s->variant->mclk_offset;
+
 	regmap_write(i2s->regmap, SUN4I_I2S_CLK_DIV_REG,
 		     SUN4I_I2S_CLK_DIV_BCLK(bclk_div) |
 		     SUN4I_I2S_CLK_DIV_MCLK(mclk_div) |
-- 
2.13.2
