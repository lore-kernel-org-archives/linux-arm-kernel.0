From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Thu, 17 Mar 2011 16:54:18 +0100
Subject: [PATCH 3/9] lpc2k: clk API
In-Reply-To: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <1300377264-10843-4-git-send-email-ithamar.adema@team-embedded.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implements clock API using the CLKDEV_LOOKUP common code.

Signed-off-by: Ithamar R. Adema <ithamar.adema@team-embedded.nl>
---
 arch/arm/Kconfig                              |    1 +
 arch/arm/mach-lpc2k/Makefile                  |    2 +-
 arch/arm/mach-lpc2k/clock.c                   |  355 +++++++++++++++++++++++++
 arch/arm/mach-lpc2k/include/mach/clkdev.h     |   17 ++
 arch/arm/mach-lpc2k/include/mach/hardware.h   |    1 +
 arch/arm/mach-lpc2k/include/mach/regs-clock.h |   36 +++
 6 files changed, 411 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-lpc2k/clock.c
 create mode 100644 arch/arm/mach-lpc2k/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-lpc2k/include/mach/regs-clock.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9c12d71..35297f9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -496,6 +496,7 @@ config ARCH_LPC2K
 	depends on !MMU
 	select CPU_ARM7TDMI
 	select ARM_VIC
