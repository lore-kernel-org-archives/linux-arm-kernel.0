From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Sun, 18 Jun 2017 09:58:50 +0800
Subject: [PATCH V1 4/9] clk: sprd: add mux clock support
In-Reply-To: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170618015855.27738-5-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a feature that can also be found in sprd composite clocks,
provide two helpers that can be reused later on.

Original-by: Xiaolong Zhang <xiaolong.zhang@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/sprd/Makefile  |  2 +-
 drivers/clk/sprd/ccu_mux.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/ccu_mux.h | 63 +++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/sprd/ccu_mux.c
 create mode 100644 drivers/clk/sprd/ccu_mux.h

diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
index 333e2b2..dc89790 100644
--- a/drivers/clk/sprd/Makefile
+++ b/drivers/clk/sprd/Makefile
@@ -1,3 +1,3 @@
 ifneq ($(CONFIG_OF),)
-obj-y	+= ccu_common.o ccu_gate.o
+obj-y	+= ccu_common.o ccu_gate.o ccu_mux.o
 endif
diff --git a/drivers/clk/sprd/ccu_mux.c b/drivers/clk/sprd/ccu_mux.c
new file mode 100644
index 0000000..51c744e
--- /dev/null
+++ b/drivers/clk/sprd/ccu_mux.c
@@ -0,0 +1,82 @@
+/*
+ * Spreadtrum multiplexer clock driver
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+#include "ccu_mux.h"
+
+DEFINE_SPINLOCK(mux_lock);
+
+u8 ccu_mux_helper_get_parent(struct ccu_common *common,
+			     struct ccu_mux_internal *mux)
+{
+	u32 reg;
+	u8 parent;
+	int num_parents;
+	int i;
+
+	reg = ccu_readl(common);
+	parent = reg >> mux->shift;
+	parent &= (1 << mux->width) - 1;
+
+	if (mux->table) {
+		num_parents = clk_hw_get_num_parents(&common->hw);
+
+		for (i = 0; i < num_parents; i++)
+			if (parent == mux->table[i] ||
+			    (i < (num_parents - 1) && parent > mux->table[i] &&
+			     parent < mux->table[i + 1]))
+				return i;
+		if (i == num_parents)
+			return i - 1;
+	}
+
+	return parent;
+}
+
+static u8 ccu_mux_get_parent(struct clk_hw *hw)
+{
+	struct ccu_mux *cm = hw_to_ccu_mux(hw);
+
+	return ccu_mux_helper_get_parent(&cm->common, &cm->mux);
+}
+
+int ccu_mux_helper_set_parent(struct ccu_common *common,
+			      struct ccu_mux_internal *mux,
+			      u8 index)
+{
+	unsigned long flags = 0;
+	u32 reg;
+
+	if (mux->table)
+		index = mux->table[index];
+
+	spin_lock_irqsave(common->lock, flags);
+
+	reg = ccu_readl(common);
+	reg &= ~GENMASK(mux->width + mux->shift - 1, mux->shift);
+	ccu_writel(reg | (index << mux->shift), common);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return 0;
+}
+
+static int ccu_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct ccu_mux *cm = hw_to_ccu_mux(hw);
+
+	return ccu_mux_helper_set_parent(&cm->common, &cm->mux, index);
+}
+
+const struct clk_ops ccu_mux_ops = {
+	.get_parent = ccu_mux_get_parent,
+	.set_parent = ccu_mux_set_parent,
+	.determine_rate = __clk_mux_determine_rate,
+};
diff --git a/drivers/clk/sprd/ccu_mux.h b/drivers/clk/sprd/ccu_mux.h
new file mode 100644
index 0000000..f3e3fb4
--- /dev/null
+++ b/drivers/clk/sprd/ccu_mux.h
@@ -0,0 +1,63 @@
+/*
+ * Spreadtrum multiplexer clock driver
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _CCU_MUX_H_
+#define _CCU_MUX_H_
+
+#include "ccu_common.h"
+
+struct ccu_mux_internal {
+	u8		shift;
+	u8		width;
+	const u8	*table;
+};
+
+struct ccu_mux {
+	struct ccu_mux_internal mux;
+	struct ccu_common	common;
+};
+
+#define _SPRD_CCU_MUX(_shift, _width, _table)		\
+	{						\
+		.shift	= _shift,			\
+		.width	= _width,			\
+		.table	= _table,			\
+	}
+
+#define SPRD_CCU_MUX(_struct, _name, _parents, _table,			\
+				     _reg, _shift, _width,		\
+				     _flags)				\
+	struct ccu_mux _struct = {					\
+		.mux	= _SPRD_CCU_MUX(_shift, _width, _table),	\
+		.common	= {						\
+			.reg		= _reg,				\
+			.lock		= &mux_lock,			\
+			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
+							      _parents, \
+							      &ccu_mux_ops,\
+							      _flags),	\
+		}							\
+	}
+
+static inline struct ccu_mux *hw_to_ccu_mux(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_mux, common);
+}
+
+extern const struct clk_ops ccu_mux_ops;
+extern spinlock_t mux_lock;
+
+u8 ccu_mux_helper_get_parent(struct ccu_common *common,
+			     struct ccu_mux_internal *mux);
+int ccu_mux_helper_set_parent(struct ccu_common *common,
+			      struct ccu_mux_internal *mux,
+			      u8 index);
+
+#endif /* _CCU_MUX_H_ */
-- 
2.7.4
