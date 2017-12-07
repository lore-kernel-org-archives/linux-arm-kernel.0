From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Thu, 7 Dec 2017 20:57:09 +0800
Subject: [PATCH V7 06/12] clk: sprd: add composite clock support
In-Reply-To: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
References: <20171207125715.16160-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20171207125715.16160-7-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduced composite driver for Spreadtrum's SoCs. The
functions of this composite clock simply consist of divider and
mux clocks.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/sprd/Makefile    |  1 +
 drivers/clk/sprd/composite.c | 60 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/composite.h | 51 +++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 drivers/clk/sprd/composite.c
 create mode 100644 drivers/clk/sprd/composite.h

diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
index 80e6039..2262e76 100644
--- a/drivers/clk/sprd/Makefile
+++ b/drivers/clk/sprd/Makefile
@@ -4,3 +4,4 @@ clk-sprd-y	+= common.o
 clk-sprd-y	+= gate.o
 clk-sprd-y	+= mux.o
 clk-sprd-y	+= div.o
+clk-sprd-y	+= composite.o
diff --git a/drivers/clk/sprd/composite.c b/drivers/clk/sprd/composite.c
new file mode 100644
index 0000000..ebb6448
--- /dev/null
+++ b/drivers/clk/sprd/composite.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Spreadtrum composite clock driver
+//
+// Copyright (C) 2017 Spreadtrum, Inc.
+// Author: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
+
+#include <linux/clk-provider.h>
+
+#include "composite.h"
+
+static long sprd_comp_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *parent_rate)
+{
+	struct sprd_comp *cc = hw_to_sprd_comp(hw);
+
+	return sprd_div_helper_round_rate(&cc->common, &cc->div,
+					 rate, parent_rate);
+}
+
+static unsigned long sprd_comp_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct sprd_comp *cc = hw_to_sprd_comp(hw);
+
+	return sprd_div_helper_recalc_rate(&cc->common, &cc->div, parent_rate);
+}
+
+static int sprd_comp_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	struct sprd_comp *cc = hw_to_sprd_comp(hw);
+
+	return sprd_div_helper_set_rate(&cc->common, &cc->div,
+				       rate, parent_rate);
+}
+
+static u8 sprd_comp_get_parent(struct clk_hw *hw)
+{
+	struct sprd_comp *cc = hw_to_sprd_comp(hw);
+
+	return sprd_mux_helper_get_parent(&cc->common, &cc->mux);
+}
+
+static int sprd_comp_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct sprd_comp *cc = hw_to_sprd_comp(hw);
+
+	return sprd_mux_helper_set_parent(&cc->common, &cc->mux, index);
+}
+
+const struct clk_ops sprd_comp_ops = {
+	.get_parent	= sprd_comp_get_parent,
+	.set_parent	= sprd_comp_set_parent,
+
+	.round_rate	= sprd_comp_round_rate,
+	.recalc_rate	= sprd_comp_recalc_rate,
+	.set_rate	= sprd_comp_set_rate,
+};
+EXPORT_SYMBOL_GPL(sprd_comp_ops);
diff --git a/drivers/clk/sprd/composite.h b/drivers/clk/sprd/composite.h
new file mode 100644
index 0000000..0984e9e
--- /dev/null
+++ b/drivers/clk/sprd/composite.h
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Spreadtrum composite clock driver
+//
+// Copyright (C) 2017 Spreadtrum, Inc.
+// Author: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
+
+#ifndef _SPRD_COMPOSITE_H_
+#define _SPRD_COMPOSITE_H_
+
+#include "common.h"
+#include "mux.h"
+#include "div.h"
+
+struct sprd_comp {
+	struct sprd_mux_ssel	mux;
+	struct sprd_div_internal	div;
+	struct sprd_clk_common	common;
+};
+
+#define SPRD_COMP_CLK_TABLE(_struct, _name, _parent, _reg, _table,	\
+			_mshift, _mwidth, _dshift, _dwidth, _flags)	\
+	struct sprd_comp _struct = {					\
+		.mux	= _SPRD_MUX_CLK(_mshift, _mwidth, _table),	\
+		.div	= _SPRD_DIV_CLK(_dshift, _dwidth),		\
+		.common = {						\
+			.regmap		= NULL,				\
+			.reg		= _reg,				\
+			.hw.init = CLK_HW_INIT_PARENTS(_name,		\
+						       _parent,		\
+						       &sprd_comp_ops,	\
+						       _flags),		\
+			 }						\
+	}
+
+#define SPRD_COMP_CLK(_struct, _name, _parent, _reg, _mshift,	\
+			_mwidth, _dshift, _dwidth, _flags)	\
+	SPRD_COMP_CLK_TABLE(_struct, _name, _parent, _reg,	\
+			    NULL, _mshift, _mwidth,		\
+			    _dshift, _dwidth, _flags)
+
+static inline struct sprd_comp *hw_to_sprd_comp(const struct clk_hw *hw)
+{
+	struct sprd_clk_common *common = hw_to_sprd_clk_common(hw);
+
+	return container_of(common, struct sprd_comp, common);
+}
+
+extern const struct clk_ops sprd_comp_ops;
+
+#endif /* _SPRD_COMPOSITE_H_ */
-- 
2.7.4
