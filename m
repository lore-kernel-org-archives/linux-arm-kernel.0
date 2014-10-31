From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 31 Oct 2014 17:39:53 +0800
Subject: [PATCH] arm: imx: clean up machine mxc_arch_reset_init_dt reset init
Message-ID: <1414748393-20799-1-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

System restart mechanism has been changed with the introduction
of "kernel restart handler call chain support". The imx2 watchdog
based restart handler has been moved to the driver, and these
restart can be removed from the machine layer.

This patch cleans up the device tree version machine reset init with
mxc_arch_reset_init_dt and removes corresponding .restart handler,
for the .init_machine that can be handled by system default after
removing the mxc_arch_reset_init_dt, the .init_machine is also removed.

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 arch/arm/mach-imx/common.h      |  1 -
 arch/arm/mach-imx/imx25-dt.c    |  9 ---------
 arch/arm/mach-imx/imx27-dt.c    |  3 ---
 arch/arm/mach-imx/imx31-dt.c    | 10 ----------
 arch/arm/mach-imx/imx35-dt.c    | 10 ----------
 arch/arm/mach-imx/mach-imx50.c  |  9 ---------
 arch/arm/mach-imx/mach-imx51.c  |  2 --
 arch/arm/mach-imx/mach-imx53.c  |  2 --
 arch/arm/mach-imx/mach-imx6q.c  |  3 ---
 arch/arm/mach-imx/mach-imx6sl.c |  3 ---
 arch/arm/mach-imx/mach-imx6sx.c |  3 ---
 arch/arm/mach-imx/mach-vf610.c  | 10 ----------
 arch/arm/mach-imx/system.c      | 15 ---------------
 13 files changed, 80 deletions(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index fe9a908..59ce8f3 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -61,7 +61,6 @@ struct platform_device *mxc_register_gpio(char *name, int id,
 void mxc_set_cpu_type(unsigned int type);
 void mxc_restart(enum reboot_mode, const char *);
 void mxc_arch_reset_init(void __iomem *);
-void mxc_arch_reset_init_dt(void);
 int mx51_revision(void);
 int mx53_revision(void);
 void imx_set_aips(void __iomem *);
diff --git a/arch/arm/mach-imx/imx25-dt.c b/arch/arm/mach-imx/imx25-dt.c
index cf8032b..25defbd 100644
--- a/arch/arm/mach-imx/imx25-dt.c
+++ b/arch/arm/mach-imx/imx25-dt.c
@@ -17,13 +17,6 @@
 #include "common.h"
 #include "mx25.h"
 
-static void __init imx25_dt_init(void)
-{
-	mxc_arch_reset_init_dt();
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 static const char * const imx25_dt_board_compat[] __initconst = {
 	"fsl,imx25",
 	NULL
@@ -33,7 +26,5 @@ DT_MACHINE_START(IMX25_DT, "Freescale i.MX25 (Device Tree Support)")
 	.map_io		= mx25_map_io,
 	.init_early	= imx25_init_early,
 	.init_irq	= mx25_init_irq,
-	.init_machine	= imx25_dt_init,
 	.dt_compat	= imx25_dt_board_compat,
-	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index dc8f1a6..bd42d1b 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -22,8 +22,6 @@ static void __init imx27_dt_init(void)
 {
 	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
 
-	mxc_arch_reset_init_dt();
-
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	platform_device_register_full(&devinfo);
@@ -40,5 +38,4 @@ DT_MACHINE_START(IMX27_DT, "Freescale i.MX27 (Device Tree Support)")
 	.init_irq	= mx27_init_irq,
 	.init_machine	= imx27_dt_init,
 	.dt_compat	= imx27_dt_board_compat,
-	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
index 418dbc8..e0a4e2f 100644
--- a/arch/arm/mach-imx/imx31-dt.c
+++ b/arch/arm/mach-imx/imx31-dt.c
@@ -15,16 +15,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 
-#include "common.h"
 #include "mx31.h"
 
-static void __init imx31_dt_init(void)
-{
-	mxc_arch_reset_init_dt();
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 static const char * const imx31_dt_board_compat[] __initconst = {
 	"fsl,imx31",
 	NULL
@@ -40,7 +32,5 @@ DT_MACHINE_START(IMX31_DT, "Freescale i.MX31 (Device Tree Support)")
 	.init_early	= imx31_init_early,
 	.init_irq	= mx31_init_irq,
 	.init_time	= imx31_dt_timer_init,
-	.init_machine	= imx31_dt_init,
 	.dt_compat	= imx31_dt_board_compat,
-	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/imx35-dt.c b/arch/arm/mach-imx/imx35-dt.c
index 584fbe1..e939603 100644
--- a/arch/arm/mach-imx/imx35-dt.c
+++ b/arch/arm/mach-imx/imx35-dt.c
@@ -20,14 +20,6 @@
 #include "common.h"
 #include "mx35.h"
 
-static void __init imx35_dt_init(void)
-{
-	mxc_arch_reset_init_dt();
-
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     NULL, NULL);
-}
-
 static void __init imx35_irq_init(void)
 {
 	imx_init_l2cache();
@@ -43,7 +35,5 @@ DT_MACHINE_START(IMX35_DT, "Freescale i.MX35 (Device Tree Support)")
 	.map_io		= mx35_map_io,
 	.init_early	= imx35_init_early,
 	.init_irq	= imx35_irq_init,
-	.init_machine	= imx35_dt_init,
 	.dt_compat	= imx35_dt_board_compat,
-	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx50.c b/arch/arm/mach-imx/mach-imx50.c
index b1e56a9..ecf58b9 100644
--- a/arch/arm/mach-imx/mach-imx50.c
+++ b/arch/arm/mach-imx/mach-imx50.c
@@ -16,13 +16,6 @@
 
 #include "common.h"
 
-static void __init imx50_dt_init(void)
-{
-	mxc_arch_reset_init_dt();
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 static const char * const imx50_dt_board_compat[] __initconst = {
 	"fsl,imx50",
 	NULL
@@ -30,7 +23,5 @@ static const char * const imx50_dt_board_compat[] __initconst = {
 
 DT_MACHINE_START(IMX50_DT, "Freescale i.MX50 (Device Tree Support)")
 	.init_irq	= tzic_init_irq,
-	.init_machine	= imx50_dt_init,
 	.dt_compat	= imx50_dt_board_compat,
-	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx51.c b/arch/arm/mach-imx/mach-imx51.c
index 2c5fcaf..b015129 100644
--- a/arch/arm/mach-imx/mach-imx51.c
+++ b/arch/arm/mach-imx/mach-imx51.c
@@ -53,7 +53,6 @@ static void __init imx51_dt_init(void)
 {
 	struct platform_device_info devinfo = { .name = "cpufreq-dt", };
 
-	mxc_arch_reset_init_dt();
 	imx51_ipu_mipi_setup();
 	imx_src_init();
 
@@ -78,5 +77,4 @@ DT_MACHINE_START(IMX51_DT, "Freescale i.MX51 (Device Tree Support)")
 	.init_machine	= imx51_dt_init,
 	.init_late	= imx51_init_late,
 	.dt_compat	= imx51_dt_board_compat,
-	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 7587cf0..86316a9 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -30,7 +30,6 @@ static void __init imx53_init_early(void)
 
 static void __init imx53_dt_init(void)
 {
-	mxc_arch_reset_init_dt();
 	imx_src_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
@@ -56,5 +55,4 @@ DT_MACHINE_START(IMX53_DT, "Freescale i.MX53 (Device Tree Support)")
 	.init_machine	= imx53_dt_init,
 	.init_late	= imx53_init_late,
 	.dt_compat	= imx53_dt_board_compat,
-	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index d51c6e9..5057d61 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -268,8 +268,6 @@ static void __init imx6q_init_machine(void)
 	imx_print_silicon_rev(cpu_is_imx6dl() ? "i.MX6DL" : "i.MX6Q",
 			      imx_get_soc_revision());
 
-	mxc_arch_reset_init_dt();
-
 	parent = imx_soc_device_init();
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
@@ -409,5 +407,4 @@ DT_MACHINE_START(IMX6Q, "Freescale i.MX6 Quad/DualLite (Device Tree)")
 	.init_machine	= imx6q_init_machine,
 	.init_late      = imx6q_init_late,
 	.dt_compat	= imx6q_dt_compat,
-	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx6sl.c b/arch/arm/mach-imx/mach-imx6sl.c
index ed263a2..65f4b0d 100644
--- a/arch/arm/mach-imx/mach-imx6sl.c
+++ b/arch/arm/mach-imx/mach-imx6sl.c
@@ -48,8 +48,6 @@ static void __init imx6sl_init_machine(void)
 {
 	struct device *parent;
 
-	mxc_arch_reset_init_dt();
-
 	parent = imx_soc_device_init();
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
@@ -81,5 +79,4 @@ DT_MACHINE_START(IMX6SL, "Freescale i.MX6 SoloLite (Device Tree)")
 	.init_machine	= imx6sl_init_machine,
 	.init_late      = imx6sl_init_late,
 	.dt_compat	= imx6sl_dt_compat,
-	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx6sx.c b/arch/arm/mach-imx/mach-imx6sx.c
index 9822249..fd6908b 100644
--- a/arch/arm/mach-imx/mach-imx6sx.c
+++ b/arch/arm/mach-imx/mach-imx6sx.c
@@ -68,8 +68,6 @@ static void __init imx6sx_init_machine(void)
 {
 	struct device *parent;
 
-	mxc_arch_reset_init_dt();
-
 	parent = imx_soc_device_init();
 	if (parent == NULL)
 		pr_warn("failed to initialize soc device\n");
@@ -109,5 +107,4 @@ DT_MACHINE_START(IMX6SX, "Freescale i.MX6 SoloX (Device Tree)")
 	.init_machine	= imx6sx_init_machine,
 	.dt_compat	= imx6sx_dt_compat,
 	.init_late	= imx6sx_init_late,
-	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-vf610.c b/arch/arm/mach-imx/mach-vf610.c
index ee7e57b..c11ab6a 100644
--- a/arch/arm/mach-imx/mach-vf610.c
+++ b/arch/arm/mach-imx/mach-vf610.c
@@ -12,14 +12,6 @@
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
 
-#include "common.h"
-
-static void __init vf610_init_machine(void)
-{
-	mxc_arch_reset_init_dt();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 static const char * const vf610_dt_compat[] __initconst = {
 	"fsl,vf610",
 	NULL,
@@ -28,7 +20,5 @@ static const char * const vf610_dt_compat[] __initconst = {
 DT_MACHINE_START(VYBRID_VF610, "Freescale Vybrid VF610 (Device Tree)")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
-	.init_machine   = vf610_init_machine,
 	.dt_compat	= vf610_dt_compat,
-	.restart	= mxc_restart,
 MACHINE_END
diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
index d14c33f..51c3501 100644
--- a/arch/arm/mach-imx/system.c
+++ b/arch/arm/mach-imx/system.c
@@ -89,21 +89,6 @@ void __init mxc_arch_reset_init(void __iomem *base)
 		clk_prepare(wdog_clk);
 }
 
-void __init mxc_arch_reset_init_dt(void)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx21-wdt");
-	wdog_base = of_iomap(np, 0);
-	WARN_ON(!wdog_base);
-
-	wdog_clk = of_clk_get(np, 0);
-	if (IS_ERR(wdog_clk))
-		pr_warn("%s: failed to get wdog clock\n", __func__);
-	else
-		clk_prepare(wdog_clk);
-}
-
 #ifdef CONFIG_CACHE_L2X0
 void __init imx_init_l2cache(void)
 {
-- 
1.8.0
