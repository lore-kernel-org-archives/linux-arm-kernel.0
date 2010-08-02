From: singh.madhav@samsung.com (MADHAV SINGHCHAUHAN)
Date: Mon, 02 Aug 2010 05:21:59 +0000 (GMT)
Subject: [PATCH V2] HRT support in Samsung S5P Platform
Message-ID: <9852485.1007371280726519429.JavaMail.weblogic@epml04>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Madhav Singh <singh.madhav@samsung.com>
Date: Wed, 28 Jul 2010 12:25:11 +0530
Subject: [PATCH] HRT support in Samsung S5P Platform
From: Jaecheol Lee <jc.lee@samsung.com>
 In this version of patch credits are corrected,and accepted reviewers
 comment like removing 'default n' in Kconfig, removing redundant clock
 source etc.
 Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
 Signed-off-by: Madhav Chauhan <singh.madhav@samsung.com>
 Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

---
 arch/arm/mach-s5pv210/Kconfig                   |    8 +
 arch/arm/mach-s5pv210/include/mach/map.h        |    3 +
 arch/arm/plat-s5p/Makefile                      |    2 +-
 arch/arm/plat-s5p/clock.c                       |    8 +-
 arch/arm/plat-s5p/hr-time-rtc.c                 |  462 +++++++++++++++++++++++
 arch/arm/plat-s5p/include/plat/regs-sys-timer.h |   63 +++
 arch/arm/plat-samsung/Makefile                  |    2 +
 arch/arm/plat-samsung/include/plat/regs-rtc.h   |    4 +
 8 files changed, 550 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/plat-s5p/hr-time-rtc.c
 create mode 100644 arch/arm/plat-s5p/include/plat/regs-sys-timer.h

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 631019a..8b2c51f 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -101,4 +101,12 @@ config MACH_SMDKC110
 	  Machine support for Samsung SMDKC110
 	  S5PC110(MCP) is one of package option of S5PV210
 
+config SAMSUNG_HRT_RTC_SYSTIMER
+	bool "HRtimer and Dynamic Tick support"
+	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
+	select HIGH_RES_TIMERS
+	help
+          Support for HRtimer and Dynamic Tick system using RTC and SYSTEM timer
+
 endif
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 17687f0..9d6cc3c 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -43,6 +43,9 @@
 
 #define S5PV210_PA_SYSTIMER	(0xE2600000)
 
+#define S5PC11X_PA_RTC		(0xE2800000)
+#define S3C_PA_RTC		S5PC11X_PA_RTC
+
 #define S5PV210_PA_WATCHDOG	(0xE2700000)
 
 #define S5PV210_PA_UART		(0xE2900000)
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 18c9e34..78f0af7 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -18,4 +18,4 @@ obj-y				+= cpu.o
 obj-y				+= clock.o
 obj-y				+= irq.o irq-gpioint.o
 obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
-
+obj-$(CONFIG_SAMSUNG_HRT_RTC_SYSTIMER)	+= hr-time-rtc.o
diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
index b5e2552..e438ce3 100644
--- a/arch/arm/plat-s5p/clock.c
+++ b/arch/arm/plat-s5p/clock.c
@@ -89,7 +89,12 @@ struct clk clk_arm = {
 	.ctrlbit	= 0,
 };
 
