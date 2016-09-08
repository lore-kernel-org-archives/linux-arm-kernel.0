From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  8 Sep 2016 11:48:40 +0200
Subject: [PATCH v3 5/8] clk: sunxi-ng: Add N-class clocks support
In-Reply-To: <20160908094843.14710-1-maxime.ripard@free-electrons.com>
References: <20160908094843.14710-1-maxime.ripard@free-electrons.com>
Message-ID: <20160908094843.14710-6-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the class with a single factor, N, being a multiplier.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/Kconfig    |   4 ++
 drivers/clk/sunxi-ng/Makefile   |   1 +
 drivers/clk/sunxi-ng/ccu_mult.c | 133 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_mult.h |  35 +++++++++++
 4 files changed, 173 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_mult.c

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index a1dee861474c..c7258779daa8 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -19,6 +19,10 @@ config SUNXI_CCU_GATE
 config SUNXI_CCU_MUX
 	bool
 
+config SUNXI_CCU_MULT
+	bool
+	select SUNXI_CCU_MUX
+
 config SUNXI_CCU_PHASE
 	bool
 
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 261438b00215..462a5f8383ed 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_SUNXI_CCU_DIV)	+= ccu_div.o
 obj-$(CONFIG_SUNXI_CCU_FRAC)	+= ccu_frac.o
 obj-$(CONFIG_SUNXI_CCU_GATE)	+= ccu_gate.o
 obj-$(CONFIG_SUNXI_CCU_MUX)	+= ccu_mux.o
+obj-$(CONFIG_SUNXI_CCU_MULT)	+= ccu_mult.o
 obj-$(CONFIG_SUNXI_CCU_PHASE)	+= ccu_phase.o
 
 # Multi-factor clocks
diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
new file mode 100644
index 000000000000..010e9424691d
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_mult.c
@@ -0,0 +1,133 @@
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
+#include "ccu_mult.h"
+
+static void ccu_mult_find_best(unsigned long parent, unsigned long rate,
+			       unsigned int max_n, unsigned int *n)
+{
+	*n = rate / parent;
+}
+
+static unsigned long ccu_mult_round_rate(struct ccu_mux_internal *mux,
+					unsigned long parent_rate,
+					unsigned long rate,
+					void *data)
+{
+	struct ccu_mult *cm = data;
+	unsigned int n;
+
+	ccu_mult_find_best(parent_rate, rate, 1 << cm->mult.width, &n);
+
+	return parent_rate * n;
+}
+
+static void ccu_mult_disable(struct clk_hw *hw)
+{
+	struct ccu_mult *cm = hw_to_ccu_mult(hw);
+
+	return ccu_gate_helper_disable(&cm->common, cm->enable);
+}
+
+static int ccu_mult_enable(struct clk_hw *hw)
+{
+	struct ccu_mult *cm = hw_to_ccu_mult(hw);
+
+	return ccu_gate_helper_enable(&cm->common, cm->enable);
+}
+
+static int ccu_mult_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_mult *cm = hw_to_ccu_mult(hw);
+
+	return ccu_gate_helper_is_enabled(&cm->common, cm->enable);
+}
+
+static unsigned long ccu_mult_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct ccu_mult *cm = hw_to_ccu_mult(hw);
+	unsigned long val;
+	u32 reg;
+
+	reg = readl(cm->common.base + cm->common.reg);
+	val = reg >> cm->mult.shift;
+	val &= (1 << cm->mult.width) - 1;
+
+	ccu_mux_helper_adjust_parent_for_prediv(&cm->common, &cm->mux, -1,
+						&parent_rate);
+
+	return parent_rate * (val + 1);
+}
+
+static int ccu_mult_determine_rate(struct clk_hw *hw,
+				struct clk_rate_request *req)
+{
+	struct ccu_mult *cm = hw_to_ccu_mult(hw);
+
+	return ccu_mux_helper_determine_rate(&cm->common, &cm->mux,
+					     req, ccu_mult_round_rate, cm);
+}
+
+static int ccu_mult_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long parent_rate)
+{
+	struct ccu_mult *cm = hw_to_ccu_mult(hw);
+	unsigned long flags;
+	unsigned int n;
+	u32 reg;
+
+	ccu_mux_helper_adjust_parent_for_prediv(&cm->common, &cm->mux, -1,
+						&parent_rate);
+
+	ccu_mult_find_best(parent_rate, rate, 1 << cm->mult.width, &n);
+
+	spin_lock_irqsave(cm->common.lock, flags);
+
+	reg = readl(cm->common.base + cm->common.reg);
+	reg &= ~GENMASK(cm->mult.width + cm->mult.shift - 1, cm->mult.shift);
+
+	writel(reg | ((n - 1) << cm->mult.shift),
+	       cm->common.base + cm->common.reg);
+
+	spin_unlock_irqrestore(cm->common.lock, flags);
+
+	return 0;
+}
+
+static u8 ccu_mult_get_parent(struct clk_hw *hw)
+{
+	struct ccu_mult *cm = hw_to_ccu_mult(hw);
+
+	return ccu_mux_helper_get_parent(&cm->common, &cm->mux);
+}
+
+static int ccu_mult_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct ccu_mult *cm = hw_to_ccu_mult(hw);
+
+	return ccu_mux_helper_set_parent(&cm->common, &cm->mux, index);
+}
+
+const struct clk_ops ccu_mult_ops = {
+	.disable	= ccu_mult_disable,
+	.enable		= ccu_mult_enable,
+	.is_enabled	= ccu_mult_is_enabled,
+
+	.get_parent	= ccu_mult_get_parent,
+	.set_parent	= ccu_mult_set_parent,
+
+	.determine_rate	= ccu_mult_determine_rate,
+	.recalc_rate	= ccu_mult_recalc_rate,
+	.set_rate	= ccu_mult_set_rate,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_mult.h b/drivers/clk/sunxi-ng/ccu_mult.h
index 609db6610880..5d2c8dc14073 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.h
+++ b/drivers/clk/sunxi-ng/ccu_mult.h
@@ -1,6 +1,9 @@
 #ifndef _CCU_MULT_H_
 #define _CCU_MULT_H_
 
+#include "ccu_common.h"
+#include "ccu_mux.h"
+
 struct _ccu_mult {
 	u8	shift;
 	u8	width;
@@ -12,4 +15,36 @@ struct _ccu_mult {
 		.width	= _width,		\
 	}
 
+struct ccu_mult {
+	u32			enable;
+
+	struct _ccu_mult	mult;
+	struct ccu_mux_internal	mux;
+	struct ccu_common	common;
+};
+
+#define SUNXI_CCU_N_WITH_GATE_LOCK(_struct, _name, _parent, _reg,	\
+				   _mshift, _mwidth, _gate, _lock,	\
+				   _flags)				\
+	struct ccu_mult _struct = {					\
+		.enable	= _gate,					\
+		.mult	= _SUNXI_CCU_MULT(_mshift, _mwidth),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_mult_ops,	\
+						      _flags),		\
+		},							\
+	}
+
+static inline struct ccu_mult *hw_to_ccu_mult(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_mult, common);
+}
+
+extern const struct clk_ops ccu_mult_ops;
+
 #endif /* _CCU_MULT_H_ */
-- 
2.9.3
