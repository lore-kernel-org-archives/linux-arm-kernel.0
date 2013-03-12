From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 01:08:30 +0800
Subject: [PATCH v2 01/14] clocksource: move sp timer driver
In-Reply-To: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1363108124-17484-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move ARM SP804 timer driver from arch/arm directory into
drivers/clocksource directory.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Kconfig                          |    5 -
 arch/arm/common/Makefile                  |    1 -
 arch/arm/common/timer-sp.c                |  191 -----------------------------
 arch/arm/include/asm/hardware/arm_timer.h |   35 ------
 arch/arm/include/asm/hardware/timer-sp.h  |   15 ---
 arch/arm/mach-highbank/highbank.c         |    4 +-
 arch/arm/mach-integrator/integrator_ap.c  |    2 +-
 arch/arm/mach-integrator/integrator_cp.c  |    4 +-
 arch/arm/mach-realview/core.c             |    4 +-
 arch/arm/mach-versatile/core.c            |    4 +-
 arch/arm/mach-vexpress/ct-ca9x4.c         |    5 +-
 arch/arm/mach-vexpress/v2m.c              |    4 +-
 drivers/clocksource/Kconfig               |    5 +
 drivers/clocksource/Makefile              |    1 +
 drivers/clocksource/timer-sp.c            |  191 +++++++++++++++++++++++++++++
 include/clocksource/arm_timer.h           |   35 ++++++
 include/clocksource/timer-sp.h            |   19 +++
 17 files changed, 264 insertions(+), 261 deletions(-)
 delete mode 100644 arch/arm/common/timer-sp.c
 delete mode 100644 arch/arm/include/asm/hardware/arm_timer.h
 delete mode 100644 arch/arm/include/asm/hardware/timer-sp.h
 create mode 100644 drivers/clocksource/timer-sp.c
 create mode 100644 include/clocksource/arm_timer.h
 create mode 100644 include/clocksource/timer-sp.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2363926..10d7e2c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1177,11 +1177,6 @@ config PLAT_PXA
 config PLAT_VERSATILE
 	bool
 
-config ARM_TIMER_SP804
-	bool
-	select CLKSRC_MMIO
-	select HAVE_SCHED_CLOCK
-
 source arch/arm/mm/Kconfig
 
 config ARM_NR_BANKS
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 45f7eae..a4e49e7 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -12,4 +12,3 @@ obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
 obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
-obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
deleted file mode 100644
index 9d2d3ba..0000000
--- a/arch/arm/common/timer-sp.c
+++ /dev/null
@@ -1,191 +0,0 @@
-/*
- *  linux/arch/arm/common/timer-sp.c
- *
- *  Copyright (C) 1999 - 2003 ARM Limited
- *  Copyright (C) 2000 Deep Blue Solutions Ltd
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#include <linux/clk.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/err.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-
-#include <asm/sched_clock.h>
-#include <asm/hardware/arm_timer.h>
-
-static long __init sp804_get_clock_rate(const char *name)
-{
-	struct clk *clk;
-	long rate;
-	int err;
-
-	clk = clk_get_sys("sp804", name);
-	if (IS_ERR(clk)) {
-		pr_err("sp804: %s clock not found: %d\n", name,
-			(int)PTR_ERR(clk));
-		return PTR_ERR(clk);
-	}
-
-	err = clk_prepare(clk);
-	if (err) {
-		pr_err("sp804: %s clock failed to prepare: %d\n", name, err);
-		clk_put(clk);
-		return err;
-	}
-
-	err = clk_enable(clk);
-	if (err) {
-		pr_err("sp804: %s clock failed to enable: %d\n", name, err);
-		clk_unprepare(clk);
-		clk_put(clk);
-		return err;
-	}
-
-	rate = clk_get_rate(clk);
-	if (rate < 0) {
-		pr_err("sp804: %s clock failed to get rate: %ld\n", name, rate);
-		clk_disable(clk);
-		clk_unprepare(clk);
-		clk_put(clk);
-	}
-
-	return rate;
-}
-
-static void __iomem *sched_clock_base;
-
-static u32 sp804_read(void)
-{
-	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
-}
-
-void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
-						     const char *name,
-						     int use_sched_clock)
-{
-	long rate = sp804_get_clock_rate(name);
-
-	if (rate < 0)
-		return;
-
-	/* setup timer 0 as free-running clocksource */
-	writel(0, base + TIMER_CTRL);
-	writel(0xffffffff, base + TIMER_LOAD);
-	writel(0xffffffff, base + TIMER_VALUE);
-	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
-		base + TIMER_CTRL);
-
-	clocksource_mmio_init(base + TIMER_VALUE, name,
-		rate, 200, 32, clocksource_mmio_readl_down);
-
-	if (use_sched_clock) {
-		sched_clock_base = base;
-		setup_sched_clock(sp804_read, 32, rate);
-	}
-}
-
-
-static void __iomem *clkevt_base;
-static unsigned long clkevt_reload;
-
-/*
- * IRQ handler for the timer
- */
-static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	/* clear the interrupt */
-	writel(1, clkevt_base + TIMER_INTCLR);
-
-	evt->event_handler(evt);
-
-	return IRQ_HANDLED;
-}
-
-static void sp804_set_mode(enum clock_event_mode mode,
-	struct clock_event_device *evt)
-{
-	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE;
-
-	writel(ctrl, clkevt_base + TIMER_CTRL);
-
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		writel(clkevt_reload, clkevt_base + TIMER_LOAD);
-		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
-		break;
-
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* period set, and timer enabled in 'next_event' hook */
-		ctrl |= TIMER_CTRL_ONESHOT;
-		break;
-
-	case CLOCK_EVT_MODE_UNUSED:
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		break;
-	}
-
-	writel(ctrl, clkevt_base + TIMER_CTRL);
-}
-
-static int sp804_set_next_event(unsigned long next,
-	struct clock_event_device *evt)
-{
-	unsigned long ctrl = readl(clkevt_base + TIMER_CTRL);
-
-	writel(next, clkevt_base + TIMER_LOAD);
-	writel(ctrl | TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
-
-	return 0;
-}
-
-static struct clock_event_device sp804_clockevent = {
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.set_mode	= sp804_set_mode,
-	.set_next_event	= sp804_set_next_event,
-	.rating		= 300,
-};
-
-static struct irqaction sp804_timer_irq = {
-	.name		= "timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= sp804_timer_interrupt,
-	.dev_id		= &sp804_clockevent,
-};
-
-void __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
-	const char *name)
-{
-	struct clock_event_device *evt = &sp804_clockevent;
-	long rate = sp804_get_clock_rate(name);
-
-	if (rate < 0)
-		return;
-
-	clkevt_base = base;
-	clkevt_reload = DIV_ROUND_CLOSEST(rate, HZ);
-	evt->name = name;
-	evt->irq = irq;
-	evt->cpumask = cpu_possible_mask;
-
-	setup_irq(irq, &sp804_timer_irq);
-	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
-}
diff --git a/arch/arm/include/asm/hardware/arm_timer.h b/arch/arm/include/asm/hardware/arm_timer.h
deleted file mode 100644
index d6030ff..0000000
--- a/arch/arm/include/asm/hardware/arm_timer.h
+++ /dev/null
@@ -1,35 +0,0 @@
-#ifndef __ASM_ARM_HARDWARE_ARM_TIMER_H
-#define __ASM_ARM_HARDWARE_ARM_TIMER_H
-
-/*
- * ARM timer implementation, found in Integrator, Versatile and Realview
- * platforms.  Not all platforms support all registers and bits in these
- * registers, so we mark them with A for Integrator AP, C for Integrator
- * CP, V for Versatile and R for Realview.
- *
- * Integrator AP has 16-bit timers, Integrator CP, Versatile and Realview
- * can have 16-bit or 32-bit selectable via a bit in the control register.
- *
- * Every SP804 contains two identical timers.
- */
-#define TIMER_1_BASE	0x00
-#define TIMER_2_BASE	0x20
-
-#define TIMER_LOAD	0x00			/* ACVR rw */
-#define TIMER_VALUE	0x04			/* ACVR ro */
-#define TIMER_CTRL	0x08			/* ACVR rw */
-#define TIMER_CTRL_ONESHOT	(1 << 0)	/*  CVR */
-#define TIMER_CTRL_32BIT	(1 << 1)	/*  CVR */
-#define TIMER_CTRL_DIV1		(0 << 2)	/* ACVR */
-#define TIMER_CTRL_DIV16	(1 << 2)	/* ACVR */
-#define TIMER_CTRL_DIV256	(2 << 2)	/* ACVR */
-#define TIMER_CTRL_IE		(1 << 5)	/*   VR */
-#define TIMER_CTRL_PERIODIC	(1 << 6)	/* ACVR */
-#define TIMER_CTRL_ENABLE	(1 << 7)	/* ACVR */
-
-#define TIMER_INTCLR	0x0c			/* ACVR wo */
-#define TIMER_RIS	0x10			/*  CVR ro */
-#define TIMER_MIS	0x14			/*  CVR ro */
-#define TIMER_BGLOAD	0x18			/*  CVR rw */
-
-#endif
diff --git a/arch/arm/include/asm/hardware/timer-sp.h b/arch/arm/include/asm/hardware/timer-sp.h
deleted file mode 100644
index 2dd9d3f..0000000
--- a/arch/arm/include/asm/hardware/timer-sp.h
+++ /dev/null
@@ -1,15 +0,0 @@
-void __sp804_clocksource_and_sched_clock_init(void __iomem *,
-					      const char *, int);
-
-static inline void sp804_clocksource_init(void __iomem *base, const char *name)
-{
-	__sp804_clocksource_and_sched_clock_init(base, name, 0);
-}
-
-static inline void sp804_clocksource_and_sched_clock_init(void __iomem *base,
-							  const char *name)
-{
-	__sp804_clocksource_and_sched_clock_init(base, name, 1);
-}
-
-void sp804_clockevents_init(void __iomem *, unsigned int, const char *);
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index a4f9f50..cfd843b 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -27,14 +27,14 @@
 #include <linux/smp.h>
 #include <linux/amba/bus.h>
 #include <linux/clk-provider.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <asm/arch_timer.h>
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_twd.h>
-#include <asm/hardware/arm_timer.h>
-#include <asm/hardware/timer-sp.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index ea96144..c2112ff 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -41,11 +41,11 @@
 #include <linux/stat.h>
 #include <linux/sys_soc.h>
 #include <linux/termios.h>
