From: konkers@google.com (konkers at google.com)
Date: Mon, 15 Mar 2010 23:41:21 -0700
Subject: [RFC/PATCH 03/10] [ARM] tegra: Add clock support
In-Reply-To: <1268721688-27550-3-git-send-email-konkers@google.com>
References: <4344f3c71003151538r7dc30e01uc9885ca5d3f327cd@mail.gmail.com>
	<1268721688-27550-1-git-send-email-konkers@google.com>
	<1268721688-27550-2-git-send-email-konkers@google.com>
	<1268721688-27550-3-git-send-email-konkers@google.com>
Message-ID: <1268721688-27550-4-git-send-email-konkers@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: Erik Gilling <konkers@android.com>
---
 arch/arm/Kconfig                          |    1 +
 arch/arm/mach-tegra/Makefile              |    2 +
 arch/arm/mach-tegra/clock.c               |  191 +++++++
 arch/arm/mach-tegra/clock.h               |  103 ++++
 arch/arm/mach-tegra/common.c              |    1 +
 arch/arm/mach-tegra/include/mach/clkdev.h |   32 ++
 arch/arm/mach-tegra/tegra2_clocks.c       |  837 +++++++++++++++++++++++++++++
 7 files changed, 1167 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/clock.c
 create mode 100644 arch/arm/mach-tegra/clock.h
 create mode 100644 arch/arm/mach-tegra/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-tegra/tegra2_clocks.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1232104..a5be2d6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -576,6 +576,7 @@ config ARCH_TEGRA
         select GENERIC_CLOCKEVENTS
         select GENERIC_GPIO
         select HAVE_CLK
