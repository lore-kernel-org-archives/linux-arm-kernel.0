From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Apr 2016 15:22:04 -0700
Subject: [PATCH v2 13/13] clk: qcom: Migrate to clk_hw based registration and
 OF APIs
In-Reply-To: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
References: <1461277324-27185-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1461277324-27185-14-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/clk-regmap.c   |  5 ++--
 drivers/clk/qcom/clk-regmap.h   |  3 +--
 drivers/clk/qcom/common.c       | 58 +++++++++++++++++++++++------------------
 drivers/clk/qcom/gcc-msm8996.c  |  9 +++----
 drivers/clk/qcom/mmcc-msm8996.c |  9 +++----
 5 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/qcom/clk-regmap.c b/drivers/clk/qcom/clk-regmap.c
index a58ba39a900c..1c856d330733 100644
--- a/drivers/clk/qcom/clk-regmap.c
+++ b/drivers/clk/qcom/clk-regmap.c
@@ -101,14 +101,13 @@ EXPORT_SYMBOL_GPL(clk_disable_regmap);
  * clk_regmap struct via this function so that the regmap is initialized
  * and so that the clock is registered with the common clock framework.
  */
-struct clk *devm_clk_register_regmap(struct device *dev,
-				     struct clk_regmap *rclk)
+int devm_clk_register_regmap(struct device *dev, struct clk_regmap *rclk)
 {
 	if (dev && dev_get_regmap(dev, NULL))
 		rclk->regmap = dev_get_regmap(dev, NULL);
 	else if (dev && dev->parent)
 		rclk->regmap = dev_get_regmap(dev->parent, NULL);
 
-	return devm_clk_register(dev, &rclk->hw);
+	return devm_clk_hw_register(dev, &rclk->hw);
 }
 EXPORT_SYMBOL_GPL(devm_clk_register_regmap);
