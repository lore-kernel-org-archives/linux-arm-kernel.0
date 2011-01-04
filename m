From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue,  4 Jan 2011 11:18:47 +0900
Subject: [PATCH V2] ARM: S5PV310: Implement kernel timers using MCT
Message-ID: <1294107527-27915-1-git-send-email-kgene.kim@samsung.com>
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
Changes since v1:
- Addressed comments from Russell King
  (implemented global timer, used local timer and so on)

- Fixed small things

 arch/arm/Kconfig                              |    2 +-
 arch/arm/mach-s5pv310/Kconfig                 |    5 +
 arch/arm/mach-s5pv310/Makefile                |   10 +-
 arch/arm/mach-s5pv310/include/mach/regs-mct.h |   58 +++
 arch/arm/mach-s5pv310/mct.c                   |  492 +++++++++++++++++++++++++
 5 files changed, 564 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/include/mach/regs-mct.h
 create mode 100644 arch/arm/mach-s5pv310/mct.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d56d21c..d9ee300 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1291,7 +1291,7 @@ config LOCAL_TIMERS
 	bool "Use local timer interrupts"
 	depends on SMP
 	default y
-	select HAVE_ARM_TWD
+	select HAVE_ARM_TWD if !S5PV310_MCT
 	help
 	  Enable support for local timers on SMP platforms, rather then the
 	  legacy IPI broadcast method.  Local timers allows the system
diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index 1150b36..5fecf1b 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -14,6 +14,11 @@ config CPU_S5PV310
 	help
 	  Enable S5PV310 CPU support
 
+config S5PV310_MCT
+	bool "Kernel timer support by MCT"
+	help
+	  Use MCT (Multi Core Timer) as kernel timers
+
 config S5PV310_SETUP_I2C1
 	bool
 	help
diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
index 84afc64..5ca7645 100644
--- a/arch/arm/mach-s5pv310/Makefile
+++ b/arch/arm/mach-s5pv310/Makefile
@@ -13,10 +13,16 @@ obj-				:=
 # Core support for S5PV310 system
 
 obj-$(CONFIG_CPU_S5PV310)	+= cpu.o init.o clock.o irq-combiner.o
-obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o time.o gpiolib.o irq-eint.o
+obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o gpiolib.o irq-eint.o
 
-obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+ifeq ($(CONFIG_S5PV310_MCT),y)
+obj-y				+= mct.o
+else
+obj-y				+= time.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
+endif
+
+obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 
 # machine support
