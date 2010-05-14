From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 May 2010 17:51:30 +0900
Subject: [PATCH v2] ARM: S5P: Add System Timer
Message-ID: <1273827090-26635-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko@samsung.com>

This patch addes system timer for Samsung S5P series SoCs

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6442/include/mach/tick.h      |    6 +
 arch/arm/mach-s5p6442/mach-smdk6442.c          |    2 +-
 arch/arm/mach-s5pv210/include/mach/tick.h      |    6 +
 arch/arm/mach-s5pv210/mach-smdkc110.c          |    2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c          |    2 +-
 arch/arm/plat-s5p/Kconfig                      |    7 +
 arch/arm/plat-s5p/Makefile                     |    1 +
 arch/arm/plat-s5p/include/plat/regs-systimer.h |   75 ++++++
 arch/arm/plat-s5p/s5p-systimer.c               |  287 ++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/cpu.h       |    3 +
 10 files changed, 388 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/plat-s5p/include/plat/regs-systimer.h
 create mode 100644 arch/arm/plat-s5p/s5p-systimer.c

diff --git a/arch/arm/mach-s5p6442/include/mach/tick.h b/arch/arm/mach-s5p6442/include/mach/tick.h
index e1d4cab..1795b43 100644
--- a/arch/arm/mach-s5p6442/include/mach/tick.h
+++ b/arch/arm/mach-s5p6442/include/mach/tick.h
@@ -21,6 +21,12 @@ static inline u32 s3c24xx_ostimer_pending(void)
 	return pend & (1 << (IRQ_TIMER4_VIC - S5P_IRQ_VIC0(0)));
 }
 
+static inline u32 s5p_ostimer_pending(void)
+{
+	u32 pend = __raw_readl(VA_VIC0 + VIC_RAW_STATUS);
+	return pend & (1 << (IRQ_SYSTIMER - S5P_IRQ_VIC0(0)));
+}
+
 #define TICK_MAX	(0xffffffff)
 
 #endif /* __ASM_ARCH_TICK_H */
diff --git a/arch/arm/mach-s5p6442/mach-smdk6442.c b/arch/arm/mach-s5p6442/mach-smdk6442.c
index 0d63371..6c8728b 100644
--- a/arch/arm/mach-s5p6442/mach-smdk6442.c
+++ b/arch/arm/mach-s5p6442/mach-smdk6442.c
@@ -87,5 +87,5 @@ MACHINE_START(SMDK6442, "SMDK6442")
 	.init_irq	= s5p6442_init_irq,
 	.map_io		= smdk6442_map_io,
 	.init_machine	= smdk6442_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s5p_systimer,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv210/include/mach/tick.h b/arch/arm/mach-s5pv210/include/mach/tick.h
index 7993b36..9fc5a8d 100644
--- a/arch/arm/mach-s5pv210/include/mach/tick.h
+++ b/arch/arm/mach-s5pv210/include/mach/tick.h
@@ -21,6 +21,12 @@ static inline u32 s3c24xx_ostimer_pending(void)
 	return pend & (1 << (IRQ_TIMER4_VIC - S5P_IRQ_VIC0(0)));
 }
 
+static inline u32 s5p_ostimer_pending(void)
+{
+	u32 pend = __raw_readl(VA_VIC0 + VIC_RAW_STATUS);
+	return pend & (1 << (IRQ_SYSTIMER - S5P_IRQ_VIC0(0)));
+}
+
 #define TICK_MAX	(0xffffffff)
 
 #endif /* __ASM_ARCH_TICK_H */
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index ab4869d..b520817 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -94,5 +94,5 @@ MACHINE_START(SMDKC110, "SMDKC110")
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= smdkc110_map_io,
 	.init_machine	= smdkc110_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s5p_systimer,
 MACHINE_END
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index a278832..2a29d47 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -94,5 +94,5 @@ MACHINE_START(SMDKV210, "SMDKV210")
 	.init_irq	= s5pv210_init_irq,
 	.map_io		= smdkv210_map_io,
 	.init_machine	= smdkv210_machine_init,
