From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 1 Aug 2014 11:58:55 +0800
Subject: [PATCH 2/3] clocksource: move arm dual timer into drivers/clocksource
In-Reply-To: <1406865536-23984-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1406865536-23984-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1406865536-23984-3-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move arm dual timer sp804 into drivers/clocksource, update the Kconfig,
makefile, so the code is co-located with other clocksource drivers, and
the sp804 can be enabled by ARM/ARM64.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/Kconfig                          |   5 -
 arch/arm/common/Makefile                  |   1 -
 arch/arm/common/timer-sp.c                | 304 ------------------------------
 arch/arm/include/asm/hardware/arm_timer.h |  35 ----
 arch/arm/include/asm/hardware/timer-sp.h  |  23 ---
 arch/arm/mach-integrator/integrator_ap.c  |   2 +-
 arch/arm/mach-realview/core.c             |   5 +-
 arch/arm/mach-versatile/core.c            |   5 +-
 arch/arm/mach-vexpress/v2m.c              |   5 +-
 drivers/clocksource/Kconfig               |   7 +
 drivers/clocksource/Makefile              |   1 +
 drivers/clocksource/timer-sp.c            | 304 ++++++++++++++++++++++++++++++
 include/clocksource/arm_timer.h           |  35 ++++
 include/clocksource/timer-sp.h            |  23 +++
 14 files changed, 380 insertions(+), 375 deletions(-)
 delete mode 100644 arch/arm/common/timer-sp.c
 delete mode 100644 arch/arm/include/asm/hardware/arm_timer.h
 delete mode 100644 arch/arm/include/asm/hardware/timer-sp.h
 create mode 100644 drivers/clocksource/timer-sp.c
 create mode 100644 include/clocksource/arm_timer.h
 create mode 100644 include/clocksource/timer-sp.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 88acf8b..f7c62b8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1062,11 +1062,6 @@ config PLAT_PXA
 config PLAT_VERSATILE
 	bool
 
-config ARM_TIMER_SP804
-	bool
-	select CLKSRC_MMIO
-	select CLKSRC_OF if OF
-
 source "arch/arm/firmware/Kconfig"
 
 source arch/arm/mm/Kconfig
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 70b1eff..6ee5959 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
 obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
-obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
 obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
 CFLAGS_REMOVE_mcpm_entry.o	= -pg
 AFLAGS_mcpm_head.o		:= -march=armv7-a
diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
deleted file mode 100644
index fd6bff0..0000000
--- a/arch/arm/common/timer-sp.c
+++ /dev/null
@@ -1,304 +0,0 @@
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
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/sched_clock.h>
-
-#include <asm/hardware/arm_timer.h>
-#include <asm/hardware/timer-sp.h>
-
-static long __init sp804_get_clock_rate(struct clk *clk)
-{
-	long rate;
-	int err;
-
-	err = clk_prepare(clk);
-	if (err) {
-		pr_err("sp804: clock failed to prepare: %d\n", err);
-		clk_put(clk);
-		return err;
-	}
-
-	err = clk_enable(clk);
-	if (err) {
-		pr_err("sp804: clock failed to enable: %d\n", err);
-		clk_unprepare(clk);
-		clk_put(clk);
-		return err;
-	}
-
-	rate = clk_get_rate(clk);
-	if (rate < 0) {
-		pr_err("sp804: clock failed to get rate: %ld\n", rate);
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
-static u64 notrace sp804_read(void)
-{
-	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
-}
-
-void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
-						     const char *name,
-						     struct clk *clk,
-						     int use_sched_clock)
-{
-	long rate;
-
-	if (!clk) {
-		clk = clk_get_sys("sp804", name);
-		if (IS_ERR(clk)) {
-			pr_err("sp804: clock not found: %d\n",
-			       (int)PTR_ERR(clk));
-			return;
-		}
-	}
-
-	rate = sp804_get_clock_rate(clk);
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
-		sched_clock_register(sp804_read, 32, rate);
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
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
-		CLOCK_EVT_FEAT_DYNIRQ,
-	.set_mode	= sp804_set_mode,
-	.set_next_event	= sp804_set_next_event,
-	.rating		= 300,
-};
-
-static struct irqaction sp804_timer_irq = {
-	.name		= "timer",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= sp804_timer_interrupt,
-	.dev_id		= &sp804_clockevent,
-};
-
-void __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct clk *clk, const char *name)
-{
-	struct clock_event_device *evt = &sp804_clockevent;
-	long rate;
-
-	if (!clk)
-		clk = clk_get_sys("sp804", name);
-	if (IS_ERR(clk)) {
-		pr_err("sp804: %s clock not found: %d\n", name,
-			(int)PTR_ERR(clk));
-		return;
-	}
-
-	rate = sp804_get_clock_rate(clk);
-	if (rate < 0)
-		return;
-
-	clkevt_base = base;
-	clkevt_reload = DIV_ROUND_CLOSEST(rate, HZ);
-	evt->name = name;
-	evt->irq = irq;
-	evt->cpumask = cpu_possible_mask;
-
-	writel(0, base + TIMER_CTRL);
-
-	setup_irq(irq, &sp804_timer_irq);
-	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
-}
-
-static void __init sp804_of_init(struct device_node *np)
-{
-	static bool initialized = false;
-	void __iomem *base;
-	int irq;
-	u32 irq_num = 0;
-	struct clk *clk1, *clk2;
-	const char *name = of_get_property(np, "compatible", NULL);
-
-	base = of_iomap(np, 0);
-	if (WARN_ON(!base))
-		return;
-
-	/* Ensure timers are disabled */
-	writel(0, base + TIMER_CTRL);
-	writel(0, base + TIMER_2_BASE + TIMER_CTRL);
-
-	if (initialized || !of_device_is_available(np))
-		goto err;
-
-	clk1 = of_clk_get(np, 0);
-	if (IS_ERR(clk1))
-		clk1 = NULL;
-
-	/* Get the 2nd clock if the timer has 2 timer clocks */
-	if (of_count_phandle_with_args(np, "clocks", "#clock-cells") == 3) {
-		clk2 = of_clk_get(np, 1);
-		if (IS_ERR(clk2)) {
-			pr_err("sp804: %s clock not found: %d\n", np->name,
-				(int)PTR_ERR(clk2));
-			goto err;
-		}
-	} else
-		clk2 = clk1;
-
-	irq = irq_of_parse_and_map(np, 0);
-	if (irq <= 0)
-		goto err;
-
-	of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
-	if (irq_num == 2) {
-		__sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
-		__sp804_clocksource_and_sched_clock_init(base, name, clk1, 1);
-	} else {
-		__sp804_clockevents_init(base, irq, clk1 , name);
-		__sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
-							 name, clk2, 1);
-	}
-	initialized = true;
-
-	return;
-err:
-	iounmap(base);
-}
-CLOCKSOURCE_OF_DECLARE(sp804, "arm,sp804", sp804_of_init);
-
-static void __init integrator_cp_of_init(struct device_node *np)
-{
-	static int init_count = 0;
-	void __iomem *base;
-	int irq;
-	const char *name = of_get_property(np, "compatible", NULL);
-	struct clk *clk;
-
-	base = of_iomap(np, 0);
-	if (WARN_ON(!base))
-		return;
-	clk = of_clk_get(np, 0);
-	if (WARN_ON(IS_ERR(clk)))
-		return;
-
-	/* Ensure timer is disabled */
-	writel(0, base + TIMER_CTRL);
-
-	if (init_count == 2 || !of_device_is_available(np))
-		goto err;
-
-	if (!init_count)
-		__sp804_clocksource_and_sched_clock_init(base, name, clk, 0);
-	else {
-		irq = irq_of_parse_and_map(np, 0);
-		if (irq <= 0)
-			goto err;
-
-		__sp804_clockevents_init(base, irq, clk, name);
-	}
-
-	init_count++;
-	return;
-err:
-	iounmap(base);
-}
-CLOCKSOURCE_OF_DECLARE(intcp, "arm,integrator-cp-timer", integrator_cp_of_init);
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
index bb28af7..0000000
--- a/arch/arm/include/asm/hardware/timer-sp.h
+++ /dev/null
@@ -1,23 +0,0 @@
-struct clk;
-
-void __sp804_clocksource_and_sched_clock_init(void __iomem *,
-					      const char *, struct clk *, int);
-void __sp804_clockevents_init(void __iomem *, unsigned int,
-			      struct clk *, const char *);
-
-static inline void sp804_clocksource_init(void __iomem *base, const char *name)
-{
-	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 0);
-}
-
-static inline void sp804_clocksource_and_sched_clock_init(void __iomem *base,
-							  const char *name)
-{
-	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 1);
-}
-
-static inline void sp804_clockevents_init(void __iomem *base, unsigned int irq, const char *name)
-{
-	__sp804_clockevents_init(base, irq, NULL, name);
-
-}
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index 660ca6f..4b42d8a 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -44,7 +44,7 @@
 #include <linux/sched_clock.h>
 #include <linux/clk-provider.h>
 
