From: moinejf@free.fr (Jean-Francois Moine)
Date: Sat, 11 Jun 2016 18:23:52 +0200
Subject: [PATCH v2 1/3] clk: sunxi-ng: Add N-D-M-P-factor clock support
In-Reply-To: <cover.1465666788.git.moinejf@free.fr>
References: <cover.1465666788.git.moinejf@free.fr>
Message-ID: <5ef2054fab9087d6f6ca7a0b4fea699db5b1dca7.1465666788.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce support for the PLL clocks of the A83T and A80 SoCs
which are set from N, D1, D2, M and P factors.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/clk/sunxi-ng/Makefile     |   1 +
 drivers/clk/sunxi-ng/ccu_common.h |   1 +
 drivers/clk/sunxi-ng/ccu_ndmp.c   | 239 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_ndmp.h   |  96 +++++++++++++++
 4 files changed, 337 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_ndmp.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_ndmp.h

diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index cafabf0..f0608cb 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -8,6 +8,7 @@ obj-y += ccu_fixed_factor.o
 obj-y += ccu_gate.o
 obj-y += ccu_mp.o
 obj-y += ccu_mux.o
+obj-y += ccu_ndmp.o
 obj-y += ccu_nk.o
 obj-y += ccu_nkm.o
 obj-y += ccu_nkmp.o
diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index fda2450..df3ae5e 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -23,6 +23,7 @@
 #define CCU_FEATURE_VARIABLE_PREDIV	BIT(3)
 #define CCU_FEATURE_FIXED_PREDIV	BIT(4)
 #define CCU_FEATURE_FIXED_POSTDIV	BIT(5)
+#define CCU_FEATURE_N1			BIT(6)
 
 struct device_node;
 
