From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Sun, 18 Jun 2017 09:58:51 +0800
Subject: [PATCH V1 5/9] clk: sprd: add divider clock support
In-Reply-To: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
References: <20170618015855.27738-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170618015855.27738-6-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a feature that can also be found in sprd composite clocks,
provide a bunch of helpers that can be reused later on.

Original-by: Xiaolong Zhang <xiaolong.zhang@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/sprd/Makefile  |  2 +-
 drivers/clk/sprd/ccu_div.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/ccu_div.h | 77 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/sprd/ccu_div.c
 create mode 100644 drivers/clk/sprd/ccu_div.h

diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
index dc89790..d129c0a8 100644
--- a/drivers/clk/sprd/Makefile
+++ b/drivers/clk/sprd/Makefile
@@ -1,3 +1,3 @@
 ifneq ($(CONFIG_OF),)
-obj-y	+= ccu_common.o ccu_gate.o ccu_mux.o
+obj-y	+= ccu_common.o ccu_gate.o ccu_mux.o ccu_div.o
 endif
diff --git a/drivers/clk/sprd/ccu_div.c b/drivers/clk/sprd/ccu_div.c
new file mode 100644
index 0000000..0d0f1e9
--- /dev/null
+++ b/drivers/clk/sprd/ccu_div.c
@@ -0,0 +1,93 @@
+/*
+ * Spreadtrum divider clock driver
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/clk-provider.h>
+
+#include "ccu_div.h"
+
+DEFINE_SPINLOCK(div_lock);
+
+long ccu_div_helper_round_rate(struct ccu_common *common,
+			       struct ccu_div_internal *div,
+			       unsigned long rate,
+			       unsigned long *parent_rate)
+{
+	return divider_round_rate(&common->hw, rate, parent_rate,
+				  NULL, div->width, 0);
+}
+
+static long ccu_div_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *parent_rate)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_div_helper_round_rate(&cd->common, &cd->div,
+					 rate, parent_rate);
+}
+
+unsigned long ccu_div_helper_recalc_rate(struct ccu_common *common,
+					 struct ccu_div_internal *div,
+					 unsigned long parent_rate)
+{
+	unsigned long val;
+	u32 reg;
+
+	reg = ccu_readl(common);
+	val = reg >> div->shift;
+	val &= (1 << div->width) - 1;
+
+	return divider_recalc_rate(&common->hw, parent_rate, val, NULL, 0);
+}
+
+static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_div_helper_recalc_rate(&cd->common, &cd->div, parent_rate);
+}
+
+int ccu_div_helper_set_rate(struct ccu_common *common,
+			    struct ccu_div_internal *div,
+			    unsigned long rate,
+			    unsigned long parent_rate)
+{
+	unsigned long flags;
+	unsigned long val;
+	u32 reg;
+
+	val = divider_get_val(rate, parent_rate, NULL,
+				div->width, 0);
+
+	spin_lock_irqsave(common->lock, flags);
+
+	reg = ccu_readl(common);
+	reg &= ~GENMASK(div->width + div->shift - 1, div->shift);
+
+	ccu_writel(reg | (val << div->shift), common);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return 0;
+
+}
+
+static int ccu_div_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct ccu_div *cd = hw_to_ccu_div(hw);
+
+	return ccu_div_helper_set_rate(&cd->common, &cd->div,
+				       rate, parent_rate);
+}
+
+const struct clk_ops ccu_div_ops = {
+	.recalc_rate = ccu_div_recalc_rate,
+	.round_rate = ccu_div_round_rate,
+	.set_rate = ccu_div_set_rate,
+};
diff --git a/drivers/clk/sprd/ccu_div.h b/drivers/clk/sprd/ccu_div.h
new file mode 100644
index 0000000..cb13ed7
--- /dev/null
+++ b/drivers/clk/sprd/ccu_div.h
@@ -0,0 +1,77 @@
+/*
+ * Spreadtrum divider clock driver
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _CCU_DIV_H_
+#define _CCU_DIV_H_
+
+#include "ccu_common.h"
+
+/**
+ * struct ccu_div_internal - Internal divider description
+ * @shift: Bit offset of the divider in its register
+ * @width: Width of the divider field in its register
+ *
+ * That structure represents a single divider, and is meant to be
+ * embedded in other structures representing the various clock
+ * classes.
+ */
+struct ccu_div_internal {
+	u8	shift;
+	u8	width;
+};
+
+#define _SPRD_CCU_DIV(_shift, _width)	\
+	{				\
+		.shift	= _shift,	\
+		.width	= _width,	\
+	}
+
+struct ccu_div {
+	struct ccu_div_internal	div;
+	struct ccu_common	common;
+};
+
+#define SPRD_CCU_DIV(_struct, _name, _parent, _reg,			\
+			_shift, _width, _flags)				\
+	struct ccu_div _struct = {					\
+		.div	= _SPRD_CCU_DIV(_shift, _width),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.lock		= &div_lock,			\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_div_ops,	\
+						      _flags),		\
+		}							\
+	}
+
+static inline struct ccu_div *hw_to_ccu_div(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_div, common);
+}
+
+long ccu_div_helper_round_rate(struct ccu_common *common,
+			       struct ccu_div_internal *div,
+			       unsigned long rate,
+			       unsigned long *parent_rate);
+
+unsigned long ccu_div_helper_recalc_rate(struct ccu_common *common,
+					 struct ccu_div_internal *div,
+					 unsigned long parent_rate);
+
+int ccu_div_helper_set_rate(struct ccu_common *common,
+			    struct ccu_div_internal *div,
+			    unsigned long rate,
+			    unsigned long parent_rate);
+
+extern const struct clk_ops ccu_div_ops;
+extern spinlock_t div_lock;
+
+#endif /* _CCU_DIV_H_ */
-- 
2.7.4
