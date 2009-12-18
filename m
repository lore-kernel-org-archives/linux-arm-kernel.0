From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 18 Dec 2009 18:19:55 +0900
Subject: [PATCH 4/7] ARM: S5P6440: Add Timer support
In-Reply-To: <1261127996-30253-3-git-send-email-kgene.kim@samsung.com>
References: <1261127996-30253-1-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-2-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <1261127996-30253-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds timer support for S5P6440 CPU.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Adityapratap Sharma <aditya.ps@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
---
 arch/arm/mach-s5p6440/include/mach/pwm-clock.h |   58 ++++++
 arch/arm/mach-s5p6440/include/mach/tick.h      |   24 +++
 arch/arm/plat-s5p/time.c                       |  227 ++++++++++++++++++++++++
 3 files changed, 309 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5p6440/include/mach/pwm-clock.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/tick.h
 create mode 100644 arch/arm/plat-s5p/time.c

diff --git a/arch/arm/mach-s5p6440/include/mach/pwm-clock.h b/arch/arm/mach-s5p6440/include/mach/pwm-clock.h
new file mode 100644
index 0000000..f6a6c30
--- /dev/null
+++ b/arch/arm/mach-s5p6440/include/mach/pwm-clock.h
@@ -0,0 +1,58 @@
+/* linux/arch/arm/mach-s5p6440/include/mach/pwm-clock.h
+ *
+ * Copyright 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6440 - pwm clock and timer support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/**
+ * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
+ * @cfg: The timer TCFG1 register bits shifted down to 0.
+ *
+ * Return true if the given configuration from TCFG1 is a TCLK instead
+ * any of the TDIV clocks.
+ */
+static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
+{
+	return tcfg == S3C2410_TCFG1_MUX_TCLK;
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
+	return 1 << (1 + tcfg1);
+}
+
+/**
+ * pwm_tdiv_has_div1() - does the tdiv setting have a /1
+ *
+ * Return true if we have a /1 in the tdiv setting.
+ */
+static inline unsigned int pwm_tdiv_has_div1(void)
+{
+	return 0;
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
+	return ilog2(div) - 1;
+}
+
+#define S3C_TCFG1_MUX_TCLK S3C2410_TCFG1_MUX_TCLK
diff --git a/arch/arm/mach-s5p6440/include/mach/tick.h b/arch/arm/mach-s5p6440/include/mach/tick.h
new file mode 100644
index 0000000..70d1f37
--- /dev/null
+++ b/arch/arm/mach-s5p6440/include/mach/tick.h
@@ -0,0 +1,24 @@
+/* linux/arch/arm/mach-s5p6440/include/mach/tick.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P6440 - Timer tick support definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_TICK_H
+#define __ASM_ARCH_TICK_H __FILE__
+
+/* s3c compatibility definition */
+static inline u32 s3c24xx_ostimer_pending(void)
+{
+	return 0;
+}
+
+#define TICK_MAX	(0xffffffff)
+
+#endif /* __ASM_ARCH_TICK_H */
diff --git a/arch/arm/plat-s5p/time.c b/arch/arm/plat-s5p/time.c
new file mode 100644
index 0000000..a5aca07
--- /dev/null
+++ b/arch/arm/plat-s5p/time.c
@@ -0,0 +1,227 @@
+/* linux/arch/arm/plat-s5p/time.c
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P Timer support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include <asm/system.h>
+#include <asm/leds.h>
+#include <asm/mach-types.h>
+
+#include <asm/irq.h>
+#include <mach/map.h>
+#include <plat/regs-timer.h>
+#include <mach/regs-irq.h>
+#include <asm/mach/time.h>
+#include <mach/tick.h>
+
+#include <plat/clock.h>
+#include <plat/cpu.h>
+
+static unsigned long timer_startval;
+static unsigned long timer_usec_ticks;
+
+#ifndef TICK_MAX
+#define TICK_MAX (0xffff)
+#endif
+
+#define TIMER_USEC_SHIFT		16
+
+#define S5P6440_TCFG1_MUX4_DIV1	(0<<16)
+#define S5P6440_TCFG1_MUX4_DIV2	(1<<16)
+#define S5P6440_TCFG1_MUX4_DIV4	(2<<16)
+#define S5P6440_TCFG1_MUX4_DIV8	(3<<16)
+#define S5P6440_TCFG1_MUX4_DIV16	(4<<16)
+
+/* we use the shifted arithmetic to work out the ratio of timer ticks
+ * to usecs, as often the peripheral clock is not a nice even multiple
+ * of 1MHz.
+ *
+ * shift of 14 and 15 are too low for the 12MHz, 16 seems to be ok
+ * for the current HZ value of 200 without producing overflows.
+ *
+ * Original patch by Dimitry Andric, updated by Ben Dooks
+*/
+
+/* timer_mask_usec_ticks
+ *
+ * given a clock and divisor, make the value to pass into timer_ticks_to_usec
+ * to scale the ticks into usecs
+*/
+
+static inline unsigned long
+timer_mask_usec_ticks(unsigned long scaler, unsigned long pclk)
+{
+	unsigned long den = pclk / 1000;
+
+	return ((1000 << TIMER_USEC_SHIFT) * scaler + (den >> 1)) / den;
+}
+
+/* timer_ticks_to_usec
+ *
+ * convert timer ticks to usec.
+*/
+
+static inline unsigned long timer_ticks_to_usec(unsigned long ticks)
+{
+	unsigned long res;
+
+	res = ticks * timer_usec_ticks;
+	res += 1 << (TIMER_USEC_SHIFT - 4);	/* round up slightly */
+
+	return res >> TIMER_USEC_SHIFT;
+}
+
+/* note, the timer interrutps turn up in 2 places, the vic and then
+ * the timer block. We take the VIC as the base at the moment.
+*/
+
+static inline u32 s5p_ostimer_pending(void)
+{
+	u32 pend = __raw_readl(S5P_VA_VIC0 + VIC_RAW_STATUS);
+	return pend & (1 << (IRQ_TIMER4_VIC - S5P_IRQ_VIC0(0)));
+}
+
+/* Returns microsecond  since last clock interrupt.  Note that interrupts
+ * will have been disabled by do_gettimeoffset()
+ * IRQs are disabled before entering here from do_gettimeofday()
+*/
+
+static unsigned long s5p6440_gettimeoffset(void)
+{
+	unsigned long tdone;
+	unsigned long tval;
+
+	/* work out how many ticks have gone since last timer interrupt */
+
+	tval =  __raw_readl(S3C2410_TCNTO(4));
+	tdone = timer_startval - tval;
+
+	/* check to see if there is an interrupt pending */
+
+	if (s5p_ostimer_pending()) {
+
+		/* re-read the timer, and try and fix up for the missed
+		 * interrupt. Note, the interrupt may go off before the
+		 * timer has re-loaded from wrapping.
+		 */
+
+		tval =  __raw_readl(S3C2410_TCNTO(4));
+		tdone = timer_startval - tval;
+
+		if (tval != 0)
+			tdone += timer_startval;
+	}
+
+	return timer_ticks_to_usec(tdone);
+}
+
+/* IRQ handler for the timer */
+
+static irqreturn_t s5p6440_timer_interrupt(int irq, void *dev_id)
+{
+	timer_tick();
+	return IRQ_HANDLED;
+}
+
+static struct irqaction s5p6440_timer_irq = {
+	.name		= "S5P6440 Timer Tick",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= s5p6440_timer_interrupt,
+};
+
+static void s5p6440_timer_setup(void)
+{
+	unsigned long tcon;
+	unsigned long tcnt;
+	unsigned long tcfg1;
+	unsigned long tcfg0;
+	unsigned long pclk;
+	struct clk *clk;
+
+	tcnt = TICK_MAX;  /* default value for tcnt */
+
+	/* read the current timer configuration bits */
+
+	tcon = __raw_readl(S3C2410_TCON);
+	tcfg1 = __raw_readl(S3C2410_TCFG1);
+	tcfg0 = __raw_readl(S3C2410_TCFG0);
+
+	clk = clk_get(NULL, "timers");
+	if (IS_ERR(clk))
+		panic("failed to get clock for system timer");
+
+	clk_enable(clk);
+	pclk = clk_get_rate(clk);
+
+	/* configure clock tick */
+
+	timer_usec_ticks = timer_mask_usec_ticks(6, pclk);
+
+	tcfg1 &= ~S3C2410_TCFG1_MUX4_MASK;
+	tcfg1 |= S5P6440_TCFG1_MUX4_DIV1;
+	tcfg0 &= ~S3C2410_TCFG_PRESCALER1_MASK;
+	tcfg0 |= (6) << S3C2410_TCFG_PRESCALER1_SHIFT;
+	tcnt = (pclk / 7) / HZ;
+
+	/* timers reload after counting zero, so reduce the count by 1 */
+
+	tcnt--;
+
+	/* check to see if timer is within 16bit range... */
+
+	if (tcnt > TICK_MAX) {
+		panic("setup_timer: HZ is too small, cannot configure timer!");
+		return;
+	}
+
+	__raw_writel(tcfg1, S3C2410_TCFG1);
+	__raw_writel(tcfg0, S3C2410_TCFG0);
+
+	timer_startval = tcnt;
+	__raw_writel(tcnt, S3C2410_TCNTB(4));
+
+	/* ensure timer is stopped... */
+
+	tcon &= ~(7<<20);
+	tcon |= S3C2410_TCON_T4RELOAD;
+	tcon |= S3C2410_TCON_T4MANUALUPD;
+
+	__raw_writel(tcon, S3C2410_TCON);
+	__raw_writel(tcnt, S3C2410_TCNTB(4));
+	__raw_writel(tcnt, S3C2410_TCMPB(4));
+
+	/* start the timer running */
+
+	tcon |= S3C2410_TCON_T4START;
+	tcon &= ~S3C2410_TCON_T4MANUALUPD;
+	__raw_writel(tcon, S3C2410_TCON);
+}
+
+static void __init s5p6440_timer_init(void)
+{
+	s5p6440_timer_setup();
+	setup_irq(IRQ_TIMER4, &s5p6440_timer_irq);
+}
+
+struct sys_timer s5p6440_timer = {
+	.init		= s5p6440_timer_init,
+	.offset		= s5p6440_gettimeoffset,
+	.resume		= s5p6440_timer_setup
+};
-- 
1.6.2.5
