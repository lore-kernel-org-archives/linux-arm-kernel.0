From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Mar 2011 15:12:52 +0000
Subject: [RFC PATCHv2 09/20] ARM: architected timers: add A15 architected
	timers
In-Reply-To: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
References: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1300201983-26124-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM architecture provides a set of optional system timers that
can be used as clocksources for local timer events.

This patch adds support for these timers, giving them priority over
any private timers if they are detected at runtime.

A global counter is also used to implement a clock source.

Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/Kconfig                                |    7 +-
 arch/arm/include/asm/arch_timer.h               |   13 ++
 arch/arm/include/asm/hardware/entry-macro-gic.S |   18 ++
 arch/arm/kernel/Makefile                        |    1 +
 arch/arm/kernel/arch_timer.c                    |  223 +++++++++++++++++++++++
 5 files changed, 261 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/include/asm/arch_timer.h
 create mode 100644 arch/arm/kernel/arch_timer.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b7e504b..38ee56e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1407,9 +1407,14 @@ config HOTPLUG_CPU
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
 
+config HAVE_ARCH_TIMERS
+	bool
+	depends on CPU_V7
+	select TICK_ONESHOT
+
 config LOCAL_TIMERS
 	bool
-	depends on SMP || ARCH_MSM_SCORPIONMP
+	depends on SMP || HAVE_ARCH_TIMERS || ARCH_MSM_SCORPIONMP
 	default y
 	help
 	  Enable support for local timers on SMP platforms, rather then the
diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
new file mode 100644
index 0000000..f98263c
--- /dev/null
+++ b/arch/arm/include/asm/arch_timer.h
@@ -0,0 +1,13 @@
+#ifndef __ASMARM_ARCH_TIMER_H
+#define __ASMARM_ARCH_TIMER_H
+
+#ifdef CONFIG_HAVE_ARCH_TIMERS
+int arch_timer_register_setup(void (*setup)(struct clock_event_device *));
+#else
+static inline int arch_timer_register_setup(void (*setup)(struct clock_event_device *))
+{
+	return -ENODEV;
+}
+#endif
+
+#endif
diff --git a/arch/arm/include/asm/hardware/entry-macro-gic.S b/arch/arm/include/asm/hardware/entry-macro-gic.S
index c115b82..b362a1e 100644
--- a/arch/arm/include/asm/hardware/entry-macro-gic.S
+++ b/arch/arm/include/asm/hardware/entry-macro-gic.S
@@ -67,8 +67,26 @@
 
 	.macro test_for_ltirq, irqnr, irqstat, base, tmp
 	bic	\irqnr, \irqstat, #0x1c00
+#ifdef CONFIG_HAVE_ARCH_TIMERS
+	/*
+	 * We need to check for both PPI 29 and 30, as we have no way
+	 * to know whether we're running in normal or secure mode.
+	 * We cannot check for the architected timers being available,
+	 * as the feature register may be virtualised (slow access).
+	 * Check for an A15 instead.
+	 * If this matches, check for PPI 30. Otherwise, fallback
+	 * to the the usual 29.
+	 */
+	mrc	p15, 0, \tmp, c0, c0, 0
+	and	\tmp, \tmp, #0xff0
+	teq	\tmp, #0x0f0
+	cmpeq	\irqnr, #30
+	movne 	\tmp, #0
+	cmpne	\irqnr, #29
+#else
 	mov 	\tmp, #0
 	cmp	\irqnr, #29
+#endif
 	moveq	\tmp, #1
 	streq	\irqstat, [\base, #GIC_CPU_EOI]
 	cmp	\tmp, #0
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 277f6ff..add5e77 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_PM)		+= sleep.o
 obj-$(CONFIG_HAVE_SCHED_CLOCK)	+= sched_clock.o
 obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o
 obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
+obj-$(CONFIG_HAVE_ARCH_TIMERS)	+= arch_timer.o
 obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= percpu_timer.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
