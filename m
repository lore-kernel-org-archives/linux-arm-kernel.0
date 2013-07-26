From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 26 Jul 2013 18:05:33 +0800
Subject: [PATCH v6 11/11] ARM: mmp: avoid to use cpu_is_xxx in timer
In-Reply-To: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1374833133-21119-12-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid to use cpu_is_xxx() in timer-mmp driver, since it blocks the
multiplatform build. Now add mmp2_mode variable for legacy mode.
In DT mode, set the right clock rate in DTS file.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/Kconfig                      |  1 +
 arch/arm/boot/dts/mmp2-brownstone.dts |  4 ++
 arch/arm/boot/dts/pxa168-aspenite.dts |  1 +
 arch/arm/boot/dts/pxa910-dkb.dts      |  1 +
 arch/arm/mach-mmp/common.h            |  2 +-
 arch/arm/mach-mmp/mmp-dt.c            | 14 ++++---
 arch/arm/mach-mmp/mmp2-dt.c           | 12 ++++--
 arch/arm/mach-mmp/mmp2.c              |  2 +-
 arch/arm/mach-mmp/pxa168.c            |  2 +-
 arch/arm/mach-mmp/pxa910.c            |  2 +-
 drivers/clocksource/timer-mmp.c       | 72 +++++++++++++++++++++--------------
 11 files changed, 72 insertions(+), 41 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 76793a6..eed4919 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -553,6 +553,7 @@ config ARCH_MMP
 	depends on MMU
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
+	select CLKSRC_OF if OF
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GPIO_PXA
diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
index 7f70a39..29c7dc6 100644
--- a/arch/arm/boot/dts/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
@@ -24,6 +24,10 @@
 
 	soc {
 		apb at d4000000 {
+			timer0: timer at d4014000 {
+				clock-frequency = <6500000>;
+				status = "okay";
+			};
 			uart3: uart at d4018000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/pxa168-aspenite.dts b/arch/arm/boot/dts/pxa168-aspenite.dts
index 2597e98..9b3d6d9 100644
--- a/arch/arm/boot/dts/pxa168-aspenite.dts
+++ b/arch/arm/boot/dts/pxa168-aspenite.dts
@@ -25,6 +25,7 @@
 	soc {
 		apb at d4000000 {
 			timer0: timer at d4014000 {
+				clock-frequency = <3250000>;
 				status = "okay";
 			};
 			uart1: uart at d4017000 {
diff --git a/arch/arm/boot/dts/pxa910-dkb.dts b/arch/arm/boot/dts/pxa910-dkb.dts
index b892ebe..3cd1a85 100644
--- a/arch/arm/boot/dts/pxa910-dkb.dts
+++ b/arch/arm/boot/dts/pxa910-dkb.dts
@@ -33,6 +33,7 @@
 				clock-output-names = "refclk1001mhz";
 			};
 			timer0: timer at d4014000 {
+				clock-frequency = <3250000>;
 				status = "okay";
 			};
 			uart1: uart at d4017000 {
diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index 22e67c6..2415282 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -1,7 +1,7 @@
 #include <linux/reboot.h>
 #define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
 
-extern void timer_init(void __iomem *base, int irq);
+extern void timer_init(void __iomem *base, int irq, int mmp2_mode);
 
 extern void __init mmp_map_io(void);
 extern void mmp_restart(enum reboot_mode, const char *);
diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index f109bf6..8d0253b 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/clocksource.h>
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
@@ -17,8 +18,6 @@
 
 #include "common.h"
 
-extern void __init mmp_dt_init_timer(void);
-
 static const struct of_dev_auxdata pxa168_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4017000, "pxa2xx-uart.0", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4018000, "pxa2xx-uart.1", NULL),
@@ -49,7 +48,6 @@ static void __init pxa168_dt_init(void)
 
 static void __init pxa910_dt_init(void)
 {
-	of_clk_init(NULL);
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     pxa910_auxdata_lookup, NULL);
 }
@@ -60,16 +58,22 @@ static const char *mmp_dt_board_compat[] __initdata = {
 	NULL,
 };
 
+static void __init mmp_init_timer(void)
+{
+	of_clk_init(NULL);
+	clocksource_of_init();
+}
+
 DT_MACHINE_START(PXA168_DT, "Marvell PXA168 (Device Tree Support)")
 	.map_io		= mmp_map_io,
-	.init_time	= mmp_dt_init_timer,
+	.init_time	= mmp_init_timer,
 	.init_machine	= pxa168_dt_init,
 	.dt_compat	= mmp_dt_board_compat,
 MACHINE_END
 
 DT_MACHINE_START(PXA910_DT, "Marvell PXA910 (Device Tree Support)")
 	.map_io		= mmp_map_io,
-	.init_time	= mmp_dt_init_timer,
+	.init_time	= mmp_init_timer,
 	.init_machine	= pxa910_dt_init,
 	.dt_compat	= mmp_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index 023cb45..2229d1d 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -9,6 +9,8 @@
  *  publishhed by the Free Software Foundation.
  */
 
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
@@ -17,8 +19,6 @@
 
 #include "common.h"
 
-extern void __init mmp_dt_init_timer(void);
-
 static const struct of_dev_auxdata mmp2_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4030000, "pxa2xx-uart.0", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4017000, "pxa2xx-uart.1", NULL),
@@ -37,6 +37,12 @@ static void __init mmp2_dt_init(void)
 			     mmp2_auxdata_lookup, NULL);
 }
 
