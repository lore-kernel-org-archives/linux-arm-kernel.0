From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:10 -0700
Subject: [PATCH 11/34] clk: cdce: Migrate to clk_hw based OF and registration
 APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-12-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-cdce706.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/clk-cdce706.c b/drivers/clk/clk-cdce706.c
index 01877f64eff6..f21d9092564f 100644
--- a/drivers/clk/clk-cdce706.c
+++ b/drivers/clk/clk-cdce706.c
@@ -71,7 +71,6 @@ struct cdce706_hw_data {
 	struct cdce706_dev_data *dev_data;
 	unsigned idx;
 	unsigned parent;
-	struct clk *clk;
 	struct clk_hw hw;
 	unsigned div;
 	unsigned mul;
@@ -81,8 +80,6 @@ struct cdce706_hw_data {
 struct cdce706_dev_data {
 	struct i2c_client *client;
 	struct regmap *regmap;
-	struct clk_onecell_data onecell;
-	struct clk *clks[6];
 	struct clk *clkin_clk[2];
 	const char *clkin_name[2];
 	struct cdce706_hw_data clkin[1];
@@ -455,18 +452,19 @@ static int cdce706_register_hw(struct cdce706_dev_data *cdce,
 			       struct clk_init_data *init)
 {
 	unsigned i;
+	int ret;
 
 	for (i = 0; i < num_hw; ++i, ++hw) {
 		init->name = clk_names[i];
 		hw->dev_data = cdce;
 		hw->idx = i;
 		hw->hw.init = init;
-		hw->clk = devm_clk_register(&cdce->client->dev,
+		ret = devm_clk_hw_register(&cdce->client->dev,
 					    &hw->hw);
-		if (IS_ERR(hw->clk)) {
+		if (ret) {
 			dev_err(&cdce->client->dev, "Failed to register %s\n",
 				clk_names[i]);
-			return PTR_ERR(hw->clk);
+			return ret;
 		}
 	}
 	return 0;
@@ -613,13 +611,23 @@ static int cdce706_register_clkouts(struct cdce706_dev_data *cdce)
 			cdce->clkout[i].parent);
 	}
 
-	ret = cdce706_register_hw(cdce, cdce->clkout,
-				  ARRAY_SIZE(cdce->clkout),
-				  cdce706_clkout_name, &init);
-	for (i = 0; i < ARRAY_SIZE(cdce->clkout); ++i)
-		cdce->clks[i] = cdce->clkout[i].clk;
+	return cdce706_register_hw(cdce, cdce->clkout,
+				   ARRAY_SIZE(cdce->clkout),
+				   cdce706_clkout_name, &init);
+}
 
-	return ret;
+static struct clk_hw *
+of_clk_cdce_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct cdce706_dev_data *cdce = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= ARRAY_SIZE(cdce->clkout)) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return &cdce->clkout[idx].hw;
 }
 
 static int cdce706_probe(struct i2c_client *client,
@@ -657,12 +665,8 @@ static int cdce706_probe(struct i2c_client *client,
 	ret = cdce706_register_clkouts(cdce);
 	if (ret < 0)
 		return ret;
-	cdce->onecell.clks = cdce->clks;
-	cdce->onecell.clk_num = ARRAY_SIZE(cdce->clks);
-	ret = of_clk_add_provider(client->dev.of_node, of_clk_src_onecell_get,
-				  &cdce->onecell);
-
-	return ret;
+	return of_clk_add_hw_provider(client->dev.of_node, of_clk_cdce_get,
+				      cdce);
 }
 
 static int cdce706_remove(struct i2c_client *client)
-- 
2.7.4