diff --git a/drivers/clk/qcom/clk-regmap.h b/drivers/clk/qcom/clk-regmap.h
index 491a63d537df..90d95cd11ec6 100644
--- a/drivers/clk/qcom/clk-regmap.h
+++ b/drivers/clk/qcom/clk-regmap.h
@@ -39,7 +39,6 @@ struct clk_regmap {
 int clk_is_enabled_regmap(struct clk_hw *hw);
 int clk_enable_regmap(struct clk_hw *hw);
 void clk_disable_regmap(struct clk_hw *hw);
-struct clk *
-devm_clk_register_regmap(struct device *dev, struct clk_regmap *rclk);
+int devm_clk_register_regmap(struct device *dev, struct clk_regmap *rclk);
 
 #endif
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index f7c226ab4307..fffcbaf0fba7 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -27,8 +27,8 @@
 
 struct qcom_cc {
 	struct qcom_reset_controller reset;
-	struct clk_onecell_data data;
-	struct clk *clks[];
+	struct clk_regmap **rclks;
+	size_t num_rclks;
 };
 
 const
@@ -102,8 +102,8 @@ static int _qcom_cc_register_board_clk(struct device *dev, const char *path,
 	struct device_node *clocks_node;
 	struct clk_fixed_factor *factor;
 	struct clk_fixed_rate *fixed;
-	struct clk *clk;
 	struct clk_init_data init_data = { };
+	int ret;
 
 	clocks_node = of_find_node_by_path("/clocks");
 	if (clocks_node)
@@ -121,9 +121,9 @@ static int _qcom_cc_register_board_clk(struct device *dev, const char *path,
 		init_data.name = path;
 		init_data.ops = &clk_fixed_rate_ops;
 
-		clk = devm_clk_register(dev, &fixed->hw);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
+		ret = devm_clk_hw_register(dev, &fixed->hw);
+		if (ret)
+			return ret;
 	}
 	of_node_put(node);
 
@@ -141,9 +141,9 @@ static int _qcom_cc_register_board_clk(struct device *dev, const char *path,
 		init_data.flags = 0;
 		init_data.ops = &clk_fixed_factor_ops;
 
-		clk = devm_clk_register(dev, &factor->hw);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
+		ret = devm_clk_hw_register(dev, &factor->hw);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -174,42 +174,48 @@ int qcom_cc_register_sleep_clk(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(qcom_cc_register_sleep_clk);
 
+static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
+					 void *data)
+{
+	struct qcom_cc *cc = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= cc->num_rclks) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return cc->rclks[idx] ? &cc->rclks[idx]->hw : ERR_PTR(-ENOENT);
+}
+
 int qcom_cc_really_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc, struct regmap *regmap)
 {
 	int i, ret;
 	struct device *dev = &pdev->dev;
-	struct clk *clk;
-	struct clk_onecell_data *data;
-	struct clk **clks;
 	struct qcom_reset_controller *reset;
 	struct qcom_cc *cc;
 	struct gdsc_desc *scd;
 	size_t num_clks = desc->num_clks;
 	struct clk_regmap **rclks = desc->clks;
 
-	cc = devm_kzalloc(dev, sizeof(*cc) + sizeof(*clks) * num_clks,
-			  GFP_KERNEL);
+	cc = devm_kzalloc(dev, sizeof(*cc), GFP_KERNEL);
 	if (!cc)
 		return -ENOMEM;
 
-	clks = cc->clks;
-	data = &cc->data;
-	data->clks = clks;
-	data->clk_num = num_clks;
+	cc->rclks = rclks;
+	cc->num_rclks = num_clks;
 
 	for (i = 0; i < num_clks; i++) {
-		if (!rclks[i]) {
-			clks[i] = ERR_PTR(-ENOENT);
+		if (!rclks[i])
 			continue;
-		}
-		clk = devm_clk_register_regmap(dev, rclks[i]);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
-		clks[i] = clk;
+
+		ret = devm_clk_register_regmap(dev, rclks[i]);
+		if (ret)
+			return ret;
 	}
 
-	ret = of_clk_add_provider(dev->of_node, of_clk_src_onecell_get, data);
+	ret = of_clk_add_hw_provider(dev->of_node, qcom_cc_clk_hw_get, cc);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index c9b96f318d9c..7a6fd069ba5d 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -3463,9 +3463,8 @@ MODULE_DEVICE_TABLE(of, gcc_msm8996_match_table);
 
 static int gcc_msm8996_probe(struct platform_device *pdev)
 {
-	struct clk *clk;
 	struct device *dev = &pdev->dev;
-	int i;
+	int i, ret;
 	struct regmap *regmap;
 
 	regmap = qcom_cc_map(pdev, &gcc_msm8996_desc);
@@ -3479,9 +3478,9 @@ static int gcc_msm8996_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x52008, BIT(21), BIT(21));
 
 	for (i = 0; i < ARRAY_SIZE(gcc_msm8996_hws); i++) {
-		clk = devm_clk_register(dev, gcc_msm8996_hws[i]);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
+		ret = devm_clk_hw_register(dev, gcc_msm8996_hws[i]);
+		if (ret)
+			return ret;
 	}
 
 	return qcom_cc_really_probe(pdev, &gcc_msm8996_desc, regmap);
diff --git a/drivers/clk/qcom/mmcc-msm8996.c b/drivers/clk/qcom/mmcc-msm8996.c
index 6df7ff36b416..e21f76817827 100644
--- a/drivers/clk/qcom/mmcc-msm8996.c
+++ b/drivers/clk/qcom/mmcc-msm8996.c
@@ -3337,9 +3337,8 @@ MODULE_DEVICE_TABLE(of, mmcc_msm8996_match_table);
 
 static int mmcc_msm8996_probe(struct platform_device *pdev)
 {
-	struct clk *clk;
 	struct device *dev = &pdev->dev;
-	int i;
+	int i, ret;
 	struct regmap *regmap;
 
 	regmap = qcom_cc_map(pdev, &mmcc_msm8996_desc);
@@ -3352,9 +3351,9 @@ static int mmcc_msm8996_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x5054, BIT(15), 0);
 
 	for (i = 0; i < ARRAY_SIZE(mmcc_msm8996_hws); i++) {
-		clk = devm_clk_register(dev, mmcc_msm8996_hws[i]);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
+		ret = devm_clk_hw_register(dev, mmcc_msm8996_hws[i]);
+		if (ret)
+			return ret;
 	}
 
 	return qcom_cc_really_probe(pdev, &mmcc_msm8996_desc, regmap);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