+static void __init mmp2_init_timer(void)
+{
+	of_clk_init(NULL);
+	clocksource_of_init();
+}
+
 static const char *mmp2_dt_board_compat[] __initdata = {
 	"mrvl,mmp2-brownstone",
 	NULL,
@@ -44,7 +50,7 @@ static const char *mmp2_dt_board_compat[] __initdata = {
 
 DT_MACHINE_START(MMP2_DT, "Marvell MMP2 (Device Tree Support)")
 	.map_io		= mmp_map_io,
-	.init_time	= mmp_dt_init_timer,
+	.init_time	= mmp2_init_timer,
 	.init_machine	= mmp2_dt_init,
 	.dt_compat	= mmp2_dt_board_compat,
 MACHINE_END
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index a0abfd7..d00c0fe 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -131,7 +131,7 @@ void __init mmp2_timer_init(void)
 	clk_rst = APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(1);
 	__raw_writel(clk_rst, APBC_TIMERS);
 
-	timer_init(TIMER1_VIRT_BASE, IRQ_MMP2_TIMER1);
+	timer_init(TIMER1_VIRT_BASE, IRQ_MMP2_TIMER1, 1);
 }
 
 /* on-chip devices */
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index a332d51..28fba2b 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -78,7 +78,7 @@ void __init pxa168_timer_init(void)
 	/* 3.25MHz, bus/functional clock enabled, release reset */
 	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
 
-	timer_init(TIMER1_VIRT_BASE, IRQ_PXA168_TIMER1);
+	timer_init(TIMER1_VIRT_BASE, IRQ_PXA168_TIMER1, 0);
 }
 
 void pxa168_clear_keypad_wakeup(void)
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 1a84800..0e98bf3 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -112,7 +112,7 @@ void __init pxa910_timer_init(void)
 	__raw_writel(APBC_APBCLK | APBC_RST, APBC_TIMERS);
 	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
 
-	timer_init(TIMER1_VIRT_BASE, IRQ_PXA910_AP1_TIMER1);
+	timer_init(TIMER1_VIRT_BASE, IRQ_PXA910_AP1_TIMER1, 0);
 }
 
 /* on-chip devices */
