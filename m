From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 17 Sep 2013 11:32:21 -0500
Subject: [PATCH 2/2] arm: socfpga: Remove socfpga_init_clocks
In-Reply-To: <1379435541-26338-1-git-send-email-dinguyen@altera.com>
References: <1379435541-26338-1-git-send-email-dinguyen@altera.com>
Message-ID: <1379435541-26338-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

The smp_twd clock can be represented in DTS, so there is no need for
socfpga_init_clocks().

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
CC: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-socfpga/socfpga.c |    1 -
 drivers/clk/socfpga/clk.c       |   11 -----------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index bfce964..5314fc2 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -108,7 +108,6 @@ static void __init socfpga_cyclone5_init(void)
 	l2x0_of_init(0, ~0UL);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	of_clk_init(NULL);
-	socfpga_init_clocks();
 }
 
 static const char *altera_dt_match[] = {
diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index c378489..24580b7 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -333,14 +333,3 @@ static void __init socfpga_gate_init(struct device_node *node)
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
