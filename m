From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Sun, 18 Jun 2017 09:58:52 +0800
Subject: [PATCH V1 6/9] clk: sprd: add composite clock support
In-Reply-To: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170618015855.27738-7-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduced composite driver whose functions are simply
consisted of divider and mux clocks.

Original-by: Xiaolong Zhang <xiaolong.zhang@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/sprd/Makefile        |  2 +-
 drivers/clk/sprd/ccu_composite.c | 62 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/ccu_composite.h | 47 ++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/sprd/ccu_composite.c
 create mode 100644 drivers/clk/sprd/ccu_composite.h

diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
index d129c0a8..83232e5 100644
--- a/drivers/clk/sprd/Makefile
+++ b/drivers/clk/sprd/Makefile
@@ -1,3 +1,3 @@
 ifneq ($(CONFIG_OF),)
-obj-y	+= ccu_common.o ccu_gate.o ccu_mux.o ccu_div.o
+obj-y	+= ccu_common.o ccu_gate.o ccu_mux.o ccu_div.o ccu_composite.o
 endif
diff --git a/drivers/clk/sprd/ccu_composite.c b/drivers/clk/sprd/ccu_composite.c
new file mode 100644
index 0000000..6a64fb1
--- /dev/null
+++ b/drivers/clk/sprd/ccu_composite.c
@@ -0,0 +1,62 @@
+/*
+ * Spreadtrum composite clock driver
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/clk-provider.h>
+
+#include "ccu_composite.h"
+
+DEFINE_SPINLOCK(comp_lock);
+
+static long ccu_comp_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *parent_rate)
+{
+	struct ccu_comp *cc = hw_to_ccu_comp(hw);
+
+	return ccu_div_helper_round_rate(&cc->common, &cc->div,
+					 rate, parent_rate);
+}
+
+static unsigned long ccu_comp_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct ccu_comp *cc = hw_to_ccu_comp(hw);
+
+	return ccu_div_helper_recalc_rate(&cc->common, &cc->div, parent_rate);
+}
+
+static int ccu_comp_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	struct ccu_comp *cc = hw_to_ccu_comp(hw);
+
+	return ccu_div_helper_set_rate(&cc->common, &cc->div,
+				       rate, parent_rate);
+}
+
+static u8 ccu_comp_get_parent(struct clk_hw *hw)
+{
+	struct ccu_comp *cc = hw_to_ccu_comp(hw);
+
+	return ccu_mux_helper_get_parent(&cc->common, &cc->mux);
+}
+
+static int ccu_comp_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct ccu_comp *cc = hw_to_ccu_comp(hw);
+
+	return ccu_mux_helper_set_parent(&cc->common, &cc->mux, index);
+}
+
+const struct clk_ops ccu_comp_ops = {
+	.get_parent	= ccu_comp_get_parent,
+	.set_parent	= ccu_comp_set_parent,
+
+	.round_rate	= ccu_comp_round_rate,
+	.recalc_rate	= ccu_comp_recalc_rate,
+	.set_rate	= ccu_comp_set_rate,
+};
diff --git a/drivers/clk/sprd/ccu_composite.h b/drivers/clk/sprd/ccu_composite.h
new file mode 100644
index 0000000..c99c919
--- /dev/null
+++ b/drivers/clk/sprd/ccu_composite.h
@@ -0,0 +1,47 @@
+/*
+ * Spreadtrum composite clock driver
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _CCU_COMPOSITE_H_
+#define _CCU_COMPOSITE_H_
+
+#include "ccu_common.h"
+#include "ccu_mux.h"
+#include "ccu_div.h"
+
+struct ccu_comp {
+	struct ccu_mux_internal	mux;
+	struct ccu_div_internal	div;
+	struct ccu_common	common;
+};
+
+#define SPRD_CCU_COMP(_struct, _name, _parent, _reg, _table,		\
+			_mshift, _mwidth, _dshift, _dwidth, _flags)	\
+	struct ccu_comp _struct = {					\
+		.mux	= _SPRD_CCU_MUX(_mshift, _mwidth, _table),	\
+		.div	= _SPRD_CCU_DIV(_dshift, _dwidth),		\
+		.common = {						\
+			 .reg		= _reg,				\
+			 .lock		= &comp_lock,			\
+			 .hw.init	= CLK_HW_INIT_PARENTS(_name,	\
+							      _parent,	\
+							&ccu_comp_ops,	\
+							      _flags),	\
+			 }						\
+	}
+
+static inline struct ccu_comp *hw_to_ccu_comp(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_comp, common);
+}
+
+extern const struct clk_ops ccu_comp_ops;
+extern spinlock_t comp_lock;
+
+#endif /* _CCU_COMPOSITE_H_ */
-- 
2.7.4
