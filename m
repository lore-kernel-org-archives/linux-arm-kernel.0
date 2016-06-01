From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:21 -0700
Subject: [PATCH 22/34] clk: palmas: Migrate to clk_hw based OF and
 registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-23-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-palmas.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk-palmas.c b/drivers/clk/clk-palmas.c
index 8328863cb0e0..31f590cea493 100644
--- a/drivers/clk/clk-palmas.c
+++ b/drivers/clk/clk-palmas.c
@@ -41,7 +41,6 @@ struct palmas_clk32k_desc {
 
 struct palmas_clock_info {
 	struct device *dev;
-	struct clk *clk;
 	struct clk_hw hw;
 	struct palmas *palmas;
 	const struct palmas_clk32k_desc *clk_desc;
@@ -218,7 +217,7 @@ static int palmas_clks_init_configure(struct palmas_clock_info *cinfo)
 	}
 
 	if (cinfo->ext_control_pin) {
-		ret = clk_prepare(cinfo->clk);
+		ret = clk_prepare(cinfo->hw.clk);
 		if (ret < 0) {
 			dev_err(cinfo->dev, "Clock prep failed, %d\n", ret);
 			return ret;
@@ -242,7 +241,6 @@ static int palmas_clks_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	const struct palmas_clks_of_match_data *match_data;
 	struct palmas_clock_info *cinfo;
-	struct clk *clk;
 	int ret;
 
 	match_data = of_device_get_match_data(&pdev->dev);
@@ -261,22 +259,20 @@ static int palmas_clks_probe(struct platform_device *pdev)
 
 	cinfo->clk_desc = &match_data->desc;
 	cinfo->hw.init = &match_data->init;
-	clk = devm_clk_register(&pdev->dev, &cinfo->hw);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
+	ret = devm_clk_hw_register(&pdev->dev, &cinfo->hw);
+	if (ret) {
 		dev_err(&pdev->dev, "Fail to register clock %s, %d\n",
 			match_data->desc.clk_name, ret);
 		return ret;
 	}
 
-	cinfo->clk = clk;
 	ret = palmas_clks_init_configure(cinfo);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Clock config failed, %d\n", ret);
 		return ret;
 	}
 
-	ret = of_clk_add_provider(node, of_clk_src_simple_get, cinfo->clk);
+	ret = of_clk_add_hw_provider(node, of_clk_hw_simple_get, &cinfo->hw);
 	if (ret < 0)
 		dev_err(&pdev->dev, "Fail to add clock driver, %d\n", ret);
 	return ret;
-- 
2.7.4
