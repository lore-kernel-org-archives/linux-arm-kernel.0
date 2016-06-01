From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:27 -0700
Subject: [PATCH 28/34] clk: si5351: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-29-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-si5351.c | 71 ++++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index b1bc12c045d3..b051db43fae1 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -54,7 +54,6 @@ struct si5351_driver_data {
 	enum si5351_variant	variant;
 	struct i2c_client	*client;
 	struct regmap		*regmap;
-	struct clk_onecell_data onecell;
 
 	struct clk		*pxtal;
 	const char		*pxtal_name;
@@ -66,6 +65,7 @@ struct si5351_driver_data {
 	struct si5351_hw_data	pll[2];
 	struct si5351_hw_data	*msynth;
 	struct si5351_hw_data	*clkout;
+	size_t			num_clkout;
 };
 
 static const char * const si5351_input_names[] = {
@@ -1307,11 +1307,31 @@ put_child:
 	of_node_put(child);
 	return -EINVAL;
 }
+
+static struct clk_hw *
+si53351_of_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct si5351_driver_data *drvdata = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= drvdata->num_clkout) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return &drvdata->clkout[idx].hw;
+}
 #else
 static int si5351_dt_parse(struct i2c_client *client, enum si5351_variant variant)
 {
 	return 0;
 }
+
+static struct clk_hw *
+si53351_of_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	return NULL;
+}
 #endif /* CONFIG_OF */
 
 static int si5351_i2c_probe(struct i2c_client *client,
@@ -1321,7 +1341,6 @@ static int si5351_i2c_probe(struct i2c_client *client,
 	struct si5351_platform_data *pdata;
 	struct si5351_driver_data *drvdata;
 	struct clk_init_data init;
-	struct clk *clk;
 	const char *parent_names[4];
 	u8 num_parents, num_clocks;
 	int ret, n;
@@ -1438,10 +1457,9 @@ static int si5351_i2c_probe(struct i2c_client *client,
 		init.num_parents = 1;
 	}
 	drvdata->xtal.init = &init;
-	clk = devm_clk_register(&client->dev, &drvdata->xtal);
-	if (IS_ERR(clk)) {
+	ret = devm_clk_hw_register(&client->dev, &drvdata->xtal);
+	if (ret) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
-		ret = PTR_ERR(clk);
 		goto err_clk;
 	}
 
@@ -1456,11 +1474,10 @@ static int si5351_i2c_probe(struct i2c_client *client,
 			init.num_parents = 1;
 		}
 		drvdata->clkin.init = &init;
-		clk = devm_clk_register(&client->dev, &drvdata->clkin);
-		if (IS_ERR(clk)) {
+		ret = devm_clk_hw_register(&client->dev, &drvdata->clkin);
+		if (ret) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
-			ret = PTR_ERR(clk);
 			goto err_clk;
 		}
 	}
@@ -1480,10 +1497,9 @@ static int si5351_i2c_probe(struct i2c_client *client,
 	init.flags = 0;
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
-	clk = devm_clk_register(&client->dev, &drvdata->pll[0].hw);
-	if (IS_ERR(clk)) {
+	ret = devm_clk_hw_register(&client->dev, &drvdata->pll[0].hw);
+	if (ret) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
-		ret = PTR_ERR(clk);
 		goto err_clk;
 	}
 
@@ -1505,10 +1521,9 @@ static int si5351_i2c_probe(struct i2c_client *client,
 		init.parent_names = parent_names;
 		init.num_parents = num_parents;
 	}
-	clk = devm_clk_register(&client->dev, &drvdata->pll[1].hw);
-	if (IS_ERR(clk)) {
+	ret = devm_clk_hw_register(&client->dev, &drvdata->pll[1].hw);
+	if (ret) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
-		ret = PTR_ERR(clk);
 		goto err_clk;
 	}
 
@@ -1524,13 +1539,9 @@ static int si5351_i2c_probe(struct i2c_client *client,
 				       sizeof(*drvdata->msynth), GFP_KERNEL);
 	drvdata->clkout = devm_kzalloc(&client->dev, num_clocks *
 				       sizeof(*drvdata->clkout), GFP_KERNEL);
+	drvdata->num_clkout = num_clocks;
 
-	drvdata->onecell.clk_num = num_clocks;
-	drvdata->onecell.clks = devm_kzalloc(&client->dev,
-		num_clocks * sizeof(*drvdata->onecell.clks), GFP_KERNEL);
-
-	if (WARN_ON(!drvdata->msynth || !drvdata->clkout ||
-		    !drvdata->onecell.clks)) {
+	if (WARN_ON(!drvdata->msynth || !drvdata->clkout)) {
 		ret = -ENOMEM;
 		goto err_clk;
 	}
@@ -1547,11 +1558,11 @@ static int si5351_i2c_probe(struct i2c_client *client,
 			init.flags |= CLK_SET_RATE_PARENT;
 		init.parent_names = parent_names;
 		init.num_parents = 2;
-		clk = devm_clk_register(&client->dev, &drvdata->msynth[n].hw);
-		if (IS_ERR(clk)) {
+		ret = devm_clk_hw_register(&client->dev,
+					   &drvdata->msynth[n].hw);
+		if (ret) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
-			ret = PTR_ERR(clk);
 			goto err_clk;
 		}
 	}
@@ -1575,19 +1586,19 @@ static int si5351_i2c_probe(struct i2c_client *client,
 			init.flags |= CLK_SET_RATE_PARENT;
 		init.parent_names = parent_names;
 		init.num_parents = num_parents;
-		clk = devm_clk_register(&client->dev, &drvdata->clkout[n].hw);
-		if (IS_ERR(clk)) {
+		ret = devm_clk_hw_register(&client->dev,
+					   &drvdata->clkout[n].hw);
+		if (ret) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
-			ret = PTR_ERR(clk);
 			goto err_clk;
 		}
-		drvdata->onecell.clks[n] = clk;
 
 		/* set initial clkout rate */
 		if (pdata->clkout[n].rate != 0) {
 			int ret;
-			ret = clk_set_rate(clk, pdata->clkout[n].rate);
+			ret = clk_set_rate(drvdata->clkout[n].hw.clk,
+					   pdata->clkout[n].rate);
 			if (ret != 0) {
 				dev_err(&client->dev, "Cannot set rate : %d\n",
 					ret);
@@ -1595,8 +1606,8 @@ static int si5351_i2c_probe(struct i2c_client *client,
 		}
 	}
 
-	ret = of_clk_add_provider(client->dev.of_node, of_clk_src_onecell_get,
-				  &drvdata->onecell);
+	ret = of_clk_add_hw_provider(client->dev.of_node, si53351_of_clk_get,
+				     drvdata);
 	if (ret) {
 		dev_err(&client->dev, "unable to add clk provider\n");
 		goto err_clk;
-- 
2.7.4
