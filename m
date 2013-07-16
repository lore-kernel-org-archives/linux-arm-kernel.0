From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Tue, 16 Jul 2013 20:17:45 +0800
Subject: [PATCH -next] clk: sunxi: fix return value check
Message-ID: <CAPgLHd_RTeUgZtsLd=GqW7tG0q-ccDcd8gBNgDxo3E8qLE141g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function clk_register_composite() and
clk_register_factors() returns ERR_PTR() not NULL. The NULL test
in the return value check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/clk/sunxi/clk-sunxi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 412912b..02e440b 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -64,7 +64,7 @@ static void __init sunxi_osc_clk_setup(struct device_node *node)
 			&gate->hw, &clk_gate_ops,
 			CLK_IS_ROOT);
 
-	if (clk) {
+	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		clk_register_clkdev(clk, clk_name, NULL);
 	}
@@ -221,7 +221,7 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
 	clk = clk_register_factors(NULL, clk_name, parent, 0, reg,
 				   data->table, data->getter, &clk_lock);
 
-	if (clk) {
+	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 		clk_register_clkdev(clk, clk_name, NULL);
 	}
