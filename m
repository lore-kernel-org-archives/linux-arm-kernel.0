From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 21 Apr 2012 23:57:13 +0800
Subject: [PATCH 1/8] clk: mxs: add mxs specific clocks
In-Reply-To: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
References: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1335023840-1394-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mxs specific clocks, pll, reference clock (PFD), integer divider
and fractional divider.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/mxs/Makefile   |    5 ++
 drivers/clk/mxs/clk-div.c  |  102 ++++++++++++++++++++++++++++++++
 drivers/clk/mxs/clk-frac.c |  127 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/mxs/clk-pll.c  |  123 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/mxs/clk-ref.c  |  139 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/mxs/clk.h      |   75 ++++++++++++++++++++++++
 6 files changed, 571 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/mxs/Makefile
 create mode 100644 drivers/clk/mxs/clk-div.c
 create mode 100644 drivers/clk/mxs/clk-frac.c
 create mode 100644 drivers/clk/mxs/clk-pll.c
 create mode 100644 drivers/clk/mxs/clk-ref.c
 create mode 100644 drivers/clk/mxs/clk.h

diff --git a/drivers/clk/mxs/Makefile b/drivers/clk/mxs/Makefile
new file mode 100644
index 0000000..067c231
--- /dev/null
+++ b/drivers/clk/mxs/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for mxs specific clk
+#
+
+obj-y += clk-pll.o clk-ref.o clk-div.o clk-frac.o
diff --git a/drivers/clk/mxs/clk-div.c b/drivers/clk/mxs/clk-div.c
new file mode 100644
index 0000000..679a927
--- /dev/null
+++ b/drivers/clk/mxs/clk-div.c
@@ -0,0 +1,102 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include "clk.h"
+
+/**
+ * struct clk_div - mxs integer divider clock
+ * @divider: the parent class
+ * @ops: pointer to clk_ops of parent class
+ * @reg: register address
+ * @busy: busy bit shift
+ *
+ * The mxs divider clock is a subclass of basic clk_divider with an
+ * addtional busy bit.
+ */
+struct clk_div {
+	struct clk_divider divider;
+	const struct clk_ops *ops;
+	void __iomem *reg;
+	u8 busy;
+};
+
+static inline struct clk_div *to_clk_div(struct clk_hw *hw)
+{
+	struct clk_divider *divider = container_of(hw, struct clk_divider, hw);
+
+	return container_of(divider, struct clk_div, divider);
+}
+
+static unsigned long clk_div_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_div *div = to_clk_div(hw);
+
+	return div->ops->recalc_rate(&div->divider.hw, parent_rate);
+}
+
+static long clk_div_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	struct clk_div *div = to_clk_div(hw);
+
+	return div->ops->round_rate(&div->divider.hw, rate, prate);
+}
+
+static int clk_div_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_div *div = to_clk_div(hw);
+	int ret;
+
+	ret = div->ops->set_rate(&div->divider.hw, rate, parent_rate);
+	if (!ret)
+		ret = mxs_clk_wait(div->reg, div->busy);
+
+	return ret;
+}
+
+static struct clk_ops clk_div_ops = {
+	.recalc_rate = clk_div_recalc_rate,
+	.round_rate = clk_div_round_rate,
+	.set_rate = clk_div_set_rate,
+};
+
+struct clk *mxs_clk_div(const char *name, const char *parent_name,
+			void __iomem *reg, u8 shift, u8 width, u8 busy)
+{
+	struct clk_div *div;
+	struct clk *clk;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	div->reg = reg;
+	div->busy = busy;
+
+	div->divider.reg = reg;
+	div->divider.shift = shift;
+	div->divider.width = width;
+	div->divider.flags = CLK_DIVIDER_ONE_BASED;
+	div->ops = &clk_divider_ops;
+
+	clk = clk_register(NULL, name, &clk_div_ops, &div->divider.hw,
+			   &parent_name, 1, CLK_SET_RATE_PARENT);
+	if (!clk)
+		kfree(div);
+
+	return clk;
+}
diff --git a/drivers/clk/mxs/clk-frac.c b/drivers/clk/mxs/clk-frac.c
new file mode 100644
index 0000000..9acf1fc
--- /dev/null
+++ b/drivers/clk/mxs/clk-frac.c
@@ -0,0 +1,127 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include "clk.h"
+
+/**
+ * struct clk_frac - mxs fractional divider clock
+ * @hw: clk_hw for the fractional divider clock
+ * @reg: register address
+ * @shift: the divider bit shift
+ * @width: the divider bit width
+ * @busy: busy bit shift
+ *
+ * The clock is an adjustable fractional divider with a busy bit to wait
+ * when the divider is adjusted.
+ */
+struct clk_frac {
+	struct clk_hw hw;
+	void __iomem *reg;
+	u8 shift;
+	u8 width;
+	u8 busy;
+};
+
+#define to_clk_frac(_hw) container_of(_hw, struct clk_frac, hw)
+
+static unsigned long clk_frac_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct clk_frac *frac = to_clk_frac(hw);
+	u32 div;
+
+	div = readl_relaxed(frac->reg) >> frac->shift;
+	div &= (1 << frac->width) - 1;
+
+	return (parent_rate >> frac->width) * div;
+}
+
+static long clk_frac_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	struct clk_frac *frac = to_clk_frac(hw);
+	unsigned long parent_rate = *prate;
+	u32 div;
+	u64 tmp;
+
+	if (rate > parent_rate)
+		return -EINVAL;
+
+	tmp = rate;
+	tmp <<= frac->width;
+	do_div(tmp, parent_rate);
+	div = tmp;
+
+	if (!div)
+		return -EINVAL;
+
+	return (parent_rate >> frac->width) * div;
+}
+
+static int clk_frac_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	struct clk_frac *frac = to_clk_frac(hw);
+	u32 div, val;
+	u64 tmp;
+
+	if (rate > parent_rate)
+		return -EINVAL;
+
+	tmp = rate;
+	tmp <<= frac->width;
+	do_div(tmp, parent_rate);
+	div = tmp;
+
+	if (!div)
+		return -EINVAL;
+
+	val = readl_relaxed(frac->reg);
+	val &= ~(((1 << frac->width) - 1) << frac->shift);
+	val |= div << frac->shift;
+	writel_relaxed(val, frac->reg);
+
+	return mxs_clk_wait(frac->reg, frac->busy);
+}
+
+static struct clk_ops clk_frac_ops = {
+	.recalc_rate = clk_frac_recalc_rate,
+	.round_rate = clk_frac_round_rate,
+	.set_rate = clk_frac_set_rate,
+};
+
+struct clk *mxs_clk_frac(const char *name, const char *parent_name,
+			 void __iomem *reg, u8 shift, u8 width, u8 busy)
+{
+	struct clk_frac *frac;
+	struct clk *clk;
+
+	frac = kzalloc(sizeof(*frac), GFP_KERNEL);
+	if (!frac)
+		return ERR_PTR(-ENOMEM);
+
+	frac->reg = reg;
+	frac->shift = shift;
+	frac->width = width;
+	frac->busy = busy;
+
+	clk = clk_register(NULL, name, &clk_frac_ops, &frac->hw,
+			   &parent_name, 1, CLK_SET_RATE_PARENT);
+	if (!clk)
+		kfree(frac);
+
+	return clk;
+}
diff --git a/drivers/clk/mxs/clk-pll.c b/drivers/clk/mxs/clk-pll.c
new file mode 100644
index 0000000..bde928d
--- /dev/null
+++ b/drivers/clk/mxs/clk-pll.c
@@ -0,0 +1,123 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include "clk.h"
+
+/**
+ * struct clk_pll - mxs pll clock
+ * @hw: clk_hw for the pll
+ * @base: base address of the pll
+ * @power_shift: the shift of power control bit
+ * @gate_shift: the shift of gate control bit
+ * @rate: the clock rate of the pll
+ * @flags: the pll specific flags
+ *	PLL_SET_GATE_DISABLE - By default, pll sets gate bit to enable clock.
+ *	Settting this flag will have pll set gate bit to disable clock.
+ *
+ * The mxs pll is a fixed rate clock with power and gate control.
+ */
+struct clk_pll {
+	struct clk_hw hw;
+	void __iomem *base;
+	u8 power_shift;
+	u8 gate_shift;
+	unsigned long rate;
+	unsigned long flags;
+};
+
+#define to_clk_pll(_hw) container_of(_hw, struct clk_pll, hw)
+
+static int clk_pll_prepare(struct clk_hw *hw)
+{
+	struct clk_pll *pll = to_clk_pll(hw);
+
+	writel_relaxed(1 << pll->power_shift, pll->base + SET);
+
+	udelay(10);
+
+	return 0;
+}
+
+static void clk_pll_unprepare(struct clk_hw *hw)
+{
+	struct clk_pll *pll = to_clk_pll(hw);
+
+	writel_relaxed(1 << pll->power_shift, pll->base + CLR);
+}
+
+static int clk_pll_enable(struct clk_hw *hw)
+{
+	struct clk_pll *pll = to_clk_pll(hw);
+
+	if (pll->flags & PLL_SET_GATE_DISABLE)
+		writel_relaxed(1 << pll->gate_shift, pll->base + CLR);
+	else
+		writel_relaxed(1 << pll->gate_shift, pll->base + SET);
+
+	return 0;
+}
+
+static void clk_pll_disable(struct clk_hw *hw)
+{
+	struct clk_pll *pll = to_clk_pll(hw);
+
+	if (pll->flags & PLL_SET_GATE_DISABLE)
+		writel_relaxed(1 << pll->gate_shift, pll->base + SET);
+	else
+		writel_relaxed(1 << pll->gate_shift, pll->base + CLR);
+}
+
+static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_pll *pll = to_clk_pll(hw);
+
+	return pll->rate;
+}
+
+static const struct clk_ops clk_pll_ops = {
+	.prepare = clk_pll_prepare,
+	.unprepare = clk_pll_unprepare,
+	.enable = clk_pll_enable,
+	.disable = clk_pll_disable,
+	.recalc_rate = clk_pll_recalc_rate,
+};
+
+struct clk *mxs_clk_pll(const char *name, const char *parent_name,
+			void __iomem *base, u8 power_shift, u8 gate_shift,
+			unsigned long rate, unsigned long flags)
+{
+	struct clk_pll *pll;
+	struct clk *clk;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base = base;
+	pll->rate = rate;
+	pll->power_shift = power_shift;
+	pll->gate_shift = gate_shift;
+	pll->flags = flags;
+
+	clk = clk_register(NULL, name, &clk_pll_ops, &pll->hw,
+			   &parent_name, 1, 0);
+	if (!clk)
+		kfree(pll);
+
+	return clk;
+}
diff --git a/drivers/clk/mxs/clk-ref.c b/drivers/clk/mxs/clk-ref.c
new file mode 100644
index 0000000..bb2027a
--- /dev/null
+++ b/drivers/clk/mxs/clk-ref.c
@@ -0,0 +1,139 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include "clk.h"
+
+/**
+ * struct clk_ref - mxs reference clock
+ * @hw: clk_hw for the reference clock
+ * @reg: register address
+ * @idx: the index of the reference clock within the same register
+ *
+ * The mxs reference clock sources from pll.  Every 4 reference clocks share
+ * one register space, and @idx is used to identify them.  Each reference
+ * clock has a gate control and a fractional * divider.  The rate is calculated
+ * as pll rate  * (18 / FRAC), where FRAC = 18 ~ 35.
+ */
+struct clk_ref {
+	struct clk_hw hw;
+	void __iomem *reg;
+	u8 idx;
+};
+
+#define to_clk_ref(_hw) container_of(_hw, struct clk_ref, hw)
+
+static int clk_ref_enable(struct clk_hw *hw)
+{
+	struct clk_ref *ref = to_clk_ref(hw);
+
+	writel_relaxed(1 << ((ref->idx + 1) * 8 - 1), ref->reg + CLR);
+
+	return 0;
+}
+
+static void clk_ref_disable(struct clk_hw *hw)
+{
+	struct clk_ref *ref = to_clk_ref(hw);
+
+	writel_relaxed(1 << ((ref->idx + 1) * 8 - 1), ref->reg + SET);
+}
+
+static unsigned long clk_ref_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_ref *ref = to_clk_ref(hw);
+	u64 tmp = parent_rate;
+	u8 frac = (readl_relaxed(ref->reg) >> (ref->idx * 8)) & 0x3f;
+
+	tmp *= 18;
+	do_div(tmp, frac);
+
+	return tmp;
+}
+
+static long clk_ref_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	unsigned long parent_rate = *prate;
+	u64 tmp = parent_rate;
+	u8 frac;
+
+	tmp = tmp * 18 + rate / 2;
+	do_div(tmp, rate);
+	frac = tmp;
+
+	if (frac < 18)
+		frac = 18;
+	else if (frac > 35)
+		frac = 35;
+
+	tmp = parent_rate;
+	tmp *= 18;
+	do_div(tmp, frac);
+
+	return tmp;
+}
+
+static int clk_ref_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_ref *ref = to_clk_ref(hw);
+	u64 tmp = parent_rate;
+	u8 frac;
+
+	tmp = tmp * 18 + rate / 2;
+	do_div(tmp, rate);
+	frac = tmp;
+
+	if (frac < 18)
+		frac = 18;
+	else if (frac > 35)
+		frac = 35;
+
+	writel_relaxed(0x3f << (ref->idx * 8), ref->reg + CLR);
+	writel_relaxed(frac << (ref->idx * 8), ref->reg + SET);
+
+	return 0;
+}
+
+static const struct clk_ops clk_ref_ops = {
+	.enable		= clk_ref_enable,
+	.disable	= clk_ref_disable,
+	.recalc_rate	= clk_ref_recalc_rate,
+	.round_rate	= clk_ref_round_rate,
+	.set_rate	= clk_ref_set_rate,
+};
+
+struct clk *mxs_clk_ref(const char *name, const char *parent_name,
+			void __iomem *reg, u8 idx)
+{
+	struct clk_ref *ref;
+	struct clk *clk;
+
+	ref = kzalloc(sizeof(*ref), GFP_KERNEL);
+	if (!ref)
+		return ERR_PTR(-ENOMEM);
+
+	ref->reg = reg;
+	ref->idx = idx;
+
+	clk = clk_register(NULL, name, &clk_ref_ops, &ref->hw,
+			   &parent_name, 1, 0);
+	if (!clk)
+		kfree(ref);
+
+	return clk;
+}
diff --git a/drivers/clk/mxs/clk.h b/drivers/clk/mxs/clk.h
new file mode 100644
index 0000000..deb5c23
--- /dev/null
+++ b/drivers/clk/mxs/clk.h
@@ -0,0 +1,75 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef __MXS_CLK_H
+#define __MXS_CLK_H
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#define SET	0x4
+#define CLR	0x8
+
+#define PLL_SET_GATE_DISABLE		BIT(0)
+
+struct clk *mxs_clk_pll(const char *name, const char *parent_name,
+			void __iomem *base, u8 power_shift, u8 gate_shift,
+			unsigned long rate, unsigned long flags);
+
+struct clk *mxs_clk_ref(const char *name, const char *parent_name,
+			void __iomem *reg, u8 idx);
+
+struct clk *mxs_clk_div(const char *name, const char *parent_name,
+			void __iomem *reg, u8 shift, u8 width, u8 busy);
+
+struct clk *mxs_clk_frac(const char *name, const char *parent_name,
+			 void __iomem *reg, u8 shift, u8 width, u8 busy);
+
+static inline struct clk *mxs_clk_fixed(const char *name, int rate)
+{
+	return clk_register_fixed_rate(NULL, name, NULL, CLK_IS_ROOT, rate);
+}
+
+static inline struct clk *mxs_clk_gate(const char *name,
+			const char *parent_name, void __iomem *reg, u8 shift)
+{
+	return clk_register_gate(NULL, name, parent_name, CLK_SET_RATE_PARENT,
+				 reg, shift, CLK_GATE_SET_TO_DISABLE, NULL);
+}
+
+static inline struct clk *mxs_clk_mux(const char *name, void __iomem *reg,
+		u8 shift, u8 width, const char **parent_names, int num_parents)
+{
+	return clk_register_mux(NULL, name, parent_names, num_parents,
+				CLK_SET_RATE_PARENT, reg, shift, width,
+				0, NULL);
+}
+
+static inline struct clk *mxs_clk_fixed_factor(const char *name,
+		const char *parent_name, unsigned int mult, unsigned int div)
+{
+	return clk_register_fixed_factor(NULL, name, parent_name,
+					 CLK_SET_RATE_PARENT, mult, div);
+}
+
+static inline int mxs_clk_wait(void __iomem *reg, u8 shift)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+
+	while (readl_relaxed(reg) & (1 << shift))
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+
+	return 0;
+}
+
+#endif /* __MXS_CLK_H */
-- 
1.7.5.4
