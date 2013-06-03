From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon,  3 Jun 2013 17:30:45 +0800
Subject: [PATCH v3 11/11] ARCH: mmp: support clocksource in timer
In-Reply-To: <1370251845-31373-1-git-send-email-haojian.zhuang@gmail.com>
References: <1370251845-31373-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1370251845-31373-12-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support clocksource in timer-mmp driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/mmp-dt.c      |  4 +---
 arch/arm/mach-mmp/mmp2-dt.c     |  2 +-
 drivers/clocksource/Kconfig     |  6 ++++++
 drivers/clocksource/Makefile    |  2 +-
 drivers/clocksource/timer-mmp.c | 16 +++-------------
 5 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index 2b8f1f6..ff4a70b 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -18,8 +18,6 @@
 
 #include "common.h"
 
-extern void __init mmp_dt_init_timer(void);
-
 static const struct of_dev_auxdata pxa168_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4017000, "pxa2xx-uart.0", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4018000, "pxa2xx-uart.1", NULL),
@@ -63,7 +61,7 @@ static const char *mmp_dt_board_compat[] __initdata = {
 static void __init mmp_init_timer(void)
 {
 	of_clk_init(NULL);
-	mmp_dt_init_timer();
+	clocksource_of_init();
 }
 
 DT_MACHINE_START(PXA168_DT, "Marvell PXA168 (Device Tree Support)")
diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index 68a7642..9495105 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -40,7 +40,7 @@ static void __init mmp2_dt_init(void)
 static void __init mmp2_init_timer(void)
 {
 	of_clk_init(NULL);
-	mmp_dt_init_timer();
+	clocksource_of_init();
 }
 
 static const char *mmp2_dt_board_compat[] __initdata = {
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index f151c6c..f429f68 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -72,6 +72,12 @@ config CLKSRC_METAG_GENERIC
 	help
 	  This option enables support for the Meta per-thread timers.
 
+config CLKSRC_MMP
+	def_bool y if ARCH_MMP
+	select CLKSRC_OF if OF
+	help
+	  This option enables support for the MMP timer.
+
 config CLKSRC_EXYNOS_MCT
 	def_bool y if ARCH_EXYNOS
 	help
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index f6aa3b6..d154705 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
 obj-$(CONFIG_EM_TIMER_STI)	+= em_sti.o
 obj-$(CONFIG_CLKBLD_I8253)	+= i8253.o
 obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
+obj-$(CONFIG_CLKSRC_MMP)	+= timer-mmp.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
 obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
@@ -17,7 +18,6 @@ obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
 obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
 obj-$(CONFIG_ARCH_MARCO)	+= timer-marco.o
-obj-$(CONFIG_ARCH_MMP)		+= timer-mmp.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs_timer.o
 obj-$(CONFIG_ARCH_PRIMA2)	+= timer-prima2.o
 obj-$(CONFIG_SUN4I_TIMER)	+= sun4i_timer.o
diff --git a/drivers/clocksource/timer-mmp.c b/drivers/clocksource/timer-mmp.c
index 39b8968..7ae4f95 100644
--- a/drivers/clocksource/timer-mmp.c
+++ b/drivers/clocksource/timer-mmp.c
@@ -235,22 +235,12 @@ void __init timer_init(int irq, int mmp2_mode)
 					MIN_DELTA, MAX_DELTA);
 }
 
-#ifdef CONFIG_OF
-static struct of_device_id mmp_timer_dt_ids[] = {
-	{ .compatible = "mrvl,mmp-timer", },
-	{}
-};
-
-void __init mmp_dt_init_timer(void)
+static void __init mmp_dt_init_timer(struct device_node *np)
 {
-	struct device_node *np;
 	struct clk *clk;
-	int irq, ret;
+	int irq;
 	u32 rate = 0;
 
-	np = of_find_matching_node(NULL, mmp_timer_dt_ids);
-	if (!np)
-		return;
 	if (!of_device_is_available(np))
 		return;
 	if (of_property_read_u32(np, "clock-frequency", &rate)) {
@@ -288,4 +278,4 @@ void __init mmp_dt_init_timer(void)
 out:
 	clk_put(clk);
 }
-#endif
+CLOCKSOURCE_OF_DECLARE(mmp_timer, "mrvl,mmp-timer", mmp_dt_init_timer);
-- 
1.8.1.2
