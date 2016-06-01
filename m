From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:25 -0700
Subject: [PATCH 26/34] clk: scpi: Migrate to clk_hw based OF and registration
 APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-27-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-scpi.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
index 6962ee5d1e9a..2a3e9d8e88b0 100644
--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -146,13 +146,13 @@ static const struct of_device_id scpi_clk_match[] = {
 	{}
 };
 
-static struct clk *
+static int
 scpi_clk_ops_init(struct device *dev, const struct of_device_id *match,
 		  struct scpi_clk *sclk, const char *name)
 {
 	struct clk_init_data init;
-	struct clk *clk;
 	unsigned long min = 0, max = 0;
+	int ret;
 
 	init.name = name;
 	init.flags = 0;
@@ -164,18 +164,18 @@ scpi_clk_ops_init(struct device *dev, const struct of_device_id *match,
 	if (init.ops == &scpi_dvfs_ops) {
 		sclk->info = sclk->scpi_ops->dvfs_get_info(sclk->id);
 		if (IS_ERR(sclk->info))
-			return NULL;
+			return PTR_ERR(sclk->info);
 	} else if (init.ops == &scpi_clk_ops) {
 		if (sclk->scpi_ops->clk_get_range(sclk->id, &min, &max) || !max)
-			return NULL;
+			return -EINVAL;
 	} else {
-		return NULL;
+		return -EINVAL;
 	}
 
-	clk = devm_clk_register(dev, &sclk->hw);
-	if (!IS_ERR(clk) && max)
+	ret = devm_clk_hw_register(dev, &sclk->hw);
+	if (!ret && max)
 		clk_hw_set_rate_range(&sclk->hw, min, max);
-	return clk;
+	return ret;
 }
 
 struct scpi_clk_data {
@@ -183,7 +183,7 @@ struct scpi_clk_data {
 	unsigned int clk_num;
 };
 
-static struct clk *
+static struct clk_hw *
 scpi_of_clk_src_get(struct of_phandle_args *clkspec, void *data)
 {
 	struct scpi_clk *sclk;
@@ -193,7 +193,7 @@ scpi_of_clk_src_get(struct of_phandle_args *clkspec, void *data)
 	for (count = 0; count < clk_data->clk_num; count++) {
 		sclk = clk_data->clk[count];
 		if (idx == sclk->id)
-			return sclk->hw.clk;
+			return &sclk->hw;
 	}
 
 	return ERR_PTR(-EINVAL);
@@ -202,8 +202,7 @@ scpi_of_clk_src_get(struct of_phandle_args *clkspec, void *data)
 static int scpi_clk_add(struct device *dev, struct device_node *np,
 			const struct of_device_id *match)
 {
-	struct clk **clks;
-	int idx, count;
+	int idx, count, err;
 	struct scpi_clk_data *clk_data;
 
 	count = of_property_count_strings(np, "clock-output-names");
@@ -222,10 +221,6 @@ static int scpi_clk_add(struct device *dev, struct device_node *np,
 	if (!clk_data->clk)
 		return -ENOMEM;
 
-	clks = devm_kcalloc(dev, count, sizeof(*clks), GFP_KERNEL);
-	if (!clks)
-		return -ENOMEM;
-
 	for (idx = 0; idx < count; idx++) {
 		struct scpi_clk *sclk;
 		const char *name;
@@ -249,15 +244,15 @@ static int scpi_clk_add(struct device *dev, struct device_node *np,
 
 		sclk->id = val;
 
-		clks[idx] = scpi_clk_ops_init(dev, match, sclk, name);
-		if (IS_ERR_OR_NULL(clks[idx]))
+		err = scpi_clk_ops_init(dev, match, sclk, name);
+		if (err)
 			dev_err(dev, "failed to register clock '%s'\n", name);
 		else
 			dev_dbg(dev, "Registered clock '%s'\n", name);
 		clk_data->clk[idx] = sclk;
 	}
 
-	return of_clk_add_provider(np, scpi_of_clk_src_get, clk_data);
+	return of_clk_add_hw_provider(np, scpi_of_clk_src_get, clk_data);
 }
 
 static int scpi_clocks_remove(struct platform_device *pdev)
-- 
2.7.4
