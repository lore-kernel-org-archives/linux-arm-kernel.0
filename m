From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Jun 2016 21:05:32 +0200
Subject: [PATCH v3 11/14] clk: sunxi-ng: Add N-K-M Factor clock
In-Reply-To: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
References: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
Message-ID: <20160629190535.11855-12-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce support for clocks that multiply and divide using two linear
multipliers and one linear divider.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/Kconfig   |   5 ++
 drivers/clk/sunxi-ng/Makefile  |   1 +
 drivers/clk/sunxi-ng/ccu_nkm.c | 153 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_nkm.h |  68 ++++++++++++++++++
 4 files changed, 227 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_nkm.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_nkm.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index d8a5da270778..4c571b86bfd1 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -28,6 +28,11 @@ config SUNXI_CCU_NK
 	bool
 	select SUNXI_CCU_GATE
 
+config SUNXI_CCU_NKM
+	bool
+	select RATIONAL
+	select SUNXI_CCU_GATE
+
 config SUNXI_CCU_NM
 	bool
 	select RATIONAL
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 7d2cd2a47a39..2d6fdca0d3cc 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -11,5 +11,6 @@ obj-$(CONFIG_SUNXI_CCU_PHASE)	+= ccu_phase.o
 
 # Multi-factor clocks
 obj-$(CONFIG_SUNXI_CCU_NK)	+= ccu_nk.o
