From: carlo@caione.org (Carlo Caione)
Date: Wed, 19 Nov 2014 11:32:20 +0100
Subject: [PATCH 1/4] ARM: meson: add basic infrastructure for clocks
In-Reply-To: <1416393143-20434-1-git-send-email-carlo@caione.org>
References: <1416393143-20434-1-git-send-email-carlo@caione.org>
Message-ID: <1416393143-20434-2-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the infrastructure for registering and managing the
core clocks found on Amlogic MesonX SoCs and also adds the support for
the basic Meson6 clocks.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 drivers/clk/Makefile                    |   1 +
 drivers/clk/meson/Makefile              |   7 +
 drivers/clk/meson/clk-pll.c             | 298 ++++++++++++++++++++++++++++++++
 drivers/clk/meson/clkc.c                | 151 ++++++++++++++++
 drivers/clk/meson/clkc.h                | 159 +++++++++++++++++
 drivers/clk/meson/meson6-clkc.c         | 160 +++++++++++++++++
 include/dt-bindings/clock/meson6-clkc.h |  18 ++
 7 files changed, 794 insertions(+)
 create mode 100644 drivers/clk/meson/Makefile
 create mode 100644 drivers/clk/meson/clk-pll.c
 create mode 100644 drivers/clk/meson/clkc.c
 create mode 100644 drivers/clk/meson/clkc.h
 create mode 100644 drivers/clk/meson/meson6-clkc.c
 create mode 100644 include/dt-bindings/clock/meson6-clkc.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d5fba5b..e93d134 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -51,6 +51,7 @@ ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)			+= mmp/
 endif
 obj-$(CONFIG_PLAT_ORION)		+= mvebu/
+obj-$(CONFIG_ARCH_MESON)		+= meson/
 obj-$(CONFIG_ARCH_MXS)			+= mxs/
 obj-$(CONFIG_COMMON_CLK_PXA)		+= pxa/
 obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
