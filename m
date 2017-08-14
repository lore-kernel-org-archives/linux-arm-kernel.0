From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Aug 2017 17:43:09 +0100
Subject: Applied "ASoC: sun4i-i2s: Add regmap config to quirks" to the asoc
 tree
In-Reply-To: <20170729141753.20174-4-codekipper@gmail.com>
Message-ID: <E1dhISL-0005EA-9q@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-i2s: Add regmap config to quirks

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

>From cd1c63df5fa8196d8ed5138f1ecc22bbabf5f6df Mon Sep 17 00:00:00 2001
From: Marcus Cooper <codekipper@gmail.com>
Date: Sat, 12 Aug 2017 13:00:50 +0200
Subject: [PATCH] ASoC: sun4i-i2s: Add regmap config to quirks

The newer SoCs have a larger range than the original SoC that this
driver was developed for. By adding the regmap config to the quirks
then the driver can initialise the managed register map correctly.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9a35313c4f9b..f6f3c409f25e 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -94,11 +94,13 @@
  * struct sun4i_i2s_quirks - Differences between SoC variants.
  *
  * @has_reset: SoC needs reset deasserted.
+ * @sun4i_i2s_regmap: regmap config to use.
  * @mclk_offset: Value by which mclkdiv needs to be adjusted.
  * @bclk_offset: Value by which bclkdiv needs to be adjusted.
  */
 struct sun4i_i2s_quirks {
 	bool				has_reset;
+	const struct regmap_config	*sun4i_i2s_regmap;
 	unsigned int			mclk_offset;
 	unsigned int			bclk_offset;
 };
@@ -674,11 +676,13 @@ static int sun4i_i2s_runtime_suspend(struct device *dev)
 }
 
 static const struct sun4i_i2s_quirks sun4i_a10_i2s_quirks = {
-	.has_reset	= false,
+	.has_reset		= false,
+	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
 };
 
 static const struct sun4i_i2s_quirks sun6i_a31_i2s_quirks = {
-	.has_reset	= true,
+	.has_reset		= true,
+	.sun4i_i2s_regmap	= &sun4i_i2s_regmap_config,
 };
 
 static int sun4i_i2s_probe(struct platform_device *pdev)
@@ -717,7 +721,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 	}
 
 	i2s->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
-					    &sun4i_i2s_regmap_config);
+					    i2s->variant->sun4i_i2s_regmap);
 	if (IS_ERR(i2s->regmap)) {
 		dev_err(&pdev->dev, "Regmap initialisation failed\n");
 		return PTR_ERR(i2s->regmap);
-- 
2.13.2
