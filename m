From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Mar 2013 12:41:17 +0100
Subject: [PATCH 6/8] ARM: sirf: use clocksource_of infrastructure
In-Reply-To: <1363779679-16880-1-git-send-email-arnd@arndb.de>
References: <1363779679-16880-1-git-send-email-arnd@arndb.de>
Message-ID: <1363779679-16880-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the two sirf clocksource drivers to drivers/clocksource
and integrates them into the framework for locating the clock sources
automatically.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/mach-prima2/Makefile                      |  2 --
 arch/arm/mach-prima2/common.c                      | 14 ++++++--
 arch/arm/mach-prima2/common.h                      |  3 --
 drivers/clocksource/Makefile                       |  2 ++
 .../clocksource}/timer-marco.c                     | 25 +++-----------
 .../clocksource}/timer-prima2.c                    | 38 ++++------------------
 6 files changed, 24 insertions(+), 60 deletions(-)
 rename {arch/arm/mach-prima2 => drivers/clocksource}/timer-marco.c (94%)
 rename {arch/arm/mach-prima2 => drivers/clocksource}/timer-prima2.c (92%)

diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
index bfe360c..4e1d3d2 100644
--- a/arch/arm/mach-prima2/Makefile
+++ b/arch/arm/mach-prima2/Makefile
@@ -7,5 +7,3 @@ obj-$(CONFIG_SUSPEND) += pm.o sleep.o
 obj-$(CONFIG_SIRF_IRQ) += irq.o
 obj-$(CONFIG_SMP) += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)  += hotplug.o
-obj-$(CONFIG_ARCH_PRIMA2) += timer-prima2.o
-obj-$(CONFIG_ARCH_MARCO) += timer-marco.o
diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index 15c14df..944d8ca 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -6,6 +6,7 @@
  * Licensed under GPLv2 or later.
  */
 
+#include <linux/clocksource.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/irqchip.h>
@@ -31,6 +32,13 @@ void __init sirfsoc_init_late(void)
 	sirfsoc_pm_init();
 }
 
