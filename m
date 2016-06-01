From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:16 -0700
Subject: [PATCH 17/34] clk: maxgen: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-18-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-max-gen.c | 64 +++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/clk-max-gen.c b/drivers/clk/clk-max-gen.c
index 35af9cb6da4f..4bb53fcf8639 100644
--- a/drivers/clk/clk-max-gen.c
+++ b/drivers/clk/clk-max-gen.c
@@ -40,6 +40,11 @@ struct max_gen_clk {
 	struct clk_hw hw;
 };
 
+struct max_gen_data {
+	size_t num;
+	struct max_gen_clk clks[];
+};
+
 static struct max_gen_clk *to_max_gen_clk(struct clk_hw *hw)
 {
 	return container_of(hw, struct max_gen_clk, hw);
@@ -89,43 +94,48 @@ struct clk_ops max_gen_clk_ops = {
 };
 EXPORT_SYMBOL_GPL(max_gen_clk_ops);
 
-static struct clk *max_gen_clk_register(struct device *dev,
-					struct max_gen_clk *max_gen)
+static int max_gen_clk_register(struct device *dev, struct max_gen_clk *max_gen)
 {
-	struct clk *clk;
 	struct clk_hw *hw = &max_gen->hw;
 	int ret;
 
-	clk = devm_clk_register(dev, hw);
-	if (IS_ERR(clk))
-		return clk;
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
+
+	return clk_hw_register_clkdev(hw, hw->init->name, NULL);
+}
 
-	ret = clk_register_clkdev(clk, hw->init->name, NULL);
+static struct clk_hw *
+of_clk_max_gen_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct max_gen_data *max_gen_data = data;
+	unsigned int idx = clkspec->args[0];
 
-	if (ret)
-		return ERR_PTR(ret);
+	if (idx >= max_gen_data->num) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
 
-	return clk;
+	return &max_gen_data->clks[idx].hw;
 }
 
 int max_gen_clk_probe(struct platform_device *pdev, struct regmap *regmap,
 		      u32 reg, struct clk_init_data *clks_init, int num_init)
 {
 	int i, ret;
+	struct max_gen_data *max_gen_data;
 	struct max_gen_clk *max_gen_clks;
-	struct clk **clocks;
 	struct device *dev = pdev->dev.parent;
 	const char *clk_name;
 	struct clk_init_data *init;
 
-	clocks = devm_kzalloc(dev, sizeof(struct clk *) * num_init, GFP_KERNEL);
-	if (!clocks)
+	max_gen_data = devm_kzalloc(dev, sizeof(*max_gen_data) +
+			sizeof(*max_gen_data->clks) * num_init, GFP_KERNEL);
+	if (!max_gen_data)
 		return -ENOMEM;
 
-	max_gen_clks = devm_kzalloc(dev, sizeof(struct max_gen_clk)
-				    * num_init, GFP_KERNEL);
-	if (!max_gen_clks)
-		return -ENOMEM;
+	max_gen_clks = max_gen_data->clks;
 
 	for (i = 0; i < num_init; i++) {
 		max_gen_clks[i].regmap = regmap;
@@ -149,29 +159,17 @@ int max_gen_clk_probe(struct platform_device *pdev, struct regmap *regmap,
 
 		max_gen_clks[i].hw.init = init;
 
-		clocks[i] = max_gen_clk_register(dev, &max_gen_clks[i]);
-		if (IS_ERR(clocks[i])) {
-			ret = PTR_ERR(clocks[i]);
+		ret = max_gen_clk_register(dev, &max_gen_clks[i]);
+		if (ret) {
 			dev_err(dev, "failed to register %s\n",
 				max_gen_clks[i].hw.init->name);
 			return ret;
 		}
 	}
 
-	platform_set_drvdata(pdev, clocks);
-
 	if (dev->of_node) {
-		struct clk_onecell_data *of_data;
-
-		of_data = devm_kzalloc(dev, sizeof(*of_data), GFP_KERNEL);
-		if (!of_data)
-			return -ENOMEM;
-
-		of_data->clks = clocks;
-		of_data->clk_num = num_init;
-		ret = of_clk_add_provider(dev->of_node, of_clk_src_onecell_get,
-					  of_data);
-
+		ret = of_clk_add_hw_provider(dev->of_node, of_clk_max_gen_get,
+					     max_gen_clks);
 		if (ret) {
 			dev_err(dev, "failed to register OF clock provider\n");
 			return ret;
-- 
2.7.4
