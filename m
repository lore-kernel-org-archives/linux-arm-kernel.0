From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  8 Feb 2016 17:45:41 -0800
Subject: [PATCH 14/14] clk: qcom: Migrate to clk_hw based registration and OF
 APIs
In-Reply-To: <1454982341-22715-1-git-send-email-sboyd@codeaurora.org>
References: <1454982341-22715-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1454982341-22715-15-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/clk-regmap.c   |  5 ++---
 drivers/clk/qcom/clk-regmap.h   |  3 +--
 drivers/clk/qcom/common.c       | 41 +++++++++++++++++++----------------------
 drivers/clk/qcom/gcc-msm8996.c  |  9 ++++-----
 drivers/clk/qcom/mmcc-msm8996.c |  9 ++++-----
 5 files changed, 30 insertions(+), 37 deletions(-)

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
index c112ebaba70d..16068af45f5d 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -27,8 +27,7 @@
 
 struct qcom_cc {
 	struct qcom_reset_controller reset;
-	struct clk_onecell_data data;
-	struct clk *clks[];
+	struct clk_hw_onecell_data data;
 };
 
 const
@@ -102,8 +101,8 @@ static int _qcom_cc_register_board_clk(struct device *dev, const char *path,
 	struct device_node *clocks_node;
 	struct clk_fixed_factor *factor;
 	struct clk_fixed_rate *fixed;
-	struct clk *clk;
 	struct clk_init_data init_data = { };
+	int ret;
 
 	clocks_node = of_find_node_by_path("/clocks");
 	if (clocks_node)
@@ -122,9 +121,9 @@ static int _qcom_cc_register_board_clk(struct device *dev, const char *path,
 		init_data.flags = CLK_IS_ROOT;
 		init_data.ops = &clk_fixed_rate_ops;
 
-		clk = devm_clk_register(dev, &fixed->hw);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
+		ret = devm_clk_hw_register(dev, &fixed->hw);
+		if (ret)
+			return ret;
 	}
 	of_node_put(node);
 
@@ -142,9 +141,9 @@ static int _qcom_cc_register_board_clk(struct device *dev, const char *path,
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
@@ -180,36 +179,34 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 {
 	int i, ret;
 	struct device *dev = &pdev->dev;
-	struct clk *clk;
-	struct clk_onecell_data *data;
-	struct clk **clks;
+	struct clk_hw_onecell_data *data;
+	struct clk_hw **hws;
 	struct qcom_reset_controller *reset;
 	struct qcom_cc *cc;
 	size_t num_clks = desc->num_clks;
 	struct clk_regmap **rclks = desc->clks;
 
-	cc = devm_kzalloc(dev, sizeof(*cc) + sizeof(*clks) * num_clks,
+	cc = devm_kzalloc(dev, sizeof(*cc) + sizeof(*hws) * num_clks,
 			  GFP_KERNEL);
 	if (!cc)
 		return -ENOMEM;
 
-	clks = cc->clks;
 	data = &cc->data;
-	data->clks = clks;
-	data->clk_num = num_clks;
+	data->num = num_clks;
+	hws = data->hws;
 
 	for (i = 0; i < num_clks; i++) {
 		if (!rclks[i]) {
-			clks[i] = ERR_PTR(-ENOENT);
+			hws[i] = ERR_PTR(-ENOENT);
 			continue;
 		}
-		clk = devm_clk_register_regmap(dev, rclks[i]);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
-		clks[i] = clk;
+		ret = devm_clk_register_regmap(dev, rclks[i]);
+		if (ret)
+			return ret;
+		hws[i] = &rclks[i]->hw;
 	}
 
-	ret = of_clk_add_provider(dev->of_node, of_clk_src_onecell_get, data);
+	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get, data);
 	if (ret)
 		return ret;
 
diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index 16d7c323db49..2cfd55141896 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -3373,9 +3373,8 @@ MODULE_DEVICE_TABLE(of, gcc_msm8996_match_table);
 
 static int gcc_msm8996_probe(struct platform_device *pdev)
 {
-	struct clk *clk;
 	struct device *dev = &pdev->dev;
-	int i;
+	int i, ret;
 	struct regmap *regmap;
 
 	regmap = qcom_cc_map(pdev, &gcc_msm8996_desc);
@@ -3389,9 +3388,9 @@ static int gcc_msm8996_probe(struct platform_device *pdev)
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
index 064f3eaa39d0..8460daa6c567 100644
--- a/drivers/clk/qcom/mmcc-msm8996.c
+++ b/drivers/clk/qcom/mmcc-msm8996.c
@@ -3180,9 +3180,8 @@ MODULE_DEVICE_TABLE(of, mmcc_msm8996_match_table);
 
 static int mmcc_msm8996_probe(struct platform_device *pdev)
 {
-	struct clk *clk;
 	struct device *dev = &pdev->dev;
-	int i;
+	int i, ret;
 	struct regmap *regmap;
 
 	regmap = qcom_cc_map(pdev, &mmcc_msm8996_desc);
@@ -3195,9 +3194,9 @@ static int mmcc_msm8996_probe(struct platform_device *pdev)
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
