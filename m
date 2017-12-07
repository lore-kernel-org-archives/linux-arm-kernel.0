From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Thu, 7 Dec 2017 20:57:08 +0800
Subject: [PATCH V7 05/12] clk: sprd: add divider clock support
In-Reply-To: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
References: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20171207125715.16160-6-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a feature that can also be found in sprd composite clocks,
provide a bunch of helpers that can be reused later on.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/sprd/Makefile |  1 +
 drivers/clk/sprd/div.c    | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/div.h    | 75 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)
 create mode 100644 drivers/clk/sprd/div.c
 create mode 100644 drivers/clk/sprd/div.h

diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
index cee36b5..80e6039 100644
--- a/drivers/clk/sprd/Makefile
+++ b/drivers/clk/sprd/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_SPRD_COMMON_CLK)	+= clk-sprd.o
 clk-sprd-y	+= common.o
 clk-sprd-y	+= gate.o
 clk-sprd-y	+= mux.o
+clk-sprd-y	+= div.o
diff --git a/drivers/clk/sprd/div.c b/drivers/clk/sprd/div.c
new file mode 100644
index 0000000..887a863
--- /dev/null
+++ b/drivers/clk/sprd/div.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Spreadtrum divider clock driver
+//
+// Copyright (C) 2017 Spreadtrum, Inc.
+// Author: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
+
+#include <linux/clk-provider.h>
+
+#include "div.h"
+
+long sprd_div_helper_round_rate(struct sprd_clk_common *common,
+				const struct sprd_div_internal *div,
+				unsigned long rate,
+				unsigned long *parent_rate)
+{
+	return divider_round_rate(&common->hw, rate, parent_rate,
+				  NULL, div->width, 0);
+}
+EXPORT_SYMBOL_GPL(sprd_div_helper_round_rate);
+
+static long sprd_div_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *parent_rate)
+{
+	struct sprd_div *cd = hw_to_sprd_div(hw);
+
+	return sprd_div_helper_round_rate(&cd->common, &cd->div,
+					  rate, parent_rate);
+}
+
+unsigned long sprd_div_helper_recalc_rate(struct sprd_clk_common *common,
+					  const struct sprd_div_internal *div,
+					  unsigned long parent_rate)
+{
+	unsigned long val;
+	unsigned int reg;
+
+	regmap_read(common->regmap, common->reg, &reg);
+	val = reg >> div->shift;
+	val &= (1 << div->width) - 1;
+
+	return divider_recalc_rate(&common->hw, parent_rate, val, NULL, 0);
+}
+EXPORT_SYMBOL_GPL(sprd_div_helper_recalc_rate);
+
+static unsigned long sprd_div_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct sprd_div *cd = hw_to_sprd_div(hw);
+
+	return sprd_div_helper_recalc_rate(&cd->common, &cd->div, parent_rate);
+}
+
+int sprd_div_helper_set_rate(const struct sprd_clk_common *common,
+			     const struct sprd_div_internal *div,
+			     unsigned long rate,
+			     unsigned long parent_rate)
+{
+	unsigned long val;
+	unsigned int reg;
+
+	val = divider_get_val(rate, parent_rate, NULL,
+			      div->width, 0);
+
+	regmap_read(common->regmap, common->reg, &reg);
+	reg &= ~GENMASK(div->width + div->shift - 1, div->shift);
+
+	regmap_write(common->regmap, common->reg,
+			  reg | (val << div->shift));
+
+	return 0;
+
+}
+EXPORT_SYMBOL_GPL(sprd_div_helper_set_rate);
+
+static int sprd_div_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	struct sprd_div *cd = hw_to_sprd_div(hw);
+
+	return sprd_div_helper_set_rate(&cd->common, &cd->div,
+					rate, parent_rate);
+}
+
+const struct clk_ops sprd_div_ops = {
+	.recalc_rate = sprd_div_recalc_rate,
+	.round_rate = sprd_div_round_rate,
+	.set_rate = sprd_div_set_rate,
+};
+EXPORT_SYMBOL_GPL(sprd_div_ops);
diff --git a/drivers/clk/sprd/div.h b/drivers/clk/sprd/div.h
new file mode 100644
index 0000000..b3033d2
--- /dev/null
+++ b/drivers/clk/sprd/div.h
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Spreadtrum divider clock driver
+//
+// Copyright (C) 2017 Spreadtrum, Inc.
+// Author: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
+
+#ifndef _SPRD_DIV_H_
+#define _SPRD_DIV_H_
+
+#include "common.h"
+
+/**
+ * struct sprd_div_internal - Internal divider description
+ * @shift: Bit offset of the divider in its register
+ * @width: Width of the divider field in its register
+ *
+ * That structure represents a single divider, and is meant to be
+ * embedded in other structures representing the various clock
+ * classes.
+ */
+struct sprd_div_internal {
+	u8	shift;
+	u8	width;
+};
+
+#define _SPRD_DIV_CLK(_shift, _width)	\
+	{				\
+		.shift	= _shift,	\
+		.width	= _width,	\
+	}
+
+struct sprd_div {
+	struct sprd_div_internal	div;
+	struct sprd_clk_common	common;
+};
+
+#define SPRD_DIV_CLK(_struct, _name, _parent, _reg,			\
+			_shift, _width, _flags)				\
+	struct sprd_div _struct = {					\
+		.div	= _SPRD_DIV_CLK(_shift, _width),		\
+		.common	= {						\
+			.regmap		= NULL,				\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &sprd_div_ops,	\
+						      _flags),		\
+		}							\
+	}
+
+static inline struct sprd_div *hw_to_sprd_div(const struct clk_hw *hw)
+{
+	struct sprd_clk_common *common = hw_to_sprd_clk_common(hw);
+
+	return container_of(common, struct sprd_div, common);
+}
+
+long sprd_div_helper_round_rate(struct sprd_clk_common *common,
+				const struct sprd_div_internal *div,
+				unsigned long rate,
+				unsigned long *parent_rate);
+
+unsigned long sprd_div_helper_recalc_rate(struct sprd_clk_common *common,
+					  const struct sprd_div_internal *div,
+					  unsigned long parent_rate);
+
+int sprd_div_helper_set_rate(const struct sprd_clk_common *common,
+			     const struct sprd_div_internal *div,
+			     unsigned long rate,
+			     unsigned long parent_rate);
+
+extern const struct clk_ops sprd_div_ops;
+
+#endif /* _SPRD_DIV_H_ */
-- 
2.7.4
