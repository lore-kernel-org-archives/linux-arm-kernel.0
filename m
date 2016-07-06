From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Wed,  6 Jul 2016 12:18:34 +0000
Subject: [PATCH -next] clk: sunxi: pll2: Fix return value check in
 sun4i_pll2_setup()
Message-ID: <1467807514-31723-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the functions clk_register_composite() and
clk_register_divider() returns ERR_PTR() and never returns NULL.
The NULL test in the return value check should be replaced with
IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/clk/sunxi/clk-a10-pll2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-a10-pll2.c b/drivers/clk/sunxi/clk-a10-pll2.c
index 0ee1f36..d8eab90 100644
--- a/drivers/clk/sunxi/clk-a10-pll2.c
+++ b/drivers/clk/sunxi/clk-a10-pll2.c
@@ -73,7 +73,7 @@ static void __init sun4i_pll2_setup(struct device_node *node,
 					  SUN4I_PLL2_PRE_DIV_WIDTH,
 					  CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
 					  &sun4i_a10_pll2_lock);
-	if (!prediv_clk) {
+	if (IS_ERR(prediv_clk)) {
 		pr_err("Couldn't register the prediv clock\n");
 		goto err_free_array;
 	}
@@ -106,7 +106,7 @@ static void __init sun4i_pll2_setup(struct device_node *node,
 					  &mult->hw, &clk_multiplier_ops,
 					  &gate->hw, &clk_gate_ops,
 					  CLK_SET_RATE_PARENT);
-	if (!base_clk) {
+	if (IS_ERR(base_clk)) {
 		pr_err("Couldn't register the base multiplier clock\n");
 		goto err_free_multiplier;
 	}
