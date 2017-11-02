From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Thu, 2 Nov 2017 14:56:19 +0800
Subject: [PATCH V3 04/11] clk: sprd: add gate clock support
In-Reply-To: <20171102065626.21835-1-chunyan.zhang@spreadtrum.com>
References: <20171102065626.21835-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20171102065626.21835-5-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks on the Spreadtrum's SoCs are just simple gates. Add
support for those clocks.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/sprd/Makefile |   1 +
 drivers/clk/sprd/gate.c   | 106 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/gate.h   |  54 +++++++++++++++++++++++
 3 files changed, 161 insertions(+)
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
index 0000000..831ef81
--- /dev/null
+++ b/drivers/clk/sprd/gate.c
@@ -0,0 +1,106 @@
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
+static void sprd_gate_endisable(const struct sprd_gate *sg, u32 en)
+{
+	const struct sprd_clk_common *common = &sg->common;
+	unsigned long flags = 0;
+	unsigned int reg;
+	int set = sg->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
+
+	set ^= en;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	sprd_regmap_read(common->regmap, common->reg, &reg);
+
+	if (set)
+		reg |= sg->op_bit;
+	else
+		reg &= ~sg->op_bit;
+
+	sprd_regmap_write(common->regmap, common->reg, reg);
+
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+static void clk_sc_gate_endisable(const struct sprd_gate *sg, u32 en)
+{
+	const struct sprd_clk_common *common = &sg->common;
+	unsigned long flags = 0;
+	int set = sg->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
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
+	sprd_regmap_write(common->regmap, common->reg + offset, sg->op_bit);
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+static void sprd_gate_disable(struct clk_hw *hw)
+{
+	struct sprd_gate *sg = hw_to_sprd_gate(hw);
+
+	if (sg->sc_offset)
+		clk_sc_gate_endisable(sg, 0);
+	else
+		sprd_gate_endisable(sg, 0);
+}
+
+static int sprd_gate_enable(struct clk_hw *hw)
+{
+	struct sprd_gate *sg = hw_to_sprd_gate(hw);
+
+	if (sg->sc_offset)
+		clk_sc_gate_endisable(sg, 1);
+	else
+		sprd_gate_endisable(sg, 1);
+
+	return 0;
+}
+
+static int sprd_gate_is_enabled(struct clk_hw *hw)
+{
+	struct sprd_gate *sg = hw_to_sprd_gate(hw);
+	struct sprd_clk_common *common = &sg->common;
+	unsigned int reg;
+
+	sprd_regmap_read(common->regmap, common->reg, &reg);
+
+	if (sg->flags & CLK_GATE_SET_TO_DISABLE)
+		reg ^= sg->op_bit;
+
+	reg &= sg->op_bit;
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
diff --git a/drivers/clk/sprd/gate.h b/drivers/clk/sprd/gate.h
new file mode 100644
index 0000000..5aeb53c
--- /dev/null
+++ b/drivers/clk/sprd/gate.h
@@ -0,0 +1,54 @@
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
+	u32			op_bit;
+	u16			flags;
+	u16			sc_offset;
+
+	struct sprd_clk_common	common;
+};
+
+#define SPRD_GATE_CLK(_struct, _name, _parent, _reg, _sc_offset,	\
+		      _op_bit, _flags, _gate_flags)			\
+	struct sprd_gate _struct = {					\
+		.op_bit		= _op_bit,				\
+		.sc_offset	= _sc_offset,				\
+		.flags		= _gate_flags,				\
+		.common	= {						\
+			.regmap		= NULL,				\
+			.reg		= _reg,				\
+			.lock		= &sprd_gate_lock,		\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &sprd_gate_ops,	\
+						      _flags),		\
+		}							\
+	}
+
+static inline struct sprd_gate *hw_to_sprd_gate(const struct clk_hw *hw)
+{
+	struct sprd_clk_common *common = hw_to_sprd_clk_common(hw);
+
+	return container_of(common, struct sprd_gate, common);
+}
+
+void sprd_gate_helper_disable(struct sprd_clk_common *common, u32 gate);
+int sprd_gate_helper_enable(struct sprd_clk_common *common, u32 gate);
+int sprd_gate_helper_is_enabled(struct sprd_clk_common *common, u32 gate);
+
+extern const struct clk_ops sprd_gate_ops;
+extern spinlock_t sprd_gate_lock;
+
+#endif /* _SPRD_GATE_H_ */
-- 
2.7.4
