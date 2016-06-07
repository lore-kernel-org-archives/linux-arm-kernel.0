From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  7 Jun 2016 22:41:49 +0200
Subject: [PATCH v2 10/15] clk: sunxi-ng: Add N-K-factor clock support
In-Reply-To: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
Message-ID: <20160607204154.31967-11-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce support for clocks that use a combination of two linear
multipliers.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/Makefile |   1 +
 drivers/clk/sunxi-ng/ccu_nk.c | 147 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_nk.h |  73 +++++++++++++++++++++
 3 files changed, 221 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_nk.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_nk.h

diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 2aeccdb26e3f..a201fad6b11d 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -8,4 +8,5 @@ obj-y += ccu_fixed_factor.o
 obj-y += ccu_gate.o
 obj-y += ccu_mp.o
 obj-y += ccu_mux.o
+obj-y += ccu_nk.o
 obj-y += ccu_phase.o
diff --git a/drivers/clk/sunxi-ng/ccu_nk.c b/drivers/clk/sunxi-ng/ccu_nk.c
new file mode 100644
index 000000000000..4470ffc8cf0d
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_nk.c
@@ -0,0 +1,147 @@
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
+#include "ccu_nk.h"
+
+void ccu_nk_find_best(unsigned long parent, unsigned long rate,
+		      unsigned int max_n, unsigned int max_k,
+		      unsigned int *n, unsigned int *k)
+{
+	unsigned long best_rate = 0;
+	unsigned int best_k = 0, best_n = 0;
+	unsigned int _k, _n;
+
+	for (_k = 1; _k <= max_k; _k++) {
+		for (_n = 1; _n <= max_n; _n++) {
+			unsigned long tmp_rate = parent * _n * _k;
+
+			if (tmp_rate > rate)
+				continue;
+
+			if ((rate - tmp_rate) < (rate - best_rate)) {
+				best_rate = tmp_rate;
+				best_k = _k;
+				best_n = _n;
+			}
+		}
+	}
+
+	*k = best_k;
+	*n = best_n;
+}
+
+static void ccu_nk_disable(struct clk_hw *hw)
+{
+	struct ccu_nk *nk = hw_to_ccu_nk(hw);
+
+	return ccu_gate_helper_disable(&nk->common, nk->enable);
+}
+
+static int ccu_nk_enable(struct clk_hw *hw)
+{
+	struct ccu_nk *nk = hw_to_ccu_nk(hw);
+
+	return ccu_gate_helper_enable(&nk->common, nk->enable);
+}
+
+static int ccu_nk_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_nk *nk = hw_to_ccu_nk(hw);
+
+	return ccu_gate_helper_is_enabled(&nk->common, nk->enable);
+}
+
+static unsigned long ccu_nk_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct ccu_nk *nk = hw_to_ccu_nk(hw);
+	unsigned long rate, n, k;
+	u32 reg;
+
+	reg = readl(nk->common.base + nk->common.reg);
+
+	n = reg >> nk->n.shift;
+	n &= (1 << nk->n.width) - 1;
+
+	k = reg >> nk->k.shift;
+	k &= (1 << nk->k.width) - 1;
+
+	rate = parent_rate * (n + 1) * (k + 1);
+
+	if (nk->common.features & CCU_FEATURE_FIXED_POSTDIV)
+		rate /= nk->fixed_post_div;
+
+	return rate;
+}
+
+static long ccu_nk_round_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long *parent_rate)
+{
+	struct ccu_nk *nk = hw_to_ccu_nk(hw);
+	unsigned int n, k;
+
+	if (nk->common.features & CCU_FEATURE_FIXED_POSTDIV)
+		rate *= nk->fixed_post_div;
+
+	ccu_nk_find_best(*parent_rate, rate,
+			 1 << nk->n.width, 1 << nk->k.width,
+			 &n, &k);
+
+	rate = *parent_rate * n * k;
+	if (nk->common.features & CCU_FEATURE_FIXED_POSTDIV)
+		rate = rate / nk->fixed_post_div;
+
+	return rate;
+}
+
+static int ccu_nk_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long parent_rate)
+{
+	struct ccu_nk *nk = hw_to_ccu_nk(hw);
+	unsigned long flags;
+	unsigned int n, k;
+	u32 reg;
+
+	if (nk->common.features & CCU_FEATURE_FIXED_POSTDIV)
+		rate = rate * nk->fixed_post_div;
+
+	ccu_nk_find_best(parent_rate, rate,
+			 1 << nk->n.width, 1 << nk->k.width,
+			 &n, &k);
+
+	spin_lock_irqsave(nk->common.lock, flags);
+
+	reg = readl(nk->common.base + nk->common.reg);
+	reg &= ~GENMASK(nk->n.width + nk->n.shift - 1, nk->n.shift);
+	reg &= ~GENMASK(nk->k.width + nk->k.shift - 1, nk->k.shift);
+
+	writel(reg | ((k - 1) << nk->k.shift) | ((n - 1) << nk->n.shift),
+	       nk->common.base + nk->common.reg);
+
+	spin_unlock_irqrestore(nk->common.lock, flags);
+
+	ccu_helper_wait_for_lock(&nk->common, nk->lock);
+
+	return 0;
+}
+
+const struct clk_ops ccu_nk_ops = {
+	.disable	= ccu_nk_disable,
+	.enable		= ccu_nk_enable,
+	.is_enabled	= ccu_nk_is_enabled,
+
+	.recalc_rate	= ccu_nk_recalc_rate,
+	.round_rate	= ccu_nk_round_rate,
+	.set_rate	= ccu_nk_set_rate,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_nk.h b/drivers/clk/sunxi-ng/ccu_nk.h
new file mode 100644
index 000000000000..d266dd85f04d
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_nk.h
@@ -0,0 +1,73 @@
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
+#ifndef _CCU_NK_H_
+#define _CCU_NK_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+#include "ccu_div.h"
+#include "ccu_mult.h"
+
+/*
+ * struct ccu_nk - Definition of an N-K clock
+ *
+ * Clocks based on the formula parent * N * K
+ */
+struct ccu_nk {
+	u16			reg;
+	u32			enable;
+	u32			lock;
+
+	struct _ccu_mult	n;
+	struct _ccu_mult	k;
+
+	unsigned int		fixed_post_div;
+
+	struct ccu_common	common;
+};
+
+#define SUNXI_CCU_NK_WITH_GATE_LOCK_POSTDIV(_struct, _name, _parent, _reg, \
+					    _nshift, _nwidth,		\
+					    _kshift, _kwidth,		\
+					    _gate, _lock, _postdiv,	\
+					    _flags)			\
+	struct ccu_nk _struct = {					\
+		.enable		= _gate,				\
+		.lock		= _lock,				\
+		.k		= _SUNXI_CCU_MULT(_kshift, _kwidth),	\
+		.n		= _SUNXI_CCU_MULT(_nshift, _nwidth),	\
+		.fixed_post_div	= _postdiv,				\
+		.common		= {					\
+			.reg		= _reg,				\
+			.features	= (CCU_FEATURE_GATE |		\
+					   CCU_FEATURE_PLL_LOCK |	\
+					   CCU_FEATURE_FIXED_POSTDIV),	\
+			.hw.init	= SUNXI_HW_INIT(_name,		\
+							_parent,	\
+							&ccu_nk_ops,	\
+							_flags),	\
+		},							\
+	}
+
+static inline struct ccu_nk *hw_to_ccu_nk(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_nk, common);
+}
+
+extern const struct clk_ops ccu_nk_ops;
+
+#endif /* _CCU_NK_H_ */
-- 
2.8.3
