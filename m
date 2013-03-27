From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 27 Mar 2013 14:01:33 +0100
Subject: [PATCH v2 4/5] ARM: imx5 DT init cpufreq-cpu0 device
In-Reply-To: <1364389294-1997-1-git-send-email-mpa@pengutronix.de>
References: <1364389294-1997-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1364389294-1997-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpufreq-cpu0 platform device for imx5 DT init and register the clock
for imx5.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c | 2 +-
 arch/arm/mach-imx/imx51-dt.c        | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 0f39f8c..e80d8fd 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -281,7 +281,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk_register_clkdev(clk[ssi_ext1_gate], "ssi_ext1", NULL);
 	clk_register_clkdev(clk[ssi_ext2_gate], "ssi_ext2", NULL);
 	clk_register_clkdev(clk[sdma_gate], NULL, "imx35-sdma");
-	clk_register_clkdev(clk[cpu_podf], "cpu", NULL);
+	clk_register_clkdev(clk[cpu_podf], NULL, "cpufreq-cpu0.0");
 	clk_register_clkdev(clk[iim_gate], "iim", NULL);
 	clk_register_clkdev(clk[dummy], NULL, "imx2-wdt.0");
 	clk_register_clkdev(clk[dummy], NULL, "imx2-wdt.1");
diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
index e2926a8..ab24cc3 100644
--- a/arch/arm/mach-imx/imx51-dt.c
+++ b/arch/arm/mach-imx/imx51-dt.c
@@ -21,7 +21,10 @@
 
 static void __init imx51_dt_init(void)
 {
+	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	platform_device_register_full(&devinfo);
 }
 
 static const char *imx51_dt_board_compat[] __initdata = {
-- 
1.8.1.5