+obj-$(CONFIG_SUNXI_CCU_NKM)	+= ccu_nkm.o
 obj-$(CONFIG_SUNXI_CCU_NM)	+= ccu_nm.o
 obj-$(CONFIG_SUNXI_CCU_MP)	+= ccu_mp.o
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
new file mode 100644
index 000000000000..2071822b1e9c
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -0,0 +1,153 @@
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
+#include "ccu_nkm.h"
+
+struct _ccu_nkm {
+	unsigned long	n, max_n;
+	unsigned long	k, max_k;
+	unsigned long	m, max_m;
+};
+
+static void ccu_nkm_find_best(unsigned long parent, unsigned long rate,
+			      struct _ccu_nkm *nkm)
+{
+	unsigned long best_rate = 0;
+	unsigned long best_n = 0, best_k = 0, best_m = 0;
+	unsigned long _n, _k, _m;
+
+	for (_k = 1; _k <= nkm->max_k; _k++) {
+		unsigned long tmp_rate;
+
+		rational_best_approximation(rate / _k, parent,
+					    nkm->max_n, nkm->max_m, &_n, &_m);
+
+		tmp_rate = parent * _n * _k / _m;
+
+		if (tmp_rate > rate)
+			continue;
+
+		if ((rate - tmp_rate) < (rate - best_rate)) {
+			best_rate = tmp_rate;
+			best_n = _n;
+			best_k = _k;
+			best_m = _m;
+		}
+	}
+
+	nkm->n = best_n;
+	nkm->k = best_k;
+	nkm->m = best_m;
+}
+
+static void ccu_nkm_disable(struct clk_hw *hw)
+{
+	struct ccu_nkm *nkm = hw_to_ccu_nkm(hw);
+
+	return ccu_gate_helper_disable(&nkm->common, nkm->enable);
+}
+
+static int ccu_nkm_enable(struct clk_hw *hw)
+{
+	struct ccu_nkm *nkm = hw_to_ccu_nkm(hw);
+
+	return ccu_gate_helper_enable(&nkm->common, nkm->enable);
+}
+
+static int ccu_nkm_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_nkm *nkm = hw_to_ccu_nkm(hw);
+
+	return ccu_gate_helper_is_enabled(&nkm->common, nkm->enable);
+}
+
+static unsigned long ccu_nkm_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct ccu_nkm *nkm = hw_to_ccu_nkm(hw);
+	unsigned long n, m, k;
+	u32 reg;
+
+	reg = readl(nkm->common.base + nkm->common.reg);
+
+	n = reg >> nkm->n.shift;
+	n &= (1 << nkm->n.width) - 1;
+
+	k = reg >> nkm->k.shift;
+	k &= (1 << nkm->k.width) - 1;
+
+	m = reg >> nkm->m.shift;
+	m &= (1 << nkm->m.width) - 1;
+
+	return parent_rate * (n + 1) * (k + 1) / (m + 1);
+}
+
+static long ccu_nkm_round_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long *parent_rate)
+{
+	struct ccu_nkm *nkm = hw_to_ccu_nkm(hw);
+	struct _ccu_nkm _nkm;
+
+	_nkm.max_n = 1 << nkm->n.width;
+	_nkm.max_k = 1 << nkm->k.width;
+	_nkm.max_m = 1 << nkm->m.width;
+
+	ccu_nkm_find_best(*parent_rate, rate, &_nkm);
+
+	return *parent_rate * _nkm.n * _nkm.k / _nkm.m;
+}
+
+static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long parent_rate)
+{
+	struct ccu_nkm *nkm = hw_to_ccu_nkm(hw);
+	struct _ccu_nkm _nkm;
+	unsigned long flags;
+	u32 reg;
+
+	_nkm.max_n = 1 << nkm->n.width;
+	_nkm.max_k = 1 << nkm->k.width;
+	_nkm.max_m = 1 << nkm->m.width;
+
+	ccu_nkm_find_best(parent_rate, rate, &_nkm);
+
+	spin_lock_irqsave(nkm->common.lock, flags);
+
+	reg = readl(nkm->common.base + nkm->common.reg);
+	reg &= ~GENMASK(nkm->n.width + nkm->n.shift - 1, nkm->n.shift);
+	reg &= ~GENMASK(nkm->k.width + nkm->k.shift - 1, nkm->k.shift);
+	reg &= ~GENMASK(nkm->m.width + nkm->m.shift - 1, nkm->m.shift);
+
+	reg |= (_nkm.n - 1) << nkm->n.shift;
+	reg |= (_nkm.k - 1) << nkm->k.shift;
+	reg |= (_nkm.m - 1) << nkm->m.shift;
+
+	writel(reg, nkm->common.base + nkm->common.reg);
+
+	spin_unlock_irqrestore(nkm->common.lock, flags);
+
+	ccu_helper_wait_for_lock(&nkm->common, nkm->lock);
+
+	return 0;
+}
+
+const struct clk_ops ccu_nkm_ops = {
+	.disable	= ccu_nkm_disable,
+	.enable		= ccu_nkm_enable,
+	.is_enabled	= ccu_nkm_is_enabled,
+
+	.recalc_rate	= ccu_nkm_recalc_rate,
+	.round_rate	= ccu_nkm_round_rate,
+	.set_rate	= ccu_nkm_set_rate,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
new file mode 100644
index 000000000000..1936ac1c6b37
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_nkm.h
@@ -0,0 +1,68 @@
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
+#ifndef _CCU_NKM_H_
+#define _CCU_NKM_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+#include "ccu_div.h"
+#include "ccu_mult.h"
+
+/*
+ * struct ccu_nkm - Definition of an N-K-M clock
+ *
+ * Clocks based on the formula parent * N * K / M
+ */
+struct ccu_nkm {
+	u32			enable;
+	u32			lock;
+
+	struct _ccu_mult	n;
+	struct _ccu_mult	k;
+	struct _ccu_div		m;
+
+	struct ccu_common	common;
+};
+
+#define SUNXI_CCU_NKM_WITH_GATE_LOCK(_struct, _name, _parent, _reg,	\
+				     _nshift, _nwidth,			\
+				     _kshift, _kwidth,			\
+				     _mshift, _mwidth,			\
+				     _gate, _lock, _flags)		\
+	struct ccu_nkm _struct = {					\
+		.enable		= _gate,				\
+		.lock		= _lock,				\
+		.k		= _SUNXI_CCU_MULT(_kshift, _kwidth),	\
+		.n		= _SUNXI_CCU_MULT(_nshift, _nwidth),	\
+		.m		= _SUNXI_CCU_DIV(_mshift, _mwidth),	\
+		.common		= {					\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_nkm_ops,	\
+						      _flags),		\
+		},							\
+	}
+
+static inline struct ccu_nkm *hw_to_ccu_nkm(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_nkm, common);
+}
+
+extern const struct clk_ops ccu_nkm_ops;
+
+#endif /* _CCU_NKM_H_ */
-- 
2.9.0