+#include <clocksource/arm_timer.h>
 #include <video/vga.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/setup.h>
 #include <asm/param.h>		/* HZ */
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 2b0db82..40373ec 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -28,12 +28,13 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/sys_soc.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 
 #include <mach/cm.h>
@@ -45,7 +46,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <asm/hardware/timer-sp.h>
 
 #include <plat/clcd.h>
 #include <plat/sched_clock.h>
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 1d5ee5c..26a3da38 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -31,11 +31,12 @@
 #include <linux/amba/mmci.h>
 #include <linux/gfp.h>
 #include <linux/mtd/physmap.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 
 #include <asm/mach/arch.h>
@@ -45,7 +46,6 @@
 
 #include <mach/platform.h>
 #include <mach/irqs.h>
-#include <asm/hardware/timer-sp.h>
 
 #include <plat/clcd.h>
 #include <plat/sched_clock.h>
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 25160ae..e894a1f 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -38,9 +38,10 @@
 #include <linux/clkdev.h>
 #include <linux/mtd/physmap.h>
 #include <linux/bitops.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <asm/irq.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 #include <asm/mach-types.h>
 
@@ -50,7 +51,6 @@
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <asm/hardware/timer-sp.h>
 
 #include <plat/clcd.h>
 #include <plat/sched_clock.h>
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 6f34497..48f6676 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -11,16 +11,15 @@
 #include <linux/clkdev.h>
 #include <linux/vexpress.h>
 #include <linux/irqchip/arm-gic.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
 
 #include <mach/ct-ca9x4.h>
 
-#include <asm/hardware/timer-sp.h>
-
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 915683c..51e8701 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -21,6 +21,8 @@
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/vexpress.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <asm/arch_timer.h>
 #include <asm/mach-types.h>
@@ -29,9 +31,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/hardware/timer-sp.h>
 
 #include <mach/ct-ca9x4.h>
 #include <mach/motherboard.h>
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index e8c4532..4c04d19 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -63,6 +63,11 @@ config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
 config ARM_ARCH_TIMER
 	bool
 
