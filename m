From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:09 -0700
Subject: [PATCH 10/34] clk: axm5516: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-11-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs. Make thing simple by using the
existing clk_hw array and implementing a custom DT clk provider
get function to map the clk spec id to a clk_hw pointer.

Cc: Anders Berg <anders.berg@lsi.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-axm5516.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/clk-axm5516.c b/drivers/clk/clk-axm5516.c
index c7c91a5ecf8b..5d7ae333257e 100644
--- a/drivers/clk/clk-axm5516.c
+++ b/drivers/clk/clk-axm5516.c
@@ -516,6 +516,19 @@ static struct axxia_clk *axmclk_clocks[] = {
 	[AXXIA_CLK_MMC]      = &clk_mmc_mux.aclk,
 };
 
+static struct clk_hw *
+of_clk_axmclk_get(struct of_phandle_args *clkspec, void *unused)
+{
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= ARRAY_SIZE(axmclk_clocks)) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return &axmclk_clocks[idx]->hw;
+}
+
 static const struct regmap_config axmclk_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -530,21 +543,14 @@ static const struct of_device_id axmclk_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, axmclk_match_table);
 
-struct axmclk_priv {
-	struct clk_onecell_data onecell;
-	struct clk *clks[];
-};
-
 static int axmclk_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
 	struct resource *res;
 	int i, ret;
 	struct device *dev = &pdev->dev;
-	struct clk *clk;
 	struct regmap *regmap;
 	size_t num_clks;
-	struct axmclk_priv *priv;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
@@ -557,29 +563,18 @@ static int axmclk_probe(struct platform_device *pdev)
 
 	num_clks = ARRAY_SIZE(axmclk_clocks);
 	pr_info("axmclk: supporting %zu clocks\n", num_clks);
-	priv = devm_kzalloc(dev, sizeof(*priv) + sizeof(*priv->clks) * num_clks,
-			    GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->onecell.clks = priv->clks;
-	priv->onecell.clk_num = num_clks;
 
 	/* Update each entry with the allocated regmap and register the clock
 	 * with the common clock framework
 	 */
 	for (i = 0; i < num_clks; i++) {
 		axmclk_clocks[i]->regmap = regmap;
-		clk = devm_clk_register(dev, &axmclk_clocks[i]->hw);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
-		priv->clks[i] = clk;
+		ret = devm_clk_hw_register(dev, &axmclk_clocks[i]->hw);
+		if (ret)
+			return ret;
 	}
 
-	ret = of_clk_add_provider(dev->of_node,
-				  of_clk_src_onecell_get, &priv->onecell);
-
-	return ret;
+	return of_clk_add_hw_provider(dev->of_node, of_clk_axmclk_get, NULL);
 }
 
 static int axmclk_remove(struct platform_device *pdev)
-- 
2.7.4
