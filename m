From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 31 May 2016 09:26:38 +0200
Subject: [PATCH RFC 1/2] clk: sunxi-ng: Add the A83T and A80 PLL clocks
In-Reply-To: <cover.1464680865.git.moinejf@free.fr>
References: <cover.1464680865.git.moinejf@free.fr>
Message-ID: <bbf3cefa47323660ead5ebdafe63f382fea06f39.1464680865.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T and A80 SoCs have unique settings of their PLL clocks.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/clk/sunxi-ng/ccu_ndmp.c | 247 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_ndmp.h |  45 ++++++++
 2 files changed, 292 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_ndmp.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_ndmp.h

diff --git a/drivers/clk/sunxi-ng/ccu_ndmp.c b/drivers/clk/sunxi-ng/ccu_ndmp.c
new file mode 100644
index 0000000..079b155
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_ndmp.c
@@ -0,0 +1,247 @@
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
+	if (ndmp->d1.shift) {
+		d1 = reg >> ndmp->d1.shift;
+		d1 &= (1 << ndmp->d1.width) - 1;
+		rate /= (d1 + 1);
+	}
+
+	n = reg >> ndmp->n.shift;
+	n &= (1 << ndmp->n.width) - 1;
+	if (!(ndmp->common.features & CCU_FEATURE_N0))
+		n++;
+	rate *= n;
+
+	if (ndmp->d2.shift) {
+		d2 = reg >> ndmp->d2.shift;
+		d2 &= (1 << ndmp->d2.width) - 1;
+		rate /= (d2 + 1);
+	}
+
+	if (ndmp->m.shift) {
+		m = reg >> ndmp->m.shift;
+		m &= (1 << ndmp->m.width) - 1;
+		rate /= (m + 1);
+	}
+
+	if (ndmp->p.shift) {
+		p = reg >> ndmp->p.shift;
+		p &= (1 << ndmp->p.width) - 1;
+		rate >>= p;
+	}
+
+	return rate;
+}
+
+/* d1 and d2 may be only 1 or 2 */
+static int ccu_ndmp_get_fact(struct ccu_ndmp *ndmp,
+			unsigned long rate, unsigned long prate,
+			int *p_n, int *p_d1, int *p_d2, int *p_m, int *p_p)
+{
+	int n, d1, d2, m, p, d;
+	unsigned long t;
+
+	/* m implies only n, d1, d2 and m (pll-audio) */
+	/* Setting d1=1 and d2=2 keeps n and m small enough
+	 *	with error < 5/10000 */
+	/* As only 2 rates are used, this could be simplified:
+	 *	22579200Hz => n = 32, m = 17
+	 *	24576000Hz => n = 43, m = 21
+	 */
+	if (ndmp->m.shift) {
+		long unsigned int lun, lum;
+
+		d1 = 0 + 1;
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
+		p = 0;
+
+	/* no d1 implies n alone (pll-cxcpux) */
+	} else if (!ndmp->d1.shift) {
+		d1 = d2 = 0 + 1;
+		n = rate / prate;
+		m = 1;
+		p = 0;
+
+	/* p implies only n, d1 and p (pll-videox) */
+	} else if (ndmp->m.shift) {
+		d2 = 0 + 1;
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
+			p = 0;
+		} else {
+			d1 = 1 + 1;
+			p = d - 1;
+		}
+		m = 1;
+
+	/* only n, d1 and d2 (other plls) */
+	} else {
+		t = prate / 4;
+		n = rate / t;
+		if (n < 12) {
+			n *= 4;
+			d1 = d2 = 0 + 1;
+		} else if (n >= 12 * 2 && !(n & 1)) {
+			if (n >= 12 * 4 && !(n % 4)) {
+				n /= 4;
+				d1 = d2 = 0 + 1;
+			} else {
+				n /= 2;
+				d1 = 0 + 1;
+				d2 = 1 + 1;
+			}
+		} else {
+			d1 = d2 = 1 + 1;
+		}
+		if (n > (1 << ndmp->n.width))
+			return -EINVAL;
+		m = 1;
+		p = 0;
+	}
+
+	if (n < 12 || n > (1 << ndmp->n.width))
+		return -EINVAL;
+
+	*p_n = n;
+	*p_d1 = d1;
+	*p_d2 = d2;
+	*p_m = m;
+	*p_p = p;
+
+	return 0;
+}
+
+static long ccu_ndmp_round_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long *parent_rate)
+{
+	struct ccu_ndmp *ndmp = hw_to_ccu_ndmp(hw);
+	int n, d1, d2, m, p, ret;
+
+	ret = ccu_ndmp_get_fact(ndmp, rate, *parent_rate,
+				&n, &d1, &d2, &m, &p);
+	if (!ret)
+		return 0;
+
+	return *parent_rate / d1 * n / d2 / m >> p;
+}
+
+static int ccu_ndmp_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long parent_rate)
+{
+	struct ccu_ndmp *ndmp = hw_to_ccu_ndmp(hw);
+	unsigned long flags;
+	int n, d1, d2, m, p, ret;
+	u32 reg;
+
+	ret = ccu_ndmp_get_fact(ndmp, rate, parent_rate,
+				&n, &d1, &d2, &m, &p);
+	if (!ret)
+		return ret;
+	if (!(ndmp->common.features & CCU_FEATURE_N0))
+		n--;
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
+	writel(reg | (n << ndmp->n.shift) |
+			((d1 - 1) << ndmp->d1.shift) |
+			((d2 - 1) << ndmp->d2.shift) |
+			((m - 1) << ndmp->m.shift) |
+			(p << ndmp->p.shift),
+	       ndmp->common.base + ndmp->common.reg);
+
+	spin_unlock_irqrestore(ndmp->common.lock, flags);
+
+	WARN_ON(readl_relaxed_poll_timeout(ndmp->common.base + ndmp->reg_lock,
+					   reg, !(reg & ndmp->lock), 50, 500));
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
index 0000000..bb47127
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_ndmp.h
@@ -0,0 +1,45 @@
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
+#include "ccu_factor.h"
+#include "ccu_common.h"
+
+struct ccu_ndmp {
+	u32			enable;
+	u32			lock;
+	int			reg_lock;
+
+	struct ccu_factor	n;
+	struct ccu_factor	d1;
+	struct ccu_factor	d2;
+	struct ccu_factor	m;
+	struct ccu_factor	p;
+
+	struct ccu_common	common;
+};
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
2.8.3
