From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Sun, 18 Jun 2017 09:58:49 +0800
Subject: [PATCH V1 3/9] clk: sprd: add gate clock support
In-Reply-To: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170618015855.27738-4-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks on the Spreadtrum's SoCs are just simple gates. Add
support for those clocks.

Also, some gate clocks are orphan, so this patch also added
registration code for those.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/sprd/Makefile   |   2 +-
 drivers/clk/sprd/ccu_gate.c | 102 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/ccu_gate.h |  73 +++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/sprd/ccu_gate.c
 create mode 100644 drivers/clk/sprd/ccu_gate.h

diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
index 8f802b2..333e2b2 100644
--- a/drivers/clk/sprd/Makefile
+++ b/drivers/clk/sprd/Makefile
@@ -1,3 +1,3 @@
 ifneq ($(CONFIG_OF),)
-obj-y	+= ccu_common.o
+obj-y	+= ccu_common.o ccu_gate.o
 endif
diff --git a/drivers/clk/sprd/ccu_gate.c b/drivers/clk/sprd/ccu_gate.c
new file mode 100644
index 0000000..3d27615
--- /dev/null
+++ b/drivers/clk/sprd/ccu_gate.c
@@ -0,0 +1,102 @@
+/*
+ * Spreadtrum gate clock driver
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/clk-provider.h>
+
+#include "ccu_gate.h"
+
+DEFINE_SPINLOCK(gate_lock);
+
+static void ccu_gate_endisable(struct ccu_gate *cg, u32 en)
+{
+	struct ccu_common *common = &cg->common;
+	unsigned long flags = 0;
+	u32 reg;
+	int set = cg->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
+
+	set ^= en;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	reg = ccu_readl(common);
+
+	if (set)
+		reg |= cg->op_bit;
+	else
+		reg &= ~cg->op_bit;
+
+	ccu_writel(reg, common);
+
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+static void ccu_sc_gate_endisable(struct ccu_gate *cg, u32 en)
+{
+	struct ccu_common *common = &cg->common;
+	unsigned long flags = 0;
+	int set = cg->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
+	u32 offset;
+
+	set ^= en;
+
+	/*
+	 * Each set/clear gate clock has three registers:
+	 * common->reg			- base register
+	 * common->reg + offset		- set register
+	 * common->reg + 2 * offset	- clear register
+	 */
+	offset = set ? cg->sc_offset : cg->sc_offset * 2;
+
+	spin_lock_irqsave(common->lock, flags);
+	ccu_writel_offset(cg->op_bit, common, offset);
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+static void ccu_gate_disable(struct clk_hw *hw)
+{
+	struct ccu_gate *cg = hw_to_ccu_gate(hw);
+
+	if (cg->sc_offset)
+		ccu_sc_gate_endisable(cg, 0);
+	else
+		ccu_gate_endisable(cg, 0);
+}
+
+static int ccu_gate_enable(struct clk_hw *hw)
+{
+	struct ccu_gate *cg = hw_to_ccu_gate(hw);
+
+	if (cg->sc_offset)
+		ccu_sc_gate_endisable(cg, 1);
+	else
+		ccu_gate_endisable(cg, 1);
+
+	return 0;
+}
+
+static int ccu_gate_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_gate *cg = hw_to_ccu_gate(hw);
+	struct ccu_common *common = &cg->common;
+	u32 reg;
+
+	reg = ccu_readl(common);
+
+	if (cg->flags & CLK_GATE_SET_TO_DISABLE)
+		reg ^= cg->op_bit;
+
+	reg &= cg->op_bit;
+
+	return reg ? 1 : 0;
+}
+
+const struct clk_ops ccu_gate_ops = {
+	.disable	= ccu_gate_disable,
+	.enable		= ccu_gate_enable,
+	.is_enabled	= ccu_gate_is_enabled,
+};
diff --git a/drivers/clk/sprd/ccu_gate.h b/drivers/clk/sprd/ccu_gate.h
new file mode 100644
index 0000000..bc40169
--- /dev/null
+++ b/drivers/clk/sprd/ccu_gate.h
@@ -0,0 +1,73 @@
+/*
+ * Spreadtrum gate clock driver
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _CCU_GATE_H_
+#define _CCU_GATE_H_
+
+#include "ccu_common.h"
+
+struct ccu_gate {
+	u32			op_bit;
+	u16			flags;
+	u16			sc_offset;
+
+	struct ccu_common	common;
+};
+
+#define SPRD_CCU_GATE(_struct, _name, _parent, _reg, _sc_offset,	\
+		      _op_bit, _flags, _gate_flags)			\
+	struct ccu_gate _struct = {					\
+		.op_bit		= _op_bit,				\
+		.sc_offset	= _sc_offset,				\
+		.flags		= _gate_flags,				\
+		.common	= {						\
+			.reg		= _reg,				\
+			.lock		= &gate_lock,			\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_gate_ops,	\
+						      _flags),		\
+		}							\
+	}
+
+#define SPRD_CCU_GATE_NO_PARENT(_struct, _name, _reg, _sc_offset,	\
+				_op_bit, _flags, _gate_flags)		\
+	struct ccu_gate _struct = {					\
+		.op_bit		= _op_bit,				\
+		.sc_offset	= _sc_offset,				\
+		.flags		= _gate_flags,				\
+		.common	= {						\
+			.reg	= _reg,					\
+			.lock	= &gate_lock,				\
+			.hw.init = CLK_HW_INIT_NO_PARENT(_name,		\
+							 &ccu_gate_ops,	\
+							 _flags),	\
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
+static inline void ccu_writel_offset(u32 val,
+	struct ccu_common *common, u32 offset)
+{
+	writel(val, common->base + common->reg + offset);
+}
+
+void ccu_gate_helper_disable(struct ccu_common *common, u32 gate);
+int ccu_gate_helper_enable(struct ccu_common *common, u32 gate);
+int ccu_gate_helper_is_enabled(struct ccu_common *common, u32 gate);
+
+extern const struct clk_ops ccu_gate_ops;
+extern spinlock_t gate_lock;
+
+#endif /* _CCU_GATE_H_ */
-- 
2.7.4
