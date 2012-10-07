From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sun, 7 Oct 2012 22:02:40 +0800
Subject: [PATCH] clk: fix return value check in bcm2835_init_clocks()
Message-ID: <CAPgLHd95ofKiKWC9B67q9mgkjsc6_YJ5x92aY0xKPiohuUMk4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function clk_register_fixed_rate() returns
ERR_PTR() and never returns NULL. The NULL test in the return value
check should be replaced with IS_ERR().

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/clk/clk-bcm2835.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-bcm2835.c b/drivers/clk/clk-bcm2835.c
index 67ad16b..b61ee2c 100644
--- a/drivers/clk/clk-bcm2835.c
+++ b/drivers/clk/clk-bcm2835.c
@@ -33,17 +33,17 @@ void __init bcm2835_init_clocks(void)
 
 	clk = clk_register_fixed_rate(NULL, "sys_pclk", NULL, CLK_IS_ROOT,
 					250000000);
-	if (!clk)
+	if (IS_ERR(clk))
 		pr_err("sys_pclk not registered\n");
 
 	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT,
 					126000000);
-	if (!clk)
+	if (IS_ERR(clk))
 		pr_err("apb_pclk not registered\n");
 
 	clk = clk_register_fixed_rate(NULL, "uart0_pclk", NULL, CLK_IS_ROOT,
 					3000000);
-	if (!clk)
+	if (IS_ERR(clk))
 		pr_err("uart0_pclk not registered\n");
 	ret = clk_register_clkdev(clk, NULL, "20201000.uart");
 	if (ret)
@@ -51,7 +51,7 @@ void __init bcm2835_init_clocks(void)
 
 	clk = clk_register_fixed_rate(NULL, "uart1_pclk", NULL, CLK_IS_ROOT,
 					125000000);
-	if (!clk)
+	if (IS_ERR(clk))
 		pr_err("uart1_pclk not registered\n");
 	ret = clk_register_clkdev(clk, NULL, "20215000.uart");
 	if (ret)
