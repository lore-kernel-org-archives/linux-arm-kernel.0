From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 11 Jul 2017 18:56:22 +0800
Subject: [PATCH V2 05/10] clk: sprd: add mux clock support
In-Reply-To: <20170711105627.20526-1-chunyan.zhang@spreadtrum.com>
References: <20170711105627.20526-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170711105627.20526-6-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clock multiplexor support for Spreadtrum platforms,
the mux clocks also can be found in sprd composite clocks, so
provides two helpers that can be reused later on.

Original-by: Xiaolong Zhang <xiaolong.zhang@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/sprd/Makefile |  1 +
 drivers/clk/sprd/mux.c    | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/mux.h    | 63 ++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 drivers/clk/sprd/mux.c
 create mode 100644 drivers/clk/sprd/mux.h

diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
index 8cd5592..cee36b5 100644
--- a/drivers/clk/sprd/Makefile
+++ b/drivers/clk/sprd/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_SPRD_COMMON_CLK)	+= clk-sprd.o
 
 clk-sprd-y	+= common.o
 clk-sprd-y	+= gate.o
+clk-sprd-y	+= mux.o
diff --git a/drivers/clk/sprd/mux.c b/drivers/clk/sprd/mux.c
new file mode 100644
index 0000000..b5d8988
--- /dev/null
+++ b/drivers/clk/sprd/mux.c
@@ -0,0 +1,86 @@
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
+#include "mux.h"
+
+DEFINE_SPINLOCK(sprd_mux_lock);
+EXPORT_SYMBOL_GPL(sprd_mux_lock);
+
+u8 sprd_mux_helper_get_parent(const struct sprd_clk_common *common,
+			      const struct sprd_mux_internal *mux)
+{
+	u32 reg;
+	u8 parent;
+	int num_parents;
+	int i;
+
+	reg = sprd_clk_readl(common);
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
+EXPORT_SYMBOL_GPL(sprd_mux_helper_get_parent);
+
+static u8 sprd_mux_get_parent(struct clk_hw *hw)
+{
+	struct sprd_mux *cm = hw_to_sprd_mux(hw);
+
+	return sprd_mux_helper_get_parent(&cm->common, &cm->mux);
+}
+
+int sprd_mux_helper_set_parent(const struct sprd_clk_common *common,
+			       const struct sprd_mux_internal *mux,
+			       u8 index)
+{
+	unsigned long flags = 0;
+	u32 reg;
+
+	if (mux->table)
+		index = mux->table[index];
+
+	spin_lock_irqsave(common->lock, flags);
+
+	reg = sprd_clk_readl(common);
+	reg &= ~GENMASK(mux->width + mux->shift - 1, mux->shift);
+	sprd_clk_writel(reg | (index << mux->shift), common);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sprd_mux_helper_set_parent);
+
+static int sprd_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct sprd_mux *cm = hw_to_sprd_mux(hw);
+
+	return sprd_mux_helper_set_parent(&cm->common, &cm->mux, index);
+}
+
+const struct clk_ops sprd_mux_ops = {
+	.get_parent = sprd_mux_get_parent,
+	.set_parent = sprd_mux_set_parent,
+	.determine_rate = __clk_mux_determine_rate,
+};
+EXPORT_SYMBOL_GPL(sprd_mux_ops);
diff --git a/drivers/clk/sprd/mux.h b/drivers/clk/sprd/mux.h
new file mode 100644
index 0000000..aa35514
--- /dev/null
+++ b/drivers/clk/sprd/mux.h
@@ -0,0 +1,63 @@
+/*
+ * Spreadtrum multiplexer clock driver
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _SPRD_MUX_H_
+#define _SPRD_MUX_H_
+
+#include "common.h"
+
+struct sprd_mux_internal {
+	u8		shift;
+	u8		width;
+	const u8	*table;
+};
+
+struct sprd_mux {
+	struct sprd_mux_internal mux;
+	struct sprd_clk_common	common;
+};
+
+#define _SPRD_MUX_CLK(_shift, _width, _table)		\
+	{						\
+		.shift	= _shift,			\
+		.width	= _width,			\
+		.table	= _table,			\
+	}
+
+#define SPRD_MUX_CLK(_struct, _name, _parents, _table,			\
+				     _reg, _shift, _width,		\
+				     _flags)				\
+	struct sprd_mux _struct = {					\
+		.mux	= _SPRD_MUX_CLK(_shift, _width, _table),	\
+		.common	= {						\
+			.reg		= _reg,				\
+			.lock		= &sprd_mux_lock,		\
+			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
+							      _parents, \
+							      &sprd_mux_ops,\
+							      _flags),	\
+		}							\
+	}
+
+static inline struct sprd_mux *hw_to_sprd_mux(const struct clk_hw *hw)
+{
+	struct sprd_clk_common *common = hw_to_sprd_clk_common(hw);
+
+	return container_of(common, struct sprd_mux, common);
+}
+
+extern const struct clk_ops sprd_mux_ops;
+extern spinlock_t sprd_mux_lock;
+
+u8 sprd_mux_helper_get_parent(const struct sprd_clk_common *common,
+			      const struct sprd_mux_internal *mux);
+int sprd_mux_helper_set_parent(const struct sprd_clk_common *common,
+			       const struct sprd_mux_internal *mux,
+			       u8 index);
+
+#endif /* _SPRD_MUX_H_ */
-- 
2.7.4
