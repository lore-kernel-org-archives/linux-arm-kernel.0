From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Tue, 29 Mar 2011 12:30:49 +0200
Subject: [PATCH v4 03/10] lpc2k: clk API
In-Reply-To: <1301394656-24853-1-git-send-email-ithamar.adema@team-embedded.nl>
References: <1301394656-24853-1-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <1301394656-24853-4-git-send-email-ithamar.adema@team-embedded.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implements clock API using the CLKDEV_LOOKUP common code.

Signed-off-by: Ithamar R. Adema <ithamar.adema@team-embedded.nl>
---
changes since v3:
	* removed 'rate' field from struct clk, and implemented
	  get_rate hook for the 3 fixed rate clocks.
	* removed generation of get_rate function per peripheral
	  clock, and introduced clk_id field in struct clk used
	  by the new single per_get_rate function.

no changes since v2.

changes since v1:
        * changed mutex into spinlock
        * simplified clk_readl/clk_writel macros
---
 arch/arm/Kconfig                          |    1 +
 arch/arm/mach-lpc2k/Makefile              |    2 +-
 arch/arm/mach-lpc2k/clock.c               |  388 +++++++++++++++++++++++++++++
 arch/arm/mach-lpc2k/include/mach/clkdev.h |   17 ++
 4 files changed, 407 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-lpc2k/clock.c
 create mode 100644 arch/arm/mach-lpc2k/include/mach/clkdev.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c96908e..4a399e0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -499,6 +499,7 @@ config ARCH_LPC2K
 	depends on !MMU
 	select CPU_ARM7TDMI
 	select ARM_VIC
+	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	help
 	  Support for NXP LPC2K family of SoCs. These SoCs are based on
diff --git a/arch/arm/mach-lpc2k/Makefile b/arch/arm/mach-lpc2k/Makefile
index 546666b..9eb0a6a 100644
--- a/arch/arm/mach-lpc2k/Makefile
+++ b/arch/arm/mach-lpc2k/Makefile
@@ -1 +1 @@
-obj-y	:= irq.o
+obj-y	:= clock.o irq.o
diff --git a/arch/arm/mach-lpc2k/clock.c b/arch/arm/mach-lpc2k/clock.c
new file mode 100644
index 0000000..8c3207a
--- /dev/null
+++ b/arch/arm/mach-lpc2k/clock.c
@@ -0,0 +1,388 @@
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
+#include <mach/regs-scb.h>
+
+#define clk_readl(a)	\
+	ioread32(APB_SCB_BASE + (a))
+#define clk_writel(v, a)	\
+	iowrite32(v, APB_SCB_BASE + (a))
+
+struct clk {
+	int		refcount;
+	struct clk	*parent;
+
+	u32		enable_mask;
+	u32		clk_id;
+
+	long		(*round_rate)(struct clk *clk, unsigned long rate);
+	int		(*set_rate)(struct clk *clk, unsigned long rate);
+	unsigned long	(*get_rate)(struct clk *clk);
+	int		(*set_parent)(struct clk *clk, struct clk *parent);
+};
+
+static DEFINE_SPINLOCK(clk_lock);
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
+	unsigned long flags;
+	int ret = 0;
+
+	if (!clk)
+		return -EINVAL;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	ret = __clk_enable(clk);
+	spin_unlock_irqrestore(&clk_lock, flags);
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
+	unsigned long flags;
+
+	if (!clk)
+		return;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	__clk_disable(clk);
+	spin_unlock_irqrestore(&clk_lock, flags);
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
+	return 0;
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
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	if (!clk)
+		return ret;
+	if (!clk->set_rate || !rate)
+		return ret;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	ret = clk->set_rate(clk, rate);
+	spin_unlock_irqrestore(&clk_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(clk_set_rate);
+
+/* Set the clock's parent to another clock source */
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	unsigned long flags;
+	struct clk *old;
+	int ret = -EINVAL;
+
+	if (!clk)
+		return ret;
+	if (!clk->set_parent || !parent)
+		return ret;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	old = clk->parent;
+	if (clk->refcount)
+		__clk_enable(parent);
+	ret = clk->set_parent(clk, parent);
+	if (ret)
+		old = parent;
+	if (clk->refcount)
+		__clk_disable(old);
+	spin_unlock_irqrestore(&clk_lock, flags);
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
+unsigned long irc_get_rate(struct clk *clk)
+{
+	return 4000000;
+}
+
+static struct clk clk_irc = {
+	.get_rate = irc_get_rate,
+};
+
+static unsigned long xtal_rate; /* set on init */
+
+static unsigned long xtal_get_rate(struct clk *clk)
+{
+	return xtal_rate;
+}
+
+static struct clk clk_xtal = {
+	.get_rate = xtal_get_rate,
+};
+
+
+static unsigned xrtc_rate; /* set on init */
+
+static unsigned long xrtc_get_rate(struct clk *clk)
+{
+	return xrtc_rate;
+}
+
+static struct clk clk_xrtc = {
+	.get_rate = xrtc_get_rate,
+};
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
+static unsigned long per_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	u32 val = clk_readl((clk->clk_id < 16) ? PCLKSEL0 : PCLKSEL1);
+	val >>= (clk->clk_id < 16) ? clk->clk_id * 2 : (clk->clk_id - 16) * 2;
+	return rate / pclkdiv[val & 3];
+}
+
+#define PERCLK(name, pnum)	\
+	struct clk clk_ ## name = {	\
+		.parent = &clk_cpu,	\
+		.enable_mask = (1 << pnum),	\
+		.clk_id = pnum,			\
+		.get_rate = per_get_rate,	\
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
+	xtal_rate = xtal;
+	xrtc_rate = rtc;
+
+	clk_pll.parent = pll_src_clk[CLKSRC(clk_readl(CLKSRCSEL))];
+
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
-- 
1.7.1
