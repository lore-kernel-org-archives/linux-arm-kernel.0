From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  8 May 2016 22:01:38 +0200
Subject: [PATCH 03/16] clk: sunxi-ng: Add fixed factor clock support
In-Reply-To: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1462737711-10017-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks in the Allwinner SoCs clock units are direct, fixed,
multipliers or dividers from their parent.

Add support for such clocks.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/Makefile           |  2 ++
 drivers/clk/sunxi-ng/ccu_fixed_factor.c | 42 +++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_fixed_factor.h | 50 +++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_fixed_factor.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_fixed_factor.h

diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index bd3461b0f38c..d76276736765 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -1,2 +1,4 @@
 obj-y += ccu_common.o
 obj-y += ccu_reset.o
+
+obj-y += ccu_fixed_factor.o
diff --git a/drivers/clk/sunxi-ng/ccu_fixed_factor.c b/drivers/clk/sunxi-ng/ccu_fixed_factor.c
new file mode 100644
index 000000000000..75df8a854db5
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_fixed_factor.c
@@ -0,0 +1,42 @@
+/*
+ * Copyright (C) 2016 Maxime Ripard
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/clk-provider.h>
+
+#include "ccu_fixed_factor.h"
+
+static unsigned long ccu_fixed_factor_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct ccu_fixed_factor *fix = hw_to_ccu_fixed_factor(hw);
+
+	return parent_rate * fix->mult / fix->div;
+}
+
+static long ccu_fixed_factor_round_rate(struct clk_hw *hw,
+					unsigned long rate,
+					unsigned long *parent_rate)
+{
+	struct ccu_fixed_factor *fix = hw_to_ccu_fixed_factor(hw);
+
+	return *parent_rate / fix->div * fix->mult;
+}
+
+static int ccu_fixed_factor_set_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long parent_rate)
+{
+	return 0;
+}
+
+const struct clk_ops ccu_fixed_factor_ops = {
+	.recalc_rate	= ccu_fixed_factor_recalc_rate,
+	.round_rate	= ccu_fixed_factor_round_rate,
+	.set_rate	= ccu_fixed_factor_set_rate,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_fixed_factor.h b/drivers/clk/sunxi-ng/ccu_fixed_factor.h
new file mode 100644
index 000000000000..4e53dbc9d10b
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_fixed_factor.h
@@ -0,0 +1,50 @@
+/*
+ * Copyright (c) 2016 Maxime Ripard. All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _CCU_FIXED_FACTOR_H_
+#define _CCU_FIXED_FACTOR_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+
+struct ccu_fixed_factor {
+	u16			div;
+	u16			mult;
+
+	struct ccu_common	common;
+};
+
+#define SUNXI_CCU_FIXED_FACTOR(_struct, _name, _parent,			\
+			       _div, _mult, _flags)			\
+	struct ccu_fixed_factor _struct = {				\
+		.div	= _div,						\
+		.mult	= _mult,					\
+		.common	= {						\
+			.hw.init	= SUNXI_HW_INIT(_name,		\
+							_parent,	\
+							&ccu_fixed_factor_ops, \
+							_flags),	\
+		},							\
+	}
+
+static inline struct ccu_fixed_factor *hw_to_ccu_fixed_factor(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_fixed_factor, common);
+}
+
+extern const struct clk_ops ccu_fixed_factor_ops;
+
+#endif /* _CCU_FIXED_FACTOR_H_ */
-- 
2.8.2