diff --git a/drivers/clocksource/timer-mmp.c b/drivers/clocksource/timer-mmp.c
index 937d51e..7e1fc75 100644
--- a/drivers/clocksource/timer-mmp.c
+++ b/drivers/clocksource/timer-mmp.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
+#include <linux/clk-provider.h>
 #include <linux/clockchips.h>
 
 #include <linux/io.h>
@@ -30,8 +31,6 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
-#include <mach/irqs.h>
-#include <mach/cputype.h>
 #include <asm/mach/time.h>
 
 #define TMR_CCR		(0x0000)
@@ -177,16 +176,19 @@ static struct clocksource cksrc = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
-static void __init timer_config(void)
+static void __init timer_init_clk(int mmp2_mode)
 {
 	uint32_t ccr = __raw_readl(mmp_timer_base + TMR_CCR);
 
 	__raw_writel(0x0, mmp_timer_base + TMR_CER); /* disable */
 
-	ccr &= (cpu_is_mmp2()) ? (TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
+	ccr &= mmp2_mode ? (TMR_CCR_CS_0(0) | TMR_CCR_CS_1(0)) :
 		(TMR_CCR_CS_0(3) | TMR_CCR_CS_1(3));
 	__raw_writel(ccr, mmp_timer_base + TMR_CCR);
+}
 
+static void __init timer_config(void)
+{
 	/* set timer 0 to periodic mode, and timer 1 to free-running mode */
 	__raw_writel(0x2, mmp_timer_base + TMR_CMR);
 
@@ -209,11 +211,12 @@ static struct irqaction timer_irq = {
 	.dev_id		= &ckevt,
 };
 
-void __init timer_init(void __iomem *base, int irq)
+void __init timer_init(void __iomem *base, int irq, int mmp2_mode)
 {
 	BUG_ON(!base);
 	mmp_timer_base = base;
 
+	timer_init_clk(mmp2_mode);
 	timer_config();
 
 	setup_sched_clock(mmp_read_sched_clock, 32, CLOCK_TICK_RATE);
@@ -227,36 +230,47 @@ void __init timer_init(void __iomem *base, int irq)
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
-	int irq, ret;
-
-	np = of_find_matching_node(NULL, mmp_timer_dt_ids);
-	if (!np) {
-		ret = -ENODEV;
-		goto out;
+	struct clk *clk;
+	int irq;
+	u32 rate = 0;
+
+	if (!of_device_is_available(np))
+		return;
+	if (of_property_read_u32(np, "clock-frequency", &rate)) {
+		pr_err("failed to find clock-frequency property\n");
+		return;
 	}
-
 	irq = irq_of_parse_and_map(np, 0);
-	if (!irq) {
-		ret = -EINVAL;
-		goto out;
+	if (!irq)
+		return;
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("failed to get timer clock\n");
+		return;
 	}
 	mmp_timer_base = of_iomap(np, 0);
-	if (!mmp_timer_base) {
-		ret = -ENOMEM;
+	if (!mmp_timer_base)
 		goto out;
-	}
-	timer_init(mmp_timer_base, irq);
+
+	__raw_writel(0x0, mmp_timer_base + TMR_CER); /* disable */
+	if (rate)
+		clk_set_rate(clk, rate);
+	clk_prepare_enable(clk);
+	timer_config();
+
+	setup_sched_clock(mmp_read_sched_clock, 32, rate);
+
+	ckevt.cpumask = cpumask_of(0);
+
+	setup_irq(irq, &timer_irq);
+
+	clocksource_register_hz(&cksrc, rate);
+	clockevents_config_and_register(&ckevt, rate,
+					MIN_DELTA, MAX_DELTA);
 	return;
 out:
-	pr_err("Failed to get timer from device tree with error:%d\n", ret);
+	clk_put(clk);
 }
-#endif
+CLOCKSOURCE_OF_DECLARE(mmp_timer, "mrvl,mmp-timer", mmp_dt_init_timer);
-- 
1.8.1.2
