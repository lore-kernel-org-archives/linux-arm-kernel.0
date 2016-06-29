From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Jun 2016 21:05:33 +0200
Subject: [PATCH v3 12/14] clk: sunxi-ng: Add N-K-M-P factor clock
In-Reply-To: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
References: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
Message-ID: <20160629190535.11855-13-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce support for clocks that use a combination of two linear
multipliers (N and K factors), one linear divider (M) and one power of two
divider (P).

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/Kconfig    |   5 ++
 drivers/clk/sunxi-ng/Makefile   |   1 +
 drivers/clk/sunxi-ng/ccu_nkmp.c | 167 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_nkmp.h |  71 +++++++++++++++++
 4 files changed, 244 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_nkmp.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_nkmp.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 4c571b86bfd1..24fc9e4cc546 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -33,6 +33,11 @@ config SUNXI_CCU_NKM
 	select RATIONAL
 	select SUNXI_CCU_GATE
 
+config SUNXI_CCU_NKMP
+	bool
+	select RATIONAL
+	select SUNXI_CCU_GATE
+
 config SUNXI_CCU_NM
 	bool
 	select RATIONAL
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 2d6fdca0d3cc..5c342cc698d2 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -12,5 +12,6 @@ obj-$(CONFIG_SUNXI_CCU_PHASE)	+= ccu_phase.o
 # Multi-factor clocks
 obj-$(CONFIG_SUNXI_CCU_NK)	+= ccu_nk.o
 obj-$(CONFIG_SUNXI_CCU_NKM)	+= ccu_nkm.o