+	select CLKDEV_LOOKUP
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	help
diff --git a/arch/arm/mach-lpc2k/Makefile b/arch/arm/mach-lpc2k/Makefile
index 546666b..9eb0a6a 100644
--- a/arch/arm/mach-lpc2k/Makefile
+++ b/arch/arm/mach-lpc2k/Makefile
@@ -1 +1 @@
-obj-y	:= irq.o
+obj-y	:= clock.o irq.o
diff --git a/arch/arm/mach-lpc2k/clock.c b/arch/arm/mach-lpc2k/clock.c
new file mode 100644
index 0000000..3ef4521
--- /dev/null
+++ b/arch/arm/mach-lpc2k/clock.c
@@ -0,0 +1,355 @@
+/*
+ * Copyright 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include <linux/clkdev.h>
+
+#include <mach/hardware.h>
+#include <mach/regs-clock.h>
+
+#define clk_readl(a)	\
+	__raw_readl((void __iomem *)APB_SCB_BASE + (a))
+#define clk_writel(v, a)	\
+	__raw_writel(v, (void __iomem *)APB_SCB_BASE + (a))
+
+struct clk {
+	int		refcount;
+	struct clk	*parent;
+	unsigned long	rate;
+
+	u32		enable_mask;
+
+	long		(*round_rate)(struct clk *clk, unsigned long rate);
+	int		(*set_rate)(struct clk *clk, unsigned long rate);
+	unsigned long	(*get_rate)(struct clk *clk);
+	int		(*set_parent)(struct clk *clk, struct clk *parent);
+};
+
+static DEFINE_MUTEX(clocks_mutex);
+
+/*-------------------------------------------------------------------------
+ * Standard clock functions defined in include/linux/clk.h
+ *-------------------------------------------------------------------------*/
+
+static void __clk_disable(struct clk *clk)
+{
+	BUG_ON(clk->refcount == 0);
+
+	if (!(--clk->refcount)) {
+		if (clk->parent)
+			__clk_disable(clk->parent);
+
+		if (clk->enable_mask) {
+			/* Unconditionally disable the clock in hardware */
+			u32 value = clk_readl(PCONP);
+			clk_writel(value & ~clk->enable_mask, PCONP);
+		}
+	}
+}
+
+static int __clk_enable(struct clk *clk)
+{
+	int ret = 0;
+
+	if (clk->refcount++ == 0) {
+		if (clk->parent)
+			ret = __clk_enable(clk->parent);
+		if (ret)
+			return ret;
+		else if (clk->enable_mask) {
+			u32 value = clk_readl(PCONP);
+			clk_writel(value | clk->enable_mask, PCONP);
+		}
+	}
+
+	return 0;
+}
+
+/* This function increments the reference count on the clock and enables the
+ * clock if not already enabled. The parent clock tree is recursively enabled
+ */
+int clk_enable(struct clk *clk)
+{
+	int ret = 0;
+
+	if (!clk)
+		return -EINVAL;
+
+	mutex_lock(&clocks_mutex);
+	ret = __clk_enable(clk);
+	mutex_unlock(&clocks_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_enable);
+
+/* This function decrements the reference count on the clock and disables
+ * the clock when reference count is 0. The parent clock tree is
+ * recursively disabled
+ */
+void clk_disable(struct clk *clk)
+{
+	if (!clk)
+		return;
+
+	mutex_lock(&clocks_mutex);
+	__clk_disable(clk);
+	mutex_unlock(&clocks_mutex);
+}
+EXPORT_SYMBOL_GPL(clk_disable);
+
+/* Retrieve the *current* clock rate. If the clock itself
+ * does not provide a special calculation routine, ask
+ * its parent and so on, until one is able to return
+ * a valid clock rate
+ */
+unsigned long clk_get_rate(struct clk *clk)
+{
+	if (!clk)
+		return 0UL;
+
+	if (clk->get_rate)
+		return clk->get_rate(clk);
+
+	if (clk->parent)
+		return clk_get_rate(clk->parent);
+
+	return clk->rate;
+}
+EXPORT_SYMBOL_GPL(clk_get_rate);
+
+/* Round the requested clock rate to the nearest supported
+ * rate that is less than or equal to the requested rate.
+ * This is dependent on the clock's current parent.
+ */
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	if (!clk)
+		return 0;
+	if (!clk->round_rate)
+		return 0;
+
+	return clk->round_rate(clk, rate);
+}
+EXPORT_SYMBOL_GPL(clk_round_rate);
+
+/* Set the clock to the requested clock rate. The rate must
+ * match a supported rate exactly based on what clk_round_rate returns
+ */
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	int ret = -EINVAL;
+
+	if (!clk)
+		return ret;
+	if (!clk->set_rate || !rate)
+		return ret;
+
+	mutex_lock(&clocks_mutex);
+	ret = clk->set_rate(clk, rate);
+	mutex_unlock(&clocks_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_set_rate);
+
+/* Set the clock's parent to another clock source */
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk *old;
+	int ret = -EINVAL;
+
+	if (!clk)
+		return ret;
+	if (!clk->set_parent || !parent)
+		return ret;
+
+	mutex_lock(&clocks_mutex);
+	old = clk->parent;
+	if (clk->refcount)
+		__clk_enable(parent);
+	ret = clk->set_parent(clk, parent);
+	if (ret)
+		old = parent;
+	if (clk->refcount)
+		__clk_disable(old);
+	mutex_unlock(&clocks_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_set_parent);
+
+/* Retrieve the clock's parent clock source */
+struct clk *clk_get_parent(struct clk *clk)
+{
+	if (!clk)
+		return NULL;
+
+	return clk->parent;
+}
+EXPORT_SYMBOL_GPL(clk_get_parent);
+
+static struct clk clk_irc = {
+	.rate = 4000000
+};
+
+static struct clk clk_xtal;
+static struct clk clk_xrtc;
+
+static unsigned long pll_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	u32 pll_stat = clk_readl(PLLSTAT);
+
+	if (pll_stat & PLLE && pll_stat & PLLC)
+		rate = (2 * M(pll_stat) * rate) / N(pll_stat);
+
+	return rate;
+}
+
+static struct clk clk_pll = {
+	.parent = NULL,
+	.get_rate = pll_get_rate,
+};
+
+static unsigned long cpu_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	return rate / (CCLKSEL(clk_readl(CCLKCFG)) + 1);
+}
+
+static struct clk clk_cpu = {
+	.parent = &clk_pll,
+	.get_rate = cpu_get_rate,
+};
+
+static unsigned long usb_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	return rate / (USBSEL(clk_readl(USBCLKCFG)) + 1);
+}
+
+static struct clk clk_usb = {
+	.enable_mask = (1 << 31),
+	.parent = &clk_pll,
+	.get_rate = usb_get_rate,
+};
+
+static struct clk clk_apbpclk;
+
+static unsigned long pclkdiv[] = { 4, 1, 2, 8 };
+
+#define PERCLK(name, pnum)	\
+	static unsigned long name ## _get_rate(struct clk *clk) \
+	{	\
+		unsigned long rate = clk_get_rate(clk->parent);	\
+		u32 val = clk_readl((pnum < 16) ? PCLKSEL0 : PCLKSEL1); \
+		val >>= (pnum < 16) ? pnum * 2 : (pnum - 16) * 2;	\
+		return rate / pclkdiv[val & 3];	\
+	}	\
+	struct clk clk_ ## name = {	\
+		.parent = &clk_cpu,	\
+		.enable_mask = (1 << pnum),	\
+		.get_rate = name ## _get_rate,	\
+	}
+
+PERCLK(timer0, 1);
+PERCLK(timer1, 2);
+PERCLK(uart0, 3);
+PERCLK(uart1, 4);
+PERCLK(pwm0, 5);
+PERCLK(pwm1, 6);
+PERCLK(i2c0, 7);
+PERCLK(spi, 8);
+PERCLK(prtc, 9);
+PERCLK(ssp1, 10);
+PERCLK(emc, 11);
+PERCLK(adc, 12);
+PERCLK(can1, 13);
+PERCLK(can2, 14);
+PERCLK(i2c1, 19);
+PERCLK(lcd, 20);
+PERCLK(ssp0, 21);
+PERCLK(timer2, 22);
+PERCLK(timer3, 23);
+PERCLK(uart2, 24);
+PERCLK(uart3, 25);
+PERCLK(i2c2, 26);
+PERCLK(i2s, 27);
+PERCLK(mci, 28);
+PERCLK(dma, 29);
+PERCLK(eth, 30);
+
+#define INIT_CK(dev, con, ck)	\
+	{ .dev_id = dev, .con_id = con, .clk = ck }
+
+
+/* clk_rtc is a virtual clock used as glue to adjust at runtime
+ * if we're using the normal peripheral clock or an extern osc.
+ */
+static struct clk clk_rtc;
+
+static struct clk_lookup clocks[] = {
+	INIT_CK(NULL, "apb_pclk", &clk_apbpclk),
+	INIT_CK(NULL, "irc", &clk_irc),
+	INIT_CK(NULL, "xtal", &clk_xtal),
+	INIT_CK(NULL, "pll", &clk_pll),
+	INIT_CK(NULL, "cpu", &clk_cpu),
+	INIT_CK(NULL, "usb", &clk_usb),
+	INIT_CK(NULL, "timer0", &clk_timer0),
+	INIT_CK(NULL, "timer1", &clk_timer1),
+	INIT_CK(NULL, "timer2", &clk_timer2),
+	INIT_CK(NULL, "timer3", &clk_timer3),
+	INIT_CK("lpc2k-pwm.0", NULL, &clk_pwm0),
+	INIT_CK("lpc2k-pwm.1", NULL, &clk_pwm1),
+	INIT_CK("lpc2k-adc", NULL, &clk_adc),
+	INIT_CK("lpc2k-i2c.0", NULL, &clk_i2c0),
+	INIT_CK("lpc2k-i2c.1", NULL, &clk_i2c1),
+	INIT_CK("lpc2k-i2c.2", NULL, &clk_i2c2),
+	INIT_CK("serial8250.0", NULL, &clk_uart0),
+	INIT_CK("serial8250.1", NULL, &clk_uart1),
+	INIT_CK("serial8250.2", NULL, &clk_uart2),
+	INIT_CK("serial8250.3", NULL, &clk_uart3),
+	INIT_CK("lpc2k-ohci", NULL, &clk_usb),
+	INIT_CK("lpc2k-spi.0", NULL, &clk_ssp0),
+	INIT_CK("lpc2k-spi.1", NULL, &clk_ssp1),
+	INIT_CK("lpc2k-eth", NULL, &clk_eth),
+	INIT_CK("lpc2k-rtc", NULL, &clk_rtc),
+	INIT_CK("ssp0", NULL, &clk_ssp0),
+	INIT_CK("ssp1", NULL, &clk_ssp1),
+	INIT_CK("mci", NULL, &clk_mci),
+	INIT_CK("lcd", NULL, &clk_lcd),
+	INIT_CK("dma", NULL, &clk_dma),
+};
+
+void __init lpc2k_init_clocks(unsigned long xtal, unsigned long rtc)
+{
+	struct clk *pll_src_clk[] = { &clk_irc, &clk_xtal, &clk_xrtc };
+	int i;
+
+	clk_xtal.rate = xtal;
+
+	clk_pll.parent = pll_src_clk[CLKSRC(clk_readl(CLKSRCSEL))];
+	clk_xrtc.rate = rtc;
+	/* If no external RTC osc. is specified, make RTC clock child
+	   of peripheral RTC (CPU) clock */
+	clk_rtc.parent = rtc ? &clk_xrtc : &clk_prtc;
+
+	for (i = 0; i < ARRAY_SIZE(clocks); i++) {
+		pr_debug("clock '%s', rate %luHz\n",
+			clocks[i].con_id ? clocks[i].con_id : clocks[i].dev_id,
+			clk_get_rate(clocks[i].clk));
+
+		clkdev_add(&clocks[i]);
+	}
+}
diff --git a/arch/arm/mach-lpc2k/include/mach/clkdev.h b/arch/arm/mach-lpc2k/include/mach/clkdev.h
new file mode 100644
index 0000000..92267cc
--- /dev/null
+++ b/arch/arm/mach-lpc2k/include/mach/clkdev.h
@@ -0,0 +1,17 @@
+/*
+ *  Copyright (C) 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef MACH_LPC2K_CLKDEV_H
+#define MACH_LPC2K_CLKDEV_H
+
+#define __clk_get(clk) ({ 1; })
+#define __clk_put(clk) do { } while (0)
+
+#endif /* MACH_LPC2K_CLKDEV_H */
diff --git a/arch/arm/mach-lpc2k/include/mach/hardware.h b/arch/arm/mach-lpc2k/include/mach/hardware.h
index 7663e97..ce19ff7 100644
--- a/arch/arm/mach-lpc2k/include/mach/hardware.h
+++ b/arch/arm/mach-lpc2k/include/mach/hardware.h
@@ -18,6 +18,7 @@
 #define APB_TIMER0_BASE		0xe0004000
 #define APB_TIMER1_BASE		0xe0008000
 #define APB_UART0_BASE		0xe000c000