diff --git a/drivers/clk/sunxi-ng/ccu_ndmp.c b/drivers/clk/sunxi-ng/ccu_ndmp.c
new file mode 100644
index 0000000..5481527
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_ndmp.c
@@ -0,0 +1,239 @@
+/*
+ * PLL clocks of sun8iw6 (A83T) and sun9iw1 (A80)
+ *
+ * Copyright (c) 2016 Jean-Francois Moine <moinejf@free.fr>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * The clock rates are computed as:
+ *	rate = parent_rate / d1 * n / d2 / m >> p
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/rational.h>
+#include <linux/iopoll.h>
+
+#include "ccu_gate.h"
+#include "ccu_ndmp.h"
+
+struct values {
+	int n, d1, d2, m, p;
+};
+
+static void ccu_ndmp_disable(struct clk_hw *hw)
+{
+	struct ccu_ndmp *ndmp = hw_to_ccu_ndmp(hw);
+
+	return ccu_gate_helper_disable(&ndmp->common, ndmp->enable);
+}
+
+static int ccu_ndmp_enable(struct clk_hw *hw)
+{
+	struct ccu_ndmp *ndmp = hw_to_ccu_ndmp(hw);
+
+	return ccu_gate_helper_enable(&ndmp->common, ndmp->enable);
+}
+
+static int ccu_ndmp_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_ndmp *ndmp = hw_to_ccu_ndmp(hw);
+
+	return ccu_gate_helper_is_enabled(&ndmp->common, ndmp->enable);
+}
+
+static unsigned long ccu_ndmp_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct ccu_ndmp *ndmp = hw_to_ccu_ndmp(hw);
+	int n, d1, d2, m, p;
+	unsigned long rate;
+	u32 reg;
+
+	reg = readl(ndmp->common.base + ndmp->common.reg);
+
+	rate = parent_rate;
+
+	if (ndmp->d1.width) {
+		d1 = reg >> ndmp->d1.shift;
+		d1 &= (1 << ndmp->d1.width) - 1;
+		rate /= (d1 + 1);
+	}
+
+	n = reg >> ndmp->n.shift;
+	n &= (1 << ndmp->n.width) - 1;
+	if (ndmp->common.features & CCU_FEATURE_N1)
+		n++;
+	rate *= n;
+
+	if (ndmp->d2.width) {
+		d2 = reg >> ndmp->d2.shift;
+		d2 &= (1 << ndmp->d2.width) - 1;
+		rate /= (d2 + 1);
+	}
+
+	if (ndmp->m.width) {
+		m = reg >> ndmp->m.shift;
+		m &= (1 << ndmp->m.width) - 1;
+		rate /= (m + 1);
+	}
+
+	if (ndmp->p.width) {
+		p = reg >> ndmp->p.shift;
+		p &= (1 << ndmp->p.width) - 1;
+		rate >>= p;
+	}
+
+	return rate;
+}
+
+/* all returned values are set here */
+/* d1 and d2 may be only 1 or 2 */
+static int ccu_ndmp_get_fact(struct ccu_ndmp *ndmp,
+			unsigned long rate, unsigned long prate,
+			struct values *p_v)
+{
+	int n;
+	int d1 = 0 + 1, d2 = 0 + 1, m = 1, p = 0, d;
+	unsigned long t;
+
+	/* m implies only n, d1, d2 and m (pll-audio) */
+	/*
+	 * Setting d1=1 and d2=2 keeps n and m small enough
+	 *	with error < 5/10000
+	 */
+	if (ndmp->m.width) {
+		unsigned long lun, lum;
+
+		d2 = 1 + 1;
+		t = prate / 2;
+		rational_best_approximation(rate, t,
+					1 << ndmp->n.width,
+					1 << ndmp->m.width,
+					&lun, &lum);
+		if (lum == 0)
+			return -EINVAL;
+		n = lun;
+		m = lum;
+
+	/* no d1 implies only n and p (pll-cxcpux) */
+	} else if (!ndmp->d1.width) {
+		n = rate / prate;
+		p = 0;		/* p is used only for rates under 288 MHz */
+
+	/* p implies only n, d1 and p (pll-videox) */
+	} else if (ndmp->p.width) {
+		d = 2 + ndmp->p.width;
+		n = rate / (prate / (1 << d));
+		if (n < 12) {
+			n *= 2;
+			d++;
+		}
+		while (n >= 12 * 2 && !(n & 1)) {
+			n /= 2;
+			if (--d == 0)
+				break;
+		}
+		if (d <= 1) {
+			d1 = d + 1;
+		} else {
+			d1 = 1 + 1;
+			p = d - 1;
+		}
+
+	/* only n, d1 and d2 (other plls) */
+	} else {
+		t = prate / 4;
+		n = rate / t;
+		if (n < 12) {
+			n *= 4;
+		} else if (n >= 12 * 2 && !(n & 1)) {
+			if (n >= 12 * 4 && !(n & 3)) {
+				n /= 4;
+			} else {
+				n /= 2;
+				d2 = 1 + 1;
+			}
+		} else {
+			d1 = d2 = 1 + 1;
+		}
+		if (n > (1 << ndmp->n.width))
+			return -EINVAL;
+	}
+
+	if (n < 12 || n > (1 << ndmp->n.width))
+		return -EINVAL;
+
+	p_v->n = n;
+	p_v->d1 = d1;
+	p_v->d2 = d2;
+	p_v->m = m;
+	p_v->p = p;
+
+	return 0;
+}
+
+static long ccu_ndmp_round_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long *parent_rate)
+{
+	struct ccu_ndmp *ndmp = hw_to_ccu_ndmp(hw);
+	struct values v;
+	int ret;
+
+	ret = ccu_ndmp_get_fact(ndmp, rate, *parent_rate, &v);
+	if (ret)
+		return 0;
+
+	return *parent_rate / v.d1 * v.n / v.d2 / v.m >> v.p;
+}
+
+static int ccu_ndmp_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long parent_rate)
+{
+	struct ccu_ndmp *ndmp = hw_to_ccu_ndmp(hw);
+	unsigned long flags;
+	struct values v;
+	int ret;
+	u32 reg;
+
+	ret = ccu_ndmp_get_fact(ndmp, rate, parent_rate, &v);
+	if (ret)
+		return ret;
+	if (ndmp->common.features & CCU_FEATURE_N1)
+		v.n--;
+
+	spin_lock_irqsave(ndmp->common.lock, flags);
+
+	reg = readl(ndmp->common.base + ndmp->common.reg) &
+		~((((1 << ndmp->n.width) - 1) << ndmp->n.shift) |
+		  (((1 << ndmp->d1.width) - 1) << ndmp->d1.shift) |
+		  (((1 << ndmp->d2.width) - 1) << ndmp->d2.shift) |
+		  (((1 << ndmp->m.width) - 1) << ndmp->m.shift) |
+		  (((1 << ndmp->p.width) - 1) << ndmp->p.shift));
+
+	writel(reg | (v.n << ndmp->n.shift) |
+			((v.d1 - 1) << ndmp->d1.shift) |
+			((v.d2 - 1) << ndmp->d2.shift) |
+			((v.m - 1) << ndmp->m.shift) |
+			(v.p << ndmp->p.shift),
+	       ndmp->common.base + ndmp->common.reg);
+
+	spin_unlock_irqrestore(ndmp->common.lock, flags);
+
+	WARN_ON(readl_relaxed_poll_timeout(ndmp->common.base + ndmp->reg_lock,
+					   reg, !(reg & ndmp->lock), 50, 5000));
+
+	return 0;
+}
+
+const struct clk_ops ccu_ndmp_ops = {
+	.disable	= ccu_ndmp_disable,
+	.enable		= ccu_ndmp_enable,
+	.is_enabled	= ccu_ndmp_is_enabled,
+
+	.recalc_rate	= ccu_ndmp_recalc_rate,
+	.round_rate	= ccu_ndmp_round_rate,
+	.set_rate	= ccu_ndmp_set_rate,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_ndmp.h b/drivers/clk/sunxi-ng/ccu_ndmp.h
new file mode 100644
index 0000000..5341861
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_ndmp.h
@@ -0,0 +1,96 @@
+/*
+ * Copyright (c) 2016 Jean-Francois Moine <moinejf@free.fr>
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
+#ifndef _CCU_NDMP_H_
+#define _CCU_NDMP_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+#include "ccu_mult.h"
+
+struct ccu_ndmp {
+	u32			enable;
+	u32			lock;
+	u16			reg_lock;
+
+	struct _ccu_mult	n;
+	struct _ccu_mult	d1;
+	struct _ccu_mult	d2;
+	struct _ccu_mult	m;
+	struct _ccu_mult	p;
+
+	struct ccu_common	common;
+};
+
+#define SUNXI_CCU_NDMP(_struct, _name, _parent, _reg,			\
+			_nshift, _nwidth,				\
+			_d1shift, _d1width,				\
+			_d2shift, _d2width,				\
+			_mshift, _mwidth,				\
+			_pshift, _pwidth,				\
+			_gate, _lock, _reglock, _flags)			\
+	struct ccu_ndmp _struct = {					\
+		.enable		= _gate,				\
+		.lock		= _lock,				\
+		.reg_lock	= _reglock,				\
+		.n		= _SUNXI_CCU_MULT(_nshift, _nwidth),	\
+		.d1		= _SUNXI_CCU_MULT(_d1shift, _d1width),	\
+		.d2		= _SUNXI_CCU_MULT(_d2shift, _d2width),	\
+		.m		= _SUNXI_CCU_MULT(_mshift, _mwidth),	\
+		.p		= _SUNXI_CCU_MULT(_pshift, _pwidth),	\
+		.common		= {					\
+			.reg		= _reg,				\
+			.hw.init	= SUNXI_HW_INIT(_name,		\
+							_parent,	\
+							&ccu_ndmp_ops,	\
+							_flags),	\
+		},							\
+	}
+
+#define SUNXI_CCU_NDMP_N1(_struct, _name, _parent, _reg,		\
+			_nshift, _nwidth,				\
+			_d1shift, _d1width,				\
+			_d2shift, _d2width,				\
+			_mshift, _mwidth,				\
+			_pshift, _pwidth,				\
+			_gate, _lock, _reglock, _flags)			\
+	struct ccu_ndmp _struct = {					\
+		.enable		= _gate,				\
+		.lock		= _lock,				\
+		.reg_lock	= _reglock,				\
+		.n		= _SUNXI_CCU_MULT(_nshift, _nwidth),	\
+		.d1		= _SUNXI_CCU_MULT(_d1shift, _d1width),	\
+		.d2		= _SUNXI_CCU_MULT(_d2shift, _d2width),	\
+		.m		= _SUNXI_CCU_MULT(_mshift, _mwidth),	\
+		.p		= _SUNXI_CCU_MULT(_pshift, _pwidth),	\
+		.common		= {					\
+			.reg		= _reg,				\
+			.features	= CCU_FEATURE_N1,		\
+			.hw.init	= SUNXI_HW_INIT(_name,		\
+							_parent,	\
+							&ccu_ndmp_ops,	\
+							_flags),	\
+		},							\
+	}
+
+static inline struct ccu_ndmp *hw_to_ccu_ndmp(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_ndmp, common);
+}
+
+extern const struct clk_ops ccu_ndmp_ops;
+
+#endif /* _CCU_NDMP_H_ */
-- 
2.8.4
