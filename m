From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  8 May 2016 22:01:47 +0200
Subject: [PATCH 12/16] clk: sunxi-ng: Add N-M-factor clock support
In-Reply-To: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1462737711-10017-13-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce support for clocks that multiply and divide using linear factors.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/Makefile |   1 +
 drivers/clk/sunxi-ng/ccu_nm.c | 103 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_nm.h |  41 +++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_nm.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_nm.h

diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index e29ddae99653..fba64c7f4fcd 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -8,5 +8,6 @@ obj-y += ccu_m.o
 obj-y += ccu_mp.o
 obj-y += ccu_mux.o
 obj-y += ccu_nk.o
+obj-y += ccu_nm.o
 obj-y += ccu_p.o
 obj-y += ccu_phase.o
diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
new file mode 100644
index 000000000000..268637db137b
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -0,0 +1,103 @@
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
+#include <linux/rational.h>
+
+#include "ccu_gate.h"
+#include "ccu_nm.h"
+
+static void ccu_nm_disable(struct clk_hw *hw)
+{
+	struct ccu_nm *nm = hw_to_ccu_nm(hw);
+
+	return ccu_gate_helper_disable(&nm->common, nm->enable);
+}
+
+static int ccu_nm_enable(struct clk_hw *hw)
+{
+	struct ccu_nm *nm = hw_to_ccu_nm(hw);
+
+	return ccu_gate_helper_enable(&nm->common, nm->enable);
+}
+
+static int ccu_nm_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_nm *nm = hw_to_ccu_nm(hw);
+
+	return ccu_gate_helper_is_enabled(&nm->common, nm->enable);
+}
+
+static unsigned long ccu_nm_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct ccu_nm *nm = hw_to_ccu_nm(hw);
+	unsigned long n, m;
+	u32 reg;
+
+	reg = readl(nm->common.base + nm->common.reg);
+
+	n = reg >> nm->n.shift;
+	n &= (1 << nm->n.width) - 1;
+
+	m = reg >> nm->m.shift;
+	m &= (1 << nm->m.width) - 1;
+
+	return parent_rate * (n + 1) / (m + 1);
+}
+
+static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long *parent_rate)
+{
+	struct ccu_nm *nm = hw_to_ccu_nm(hw);
+	unsigned long n, m;
+
+	rational_best_approximation(rate, *parent_rate,
+				    nm->n.width, nm->m.width, &n, &m);
+
+	return *parent_rate * n / m;
+}
+
+static int ccu_nm_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long parent_rate)
+{
+	struct ccu_nm *nm = hw_to_ccu_nm(hw);
+	unsigned long flags;
+	unsigned long n, m;
+	u32 reg;
+
+	rational_best_approximation(rate, parent_rate,
+				    nm->n.width, nm->m.width, &n, &m);
+
+	spin_lock_irqsave(nm->common.lock, flags);
+
+	reg = readl(nm->common.base + nm->common.reg);
+	reg &= ~GENMASK(nm->n.width + nm->n.shift, nm->n.shift);
+	reg &= ~GENMASK(nm->m.width + nm->m.shift, nm->m.shift);
+
+	writel(reg | ((m - 1) << nm->m.shift) | ((n - 1) << nm->n.shift),
+	       nm->common.base + nm->common.reg);
+
+	spin_unlock_irqrestore(nm->common.lock, flags);
+
+	ccu_helper_wait_for_lock(&nm->common, nm->lock);
+
+	return 0;
+}
+
+const struct clk_ops ccu_nm_ops = {
+	.disable	= ccu_nm_disable,
+	.enable		= ccu_nm_enable,
+	.is_enabled	= ccu_nm_is_enabled,
+
+	.recalc_rate	= ccu_nm_recalc_rate,
+	.round_rate	= ccu_nm_round_rate,
+	.set_rate	= ccu_nm_set_rate,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_nm.h b/drivers/clk/sunxi-ng/ccu_nm.h
new file mode 100644
index 000000000000..6fda3ed05cd8
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_nm.h
@@ -0,0 +1,41 @@
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
+#ifndef _CCU_NM_H_
+#define _CCU_NM_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_factor.h"
+#include "ccu_common.h"
+
+struct ccu_nm {
+	u32			enable;
+	u32			lock;
+
+	struct ccu_factor	n;
+	struct ccu_factor	m;
+
+	struct ccu_common	common;
+};
+
+static inline struct ccu_nm *hw_to_ccu_nm(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_nm, common);
+}
+
+extern const struct clk_ops ccu_nm_ops;
+
+#endif /* _CCU_NM_H_ */
-- 
2.8.2