+#define APB_SCB_BASE		0xe01fc000
 #define APH_VIC_BASE		0xfffff000
 
 #endif /* MACH_LPC2K_HARDWARE_H */
diff --git a/arch/arm/mach-lpc2k/include/mach/regs-clock.h b/arch/arm/mach-lpc2k/include/mach/regs-clock.h
new file mode 100644
index 0000000..1c94582
--- /dev/null
+++ b/arch/arm/mach-lpc2k/include/mach/regs-clock.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright 2011 Team Embedded VOF
+ *     Ithamar R. Adema <ihamar.adema@team-embedded.nl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef MACH_LPC2K_REGS_CLOCK_H
+#define MACH_LPC2K_REGS_CLOCK_H
+
+#define CLKSRCSEL	0x10c
+#define CLKSRC(x)	((x) & 3)
+#define PLLCON		0x080
+#define PLLCFG		0x084
+#define PLLSTAT		0x088
+#define M(x)		(((x) & 0x7fff) + 1)
+#define N(x)		((((x) >> 16) & 0xf) + 1)
+#define PLLE		(1 << 24)
+#define PLLC		(1 << 25)
+#define PLLFEED		0x08c
+
+#define CCLKCFG		0x104
+#define CCLKSEL(x)	((x) & 0xff)
+#define USBCLKCFG	0x108
+#define USBSEL(x)	((x) & 0xf)
+#define IRCTRIM		0x1a4
+#define PCLKSEL0	0x1a8
+#define PCLKSEL1	0x1ac
+
+#define PCON		0x0c0
+#define INTWAKE		0x144
+#define PCONP		0x0c4
+
+#endif /* MACH_LPC2K_REGS_CLOCK_H */
-- 
1.7.1
