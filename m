From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed,  1 Jun 2016 16:15:32 -0700
Subject: [PATCH 33/34] clk: vt8500: Migrate to clk_hw based registration APIs
In-Reply-To: <20160601231533.9354-1-stephen.boyd@linaro.org>
References: <20160601231533.9354-1-stephen.boyd@linaro.org>
Message-ID: <20160601231533.9354-34-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have clk_hw based provider APIs to register clks, we
can get rid of struct clk pointers while registering clks in
these drivers, allowing us to move closer to a clear split of
consumer and provider clk APIs.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Tony Prisk <linux@prisktech.co.nz>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---

See commit 58657d189a2f and it's children for details on this
new registration API.

 drivers/clk/clk-vt8500.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index b0f76a84f1e9..ed583bedef05 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -232,7 +232,7 @@ static const struct clk_ops vt8500_gated_divisor_clk_ops = {
 static __init void vtwm_device_clk_init(struct device_node *node)
 {
 	u32 en_reg, div_reg;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_device *dev_clk;
 	const char *clk_name = node->name;
 	const char *parent_name;
@@ -301,13 +301,14 @@ static __init void vtwm_device_clk_init(struct device_node *node)
 
 	dev_clk->hw.init = &init;
 
-	clk = clk_register(NULL, &dev_clk->hw);
-	if (WARN_ON(IS_ERR(clk))) {
+	hw = &dev_clk->hw;
+	rc = clk_hw_register(NULL, hw);
+	if (WARN_ON(rc)) {
 		kfree(dev_clk);
 		return;
 	}
-	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	clk_register_clkdev(clk, clk_name, NULL);
+	rc = of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
+	clk_hw_register_clkdev(hw, clk_name, NULL);
 }
 CLK_OF_DECLARE(vt8500_device, "via,vt8500-device-clock", vtwm_device_clk_init);
 
@@ -692,7 +693,7 @@ static const struct clk_ops vtwm_pll_ops = {
 static __init void vtwm_pll_clk_init(struct device_node *node, int pll_type)
 {
 	u32 reg;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_pll *pll_clk;
 	const char *clk_name = node->name;
 	const char *parent_name;
@@ -725,13 +726,14 @@ static __init void vtwm_pll_clk_init(struct device_node *node, int pll_type)
 
 	pll_clk->hw.init = &init;
 
-	clk = clk_register(NULL, &pll_clk->hw);
-	if (WARN_ON(IS_ERR(clk))) {
+	hw = &pll_clk->hw;
+	rc = clk_hw_register(NULL, &pll_clk->hw);
+	if (WARN_ON(rc)) {
 		kfree(pll_clk);
 		return;
 	}
-	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	clk_register_clkdev(clk, clk_name, NULL);
+	rc = of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw);
+	clk_hw_register_clkdev(hw, clk_name, NULL);
 }
 
 
-- 
2.7.4
