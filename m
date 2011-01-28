From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 28 Jan 2011 18:02:44 +0900
Subject: [PATCH V3] ARM: S5PV310: Implement kernel timers using MCT
Message-ID: <1296205364-30175-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

The Multi-Core Timer(MCT) of S5PV310 is designed for implementing
clock source timer and clock event timers. This patch implements
1 clock source timer with 64 bit free running counter of MCT and
2 clock event timers with two of 31-bit tick counters.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
NOTE: This depends on following...
- ARM: S5PV310: Add SYSTIMER IO Address mapping for MCT
- ARM: S5PV310: Add irq definition for kernel global timer

Changes since v2:
- Addressed comments from Russell King
  Added mct_clock_event_device structure
- Removed suspend()/resume() which are not used now

Changes since v1:
- Addressed comments from Russell King
  (implemented global timer, used local timer and so on)
- Fixed small things

 arch/arm/Kconfig                              |    2 +-
 arch/arm/mach-s5pv310/Kconfig                 |    5 +
 arch/arm/mach-s5pv310/Makefile                |    9 +-
 arch/arm/mach-s5pv310/include/mach/regs-mct.h |   52 +++
 arch/arm/mach-s5pv310/mct.c                   |  423 +++++++++++++++++++++++++
 5 files changed, 489 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/include/mach/regs-mct.h
 create mode 100644 arch/arm/mach-s5pv310/mct.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5cff165..dc15aaa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1341,7 +1341,7 @@ config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP
 	default y
-	select HAVE_ARM_TWD if !ARCH_MSM_SCORPIONMP
+	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !S5PV310_MCT)
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index b2a9acc..14d4485 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -15,6 +15,11 @@ config CPU_S5PV310
 	help
 	  Enable S5PV310 CPU support
 
+config S5PV310_MCT
+	bool "Kernel timer support by MCT"
+	help
+	  Use MCT (Multi Core Timer) as kernel timers
+
 config S5PV310_DEV_PD
 	bool
 	help
diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
index 036fb38..85b80ef 100644
--- a/arch/arm/mach-s5pv310/Makefile
+++ b/arch/arm/mach-s5pv310/Makefile
@@ -13,11 +13,18 @@ obj-				:=
 # Core support for S5PV310 system
 
 obj-$(CONFIG_CPU_S5PV310)	+= cpu.o init.o clock.o irq-combiner.o
-obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o time.o gpiolib.o irq-eint.o dma.o
+obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o gpiolib.o irq-eint.o dma.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+
+ifeq ($(CONFIG_S5PV310_MCT),y)
+obj-y				+= mct.o
+else
+obj-y				+= time.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
+endif
+
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 
 # machine support
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-mct.h b/arch/arm/mach-s5pv310/include/mach/regs-mct.h
new file mode 100644
index 0000000..efada04
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/regs-mct.h
@@ -0,0 +1,52 @@
+/* arch/arm/mach-s5pv310/include/mach/regs-mct.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5PV310 MCT configutation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_MCT_H
+#define __ASM_ARCH_REGS_MCT_H __FILE__
+
+#include <mach/map.h>
+
+#define S5PV310_MCTREG(x)		(S5P_VA_SYSTIMER + (x))
+
+#define S5PV310_MCT_G_CNT_L		S5PV310_MCTREG(0x100)
+#define S5PV310_MCT_G_CNT_U		S5PV310_MCTREG(0x104)
+#define S5PV310_MCT_G_CNT_WSTAT		S5PV310_MCTREG(0x110)
+
+#define S5PV310_MCT_G_COMP0_L		S5PV310_MCTREG(0x200)
+#define S5PV310_MCT_G_COMP0_U		S5PV310_MCTREG(0x204)
+#define S5PV310_MCT_G_COMP0_ADD_INCR	S5PV310_MCTREG(0x208)
+
+#define S5PV310_MCT_G_TCON		S5PV310_MCTREG(0x240)
+
+#define S5PV310_MCT_G_INT_CSTAT		S5PV310_MCTREG(0x244)
+#define S5PV310_MCT_G_INT_ENB		S5PV310_MCTREG(0x248)
+#define S5PV310_MCT_G_WSTAT		S5PV310_MCTREG(0x24C)
+
+#define S5PV310_MCT_L0_BASE		S5PV310_MCTREG(0x300)
+#define S5PV310_MCT_L1_BASE		S5PV310_MCTREG(0x400)
+
+#define MCT_L_TCNTB_OFFSET		(0x00)
+#define MCT_L_ICNTB_OFFSET		(0x08)
+#define MCT_L_TCON_OFFSET		(0x20)
+#define MCT_L_INT_CSTAT_OFFSET		(0x30)
+#define MCT_L_INT_ENB_OFFSET		(0x34)
+#define MCT_L_WSTAT_OFFSET		(0x40)
+
+#define MCT_G_TCON_START		(1 << 8)
+#define MCT_G_TCON_COMP0_AUTO_INC	(1 << 1)
+#define MCT_G_TCON_COMP0_ENABLE		(1 << 0)
+
+#define MCT_L_TCON_INTERVAL_MODE	(1 << 2)
+#define MCT_L_TCON_INT_START		(1 << 1)
+#define MCT_L_TCON_TIMER_START		(1 << 0)
+
+#endif /* __ASM_ARCH_REGS_MCT_H */
diff --git a/arch/arm/mach-s5pv310/mct.c b/arch/arm/mach-s5pv310/mct.c
new file mode 100644
index 0000000..d330f87
--- /dev/null
+++ b/arch/arm/mach-s5pv310/mct.c
@@ -0,0 +1,423 @@
+/* linux/arch/arm/mach-s5pv310/mct.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5PV310 MCT(Multi-Core Timer) support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/percpu.h>
+
+#include <mach/map.h>
+#include <mach/regs-mct.h>
+#include <asm/mach/time.h>
+
+static unsigned long clk_cnt_per_tick;
+static unsigned long clk_rate;
+
+struct mct_clock_event_device {
+	struct clock_event_device evt;
+	void __iomem *base;
+};
+
+struct mct_clock_event_device mct_tick[2];
+
+static void s5pv310_mct_write(unsigned int value, void *addr)
+{
+	void __iomem *stat_addr;
+	u32 mask;
+	u32 i;
+
+	__raw_writel(value, addr);
+
+	switch ((u32) addr) {
+	case (u32) S5PV310_MCT_G_TCON:
+		stat_addr = S5PV310_MCT_G_WSTAT;
+		mask = 1 << 16;		/* G_TCON write status */
+		break;
+	case (u32) S5PV310_MCT_G_COMP0_L:
+		stat_addr = S5PV310_MCT_G_WSTAT;
+		mask = 1 << 0;		/* G_COMP0_L write status */
+		break;
+	case (u32) S5PV310_MCT_G_COMP0_U:
+		stat_addr = S5PV310_MCT_G_WSTAT;
+		mask = 1 << 1;		/* G_COMP0_U write status */
+		break;
+	case (u32) S5PV310_MCT_G_COMP0_ADD_INCR:
+		stat_addr = S5PV310_MCT_G_WSTAT;
+		mask = 1 << 2;		/* G_COMP0_ADD_INCR write status */
+		break;
+	case (u32) S5PV310_MCT_G_CNT_L:
+		stat_addr = S5PV310_MCT_G_CNT_WSTAT;
+		mask = 1 << 0;		/* G_CNT_L write status */
+		break;
+	case (u32) S5PV310_MCT_G_CNT_U:
+		stat_addr = S5PV310_MCT_G_CNT_WSTAT;
+		mask = 1 << 1;		/* G_CNT_U write status */
+		break;
+	case (u32)(S5PV310_MCT_L0_BASE + MCT_L_TCON_OFFSET):
+		stat_addr = S5PV310_MCT_L0_BASE + MCT_L_WSTAT_OFFSET;
+		mask = 1 << 3;		/* L0_TCON write status */
+		break;
+	case (u32)(S5PV310_MCT_L1_BASE + MCT_L_TCON_OFFSET):
+		stat_addr = S5PV310_MCT_L1_BASE + MCT_L_WSTAT_OFFSET;
+		mask = 1 << 3;		/* L1_TCON write status */
+		break;
+	case (u32)(S5PV310_MCT_L0_BASE + MCT_L_TCNTB_OFFSET):
+		stat_addr = S5PV310_MCT_L0_BASE + MCT_L_WSTAT_OFFSET;
+		mask = 1 << 0;		/* L0_TCNTB write status */
+		break;
+	case (u32)(S5PV310_MCT_L1_BASE + MCT_L_TCNTB_OFFSET):
+		stat_addr = S5PV310_MCT_L1_BASE + MCT_L_WSTAT_OFFSET;
+		mask = 1 << 0;		/* L1_TCNTB write status */
+		break;
+	case (u32)(S5PV310_MCT_L0_BASE + MCT_L_ICNTB_OFFSET):
+		stat_addr = S5PV310_MCT_L0_BASE + MCT_L_WSTAT_OFFSET;
+		mask = 1 << 1;		/* L0_ICNTB write status */
+		break;
+	case (u32)(S5PV310_MCT_L1_BASE + MCT_L_ICNTB_OFFSET):
+		stat_addr = S5PV310_MCT_L1_BASE + MCT_L_WSTAT_OFFSET;
+		mask = 1 << 1;		/* L1_ICNTB write status */
+		break;
+	default:
+		return;
+	}
+
+	/* Wait maximum 1 ms until written values are applied */
+	for (i = 0; i < loops_per_jiffy / 1000 * HZ; i++)
+		if (__raw_readl(stat_addr) & mask) {
+			__raw_writel(mask, stat_addr);
+			return;
+		}
+
+	panic("MCT hangs after writing %d (addr:0x%08x)\n", value, (u32)addr);
+}
+
+/* Clocksource handling */
+static void s5pv310_mct_frc_start(u32 hi, u32 lo)
+{
+	u32 reg;
+
+	s5pv310_mct_write(lo, S5PV310_MCT_G_CNT_L);
+	s5pv310_mct_write(hi, S5PV310_MCT_G_CNT_U);
+
+	reg = __raw_readl(S5PV310_MCT_G_TCON);
+	reg |= MCT_G_TCON_START;
+	s5pv310_mct_write(reg, S5PV310_MCT_G_TCON);
+}
+
+static cycle_t s5pv310_frc_read(struct clocksource *cs)
+{
+	unsigned int lo, hi;
+	u32 hi2 = __raw_readl(S5PV310_MCT_G_CNT_U);
+
+	do {
+		hi = hi2;
+		lo = __raw_readl(S5PV310_MCT_G_CNT_L);
+		hi2 = __raw_readl(S5PV310_MCT_G_CNT_U);
+	} while (hi != hi2);
+
+	return ((cycle_t)hi << 32) | lo;
+}
+
+struct clocksource mct_frc = {
+	.name		= "mct-frc",
+	.rating		= 400,
+	.read		= s5pv310_frc_read,
+	.mask		= CLOCKSOURCE_MASK(64),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static void __init s5pv310_clocksource_init(void)
+{
+	s5pv310_mct_frc_start(0, 0);
+
+	if (clocksource_register_hz(&mct_frc, clk_rate))
+		panic("%s: can't register clocksource\n", mct_frc.name);
+}
+
+static void s5pv310_mct_comp0_stop(void)
+{
+	unsigned int tcon;
+
+	tcon = __raw_readl(S5PV310_MCT_G_TCON);
+	tcon &= ~(MCT_G_TCON_COMP0_ENABLE | MCT_G_TCON_COMP0_AUTO_INC);
+
+	s5pv310_mct_write(tcon, S5PV310_MCT_G_TCON);
+	s5pv310_mct_write(0, S5PV310_MCT_G_INT_ENB);
+}
+
+static void s5pv310_mct_comp0_start(enum clock_event_mode mode,
+				    unsigned long cycles)
+{
+	unsigned int tcon;
+	cycle_t comp_cycle;
+
+	tcon = __raw_readl(S5PV310_MCT_G_TCON);
+
+	if (mode == CLOCK_EVT_MODE_PERIODIC) {
+		tcon |= MCT_G_TCON_COMP0_AUTO_INC;
+		s5pv310_mct_write(cycles, S5PV310_MCT_G_COMP0_ADD_INCR);
+	}
+
+	comp_cycle = s5pv310_frc_read(&mct_frc) + cycles;
+	s5pv310_mct_write((u32)comp_cycle, S5PV310_MCT_G_COMP0_L);
+	s5pv310_mct_write((u32)(comp_cycle >> 32), S5PV310_MCT_G_COMP0_U);
+
+	s5pv310_mct_write(0x1, S5PV310_MCT_G_INT_ENB);
+
+	tcon |= MCT_G_TCON_COMP0_ENABLE;
+	s5pv310_mct_write(tcon , S5PV310_MCT_G_TCON);
+}
+
+static int s5pv310_comp_set_next_event(unsigned long cycles,
+				       struct clock_event_device *evt)
+{
+	s5pv310_mct_comp0_start(evt->mode, cycles);
+
+	return 0;
+}
+
+static void s5pv310_comp_set_mode(enum clock_event_mode mode,
+				  struct clock_event_device *evt)
+{
+	s5pv310_mct_comp0_stop();
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		s5pv310_mct_comp0_start(mode, clk_cnt_per_tick);
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+static struct clock_event_device mct_comp_device = {
+	.name		= "mct-comp",
+	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.rating		= 250,
+	.set_next_event	= s5pv310_comp_set_next_event,
+	.set_mode	= s5pv310_comp_set_mode,
+};
+
+irqreturn_t s5pv310_mct_comp_isr(int irq, void *dev_id)
+{
+	struct clock_event_device *evt;
+
+	s5pv310_mct_write(0x1, S5PV310_MCT_G_INT_CSTAT);
+
+	evt = &mct_comp_device;
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction mct_comp_event_irq = {
+	.name		= "mct_comp_irq",
+	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= s5pv310_mct_comp_isr,
+};
+
+static void s5pv310_clockevent_init(void)
+{
+	clk_cnt_per_tick = clk_rate / 2	/ HZ;
+
+	clockevents_calc_mult_shift(&mct_comp_device, clk_rate / 2, 5);
+	mct_comp_device.max_delta_ns =
+		clockevent_delta2ns(0xffffffff, &mct_comp_device);
+	mct_comp_device.min_delta_ns =
+		clockevent_delta2ns(0xf, &mct_comp_device);
+	mct_comp_device.cpumask = cpumask_of(0);
+	clockevents_register_device(&mct_comp_device);
+
+	setup_irq(IRQ_MCT_G0, &mct_comp_event_irq);
+}
+
+#ifdef CONFIG_LOCAL_TIMERS
+/* Clock event handling */
+static void s5pv310_mct_tick_stop(struct mct_clock_event_device *mevt)
+{
+	unsigned long tmp;
+	unsigned long mask = MCT_L_TCON_INT_START | MCT_L_TCON_TIMER_START;
+	void __iomem *addr = mevt->base + MCT_L_TCON_OFFSET;
+
+	tmp = __raw_readl(addr);
+	if (tmp & mask) {
+		tmp &= ~mask;
+		s5pv310_mct_write(tmp, addr);
+	}
+}
+
+static void s5pv310_mct_tick_start(unsigned long cycles,
+				   struct mct_clock_event_device *mevt)
+{
+	unsigned long tmp;
+
+	s5pv310_mct_tick_stop(mevt);
+
+	tmp = (1 << 31) | cycles;	/* MCT_L_UPDATE_ICNTB */
+
+	/* update interrupt count buffer */
+	s5pv310_mct_write(tmp, mevt->base + MCT_L_ICNTB_OFFSET);
+
+	/* enable MCT tick interupt */
+	s5pv310_mct_write(0x1, mevt->base + MCT_L_INT_ENB_OFFSET);
+
+	tmp = __raw_readl(mevt->base + MCT_L_TCON_OFFSET);
+	tmp |= MCT_L_TCON_INT_START | MCT_L_TCON_TIMER_START |
+	       MCT_L_TCON_INTERVAL_MODE;
+	s5pv310_mct_write(tmp, mevt->base + MCT_L_TCON_OFFSET);
+}
+
+static int s5pv310_tick_set_next_event(unsigned long cycles,
+				       struct clock_event_device *evt)
+{
+	struct mct_clock_event_device *mevt =
+		container_of(evt, struct mct_clock_event_device, evt);
+
+	s5pv310_mct_tick_start(cycles, mevt);
+
+	return 0;
+}
+
+static inline void s5pv310_tick_set_mode(enum clock_event_mode mode,
+					 struct clock_event_device *evt)
+{
+	struct mct_clock_event_device *mevt =
+		container_of(evt, struct mct_clock_event_device, evt);
+
+	s5pv310_mct_tick_stop(mevt);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		s5pv310_mct_tick_start(clk_cnt_per_tick, mevt);
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+irqreturn_t s5pv310_mct_tick_isr(int irq, void *dev_id)
+{
+	struct mct_clock_event_device *mevt = dev_id;
+	struct clock_event_device *evt = &mevt->evt;
+
+	/*
+	 * This is for supporting oneshot mode.
+	 * Mct would generate interrupt periodically
+	 * without explicit stopping.
+	 */
+	if (evt->mode != CLOCK_EVT_MODE_PERIODIC)
+		s5pv310_mct_tick_stop(mevt);
+
+	/* Clear the MCT tick interrupt */
+	s5pv310_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction mct_tick0_event_irq = {
+	.name		= "mct_tick0_irq",
+	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
+	.handler	= s5pv310_mct_tick_isr,
+};
+
+static struct irqaction mct_tick1_event_irq = {
+	.name		= "mct_tick1_irq",
+	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
+	.handler	= s5pv310_mct_tick_isr,
+};
+
+static void s5pv310_mct_tick_init(struct clock_event_device *evt)
+{
+	unsigned int cpu = smp_processor_id();
+
+	evt = &mct_tick[cpu].evt;
+
+	if (cpu == 0) {
+		mct_tick[cpu].base = S5PV310_MCT_L0_BASE;
+		evt->name = "mct_tick0";
+	} else {
+		mct_tick[cpu].base = S5PV310_MCT_L1_BASE;
+		evt->name = "mct_tick1";
+	}
+
+	evt->cpumask = cpumask_of(cpu);
+	evt->set_next_event = s5pv310_tick_set_next_event;
+	evt->set_mode = s5pv310_tick_set_mode;
+	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	evt->rating = 450;
+
+	clockevents_calc_mult_shift(evt, clk_rate / 2, 5);
+	evt->max_delta_ns =
+		clockevent_delta2ns(0x7fffffff, evt);
+	evt->min_delta_ns =
+		clockevent_delta2ns(0xf, evt);
+
+	clockevents_register_device(evt);
+
+	s5pv310_mct_write(0x1, mct_tick[cpu].base + MCT_L_TCNTB_OFFSET);
+
+	if (cpu == 0) {
+		mct_tick0_event_irq.dev_id = &mct_tick[cpu];
+		setup_irq(IRQ_MCT_L0, &mct_tick0_event_irq);
+	} else {
+		mct_tick1_event_irq.dev_id = &mct_tick[cpu];
+		irq_set_affinity(IRQ_MCT1, cpumask_of(1));
+		setup_irq(IRQ_MCT_L1, &mct_tick1_event_irq);
+	}
+}
+
+/* Setup the local clock events for a CPU */
+void __cpuinit local_timer_setup(struct clock_event_device *evt)
+{
+	s5pv310_mct_tick_init(evt);
+}
+
+int local_timer_ack(void)
+{
+	return 0;
+}
+
+#endif /* CONFIG_LOCAL_TIMERS */
+
+static void __init s5pv310_timer_resources(void)
+{
+	struct clk *mct_clk;
+	mct_clk = clk_get(NULL, "xtal");
+
+	clk_rate = clk_get_rate(mct_clk);
+}
+
+static void __init s5pv310_timer_init(void)
+{
+	s5pv310_timer_resources();
+	s5pv310_clocksource_init();
+	s5pv310_clockevent_init();
+}
+
+struct sys_timer s5pv310_timer = {
+	.init		= s5pv310_timer_init,
+};
-- 
1.7.1