new file mode 100644
index 0000000..bc05604
--- /dev/null
+++ b/arch/arm/kernel/arch_timer.c
@@ -0,0 +1,223 @@
+/*
+ *  linux/arch/arm/kernel/arch_timer.c
+ *
+ *  Copyright (C) 2011 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/smp.h>
+#include <linux/jiffies.h>
+#include <linux/clockchips.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+
+#include <asm/cputype.h>
+#include <asm/localtimer.h>
+#include <asm/hardware/gic.h>
+
+static unsigned long arch_timer_rate;
+
+/*
+ * Architected system timer support.
+ */
+
+#define ARCH_TIMER_CTRL_ENABLE		(1 << 0)
+#define ARCH_TIMER_CTRL_IT_MASK		(1 << 1)
+
+#define ARCH_TIMER_REG_CTRL		0
+#define ARCH_TIMER_REG_FREQ		1
+#define ARCH_TIMER_REG_TVAL		2
+
+static void arch_timer_reg_write(int reg, u32 val)
+{
+	switch (reg) {
+	case ARCH_TIMER_REG_CTRL:
+		asm volatile("mcr p15, 0, %0, c14, c2, 1" : : "r" (val));
+		break;
+	case ARCH_TIMER_REG_TVAL:
+		asm volatile("mcr p15, 0, %0, c14, c2, 0" : : "r" (val));
+		break;
+	}
+
+	isb();
+}
+
+static u32 arch_timer_reg_read(int reg)
+{
+	u32 val;
+
+	switch (reg) {
+	case ARCH_TIMER_REG_CTRL:
+		asm volatile("mrc p15, 0, %0, c14, c2, 1" : "=r" (val));
+		break;
+	case ARCH_TIMER_REG_FREQ:
+		asm volatile("mrc p15, 0, %0, c14, c0, 0" : "=r" (val));
+		break;
+	case ARCH_TIMER_REG_TVAL:
+		asm volatile("mrc p15, 0, %0, c14, c2, 0" : "=r" (val));
+		break;
+	default:
+		BUG();
+	}
+
+	return val;
+}
+
+static int arch_timer_ack(void)
+{
+	unsigned long ctrl;
+
+	ctrl = arch_timer_reg_read(ARCH_TIMER_REG_CTRL);
+	if (ctrl & 0x4) {
+		ctrl |= ARCH_TIMER_CTRL_IT_MASK;
+		arch_timer_reg_write(ARCH_TIMER_REG_CTRL, ctrl);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void arch_set_mode(enum clock_event_mode mode,
+			  struct clock_event_device *clk)
+{
+}
+
+static int arch_set_next_event(unsigned long evt,
+			       struct clock_event_device *unused)
+{
+	unsigned long ctrl;
+
+	ctrl = arch_timer_reg_read(ARCH_TIMER_REG_CTRL);
+	ctrl |= ARCH_TIMER_CTRL_ENABLE;
+	ctrl &= ~ARCH_TIMER_CTRL_IT_MASK;
+
+	arch_timer_reg_write(ARCH_TIMER_REG_TVAL, evt);
+	arch_timer_reg_write(ARCH_TIMER_REG_CTRL, ctrl);
+
+	return 0;
+}
+
+static void __cpuinit arch_timer_pre_setup(struct clock_event_device *clk)
+{
+	unsigned long ctrl;
+
+	/* Let's make sure the timer is off before doing anything else */
+	ctrl = arch_timer_reg_read(ARCH_TIMER_REG_CTRL);
+	ctrl &= ~ARCH_TIMER_CTRL_ENABLE;
+	arch_timer_reg_write(ARCH_TIMER_REG_CTRL, ctrl);
+}
+
+static void __cpuinit arch_timer_setup(struct clock_event_device *clk)
+{
+	clk->features = CLOCK_EVT_FEAT_ONESHOT;
+	clk->name = "arch_sys_timer";
+	clk->rating = 350;
+	clockevents_calc_mult_shift(clk, arch_timer_rate, 4);
+
+	clk->max_delta_ns = clockevent_delta2ns(0xffffffff, clk);
+	clk->min_delta_ns = clockevent_delta2ns(0xf, clk);
+	clk->set_mode = arch_set_mode;
+	clk->set_next_event = arch_set_next_event;
+
+	/* Make sure our local interrupt controller has this enabled */
+	gic_enable_ppi(clk->irq);
+
+	clockevents_register_device(clk);
+}
+
+static struct local_timer_ops arch_timer_ops = {
+	.pre_setup	= arch_timer_pre_setup,
+	.setup		= arch_timer_setup,
+	.ack		= arch_timer_ack,
+};
+
+/* Is the optional system timer available? */
+static int local_timer_is_architected(void)
+{
+	return (cpu_architecture() >= CPU_ARCH_ARMv7) &&
+	       ((read_cpuid_ext(CPUID_EXT_PFR1) >> 16) & 0xf) == 1;
+}
+
+static int arch_timer_available(void)
+{
+	unsigned long freq;
+
+	if (!local_timer_is_architected())
+		return 0;
+
+	if (arch_timer_rate == 0) {
+		arch_timer_reg_write(ARCH_TIMER_REG_CTRL, 0);
+		freq = arch_timer_reg_read(ARCH_TIMER_REG_FREQ);
+
+		/* Check the timer frequency. */
+		if (freq == 0) {
+			pr_warn("Architected timer frequency not available\n");
+			return 0;
+		}
+
+		arch_timer_rate = freq;
+		pr_info("Architected local timer running at %lu.%02luMHz.\n",
+			arch_timer_rate / 1000000, (arch_timer_rate / 100000) % 100);
+	}
+
+	return 1;
+}
+
+static inline cycle_t arch_counter_get_cntpct(void)
+{
+	u32 cvall, cvalh;
+
+	asm volatile("mrrc p15, 0, %0, %1, c14" : "=r" (cvall), "=r" (cvalh));
+
+	return ((u64) cvalh << 32) | cvall;
+}
+
+static inline cycle_t arch_counter_get_cntvct(void)
+{
+	u32 cvall, cvalh;
+
+	asm volatile("mrrc p15, 1, %0, %1, c14" : "=r" (cvall), "=r" (cvalh));
+
+	return ((u64) cvalh << 32) | cvall;
+}
+
+static cycle_t arch_counter_read(struct clocksource *cs)
+{
+	return arch_counter_get_cntpct();
+}
+
+static struct clocksource clocksource_counter = {
+	.name	= "arch_sys_counter",
+	.rating	= 400,
+	.read	= arch_counter_read,
+	.mask	= CLOCKSOURCE_MASK(56),
+	.flags	= (CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_VALID_FOR_HRES),
+};
+
+static int __init arch_timer_clocksource_init(void)
+{
+	struct clocksource *cs = &clocksource_counter;
+
+	percpu_timer_setup();
+
+	clocksource_register_hz(cs, arch_timer_rate);
+
+	return 0;
+}
+
+int __init arch_timer_register_setup(void (*setup)(struct clock_event_device *))
+{
+	if (!arch_timer_available())
+		return -ENODEV;
+
+	percpu_timer_register_setup(&arch_timer_ops, setup);
+	arch_timer_clocksource_init();
+	return 0;
+}
-- 
1.7.0.4
