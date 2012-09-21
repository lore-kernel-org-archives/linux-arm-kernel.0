From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Fri, 21 Sep 2012 14:35:18 +0800
Subject: [PATCH] clk: fix return value check in of_fixed_clk_setup()
Message-ID: <CAPgLHd-BtGhVBHYGW1UFT9wqmnPqmuf9AWkQk6mXG7xSzWqOOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function clk_register_fixed_rate() returns
ERR_PTR() not NULL pointer. The NULL test in the return value
check should be replaced with IS_ERR().

dpatch engine is used to auto generated this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/clk/clk-fixed-rate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
index f5ec0ee..af78ed6 100644
--- a/drivers/clk/clk-fixed-rate.c
+++ b/drivers/clk/clk-fixed-rate.c
@@ -97,7 +97,7 @@ void __init of_fixed_clk_setup(struct device_node *node)
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, CLK_IS_ROOT, rate);
-	if (clk)
+	if (!IS_ERR(clk))
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 }
 EXPORT_SYMBOL_GPL(of_fixed_clk_setup);
