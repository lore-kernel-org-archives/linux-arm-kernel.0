From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:23 -0700
Subject: [PATCH 24/34] clk: rk808: Migrate to clk_hw based OF and registration
 APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-25-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Chris Zhong <zyw@rock-chips.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-rk808.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
index 74383039761e..f7e0dd181946 100644
--- a/drivers/clk/clk-rk808.c
+++ b/drivers/clk/clk-rk808.c
@@ -26,7 +26,6 @@
 
 struct rk808_clkout {
 	struct rk808 *rk808;
-	struct clk_onecell_data clk_data;
 	struct clk_hw		clkout1_hw;
 	struct clk_hw		clkout2_hw;
 };
@@ -85,14 +84,28 @@ static const struct clk_ops rk808_clkout2_ops = {
 	.recalc_rate = rk808_clkout_recalc_rate,
 };
 
+static struct clk_hw *
+of_clk_rk808_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct rk808_clkout *rk808_clkout = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= 2) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return idx ? &rk808_clkout->clkout2_hw : &rk808_clkout->clkout1_hw;
+}
+
 static int rk808_clkout_probe(struct platform_device *pdev)
 {
 	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
 	struct i2c_client *client = rk808->i2c;
 	struct device_node *node = client->dev.of_node;
 	struct clk_init_data init = {};
-	struct clk **clk_table;
 	struct rk808_clkout *rk808_clkout;
+	int ret;
 
 	rk808_clkout = devm_kzalloc(&client->dev,
 				    sizeof(*rk808_clkout), GFP_KERNEL);
@@ -101,11 +114,6 @@ static int rk808_clkout_probe(struct platform_device *pdev)
 
 	rk808_clkout->rk808 = rk808;
 
-	clk_table = devm_kcalloc(&client->dev, RK808_NR_OUTPUT,
-				 sizeof(struct clk *), GFP_KERNEL);
-	if (!clk_table)
-		return -ENOMEM;
-
 	init.parent_names = NULL;
 	init.num_parents = 0;
 	init.name = "rk808-clkout1";
@@ -116,10 +124,9 @@ static int rk808_clkout_probe(struct platform_device *pdev)
 	of_property_read_string_index(node, "clock-output-names",
 				      0, &init.name);
 
-	clk_table[0] = devm_clk_register(&client->dev,
-					 &rk808_clkout->clkout1_hw);
-	if (IS_ERR(clk_table[0]))
-		return PTR_ERR(clk_table[0]);
+	ret = devm_clk_hw_register(&client->dev, &rk808_clkout->clkout1_hw);
+	if (ret)
+		return ret;
 
 	init.name = "rk808-clkout2";
 	init.ops = &rk808_clkout2_ops;
@@ -129,16 +136,11 @@ static int rk808_clkout_probe(struct platform_device *pdev)
 	of_property_read_string_index(node, "clock-output-names",
 				      1, &init.name);
 
-	clk_table[1] = devm_clk_register(&client->dev,
-					 &rk808_clkout->clkout2_hw);
-	if (IS_ERR(clk_table[1]))
-		return PTR_ERR(clk_table[1]);
-
-	rk808_clkout->clk_data.clks = clk_table;
-	rk808_clkout->clk_data.clk_num = RK808_NR_OUTPUT;
+	ret = devm_clk_hw_register(&client->dev, &rk808_clkout->clkout2_hw);
+	if (ret)
+		return ret;
 
-	return of_clk_add_provider(node, of_clk_src_onecell_get,
-				   &rk808_clkout->clk_data);
+	return of_clk_add_hw_provider(node, of_clk_rk808_get, &rk808_clkout);
 }
 
 static int rk808_clkout_remove(struct platform_device *pdev)
-- 
2.7.4
