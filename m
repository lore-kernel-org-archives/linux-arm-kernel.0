From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 22 Apr 2013 12:56:01 +0800
Subject: [PATCH] ARM: imx: move imx53-qsb audio codec clk lookup into DT
Message-ID: <1366606561-18805-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With device tree clk lookup support in place, we can move audio codec
clk lookup for ssi_ext1 into device tree now, so that imx53_qsb_init()
can be saved.

Since ssi_ext2 lookup is used nowhere, it gets removed together with
ssi_ext1 lookup from clk driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53-qsb.dts     |    1 +
 arch/arm/mach-imx/clk-imx51-imx53.c |    2 --
 arch/arm/mach-imx/mach-imx53.c      |   16 ----------------
 3 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 8f0e9ae..ed47e43 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -147,6 +147,7 @@
 		reg = <0x0a>;
 		VDDA-supply = <&reg_3p2v>;
 		VDDIO-supply = <&reg_3p2v>;
+		clocks = <&clks 150>;
 	};
 };
 
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 6fc486b..adea706 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -310,8 +310,6 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
 	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
 	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "imx-ssi.2");
-	clk_register_clkdev(clk[ssi_ext1_gate], "ssi_ext1", NULL);
-	clk_register_clkdev(clk[ssi_ext2_gate], "ssi_ext2", NULL);
 	clk_register_clkdev(clk[sdma_gate], NULL, "imx35-sdma");
 	clk_register_clkdev(clk[cpu_podf], NULL, "cpufreq-cpu0.0");
 	clk_register_clkdev(clk[iim_gate], "iim", NULL);
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index f579c61..8d47571 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -23,24 +23,8 @@
 #include "common.h"
 #include "mx53.h"
 
-static void __init imx53_qsb_init(void)
-{
-	struct clk *clk;
-
-	clk = clk_get_sys(NULL, "ssi_ext1");
-	if (IS_ERR(clk)) {
-		pr_err("failed to get clk ssi_ext1\n");
-		return;
-	}
-
-	clk_register_clkdev(clk, NULL, "0-000a");
-}
-
 static void __init imx53_dt_init(void)
 {
-	if (of_machine_is_compatible("fsl,imx53-qsb"))
-		imx53_qsb_init();
-
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.7.9.5
