From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 Nov 2011 09:48:55 +0800
Subject: [RFC PATCH 2/3] arm/imx: add a generic clock implementation for imx
In-Reply-To: <1321926536-671-1-git-send-email-shawn.guo@linaro.org>
References: <1321926536-671-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1321926536-671-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds a generic clock implementation which applies on several
modern imx generations.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clock.c |  222 +++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/clock.h |   64 +++++++++++++
 2 files changed, 286 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-imx/clock.c
 create mode 100644 arch/arm/mach-imx/clock.h

diff --git a/arch/arm/mach-imx/clock.c b/arch/arm/mach-imx/clock.c
new file mode 100644
index 0000000..6243622
--- /dev/null
+++ b/arch/arm/mach-imx/clock.c
@@ -0,0 +1,222 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <asm/processor.h>
+#include "clock.h"
+
+int clk_imx_enable(struct clk_hw *hw)
+{
+	struct clk_imx_gate *g = to_clk_imx(hw)->gate;
+	u32 val;
+
+	if (!g)
+		return 0;
+
+	val = readl_relaxed(g->reg);
+	if (g->gate_set_bit)
+		val &= ~g->mask;
+	else
+		val |= g->mask;
+	writel_relaxed(val, g->reg);
+
+	return 0;
+}
+
+void clk_imx_disable(struct clk_hw *hw)
+{
+	struct clk_imx_gate *g = to_clk_imx(hw)->gate;
+	u32 val;
+
+	if (!g)
+		return;
+
+	val = readl_relaxed(g->reg);
+	if (g->gate_set_bit)
+		val |= g->mask;
+	else
+		val &= ~g->mask;
+	writel_relaxed(val, g->reg);
+}
+
+struct clk *clk_imx_get_parent(struct clk_hw *hw)
+{
+	struct clk_imx_mux *m = to_clk_imx(hw)->mux;
+	u32 i;
+
+	if (!m)
+		return to_clk_imx(hw)->parent->clk;
+
+	i = readl_relaxed(m->reg) >> m->shift;
+	i &= (1 << m->width) - 1;
+
+	if (i >= m->num_parents)
+		return ERR_PTR(-EINVAL);
+
+	return m->parents[i]->clk;
+}
+
+static int clk_imx_busy_wait(struct clk_imx_busy *b)
+{
+	int timeout = 0x100000;
+
+	while ((readl_relaxed(b->reg) & b->mask) && --timeout)
+		cpu_relax();
+
+	if (unlikely(!timeout))
+		return -EBUSY;
+
+	return 0;
+}
+
+static int clk_imx_set_parent(struct clk_hw *hw, struct clk *parent)
+{
+	struct clk_imx_mux *m = to_clk_imx(hw)->mux;
+	int i;
+	u32 val;
+
+	if (!m)
+		return -EINVAL;
+
+	for (i = 0; i < m->num_parents; i++)
+		if (parent == m->parents[i]->clk)
+			break;
+
+	if (i == m->num_parents)
+		return -EINVAL;
+
+	val = readl_relaxed(m->reg);
+	val &= ~(((1 << m->width) - 1) << m->shift);
+	val |= i << m->shift;
+	writel_relaxed(val, m->reg);
+
+	return (m->busy) ? clk_imx_busy_wait(m->busy) : 0;
+}
+
+static unsigned long clk_imx_recalc_rate(struct clk_hw *hw)
+{
+	struct clk_imx_div *d = to_clk_imx(hw)->div;
+	u32 val, pred, podf;
+
+	if (!d)
+		return clk_get_rate(clk_get_parent(hw->clk));
+
+	val = readl_relaxed(d->reg);
+	pred = (val >> d->shift_pred & ((1 << d->width_pred) - 1)) + 1;
+	podf = (val >> d->shift_podf & ((1 << d->width_podf) - 1)) + 1;
+
+	return clk_get_rate(clk_get_parent(hw->clk)) / (pred * podf);
+}
+
+static void calc_pred_podf_dividers(u32 div, u32 *pred, u32 *podf)
+{
+	u32 min_pred, temp_pred, old_err, err;
+
+	if (div >= 512) {
+		*pred = 8;
+		*podf = 64;
+	} else if (div >= 8) {
+		min_pred = (div - 1) / 64 + 1;
+		old_err = 8;
+		for (temp_pred = 8; temp_pred >= min_pred; temp_pred--) {
+			err = div % temp_pred;
+			if (err == 0) {
+				*pred = temp_pred;
+				break;
+			}
+			err = temp_pred - err;
+			if (err < old_err) {
+				old_err = err;
+				*pred = temp_pred;
+			}
+		}
+		*podf = (div + *pred - 1) / *pred;
+	} else if (div < 8) {
+		*pred = div;
+		*podf = 1;
+	}
+}
+
+static long clk_imx_round_rate(struct clk_hw *hw, unsigned long rate)
+{
+	struct clk_imx_div *d = to_clk_imx(hw)->div;
+	u32 div, div_max, pred = 0, podf;
+	unsigned long parent_rate = clk_get_rate(clk_get_parent(hw->clk));
+
+	if (!d)
+		return -EINVAL;
+
+	div = parent_rate / rate;
+	if (div == 0 || parent_rate % rate)
+		div++;
+
+	if (d->width_pred) {
+		calc_pred_podf_dividers(div, &pred, &podf);
+		div = pred * podf;
+	} else {
+		div_max = 1 << d->width_podf;
+		if (div > div_max)
+			div = div_max;
+	}
+
+	return parent_rate / div;
+}
+
+static int clk_imx_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long *parent_rate)
+{
+	struct clk_imx_div *d = to_clk_imx(hw)->div;
+	u32 val, div, pred = 0, podf;
+
+	if (!d)
+		return -EINVAL;
+
+	*parent_rate = clk_get_rate(clk_get_parent(hw->clk));
+
+	div = *parent_rate / rate;
+	if (div == 0)
+		div++;
+
+	if ((*parent_rate / div != rate) || div >
+	    (1 << d->width_pred) * (1 << d->width_podf))
+		return -EINVAL;
+
+	if (d->width_pred) {
+		calc_pred_podf_dividers(div, &pred, &podf);
+	} else {
+		pred = 1;
+		podf = div;
+	}
+
+	val = readl_relaxed(d->reg);
+	val &= ~(((1 << d->width_pred) - 1) << d->shift_pred);
+	val &= ~(((1 << d->width_podf) - 1) << d->shift_podf);
+	val |= (pred - 1) << d->shift_pred;
+	val |= (podf - 1) << d->shift_podf;
+	writel_relaxed(val, d->reg);
+
+	return (d->busy) ? clk_imx_busy_wait(d->busy) : 0;
+}
+
+const struct clk_hw_ops clk_imx_ops = {
+	.enable		= clk_imx_enable,
+	.disable	= clk_imx_disable,
+	.recalc_rate	= clk_imx_recalc_rate,
+	.round_rate	= clk_imx_round_rate,
+	.set_rate	= clk_imx_set_rate,
+	.get_parent	= clk_imx_get_parent,
+	.set_parent	= clk_imx_set_parent,
+};
diff --git a/arch/arm/mach-imx/clock.h b/arch/arm/mach-imx/clock.h
new file mode 100644
index 0000000..49e42b9
--- /dev/null
+++ b/arch/arm/mach-imx/clock.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#ifndef __MACH_IMX_CLK_H
+#define __MACH_IMX_CLK_H
+
+#include <linux/types.h>
+#include <linux/clk.h>
+
+struct clk_imx_busy {
+	void __iomem *reg;
+	u32 mask;
+};
+
+struct clk_imx_gate {
+	void __iomem *reg;
+	u32 mask;
+	int gate_set_bit;
+	int powerup_set_bit;
+};
+
+struct clk_imx_div {
+	void __iomem *reg;
+	u32 shift_pred;
+	u32 width_pred;
+	u32 shift_podf;
+	u32 width_podf;
+	struct clk_imx_busy *busy;
+};
+
+struct clk_imx_mux {
+	void __iomem *reg;
+	u32 shift;
+	u32 width;
+	struct clk_imx_busy *busy;
+	struct clk_hw **parents;
+	int num_parents;
+};
+
+struct clk_hw_imx {
+	struct clk_hw hw;
+	struct clk_imx_gate *gate;
+	struct clk_imx_div *div;
+	struct clk_imx_mux *mux;
+	struct clk_hw *parent;
+};
+
+#define to_clk_imx(c) container_of(c, struct clk_hw_imx, hw)
+
+extern const struct clk_hw_ops clk_imx_ops;
+
+extern int clk_imx_enable(struct clk_hw *hw);
+extern void clk_imx_disable(struct clk_hw *hw);
+extern struct clk *clk_imx_get_parent(struct clk_hw *hw);
+
+#endif /* __MACH_IMX_CLK_H */
-- 
1.7.4.1
