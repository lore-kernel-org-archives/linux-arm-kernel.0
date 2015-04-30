From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 30 Apr 2015 19:45:53 +0200
Subject: [PATCH 3/4] clk: si5351: Do not pass struct clk in platform_data
In-Reply-To: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1430415954-29517-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1430415954-29517-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When registering clk-si5351 by platform_data, we should not pass struct clk
for the reference clocks. Drop struct clk from platform_data and rework the
driver to use devm_clk_get of named clock references.

While at it, check for at least one valid input clock and properly prepare/
enable valid reference clocks.

Reported-by: Michael Welling <mwelling@ieee.org>
Reported-by: Jean-Francois Moine <moinejf@free.fr>
Reported-by: Russell King <rmk+linux@arm.linux.org.uk>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: Michael Welling <mwelling@ieee.org>
Cc: Russell King <rmk+linux@arm.linux.org.uk>
Cc: linux-clk at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/clk/clk-si5351.c             | 58 +++++++++++++++++++++++++-----------
 include/linux/platform_data/si5351.h |  4 ---
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 44ea107cfc67..beeb57bbb04c 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -1128,13 +1128,6 @@ static int si5351_dt_parse(struct i2c_client *client,
 	if (!pdata)
 		return -ENOMEM;
 
-	pdata->clk_xtal = of_clk_get(np, 0);
-	if (!IS_ERR(pdata->clk_xtal))
-		clk_put(pdata->clk_xtal);
-	pdata->clk_clkin = of_clk_get(np, 1);
-	if (!IS_ERR(pdata->clk_clkin))
-		clk_put(pdata->clk_clkin);
-
 	/*
 	 * property silabs,pll-source : <num src>, [<..>]
 	 * allow to selectively set pll source
@@ -1328,8 +1321,17 @@ static int si5351_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, drvdata);
 	drvdata->client = client;
 	drvdata->variant = variant;
-	drvdata->pxtal = pdata->clk_xtal;
-	drvdata->pclkin = pdata->clk_clkin;
+	drvdata->pxtal = devm_clk_get(&client->dev, "xtal");
+	drvdata->pclkin = devm_clk_get(&client->dev, "clkin");
+
+	if (PTR_ERR(drvdata->pxtal) == -EPROBE_DEFER ||
+	    PTR_ERR(drvdata->pclkin) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	if (IS_ERR(drvdata->pxtal) && IS_ERR(drvdata->pclkin)) {
+		dev_err(&client->dev, "missing at least one parent clock\n");
+		return -EINVAL;
+	}
 
 	drvdata->regmap = devm_regmap_init_i2c(client, &si5351_regmap_config);
 	if (IS_ERR(drvdata->regmap)) {
@@ -1393,6 +1395,11 @@ static int si5351_i2c_probe(struct i2c_client *client,
 		}
 	}
 
+	if (!IS_ERR(drvdata->pxtal))
+		clk_prepare_enable(drvdata->pxtal);
+	if (!IS_ERR(drvdata->pclkin))
+		clk_prepare_enable(drvdata->pclkin);
+
 	/* register xtal input clock gate */
 	memset(&init, 0, sizeof(init));
 	init.name = si5351_input_names[0];
@@ -1407,7 +1414,8 @@ static int si5351_i2c_probe(struct i2c_client *client,
 	clk = devm_clk_register(&client->dev, &drvdata->xtal);
 	if (IS_ERR(clk)) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
-		return PTR_ERR(clk);
+		ret = PTR_ERR(clk);
+		goto err_clk;
 	}
 
 	/* register clkin input clock gate */
@@ -1425,7 +1433,8 @@ static int si5351_i2c_probe(struct i2c_client *client,
 		if (IS_ERR(clk)) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
-			return PTR_ERR(clk);
+			ret = PTR_ERR(clk);
+			goto err_clk;
 		}
 	}
 
@@ -1447,7 +1456,8 @@ static int si5351_i2c_probe(struct i2c_client *client,
 	clk = devm_clk_register(&client->dev, &drvdata->pll[0].hw);
 	if (IS_ERR(clk)) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
-		return -EINVAL;
+		ret = PTR_ERR(clk);
+		goto err_clk;
 	}
 
 	/* register PLLB or VXCO (Si5351B) */
@@ -1471,7 +1481,8 @@ static int si5351_i2c_probe(struct i2c_client *client,
 	clk = devm_clk_register(&client->dev, &drvdata->pll[1].hw);
 	if (IS_ERR(clk)) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
-		return -EINVAL;
+		ret = PTR_ERR(clk);
+		goto err_clk;
 	}
 
 	/* register clk multisync and clk out divider */
@@ -1492,8 +1503,10 @@ static int si5351_i2c_probe(struct i2c_client *client,
 		num_clocks * sizeof(*drvdata->onecell.clks), GFP_KERNEL);
 
 	if (WARN_ON(!drvdata->msynth || !drvdata->clkout ||
-		    !drvdata->onecell.clks))
-		return -ENOMEM;
+		    !drvdata->onecell.clks)) {
+		ret = -ENOMEM;
+		goto err_clk;
+	}
 
 	for (n = 0; n < num_clocks; n++) {
 		drvdata->msynth[n].num = n;
@@ -1511,7 +1524,8 @@ static int si5351_i2c_probe(struct i2c_client *client,
 		if (IS_ERR(clk)) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
-			return -EINVAL;
+			ret = PTR_ERR(clk);
+			goto err_clk;
 		}
 	}
 
@@ -1538,7 +1552,8 @@ static int si5351_i2c_probe(struct i2c_client *client,
 		if (IS_ERR(clk)) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
-			return -EINVAL;
+			ret = PTR_ERR(clk);
+			goto err_clk;
 		}
 		drvdata->onecell.clks[n] = clk;
 
@@ -1557,10 +1572,17 @@ static int si5351_i2c_probe(struct i2c_client *client,
 				  &drvdata->onecell);
 	if (ret) {
 		dev_err(&client->dev, "unable to add clk provider\n");
-		return ret;
+		goto err_clk;
 	}
 
 	return 0;
+
+err_clk:
+	if (!IS_ERR(drvdata->pxtal))
+		clk_disable_unprepare(drvdata->pxtal);
+	if (!IS_ERR(drvdata->pclkin))
+		clk_disable_unprepare(drvdata->pclkin);
+	return ret;
 }
 
 static const struct i2c_device_id si5351_i2c_ids[] = {
diff --git a/include/linux/platform_data/si5351.h b/include/linux/platform_data/si5351.h
index a947ab8b441a..533d9807e543 100644
--- a/include/linux/platform_data/si5351.h
+++ b/include/linux/platform_data/si5351.h
@@ -5,8 +5,6 @@
 #ifndef __LINUX_PLATFORM_DATA_SI5351_H__
 #define __LINUX_PLATFORM_DATA_SI5351_H__
 
-struct clk;
-
 /**
  * enum si5351_pll_src - Si5351 pll clock source
  * @SI5351_PLL_SRC_DEFAULT: default, do not change eeprom config
@@ -107,8 +105,6 @@ struct si5351_clkout_config {
  * @clkout: array of clkout configuration
  */
 struct si5351_platform_data {
-	struct clk *clk_xtal;
-	struct clk *clk_clkin;
 	enum si5351_pll_src pll_src[2];
 	struct si5351_clkout_config clkout[8];
 };
-- 
2.1.0
