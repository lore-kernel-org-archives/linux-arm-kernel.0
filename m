From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  8 May 2016 22:01:44 +0200
Subject: [PATCH 09/16] clk: sunxi-ng: Add P-factor clock support
In-Reply-To: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1462737711-10017-10-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce support for clocks that divide using a power of two factor.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/Makefile |   1 +
 drivers/clk/sunxi-ng/ccu_p.c  | 141 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_p.h  |  40 ++++++++++++
 3 files changed, 182 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_p.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_p.h

diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index f41de901c607..063c50f35ad4 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -6,4 +6,5 @@ obj-y += ccu_fixed_factor.o
 obj-y += ccu_gate.o
 obj-y += ccu_m.o
 obj-y += ccu_mux.o
+obj-y += ccu_p.o
 obj-y += ccu_phase.o
diff --git a/drivers/clk/sunxi-ng/ccu_p.c b/drivers/clk/sunxi-ng/ccu_p.c
new file mode 100644
index 000000000000..4d4dbd35cead
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_p.c
@@ -0,0 +1,141 @@
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
+#include "ccu_p.h"
+
+static void ccu_p_find_best(unsigned long parent, unsigned long rate,
+			    unsigned int max_p, unsigned int *p)
+{
+	unsigned int div, _p;
+
+	div = DIV_ROUND_UP(parent, rate);
+	_p = __roundup_pow_of_two(div);
+
+	if (_p > max_p)
+		_p = max_p;
+
+	*p = _p;
+}
+
+static unsigned long ccu_p_round_rate(struct ccu_mux_internal *mux,
+				       unsigned long parent_rate,
+				       unsigned long rate,
+				       void *data)
+{
+	struct ccu_p *cp = data;
+	unsigned int p;
+
+	ccu_p_find_best(parent_rate, rate, (1 << cp->p.width) - 1, &p);
+
+	return parent_rate >> p;
+}
+
+static void ccu_p_disable(struct clk_hw *hw)
+{
+	struct ccu_p *cp = hw_to_ccu_p(hw);
+
+	return ccu_gate_helper_disable(&cp->common, cp->enable);
+}
+
+static int ccu_p_enable(struct clk_hw *hw)
+{
+	struct ccu_p *cp = hw_to_ccu_p(hw);
+
+	return ccu_gate_helper_enable(&cp->common, cp->enable);
+}
+
+static int ccu_p_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_p *cp = hw_to_ccu_p(hw);
+
+	return ccu_gate_helper_is_enabled(&cp->common, cp->enable);
+}
+
+static unsigned long ccu_p_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct ccu_p *cp = hw_to_ccu_p(hw);
+	unsigned long p;
+	u32 reg;
+
+	reg = readl(cp->common.base + cp->common.reg);
+	p = reg >> cp->p.shift;
+	p &= (1 << cp->p.width) - 1;
+
+	ccu_mux_helper_adjust_parent_for_prediv(&cp->common, &cp->mux, -1,
+						&parent_rate);
+
+	return parent_rate >> p;
+}
+
+static int ccu_p_determine_rate(struct clk_hw *hw,
+				struct clk_rate_request *req)
+{
+	struct ccu_p *cp = hw_to_ccu_p(hw);
+
+	return ccu_mux_helper_determine_rate(&cp->common, &cp->mux,
+					     req, ccu_p_round_rate, cp);
+}
+
+static int ccu_p_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long parent_rate)
+{
+	struct ccu_p *cp = hw_to_ccu_p(hw);
+	unsigned long flags;
+	unsigned int p;
+	u32 reg;
+
+	ccu_mux_helper_adjust_parent_for_prediv(&cp->common, &cp->mux, -1,
+						&parent_rate);
+
+	ccu_p_find_best(parent_rate, rate, (1 << cp->p.width) - 1, &p);
+
+	spin_lock_irqsave(cp->common.lock, flags);
+
+	reg = readl(cp->common.base + cp->common.reg);
+	reg &= ~GENMASK(cp->p.width + cp->p.shift, cp->p.shift);
+
+	writel(reg | (p << cp->p.shift),
+	       cp->common.base + cp->common.reg);
+
+	spin_unlock_irqrestore(cp->common.lock, flags);
+
+	return 0;
+}
+
+static u8 ccu_p_get_parent(struct clk_hw *hw)
+{
+	struct ccu_p *cp = hw_to_ccu_p(hw);
+
+	return ccu_mux_helper_get_parent(&cp->common, &cp->mux);
+}
+
+static int ccu_p_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct ccu_p *cp = hw_to_ccu_p(hw);
+
+	return ccu_mux_helper_set_parent(&cp->common, &cp->mux, index);
+}
+
+const struct clk_ops ccu_p_ops = {
+	.disable	= ccu_p_disable,
+	.enable		= ccu_p_enable,
+	.is_enabled	= ccu_p_is_enabled,
+
+	.get_parent	= ccu_p_get_parent,
+	.set_parent	= ccu_p_set_parent,
+
+	.determine_rate	= ccu_p_determine_rate,
+	.recalc_rate	= ccu_p_recalc_rate,
+	.set_rate	= ccu_p_set_rate,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_p.h b/drivers/clk/sunxi-ng/ccu_p.h
new file mode 100644
index 000000000000..3cbda4ae6e72
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_p.h
@@ -0,0 +1,40 @@
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
+#ifndef _CCU_P_H_
+#define _CCU_P_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+#include "ccu_factor.h"
+#include "ccu_mux.h"
+
+struct ccu_p {
+	u32			enable;
+
+	struct ccu_factor	p;
+	struct ccu_mux_internal	mux;
+	struct ccu_common	common;
+};
+
+static inline struct ccu_p *hw_to_ccu_p(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_p, common);
+}
+
+extern const struct clk_ops ccu_p_ops;
+
+#endif /* _CCU_P_H_ */
-- 
2.8.2