+config ARM_TIMER_SP804
+	bool
+	select CLKSRC_MMIO
+	select HAVE_SCHED_CLOCK
+
 config CLKSRC_METAG_GENERIC
 	def_bool y if METAG
 	help
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 1c1b15d..9d3ad88 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -22,4 +22,5 @@ obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
 obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
 
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
+obj-$(CONFIG_ARM_TIMER_SP804)		+= timer-sp.o
 obj-$(CONFIG_CLKSRC_METAG_GENERIC)	+= metag_generic.o
diff --git a/drivers/clocksource/timer-sp.c b/drivers/clocksource/timer-sp.c
new file mode 100644
index 0000000..a7f2510
--- /dev/null
+++ b/drivers/clocksource/timer-sp.c
@@ -0,0 +1,191 @@
+/*
+ *  linux/arch/arm/common/timer-sp.c
+ *
+ *  Copyright (C) 1999 - 2003 ARM Limited
+ *  Copyright (C) 2000 Deep Blue Solutions Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <clocksource/arm_timer.h>
+
+#include <asm/sched_clock.h>
+
+static long __init sp804_get_clock_rate(const char *name)
+{
+	struct clk *clk;
+	long rate;
+	int err;
+
+	clk = clk_get_sys("sp804", name);
+	if (IS_ERR(clk)) {
+		pr_err("sp804: %s clock not found: %d\n", name,
+			(int)PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	err = clk_prepare(clk);
+	if (err) {
+		pr_err("sp804: %s clock failed to prepare: %d\n", name, err);
+		clk_put(clk);
+		return err;
+	}
+
+	err = clk_enable(clk);
+	if (err) {
+		pr_err("sp804: %s clock failed to enable: %d\n", name, err);
+		clk_unprepare(clk);
+		clk_put(clk);
+		return err;
+	}
+
+	rate = clk_get_rate(clk);
+	if (rate < 0) {
+		pr_err("sp804: %s clock failed to get rate: %ld\n", name, rate);
+		clk_disable(clk);
+		clk_unprepare(clk);
+		clk_put(clk);
+	}
+
+	return rate;
+}
+
+static void __iomem *sched_clock_base;
+
+static u32 sp804_read(void)
+{
+	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
+}
+
+void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
+						     const char *name,
+						     int use_sched_clock)
+{
+	long rate = sp804_get_clock_rate(name);
+
+	if (rate < 0)
+		return;
+
+	/* setup timer 0 as free-running clocksource */
+	writel(0, base + TIMER_CTRL);
+	writel(0xffffffff, base + TIMER_LOAD);
+	writel(0xffffffff, base + TIMER_VALUE);
+	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
+		base + TIMER_CTRL);
+
+	clocksource_mmio_init(base + TIMER_VALUE, name,
+		rate, 200, 32, clocksource_mmio_readl_down);
+
+	if (use_sched_clock) {
+		sched_clock_base = base;
+		setup_sched_clock(sp804_read, 32, rate);
+	}
+}
+
+
+static void __iomem *clkevt_base;
+static unsigned long clkevt_reload;
+
+/*
+ * IRQ handler for the timer
+ */
+static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	/* clear the interrupt */
+	writel(1, clkevt_base + TIMER_INTCLR);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static void sp804_set_mode(enum clock_event_mode mode,
+	struct clock_event_device *evt)
+{
+	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE;
+
+	writel(ctrl, clkevt_base + TIMER_CTRL);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		writel(clkevt_reload, clkevt_base + TIMER_LOAD);
+		ctrl |= TIMER_CTRL_PERIODIC | TIMER_CTRL_ENABLE;
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* period set, and timer enabled in 'next_event' hook */
+		ctrl |= TIMER_CTRL_ONESHOT;
+		break;
+
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	default:
+		break;
+	}
+
+	writel(ctrl, clkevt_base + TIMER_CTRL);
+}
+
+static int sp804_set_next_event(unsigned long next,
+	struct clock_event_device *evt)
+{
+	unsigned long ctrl = readl(clkevt_base + TIMER_CTRL);
+
+	writel(next, clkevt_base + TIMER_LOAD);
+	writel(ctrl | TIMER_CTRL_ENABLE, clkevt_base + TIMER_CTRL);
+
+	return 0;
+}
+
+static struct clock_event_device sp804_clockevent = {
+	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.set_mode	= sp804_set_mode,
+	.set_next_event	= sp804_set_next_event,
+	.rating		= 300,
+};
+
+static struct irqaction sp804_timer_irq = {
+	.name		= "timer",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= sp804_timer_interrupt,
+	.dev_id		= &sp804_clockevent,
+};
+
+void __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
+	const char *name)
+{
+	struct clock_event_device *evt = &sp804_clockevent;
+	long rate = sp804_get_clock_rate(name);
+
+	if (rate < 0)
+		return;
+
+	clkevt_base = base;
+	clkevt_reload = DIV_ROUND_CLOSEST(rate, HZ);
+	evt->name = name;
+	evt->irq = irq;
+	evt->cpumask = cpu_possible_mask;
+
+	setup_irq(irq, &sp804_timer_irq);
+	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
+}
diff --git a/include/clocksource/arm_timer.h b/include/clocksource/arm_timer.h
new file mode 100644
index 0000000..f4a443a
--- /dev/null
+++ b/include/clocksource/arm_timer.h
@@ -0,0 +1,35 @@
+#ifndef __CLOCKSOURCE_ARM_TIMER_H
+#define __CLOCKSOURCE_ARM_TIMER_H
+
+/*
+ * ARM timer implementation, found in Integrator, Versatile and Realview
+ * platforms.  Not all platforms support all registers and bits in these
+ * registers, so we mark them with A for Integrator AP, C for Integrator
+ * CP, V for Versatile and R for Realview.
+ *
+ * Integrator AP has 16-bit timers, Integrator CP, Versatile and Realview
+ * can have 16-bit or 32-bit selectable via a bit in the control register.
+ *
+ * Every SP804 contains two identical timers.
+ */
+#define TIMER_1_BASE	0x00
+#define TIMER_2_BASE	0x20
+
+#define TIMER_LOAD	0x00			/* ACVR rw */
+#define TIMER_VALUE	0x04			/* ACVR ro */
+#define TIMER_CTRL	0x08			/* ACVR rw */
+#define TIMER_CTRL_ONESHOT	(1 << 0)	/*  CVR */
+#define TIMER_CTRL_32BIT	(1 << 1)	/*  CVR */
+#define TIMER_CTRL_DIV1		(0 << 2)	/* ACVR */
+#define TIMER_CTRL_DIV16	(1 << 2)	/* ACVR */
+#define TIMER_CTRL_DIV256	(2 << 2)	/* ACVR */
+#define TIMER_CTRL_IE		(1 << 5)	/*   VR */
+#define TIMER_CTRL_PERIODIC	(1 << 6)	/* ACVR */
+#define TIMER_CTRL_ENABLE	(1 << 7)	/* ACVR */
+
+#define TIMER_INTCLR	0x0c			/* ACVR wo */
+#define TIMER_RIS	0x10			/*  CVR ro */
+#define TIMER_MIS	0x14			/*  CVR ro */
+#define TIMER_BGLOAD	0x18			/*  CVR rw */
+
+#endif
diff --git a/include/clocksource/timer-sp.h b/include/clocksource/timer-sp.h
new file mode 100644
index 0000000..0ad4186
--- /dev/null
+++ b/include/clocksource/timer-sp.h
@@ -0,0 +1,19 @@
+#ifndef __TIMER_SP_H
+#define __TIMER_SP_H
+
+void __sp804_clocksource_and_sched_clock_init(void __iomem *,
+					      const char *, int);
+
+static inline void sp804_clocksource_init(void __iomem *base, const char *name)
+{
+	__sp804_clocksource_and_sched_clock_init(base, name, 0);
+}
+
+static inline void sp804_clocksource_and_sched_clock_init(void __iomem *base,
+							  const char *name)
+{
+	__sp804_clocksource_and_sched_clock_init(base, name, 1);
+}
+
+void sp804_clockevents_init(void __iomem *, unsigned int, const char *);
+#endif	/* __TIMER_SP_H */
-- 
1.7.10.4