+        select COMMON_CLKDEV
 	select ARCH_HAS_BARRIERS if CACHE_L2X0
         help
           This enables support for NVIDIA Tegra based systems (Tegra APX,
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index a0d2c5b..e20546a 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -1,3 +1,5 @@
 obj-y                                   += common.o
 obj-y                                   += io.o
 obj-y                                   += irq.o
+obj-y                                   += clock.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
new file mode 100644
index 0000000..86c1965
--- /dev/null
+++ b/arch/arm/mach-tegra/clock.c
@@ -0,0 +1,191 @@
+/*
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/list.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <asm/clkdev.h>
+
+#include "clock.h"
+
+static LIST_HEAD(clocks);
+static DEFINE_MUTEX(clocks_mutex);
+
+/**
+ * clk_preinit - initialize any fields in the struct clk before clk init
+ * @clk: struct clk * to initialize
+ *
+ * Initialize any struct clk fields needed before normal clk initialization
+ * can run.  No return value.
+ */
+void clk_preinit(struct clk *c)
+{
+	c->lock = __SPIN_LOCK_UNLOCKED(c->lock);
+}
+
+int clk_register(struct clk *c)
+{
+	mutex_lock(&clocks_mutex);
+	list_add(&c->node, &clocks);
+	mutex_unlock(&clocks_mutex);
+	return 0;
+}
+
+int clk_enable(struct clk *c)
+{
+	int ret = 0;
+	unsigned long flags;
+	spin_lock_irqsave(&c->lock, flags);
+	if (c->refcnt == 0) {
+		if (c->parent) {
+			ret = clk_enable(c->parent);
+			if (ret)
+				goto err;
+		}
+
+		if (c->ops && c->ops->enable) {
+			ret = c->ops->enable(c);
+			if (ret) {
+				if (c->parent)
+					clk_disable(c->parent);
+				goto err;
+			}
+		}
+	}
+	c->refcnt++;
+err:
+	spin_unlock_irqrestore(&c->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *c)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&c->lock, flags);
+	if (c->refcnt == 0) {
+		WARN(1, "Attempting to disable clock %s with refcnt 0", c->name);
+		goto err;
+	}
+	if (c->refcnt == 1) {
+		if (c->parent)
+			clk_disable(c->parent);
+
+		if (c->ops && c->ops->disable)
+			c->ops->disable(c);
+	}
+	c->refcnt--;
+err:
+	spin_unlock_irqrestore(&c->lock, flags);
+}
+EXPORT_SYMBOL(clk_disable);
+
+int clk_set_parent(struct clk *c, struct clk *parent)
+{
+	unsigned long flags;
+	int ret = 0;
+	spin_lock_irqsave(&c->lock, flags);
+	if (c->ops && c->ops->set_parent)
+		ret = c->ops->set_parent(c, parent);
+	else
+		BUG();
+	spin_unlock_irqrestore(&c->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
+struct clk *clk_get_parent(struct clk *c)
+{
+	return c->parent;
+}
+EXPORT_SYMBOL(clk_get_parent);
+
+int clk_set_rate(struct clk *c, unsigned long rate)
+{
+	int ret = 0;
+	unsigned long flags;
+	spin_lock_irqsave(&c->lock, flags);
+	if (c->ops && c->ops->set_rate)
+		ret = c->ops->set_rate(c, rate);
+	else
+		BUG();
+	spin_unlock_irqrestore(&c->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+unsigned long clk_get_rate(struct clk *c)
+{
+	int ret = 0;
+	unsigned long flags;
+	spin_lock_irqsave(&c->lock, flags);
+	if (c->ops && c->ops->get_rate)
+		ret = c->ops->get_rate(c);
+	else if (c->parent)
+		ret = clk_get_rate(c->parent);
+	else
+		BUG();
+	spin_unlock_irqrestore(&c->lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+void clk_enable_init_clocks(void)
+{
+	struct clk *clkp;
+
+	list_for_each_entry(clkp, &clocks, node) {
+		if (clkp->flags & ENABLE_ON_INIT)
+			clk_enable(clkp);
+	}
+}
+EXPORT_SYMBOL(clk_enable_init_clocks);
+
+int __init tegra_init_clock(void)
+{
+	int i;
+	struct clk_lookup *cl;
+	struct clk *c;
+
+	for (cl = tegra_clk_lookups; cl->clk != NULL; cl++) {
+		clk_preinit(cl->clk);
+		if (cl->clk->ops && cl->clk->ops->init)
+			cl->clk->ops->init(cl->clk);
+		clkdev_add(cl);
+		clk_register(cl->clk);
+	}
+
+	for (i = 0; i < tegra_num_periph_clks; i++) {
+		c = &tegra_periph_clks[i];
+		cl = &tegra_periph_clk_lookups[i];
+		cl->dev_id = c->dev_id;
+		cl->con_id = c->con_id;
+		cl->clk = c;
+
+		clk_preinit(cl->clk);
+		if (cl->clk->ops && cl->clk->ops->init)
+			cl->clk->ops->init(cl->clk);
+		clkdev_add(cl);
+		clk_register(cl->clk);
+	}
+
+	clk_enable_init_clocks();
+	return 0;
+}
diff --git a/arch/arm/mach-tegra/clock.h b/arch/arm/mach-tegra/clock.h
new file mode 100644
index 0000000..100ade6
--- /dev/null
+++ b/arch/arm/mach-tegra/clock.h
@@ -0,0 +1,103 @@
+/*
+ * arch/arm/mach-tegra/include/mach/clock.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_CLOCK_H
+#define __MACH_TEGRA_CLOCK_H
+
+#include <asm/clkdev.h>
+
+#define ENABLE_ON_INIT	0x00000001
+#define DIV_U71		0x00000002
+#define DIV_U71_FIXED	0x00000004
+#define DIV_2		0x00000008
+#define PLL_FIXED	0x00000010
+#define PLL_HAS_CPCON	0x00000020
+#define MUX		0x00000040
+
+struct clk;
+
+struct clk_mux_sel {
+	struct clk	*input;
+	u32		value;
+};
+
+struct clk_pll_table {
+	unsigned long	input_rate;
+	unsigned long	output_rate;
+	u16		n;
+	u16		m;
+	u8		p;
+	u8		cpcon;
+};
+
+struct clk_ops {
+	void		(*init)(struct clk *);
+	int		(*enable)(struct clk *);
+	void		(*disable)(struct clk *);
+	void		(*recalc)(struct clk *);
+	int		(*set_parent)(struct clk *, struct clk *);
+	int		(*set_rate)(struct clk *, unsigned long);
+	unsigned long	(*get_rate)(struct clk *);
+	long		(*round_rate)(struct clk *, unsigned long);
+};
+
+struct clk {
+	struct list_head		node;
+	struct clk_ops			*ops;
+	struct clk			*parent;
+	unsigned long			rate;
+	u32				flags;
+	u32				refcnt;
+	const char			*name;
+	const char			*dev_id;
+	const char			*con_id;
+	u32				reg;
+	u32				reg_shift;
+	unsigned int			clk_num;
+	spinlock_t			lock;
+
+	/* PLL */
+	unsigned long			input_min;
+	unsigned long			input_max;
+	unsigned long			cf_min;
+	unsigned long			cf_max;
+	unsigned long			vco_min;
+	unsigned long			vco_max;
+	u32				m;
+	u32				n;
+	u32				p;
+	u32				cpcon;
+	const struct clk_pll_table	*pll_table;
+
+	/* DIV */
+
+	/* MUX */
+	const struct clk_mux_sel	*inputs;
+	u32				sel;
+	u32				reg_mask;
+};
+
+extern struct clk_lookup tegra_clk_lookups[];
+extern struct clk tegra_periph_clks[];
+extern struct clk_lookup tegra_periph_clk_lookups[];
+extern const int tegra_num_periph_clks;
+
+unsigned long clk_measure_input_freq(void);
+
+#endif
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 20875ee..838bb5d 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -40,5 +40,6 @@ void __init tegra_init_cache(void)
 
 void __init tegra_common_init(void)
 {
+	tegra_init_clock();
 	tegra_init_cache();
 }
diff --git a/arch/arm/mach-tegra/include/mach/clkdev.h b/arch/arm/mach-tegra/include/mach/clkdev.h
new file mode 100644
index 0000000..412f5c6
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/clkdev.h
@@ -0,0 +1,32 @@
+/*
+ * arch/arm/mach-tegra/include/mach/clkdev.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_CLKDEV_H
+#define __MACH_CLKDEV_H
+
+static inline int __clk_get(struct clk *clk)
+{
+	return 1;
+}
+
+static inline void __clk_put(struct clk *clk)
+{
+}
+
+#endif
diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
new file mode 100644
index 0000000..83cbd5d
--- /dev/null
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -0,0 +1,837 @@
+/*
+ * arch/arm/mach-tegra/tegra2_clocks.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+
+#include <asm/io.h>
+#include <asm/clkdev.h>
+
+#include <mach/io.h>
+#include <mach/iomap.h>
+
+#include "clock.h"
+
+#define RST_DEVICES			0x004
+#define RST_DEVICES_SET			0x300
+#define RST_DEVICES_CLR			0x304
+
+
+#define CLK_OUT_ENB			0x010
+#define CLK_OUT_ENB_SET			0x320
+#define CLK_OUT_ENB_CLR			0x324
+
+#define OSC_CTRL			0x50
+#define OSC_CTRL_OSC_FREQ_MASK		(3<<30)
+#define OSC_CTRL_OSC_FREQ_13MHZ		(0<<30)
+#define OSC_CTRL_OSC_FREQ_19_2MHZ	(1<<30)
+#define OSC_CTRL_OSC_FREQ_12MHZ		(2<<30)
+#define OSC_CTRL_OSC_FREQ_26MHZ		(3<<30)
+
+#define OSC_FREQ_DET			0x58
+#define OSC_FREQ_DET_TRIG		(1<<31)
+
+#define OSC_FREQ_DET_STATUS		0x5C
+#define OSC_FREQ_DET_BUSY		(1<<31)
+#define OSC_FREQ_DET_CNT_MASK		0xFFFF
+
+#define PERIPH_CLK_SOURCE_MASK		(3<<30)
+#define PERIPH_CLK_SOURCE_SHIFT		30
+#define PERIPH_CLK_SOURCE_ENABLE	(1<<28)
+#define PERIPH_CLK_SOURCE_DIV_MASK	0xFF
+#define PERIPH_CLK_SOURCE_DIV_SHIFT	0
+
+#define PLL_BASE			0x0
+#define PLL_BASE_BYPASS			(1<<31)
+#define PLL_BASE_ENABLE			(1<<30)
+#define PLL_BASE_REF_ENABLE		(1<<29)
+#define PLL_BASE_OVERRIDE		(1<<28)
+#define PLL_BASE_LOCK			(1<<27)
+#define PLL_BASE_DIVP_MASK		(0x7<<20)
+#define PLL_BASE_DIVP_SHIFT		20
+#define PLL_BASE_DIVN_MASK		(0x3FF<<8)
+#define PLL_BASE_DIVN_SHIFT		8
+#define PLL_BASE_DIVM_MASK		(0x1F)
+#define PLL_BASE_DIVM_SHIFT		0
+
+#define PLL_OUT_RATIO_MASK		(0xFF<<8)
+#define PLL_OUT_RATIO_SHIFT		8
+#define PLL_OUT_OVERRIDE		(1<<2)
+#define PLL_OUT_CLKEN			(1<<1)
+#define PLL_OUT_RESET_DISABLE		(1<<0)
+
+#define PLL_MISC			0xc
+#define PLL_MISC_DCCON			(1<<20)
+#define PLL_MISC_LOCK_ENABLE		(1<<18)
+#define PLL_MISC_CPCON_SHIFT		8
+#define PLL_MISC_LFCON_SHIFT		4
+#define PLL_MISC_VCOCON_SHIFT		0
+
+static void __iomem *reg_clk_base = IO_ADDRESS(TEGRA_CLK_RESET_BASE);
+
+/* Lock clk_reg_lock around any non-atomic access to a register
+   that is shared by multiple clocks. */
+static DEFINE_SPINLOCK(clk_reg_lock);
+
+#define clk_writel(value, reg) \
+	__raw_writel(value, (u32)reg_clk_base + (reg))
+#define clk_readl(reg) \
+	__raw_readl((u32)reg_clk_base + (reg))
+
+unsigned long clk_measure_input_freq(void) {
+	u32 clock_autodetect;
+	clk_writel(OSC_FREQ_DET_TRIG | 1, OSC_FREQ_DET);
+	do {} while (clk_readl(OSC_FREQ_DET_STATUS) & OSC_FREQ_DET_BUSY);
+	clock_autodetect = clk_readl(OSC_FREQ_DET_STATUS);
+	if (clock_autodetect >= 732 - 3 && clock_autodetect <= 732 + 3) {
+		return 12000000;
+	} else if (clock_autodetect >= 794 - 3 && clock_autodetect <= 794 + 3) {
+		return 13000000;
+	} else if (clock_autodetect >= 1172 - 3 && clock_autodetect <= 1172 + 3) {
+		return 19200000;
+	} else if (clock_autodetect >= 1587 - 3 && clock_autodetect <= 1587 + 3) {
+		return 26000000;
+	} else {
+		pr_err("%s: Unexpected clock autodetect value %d", __func__, clock_autodetect);
+		BUG();
+		return 0;
+	}
+}
+
+static int clk_div71_possible_rate(struct clk *c, unsigned long rate)
+{
+	unsigned long input_rate = clk_get_rate(c);
+	int divider_u71;
+
+	divider_u71 = (input_rate*2)/rate;
+	if (rate * divider_u71 == input_rate*2)
+		return divider_u71 - 2;
+	else
+		return -1;
+}
+
+/* Default clk ops */
+static int tegra2_clk_enable(struct clk *c)
+{
+	pr_debug("%s on clock %s\n", __func__, c->name);
+	return 0;
+}
+
+static void tegra2_clk_disable(struct clk *c)
+{
+	pr_debug("%s on clock %s\n", __func__, c->name);
+}
+
+static unsigned long tegra2_clk_get_rate(struct clk *c)
+{
+	pr_debug("%s on clock %s\n", __func__, c->name);
+	return c->rate;
+}
+
+/* clk_m functions */
+static unsigned long tegra2_clk_m_autodetect_rate(struct clk *c)
+{
+	u32 auto_clock_control = clk_readl(OSC_CTRL) & ~OSC_CTRL_OSC_FREQ_MASK;
+
+	c->rate = clk_measure_input_freq();
+	switch (c->rate) {
+	case 12000000:
+		auto_clock_control |= OSC_CTRL_OSC_FREQ_12MHZ;
+		break;
+	case 13000000:
+		auto_clock_control |= OSC_CTRL_OSC_FREQ_13MHZ;
+		break;
+	case 19200000:
+		auto_clock_control |= OSC_CTRL_OSC_FREQ_19_2MHZ;
+		break;
+	case 26000000:
+		auto_clock_control |= OSC_CTRL_OSC_FREQ_26MHZ;
+		break;
+	default:
+		pr_err("%s: Unexpected clock rate %ld", __func__, c->rate);
+		BUG();
+	}
+	clk_writel(auto_clock_control, OSC_CTRL);
+	return c->rate;
+}
+
+static void tegra2_clk_m_init(struct clk *c)
+{
+	pr_debug("%s on clock %s\n", __func__, c->name);
+	tegra2_clk_m_autodetect_rate(c);
+}
+
+static int tegra2_clk_m_enable(struct clk *c)
+{
+	int ret = 0;
+	pr_debug("%s on clock %s\n", __func__, c->name);
+	return ret;
+}
+
+static void tegra2_clk_m_disable(struct clk *c)
+{
+	pr_debug("%s on clock %s\n", __func__, c->name);
+	BUG();
+}
+
+static struct clk_ops tegra_clk_m_ops = {
+	.init     = tegra2_clk_m_init,
+	.enable   = tegra2_clk_m_enable,
+	.disable  = tegra2_clk_m_disable,
+	.get_rate = tegra2_clk_get_rate,
+};
+
+/* PLL Functions */
+static int tegra2_pll_clk_set_rate(struct clk *c, unsigned long rate)
+{
+	u32 val;
+	unsigned long input_rate;
+	const struct clk_pll_table *sel;
+
+	pr_debug("%s on clock %s\n", __func__, c->name);
+	/* BUG_ON(c->refcnt != 0); */
+
+	input_rate = clk_get_rate(c->parent);
+	for (sel = c->pll_table; sel->input_rate != 0; sel++) {
+		if (sel->input_rate == input_rate && sel->output_rate == rate) {
+			c->n = sel->n;
+			c->m = sel->m;
+			c->p = sel->p;
+			c->cpcon = sel->cpcon;
+			val = clk_readl(c->reg + PLL_BASE);
+			if (c->flags & PLL_FIXED)
+				val |= PLL_BASE_OVERRIDE;
+			val &= ~(PLL_BASE_DIVP_MASK | PLL_BASE_DIVN_MASK |
+				 PLL_BASE_DIVM_MASK);
+			val |= (c->m << PLL_BASE_DIVM_SHIFT) |
+				(c->n << PLL_BASE_DIVN_SHIFT);
+			BUG_ON(c->p > 2);
+			if (c->p == 2)
+				val |= 1 << PLL_BASE_DIVP_SHIFT;
+			clk_writel(val, c->reg + PLL_BASE);
+			c->rate = rate;
+
+			if (c->flags & PLL_HAS_CPCON) {
+				val = c->cpcon << PLL_MISC_CPCON_SHIFT;
+				clk_writel(val, c->reg + PLL_MISC);
+			}
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static int tegra2_pll_clk_enable(struct clk *c)
+{
+	int ret = 0;
+	u32 val;
+	pr_debug("%s on clock %s\n", __func__, c->name);
+
+	val = clk_readl(c->reg + PLL_BASE);
+	val &= ~PLL_BASE_BYPASS;
+	val |= PLL_BASE_ENABLE;
+	clk_writel(val, c->reg + PLL_BASE);
+	return ret;
+}
+
+static void tegra2_pll_clk_disable(struct clk *c)
+{
+	u32 val;
+	pr_debug("%s on clock %s\n", __func__, c->name);
+
+	val = clk_readl(c->reg);
+	val &= ~(PLL_BASE_BYPASS | PLL_BASE_ENABLE);
+	clk_writel(val, c->reg);
+}
+
+static struct clk_ops tegra_pll_ops = {
+	.enable   = tegra2_pll_clk_enable,
+	.disable  = tegra2_pll_clk_disable,
+	.set_rate = tegra2_pll_clk_set_rate,
+	.get_rate = tegra2_clk_get_rate,
+};
+
+/* Clock divider ops */
+static int tegra2_div_clk_set_rate(struct clk *c, unsigned long rate)
+{
+	int ret = 0;
+	unsigned long flags;
+	u32 val;
+	u32 new_val;
+	int divider_u71;
+	pr_debug("%s: %lu\n", __func__, rate);
+	if (c->flags & DIV_U71) {
+		divider_u71 = clk_div71_possible_rate(c->parent, rate);
+		if (divider_u71 >= 0) {
+			/* Divider values for multiple PLL outputs are
+			   in the same register, so lock clk_reg_lock */
+			spin_lock_irqsave(&clk_reg_lock, flags);
+			val = clk_readl(c->reg);
+			new_val = val >> c->reg_shift;
+			new_val &= 0xFFFF;
+
+			if (c->flags & DIV_U71_FIXED)
+				new_val |= PLL_OUT_OVERRIDE;
+			new_val &= PLL_OUT_RATIO_MASK;
+			new_val |= divider_u71 << PLL_OUT_RATIO_SHIFT;
+
+			val &= ~(0xFFFF << c->reg_shift);
+			val |= new_val << c->reg_shift;
+			clk_writel(val, c->reg);
+			spin_unlock_irqrestore(&clk_reg_lock, flags);
+			return 1;
+		}
+	} else if (c->flags & DIV_2) {
+		if (clk_get_rate(c->parent) == rate * 2)
+			return 1;
+	}
+	BUG();
+	return ret;
+}
+
+
+static struct clk_ops tegra_div_ops = {
+	.enable   = tegra2_clk_enable,
+	.disable  = tegra2_clk_disable,
+	.set_rate = tegra2_div_clk_set_rate,
+	.get_rate = tegra2_clk_get_rate,
+};
+
+/* Periph clk ops */
+static void tegra2_periph_clk_init(struct clk *c)
+{
+	u32 val;
+	const struct clk_mux_sel *mux = 0;
+	const struct clk_mux_sel *sel;
+	if (c->reg) {
+		val = clk_readl(c->reg);
+		for (sel = c->inputs; sel->input != NULL; sel++) {
+			if (val >> PERIPH_CLK_SOURCE_SHIFT == sel->value)
+				mux = sel;
+		}
+		BUG_ON(!mux);
+
+		if (c->ops && c->ops->set_parent)
+			c->ops->set_parent(c, mux->input);
+	} else {
+		if (c->ops && c->ops->set_parent)
+			c->ops->set_parent(c, c->inputs[0].input);
+	}
+}
+
+static int tegra2_periph_clk_enable(struct clk *c)
+{
+	u32 val = (1<<(c->clk_num%32));
+	unsigned long reg = (c->clk_num / 32) * 8;
+
+	clk_writel(val, CLK_OUT_ENB_SET + reg);
+	clk_writel(val, RST_DEVICES_CLR + reg);
+	return 0;
+}
+
+static void tegra2_periph_clk_disable(struct clk *c)
+{
+	u32 val = (1<<(c->clk_num%32));
+	unsigned long reg = (c->clk_num / 32) * 8;
+
+	clk_writel(val, CLK_OUT_ENB_CLR + reg);
+	clk_writel(val, RST_DEVICES_SET + reg);
+}
+
+static int tegra2_periph_clk_set_parent(struct clk *c, struct clk *p)
+{
+	int ret = 0;
+	u32 val;
+	const struct clk_mux_sel *sel;
+	for (sel = c->inputs; sel->input != NULL; sel++) {
+		if (sel->input == p) {
+			c->parent = p;
+			val = clk_readl(c->reg);
+			val &= ~PERIPH_CLK_SOURCE_MASK;
+			val |= (sel->value) << PERIPH_CLK_SOURCE_SHIFT;
+			clk_writel(val, c->reg);
+		}
+	}
+
+	return ret;
+}
+
+static int tegra2_periph_clk_set_rate(struct clk *c, unsigned long rate)
+{
+	int ret = 0;
+	u32 val;
+	int divider_u71;
+	const struct clk_mux_sel *sel;
+	pr_debug("%s: %lu\n", __func__, rate);
+	for (sel = c->inputs; sel->input != NULL; sel++) {
+		if (c->flags & DIV_U71) {
+			divider_u71 = clk_div71_possible_rate(sel->input, rate);
+			if (divider_u71 >= 0) {
+				/* FIXME: ensure we don't go through a too-high rate */
+				if (c->ops && c->ops->set_parent)
+					c->ops->set_parent(c, sel->input);
+				udelay(1);
+				val = clk_readl(c->reg);
+				val &= ~PERIPH_CLK_SOURCE_DIV_MASK;
+				val |= divider_u71;
+				clk_writel(val, c->reg);
+				return 1;
+			}
+		} else {
+			if (clk_get_rate(sel->input) == rate) {
+				if (c->ops && c->ops->set_parent)
+					c->ops->set_parent(c, sel->input);
+				return 1;
+			}
+		}
+	}
+	BUG();
+	return ret;
+}
+
+static struct clk_ops tegra_periph_clk_ops = {
+	.init       = &tegra2_periph_clk_init,
+	.enable     = &tegra2_periph_clk_enable,
+	.disable    = &tegra2_periph_clk_disable,
+	.set_parent = &tegra2_periph_clk_set_parent,
+	.set_rate   = &tegra2_periph_clk_set_rate,
+};
+
+static struct clk tegra_clk_32k = {
+	.name = "tegra_clk_32k",
+	.rate = 32678,
+	.ops  = NULL,
+};
+
+static struct clk tegra_clk_input = {
+	.name = "tegra_clk_input",
+	.flags = ENABLE_ON_INIT,
+	.rate = 12000000,
+	.ops = NULL,
+};
+
+static struct clk_pll_table tegra_pll_s_table[] = {
+	{32768, 12000000, 366, 1, 1, 0},
+	{32768, 13000000, 397, 1, 1, 0},
+	{32768, 19200000, 586, 1, 1, 0},
+	{32768, 26000000, 793, 1, 1, 0},
+	{0, 0, 0, 0, 0, 0},
+};
+
+static struct clk tegra_pll_s = {
+	.name = "tegra_pll_s",
+	.ops = &tegra_pll_ops,
+	.reg       = 0xf0,
+	.input_min = 32768,
+	.input_max = 32768,
+	.parent     = &tegra_clk_32k,
+	.cf_min    = 0, /* FIXME */
+	.cf_max    = 0, /* FIXME */
+	.vco_min   = 12000000,
+	.vco_max   = 26000000,
+	.pll_table = tegra_pll_s_table,
+};
+
+static struct clk_mux_sel tegra_clk_m_sel[] = {
+	{ .input = &tegra_clk_32k, .value = 0},
+	{ .input = &tegra_pll_s,  .value = 1},
+	{ 0, 0},
+};
+static struct clk tegra_clk_m = {
+	.name      = "tegra_clk_m",
+	.flags     = ENABLE_ON_INIT,
+	.ops       = &tegra_clk_m_ops,
+	.inputs    = tegra_clk_m_sel,
+	.reg       = 0x1fc,
+	.reg_mask  = (1<<28),
+	.reg_shift = 28,
+};
+
+static struct clk_pll_table tegra_pll_c_table[] = {
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_c = {
+	.name      = "tegra_pll_c",
+	.flags	   = PLL_HAS_CPCON,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0x80,
+	.input_min = 2000000,
+	.input_max = 31000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 20000000,
+	.vco_max   = 1400000000,
+	.pll_table = tegra_pll_c_table,
+};
+
+static struct clk tegra_pll_c_out1 = {
+	.name      = "tegra_pll_c_out1",
+	.ops       = &tegra_div_ops,
+	.flags     = DIV_U71,
+	.parent    = &tegra_pll_c,
+	.reg       = 0x84,
+	.reg_shift = 0,
+};
+
+static struct clk_pll_table tegra_pll_m_table[] = {
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_m = {
+	.name      = "tegra_pll_m",
+	.flags     = PLL_HAS_CPCON,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0x90,
+	.input_min = 2000000,
+	.input_max = 31000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 20000000,
+	.vco_max   = 1200000000,
+	.pll_table = tegra_pll_m_table,
+};
+
+static struct clk tegra_pll_m_out1 = {
+	.name      = "tegra_pll_m_out1",
+	.ops       = &tegra_div_ops,
+	.flags     = DIV_U71,
+	.parent    = &tegra_pll_m,
+	.reg       = 0x94,
+	.reg_shift = 0,
+};
+
+static struct clk_pll_table tegra_pll_p_table[] = {
+	{ 12000000, 216000000, 432, 12, 2, 8},
+	{ 13000000, 216000000, 432, 13, 2, 8},
+	{ 19200000, 216000000, 90,   4, 2, 1},
+	{ 26000000, 216000000, 432, 26, 2, 8},
+	{ 12000000, 432000000, 432, 12, 1, 8},
+	{ 13000000, 432000000, 432, 13, 1, 8},
+	{ 19200000, 432000000, 90,   4, 1, 1},
+	{ 26000000, 432000000, 432, 26, 1, 8},
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_p = {
+	.name      = "tegra_pll_p",
+	.flags     = ENABLE_ON_INIT | PLL_FIXED | PLL_HAS_CPCON,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0xa0,
+	.input_min = 2000000,
+	.input_max = 31000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 20000000,
+	.vco_max   = 1400000000,
+	.pll_table = tegra_pll_p_table,
+};
+
+static struct clk tegra_pll_p_out1 = {
+	.name      = "tegra_pll_p_out1",
+	.ops       = &tegra_div_ops,
+	.flags     = ENABLE_ON_INIT | DIV_U71 | DIV_U71_FIXED,
+	.parent    = &tegra_pll_p,
+	.reg       = 0xa4,
+	.reg_shift = 0,
+};
+
+static struct clk tegra_pll_p_out2 = {
+	.name      = "tegra_pll_p_out2",
+	.ops       = &tegra_div_ops,
+	.flags     = ENABLE_ON_INIT | DIV_U71 | DIV_U71_FIXED,
+	.parent    = &tegra_pll_p,
+	.reg       = 0xa4,
+	.reg_shift = 16,
+};
+
+static struct clk tegra_pll_p_out3 = {
+	.name      = "tegra_pll_p_out3",
+	.ops       = &tegra_div_ops,
+	.flags     = ENABLE_ON_INIT | DIV_U71 | DIV_U71_FIXED,
+	.parent    = &tegra_pll_p,
+	.reg       = 0xa8,
+	.reg_shift = 0,
+};
+
+static struct clk tegra_pll_p_out4 = {
+	.name      = "tegra_pll_p_out4",
+	.ops       = &tegra_div_ops,
+	.flags     = ENABLE_ON_INIT | DIV_U71 | DIV_U71_FIXED,
+	.parent    = &tegra_pll_p,
+	.reg       = 0xa8,
+	.reg_shift = 16,
+};
+
+static struct clk_pll_table tegra_pll_a_table[] = {
+	{ 28800000, 56448000, 49, 25, 1, 1},
+	{ 28800000, 73728000, 64, 25, 1, 1},
+	{ 28800000, 11289600, 49, 25, 1, 1},
+	{ 28800000, 12288000, 64, 25, 1, 1},
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_a = {
+	.name      = "tegra_pll_a",
+	.flags     = PLL_HAS_CPCON,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0xb0,
+	.input_min = 2000000,
+	.input_max = 31000000,
+	.parent    = &tegra_pll_p_out1,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 20000000,
+	.vco_max   = 1400000000,
+	.pll_table = tegra_pll_a_table,
+};
+
+static struct clk tegra_pll_a_out0 = {
+	.name      = "tegra_pll_a_out0",
+	.ops       = &tegra_div_ops,
+	.flags     = DIV_U71,
+	.parent    = &tegra_pll_a,
+	.reg       = 0xb4,
+	.reg_shift = 0,
+};
+
+static struct clk_pll_table tegra_pll_d_table[] = {
+	{ 12000000, 1000000000, 1000, 12, 1, 12},
+	{ 13000000, 1000000000, 1000, 13, 1, 12},
+	{ 19200000, 1000000000, 625,  12, 1, 8},
+	{ 26000000, 1000000000, 1000, 26, 1, 12},
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_d = {
+	.name      = "tegra_pll_d",
+	.flags     = PLL_HAS_CPCON,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0xd0,
+	.input_min = 2000000,
+	.input_max = 40000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 40000000,
+	.vco_max   = 1000000000,
+	.pll_table = tegra_pll_d_table,
+};
+
+static struct clk tegra_pll_d_out0 = {
+	.name      = "tegra_pll_d_out0",
+	.ops       = &tegra_div_ops,
+	.flags     = DIV_2,
+	.parent    = &tegra_pll_d,
+};
+
+static struct clk_pll_table tegra_pll_u_table[] = {
+	{ 12000000, 480000000, 960, 12, 1, 0},
+	{ 13000000, 480000000, 960, 13, 1, 0},
+	{ 19200000, 480000000, 200, 4,  1, 0},
+	{ 26000000, 480000000, 960, 26, 1, 0},
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_u = {
+	.name      = "tegra_pll_u",
+	.flags     = 0,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0xc0,
+	.input_min = 2000000,
+	.input_max = 40000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 480000000,
+	.vco_max   = 960000000,
+	.pll_table = tegra_pll_u_table,
+};
+
+static struct clk_mux_sel mux_pllm_pllc_pllp_plla[] = {
+	{ .input = &tegra_pll_m, .value = 0},
+	{ .input = &tegra_pll_c, .value = 1},
+	{ .input = &tegra_pll_p, .value = 2},
+	{ .input = &tegra_pll_a_out0, .value = 3},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_pllp_pllc_pllm_clkm[] = {
+	{ .input = &tegra_pll_p, .value = 0},
+	{ .input = &tegra_pll_c, .value = 1},
+	{ .input = &tegra_pll_m, .value = 2},
+	{ .input = &tegra_clk_m, .value = 3},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_plla_audio_pllp_clkm[] = {
+	{.input = &tegra_pll_a, .value = 0},
+	/* FIXME: no mux defined for tegra_audio
+	{.input = &tegra_audio, .value = 1},*/
+	{.input = &tegra_pll_p, .value = 2},
+	{.input = &tegra_clk_m, .value = 3},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_pllp_plld_pllc_clkm[] = {
+	{.input = &tegra_pll_p, .value = 0},
+	{.input = &tegra_pll_d_out0, .value = 1},
+	{.input = &tegra_pll_c, .value = 2},
+	{.input = &tegra_clk_m, .value = 3},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_pllp_pllc_audio_clkm_clk32[] = {
+	{.input = &tegra_pll_p,     .value = 0},
+	{.input = &tegra_pll_c,     .value = 1},
+	/* FIXME: no mux defined for tegra_audio
+	{.input = &tegra_audio,     .value = 2},*/
+	{.input = &tegra_clk_m,     .value = 3},
+	{.input = &tegra_clk_32k,   .value = 4},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_pllp_pllc_pllm[] = {
+	{.input = &tegra_pll_p,     .value = 0},
+	{.input = &tegra_pll_c,     .value = 1},
+	{.input = &tegra_pll_m,     .value = 2},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_clk_m[] = {
+	{ .input = &tegra_clk_m, .value = 0},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_clk_32k[] = {
+	{ .input = &tegra_clk_32k, .value = 0},
+	{ 0, 0},
+};
+
+#define PERIPH_CLK(_name, _dev, _con, _clk_num, _reg, _inputs, _flags) \
+	{						\
+		.name      = _name,			\
+		.dev_id    = _dev,			\
+		.con_id	   = _con,			\
+		.ops       = &tegra_periph_clk_ops,	\
+		.clk_num   = _clk_num,			\
+		.reg       = _reg,			\
+		.inputs    = _inputs,			\
+		.flags     = _flags,			\
+	}
+
+struct clk tegra_periph_clks[] = {
+	PERIPH_CLK("rtc",       "rtc-tegra",  NULL,   4,  0,     mux_clk_32k,                    0),
+	PERIPH_CLK("timer",     "timer",      NULL,   5,  0,     mux_clk_m,                      0),
+	PERIPH_CLK("i2s1",      "i2s.0",      NULL,   11, 0x100, mux_plla_audio_pllp_clkm,       MUX | DIV_U71),
+	PERIPH_CLK("i2s2",      "i2s.1",      NULL,   18, 0x104, mux_plla_audio_pllp_clkm,       MUX | DIV_U71),
+	/* FIXME: spdif has 2 clocks but 1 enable */
+	PERIPH_CLK("spdif_out", "spdif_out",  NULL,   10, 0x108, mux_plla_audio_pllp_clkm,       MUX | DIV_U71),
+	PERIPH_CLK("spdif_in",  "spdif_in",   NULL,   10, 0x10c, mux_pllp_pllc_pllm,             MUX | DIV_U71),
+	PERIPH_CLK("pwm",       "pwm",        NULL,   17, 0x110, mux_pllp_pllc_audio_clkm_clk32, MUX | DIV_U71),
+	PERIPH_CLK("spi",       "spi",        NULL,   43, 0x114, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("xio",       "xio",        NULL,   45, 0x120, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("twc",       "twc",        NULL,   16, 0x12c, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sbc1",      "sbc.0",      NULL,   41, 0x134, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sbc2",      "sbc.1",      NULL,   44, 0x118, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sbc3",      "sbc.2",      NULL,   46, 0x11c, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sbc4",      "sbc.3",      NULL,   68, 0x1b4, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("ide",       "ide",        NULL,   25, 0x144, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("ndflash",   "tegra_nand", NULL,   13, 0x160, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	/* FIXME: vfir shares an enable with uartb */
+	PERIPH_CLK("vfir",      "vfir",       NULL,   7,  0x168, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sdmmc1",    "sdhci-tegra.0",    NULL,   14, 0x150, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sdmmc2",    "sdhci-tegra.1",    NULL,   9,  0x154, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sdmmc3",    "sdhci-tegra.2",    NULL,   69, 0x1bc, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sdmmc4",    "sdhci-tegra.3",    NULL,   15, 0x160, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("vde",       "vde",        NULL,   61, 0x1c8, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("csite",     "csite",      NULL,   73, 0x1d4, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	/* FIXME: what is la? */
+	PERIPH_CLK("la",        "la",         NULL,   76, 0x1f8, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("owr",       "owr",        NULL,   71, 0x1cc, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("nor",       "nor",        NULL,   42, 0x1d0, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("mipi",      "mipi",       NULL,   50, 0x174, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("i2c1",      "i2c.0",      NULL,   12, 0x124, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("i2c2",      "i2c.1",      NULL,   54, 0x198, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("i2c3",      "i2c.2",      NULL,   67, 0x1b8, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("dvc",       "dvc",        NULL,   47, 0x128, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("uarta",     "uart.0",     NULL,   6,  0x178, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("uartb",     "uart.1",     NULL,   7,  0x17c, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("uartc",     "uart.2",     NULL,   55, 0x1a0, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("uartd",     "uart.3",     NULL,   65, 0x1c0, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("uarte",     "uart.4",     NULL,   66, 0x1c4, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("3d",        "3d",         NULL,   24, 0x158, mux_pllm_pllc_pllp_plla,        MUX | DIV_U71),
+	PERIPH_CLK("2d",        "2d",         NULL,   21, 0x15c, mux_pllm_pllc_pllp_plla,        MUX | DIV_U71),
+	/* FIXME: vi and vi_sensor share an enable */
+	PERIPH_CLK("vi",        "vi",         NULL,   20, 0x148, mux_pllm_pllc_pllp_plla,        MUX | DIV_U71),
+	PERIPH_CLK("vi_sensor", "vi_sensor",  NULL,   20, 0x1a8, mux_pllm_pllc_pllp_plla,        MUX | DIV_U71),
+	PERIPH_CLK("epp",       "epp",        NULL,   19, 0x16c, mux_pllm_pllc_pllp_plla,        MUX | DIV_U71),
+	PERIPH_CLK("mpe",       "mpe",        NULL,   60, 0x170, mux_pllm_pllc_pllp_plla,        MUX | DIV_U71),
+	PERIPH_CLK("host1x",    "host1x",     NULL,   28, 0x180, mux_pllm_pllc_pllp_plla,        MUX | DIV_U71),
+	/* FIXME: cve and tvo share an enable  */
+	PERIPH_CLK("cve",       "cve",        NULL,   49, 0x140, mux_pllp_plld_pllc_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("tvo",       "tvo",        NULL,   49, 0x188, mux_pllp_plld_pllc_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("hdmi",      "hdmi",       NULL,   51, 0x18c, mux_pllp_plld_pllc_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("tvdac",     "tvdac",      NULL,   53, 0x194, mux_pllp_plld_pllc_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("disp1",     "tegrafb.0",  NULL,   27, 0x138, mux_pllp_plld_pllc_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("disp2",     "tegrafb.1",  NULL,   26, 0x13c, mux_pllp_plld_pllc_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("usbd",      "usb.0",      NULL,   22, 0,     mux_clk_m,                              0),
+	PERIPH_CLK("usb2",      "usb.1",      NULL,   58, 0,     mux_clk_m,                              0),
+	PERIPH_CLK("usb3",      "usb.2",      NULL,   59, 0,     mux_clk_m,                              0),
+};
+const int tegra_num_periph_clks = ARRAY_SIZE(tegra_periph_clks);
+
+struct clk_lookup tegra_periph_clk_lookups[ARRAY_SIZE(tegra_periph_clks)];
+
+#define CLK(dev, con, ck)     \
+	{       \
+		.dev_id = dev,  \
+		.con_id = con,  \
+		.clk = ck,  \
+	}
+
+struct clk_lookup tegra_clk_lookups[] = {
+	/* external root sources */
+	CLK(NULL, "input_clk",  &tegra_clk_input),
+	CLK(NULL, "32k_clk", &tegra_clk_32k),
+	CLK(NULL, "pll_s", &tegra_pll_s),
+	CLK(NULL, "clk_m", &tegra_clk_m),
+	CLK(NULL, "pll_m", &tegra_pll_m),
+	CLK(NULL, "pll_m_out1", &tegra_pll_m_out1),
+	CLK(NULL, "pll_c", &tegra_pll_c),
+	CLK(NULL, "pll_c_out1", &tegra_pll_c_out1),
+	CLK(NULL, "pll_p", &tegra_pll_p),
+	CLK(NULL, "pll_p_out1", &tegra_pll_p_out1),
+	CLK(NULL, "pll_p_out2", &tegra_pll_p_out2),
+	CLK(NULL, "pll_p_out3", &tegra_pll_p_out3),
+	CLK(NULL, "pll_p_out4", &tegra_pll_p_out4),
+	CLK(NULL, "pll_a",      &tegra_pll_a),
+	CLK(NULL, "pll_a_out0", &tegra_pll_a_out0),
+	CLK(NULL, "pll_d",      &tegra_pll_d),
+	CLK(NULL, "pll_d_out0", &tegra_pll_d_out0),
+	CLK(NULL, "pll_u",      &tegra_pll_u),
+	CLK(NULL, NULL, NULL),
+};
-- 
1.6.5.6
