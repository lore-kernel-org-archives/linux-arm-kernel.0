From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Jun 2016 21:05:25 +0200
Subject: [PATCH v3 04/14] clk: sunxi-ng: Add gate clock support
In-Reply-To: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
References: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
Message-ID: <20160629190535.11855-5-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks in the Allwinner SoCs clocks unit are just simple gates. Add
support for those clocks.

Since it's a feature that can also be found in more complex clocks, provide
a bunch of helpers that can be reused later on.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/Kconfig    |  3 ++
 drivers/clk/sunxi-ng/Makefile   |  1 +
 drivers/clk/sunxi-ng/ccu_gate.c | 82 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_gate.h | 52 ++++++++++++++++++++++++++
 4 files changed, 138 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_gate.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_gate.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 3d117d7a3621..2f135c8a61b6 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -9,4 +9,7 @@ if SUNXI_CCU
 config SUNXI_CCU_FRAC
 	bool
 
+config SUNXI_CCU_GATE
+	bool
+
 endif
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 46f417cb682a..48b885f2d8ff 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_SUNXI_CCU)		+= ccu_reset.o
 
 # Base clock types
 obj-$(CONFIG_SUNXI_CCU_FRAC)	+= ccu_frac.o
+obj-$(CONFIG_SUNXI_CCU_GATE)	+= ccu_gate.o
diff --git a/drivers/clk/sunxi-ng/ccu_gate.c b/drivers/clk/sunxi-ng/ccu_gate.c
new file mode 100644
index 000000000000..8a81f9d4a89f
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_gate.c
@@ -0,0 +1,82 @@
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
+
+void ccu_gate_helper_disable(struct ccu_common *common, u32 gate)
+{
+	unsigned long flags;
+	u32 reg;
+
+	if (!gate)
+		return;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	reg = readl(common->base + common->reg);
+	writel(reg & ~gate, common->base + common->reg);
+
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+static void ccu_gate_disable(struct clk_hw *hw)
+{
+	struct ccu_gate *cg = hw_to_ccu_gate(hw);
+
+	return ccu_gate_helper_disable(&cg->common, cg->enable);
+}
+
+int ccu_gate_helper_enable(struct ccu_common *common, u32 gate)
+{
+	unsigned long flags;
+	u32 reg;
+
+	if (!gate)
+		return 0;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	reg = readl(common->base + common->reg);
+	writel(reg | gate, common->base + common->reg);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return 0;
+}
+
+static int ccu_gate_enable(struct clk_hw *hw)
+{
+	struct ccu_gate *cg = hw_to_ccu_gate(hw);
+
+	return ccu_gate_helper_enable(&cg->common, cg->enable);
+}
+
+int ccu_gate_helper_is_enabled(struct ccu_common *common, u32 gate)
+{
+	if (!gate)
+		return 1;
+
+	return readl(common->base + common->reg) & gate;
+}
+
+static int ccu_gate_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_gate *cg = hw_to_ccu_gate(hw);
+
+	return ccu_gate_helper_is_enabled(&cg->common, cg->enable);
+}
+
+const struct clk_ops ccu_gate_ops = {
+	.disable	= ccu_gate_disable,
+	.enable		= ccu_gate_enable,
+	.is_enabled	= ccu_gate_is_enabled,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_gate.h b/drivers/clk/sunxi-ng/ccu_gate.h
new file mode 100644
index 000000000000..4466169bd2d7
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_gate.h
@@ -0,0 +1,52 @@
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
+#ifndef _CCU_GATE_H_
+#define _CCU_GATE_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+
+struct ccu_gate {
+	u32			enable;
+
+	struct ccu_common	common;
+};
+
+#define SUNXI_CCU_GATE(_struct, _name, _parent, _reg, _gate, _flags)	\
+	struct ccu_gate _struct = {					\
+		.enable	= _gate,					\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_gate_ops,	\
+						      _flags),		\
+		}							\
+	}
+
+static inline struct ccu_gate *hw_to_ccu_gate(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_gate, common);
+}
+
+void ccu_gate_helper_disable(struct ccu_common *common, u32 gate);
+int ccu_gate_helper_enable(struct ccu_common *common, u32 gate);
+int ccu_gate_helper_is_enabled(struct ccu_common *common, u32 gate);
+
+extern const struct clk_ops ccu_gate_ops;
+
+#endif /* _CCU_GATE_H_ */
-- 
2.9.0
