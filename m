From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Fri, 10 Nov 2017 14:35:59 +0800
Subject: [PATCH V4 04/12] clk: sprd: add gate clock support
In-Reply-To: <20171110063607.3250-1-chunyan.zhang@spreadtrum.com>
References: <20171110063607.3250-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20171110063607.3250-5-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks on the Spreadtrum's SoCs are just simple gates. Add
support for those clocks.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/sprd/Makefile |   1 +
 drivers/clk/sprd/gate.c   | 124 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/gate.h   |  63 +++++++++++++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 drivers/clk/sprd/gate.c
 create mode 100644 drivers/clk/sprd/gate.h

diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
index 74f4b80..8cd5592 100644
--- a/drivers/clk/sprd/Makefile
+++ b/drivers/clk/sprd/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_SPRD_COMMON_CLK)	+= clk-sprd.o
 
 clk-sprd-y	+= common.o
+clk-sprd-y	+= gate.o
diff --git a/drivers/clk/sprd/gate.c b/drivers/clk/sprd/gate.c
new file mode 100644
index 0000000..fa0d9ee
--- /dev/null
+++ b/drivers/clk/sprd/gate.c
@@ -0,0 +1,124 @@
+/*
+ * Spreadtrum gate clock driver
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ * Author: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+
+#include "gate.h"
+
+DEFINE_SPINLOCK(sprd_gate_lock);
+EXPORT_SYMBOL_GPL(sprd_gate_lock);
+
+static void clk_gate_toggle(const struct sprd_gate *sg, bool en)
+{
+	const struct sprd_clk_common *common = &sg->common;
+	unsigned long flags = 0;
+	unsigned int reg;
+	bool set = sg->flags & CLK_GATE_SET_TO_DISABLE ? true : false;
+
+	set ^= en;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	sprd_regmap_read(common->regmap, common->reg, &reg);
+
+	if (set)
+		reg |= sg->enable_mask;
+	else
+		reg &= ~sg->enable_mask;
+
+	sprd_regmap_write(common->regmap, common->reg, reg);
+
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+static void clk_sc_gate_toggle(const struct sprd_gate *sg, bool en)
+{
+	const struct sprd_clk_common *common = &sg->common;
+	unsigned long flags = 0;
+	bool set = sg->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
+	unsigned int offset;
+
+	set ^= en;
+
+	/*
+	 * Each set/clear gate clock has three registers:
+	 * common->reg			- base register
+	 * common->reg + offset		- set register
+	 * common->reg + 2 * offset	- clear register
+	 */
+	offset = set ? sg->sc_offset : sg->sc_offset * 2;
+
+	spin_lock_irqsave(common->lock, flags);
+	sprd_regmap_write(common->regmap, common->reg + offset,
+			  sg->enable_mask);
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+static void sprd_gate_disable(struct clk_hw *hw)
+{
+	struct sprd_gate *sg = hw_to_sprd_gate(hw);
+
+	clk_gate_toggle(sg, false);
+}
+
+static int sprd_gate_enable(struct clk_hw *hw)
+{
+	struct sprd_gate *sg = hw_to_sprd_gate(hw);
+
+	clk_gate_toggle(sg, true);
+
+	return 0;
+}
+
+static void sprd_sc_gate_disable(struct clk_hw *hw)
+{
+	struct sprd_gate *sg = hw_to_sprd_gate(hw);
+
+	clk_sc_gate_toggle(sg, false);
+}
+
+static int sprd_sc_gate_enable(struct clk_hw *hw)
+{
+	struct sprd_gate *sg = hw_to_sprd_gate(hw);
+
+	clk_sc_gate_toggle(sg, true);
+
+	return 0;
+}
+static int sprd_gate_is_enabled(struct clk_hw *hw)
+{
+	struct sprd_gate *sg = hw_to_sprd_gate(hw);
+	struct sprd_clk_common *common = &sg->common;
+	unsigned int reg;
+
+	sprd_regmap_read(common->regmap, common->reg, &reg);
+
+	if (sg->flags & CLK_GATE_SET_TO_DISABLE)
+		reg ^= sg->enable_mask;
+
+	reg &= sg->enable_mask;
+
+	return reg ? 1 : 0;
+}
+
+const struct clk_ops sprd_gate_ops = {
+	.disable	= sprd_gate_disable,
+	.enable		= sprd_gate_enable,
+	.is_enabled	= sprd_gate_is_enabled,
+};
+EXPORT_SYMBOL_GPL(sprd_gate_ops);
+
+const struct clk_ops sprd_sc_gate_ops = {
+	.disable	= sprd_sc_gate_disable,
+	.enable		= sprd_sc_gate_enable,
+	.is_enabled	= sprd_gate_is_enabled,
+};
+EXPORT_SYMBOL_GPL(sprd_sc_gate_ops);
+
diff --git a/drivers/clk/sprd/gate.h b/drivers/clk/sprd/gate.h
new file mode 100644
index 0000000..dad8ba0
--- /dev/null
+++ b/drivers/clk/sprd/gate.h
@@ -0,0 +1,63 @@
+/*
+ * Spreadtrum gate clock driver
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ * Author: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _SPRD_GATE_H_
+#define _SPRD_GATE_H_
+
+#include "common.h"
+
+struct sprd_gate {
+	u32			enable_mask;
+	u16			flags;
+	u16			sc_offset;
+
+	struct sprd_clk_common	common;
+};
+
+#define SPRD_SC_GATE_CLK_OPS(_struct, _name, _parent, _reg, _sc_offset,	\
+			     _enable_mask, _flags, _gate_flags, _ops)	\
+	struct sprd_gate _struct = {					\
+		.enable_mask	= _enable_mask,				\
+		.sc_offset	= _sc_offset,				\
+		.flags		= _gate_flags,				\
+		.common	= {						\
+			.regmap		= NULL,				\
+			.reg		= _reg,				\
+			.lock		= &sprd_gate_lock,		\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      _ops,		\
+						      _flags),		\
+		}							\
+	}
+
+#define SPRD_GATE_CLK(_struct, _name, _parent, _reg,			\
+		      _enable_mask, _flags, _gate_flags)		\
+	SPRD_SC_GATE_CLK_OPS(_struct, _name, _parent, _reg, 0,		\
+			     _enable_mask, _flags, _gate_flags,		\
+			     &sprd_gate_ops)
+
+#define SPRD_SC_GATE_CLK(_struct, _name, _parent, _reg, _sc_offset,	\
+			 _enable_mask, _flags, _gate_flags)		\
+	SPRD_SC_GATE_CLK_OPS(_struct, _name, _parent, _reg, _sc_offset,	\
+			     _enable_mask, _flags, _gate_flags,		\
+			     &sprd_sc_gate_ops)
+
+static inline struct sprd_gate *hw_to_sprd_gate(const struct clk_hw *hw)
+{
+	struct sprd_clk_common *common = hw_to_sprd_clk_common(hw);
+
+	return container_of(common, struct sprd_gate, common);
+}
+
+extern const struct clk_ops sprd_gate_ops;
+extern const struct clk_ops sprd_sc_gate_ops;
+extern spinlock_t sprd_gate_lock;
+
+#endif /* _SPRD_GATE_H_ */
-- 
2.7.4