+static __init void sirfsoc_init_time(void)
+{
+	/* initialize clocking early, we want to set the OS timer */
+	sirfsoc_of_clk_init();
+	clocksource_of_init();
+}
+
 static __init void sirfsoc_map_io(void)
 {
 	sirfsoc_map_lluart();
@@ -47,7 +55,7 @@ DT_MACHINE_START(ATLAS6_DT, "Generic ATLAS6 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.map_io         = sirfsoc_map_io,
 	.init_irq	= irqchip_init,
-	.init_time	= sirfsoc_prima2_timer_init,
+	.init_time	= sirfsoc_init_time,
 	.init_machine	= sirfsoc_mach_init,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = atlas6_dt_match,
@@ -65,7 +73,7 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	/* Maintainer: Barry Song <baohua.song@csr.com> */
 	.map_io         = sirfsoc_map_io,
 	.init_irq	= irqchip_init,
-	.init_time	= sirfsoc_prima2_timer_init,
+	.init_time	= sirfsoc_init_time,
 	.dma_zone_size	= SZ_256M,
 	.init_machine	= sirfsoc_mach_init,
 	.init_late	= sirfsoc_init_late,
@@ -85,7 +93,7 @@ DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
 	.smp            = smp_ops(sirfsoc_smp_ops),
 	.map_io         = sirfsoc_map_io,
 	.init_irq	= irqchip_init,
-	.init_time	= sirfsoc_marco_timer_init,
+	.init_time	= sirfsoc_init_time,
 	.init_machine	= sirfsoc_mach_init,
 	.init_late	= sirfsoc_init_late,
 	.dt_compat      = marco_dt_match,
diff --git a/arch/arm/mach-prima2/common.h b/arch/arm/mach-prima2/common.h
index b7c26b6..54262cf 100644
--- a/arch/arm/mach-prima2/common.h
+++ b/arch/arm/mach-prima2/common.h
@@ -13,9 +13,6 @@
 #include <asm/mach/time.h>
 #include <asm/exception.h>
 
-extern void sirfsoc_prima2_timer_init(void);
-extern void sirfsoc_marco_timer_init(void);
-
 extern struct smp_operations   sirfsoc_smp_ops;
 extern void sirfsoc_secondary_startup(void);
 extern void sirfsoc_cpu_die(unsigned int cpu);
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 4d8283a..5e2176f 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -16,6 +16,8 @@ obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
 obj-$(CONFIG_ARMADA_370_XP_TIMER)	+= time-armada-370-xp.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
+obj-$(CONFIG_ARCH_MARCO)	+= timer-marco.o
+obj-$(CONFIG_ARCH_PRIMA2)	+= timer-prima2.o
 obj-$(CONFIG_SUNXI_TIMER)	+= sunxi_timer.o
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra20_timer.o
 obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
diff --git a/arch/arm/mach-prima2/timer-marco.c b/drivers/clocksource/timer-marco.c
similarity index 94%
rename from arch/arm/mach-prima2/timer-marco.c
rename to drivers/clocksource/timer-marco.c
index f4eea2e..97738db 100644
--- a/arch/arm/mach-prima2/timer-marco.c
+++ b/drivers/clocksource/timer-marco.c
@@ -21,8 +21,6 @@
 #include <asm/localtimer.h>
 #include <asm/mach/time.h>
 
-#include "common.h"
-
 #define SIRFSOC_TIMER_32COUNTER_0_CTRL			0x0000
 #define SIRFSOC_TIMER_32COUNTER_1_CTRL			0x0004
 #define SIRFSOC_TIMER_MATCH_0				0x0018
@@ -53,7 +51,6 @@ static const u32 sirfsoc_timer_reg_list[SIRFSOC_TIMER_REG_CNT] = {
 static u32 sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT];
 
 static void __iomem *sirfsoc_timer_base;
-static void __init sirfsoc_of_timer_map(void);
 
 /* disable count and interrupt */
 static inline void sirfsoc_timer_count_disable(int idx)
@@ -242,15 +239,12 @@ static void __init sirfsoc_clockevent_init(void)
 }
 
 /* initialize the kernel jiffy timer source */
-void __init sirfsoc_marco_timer_init(void)
+static void __init sirfsoc_marco_timer_init(void)
 {
 	unsigned long rate;
 	u32 timer_div;
 	struct clk *clk;
 
-	/* initialize clocking early, we want to set the OS timer */
-	sirfsoc_of_clk_init();
-
 	/* timer's input clock is io clock */
 	clk = clk_get_sys("io", NULL);
 
@@ -260,8 +254,6 @@ void __init sirfsoc_marco_timer_init(void)
 	BUG_ON(rate < CLOCK_TICK_RATE);
 	BUG_ON(rate % CLOCK_TICK_RATE);
 
-	sirfsoc_of_timer_map();
-
 	/* Initialize the timer dividers */
 	timer_div = rate / CLOCK_TICK_RATE - 1;
 	writel_relaxed(timer_div << 16, sirfsoc_timer_base + SIRFSOC_TIMER_64COUNTER_CTRL);
@@ -286,18 +278,8 @@ void __init sirfsoc_marco_timer_init(void)
 	sirfsoc_clockevent_init();
 }
 
-static struct of_device_id timer_ids[] = {
-	{ .compatible = "sirf,marco-tick" },
-	{},
-};
-
-static void __init sirfsoc_of_timer_map(void)
+static void __init sirfsoc_of_timer_init(struct device_node *np)
 {
-	struct device_node *np;
-
-	np = of_find_matching_node(NULL, timer_ids);
-	if (!np)
-		return;
 	sirfsoc_timer_base = of_iomap(np, 0);
 	if (!sirfsoc_timer_base)
 		panic("unable to map timer cpu registers\n");
@@ -312,5 +294,6 @@ static void __init sirfsoc_of_timer_map(void)
 		panic("No irq passed for timer1 via DT\n");
 #endif
 
-	of_node_put(np);
+	sirfsoc_marco_timer_init();
 }
+CLOCKSOURCE_OF_DECLARE(sirfsoc_marco_timer, "sirf,marco-tick", sirfsoc_of_timer_init );
diff --git a/arch/arm/mach-prima2/timer-prima2.c b/drivers/clocksource/timer-prima2.c
similarity index 92%
rename from arch/arm/mach-prima2/timer-prima2.c
rename to drivers/clocksource/timer-prima2.c
index 9829083..7608826 100644
--- a/arch/arm/mach-prima2/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -18,12 +18,9 @@
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <mach/map.h>
 #include <asm/sched_clock.h>
 #include <asm/mach/time.h>
 
-#include "common.h"
-
 #define SIRFSOC_TIMER_COUNTER_LO	0x0000
 #define SIRFSOC_TIMER_COUNTER_HI	0x0004
 #define SIRFSOC_TIMER_MATCH_0		0x0008
@@ -56,7 +53,6 @@ static const u32 sirfsoc_timer_reg_list[SIRFSOC_TIMER_REG_CNT] = {
 static u32 sirfsoc_timer_reg_val[SIRFSOC_TIMER_REG_CNT];
 
 static void __iomem *sirfsoc_timer_base;
-static void __init sirfsoc_of_timer_map(void);
 
 /* timer0 interrupt handler */
 static irqreturn_t sirfsoc_timer_interrupt(int irq, void *dev_id)
@@ -182,14 +178,11 @@ static void __init sirfsoc_clockevent_init(void)
 }
 
 /* initialize the kernel jiffy timer source */
-void __init sirfsoc_prima2_timer_init(void)
+static void __init sirfsoc_prima2_timer_init(struct device_node *np)
 {
 	unsigned long rate;
 	struct clk *clk;
 
-	/* initialize clocking early, we want to set the OS timer */
-	sirfsoc_of_clk_init();
-
 	/* timer's input clock is io clock */
 	clk = clk_get_sys("io", NULL);
 
@@ -200,7 +193,11 @@ void __init sirfsoc_prima2_timer_init(void)
 	BUG_ON(rate < CLOCK_TICK_RATE);
 	BUG_ON(rate % CLOCK_TICK_RATE);
 
-	sirfsoc_of_timer_map();
+	sirfsoc_timer_base = of_iomap(np, 0);
+	if (!sirfsoc_timer_base)
+		panic("unable to map timer cpu registers\n");
+
+	sirfsoc_timer_irq.irq = irq_of_parse_and_map(np, 0);
 
 	writel_relaxed(rate / CLOCK_TICK_RATE / 2 - 1, sirfsoc_timer_base + SIRFSOC_TIMER_DIV);
 	writel_relaxed(0, sirfsoc_timer_base + SIRFSOC_TIMER_COUNTER_LO);
@@ -215,25 +212,4 @@ void __init sirfsoc_prima2_timer_init(void)
 
 	sirfsoc_clockevent_init();
 }
-
-static struct of_device_id timer_ids[] = {
-	{ .compatible = "sirf,prima2-tick" },
-	{},
-};
-
-static void __init sirfsoc_of_timer_map(void)
-{
-	struct device_node *np;
-
-	np = of_find_matching_node(NULL, timer_ids);
-	if (!np)
-		return;
-	sirfsoc_timer_base = of_iomap(np, 0);
-	if (!sirfsoc_timer_base)
-		panic("unable to map timer cpu registers\n");
-
-	/* Get the interrupts property */
-	sirfsoc_timer_irq.irq = irq_of_parse_and_map(np, 0);
-
-	of_node_put(np);
-}
+CLOCKSOURCE_OF_DECLARE(sirfsoc_prima2_timer, "sirf,prima2-tick", sirfsoc_prima2_timer_init);
-- 
1.8.1.2