-#include <asm/hardware/arm_timer.h>
+#include <clocksource/arm_timer.h>
 #include <asm/setup.h>
 #include <asm/param.h>		/* HZ */
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 8c1b39a..e221838 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -36,7 +36,6 @@
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 
 #include <asm/mach/arch.h>
@@ -46,7 +45,9 @@
 
 #include <mach/platform.h>
 #include <mach/irqs.h>
-#include <asm/hardware/timer-sp.h>
+
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <plat/clcd.h>
 #include <plat/sched_clock.h>
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index be83ba2..21234a8 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -41,7 +41,6 @@
 #include <linux/reboot.h>
 
 #include <asm/irq.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 #include <asm/mach-types.h>
 
@@ -51,7 +50,9 @@
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <asm/hardware/timer-sp.h>
+
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <plat/clcd.h>
 #include <plat/sched_clock.h>
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 6ff681a..161a8e4 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -27,9 +27,10 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/hardware/timer-sp.h>
+
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <mach/ct-ca9x4.h>
 #include <mach/motherboard.h>
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 065131c..80ca5f7 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -111,6 +111,13 @@ config ARM_GLOBAL_TIMER
 	help
 	  This options enables support for the ARM global timer unit
 
+config ARM_TIMER_SP804
+	bool
+	select CLKSRC_MMIO
+	select CLKSRC_OF if OF
+	help
+	  This options enables support for the ARM dual timer sp804
+
 config CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	bool
 	depends on ARM_GLOBAL_TIMER
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 800b130..5934b3b 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_CLKSRC_QCOM)	+= qcom-timer.o
 
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
 obj-$(CONFIG_ARM_GLOBAL_TIMER)		+= arm_global_timer.o
+obj-$(CONFIG_ARM_TIMER_SP804)		+= timer-sp.o
 obj-$(CONFIG_CLKSRC_METAG_GENERIC)	+= metag_generic.o
 obj-$(CONFIG_ARCH_HAS_TICK_BROADCAST)	+= dummy_timer.o
 obj-$(CONFIG_ARCH_KEYSTONE)		+= timer-keystone.o
