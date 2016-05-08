From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  8 May 2016 22:01:49 +0200
Subject: [PATCH 14/16] clk: sunxi-ng: Add N-K-M-P factor clock
In-Reply-To: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1462737711-10017-15-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce support for clocks that use a combination of two linear
multipliers (N and K factors), one linear divider (M) and one power of two
divider (P).

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/Makefile   |   1 +
 drivers/clk/sunxi-ng/ccu_nkmp.c | 157 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_nkmp.h |  43 +++++++++++
 3 files changed, 201 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_nkmp.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_nkmp.h

diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 2bb8bc22e907..c794f57b6fb1 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -9,6 +9,7 @@ obj-y += ccu_mp.o
 obj-y += ccu_mux.o
 obj-y += ccu_nk.o
 obj-y += ccu_nkm.o
+obj-y += ccu_nkmp.o
 obj-y += ccu_nm.o
 obj-y += ccu_p.o
 obj-y += ccu_phase.o
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
new file mode 100644
index 000000000000..b7da00773cd6
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -0,0 +1,157 @@
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
+void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
+			unsigned long max_n, unsigned long max_k,
+			unsigned long max_m, unsigned long max_p,
+			unsigned long *n, unsigned long *k,
+			unsigned long *m, unsigned long *p)
+{
+	unsigned long best_rate = 0;
+	unsigned long best_n = 0, best_k = 0, best_m = 0, best_p = 0;
+	unsigned long _n, _k, _m, _p;
+
+	for (_k = 1; _k <= max_k; _k++) {
+		for (_p = 0; _p <= max_p; _p++) {
+			unsigned long tmp_rate;
+
+			rational_best_approximation(rate / _k, parent << _p,
+						    max_n, max_m, &_n, &_m);
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
+	*n = best_n;
+	*k = best_k;
+	*m = best_m;
+	*p = best_p;
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
+	unsigned long n, k, m, p;
+
+	ccu_nkmp_find_best(*parent_rate, rate,
+			   1 << nkmp->n.width, 1 << nkmp->k.width,
+			   1 << nkmp->m.width, (1 << nkmp->p.width) - 1,
+			   &n, &k, &m, &p);
+
+	return (*parent_rate * n * k >> p) / m;
+}
+
+static int ccu_nkmp_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long parent_rate)
+{
+	struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
+	unsigned long n, k, m, p;
+	unsigned long flags;
+	u32 reg;
+
+	ccu_nkmp_find_best(parent_rate, rate,
+			   1 << nkmp->n.width, 1 << nkmp->k.width,
+			   1 << nkmp->m.width, (1 << nkmp->p.width) - 1,
+			   &n, &k, &m, &p);
+
+	spin_lock_irqsave(nkmp->common.lock, flags);
+
+	reg = readl(nkmp->common.base + nkmp->common.reg);
+	reg &= ~GENMASK(nkmp->n.width + nkmp->n.shift, nkmp->n.shift);
+	reg &= ~GENMASK(nkmp->k.width + nkmp->k.shift, nkmp->k.shift);
+	reg &= ~GENMASK(nkmp->m.width + nkmp->m.shift, nkmp->m.shift);
+	reg &= ~GENMASK(nkmp->p.width + nkmp->p.shift, nkmp->p.shift);
+
+	reg |= (n - 1) << nkmp->m.shift;
+	reg |= (k - 1) << nkmp->m.shift;
+	reg |= (m - 1) << nkmp->m.shift;
+	reg |= p << nkmp->p.shift;
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
index 000000000000..8a91f2c837a4
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.h
@@ -0,0 +1,43 @@
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
+#include "ccu_factor.h"
+#include "ccu_common.h"
+
+struct ccu_nkmp {
+	u32			enable;
+	u32			lock;
+
+	struct ccu_factor	n;
+	struct ccu_factor	k;
+	struct ccu_factor	m;
+	struct ccu_factor	p;
+
+	struct ccu_common	common;
+};
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
2.8.2
