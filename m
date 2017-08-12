From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 12 Aug 2017 13:00:50 +0200
Subject: [PATCH v3 02/11] ASoC: sun4i-i2s: Add regmap config to quirks
In-Reply-To: <20170812110059.5115-1-codekipper@gmail.com>
References: <20170812110059.5115-1-codekipper@gmail.com>
Message-ID: <20170812110059.5115-3-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The newer SoCs have a larger range than the original SoC that this
driver was developed for. By adding the regmap config to the quirks
then the driver can initialise the managed register map correctly.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
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
2.14.1
