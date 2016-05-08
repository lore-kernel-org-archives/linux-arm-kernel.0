From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  8 May 2016 22:01:45 +0200
Subject: [PATCH 10/16] clk: sunxi-ng: Add M-P factor clock support
In-Reply-To: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1462737711-10017-11-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce support for the clocks that combine a linear divider and a
power-of-two based one.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/Makefile |   1 +
 drivers/clk/sunxi-ng/ccu_mp.c | 158 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_mp.h |  79 +++++++++++++++++++++
 3 files changed, 238 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_mp.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_mp.h

diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 063c50f35ad4..09fce7467784 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -5,6 +5,7 @@ obj-y += ccu_div_table.o
 obj-y += ccu_fixed_factor.o
 obj-y += ccu_gate.o
 obj-y += ccu_m.o
+obj-y += ccu_mp.o
 obj-y += ccu_mux.o
 obj-y += ccu_p.o
 obj-y += ccu_phase.o
diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
new file mode 100644
index 000000000000..7181188deba7
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -0,0 +1,158 @@
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
+
+#include "ccu_gate.h"
+#include "ccu_mp.h"
+
+static void ccu_mp_find_best(unsigned long parent, unsigned long rate,
+			     unsigned int max_m, unsigned int max_p,
+			     unsigned int *m, unsigned int *p)
+{
+	unsigned long best_rate = 0;
+	unsigned int best_m = 0, best_p = 0;
+	unsigned int _m, _p;
+
+	for (_p = 0; _p <= max_p; _p++) {
+		for (_m = 1; _m <= max_m; _m++) {
+			unsigned long tmp_rate = (parent >> _p) / _m;
+
+			if (tmp_rate > rate)
+				continue;
+
+			if ((rate - tmp_rate) < (rate - best_rate)) {
+				best_rate = tmp_rate;
+				best_m = _m;
+				best_p = _p;
+			}
+		}
+	}
+
+	*m = best_m;
+	*p = best_p;
+}
+
+static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
+				       unsigned long parent_rate,
+				       unsigned long rate,
+				       void *data)
+{
+	struct ccu_mp *cmp = data;
+	unsigned int m, p;
+
+	ccu_mp_find_best(parent_rate, rate,
+			 1 << cmp->m.width, (1 << cmp->p.width) - 1,
+			 &m, &p);
+
+	return (parent_rate >> p) / m;
+}
+
+static void ccu_mp_disable(struct clk_hw *hw)
+{
+	struct ccu_mp *cmp = hw_to_ccu_mp(hw);
+
+	return ccu_gate_helper_disable(&cmp->common, cmp->enable);
+}
+
+static int ccu_mp_enable(struct clk_hw *hw)
+{
+	struct ccu_mp *cmp = hw_to_ccu_mp(hw);
+
+	return ccu_gate_helper_enable(&cmp->common, cmp->enable);
+}
+
+static int ccu_mp_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_mp *cmp = hw_to_ccu_mp(hw);
+
+	return ccu_gate_helper_is_enabled(&cmp->common, cmp->enable);
+}
+
+static unsigned long ccu_mp_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct ccu_mp *cmp = hw_to_ccu_mp(hw);
+	unsigned int m, p;
+	u32 reg;
+
+	reg = readl(cmp->common.base + cmp->common.reg);
+
+	m = reg >> cmp->m.shift;
+	m &= (1 << cmp->m.width) - 1;
+
+	p = reg >> cmp->p.shift;
+	p &= (1 << cmp->p.width) - 1;
+
+	return (parent_rate >> p) / (m + 1);
+}
+
+static int ccu_mp_determine_rate(struct clk_hw *hw,
+				 struct clk_rate_request *req)
+{
+	struct ccu_mp *cmp = hw_to_ccu_mp(hw);
+
+	return ccu_mux_helper_determine_rate(&cmp->common, &cmp->mux,
+					     req, ccu_mp_round_rate, cmp);
+}
+
+static int ccu_mp_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long parent_rate)
+{
+	struct ccu_mp *cmp = hw_to_ccu_mp(hw);
+	unsigned long flags;
+	unsigned int m, p;
+	u32 reg;
+
+	ccu_mp_find_best(parent_rate, rate,
+			 1 << cmp->m.width, (1 << cmp->p.width) - 1,
+			 &m, &p);
+
+
+	spin_lock_irqsave(cmp->common.lock, flags);
+
+	reg = readl(cmp->common.base + cmp->common.reg);
+	reg &= ~GENMASK(cmp->m.width + cmp->m.shift, cmp->m.shift);
+	reg &= ~GENMASK(cmp->p.width + cmp->p.shift, cmp->p.shift);
+
+	writel(reg | (p << cmp->p.shift) | ((m - 1) << cmp->m.shift),
+	       cmp->common.base + cmp->common.reg);
+
+	spin_unlock_irqrestore(cmp->common.lock, flags);
+
+	return 0;
+}
+
+static u8 ccu_mp_get_parent(struct clk_hw *hw)
+{
+	struct ccu_mp *cmp = hw_to_ccu_mp(hw);
+
+	return ccu_mux_helper_get_parent(&cmp->common, &cmp->mux);
+}
+
+static int ccu_mp_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct ccu_mp *cmp = hw_to_ccu_mp(hw);
+
+	return ccu_mux_helper_set_parent(&cmp->common, &cmp->mux, index);
+}
+
+const struct clk_ops ccu_mp_ops = {
+	.disable	= ccu_mp_disable,
+	.enable		= ccu_mp_enable,
+	.is_enabled	= ccu_mp_is_enabled,
+
+	.get_parent	= ccu_mp_get_parent,
+	.set_parent	= ccu_mp_set_parent,
+
+	.determine_rate	= ccu_mp_determine_rate,
+	.recalc_rate	= ccu_mp_recalc_rate,
+	.set_rate	= ccu_mp_set_rate,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_mp.h b/drivers/clk/sunxi-ng/ccu_mp.h
new file mode 100644
index 000000000000..95da9c46cd4f
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_mp.h
@@ -0,0 +1,79 @@
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
+#ifndef _CCU_MP_H_
+#define _CCU_MP_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+#include "ccu_factor.h"
+#include "ccu_mux.h"
+
+struct ccu_mp {
+	u32			enable;
+
+	struct ccu_factor	m;
+	struct ccu_factor	p;
+	struct ccu_mux_internal	mux;
+	struct ccu_common	common;
+};
+
+#define SUNXI_CCU_MP_WITH_MUX(_struct, _name, _parents, _reg,		\
+			      _mshift, _mwidth,				\
+			      _pshift, _pwidth,				\
+			      _muxshift, _muxwidth,			\
+			      _flags)					\
+	struct ccu_mp _struct = {					\
+		.m	= SUNXI_CLK_FACTOR(_mshift, _mwidth),		\
+		.p	= SUNXI_CLK_FACTOR(_pshift, _pwidth),		\
+		.mux	= SUNXI_CLK_MUX(_muxshift, _muxwidth),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= SUNXI_HW_INIT_PARENTS(_name,	\
+								_parents, \
+								&ccu_mp_ops, \
+								_flags), \
+		}							\
+	}
+
+#define SUNXI_CCU_MP_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
+				   _mshift, _mwidth,			\
+				   _pshift, _pwidth,			\
+				   _muxshift, _muxwidth,		\
+				   _gate, _flags)			\
+	struct ccu_mp _struct = {					\
+		.enable	= _gate,					\
+		.m	= SUNXI_CLK_FACTOR(_mshift, _mwidth),		\
+		.p	= SUNXI_CLK_FACTOR(_pshift, _pwidth),		\
+		.mux	= SUNXI_CLK_MUX(_muxshift, _muxwidth),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.features	= CCU_FEATURE_GATE,		\
+			.hw.init	= SUNXI_HW_INIT_PARENTS(_name,	\
+								_parents, \
+								&ccu_mp_ops, \
+								_flags), \
+		}							\
+	}
+
+static inline struct ccu_mp *hw_to_ccu_mp(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_mp, common);
+}
+
+extern const struct clk_ops ccu_mp_ops;
+
+#endif /* _CCU_MP_H_ */
-- 
2.8.2