-/* Possible clock sources for APLL Mux */
+struct clk clk_ext_xtal_rtc = {
+	.name		= "XrtcXTI",
+	.id		= -1,
+	.rate           = 32768,
+};
+
 static struct clk *clk_src_apll_list[] = {
 	[0] = &clk_fin_apll,
 	[1] = &clk_fout_apll,
@@ -149,6 +154,7 @@ static struct clk *s5p_clks[] __initdata = {
 	&clk_arm,
 	&clk_vpll,
 	&clk_xusbxti,
+	&clk_ext_xtal_rtc,
 };
 
 void __init s5p_register_clocks(unsigned long xtal_freq)
diff --git a/arch/arm/plat-s5p/hr-time-rtc.c b/arch/arm/plat-s5p/hr-time-rtc.c
new file mode 100644
index 0000000..a6b3ed6
--- /dev/null
+++ b/arch/arm/plat-s5p/hr-time-rtc.c
@@ -0,0 +1,462 @@
+/*
+ * linux/arch/arm/plat-s5p/hr-time-rtc.c
+ *
+ * S5PC11X Timers
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics
+ *
+ * S5PC11X (and compatible) HRT support using RTC and SYSTEM TIMER
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
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/io.h>
+#include <asm/system.h>
+#include <mach/hardware.h>
+#include <asm/irq.h>
+#include <asm/mach/irq.h>
+#include <asm/mach/time.h>
+#include <asm/mach-types.h>
+#include <mach/map.h>
+#include <plat/regs-timer.h>
+#include <plat/regs-rtc.h>
+#include <plat/regs-sys-timer.h>
+#include <mach/regs-irq.h>
+#include <mach/tick.h>
+#include <plat/clock.h>
+#include <plat/cpu.h>
+
+/*For SCHED_CLOCK*/
+static unsigned long long time_stamp;
+static unsigned long long s5pc11x_sched_timer_overflows;
+static unsigned long long old_overflows;
+static cycle_t last_ticks;
+
+/*
+ * Sched timer interrupt is not processed right after
+ * timer counter expired
+ */
+static unsigned int pending_irq;
+
+/*
+ * sched_timer_running
+ * 0 : sched timer stopped or not initialized
+ * 1 : sched timer started
+ */
+static unsigned int sched_timer_running;
+
+static void __iomem *rtc_base;
+static struct clk *clk_event;
+static int tick_timer_mode;	/* 0: oneshot, 1: autoreload */
+
+#define RTC_CLOCK		(32768)
+#define RTC_DEFAULT_TICK	((RTC_CLOCK / HZ) - 1)
+
+/*
+ * Helper functions
+ * s5pc11x_systimer_read() : Read from System timer register
+ * s5pc11x_systimer_write(): Write to System timer register
+ *
+ */
+static unsigned int s5pc11x_systimer_read(unsigned int *reg_offset)
+{
+	return __raw_readl(reg_offset);
+}
+
+static unsigned int s5pc11x_systimer_write(unsigned int *reg_offset,
+					unsigned int value)
+{
+	unsigned int temp_regs;
+
+	__raw_writel(value, reg_offset);
+
+	if (reg_offset == S5P_SYSTIMER_TCON) {
+		while (!(__raw_readl(S5P_SYSTIMER_INT_CSTAT) &
+				S5P_SYSTIMER_INT_TCON));
+		temp_regs = __raw_readl(S5P_SYSTIMER_INT_CSTAT);
+		temp_regs |= S5P_SYSTIMER_INT_TCON;
+		__raw_writel(temp_regs, S5P_SYSTIMER_INT_CSTAT);
+
+	} else if (reg_offset == S5P_SYSTIMER_ICNTB) {
+		while (!(__raw_readl(S5P_SYSTIMER_INT_CSTAT) &
+				S5P_SYSTIMER_INT_ICNTB));
+		temp_regs = __raw_readl(S5P_SYSTIMER_INT_CSTAT);
+		temp_regs |= S5P_SYSTIMER_INT_ICNTB;
+		__raw_writel(temp_regs, S5P_SYSTIMER_INT_CSTAT);
+
+	} else if (reg_offset == S5P_SYSTIMER_TCNTB) {
+		while (!(__raw_readl(S5P_SYSTIMER_INT_CSTAT) &
+				S5P_SYSTIMER_INT_TCNTB));
+		temp_regs = __raw_readl(S5P_SYSTIMER_INT_CSTAT);
+		temp_regs |= S5P_SYSTIMER_INT_TCNTB;
+		__raw_writel(temp_regs, S5P_SYSTIMER_INT_CSTAT);
+	}
+
+	return 0;
+}
+
+static void s5pc11x_rtc_set_tick(int enabled)
+{
+	unsigned int tmp;
+
+	tmp = __raw_readl(rtc_base + S3C2410_RTCCON) & ~S3C_RTCCON_TICEN;
+	if (enabled)
+		tmp |= S3C_RTCCON_TICEN;
+	__raw_writel(tmp, rtc_base + S3C2410_RTCCON);
+}
+
+static void s5pc11x_tick_timer_setup(void);
+
+static void s5pc11x_tick_timer_start(unsigned long load_val,
+					int autoreset)
+{
+	unsigned int tmp;
+
+	tmp = __raw_readl(rtc_base + S3C2410_RTCCON) &
+		~(S3C_RTCCON_TICEN | S3C2410_RTCCON_RTCEN);
+	__raw_writel(tmp, rtc_base + S3C2410_RTCCON);
+
+	__raw_writel(load_val, rtc_base + S3C2410_TICNT);
+
+	tmp |= S3C_RTCCON_TICEN;
+
+	__raw_writel(tmp, rtc_base + S3C2410_RTCCON);
+}
+
+static  void s5pc11x_tick_timer_stop(void)
+{
+	unsigned int tmp;
+
+	tmp = __raw_readl(rtc_base + S3C2410_RTCCON) &
+		~(S3C_RTCCON_TICEN | S3C2410_RTCCON_RTCEN);
+
+	__raw_writel(tmp, rtc_base + S3C2410_RTCCON);
+
+}
+
+static void s5pc11x_sched_timer_start(unsigned long load_val,
+					int autoreset)
+{
+	unsigned long tcon;
+	unsigned long tcnt;
+	unsigned long tcfg;
+
+	/* clock configuration setting and enable */
+	struct clk *clk;
+
+	tcnt = TICK_MAX;  /* default value for tcnt */
+
+	/* initialize system timer clock */
+	tcfg = s5pc11x_systimer_read(S5P_SYSTIMER_TCFG);
+
+	tcfg &= ~S5P_SYSTIMER_TCLK_MASK;
+	tcfg |= S5P_SYSTIMER_TCLK_USB;
+
+	s5pc11x_systimer_write(S5P_SYSTIMER_TCFG, tcfg);
+
+	/* TCFG must not be changed at run-time.
+	 * If you want to change TCFG, stop timer(TCON[0] = 0)
+	 */
+	s5pc11x_systimer_write(S5P_SYSTIMER_TCON, 0);
+
+	/* read the current timer configuration bits */
+	tcon = s5pc11x_systimer_read(S5P_SYSTIMER_TCON);
+	tcfg = s5pc11x_systimer_read(S5P_SYSTIMER_TCFG);
+
+	clk = clk_get(NULL, "systimer");
+	if (IS_ERR(clk))
+		panic("failed to get clock[%s] for system timer", "systimer");
+
+	clk_enable(clk);
+
+	clk_put(clk);
+
+	tcfg &= ~S5P_SYSTIMER_TCLK_MASK;
+	tcfg |= S5P_SYSTIMER_TCLK_USB;
+	tcfg &= ~S5P_SYSTIMER_PRESCALER_MASK;
+
+	/* check to see if timer is within 16bit range... */
+	if (tcnt > TICK_MAX) {
+		panic("setup_timer: cannot configure timer!");
+		return;
+	}
+
+	s5pc11x_systimer_write(S5P_SYSTIMER_TCFG, tcfg);
+
+	s5pc11x_systimer_write(S5P_SYSTIMER_TCNTB, tcnt);
+
+	/* set timer con */
+	tcon =  S5P_SYSTIMER_INT_AUTO | S5P_SYSTIMER_START |
+			S5P_SYSTIMER_AUTO_RELOAD;
+	s5pc11x_systimer_write(S5P_SYSTIMER_TCON, tcon);
+
+	tcon |= S5P_SYSTIMER_INT_START;
+	s5pc11x_systimer_write(S5P_SYSTIMER_TCON, tcon);
+
+	/* Interrupt Start and Enable */
+	s5pc11x_systimer_write(S5P_SYSTIMER_INT_CSTAT,
+				(S5P_SYSTIMER_INT_ICNTEIE |
+					S5P_SYSTIMER_INT_EN));
+	sched_timer_running = 1;
+}
+
+/*
+ * RTC tick : count down to zero, interrupt, reload
+ */
+static int s5pc11x_tick_set_next_event(unsigned long cycles,
+				   struct clock_event_device *evt)
+{
+	if  (cycles == 0)	/* Should be larger than 0 */
+		cycles = 1;
+	s5pc11x_tick_timer_start(cycles, 0);
+	return 0;
+}
+
+static void s5pc11x_tick_set_mode(enum clock_event_mode mode,
+			      struct clock_event_device *evt)
+{
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		tick_timer_mode = 1;
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		s5pc11x_tick_timer_stop();
+		tick_timer_mode = 0;
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		/* Sched timer stopped */
+		sched_timer_running = 0;
+		/* Reset sched_clock variables after sleep/wakeup */
+		last_ticks = 0;
+		s5pc11x_sched_timer_overflows = 0;
+		old_overflows = 0;
+		pending_irq = 0;
+		break;
+	case CLOCK_EVT_MODE_RESUME:
+		s5pc11x_tick_timer_setup();
+		s5pc11x_sched_timer_start(~0, 1);
+		break;
+	}
+}
+
+static struct clock_event_device clockevent_tick_timer = {
+	.name		= "S5PC110 event timer",
+	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.shift		= 32,
+	.set_next_event	= s5pc11x_tick_set_next_event,
+	.set_mode	= s5pc11x_tick_set_mode,
+};
+
+irqreturn_t s5pc11x_tick_timer_interrupt(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = &clockevent_tick_timer;
+
+	__raw_writel(S3C_INTP_TIC, rtc_base + S3C_INTP);
+	/* In case of oneshot mode */
+	if (tick_timer_mode == 0)
+		s5pc11x_tick_timer_stop();
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction s5pc11x_tick_timer_irq = {
+	.name		= "rtc-tick",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= s5pc11x_tick_timer_interrupt,
+};
+
+static void  s5pc11x_init_dynamic_tick_timer(unsigned long rate)
+{
+	tick_timer_mode = 1;
+
+	rtc_base = ioremap(S3C_PA_RTC, SZ_4K);
+
+	s5pc11x_tick_timer_stop();
+
+	s5pc11x_tick_timer_start((rate / HZ) - 1, 1);
+
+	clockevent_tick_timer.mult = div_sc(rate, NSEC_PER_SEC,
+					    clockevent_tick_timer.shift);
+	clockevent_tick_timer.max_delta_ns =
+		clockevent_delta2ns(-1, &clockevent_tick_timer);
+	clockevent_tick_timer.min_delta_ns =
+		clockevent_delta2ns(1, &clockevent_tick_timer);
+
+	clockevent_tick_timer.cpumask = cpumask_of(0);
+	clockevents_register_device(&clockevent_tick_timer);
+
+	printk(KERN_INFO "mult[%u]\n", clockevent_tick_timer.mult);
+	printk(KERN_INFO "max_delta_ns[%u]\n", clockevent_tick_timer.max_delta_ns);
+	printk(KERN_INFO "min_delta_ns[%u]\n", clockevent_tick_timer.min_delta_ns);
+	printk(KERN_INFO "rate[%lu]\n", rate);
+	printk(KERN_INFO "HZ[%d]\n", HZ);
+}
+
+/*
+ * ---------------------------------------------------------------------------
+ * SYSTEM TIMER ... free running 32-bit clock source and scheduler clock
+ * ---------------------------------------------------------------------------
+ */
+irqreturn_t s5pc11x_sched_timer_interrupt(int irq, void *dev_id)
+{
+	volatile unsigned int temp_cstat;
+
+	temp_cstat = s5pc11x_systimer_read(S5P_SYSTIMER_INT_CSTAT);
+	temp_cstat |= S5P_SYSTIMER_INT_STATS;
+
+	s5pc11x_systimer_write(S5P_SYSTIMER_INT_CSTAT, temp_cstat);
+
+	if (unlikely(pending_irq))
+		pending_irq = 0;
+	else
+		s5pc11x_sched_timer_overflows++;
+
+	return IRQ_HANDLED;
+}
+
+struct irqaction s5pc11x_systimer_irq = {
+	.name		= "System timer",
+	.flags		= IRQF_DISABLED ,
+	.handler	= s5pc11x_sched_timer_interrupt,
+};
+
+static cycle_t s5pc11x_sched_timer_read(void)
+{
+	return (cycle_t)~__raw_readl(S5P_SYSTIMER_TCNTO);
+}
+
+struct clocksource clocksource_s5pc11x = {
+	.name		= "clock_source_systimer",
+	.rating		= 300,
+	.read		= s5pc11x_sched_timer_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift		= 20,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
+static void s5pc11x_init_clocksource(unsigned long rate)
+{
+	static char err[] __initdata = KERN_ERR
+			"%s: can't register clocksource!\n";
+
+	clocksource_s5pc11x.mult
+		= clocksource_khz2mult(rate/1000, clocksource_s5pc11x.shift);
+
+
+	s5pc11x_sched_timer_start(~0, 1);
+
+	if (clocksource_register(&clocksource_s5pc11x))
+		printk(err, clocksource_s5pc11x.name);
+}
+
+/*
+ * Returns current time from boot in nsecs. It's OK for this to wrap
+ * around for now, as it's just a relative time stamp.
+ */
+unsigned long long sched_clock(void)
+{
+	unsigned long irq_flags;
+	cycle_t ticks, elapsed_ticks = 0;
+	unsigned long long increment = 0;
+	unsigned int overflow_cnt = 0;
+
+	local_irq_save(irq_flags);
+
+	if (likely(sched_timer_running)) {
+		overflow_cnt = (s5pc11x_sched_timer_overflows - old_overflows);
+
+		ticks = s5pc11x_sched_timer_read();
+
+		if (overflow_cnt) {
+			increment = (overflow_cnt - 1) *
+					(clocksource_cyc2ns(clocksource_s5pc11x.mask,
+					clocksource_s5pc11x.mult, clocksource_s5pc11x.shift));
+			elapsed_ticks = (clocksource_s5pc11x.mask - last_ticks) + ticks;
+		} else {
+			if (unlikely(last_ticks > ticks)) {
+				pending_irq = 1;
+				elapsed_ticks = (clocksource_s5pc11x.mask - last_ticks) + ticks;
+				s5pc11x_sched_timer_overflows++;
+			} else {
+				elapsed_ticks = (ticks - last_ticks);
+			}
+		}
+
+		time_stamp += (clocksource_cyc2ns(elapsed_ticks, clocksource_s5pc11x.mult, clocksource_s5pc11x.shift) + increment);
+
+		old_overflows = s5pc11x_sched_timer_overflows;
+		last_ticks = ticks;
+	}
+	local_irq_restore(irq_flags);
+
+	return time_stamp;
+}
+
+/*
+ *  Event/Sched Timer initialization
+ */
+static void s5pc11x_timer_setup(void)
+{
+	unsigned long rate;
+
+	/* Setup event timer using XrtcXTI */
+	if (clk_event == NULL)
+		clk_event = clk_get(NULL, "XrtcXTI");
+	if (IS_ERR(clk_event))
+		panic("failed to get clock for event timer");
+	rate = clk_get_rate(clk_event);
+	s5pc11x_init_dynamic_tick_timer(rate);
+	s5pc11x_init_clocksource(rate);
+}
+
+static void s5pc11x_tick_timer_setup(void)
+{
+	unsigned long rate;
+
+	rate = clk_get_rate(clk_event);
+	s5pc11x_tick_timer_start((rate / HZ) - 1, 1);
+}
+
+static void __init s5pc11x_timer_init(void)
+{
+	/* Initialize variables before starting each timers */
+	last_ticks = 0;
+	s5pc11x_sched_timer_overflows = 0;
+	old_overflows = 0;
+	time_stamp = 0;
+	sched_timer_running = 0;
+	pending_irq = 0;
+	s5pc11x_timer_setup();
+	setup_irq(IRQ_RTC_TIC, &s5pc11x_tick_timer_irq);
+	setup_irq(IRQ_SYSTIMER, &s5pc11x_systimer_irq);
+}
+
+struct sys_timer s3c24xx_timer = {
+	.init		= s5pc11x_timer_init,
+};
+
diff --git a/arch/arm/plat-s5p/include/plat/regs-sys-timer.h b/arch/arm/plat-s5p/include/plat/regs-sys-timer.h
new file mode 100644
index 0000000..912f1ac
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/regs-sys-timer.h
@@ -0,0 +1,63 @@
+/* arch/arm/plat-s5p/include/plat/regs-sys-timer.h
+ *
+ * Copyright (c) 2008 Samsung Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * S5PC1XX System Timer configuration
+*/
+
+#ifndef __ASM_ARCH_REGS_SYS_TIMER_H
+#define __ASM_ARCH_REGS_SYS_TIMER_H
+
+#define S5P_SYSTIMERREG(x)		(S5P_VA_SYSTIMER + (x))
+
+#define S5P_SYSTIMER_TCFG		S5P_SYSTIMERREG(0x00)
+#define S5P_SYSTIMER_TCON		S5P_SYSTIMERREG(0x04)
+#define S5P_SYSTIMER_TCNTB		S5P_SYSTIMERREG(0x08)
+#define S5P_SYSTIMER_TCNTO		S5P_SYSTIMERREG(0x0c)
+
+#define S5P_SYSTIMER_TFCNTB		S5P_SYSTIMERREG(0x10)
+#define S5P_SYSTIMER_ICNTB		S5P_SYSTIMERREG(0x18)
+#define S5P_SYSTIMER_ICNTO		S5P_SYSTIMERREG(0x1c)
+#define S5P_SYSTIMER_INT_CSTAT		S5P_SYSTIMERREG(0x20)
+
+/* Value for TCFG */
+#define S5P_SYSTIMER_TCLK_MASK		(3<<12)
+#define S5P_SYSTIMER_TCLK_XXTI		(0<<12)
+#define S5P_SYSTIMER_TCLK_RTC		(1<<12)
+#define S5P_SYSTIMER_TCLK_USB		(2<<12)
+#define S5P_SYSTIMER_TCLK_PCLK		(3<<12)
+
+#define S5P_SYSTIMER_DIV_MASK		(7<<8)
+#define S5P_SYSTIMER_DIV_1		(0<<8)
+#define S5P_SYSTIMER_DIV_2		(1<<8)
+#define S5P_SYSTIMER_DIV_4		(2<<8)
+#define S5P_SYSTIMER_DIV_8		(3<<8)
+#define S5P_SYSTIMER_DIV_16		(4<<8)
+
+#define S5P_SYSTIMER_TARGET_HZ		200
+#define S5P_SYSTIMER_PRESCALER		5
+#define S5P_SYSTIMER_PRESCALER_MASK	(0x3f<<0)
+
+/* value for TCON */
+#define S5P_SYSTIMER_INT_AUTO		(1<<5)
+#define S5P_SYSTIMER_INT_IMM		(1<<4)
+#define S5P_SYSTIMER_INT_START		(1<<3)
+#define S5P_SYSTIMER_AUTO_RELOAD	(1<<2)
+#define S5P_SYSTIMER_IMM_UPDATE		(1<<1)
+#define S5P_SYSTIMER_START		(1<<0)
+
+/* Value for INT_CSTAT */
+#define S5P_SYSTIMER_INT_IWIE		(1<<9)
+#define S5P_SYSTIMER_INT_TWIE		(1<<10)
+#define S5P_SYSTIMER_INT_ICNTEIE	(1<<6)
+#define S5P_SYSTIMER_INT_TCON		(1<<5)
+#define S5P_SYSTIMER_INT_ICNTB		(1<<4)
+#define S5P_SYSTIMER_INT_TCNTB		(1<<2)
+#define S5P_SYSTIMER_INT_STATS		(1<<1)
+#define S5P_SYSTIMER_INT_EN		(1<<0)
+
+#endif /*  __ASM_ARCH_REGS_TIMER_H */
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 8269d80..a61c93c 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -12,7 +12,9 @@ obj-				:=
 # Objects we always build independent of SoC choice
 
 obj-y				+= init.o
+ifndef CONFIG_SAMSUNG_HRT_RTC_SYSTIMER
 obj-y				+= time.o
+endif
 obj-y				+= clock.o
 obj-y				+= pwm-clock.o
 obj-y				+= gpio.o
diff --git a/arch/arm/plat-samsung/include/plat/regs-rtc.h b/arch/arm/plat-samsung/include/plat/regs-rtc.h
index 65c190d..da1abf6 100644
--- a/arch/arm/plat-samsung/include/plat/regs-rtc.h
+++ b/arch/arm/plat-samsung/include/plat/regs-rtc.h
@@ -21,6 +21,10 @@
 #define S3C2410_RTCCON_CNTSEL (1<<2)
 #define S3C2410_RTCCON_CLKRST (1<<3)
 #define S3C64XX_RTCCON_TICEN  (1<<8)
+#define S3C_INTP		S3C2410_RTCREG(0X30)
+#define S3C_INTP_ALM		(1<<1)
+#define S3C_INTP_TIC		(1<<0)
+#define S3C_RTCCON_TICEN	(1<<8)
 
 #define S3C64XX_RTCCON_TICMSK (0xF<<7)
 #define S3C64XX_RTCCON_TICSHT (7)
-- 
1.6.0.4


 
 