diff --git a/drivers/clocksource/timer-sp.c b/drivers/clocksource/timer-sp.c
new file mode 100644
index 0000000..82b27c0
--- /dev/null
+++ b/drivers/clocksource/timer-sp.c
@@ -0,0 +1,304 @@
+/*
+ *  linux/driver/clocksource/timer-sp.c
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
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
+
+static long __init sp804_get_clock_rate(struct clk *clk)
+{
+	long rate;
+	int err;
+
+	err = clk_prepare(clk);
+	if (err) {
+		pr_err("sp804: clock failed to prepare: %d\n", err);
+		clk_put(clk);
+		return err;
+	}
+
+	err = clk_enable(clk);
+	if (err) {
+		pr_err("sp804: clock failed to enable: %d\n", err);
+		clk_unprepare(clk);
+		clk_put(clk);
+		return err;
+	}
+
+	rate = clk_get_rate(clk);
+	if (rate < 0) {
+		pr_err("sp804: clock failed to get rate: %ld\n", rate);
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
+static u64 notrace sp804_read(void)
+{
+	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
+}
+
+void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
+						     const char *name,
+						     struct clk *clk,
+						     int use_sched_clock)
+{
+	long rate;
+
+	if (!clk) {
+		clk = clk_get_sys("sp804", name);
+		if (IS_ERR(clk)) {
+			pr_err("sp804: clock not found: %d\n",
+			       (int)PTR_ERR(clk));
+			return;
+		}
+	}
+
+	rate = sp804_get_clock_rate(clk);
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
+		sched_clock_register(sp804_read, 32, rate);
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
+	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
+		CLOCK_EVT_FEAT_DYNIRQ,
+	.set_mode	= sp804_set_mode,
+	.set_next_event	= sp804_set_next_event,
+	.rating		= 300,
+};
+
+static struct irqaction sp804_timer_irq = {
+	.name		= "timer",
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= sp804_timer_interrupt,
+	.dev_id		= &sp804_clockevent,
+};
+
+void __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struct clk *clk, const char *name)
+{
+	struct clock_event_device *evt = &sp804_clockevent;
+	long rate;
+
+	if (!clk)
+		clk = clk_get_sys("sp804", name);
+	if (IS_ERR(clk)) {
+		pr_err("sp804: %s clock not found: %d\n", name,
+			(int)PTR_ERR(clk));
+		return;
+	}
+
+	rate = sp804_get_clock_rate(clk);
+	if (rate < 0)
+		return;
+
+	clkevt_base = base;
+	clkevt_reload = DIV_ROUND_CLOSEST(rate, HZ);
+	evt->name = name;
+	evt->irq = irq;
+	evt->cpumask = cpu_possible_mask;
+
+	writel(0, base + TIMER_CTRL);
+
+	setup_irq(irq, &sp804_timer_irq);
+	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
+}
+
+static void __init sp804_of_init(struct device_node *np)
+{
+	static bool initialized = false;
+	void __iomem *base;
+	int irq;
+	u32 irq_num = 0;
+	struct clk *clk1, *clk2;
+	const char *name = of_get_property(np, "compatible", NULL);
+
+	base = of_iomap(np, 0);
+	if (WARN_ON(!base))
+		return;
+
+	/* Ensure timers are disabled */
+	writel(0, base + TIMER_CTRL);
+	writel(0, base + TIMER_2_BASE + TIMER_CTRL);
+
+	if (initialized || !of_device_is_available(np))
+		goto err;
+
+	clk1 = of_clk_get(np, 0);
+	if (IS_ERR(clk1))
+		clk1 = NULL;
+
+	/* Get the 2nd clock if the timer has 2 timer clocks */
+	if (of_count_phandle_with_args(np, "clocks", "#clock-cells") == 3) {
+		clk2 = of_clk_get(np, 1);
+		if (IS_ERR(clk2)) {
+			pr_err("sp804: %s clock not found: %d\n", np->name,
+				(int)PTR_ERR(clk2));
+			goto err;
+		}
+	} else
+		clk2 = clk1;
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq <= 0)
+		goto err;
+
+	of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
+	if (irq_num == 2) {
+		__sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
+		__sp804_clocksource_and_sched_clock_init(base, name, clk1, 1);
+	} else {
+		__sp804_clockevents_init(base, irq, clk1 , name);
+		__sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
+							 name, clk2, 1);
+	}
+	initialized = true;
+
+	return;
+err:
+	iounmap(base);
+}
+CLOCKSOURCE_OF_DECLARE(sp804, "arm,sp804", sp804_of_init);
+
+static void __init integrator_cp_of_init(struct device_node *np)
+{
+	static int init_count = 0;
+	void __iomem *base;
+	int irq;
+	const char *name = of_get_property(np, "compatible", NULL);
+	struct clk *clk;
+
+	base = of_iomap(np, 0);
+	if (WARN_ON(!base))
+		return;
+	clk = of_clk_get(np, 0);
+	if (WARN_ON(IS_ERR(clk)))
+		return;
+
+	/* Ensure timer is disabled */
+	writel(0, base + TIMER_CTRL);
+
+	if (init_count == 2 || !of_device_is_available(np))
+		goto err;
+
+	if (!init_count)
+		__sp804_clocksource_and_sched_clock_init(base, name, clk, 0);
+	else {
+		irq = irq_of_parse_and_map(np, 0);
+		if (irq <= 0)
+			goto err;
+
+		__sp804_clockevents_init(base, irq, clk, name);
+	}
+
+	init_count++;
+	return;
+err:
+	iounmap(base);
+}
+CLOCKSOURCE_OF_DECLARE(intcp, "arm,integrator-cp-timer", integrator_cp_of_init);
diff --git a/include/clocksource/arm_timer.h b/include/clocksource/arm_timer.h
new file mode 100644
index 0000000..b94da5d
--- /dev/null
+++ b/include/clocksource/arm_timer.h
@@ -0,0 +1,35 @@
+#ifndef __CLKSOURCE_ARM_TIMER_H
+#define __CLKSOURCE_ARM_TIMER_H
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
index 0000000..bb28af7
--- /dev/null
+++ b/include/clocksource/timer-sp.h
@@ -0,0 +1,23 @@
+struct clk;
+
+void __sp804_clocksource_and_sched_clock_init(void __iomem *,
+					      const char *, struct clk *, int);
+void __sp804_clockevents_init(void __iomem *, unsigned int,
+			      struct clk *, const char *);
+
+static inline void sp804_clocksource_init(void __iomem *base, const char *name)
+{
+	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 0);
+}
+
+static inline void sp804_clocksource_and_sched_clock_init(void __iomem *base,
+							  const char *name)
+{
+	__sp804_clocksource_and_sched_clock_init(base, name, NULL, 1);
+}
+
+static inline void sp804_clockevents_init(void __iomem *base, unsigned int irq, const char *name)
+{
+	__sp804_clockevents_init(base, irq, NULL, name);
+
+}
-- 
1.7.12.4
