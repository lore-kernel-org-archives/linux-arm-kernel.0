From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Jun 2016 21:05:31 +0200
Subject: [PATCH v3 10/14] clk: sunxi-ng: Add N-M-factor clock support
In-Reply-To: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
References: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
Message-ID: <20160629190535.11855-11-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce support for clocks that multiply and divide using linear factors.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/Kconfig  |   6 +++
 drivers/clk/sunxi-ng/Makefile |   1 +
 drivers/clk/sunxi-ng/ccu_nm.c | 114 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_nm.h |  91 +++++++++++++++++++++++++++++++++
 4 files changed, 212 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_nm.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_nm.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 2eb0fc6b41d5..d8a5da270778 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -28,6 +28,12 @@ config SUNXI_CCU_NK
 	bool
 	select SUNXI_CCU_GATE
 
+config SUNXI_CCU_NM
+	bool
+	select RATIONAL
+	select SUNXI_CCU_FRAC
+	select SUNXI_CCU_GATE
+
 config SUNXI_CCU_MP
 	bool
 	select SUNXI_CCU_GATE
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 22951e60f876..7d2cd2a47a39 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -11,4 +11,5 @@ obj-$(CONFIG_SUNXI_CCU_PHASE)	+= ccu_phase.o
 
 # Multi-factor clocks
 obj-$(CONFIG_SUNXI_CCU_NK)	+= ccu_nk.o
+obj-$(CONFIG_SUNXI_CCU_NM)	+= ccu_nm.o
 obj-$(CONFIG_SUNXI_CCU_MP)	+= ccu_mp.o
diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
new file mode 100644
index 000000000000..e35ddd8eec8b
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -0,0 +1,114 @@
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
+#include "ccu_frac.h"
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
+	if (ccu_frac_helper_is_enabled(&nm->common, &nm->frac))
+		return ccu_frac_helper_read_rate(&nm->common, &nm->frac);
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
+				    1 << nm->n.width, 1 << nm->m.width,
+				    &n, &m);
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
+	if (ccu_frac_helper_has_rate(&nm->common, &nm->frac, rate))
+		return ccu_frac_helper_set_rate(&nm->common, &nm->frac, rate);
+	else
+		ccu_frac_helper_disable(&nm->common, &nm->frac);
+
+	rational_best_approximation(rate, parent_rate,
+				    1 << nm->n.width, 1 << nm->m.width,
+				    &n, &m);
+
+	spin_lock_irqsave(nm->common.lock, flags);
+
+	reg = readl(nm->common.base + nm->common.reg);
+	reg &= ~GENMASK(nm->n.width + nm->n.shift - 1, nm->n.shift);
+	reg &= ~GENMASK(nm->m.width + nm->m.shift - 1, nm->m.shift);
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
index 000000000000..0b7bcd33a2df
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_nm.h
@@ -0,0 +1,91 @@
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
+#include "ccu_common.h"
+#include "ccu_div.h"
+#include "ccu_frac.h"
+#include "ccu_mult.h"
+
+/*
+ * struct ccu_nm - Definition of an N-M clock
+ *
+ * Clocks based on the formula parent * N / M
+ */
+struct ccu_nm {
+	u32			enable;
+	u32			lock;
+
+	struct _ccu_mult	n;
+	struct _ccu_div		m;
+	struct _ccu_frac	frac;
+
+	struct ccu_common	common;
+};
+
+#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(_struct, _name, _parent, _reg,	\
+					 _nshift, _nwidth,		\
+					 _mshift, _mwidth,		\
+					 _frac_en, _frac_sel,		\
+					 _frac_rate_0, _frac_rate_1,	\
+					 _gate, _lock, _flags)		\
+	struct ccu_nm _struct = {					\
+		.enable		= _gate,				\
+		.lock		= _lock,				\
+		.n		= _SUNXI_CCU_MULT(_nshift, _nwidth),	\
+		.m		= _SUNXI_CCU_DIV(_mshift, _mwidth),	\
+		.frac		= _SUNXI_CCU_FRAC(_frac_en, _frac_sel,	\
+						  _frac_rate_0,		\
+						  _frac_rate_1),	\
+		.common		= {					\
+			.reg		= _reg,				\
+			.features	= CCU_FEATURE_FRACTIONAL,	\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_nm_ops,	\
+						      _flags),		\
+		},							\
+	}
+
+#define SUNXI_CCU_NM_WITH_GATE_LOCK(_struct, _name, _parent, _reg,	\
+				    _nshift, _nwidth,			\
+				    _mshift, _mwidth,			\
+				    _gate, _lock, _flags)		\
+	struct ccu_nm _struct = {					\
+		.enable		= _gate,				\
+		.lock		= _lock,				\
+		.n		= _SUNXI_CCU_MULT(_nshift, _nwidth),	\
+		.m		= _SUNXI_CCU_DIV(_mshift, _mwidth),	\
+		.common		= {					\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_nm_ops,	\
+						      _flags),		\
+		},							\
+	}
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
2.9.0
