From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  8 May 2016 22:01:41 +0200
Subject: [PATCH 06/16] clk: sunxi-ng: Add divider table clock
In-Reply-To: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1462737711-10017-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for clocks based on a divider tables.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/Makefile        |   1 +
 drivers/clk/sunxi-ng/ccu_div_table.c | 117 +++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_div_table.h |  75 ++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_div_table.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_div_table.h

diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index aa5c411ff8ea..f20c6c8f217c 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -1,6 +1,7 @@
 obj-y += ccu_common.o
 obj-y += ccu_reset.o
 
+obj-y += ccu_div_table.o
 obj-y += ccu_fixed_factor.o
 obj-y += ccu_gate.o
 obj-y += ccu_mux.o
diff --git a/drivers/clk/sunxi-ng/ccu_div_table.c b/drivers/clk/sunxi-ng/ccu_div_table.c
new file mode 100644
index 000000000000..cbfff0bd47e3
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_div_table.c
@@ -0,0 +1,117 @@
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
+#include "ccu_div_table.h"
+#include "ccu_gate.h"
+
+static void ccu_div_table_find_best(unsigned long parent, unsigned long rate,
+				    struct ccu_div_table *ct,
+				    unsigned int *index)
+{
+	unsigned long best_rate = 0;
+	unsigned int best_index = 0;
+	unsigned int _index;
+
+	for (_index = 0; _index <= ct->num_divs; _index++) {
+		unsigned long tmp_rate = parent / ct->table[_index];
+
+		if (tmp_rate > rate)
+			continue;
+
+		if ((rate - tmp_rate) < (rate - best_rate)) {
+			best_rate = tmp_rate;
+			best_index = _index;
+		}
+	}
+
+	*index = best_index;
+}
+
+static void ccu_div_table_disable(struct clk_hw *hw)
+{
+	struct ccu_div_table *ct = hw_to_ccu_div_table(hw);
+
+	return ccu_gate_helper_disable(&ct->common, ct->enable);
+}
+
+static int ccu_div_table_enable(struct clk_hw *hw)
+{
+	struct ccu_div_table *ct = hw_to_ccu_div_table(hw);
+
+	return ccu_gate_helper_enable(&ct->common, ct->enable);
+}
+
+static int ccu_div_table_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_div_table *ct = hw_to_ccu_div_table(hw);
+
+	return ccu_gate_helper_is_enabled(&ct->common, ct->enable);
+}
+
+static unsigned long ccu_div_table_recalc_rate(struct clk_hw *hw,
+					       unsigned long parent_rate)
+{
+	struct ccu_div_table *ct = hw_to_ccu_div_table(hw);
+	unsigned long div;
+	u32 reg;
+
+	reg = readl(ct->common.base + ct->common.reg);
+
+	div = reg >> ct->div.shift;
+	div &= (1 << ct->div.width) - 1;
+
+	return parent_rate / ct->table[div];
+}
+
+static long ccu_div_table_round_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long *parent_rate)
+{
+	struct ccu_div_table *ct = hw_to_ccu_div_table(hw);
+	unsigned int index;
+	
+	ccu_div_table_find_best(*parent_rate, rate,
+				ct, &index);
+
+	return *parent_rate / ct->table[index];
+}
+
+static int ccu_div_table_set_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long parent_rate)
+{
+	struct ccu_div_table *ct = hw_to_ccu_div_table(hw);
+	unsigned long flags;
+	unsigned int index;
+	u32 reg;
+
+	ccu_div_table_find_best(parent_rate, rate, ct, &index);
+
+	spin_lock_irqsave(ct->common.lock, flags);
+
+	reg = readl(ct->common.base + ct->common.reg);
+	reg &= ~GENMASK(ct->div.width + ct->div.shift, ct->div.shift);
+	writel(reg | ((ct->table[index]) << ct->div.shift),
+	       ct->common.base + ct->common.reg);
+
+	spin_unlock_irqrestore(ct->common.lock, flags);
+
+	return 0;
+}
+
+const struct clk_ops ccu_div_table_ops = {
+	.disable	= ccu_div_table_disable,
+	.enable		= ccu_div_table_enable,
+	.is_enabled	= ccu_div_table_is_enabled,
+
+	.recalc_rate	= ccu_div_table_recalc_rate,
+	.round_rate	= ccu_div_table_round_rate,
+	.set_rate	= ccu_div_table_set_rate,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_div_table.h b/drivers/clk/sunxi-ng/ccu_div_table.h
new file mode 100644
index 000000000000..bd7da49087ed
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_div_table.h
@@ -0,0 +1,75 @@
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
+#ifndef _CCU_DIV_TABLE_H_
+#define _CCU_DIV_TABLE_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+#include "ccu_factor.h"
+
+struct ccu_div_table {
+	u32			enable;
+
+	u8			*table;
+	int			num_divs;
+
+	struct ccu_factor	div;
+	struct ccu_common	common;
+};
+
+#define SUNXI_CCU_DIV_TABLE(_struct, _name, _parent, _reg,		\
+			    _shift, _width,				\
+			    _table, _flags)				\
+	struct ccu_div_table _struct = {				\
+		.table		= _table,				\
+		.num_divs	= ARRAY_SIZE(_table),			\
+		.div		= SUNXI_CLK_FACTOR(_shift, _width),	\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= SUNXI_HW_INIT(_name,		\
+							_parent,	\
+							&ccu_div_table_ops, \
+							_flags),	\
+		}							\
+	}
+
+#define SUNXI_CCU_DIV_TABLE_WITH_GATE(_struct, _name, _parent, _reg,	\
+				      _shift, _width,			\
+				      _table, _gate, _flags)		\
+	struct ccu_div_table _struct = {				\
+		.enable		= _gate,				\
+		.table		= _table,				\
+		.num_divs	= ARRAY_SIZE(_table),			\
+		.div		= SUNXI_CLK_FACTOR(_shift, _width),	\
+		.common	= {						\
+			.reg		= _reg,				\
+			.features	= CCU_FEATURE_GATE,		\
+			.hw.init	= SUNXI_HW_INIT(_name,		\
+							_parent,	\
+							&ccu_div_table_ops, \
+							_flags),	\
+		}							\
+	}
+
+static inline struct ccu_div_table *hw_to_ccu_div_table(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_div_table, common);
+}
+
+extern const struct clk_ops ccu_div_table_ops;
+
+#endif /* _CCU_DIV_H_ */
-- 
2.8.2