new file mode 100644
index 0000000..8f102e4
--- /dev/null
+++ b/drivers/clk/meson/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for Meson specific clk
+#
+
+obj-y += clkc.o
+obj-y += meson6-clkc.o
+obj-y += clk-pll.o
diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
new file mode 100644
index 0000000..5b6d064
--- /dev/null
+++ b/drivers/clk/meson/clk-pll.c
@@ -0,0 +1,298 @@
+/*
+ * Copyright (c) 2014 Carlo Caione <carlo@caione.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "clkc.h"
+
+/*
+ * A generic PLL in a Meson6/Meson8 SOC is composed as follows with a variable
+ * number of output divisors.
+ *
+ *                       PLL+DIVs
+ *     ----------------------------------------------
+ *     |                                            |
+ *     |                                 |---[DIV1]--->> out1
+ * in ---[ 1/N ]---[ *M ]---[ *OD_FB ]---|    ....  |
+ *     |         ^               ^     ^ |---[DIV#]--->> out#
+ *     |         |               |     |            |
+ *     |---------------------------------------------
+ *               |               |     |
+ *              FREF             |    VCO
+ *                          optional
+ *
+ * For each divisor DIV# the output frequency is calculated as:
+ *
+ * out# = in# * M * OD_FB / N / DIV#
+ */
+
+#define PMASK(width)				((1U << (width)) - 1)
+#define SETPMASK(width, shift)			(PMASK(width) << (shift))
+#define CLRPMASK(width, shift)			(~(SETPMASK(width, shift)))
+#define PARM_GET(width, shift, reg)		(((reg) & SETPMASK(width, shift)) >> (shift))
+#define PARM_SET(width, shift, reg, val)	(((reg) & CLRPMASK(width, shift)) | (val << (shift)))
+
+#define MESON_FREF_MIN_MHZ			5
+#define MESON_FREF_MAX_MHZ			30
+
+struct meson_clk_pll {
+	struct clk_hw	hw;
+	void __iomem	*base;
+	struct pll_conf	*conf;
+	spinlock_t	*lock;
+};
+#define to_meson_clk_pll(_hw) container_of(_hw, struct meson_clk_pll, hw)
+
+static void meson_clk_pll_get_parms(struct meson_clk_pll *pll,
+				    unsigned long *rate, unsigned long p_rate,
+				    u16 *best_n, u16 *best_m, u16 *best_od_fb)
+{
+	unsigned long rate_mhz, p_rate_mhz;
+	unsigned long pll_vco_min_mhz, pll_vco_max_mhz;
+	unsigned long cur_rate_mhz, best_rate_mhz;
+	u16 m, m_min, m_max, m_mask;
+	u16 n, n_min, n_max, n_mask, _n_min, _n_max;
+	u16 od_fb, od_fb_max;
+
+	rate_mhz = *rate / 1000000;
+	p_rate_mhz = p_rate / 1000000;
+	pll_vco_min_mhz = pll->conf->vco_min_mhz;
+	pll_vco_max_mhz = pll->conf->vco_max_mhz;
+	best_rate_mhz = ULONG_MAX;
+	*best_n = 0;
+	*best_m = 0;
+	*best_od_fb = 1;
+
+	m_mask = PMASK(pll->conf->m.width);
+	n_mask = PMASK(pll->conf->n.width);
+
+	/* FREF = P_RATE / N */
+	n_min = max_t(u16, DIV_ROUND_UP(p_rate_mhz, MESON_FREF_MAX_MHZ), 1);
+	n_max = min_t(u16, p_rate_mhz / MESON_FREF_MIN_MHZ, n_mask);
+
+	od_fb_max = 1 << PMASK(pll->conf->od_fb.width);
+
+	for (od_fb = 1; od_fb <= od_fb_max; od_fb <<= 1) {
+
+		/* VCO = P_RATE * M * OD_FB / N */
+		m_min = max_t(u16, DIV_ROUND_UP(pll_vco_min_mhz,
+			      p_rate_mhz * od_fb) * n_min, 1);
+		m_max = min_t(u16, (pll_vco_max_mhz * n_max) /
+			      (p_rate_mhz * od_fb), m_mask);
+
+
+		for (m = m_min; m <= m_max; m++) {
+			_n_min = max_t(u16, n_min,
+				       DIV_ROUND_UP(p_rate_mhz * m * od_fb,
+				       pll_vco_max_mhz));
+			_n_max = min_t(u16, n_max,
+				       p_rate_mhz * m * od_fb / pll_vco_min_mhz);
+
+			for (n = _n_min; n <= _n_max; n++) {
+				cur_rate_mhz = p_rate_mhz * m * od_fb / n;
+
+				if (abs(cur_rate_mhz - rate_mhz) <
+				   abs(best_rate_mhz - rate_mhz)) {
+					best_rate_mhz = cur_rate_mhz;
+					*best_n = n;
+					*best_m = m;
+					*best_od_fb = od_fb;
+					if (best_rate_mhz == rate_mhz)
+						goto done;
+				}
+			}
+		}
+	}
+
+done:
+	*best_od_fb >>= 1;
+	*rate = best_rate_mhz * 1000000;
+	return;
+
+}
+
+static unsigned long meson_clk_pll_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct meson_clk_pll *pll = to_meson_clk_pll(hw);
+	struct parm *p_n, *p_m, *p_od_fb;
+	unsigned long parent_rate_mhz = parent_rate / 1000000;
+	unsigned long rate_mhz;
+	u16 n, m, od_fb = 1;
+	u32 reg_n, reg_m, reg_od_fb;
+
+	p_n = &pll->conf->n;
+	p_m = &pll->conf->m;
+	p_od_fb = &pll->conf->od_fb;
+
+	reg_n = readl(pll->base + p_n->reg_off);
+	n = PARM_GET(p_n->width, p_n->shift, reg_n);
+
+	reg_m = readl(pll->base + p_m->reg_off);
+	m = PARM_GET(p_m->width, p_m->shift, reg_m);
+
+	if (p_od_fb->width != MESON_PARM_NOT_APPLICABLE) {
+		reg_od_fb = readl(pll->base + p_od_fb->reg_off);
+		od_fb = PARM_GET(p_od_fb->width, p_od_fb->shift, reg_od_fb);
+		od_fb = 1 << od_fb;
+	}
+
+	rate_mhz = parent_rate_mhz * m * od_fb / n;
+
+	return rate_mhz * 1000000;
+}
+
+static long meson_clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long *parent_rate)
+{
+	struct meson_clk_pll *pll = to_meson_clk_pll(hw);
+	u16 m, n, od_fb;
+
+	meson_clk_pll_get_parms(pll, &rate, *parent_rate, &n, &m, &od_fb);
+	if (m == 0 || n == 0)
+		return -EINVAL;
+
+	return rate;
+}
+
+static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long parent_rate)
+{
+	struct meson_clk_pll *pll = to_meson_clk_pll(hw);
+	struct parm *p_n, *p_m, *p_od_fb;
+	unsigned long flags = 0;
+	u32 reg_n, reg_m, reg_od_fb;
+	u16 m, n, od_fb;
+
+	spin_lock_irqsave(pll->lock, flags);
+
+	if (parent_rate == 0 || rate == 0)
+		return -EINVAL;
+
+	meson_clk_pll_get_parms(pll, &rate, parent_rate, &n, &m, &od_fb);
+	if (m == 0 || n == 0)
+		return -EINVAL;
+
+	p_n = &pll->conf->n;
+	p_m = &pll->conf->m;
+	p_od_fb = &pll->conf->od_fb;
+
+	reg_n = readl(pll->base + p_n->reg_off);
+	reg_n = PARM_SET(p_n->width, p_n->shift, reg_n, n);
+	writel(reg_n, pll->base + p_n->reg_off);
+
+	reg_m = readl(pll->base + p_m->reg_off);
+	reg_m = PARM_SET(p_m->width, p_m->shift, reg_m, m);
+	writel(reg_m, pll->base + p_m->reg_off);
+
+	if (p_od_fb->width != MESON_PARM_NOT_APPLICABLE) {
+		reg_od_fb = readl(pll->base + p_od_fb->reg_off);
+		reg_od_fb = PARM_SET(p_od_fb->width, p_od_fb->shift, reg_od_fb,
+				     od_fb);
+		writel(reg_od_fb, pll->base + p_od_fb->reg_off);
+	}
+
+	spin_unlock_irqrestore(pll->lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops meson_clk_pll_ops = {
+	.recalc_rate	= meson_clk_pll_recalc_rate,
+	.round_rate	= meson_clk_pll_round_rate,
+	.set_rate	= meson_clk_pll_set_rate,
+};
+
+
+static struct clk * __init meson_clk_pll_setup(struct pll_div_conf *pll_div_conf,
+						void __iomem *reg_base,
+						spinlock_t *lock)
+{
+	struct clk *clk;
+	struct meson_clk_pll *pll;
+	struct clk_init_data init;
+	const char *parent_name = pll_div_conf->clk_parent;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base = reg_base + pll_div_conf->reg_off;
+	pll->lock = lock;
+	pll->conf = pll_div_conf->pll_conf;
+
+	init.name = pll_div_conf->pll_name;
+	init.ops = &meson_clk_pll_ops;
+	init.flags = pll_div_conf->flags;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	pll->hw.init = &init;
+
+	clk = clk_register(NULL, &pll->hw);
+	if (IS_ERR(clk))
+		kfree(pll);
+
+	return clk;
+}
+
+void __init meson_clk_register_pll_div(struct pll_div_conf *pll_div_conf,
+				       void __iomem *reg_base,
+				       spinlock_t *lock)
+{
+	struct clk *pclk, *clk;
+	struct div_conf *div;
+	void __iomem *div_base;
+	int d;
+
+	pclk = meson_clk_pll_setup(pll_div_conf, reg_base, lock);
+	if (IS_ERR(pclk)) {
+		pr_warn("%s: Unable to create %s clock\n", __func__,
+			pll_div_conf->pll_name);
+		return;
+	}
+
+	for (d = 0; d < MESON_DIVS_MAX; d++) {
+		div = &pll_div_conf->div[d];
+		div_base = reg_base + pll_div_conf->reg_off + div->od.reg_off;
+
+		if (div->clk_id == CLKID_UNUSED)
+			continue;
+
+		clk = clk_register_divider(NULL, div->clk_name,
+					   pll_div_conf->pll_name,
+					   div->flags, div_base,
+					   div->od.shift, div->od.width,
+					   CLK_DIVIDER_POWER_OF_TWO, lock);
+
+		if (IS_ERR(clk)) {
+			pr_warn("%s: Unable to create %s clock\n", __func__,
+				div->clk_name);
+			continue;
+		}
+
+		meson_clk_add_lookup(clk, div->clk_id);
+	}
+}
+
diff --git a/drivers/clk/meson/clkc.c b/drivers/clk/meson/clkc.c
new file mode 100644
index 0000000..02b409e
--- /dev/null
+++ b/drivers/clk/meson/clkc.c
@@ -0,0 +1,151 @@
+/*
+ * Copyright (c) 2014 Carlo Caione <carlo@caione.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
+#include <linux/slab.h>
+
+#include "clkc.h"
+
+static DEFINE_SPINLOCK(clk_lock);
+
+static struct clk **clks;
+static struct clk_onecell_data clk_data;
+
+void __init meson_clk_init(struct device_node *np, unsigned long nr_clks)
+{
+	clks = kcalloc(nr_clks, sizeof(struct clk *), GFP_KERNEL);
+	if (!clks)
+		pr_err("%s: could not allocate clock lookup table\n", __func__);
+
+	clk_data.clks = clks;
+	clk_data.clk_num = nr_clks;
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+}
+
+void meson_clk_add_lookup(struct clk *clk, unsigned int id)
+{
+	if (clks && id)
+		clks[id] = clk;
+}
+
+void __init meson_clk_register_pll_divs(struct pll_div_conf *pll_divs,
+					unsigned int nr_pll_divs,
+					void __iomem *pll_base)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr_pll_divs; i++)
+		meson_clk_register_pll_div(&pll_divs[i], pll_base, &clk_lock);
+}
+
+static struct clk __init *meson_clk_register_mux_div(struct clk_conf *clk_conf,
+						     void __iomem *clk_base)
+{
+	struct clk *clk;
+	struct clk_mux *mux = NULL;
+	struct clk_divider *div = NULL;
+	const struct clk_ops *mux_ops = NULL, *div_ops = NULL;
+	struct mux_div_conf *mux_div_conf = &clk_conf->conf.mux_div_conf;
+
+	if (clk_conf->num_parents > 1) {
+		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+		if (!mux)
+			return ERR_PTR(-ENOMEM);
+
+		mux->reg = clk_base + mux_div_conf->mux_parm.reg_off;
+		mux->shift = mux_div_conf->mux_parm.shift;
+		mux->mask = BIT(mux_div_conf->mux_parm.width) - 1;
+		mux->flags = mux_div_conf->mux_flags;
+		mux->lock = &clk_lock;
+		mux->table = mux_div_conf->mux_table;
+		mux_ops = (mux_div_conf->mux_flags & CLK_MUX_READ_ONLY) ?
+			  &clk_mux_ro_ops : &clk_mux_ops;
+	}
+
+	if (mux_div_conf->div_parm.width != MESON_PARM_NOT_APPLICABLE) {
+		div = kzalloc(sizeof(*div), GFP_KERNEL);
+		if (!div)
+			return ERR_PTR(-ENOMEM);
+
+		div->flags = mux_div_conf->div_flags;
+		div->reg = clk_base + mux_div_conf->div_parm.reg_off;
+		div->shift = mux_div_conf->div_parm.shift;
+		div->width = mux_div_conf->div_parm.width;
+		div->lock = &clk_lock;
+		div->table = mux_div_conf->div_table;
+		div_ops = (mux_div_conf->div_flags & CLK_DIVIDER_READ_ONLY) ?
+			  &clk_divider_ro_ops : &clk_divider_ops;
+	}
+
+	clk = clk_register_composite(NULL, clk_conf->clk_name,
+				    clk_conf->clks_parent,
+				    clk_conf->num_parents,
+				    mux ? &mux->hw : NULL, mux_ops,
+				    div ? &div->hw : NULL, div_ops,
+				    NULL, NULL, clk_conf->flags);
+
+	return clk;
+}
+
+void __init meson_clk_register_clks(struct clk_conf *clk_confs,
+				     unsigned int nr_confs,
+				     void __iomem *clk_base)
+{
+	unsigned int i;
+	struct clk *clk = NULL;
+
+	for (i = 0; i < nr_confs; i++) {
+		struct clk_conf *clk_conf = &clk_confs[i];
+
+		switch (clk_conf->clk_type) {
+		case clk_fixed_rate:
+			clk = clk_register_fixed_rate(NULL,
+					clk_conf->clk_name,
+					(clk_conf->num_parents) ?
+						clk_conf->clks_parent[0] : NULL,
+					clk_conf->flags,
+					clk_conf->conf.fixed_rate);
+			break;
+		case clk_fixed_factor:
+			clk = clk_register_fixed_factor(NULL,
+					clk_conf->clk_name,
+					clk_conf->clks_parent[0],
+					clk_conf->flags,
+					clk_conf->conf.fixed_fact_conf.mult,
+					clk_conf->conf.fixed_fact_conf.div);
+			break;
+		case clk_mux_div:
+			clk = meson_clk_register_mux_div(clk_conf, clk_base);
+			break;
+		}
+
+		if (!clk) {
+			pr_err("%s: unknown clock type %d\n", __func__,
+			       clk_conf->clk_type);
+			continue;
+		}
+
+		if (IS_ERR(clk)) {
+			pr_warn("%s: Unable to create %s clock\n", __func__,
+				clk_conf->clk_name);
+			continue;
+		}
+
+		meson_clk_add_lookup(clk, clk_conf->clk_id);
+	}
+}
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
new file mode 100644
index 0000000..6c0f611
--- /dev/null
+++ b/drivers/clk/meson/clkc.h
@@ -0,0 +1,159 @@
+/*
+ * Copyright (c) 2014 Carlo Caione <carlo@caione.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __CLKC_H
+#define __CLKC_H
+
+#include <linux/clk.h>
+
+#define MESON_DIVS_MAX			2
+#define MESON_DIVS_WIDTH		2
+#define MESON_PARM_NOT_APPLICABLE	0
+
+#define CLKID_UNUSED			0
+
+struct parm {
+	u16	reg_off;
+	u8	shift;
+	u8	width;
+};
+#define PARM(_r, _s, _w) { .reg_off = (_r), .shift = (_s), .width = (_w), }
+
+struct pll_conf {
+	unsigned long	vco_min_mhz;
+	unsigned long	vco_max_mhz;
+	struct parm	m;
+	struct parm	n;
+	struct parm	od_fb;
+};
+#define PLL_CONF3(_vmin, _vmax, _pm, _pn, _po)				\
+	{								\
+		.vco_min_mhz	= (_vmin),				\
+		.vco_max_mhz	= (_vmax),				\
+		.m		= _pm,					\
+		.n		= _pn,					\
+		.od_fb		= _po,					\
+	}
+
+#define PLL_CONF2(_vmin, _vmax, _pm, _pn)				\
+	{								\
+		.vco_min_mhz	= (_vmin),				\
+		.vco_max_mhz	= (_vmax),				\
+		.m		= _pm,					\
+		.n		= _pn,					\
+	}
+
+struct div_conf {
+	unsigned int	clk_id;
+	const char	*clk_name;
+	struct parm	od;
+	unsigned long	flags;
+};
+#define DIV_CONF(_name, _pod, _id, _f)					\
+	{								\
+		.clk_name	= (_name),				\
+		.od		= PARM(0x00, (_pod), MESON_DIVS_WIDTH),	\
+		.clk_id		= (_id),				\
+		.flags		= (_f),					\
+	}
+
+struct pll_div_conf {
+	u16		reg_off;
+	const char	*pll_name;
+	const char	*clk_parent;
+	unsigned long	flags;
+	struct pll_conf	*pll_conf;
+	struct div_conf	div[MESON_DIVS_MAX];
+};
+
+struct fixed_fact_conf {
+	unsigned int	div;
+	unsigned int	mult;
+};
+
+struct mux_div_conf {
+	u32			*mux_table;
+	u8			mux_flags;
+	struct clk_div_table	*div_table;
+
+	u8			div_flags;
+	struct parm		mux_parm;
+	struct parm		div_parm;
+};
+
+#define PNAME(x) static const char *x[] __initconst
+
+enum clk_type { clk_fixed_factor, clk_fixed_rate, clk_mux_div };
+
+struct clk_conf {
+	enum clk_type			clk_type;
+	unsigned int			clk_id;
+	const char			*clk_name;
+	const char			**clks_parent;
+	int				num_parents;
+	unsigned long			flags;
+	union {
+		struct fixed_fact_conf	fixed_fact_conf;
+		struct mux_div_conf	mux_div_conf;
+		unsigned long		fixed_rate;
+	} conf;
+};
+
+#define FIXED_ROOT(_id, _cn, _f, _r)					\
+	{								\
+		.clk_type		= clk_fixed_rate,		\
+		.clk_id			= (_id),			\
+		.clk_name		= (_cn),			\
+		.flags			= CLK_IS_ROOT | (_f),		\
+		.conf.fixed_rate	= (_r),				\
+	}
+
+#define FIXED_DIV(_id, _cn, _cp, _f, _div)				\
+	{								\
+		.clk_type			= clk_fixed_factor,	\
+		.clk_id				= (_id),		\
+		.clk_name			= (_cn),		\
+		.clks_parent			= (_cp),		\
+		.num_parents			= ARRAY_SIZE(_cp),	\
+		.flags				= (_f),			\
+		.conf.fixed_fact_conf.div	= (_div),		\
+		.conf.fixed_fact_conf.mult	= 1,			\
+	}
+
+#define MUX_DIV(_id, _cn, _cp, _f, _mt, _mp, _dp)			\
+	{								\
+		.clk_type			= clk_mux_div,		\
+		.clk_id				= (_id),		\
+		.clk_name			= (_cn),		\
+		.clks_parent			= (_cp),		\
+		.num_parents			= ARRAY_SIZE(_cp),	\
+		.flags				= (_f),			\
+		.conf.mux_div_conf.mux_table	= _mt,			\
+		.conf.mux_div_conf.mux_parm	= _mp,			\
+		.conf.mux_div_conf.div_parm	= _dp,			\
+	}
+
+
+void meson_clk_init(struct device_node *np, unsigned long nr_clks);
+void meson_clk_add_lookup(struct clk *clk, unsigned int id);
+void meson_clk_register_pll_divs(struct pll_div_conf *pll_divs,
+				 unsigned int nr_pll_divs,
+				 void __iomem *reg_base);
+void meson_clk_register_pll_div(struct pll_div_conf *pll_div_conf,
+				void __iomem *reg_base, spinlock_t *lock);
+void meson_clk_register_clks(struct clk_conf *clk_confs,
+			     unsigned int nr_confs,
+			     void __iomem *clk_base);
diff --git a/drivers/clk/meson/meson6-clkc.c b/drivers/clk/meson/meson6-clkc.c
new file mode 100644
index 0000000..9f809e1
--- /dev/null
+++ b/drivers/clk/meson/meson6-clkc.c
@@ -0,0 +1,160 @@
+/*
+ * Copyright (c) 2014 Carlo Caione <carlo@caione.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <dt-bindings/clock/meson6-clkc.h>
+
+#include "clkc.h"
+
+#define MESON6_REG_MPLL_FIXED	0x0280
+#define MESON6_REG_DPLL_SYS	0x0260
+#define MESON6_REG_DPLL_DDR	0x01a0
+#define MESON6_REG_DPLL_VID2	0x011c
+#define MESON6_REG_HPLL		0x0270
+#define MESON6_REG_HHI_MPEG	0x0174
+
+#define MESON6_XTAL		"xtal"
+
+static struct pll_conf dpll_conf = PLL_CONF2(750, 1512, PARM(0x00, 0, 9),
+							PARM(0x00, 9, 5));
+
+static struct pll_conf mpll_conf = PLL_CONF3(1000, 2000, PARM(0x00, 0, 9),
+							 PARM(0x00, 9, 5),
+							 PARM(0x0c, 4, 1));
+
+static struct pll_conf hpll_conf = PLL_CONF3(750, 1512, PARM(0x00, 0, 10),
+							PARM(0x00, 10, 5),
+							PARM(0x00, 20, 2));
+
+static struct pll_div_conf meson_pll_divs[] __initdata = {
+	{
+		.clk_parent	= MESON6_XTAL,
+		.reg_off	= MESON6_REG_DPLL_SYS,
+		.pll_name	= "vco_sys",
+		.pll_conf	= &dpll_conf,
+		.flags		= CLK_SET_RATE_PARENT,
+		.div		= {
+					DIV_CONF("dpll_sys", 16,
+						 CLKID_DPLL_SYS,
+						 CLK_SET_RATE_PARENT),
+		}
+	},
+	{
+		.clk_parent	= MESON6_XTAL,
+		.reg_off	= MESON6_REG_DPLL_DDR,
+		.pll_name	= "vco_ddr",
+		.pll_conf	= &dpll_conf,
+		.flags		= CLK_SET_RATE_PARENT,
+		.div		= {
+					DIV_CONF("dpll_ddr", 16,
+						 CLKID_DPLL_DDR,
+						 CLK_SET_RATE_PARENT),
+		}
+	},
+	{
+		.clk_parent	= MESON6_XTAL,
+		.reg_off	= MESON6_REG_DPLL_VID2,
+		.pll_name	= "vco_vid2",
+		.pll_conf	= &dpll_conf,
+		.flags		= CLK_SET_RATE_PARENT,
+		.div		= {
+					DIV_CONF("dpll_vid2", 16,
+						 CLKID_DPLL_VID2,
+						 CLK_SET_RATE_PARENT),
+		}
+	},
+	{
+		.clk_parent	= MESON6_XTAL,
+		.reg_off	= MESON6_REG_MPLL_FIXED,
+		.pll_name	= "vco_fixed",
+		.pll_conf	= &mpll_conf,
+		.flags		= CLK_SET_RATE_PARENT,
+		.div		= {
+					DIV_CONF("mpll_fixed", 16,
+						 CLKID_MPLL_FIXED,
+						 CLK_SET_RATE_PARENT),
+		}
+	},
+	{
+		.clk_parent	= MESON6_XTAL,
+		.reg_off	= MESON6_REG_HPLL,
+		.pll_name	= "vco_hpll",
+		.pll_conf	= &hpll_conf,
+		.flags		= CLK_SET_RATE_PARENT,
+		.div		= {
+					DIV_CONF("hpll_lvds", 16,
+						 CLKID_HPLL_LVDS,
+						 CLK_SET_RATE_PARENT),
+					DIV_CONF("hpll_hdmi", 18,
+						 CLKID_HPLL_HDMI,
+						 CLK_SET_RATE_PARENT),
+		}
+	},
+};
+
+PNAME(p_fclk_div) = { "mpll_fixed" };
+PNAME(p_clk81) = { "fclk_div2", "fclk_div3", "fclk_div5" };
+
+static u32 mux_table_clk81[] __initdata = { 5, 6, 7 };
+
+static struct clk_conf meson_clk_confs[] __initdata = {
+	FIXED_ROOT(CLKID_XTAL, MESON6_XTAL, 0, 0),
+	FIXED_ROOT(CLKID_RTC_XTAL, "rtc_xtal", 0, 32000),
+	FIXED_DIV(CLKID_FCLK_DIV2, "fclk_div2", p_fclk_div, 0, 2),
+	FIXED_DIV(CLKID_FCLK_DIV3, "fclk_div3", p_fclk_div, 0, 3),
+	FIXED_DIV(CLKID_FCLK_DIV5, "fclk_div5", p_fclk_div, 0, 5),
+	MUX_DIV(CLKID_CLK81, "clk81", p_clk81, 0, mux_table_clk81,
+		PARM(MESON6_REG_HHI_MPEG, 12, 3),
+		PARM(MESON6_REG_HHI_MPEG, 0, 7)),
+};
+
+static void __init meson_clkc_init(struct device_node *np)
+{
+	void __iomem *clk_base;
+	u32 xtal_rate;
+
+	/* XTAL */
+	clk_base = of_iomap(np, 0);
+	if (!clk_base) {
+		pr_err("%s: Unable to map xtal base\n", __func__);
+		return;
+	}
+
+	xtal_rate = readl(clk_base) >> 4 & 0x3f;
+	xtal_rate *= 1000000;
+	meson_clk_confs[0].conf.fixed_rate = xtal_rate;
+	iounmap(clk_base);
+
+	/*  Generic clocks and PLLs */
+	clk_base = of_iomap(np, 1);
+	if (!clk_base) {
+		pr_err("%s: Unable to map clk base\n", __func__);
+		return;
+	}
+
+	meson_clk_init(np, CLK_NR_CLKS);
+
+	meson_clk_register_clks(meson_clk_confs, ARRAY_SIZE(meson_clk_confs),
+				clk_base);
+	meson_clk_register_pll_divs(meson_pll_divs, ARRAY_SIZE(meson_pll_divs),
+				    clk_base);
+}
+CLK_OF_DECLARE(meson6_clock, "amlogic,meson6-clkc", meson_clkc_init);
diff --git a/include/dt-bindings/clock/meson6-clkc.h b/include/dt-bindings/clock/meson6-clkc.h
new file mode 100644
index 0000000..06efef3
--- /dev/null
+++ b/include/dt-bindings/clock/meson6-clkc.h
@@ -0,0 +1,18 @@
+/*
+ * Meson6 clock tree IDs
+ */
+
+#define CLKID_XTAL		1
+#define CLKID_RTC_XTAL		2
+#define CLKID_DPLL_SYS		3
+#define CLKID_DPLL_DDR		4
+#define CLKID_DPLL_VID2		5
+#define CLKID_MPLL_FIXED	6
+#define CLKID_HPLL_HDMI		7
+#define CLKID_HPLL_LVDS		8
+#define CLKID_FCLK_DIV2		9
+#define CLKID_FCLK_DIV3		10
+#define CLKID_FCLK_DIV5		11
+#define CLKID_CLK81		12
+
+#define CLK_NR_CLKS		(CLKID_CLK81 + 1)
-- 
1.9.1