-	.timer		= &s3c24xx_timer,
+	.timer		= &s5p_systimer,
 MACHINE_END
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index d400a6a..e152bbc 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -23,3 +23,10 @@ config PLAT_S5P
 	select SAMSUNG_IRQ_UART
 	help
 	  Base platform code for Samsung's S5P series SoC.
+
+config S5P_SYSTIMER
+	bool
+	depends on (ARCH_S5P6442 || ARCH_S5PV210)
+	default y
+	help
+	  Support System Timer for S5P Series
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 7f44678..dbc6595 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -17,3 +17,4 @@ obj-y				+= cpu.o
 obj-y				+= clock.o
 obj-y				+= irq.o
 obj-y				+= setup-i2c0.o
+obj-$(CONFIG_S5P_SYSTIMER)	+= s5p-systimer.o
diff --git a/arch/arm/plat-s5p/include/plat/regs-systimer.h b/arch/arm/plat-s5p/include/plat/regs-systimer.h
new file mode 100644
index 0000000..61f1282
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/regs-systimer.h
@@ -0,0 +1,75 @@
+/* linux/arch/arm/plat-s5p/include/plat/regs-systimer.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P System Timer Driver Header information
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_PLAT_REGS_SYSTIMER_H
+#define __ASM_PLAT_REGS_SYSTIMER_H __FILE__
+
+#define S5P_SYSTIMERREG(x)		(S5P_VA_SYSTIMER + (x))
+
+#define S5P_SYSTIMER_TCFG		S5P_SYSTIMERREG(0x00)
+#define S5P_SYSTIMER_TCON		S5P_SYSTIMERREG(0x04)
+#define S5P_SYSTIMER_TICNTB		S5P_SYSTIMERREG(0x08)
+#define S5P_SYSTIMER_TICNTO		S5P_SYSTIMERREG(0x0c)
+#define S5P_SYSTIMER_TFCNTB		S5P_SYSTIMERREG(0x10)
+#define S5P_SYSTIMER_ICNTB		S5P_SYSTIMERREG(0x18)
+#define S5P_SYSTIMER_ICNTO		S5P_SYSTIMERREG(0x1c)
+#define S5P_SYSTIMER_INT_CSTAT		S5P_SYSTIMERREG(0x20)
+
+/* Value for TCFG */
+
+#define S5P_SYSTIMER_SWRST		(1 << 16)
+
+#define S5P_SYSTIMER_DIV_GEN		(0 << 15)
+#define S5P_SYSTIMER_DIV_RTC		(1 << 15)
+
+#define S5P_SYSTIMER_TICK_INT		(0 << 14)
+#define S5P_SYSTIMER_TICK_FRA		(1 << 14)
+
+#define S5P_SYSTIMER_TCLK_MASK		(3 << 12)
+#define S5P_SYSTIMER_TCLK_XXTI		(0 << 12)
+#define S5P_SYSTIMER_TCLK_RTC		(1 << 12)
+#define S5P_SYSTIMER_TCLK_USB		(2 << 12)
+#define S5P_SYSTIMER_TCLK_PCLK		(3 << 12)
+
+#define S5P_SYSTIMER_DIV_MASK		(7 << 8)
+#define S5P_SYSTIMER_DIV_1		(0 << 8)
+#define S5P_SYSTIMER_DIV_2		(1 << 8)
+#define S5P_SYSTIMER_DIV_4		(2 << 8)
+#define S5P_SYSTIMER_DIV_8		(3 << 8)
+#define S5P_SYSTIMER_DIV_16		(4 << 8)
+
+#define S5P_SYSTIMER_TARGET_HZ		1000
+#define S5P_SYSTIMER_PRESCALER		5
+#define S5P_SYSTIMER_PRESCALER_MASK	(0x3f << 0)
+
+/* value for TCON */
+
+#define S5P_SYSTIMER_INT_AUTO		(1 << 5)
+#define S5P_SYSTIMER_INT_IMM		(1 << 4)
+#define S5P_SYSTIMER_INT_START		(1 << 3)
+#define S5P_SYSTIMER_START		(1 << 0)
+
+/* Value for INT_CSTAT */
+
+#define S5P_SYSTIMER_INT_TWIE		(1 << 10)
+#define S5P_SYSTIMER_INT_IWIE		(1 << 9)
+#define S5P_SYSTIMER_INT_TFWIE		(1 << 8)
+#define S5P_SYSTIMER_INT_TIWIE		(1 << 7)
+#define S5P_SYSTIMER_INT_ICNTEIE	(1 << 6)
+#define S5P_SYSTIMER_INT_TCON		(1 << 5)
+#define S5P_SYSTIMER_INT_ICNTB		(1 << 4)
+#define S5P_SYSTIMER_INT_TFCNTB		(1 << 3)
+#define S5P_SYSTIMER_INT_TICNTB		(1 << 2)
+#define S5P_SYSTIMER_INT_INTCNT		(1 << 1)
+#define S5P_SYSTIMER_INT_INTENABLE	(1 << 0)
+
+#endif /* __ASM_PLAT_REGS_SYSTIMER_H */
diff --git a/arch/arm/plat-s5p/s5p-systimer.c b/arch/arm/plat-s5p/s5p-systimer.c
new file mode 100644
index 0000000..f0e4ec8
--- /dev/null
+++ b/arch/arm/plat-s5p/s5p-systimer.c
@@ -0,0 +1,287 @@
+/* linux/arch/arm/plat-s5p/s5p-systimer.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P System Timer
+ *
+ * Based on linux/arch/arm/plat-samsung/time.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <asm/system.h>
+#include <asm/mach-types.h>
+
+#include <asm/irq.h>
+#include <asm/mach/time.h>
+
+#include <mach/map.h>
+#include <mach/regs-irq.h>
+#include <mach/tick.h>
+
+#include <plat/regs-systimer.h>
+#include <plat/clock.h>
+#include <plat/cpu.h>
+
+#include <mach/regs-clock.h>
+
+static unsigned long timer_startval;
+static unsigned long timer_usec_ticks;
+static unsigned long timer_icnt;
+
+#define TICK_MAX		(0xffffffff)
+#define TIMER_USEC_SHIFT	16
+
+static unsigned int systimer_write_done(unsigned int value)
+{
+	unsigned int cnt;
+	unsigned int tmp_reg;
+
+	cnt = 1000;
+
+	do {
+		if (__raw_readl(S5P_SYSTIMER_INT_CSTAT) & value) {
+			tmp_reg = __raw_readl(S5P_SYSTIMER_INT_CSTAT);
+			tmp_reg |= value;
+			__raw_writel(tmp_reg , S5P_SYSTIMER_INT_CSTAT);
+
+			return 0;
+		}
+	} while (--cnt > 0);
+
+	printk(KERN_ERR "%s : %d : Timer Expired\n", __func__, value);
+
+	return -ETIME;
+}
+
+static unsigned int s5p_systimer_write(void __iomem *reg,
+				       unsigned int value)
+{
+	unsigned int int_cstat;
+	unsigned int ret = 0;
+
+	__raw_writel(value, reg);
+
+	int_cstat = __raw_readl(S5P_SYSTIMER_INT_CSTAT);
+
+	if (reg == S5P_SYSTIMER_TCON) {
+		if (int_cstat & S5P_SYSTIMER_INT_TWIE)
+			ret = systimer_write_done(S5P_SYSTIMER_INT_TCON);
+
+	} else if (reg == S5P_SYSTIMER_ICNTB) {
+		if (int_cstat & S5P_SYSTIMER_INT_IWIE)
+			ret = systimer_write_done(S5P_SYSTIMER_INT_ICNTB);
+
+	} else if (reg == S5P_SYSTIMER_TFCNTB) {
+		if (int_cstat & S5P_SYSTIMER_INT_TFWIE)
+			ret = systimer_write_done(S5P_SYSTIMER_INT_TFCNTB);
+
+	} else if (reg == S5P_SYSTIMER_TICNTB) {
+		if (int_cstat & S5P_SYSTIMER_INT_TIWIE)
+			ret = systimer_write_done(S5P_SYSTIMER_INT_TICNTB);
+	}
+
+	return ret;
+}
+
+/*
+ * S5P has system timer to use as OS tick Timer.
+ * System Timer provides two distincive feature. Accurate timer which provides
+ * exact 1ms time tick at any power mode except sleep mode.
+ * interrupt interval without stopping reference tick timer.
+ */
+
+/*
+ * timer_mask_usec_ticks
+ *
+ * given a clock and divisor, make the value to pass into timer_ticks_to_usec
+ * to scale the ticks into usecs
+ */
+static inline unsigned long timer_mask_usec_ticks(unsigned long scaler,
+						  unsigned long pclk)
+{
+	unsigned long den = pclk / 1000;
+
+	return ((1000 << TIMER_USEC_SHIFT) * scaler + (den >> 1)) / den;
+}
+
+/*
+ * timer_ticks_to_usec
+ *
+ * convert timer ticks to usec.
+ */
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
+/*
+ * Returns microsecond  since last clock interrupt.  Note that interrupts
+ * will have been disabled by do_gettimeoffset()
+ * IRQs are disabled before entering here from do_gettimeofday()
+ */
+static unsigned long s5p_gettimeoffset(void)
+{
+	unsigned long tdone;
+	unsigned long tval;
+	unsigned long clk_tick_totcnt;
+
+	clk_tick_totcnt = (timer_icnt + 1) * timer_startval;
+
+	/* work out how many ticks have gone since last timer interrupt */
+	tval = __raw_readl(S5P_SYSTIMER_ICNTO) * timer_startval;
+	tval += __raw_readl(S5P_SYSTIMER_TICNTO);
+
+	tdone = clk_tick_totcnt - tval;
+
+	/* check to see if there is an interrupt pending */
+	if (s5p_ostimer_pending()) {
+		/* re-read the timer, and try and fix up for the missed
+		 * interrupt. Note, the interrupt may go off before the
+		 * timer has re-loaded from wrapping.
+		 */
+
+		tval = __raw_readl(S5P_SYSTIMER_ICNTO) * timer_startval;
+		tval += __raw_readl(S5P_SYSTIMER_TICNTO);
+
+		tdone = clk_tick_totcnt - tval;
+
+		if (tval != 0)
+			tdone += clk_tick_totcnt;
+	}
+
+	return timer_ticks_to_usec(tdone);
+}
+
+/*
+ * IRQ handler for the timer
+ */
+static irqreturn_t s5p_systimer_interrupt(int irq, void *dev_id)
+{
+	unsigned int temp_cstat;
+
+	temp_cstat = __raw_readl(S5P_SYSTIMER_INT_CSTAT);
+	temp_cstat |= S5P_SYSTIMER_INT_INTCNT;
+	s5p_systimer_write(S5P_SYSTIMER_INT_CSTAT, temp_cstat);
+
+	timer_tick();
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction s5p_systimer_irq = {
+	.name		= "S5P System Timer",
+	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
+	.handler	= s5p_systimer_interrupt,
+};
+
+/*
+ * Set up timer interrupt, and return the current time in seconds.
+ */
+static void s5p_systimer_setup(void)
+{
+	unsigned long tcon;
+	unsigned long tcnt;
+	unsigned long tcfg;
+	unsigned long int_csata;
+
+	/* clock configuration setting and enable */
+	unsigned long pclk;
+	struct clk *clk;
+
+	clk = clk_get(NULL, "systimer");
+	if (IS_ERR(clk))
+		panic("failed to get clock for system timer");
+
+	clk_enable(clk);
+
+	pclk = clk_get_rate(clk);
+
+	tcfg = __raw_readl(S5P_SYSTIMER_TCFG);
+	tcfg |= S5P_SYSTIMER_SWRST;
+	s5p_systimer_write(S5P_SYSTIMER_TCFG, tcfg);
+
+	tcnt = TICK_MAX;  /* default value for tcnt */
+
+	/* initialize system timer clock */
+	tcfg = __raw_readl(S5P_SYSTIMER_TCFG);
+
+	tcfg &= ~S5P_SYSTIMER_TCLK_MASK;
+	tcfg |= S5P_SYSTIMER_TCLK_PCLK;
+
+	s5p_systimer_write(S5P_SYSTIMER_TCFG, tcfg);
+
+	/* TCFG must not be changed at run-time.
+	 * If you want to change TCFG, stop timer(TCON[0] = 0)
+	 */
+
+	s5p_systimer_write(S5P_SYSTIMER_TCON, 0);
+
+	/* read the current timer configuration bits */
+	tcon = __raw_readl(S5P_SYSTIMER_TCON);
+	tcfg = __raw_readl(S5P_SYSTIMER_TCFG);
+
+	/* configure clock tick */
+	timer_usec_ticks = timer_mask_usec_ticks(S5P_SYSTIMER_PRESCALER, pclk);
+
+	tcfg &= ~S5P_SYSTIMER_TCLK_MASK;
+	tcfg |= S5P_SYSTIMER_TCLK_PCLK;
+	tcfg &= ~S5P_SYSTIMER_PRESCALER_MASK;
+	tcfg |= S5P_SYSTIMER_PRESCALER - 1;
+
+	tcnt = ((pclk / S5P_SYSTIMER_PRESCALER) / S5P_SYSTIMER_TARGET_HZ) - 1;
+
+	/* check to see if timer is within 16bit range... */
+	if (tcnt > TICK_MAX) {
+		panic("setup_timer: HZ is too small, cannot configure timer!");
+		return;
+	}
+
+	s5p_systimer_write(S5P_SYSTIMER_TCFG, tcfg);
+
+	timer_startval = tcnt;
+	s5p_systimer_write(S5P_SYSTIMER_TICNTB, tcnt);
+
+	/* set Interrupt tick value */
+	timer_icnt = (S5P_SYSTIMER_TARGET_HZ / HZ) - 1;
+	s5p_systimer_write(S5P_SYSTIMER_ICNTB, timer_icnt);
+
+	tcon = (S5P_SYSTIMER_INT_AUTO | S5P_SYSTIMER_START
+		| S5P_SYSTIMER_INT_START);
+	s5p_systimer_write(S5P_SYSTIMER_TCON, tcon);
+
+	/* Interrupt Start and Enable */
+	int_csata = __raw_readl(S5P_SYSTIMER_INT_CSTAT);
+	int_csata |= (S5P_SYSTIMER_INT_ICNTEIE | S5P_SYSTIMER_INT_INTENABLE);
+	s5p_systimer_write(S5P_SYSTIMER_INT_CSTAT, int_csata);
+}
+
+static void __init s5p_systimer_init(void)
+{
+	s5p_systimer_setup();
+	setup_irq(IRQ_SYSTIMER, &s5p_systimer_irq);
+}
+
+struct sys_timer s5p_systimer = {
+	.init		= s5p_systimer_init,
+	.offset		= s5p_gettimeoffset,
+	.resume		= s5p_systimer_setup
+};
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index c54f318..d1ec201 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -68,6 +68,9 @@ extern void s3c24xx_init_uartdevs(char *name,
 struct sys_timer;
 extern struct sys_timer s3c24xx_timer;
 
+/* timer for s5p */
+extern struct sys_timer s5p_systimer;
+
 /* system device classes */
 
 extern struct sysdev_class s3c2410_sysclass;
-- 
1.6.2.5
