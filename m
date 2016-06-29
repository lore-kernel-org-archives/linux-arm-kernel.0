From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Jun 2016 21:05:28 +0200
Subject: [PATCH v3 07/14] clk: sunxi-ng: Add divider
In-Reply-To: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
References: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
Message-ID: <20160629190535.11855-8-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the various dividers (linear, table or pow-of-two based)
found in the CCU.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/Kconfig   |   4 ++
 drivers/clk/sunxi-ng/Makefile  |   1 +
 drivers/clk/sunxi-ng/ccu_div.c | 136 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_div.h | 133 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 274 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_div.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_div.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 3a3bc4368a2a..7e65e776e7a8 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -6,6 +6,10 @@ if SUNXI_CCU
 
 # Base clock types
 
+config SUNXI_CCU_DIV
+	bool
+	select SUNXI_CCU_MUX
+
 config SUNXI_CCU_FRAC
 	bool
 
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index a0c53c56ebfe..4bc5b6168560 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_SUNXI_CCU)		+= ccu_common.o
 obj-$(CONFIG_SUNXI_CCU)		+= ccu_reset.o
 
 # Base clock types
+obj-$(CONFIG_SUNXI_CCU_DIV)	+= ccu_div.o
 obj-$(CONFIG_SUNXI_CCU_FRAC)	+= ccu_frac.o
 obj-$(CONFIG_SUNXI_CCU_GATE)	+= ccu_gate.o
 obj-$(CONFIG_SUNXI_CCU_MUX)	+= ccu_mux.o
diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
new file mode 100644
index 000000000000..8659b4cb6c20
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_div.c
@@ -0,0 +1,136 @@
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
+#include "ccu_div.h"
+
+static unsigned long ccu_div_round_rate(struct ccu_mux_internal *mux,
+					unsigned long parent_rate,
+					unsigned long rate,
+					void *data)
+{
+	struct ccu_div *cd = data;
+	unsigned long val;
+
+	/*
+	 * We can't use divider_round_rate that assumes that there's
+	 * several parents, while we might be called to evaluate
+	 * several different parents.
+	 */
+	val = divider_get_val(rate, parent_rate, cd->div.table, cd->div.width,
+			      cd->div.flags);
+
+	return divider_recalc_rate(&cd->common.hw, parent_rate, val,
+				   cd->div.table, cd->div.flags);
+}
+
+static void ccu_div_disable(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_gate_helper_disable(&cd->common, cd->enable);
+}
+
+static int ccu_div_enable(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_gate_helper_enable(&cd->common, cd->enable);
+}
+
+static int ccu_div_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_gate_helper_is_enabled(&cd->common, cd->enable);
+}
+
+static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+	unsigned long val;
+	u32 reg;
+
+	reg = readl(cd->common.base + cd->common.reg);
+	val = reg >> cd->div.shift;
+	val &= (1 << cd->div.width) - 1;
+
+	ccu_mux_helper_adjust_parent_for_prediv(&cd->common, &cd->mux, -1,
+						&parent_rate);
+
+	return divider_recalc_rate(hw, parent_rate, val, cd->div.table,
+				   cd->div.flags);
+}
+
+static int ccu_div_determine_rate(struct clk_hw *hw,
+				struct clk_rate_request *req)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_mux_helper_determine_rate(&cd->common, &cd->mux,
+					     req, ccu_div_round_rate, cd);
+}
+
+static int ccu_div_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long parent_rate)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+	unsigned long flags;
+	unsigned long val;
+	u32 reg;
+
+	ccu_mux_helper_adjust_parent_for_prediv(&cd->common, &cd->mux, -1,
+						&parent_rate);
+
+	val = divider_get_val(rate, parent_rate, cd->div.table, cd->div.width,
+			      cd->div.flags);
+
+	spin_lock_irqsave(cd->common.lock, flags);
+
+	reg = readl(cd->common.base + cd->common.reg);
+	reg &= ~GENMASK(cd->div.width + cd->div.shift - 1, cd->div.shift);
+
+	writel(reg | (val << cd->div.shift),
+	       cd->common.base + cd->common.reg);
+
+	spin_unlock_irqrestore(cd->common.lock, flags);
+
+	return 0;
+}
+
+static u8 ccu_div_get_parent(struct clk_hw *hw)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_mux_helper_get_parent(&cd->common, &cd->mux);
+}
+
+static int ccu_div_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_mux_helper_set_parent(&cd->common, &cd->mux, index);
+}
+
+const struct clk_ops ccu_div_ops = {
+	.disable	= ccu_div_disable,
+	.enable		= ccu_div_enable,
+	.is_enabled	= ccu_div_is_enabled,
+
+	.get_parent	= ccu_div_get_parent,
+	.set_parent	= ccu_div_set_parent,
+
+	.determine_rate	= ccu_div_determine_rate,
+	.recalc_rate	= ccu_div_recalc_rate,
+	.set_rate	= ccu_div_set_rate,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_div.h b/drivers/clk/sunxi-ng/ccu_div.h
new file mode 100644
index 000000000000..653ade5769b3
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_div.h
@@ -0,0 +1,133 @@
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
+#ifndef _CCU_DIV_H_
+#define _CCU_DIV_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+#include "ccu_mux.h"
+
+struct _ccu_div {
+	u8			shift;
+	u8			width;
+
+	u32			flags;
+
+	struct clk_div_table	*table;
+};
+
+#define _SUNXI_CCU_DIV_TABLE_FLAGS(_shift, _width, _table, _flags)	\
+	{								\
+		.shift	= _shift,					\
+		.width	= _width,					\
+		.flags	= _flags,					\
+		.table	= _table,					\
+	}
+
+#define _SUNXI_CCU_DIV_FLAGS(_shift, _width, _flags)			\
+	_SUNXI_CCU_DIV_TABLE_FLAGS(_shift, _width, NULL, _flags)
+
+#define _SUNXI_CCU_DIV_TABLE(_shift, _width, _table)			\
+	_SUNXI_CCU_DIV_TABLE_FLAGS(_shift, _width, _table, 0)
+
+#define _SUNXI_CCU_DIV(_shift, _width)					\
+	_SUNXI_CCU_DIV_TABLE_FLAGS(_shift, _width, NULL, 0)
+
+struct ccu_div {
+	u32			enable;
+
+	struct _ccu_div		div;
+	struct ccu_mux_internal	mux;
+	struct ccu_common	common;
+};
+
+#define SUNXI_CCU_DIV_TABLE_WITH_GATE(_struct, _name, _parent, _reg,	\
+				      _shift, _width,			\
+				      _table, _gate, _flags)		\
+	struct ccu_div _struct = {					\
+		.div		= _SUNXI_CCU_DIV_TABLE(_shift, _width,	\
+						       _table),		\
+		.enable		= _gate,				\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_div_ops,	\
+						      _flags),		\
+		}							\
+	}
+
+
+#define SUNXI_CCU_DIV_TABLE(_struct, _name, _parent, _reg,		\
+			    _shift, _width,				\
+			    _table, _flags)				\
+	SUNXI_CCU_DIV_TABLE_WITH_GATE(_struct, _name, _parent, _reg,	\
+				      _shift, _width, _table, 0,	\
+				      _flags)
+
+#define SUNXI_CCU_M_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
+				  _mshift, _mwidth, _muxshift, _muxwidth, \
+				  _gate, _flags)			\
+	struct ccu_div _struct = {					\
+		.enable	= _gate,					\
+		.div	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
+		.mux	= SUNXI_CLK_MUX(_muxshift, _muxwidth),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
+							      _parents, \
+							      &ccu_div_ops, \
+							      _flags),	\
+		},							\
+	}
+
+#define SUNXI_CCU_M_WITH_MUX(_struct, _name, _parents, _reg,		\
+			     _mshift, _mwidth, _muxshift, _muxwidth,	\
+			     _flags)					\
+	SUNXI_CCU_M_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
+				  _mshift, _mwidth, _muxshift, _muxwidth, \
+				  0, _flags)
+
+
+#define SUNXI_CCU_M_WITH_GATE(_struct, _name, _parent, _reg,		\
+			      _mshift, _mwidth,	_gate,			\
+			      _flags)					\
+	struct ccu_div _struct = {					\
+		.enable	= _gate,					\
+		.div	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_div_ops,	\
+						      _flags),		\
+		},							\
+	}
+
+#define SUNXI_CCU_M(_struct, _name, _parent, _reg, _mshift, _mwidth,	\
+		    _flags)						\
+	SUNXI_CCU_M_WITH_GATE(_struct, _name, _parent, _reg,		\
+			      _mshift, _mwidth, 0, _flags)
+
+static inline struct ccu_div *hw_to_ccu_div(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_div, common);
+}
+
+extern const struct clk_ops ccu_div_ops;
+
+#endif /* _CCU_DIV_H_ */
-- 
2.9.0
