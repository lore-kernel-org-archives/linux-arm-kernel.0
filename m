From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:11 -0700
Subject: [PATCH 12/34] clk: cdce925: Migrate to clk_hw based OF and provider
 APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-13-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Mike Looijmans <mike.looijmans@topic.nl>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-cdce925.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index 089bf88ffa8d..b8459c14a1b7 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -62,8 +62,6 @@ struct clk_cdce925_chip {
 	struct i2c_client *i2c_client;
 	struct clk_cdce925_pll pll[NUMBER_OF_PLLS];
 	struct clk_cdce925_output clk[NUMBER_OF_OUTPUTS];
-	struct clk *dt_clk[NUMBER_OF_OUTPUTS];
-	struct clk_onecell_data onecell;
 };
 
 /* ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** ** */
@@ -557,6 +555,20 @@ static int cdce925_regmap_i2c_read(void *context,
 		return -EIO;
 }
 
+static struct clk_hw *
+of_clk_cdce925_get(struct of_phandle_args *clkspec, void *_data)
+{
+	struct clk_cdce925_chip *data = _data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= ARRAY_SIZE(data->clk)) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return &data->clk[idx].hw;
+}
+
 /* The CDCE925 uses a funky way to read/write registers. Bulk mode is
  * just weird, so just use the single byte mode exclusively. */
 static struct regmap_bus regmap_cdce925_bus = {
@@ -572,7 +584,6 @@ static int cdce925_probe(struct i2c_client *client,
 	const char *parent_name;
 	const char *pll_clk_name[NUMBER_OF_PLLS] = {NULL,};
 	struct clk_init_data init;
-	struct clk *clk;
 	u32 value;
 	int i;
 	int err;
@@ -622,10 +633,9 @@ static int cdce925_probe(struct i2c_client *client,
 		data->pll[i].chip = data;
 		data->pll[i].hw.init = &init;
 		data->pll[i].index = i;
-		clk = devm_clk_register(&client->dev, &data->pll[i].hw);
-		if (IS_ERR(clk)) {
+		err = devm_clk_hw_register(&client->dev, &data->pll[i].hw);
+		if (err) {
 			dev_err(&client->dev, "Failed register PLL %d\n", i);
-			err = PTR_ERR(clk);
 			goto error;
 		}
 		sprintf(child_name, "PLL%d", i+1);
@@ -634,7 +644,7 @@ static int cdce925_probe(struct i2c_client *client,
 			continue;
 		if (!of_property_read_u32(np_output,
 			"clock-frequency", &value)) {
-			err = clk_set_rate(clk, value);
+			err = clk_set_rate(data->pll[i].hw.clk, value);
 			if (err)
 				dev_err(&client->dev,
 					"unable to set PLL frequency %ud\n",
@@ -663,14 +673,12 @@ static int cdce925_probe(struct i2c_client *client,
 	data->clk[0].hw.init = &init;
 	data->clk[0].index = 0;
 	data->clk[0].pdiv = 1;
-	clk = devm_clk_register(&client->dev, &data->clk[0].hw);
+	err = devm_clk_hw_register(&client->dev, &data->clk[0].hw);
 	kfree(init.name); /* clock framework made a copy of the name */
-	if (IS_ERR(clk)) {
+	if (err) {
 		dev_err(&client->dev, "clock registration Y1 failed\n");
-		err = PTR_ERR(clk);
 		goto error;
 	}
-	data->dt_clk[0] = clk;
 
 	/* Register output clocks Y2 .. Y5*/
 	init.ops = &cdce925_clk_ops;
@@ -695,21 +703,17 @@ static int cdce925_probe(struct i2c_client *client,
 			init.parent_names = &pll_clk_name[1];
 			break;
 		}
-		clk = devm_clk_register(&client->dev, &data->clk[i].hw);
+		err = devm_clk_hw_register(&client->dev, &data->clk[i].hw);
 		kfree(init.name); /* clock framework made a copy of the name */
-		if (IS_ERR(clk)) {
+		if (err) {
 			dev_err(&client->dev, "clock registration failed\n");
-			err = PTR_ERR(clk);
 			goto error;
 		}
-		data->dt_clk[i] = clk;
 	}
 
 	/* Register the output clocks */
-	data->onecell.clk_num = NUMBER_OF_OUTPUTS;
-	data->onecell.clks = data->dt_clk;
-	err = of_clk_add_provider(client->dev.of_node, of_clk_src_onecell_get,
-		&data->onecell);
+	err = of_clk_add_hw_provider(client->dev.of_node, of_clk_cdce925_get,
+				  data);
 	if (err)
 		dev_err(&client->dev, "unable to add OF clock provider\n");
 
-- 
2.7.4
