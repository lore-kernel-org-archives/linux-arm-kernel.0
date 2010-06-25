From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Jun 2010 23:27:14 +0900
Subject: [PATCH 5/8] ARM: S5PV310: Add Timer support
In-Reply-To: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
References: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1277476037-8806-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch adds timer support for S5PV310.
Until now, all S5P SoCs use CONFIG_ARCH_USES_GETTIMEOFFSET macro as a default
configuration. Instead, S5PV310 implements clocksource and clock_event_device
to support the high resolution timer and tickless system.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/include/mach/pwm-clock.h |   70 ++++++
 arch/arm/mach-s5pv310/localtimer.c             |   25 ++
 arch/arm/mach-s5pv310/time.c                   |  289 ++++++++++++++++++++++++
 arch/arm/plat-samsung/Makefile                 |    2 +-
 4 files changed, 385 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/include/mach/pwm-clock.h
 create mode 100644 arch/arm/mach-s5pv310/localtimer.c
 create mode 100644 arch/arm/mach-s5pv310/time.c

diff --git a/arch/arm/mach-s5pv310/include/mach/pwm-clock.h b/arch/arm/mach-s5pv310/include/mach/pwm-clock.h
new file mode 100644
index 0000000..7e6da27
--- /dev/null
+++ b/arch/arm/mach-s5pv310/include/mach/pwm-clock.h
@@ -0,0 +1,70 @@
+/* linux/arch/arm/mach-s5pv310/include/mach/pwm-clock.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *      Ben Dooks <ben@simtec.co.uk>
+ *      http://armlinux.simtec.co.uk/
+ *
+ * Based on arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
+ *
+ * S5PV310 - pwm clock and timer support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_PWMCLK_H
+#define __ASM_ARCH_PWMCLK_H __FILE__
+
+/**
+ * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
+ * @tcfg: The timer TCFG1 register bits shifted down to 0.
+ *
+ * Return true if the given configuration from TCFG1 is a TCLK instead
+ * any of the TDIV clocks.
+ */
+static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
+{
+	return tcfg == S3C64XX_TCFG1_MUX_TCLK;
+}
+
+/**
+ * tcfg_to_divisor() - convert tcfg1 setting to a divisor
+ * @tcfg1: The tcfg1 setting, shifted down.
+ *
+ * Get the divisor value for the given tcfg1 setting. We assume the
+ * caller has already checked to see if this is not a TCLK source.
+ */
+static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
+{
+	return 1 << tcfg1;
+}
+
+/**
+ * pwm_tdiv_has_div1() - does the tdiv setting have a /1
+ *
+ * Return true if we have a /1 in the tdiv setting.
+ */
+static inline unsigned int pwm_tdiv_has_div1(void)
+{
+	return 1;
+}
+
+/**
+ * pwm_tdiv_div_bits() - calculate TCFG1 divisor value.
+ * @div: The divisor to calculate the bit information for.
+ *
+ * Turn a divisor into the necessary bit field for TCFG1.
+ */
+static inline unsigned long pwm_tdiv_div_bits(unsigned int div)
+{
+	return ilog2(div);
+}
+
+#define S3C_TCFG1_MUX_TCLK S3C64XX_TCFG1_MUX_TCLK
+
+#endif /* __ASM_ARCH_PWMCLK_H */
diff --git a/arch/arm/mach-s5pv310/localtimer.c b/arch/arm/mach-s5pv310/localtimer.c
new file mode 100644
index 0000000..2784036
--- /dev/null
+++ b/arch/arm/mach-s5pv310/localtimer.c
@@ -0,0 +1,25 @@
+/* linux/arch/arm/mach-s5pv310/localtimer.c
+ *
+ * Cloned from linux/arch/arm/mach-realview/localtimer.c
+ *
+ *  Copyright (C) 2002 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/clockchips.h>
+
+#include <asm/irq.h>
+#include <asm/localtimer.h>
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+void __cpuinit local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = IRQ_LOCALTIMER;
+	twd_timer_setup(evt);
+}
diff --git a/arch/arm/mach-s5pv310/time.c b/arch/arm/mach-s5pv310/time.c
new file mode 100644
index 0000000..250af60
--- /dev/null
+++ b/arch/arm/mach-s5pv310/time.c
@@ -0,0 +1,289 @@
+/* linux/arch/arm/mach-s5pv310/time.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5PV310 (and compatible) HRT support
+ * PWM 2/4 is used for this feature
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
+
+#include <asm/smp_twd.h>
+
+#include <mach/map.h>
+#include <plat/regs-timer.h>
+#include <asm/mach/time.h>
+
+static unsigned long clock_count_per_tick;
+
+static struct clk *tin2;
+static struct clk *tin4;
+static struct clk *tdiv2;
+static struct clk *tdiv4;
+static struct clk *timerclk;
+
+static void s5pv310_pwm_stop(unsigned int pwm_id)
+{
+	unsigned long tcon;
+
+	tcon = __raw_readl(S3C2410_TCON);
+
+	switch (pwm_id) {
+	case 2:
+		tcon &= ~S3C2410_TCON_T2START;
+		break;
+	case 4:
+		tcon &= ~S3C2410_TCON_T4START;
+		break;
+	default:
+		break;
+	}
+	__raw_writel(tcon, S3C2410_TCON);
+}
+
+static void s5pv310_pwm_init(unsigned int pwm_id, unsigned long tcnt)
+{
+	unsigned long tcon;
+
+	tcon = __raw_readl(S3C2410_TCON);
+
+	/* timers reload after counting zero, so reduce the count by 1 */
+	tcnt--;
+
+	printk(KERN_DEBUG "timer tcon=%08lx, tcnt %08lx\n", tcon, tcnt);
+
+	/* ensure timer is stopped... */
+	switch (pwm_id) {
+	case 2:
+		tcon &= ~(0xf<<12);
+		tcon |= S3C2410_TCON_T2MANUALUPD;
+
+		__raw_writel(tcnt, S3C2410_TCNTB(2));
+		__raw_writel(tcnt, S3C2410_TCMPB(2));
+		__raw_writel(tcon, S3C2410_TCON);
+
+		break;
+	case 4:
+		tcon &= ~(7<<20);
+		tcon |= S3C2410_TCON_T4MANUALUPD;
+
+		__raw_writel(tcnt, S3C2410_TCNTB(4));
+		__raw_writel(tcnt, S3C2410_TCMPB(4));
+		__raw_writel(tcon, S3C2410_TCON);
+
+		break;
+	default:
+		break;
+	}
+}
+
+static inline void s5pv310_pwm_start(unsigned int pwm_id, bool periodic)
+{
+	unsigned long tcon;
+
+	tcon  = __raw_readl(S3C2410_TCON);
+
+	switch (pwm_id) {
+	case 2:
+		tcon |= S3C2410_TCON_T2START;
+		tcon &= ~S3C2410_TCON_T2MANUALUPD;
+
+		if (periodic)
+			tcon |= S3C2410_TCON_T2RELOAD;
+		else
+			tcon &= ~S3C2410_TCON_T2RELOAD;
+		break;
+	case 4:
+		tcon |= S3C2410_TCON_T4START;
+		tcon &= ~S3C2410_TCON_T4MANUALUPD;
+
+		if (periodic)
+			tcon |= S3C2410_TCON_T4RELOAD;
+		else
+			tcon &= ~S3C2410_TCON_T4RELOAD;
+		break;
+	default:
+		break;
+	}
+	__raw_writel(tcon, S3C2410_TCON);
+}
+
+static int s5pv310_pwm_set_next_event(unsigned long cycles,
+					struct clock_event_device *evt)
+{
+	s5pv310_pwm_init(4, cycles);
+	s5pv310_pwm_start(4, 0);
+	return 0;
+}
+
+static void s5pv310_pwm_set_mode(enum clock_event_mode mode,
+				struct clock_event_device *evt)
+{
+	s5pv310_pwm_stop(4);
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		s5pv310_pwm_init(4, clock_count_per_tick);
+		s5pv310_pwm_start(4, 1);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+static struct clock_event_device pwm_event_device = {
+	.name		= "pwm_timer4",
+	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.rating		= 200,
+	.shift		= 32,
+	.set_next_event	= s5pv310_pwm_set_next_event,
+	.set_mode	= s5pv310_pwm_set_mode,
+};
+
+irqreturn_t s5pv310_clock_event_isr(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = &pwm_event_device;
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction s5pv310_clock_event_irq = {
+	.name		= "pwm_timer4_irq",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= s5pv310_clock_event_isr,
+};
+
+static void __init s5pv310_clockevent_init(void)
+{
+	unsigned long pclk;
+	unsigned long clock_rate;
+	struct clk *tscaler;
+
+	pclk = clk_get_rate(timerclk);
+
+	/* configure clock tick */
+
+	tscaler = clk_get_parent(tdiv4);
+
+	clk_set_rate(tscaler, pclk / 2);
+	clk_set_rate(tdiv4, pclk / 2);
+	clk_set_parent(tin4, tdiv4);
+
+	clock_rate = clk_get_rate(tin4);
+
+	clock_count_per_tick = clock_rate / HZ;
+
+	pwm_event_device.mult =
+		div_sc(clock_rate, NSEC_PER_SEC, pwm_event_device.shift);
+	pwm_event_device.max_delta_ns =
+		clockevent_delta2ns(-1, &pwm_event_device);
+	pwm_event_device.min_delta_ns =
+		clockevent_delta2ns(1, &pwm_event_device);
+
+	pwm_event_device.cpumask = cpumask_of(0);
+	clockevents_register_device(&pwm_event_device);
+
+	setup_irq(IRQ_TIMER4, &s5pv310_clock_event_irq);
+}
+
+static cycle_t s5pv310_pwm2_read(struct clocksource *cs)
+{
+	return (cycle_t) ~__raw_readl(S3C_TIMERREG(0x2c));
+}
+
+struct clocksource pwm_clocksource = {
+	.name		= "pwm_timer2",
+	.rating		= 250,
+	.read		= s5pv310_pwm2_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift		= 20,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS ,
+};
+
+static void __init s5pv310_clocksource_init(void)
+{
+	unsigned long pclk;
+	unsigned long clock_rate;
+
+	pclk = clk_get_rate(timerclk);
+
+	clk_set_rate(tdiv2, pclk / 2);
+	clk_set_parent(tin2, tdiv2);
+
+	clock_rate = clk_get_rate(tin2);
+
+	pwm_clocksource.mult =
+		clocksource_khz2mult(clock_rate/1000, pwm_clocksource.shift);
+
+	if (clocksource_register(&pwm_clocksource))
+		panic("%s: can't register clocksource\n", pwm_clocksource.name);
+
+	s5pv310_pwm_init(2, ~0);
+	s5pv310_pwm_start(2, 1);
+}
+
+static void __init s5pv310_timer_resources(void)
+{
+	struct platform_device tmpdev;
+
+	tmpdev.dev.bus = &platform_bus_type;
+
+	timerclk = clk_get(NULL, "timers");
+	if (IS_ERR(timerclk))
+		panic("failed to get timers clock for system timer");
+
+	clk_enable(timerclk);
+
+	tmpdev.id = 2;
+	tin2 = clk_get(&tmpdev.dev, "pwm-tin");
+	if (IS_ERR(tin2))
+		panic("failed to get pwm-tin2 clock for system timer");
+
+	tdiv2 = clk_get(&tmpdev.dev, "pwm-tdiv");
+	if (IS_ERR(tdiv2))
+		panic("failed to get pwm-tdiv2 clock for system timer");
+	clk_enable(tin2);
+
+	tmpdev.id = 4;
+	tin4 = clk_get(&tmpdev.dev, "pwm-tin");
+	if (IS_ERR(tin4))
+		panic("failed to get pwm-tin4 clock for system timer");
+
+	tdiv4 = clk_get(&tmpdev.dev, "pwm-tdiv");
+	if (IS_ERR(tdiv4))
+		panic("failed to get pwm-tdiv4 clock for system timer");
+
+	clk_enable(tin4);
+}
+
+static void __init s5pv310_timer_init(void)
+{
+#ifdef CONFIG_LOCAL_TIMERS
+	twd_base = S5P_VA_TWD;
+#endif
+
+	s5pv310_timer_resources();
+	s5pv310_clockevent_init();
+	s5pv310_clocksource_init();
+}
+
+struct sys_timer s5pv310_timer = {
+	.init		= s5pv310_timer_init,
+};
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index b1d82cc..0d5bf8a 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -12,7 +12,7 @@ obj-				:=
 # Objects we always build independent of SoC choice
 
 obj-y				+= init.o
-obj-y				+= time.o
+obj-$(CONFIG_ARCH_USES_GETTIMEOFFSET)   += time.o
 obj-y				+= clock.o
 obj-y				+= pwm-clock.o
 obj-y				+= gpio.o
-- 
1.6.2.5