diff --git a/arch/arm/mach-s5pv310/include/mach/regs-mct.h b/arch/arm/mach-s5pv310/include/mach/regs-mct.h
new file mode 100644
index 0000000..1ed14f0
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/regs-mct.h
@@ -0,0 +1,58 @@
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
+#define S5PV310_MCT_L0_TCNTB		S5PV310_MCTREG(0x300)
+#define S5PV310_MCT_L0_ICNTB		S5PV310_MCTREG(0x308)
+#define S5PV310_MCT_L0_TCON		S5PV310_MCTREG(0x320)
+
+#define S5PV310_MCT_L0_INT_CSTAT	S5PV310_MCTREG(0x330)
+#define S5PV310_MCT_L0_INT_ENB		S5PV310_MCTREG(0x334)
+#define S5PV310_MCT_L0_WSTAT		S5PV310_MCTREG(0x340)
+
+#define S5PV310_MCT_L1_TCNTB		S5PV310_MCTREG(0x400)
+#define S5PV310_MCT_L1_ICNTB		S5PV310_MCTREG(0x408)
+#define S5PV310_MCT_L1_TCON		S5PV310_MCTREG(0x420)
+
+#define S5PV310_MCT_L1_INT_CSTAT	S5PV310_MCTREG(0x430)
+#define S5PV310_MCT_L1_INT_ENB		S5PV310_MCTREG(0x434)
+#define S5PV310_MCT_L1_WSTAT		S5PV310_MCTREG(0x440)
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
index 0000000..05c2280
--- /dev/null
+++ b/arch/arm/mach-s5pv310/mct.c
@@ -0,0 +1,492 @@
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
+static cycle_t time_suspended;
+
+enum mct_tick_type {
+	MCT_TICK0,
+	MCT_TICK1,
+};
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
+	case (u32) S5PV310_MCT_L0_TCON:
+		stat_addr = S5PV310_MCT_L0_WSTAT;
+		mask = 1 << 3;		/* L0_TCON write status */
+		break;
+	case (u32) S5PV310_MCT_L1_TCON:
+		stat_addr = S5PV310_MCT_L1_WSTAT;
+		mask = 1 << 3;		/* L1_TCON write status */
+		break;
+	case (u32) S5PV310_MCT_L0_TCNTB:
+		stat_addr = S5PV310_MCT_L0_WSTAT;
+		mask = 1 << 0;		/* L0_TCNTB write status */
+		break;
+	case (u32) S5PV310_MCT_L1_TCNTB:
+		stat_addr = S5PV310_MCT_L1_WSTAT;
+		mask = 1 << 0;		/* L1_TCNTB write status */
+		break;
+	case (u32) S5PV310_MCT_L0_ICNTB:
+		stat_addr = S5PV310_MCT_L0_WSTAT;
+		mask = 1 << 1;		/* L0_ICNTB write status */
+		break;
+	case (u32) S5PV310_MCT_L1_ICNTB:
+		stat_addr = S5PV310_MCT_L1_WSTAT;
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
+static void s5pv310_frc_suspend(struct clocksource *cs)
+{
+	time_suspended = s5pv310_frc_read(cs);
+};
+
+static void s5pv310_frc_resume(struct clocksource *cs)
+{
+	s5pv310_mct_frc_start((u32)(time_suspended >> 32), (u32)time_suspended);
+};
+
+struct clocksource mct_frc = {
+	.name		= "mct-frc",
+	.rating		= 400,
+	.read		= s5pv310_frc_read,
+	.mask		= CLOCKSOURCE_MASK(64),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend	= s5pv310_frc_suspend,
+	.resume		= s5pv310_frc_resume,
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
+static void s5pv310_mct_tick_stop(enum mct_tick_type type)
+{
+	unsigned long tmp;
+	void __iomem *addr;
+
+	if (type == MCT_TICK0)
+		addr = S5PV310_MCT_L0_TCON;
+	else
+		addr = S5PV310_MCT_L1_TCON;
+
+	tmp = __raw_readl(addr);
+	tmp &= ~(MCT_L_TCON_INT_START | MCT_L_TCON_TIMER_START);
+	s5pv310_mct_write(tmp, addr);
+}
+
+static void s5pv310_mct_tick_start(enum mct_tick_type type,
+				   unsigned long cycles)
+{
+	unsigned long tmp;
+	unsigned int tmp1, tmp2;
+	void __iomem *addr;
+
+	s5pv310_mct_tick_stop(type);
+
+	tmp1 = (1 << 31) | cycles;	/* MCT_L_UPDATE_ICNTB */
+	tmp2 = 1 << 0;			/* L_INT_ENB_CNTIE */
+
+	if (type == MCT_TICK0) {
+		/* update interrupt count buffer */
+		s5pv310_mct_write(tmp1, S5PV310_MCT_L0_ICNTB);
+
+		/* enable MCT tick0 interupt */
+		s5pv310_mct_write(tmp2, S5PV310_MCT_L0_INT_ENB);
+
+		addr = S5PV310_MCT_L0_TCON;
+	} else {
+		/* update interrupt count buffer */
+		s5pv310_mct_write(tmp1, S5PV310_MCT_L1_ICNTB);
+
+		/* enable MCT tick1 interupt */
+		s5pv310_mct_write(tmp2, S5PV310_MCT_L1_INT_ENB);
+
+		addr = S5PV310_MCT_L1_TCON;
+	}
+
+	tmp = __raw_readl(addr);
+	tmp |= MCT_L_TCON_INT_START | MCT_L_TCON_TIMER_START |
+	       MCT_L_TCON_INTERVAL_MODE;
+	s5pv310_mct_write(tmp, addr);
+}
+
+static inline int s5pv310_tick_set_next_event(enum mct_tick_type type,
+					      unsigned long cycles)
+{
+	s5pv310_mct_tick_start(type, cycles);
+
+	return 0;
+}
+
+static inline void s5pv310_tick_set_mode(enum mct_tick_type type,
+					 enum clock_event_mode mode)
+{
+	s5pv310_mct_tick_stop(type);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		s5pv310_mct_tick_start(type, clk_cnt_per_tick);
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
+static int s5pv310_tick0_set_next_event(unsigned long cycles,
+					struct clock_event_device *evt)
+{
+	return s5pv310_tick_set_next_event(MCT_TICK0, cycles);
+}
+
+static int s5pv310_tick1_set_next_event(unsigned long cycles,
+					struct clock_event_device *evt)
+{
+	return s5pv310_tick_set_next_event(MCT_TICK1, cycles);
+}
+
+static void s5pv310_tick0_set_mode(enum clock_event_mode mode,
+				   struct clock_event_device *evt)
+{
+	s5pv310_tick_set_mode(MCT_TICK0, mode);
+}
+
+static void s5pv310_tick1_set_mode(enum clock_event_mode mode,
+				   struct clock_event_device *evt)
+{
+	s5pv310_tick_set_mode(MCT_TICK1, mode);
+}
+
+irqreturn_t s5pv310_mct_tick0_isr(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	/*
+	 * This is for supporting oneshot mode.
+	 * Mct would generate interrupt periodically
+	 * without explicit stopping.
+	 */
+	if (evt->mode != CLOCK_EVT_MODE_PERIODIC)
+		s5pv310_mct_tick_stop(MCT_TICK0);
+
+	/* Clear the MCT tick0 interrupt */
+	s5pv310_mct_write(0x1, S5PV310_MCT_L0_INT_CSTAT);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t s5pv310_mct_tick1_isr(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	/*
+	 * This is for supporting oneshot mode.
+	 * Mct would generate interrupt periodically
+	 * without explicit stopping.
+	 */
+	if (evt->mode != CLOCK_EVT_MODE_PERIODIC)
+		s5pv310_mct_tick_stop(MCT_TICK1);
+
+	/* Clear the MCT tick1 interrupt */
+	s5pv310_mct_write(0x1, S5PV310_MCT_L1_INT_CSTAT);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction mct_tick0_event_irq = {
+	.name		= "mct_tick0_irq",
+	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
+	.handler	= s5pv310_mct_tick0_isr,
+};
+
+static struct irqaction mct_tick1_event_irq = {
+	.name		= "mct_tick1_irq",
+	.flags		= IRQF_TIMER | IRQF_NOBALANCING,
+	.handler	= s5pv310_mct_tick1_isr,
+};
+
+static void s5pv310_mct_tick_init(struct clock_event_device *evt)
+{
+	unsigned int cpu = smp_processor_id();
+
+	if (cpu == 0) {
+		s5pv310_mct_write(0x1, S5PV310_MCT_L0_TCNTB);
+		evt->set_next_event = s5pv310_tick0_set_next_event;
+		evt->set_mode = s5pv310_tick0_set_mode;
+		evt->name = "mct_tick0";
+	} else {
+		s5pv310_mct_write(0x1, S5PV310_MCT_L1_TCNTB);
+		evt->set_next_event = s5pv310_tick1_set_next_event;
+		evt->set_mode = s5pv310_tick1_set_mode;
+		evt->name = "mct_tick1";
+	}
+
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
+	if (cpu == 0) {
+		mct_tick0_event_irq.dev_id = evt;
+		setup_irq(IRQ_MCT_L0, &mct_tick0_event_irq);
+	} else {
+		mct_tick1_event_irq.dev_id = evt;
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
+#ifdef CONFIG_HOTPLUG_CPU
+void local_timer_stop(void)
+{
+	s5pv310_mct_tick_stop(smp_processor_id());
+}
+#endif /* CONFIG_HOTPLUG_CPU */
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
1.6.2.5
