From: dinguyen@altera.com (dinguyen at altera.com)
Date: Thu, 5 Dec 2013 11:41:21 -0600
Subject: [PATCH] clk: socfpga: Remove socfpga_init_clocks
Message-ID: <1386265281-11799-1-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The only thing that socfpga_init_clocks was doing setting up the smp_twd clock.
Now that twd-timer's clock phandle is populated in the DTS, we can remove
this function.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 arch/arm/mach-socfpga/socfpga.c |    1 -
 drivers/clk/socfpga/clk.c       |   11 -----------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index dd0d49c..d4ae019 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -106,7 +106,6 @@ static void __init socfpga_cyclone5_init(void)
 {
 	l2x0_of_init(0, ~0UL);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	socfpga_init_clocks();
 }
 
 static const char *altera_dt_match[] = {
diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index 01baf20..53ddea8 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -358,14 +358,3 @@ static void __init socfpga_gate_init(struct device_node *node)
 	socfpga_gate_clk_init(node, &gateclk_ops);
 }
 CLK_OF_DECLARE(socfpga_gate, "altr,socfpga-gate-clk", socfpga_gate_init);
-
-void __init socfpga_init_clocks(void)
-{
-	struct clk *clk;
-	int ret;
-
-	clk = clk_register_fixed_factor(NULL, "smp_twd", "mpuclk", 0, 1, 4);
-	ret = clk_register_clkdev(clk, NULL, "smp_twd");
-	if (ret)
-		pr_err("smp_twd alias not registered\n");
-}
-- 
1.7.9.5
