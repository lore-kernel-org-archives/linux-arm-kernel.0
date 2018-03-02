From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Fri,  2 Mar 2018 11:18:56 +0530
Subject: [PATCH v4 07/11] clk: actions: Add divider clock support
In-Reply-To: <20180302054900.11275-1-manivannan.sadhasivam@linaro.org>
References: <20180302054900.11275-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180302054900.11275-8-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Actions Semi divider clock together with
helper functions to be used in composite clock.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/Makefile      |  1 +
 drivers/clk/actions/owl-divider.c | 94 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/actions/owl-divider.h | 75 +++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 drivers/clk/actions/owl-divider.c
 create mode 100644 drivers/clk/actions/owl-divider.h

diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
index 2d4aa8f35d90..5ce75df57e1a 100644
--- a/drivers/clk/actions/Makefile
+++ b/drivers/clk/actions/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_CLK_ACTIONS)	+= clk-owl.o
 clk-owl-y			+= owl-common.o
 clk-owl-y			+= owl-gate.o
 clk-owl-y			+= owl-mux.o
+clk-owl-y			+= owl-divider.o
diff --git a/drivers/clk/actions/owl-divider.c b/drivers/clk/actions/owl-divider.c
new file mode 100644
index 000000000000..cddac00fe324
--- /dev/null
+++ b/drivers/clk/actions/owl-divider.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL divider clock driver
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Author: David Liu <liuwei@actions-semi.com>
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+
+#include "owl-divider.h"
+
+long owl_divider_helper_round_rate(struct owl_clk_common *common,
+				const struct owl_divider_hw *div_hw,
+				unsigned long rate,
+				unsigned long *parent_rate)
+{
+	return divider_round_rate(&common->hw, rate, parent_rate,
+				  div_hw->table, div_hw->width,
+				  div_hw->div_flags);
+}
+
+static long owl_divider_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *parent_rate)
+{
+	struct owl_divider *div = hw_to_owl_divider(hw);
+
+	return owl_divider_helper_round_rate(&div->common, &div->div_hw,
+					     rate, parent_rate);
+}
+
+unsigned long owl_divider_helper_recalc_rate(struct owl_clk_common *common,
+					 const struct owl_divider_hw *div_hw,
+					 unsigned long parent_rate)
+{
+	unsigned long val;
+	unsigned int reg;
+
+	regmap_read(common->regmap, div_hw->reg, &reg);
+	val = reg >> div_hw->shift;
+	val &= (1 << div_hw->width) - 1;
+
+	return divider_recalc_rate(&common->hw, parent_rate,
+				   val, div_hw->table,
+				   div_hw->div_flags,
+				   div_hw->width);
+}
+
+static unsigned long owl_divider_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct owl_divider *div = hw_to_owl_divider(hw);
+
+	return owl_divider_helper_recalc_rate(&div->common,
+					      &div->div_hw, parent_rate);
+}
+
+int owl_divider_helper_set_rate(const struct owl_clk_common *common,
+				const struct owl_divider_hw *div_hw,
+				unsigned long rate,
+				unsigned long parent_rate)
+{
+	unsigned long val;
+	unsigned int reg;
+
+	val = divider_get_val(rate, parent_rate, div_hw->table,
+			      div_hw->width, 0);
+
+	regmap_read(common->regmap, div_hw->reg, &reg);
+	reg &= ~GENMASK(div_hw->width + div_hw->shift - 1, div_hw->shift);
+
+	regmap_write(common->regmap, div_hw->reg,
+			  reg | (val << div_hw->shift));
+
+	return 0;
+}
+
+static int owl_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct owl_divider *div = hw_to_owl_divider(hw);
+
+	return owl_divider_helper_set_rate(&div->common, &div->div_hw,
+					rate, parent_rate);
+}
+
+const struct clk_ops owl_divider_ops = {
+	.recalc_rate = owl_divider_recalc_rate,
+	.round_rate = owl_divider_round_rate,
+	.set_rate = owl_divider_set_rate,
+};
diff --git a/drivers/clk/actions/owl-divider.h b/drivers/clk/actions/owl-divider.h
new file mode 100644
index 000000000000..92d3e3d23967
--- /dev/null
+++ b/drivers/clk/actions/owl-divider.h
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL divider clock driver
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Author: David Liu <liuwei@actions-semi.com>
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#ifndef _OWL_DIVIDER_H_
+#define _OWL_DIVIDER_H_
+
+#include "owl-common.h"
+
+struct owl_divider_hw {
+	u32			reg;
+	u8			shift;
+	u8			width;
+	u8			div_flags;
+	struct clk_div_table	*table;
+};
+
+struct owl_divider {
+	struct owl_divider_hw	div_hw;
+	struct owl_clk_common	common;
+};
+
+#define OWL_DIVIDER_HW(_reg, _shift, _width, _div_flags, _table)	\
+	{								\
+		.reg		= _reg,					\
+		.shift		= _shift,				\
+		.width		= _width,				\
+		.div_flags	= _div_flags,				\
+		.table		= _table,				\
+	}
+
+#define OWL_DIVIDER(_struct, _name, _parent, _reg,			\
+		    _shift, _width, _table, _div_flags, _flags)		\
+	struct owl_divider _struct = {					\
+		.div_hw	= OWL_DIVIDER_HW(_reg, _shift, _width,		\
+					 _div_flags, _table),		\
+		.common = {						\
+			.regmap		= NULL,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &owl_divider_ops,	\
+						      _flags),		\
+		},							\
+	}
+
+static inline struct owl_divider *hw_to_owl_divider(const struct clk_hw *hw)
+{
+	struct owl_clk_common *common = hw_to_owl_clk_common(hw);
+
+	return container_of(common, struct owl_divider, common);
+}
+
+long owl_divider_helper_round_rate(struct owl_clk_common *common,
+				const struct owl_divider_hw *div_hw,
+				unsigned long rate,
+				unsigned long *parent_rate);
+
+unsigned long owl_divider_helper_recalc_rate(struct owl_clk_common *common,
+					 const struct owl_divider_hw *div_hw,
+					 unsigned long parent_rate);
+
+int owl_divider_helper_set_rate(const struct owl_clk_common *common,
+				const struct owl_divider_hw *div_hw,
+				unsigned long rate,
+				unsigned long parent_rate);
+
+extern const struct clk_ops owl_divider_ops;
+
+#endif /* _OWL_DIVIDER_H_ */
-- 
2.14.1