+obj-$(CONFIG_SUNXI_CCU_NKMP)	+= ccu_nkmp.o
 obj-$(CONFIG_SUNXI_CCU_NM)	+= ccu_nm.o
 obj-$(CONFIG_SUNXI_CCU_MP)	+= ccu_mp.o
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
new file mode 100644
index 000000000000..9f2b98e19dc9
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -0,0 +1,167 @@
+/*
+ * Copyright (C) 2016 Maxime Ripard
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/rational.h>
+
+#include "ccu_gate.h"
+#include "ccu_nkmp.h"
+
+struct _ccu_nkmp {
+	unsigned long	n, max_n;
+	unsigned long	k, max_k;
+	unsigned long	m, max_m;
+	unsigned long	p, max_p;
+};
+
+static void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
+			       struct _ccu_nkmp *nkmp)
+{
+	unsigned long best_rate = 0;
+	unsigned long best_n = 0, best_k = 0, best_m = 0, best_p = 0;
+	unsigned long _n, _k, _m, _p;
+
+	for (_k = 1; _k <= nkmp->max_k; _k++) {
+		for (_p = 0; _p <= nkmp->max_p; _p++) {
+			unsigned long tmp_rate;
+
+			rational_best_approximation(rate / _k, parent >> _p,
+						    nkmp->max_n, nkmp->max_m,
+						    &_n, &_m);
+
+			tmp_rate = (parent * _n * _k >> _p) / _m;
+
+			if (tmp_rate > rate)
+				continue;
+
+			if ((rate - tmp_rate) < (rate - best_rate)) {
+				best_rate = tmp_rate;
+				best_n = _n;
+				best_k = _k;
+				best_m = _m;
+				best_p = _p;
+			}
+		}
+	}
+
+	nkmp->n = best_n;
+	nkmp->k = best_k;
+	nkmp->m = best_m;
+	nkmp->p = best_p;
+}
+
+static void ccu_nkmp_disable(struct clk_hw *hw)
+{
+	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
+
+	return ccu_gate_helper_disable(&nkmp->common, nkmp->enable);
+}
+
+static int ccu_nkmp_enable(struct clk_hw *hw)
+{
+	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
+
+	return ccu_gate_helper_enable(&nkmp->common, nkmp->enable);
+}
+
+static int ccu_nkmp_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
+
+	return ccu_gate_helper_is_enabled(&nkmp->common, nkmp->enable);
+}
+
+static unsigned long ccu_nkmp_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
+	unsigned long n, m, k, p;
+	u32 reg;
+
+	reg = readl(nkmp->common.base + nkmp->common.reg);
+
+	n = reg >> nkmp->n.shift;
+	n &= (1 << nkmp->n.width) - 1;
+
+	k = reg >> nkmp->k.shift;
+	k &= (1 << nkmp->k.width) - 1;
+
+	m = reg >> nkmp->m.shift;
+	m &= (1 << nkmp->m.width) - 1;
+
+	p = reg >> nkmp->p.shift;
+	p &= (1 << nkmp->p.width) - 1;
+
+	return (parent_rate * (n + 1) * (k + 1) >> p) / (m + 1);
+}
+
+static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long *parent_rate)
+{
+	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
+	struct _ccu_nkmp _nkmp;
+
+	_nkmp.max_n = 1 << nkmp->n.width;
+	_nkmp.max_k = 1 << nkmp->k.width;
+	_nkmp.max_m = 1 << nkmp->m.width;
+	_nkmp.max_p = (1 << nkmp->p.width) - 1;
+
+	ccu_nkmp_find_best(*parent_rate, rate,
+			   &_nkmp);
+
+	return (*parent_rate * _nkmp.n * _nkmp.k >> _nkmp.p) / _nkmp.m;
+}
+
+static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long parent_rate)
+{
+	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
+	struct _ccu_nkmp _nkmp;
+	unsigned long flags;
+	u32 reg;
+
+	_nkmp.max_n = 1 << nkmp->n.width;
+	_nkmp.max_k = 1 << nkmp->k.width;
+	_nkmp.max_m = 1 << nkmp->m.width;
+	_nkmp.max_p = (1 << nkmp->p.width) - 1;
+
+	ccu_nkmp_find_best(parent_rate, rate, &_nkmp);
+
+	spin_lock_irqsave(nkmp->common.lock, flags);
+
+	reg = readl(nkmp->common.base + nkmp->common.reg);
+	reg &= ~GENMASK(nkmp->n.width + nkmp->n.shift - 1, nkmp->n.shift);
+	reg &= ~GENMASK(nkmp->k.width + nkmp->k.shift - 1, nkmp->k.shift);
+	reg &= ~GENMASK(nkmp->m.width + nkmp->m.shift - 1, nkmp->m.shift);
+	reg &= ~GENMASK(nkmp->p.width + nkmp->p.shift - 1, nkmp->p.shift);
+
+	reg |= (_nkmp.n - 1) << nkmp->n.shift;
+	reg |= (_nkmp.k - 1) << nkmp->k.shift;
+	reg |= (_nkmp.m - 1) << nkmp->m.shift;
+	reg |= _nkmp.p << nkmp->p.shift;
+
+	writel(reg, nkmp->common.base + nkmp->common.reg);
+
+	spin_unlock_irqrestore(nkmp->common.lock, flags);
+
+	ccu_helper_wait_for_lock(&nkmp->common, nkmp->lock);
+
+	return 0;
+}
+
+const struct clk_ops ccu_nkmp_ops = {
+	.disable	= ccu_nkmp_disable,
+	.enable		= ccu_nkmp_enable,
+	.is_enabled	= ccu_nkmp_is_enabled,
+
+	.recalc_rate	= ccu_nkmp_recalc_rate,
+	.round_rate	= ccu_nkmp_round_rate,
+	.set_rate	= ccu_nkmp_set_rate,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.h b/drivers/clk/sunxi-ng/ccu_nkmp.h
new file mode 100644
index 000000000000..5adb0c92a614
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.h
@@ -0,0 +1,71 @@
+/*
+ * Copyright (c) 2016 Maxime Ripard. All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _CCU_NKMP_H_
+#define _CCU_NKMP_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+#include "ccu_div.h"
+#include "ccu_mult.h"
+
+/*
+ * struct ccu_nkmp - Definition of an N-K-M-P clock
+ *
+ * Clocks based on the formula parent * N * K >> P / M
+ */
+struct ccu_nkmp {
+	u32			enable;
+	u32			lock;
+
+	struct _ccu_mult	n;
+	struct _ccu_mult	k;
+	struct _ccu_div		m;
+	struct _ccu_div		p;
+
+	struct ccu_common	common;
+};
+
+#define SUNXI_CCU_NKMP_WITH_GATE_LOCK(_struct, _name, _parent, _reg,	\
+				      _nshift, _nwidth,			\
+				      _kshift, _kwidth,			\
+				      _mshift, _mwidth,			\
+				      _pshift, _pwidth,			\
+				      _gate, _lock, _flags)		\
+	struct ccu_nkmp _struct = {					\
+		.enable		= _gate,				\
+		.lock		= _lock,				\
+		.n		= _SUNXI_CCU_MULT(_nshift, _nwidth),	\
+		.k		= _SUNXI_CCU_MULT(_kshift, _kwidth),	\
+		.m		= _SUNXI_CCU_DIV(_mshift, _mwidth),	\
+		.p		= _SUNXI_CCU_DIV(_pshift, _pwidth),	\
+		.common		= {					\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_nkmp_ops,	\
+						      _flags),		\
+		},							\
+	}
+
+static inline struct ccu_nkmp *hw_to_ccu_nkmp(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_nkmp, common);
+}
+
+extern const struct clk_ops ccu_nkmp_ops;
+
+#endif /* _CCU_NKMP_H_ */
-- 
2.9.0
