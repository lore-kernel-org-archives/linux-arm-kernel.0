From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Tue, 11 Jul 2017 18:56:25 +0800
Subject: [PATCH V2 08/10] clk: sprd: add adjustable pll support
In-Reply-To: <20170711105627.20526-1-chunyan.zhang@spreadtrum.com>
References: <20170711105627.20526-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170711105627.20526-9-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduced a common adjustable pll clock driver for Spreadtrum SoCs.

Original-by: Xiaolong Zhang <xiaolong.zhang@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/sprd/Makefile |   1 +
 drivers/clk/sprd/pll.c    | 236 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/pll.h    | 133 ++++++++++++++++++++++++++
 3 files changed, 370 insertions(+)
 create mode 100644 drivers/clk/sprd/pll.c
 create mode 100644 drivers/clk/sprd/pll.h

diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
index 2262e76..d693969 100644
--- a/drivers/clk/sprd/Makefile
+++ b/drivers/clk/sprd/Makefile
@@ -5,3 +5,4 @@ clk-sprd-y	+= gate.o
 clk-sprd-y	+= mux.o
 clk-sprd-y	+= div.o
 clk-sprd-y	+= composite.o
+clk-sprd-y	+= pll.o
diff --git a/drivers/clk/sprd/pll.c b/drivers/clk/sprd/pll.c
new file mode 100644
index 0000000..97935a2
--- /dev/null
+++ b/drivers/clk/sprd/pll.c
@@ -0,0 +1,236 @@
+/*
+ * Spreadtrum pll clock driver
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include "pll.h"
+
+#define CLK_PLL_1M	1000000
+#define CLK_PLL_10M	(CLK_PLL_1M * 10)
+
+#define pindex(pll, member)		\
+	(pll->factors[member].shift / (8 * sizeof(pll->regs[0])))
+
+#define pshift(pll, member)		\
+	(pll->factors[member].shift % (8 * sizeof(pll->regs[0])))
+
+#define pwidth(pll, member)		\
+	pll->factors[member].width
+
+#define pmask(pll, member)					\
+	((pwidth(pll, member)) ?				\
+	GENMASK(pwidth(pll, member) + pshift(pll, member) - 1,	\
+	pshift(pll, member)) : 0)
+
+#define pinternal(pll, cfg, member)	\
+	(cfg[pindex(pll, member)] & pmask(pll, member))
+
+#define pinternal_val(pll, cfg, member)	\
+	(pinternal(pll, cfg, member) >> pshift(pll, member))
+
+static unsigned long pll_get_refin(const struct sprd_pll *pll)
+{
+	u32 shift, mask, index, refin_id = 3;
+	const unsigned long refin[4] = { 2, 4, 13, 26 };
+
+	if (pwidth(pll, PLL_REFIN)) {
+		index = pindex(pll, PLL_REFIN);
+		shift = pshift(pll, PLL_REFIN);
+		mask = pmask(pll, PLL_REFIN);
+		refin_id = (sprd_pll_readl(pll, index) & mask) >> shift;
+		if (refin_id > 3)
+			refin_id = 3;
+	}
+
+	return refin[refin_id];
+}
+
+static u32 pll_get_ibias(u64 rate, const u64 *table)
+{
+	u32 i, num = table[0];
+
+	for (i = 1; i < num + 1; i++)
+		if (rate <= table[i])
+			break;
+
+	return (i == num + 1) ? num : i;
+}
+
+static unsigned long _sprd_pll_recalc_rate(const struct sprd_pll *pll,
+					   unsigned long parent_rate)
+{
+	u32 *cfg;
+	u32 i, mask, reg_num = pll->regs[0];
+	unsigned long rate, nint, kint = 0;
+	u64 refin;
+	u16 k1, k2;
+
+	cfg = kcalloc(reg_num, sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return -ENOMEM;
+
+	for (i = 0; i < reg_num; i++)
+		cfg[i] = sprd_pll_readl(pll, i);
+
+	refin = pll_get_refin(pll);
+
+	if (pinternal(pll, cfg, PLL_PREDIV))
+		refin = refin * 2;
+
+	if (pwidth(pll, PLL_POSTDIV) &&
+	    ((pll->fflag == 1 && pinternal(pll, cfg, PLL_POSTDIV)) ||
+	     (!pll->fflag && !pinternal(pll, cfg, PLL_POSTDIV))))
+		refin = refin / 2;
+
+	if (!pinternal(pll, cfg, PLL_DIV_S)) {
+		rate = refin * pinternal_val(pll, cfg, PLL_N) * CLK_PLL_10M;
+	} else {
+		nint = pinternal_val(pll, cfg, PLL_NINT);
+		if (pinternal(pll, cfg, PLL_SDM_EN))
+			kint = pinternal_val(pll, cfg, PLL_KINT);
+
+		mask = pmask(pll, PLL_KINT);
+
+		k1 = pll->k1;
+		k2 = pll->k2;
+		rate = DIV_ROUND_CLOSEST_ULL(refin * kint * k1,
+					 ((mask >> __ffs(mask)) + 1)) *
+					 k2 + refin * nint * CLK_PLL_1M;
+	}
+
+	return rate;
+}
+
+#define SPRD_PLL_WRITE_CHECK(pll, i, mask, val)		\
+	((sprd_pll_readl(pll, i) & mask) == val) ? 0 : -EFAULT
+
+static int _sprd_pll_set_rate(const struct sprd_pll *pll,
+			      unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct reg_cfg *cfg;
+	int ret = 0;
+	u32 mask, shift, width, ibias_val, index;
+	u32 reg_num = pll->regs[0], i = 0;
+	unsigned long kint, nint;
+	u64 refin, fvco = rate;
+
+	cfg = kcalloc(reg_num, sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return -ENOMEM;
+
+	refin = pll_get_refin(pll);
+
+	mask = pmask(pll, PLL_PREDIV);
+	index = pindex(pll, PLL_PREDIV);
+	width = pwidth(pll, PLL_PREDIV);
+	if (width && (sprd_pll_readl(pll, index) & mask))
+		refin = refin * 2;
+
+	mask = pmask(pll, PLL_POSTDIV);
+	index = pindex(pll, PLL_POSTDIV);
+	width = pwidth(pll, PLL_POSTDIV);
+	cfg[index].msk = mask;
+	if (width && ((pll->fflag == 1 && fvco <= pll->fvco) ||
+		      (pll->fflag == 0 && fvco > pll->fvco)))
+		cfg[index].val |= mask;
+
+	if (width && fvco <= pll->fvco)
+		fvco = fvco * 2;
+
+	mask = pmask(pll, PLL_DIV_S);
+	index = pindex(pll, PLL_DIV_S);
+	cfg[index].val |= mask;
+	cfg[index].msk |= mask;
+
+	mask = pmask(pll, PLL_SDM_EN);
+	index = pindex(pll, PLL_SDM_EN);
+	cfg[index].val |= mask;
+	cfg[index].msk |= mask;
+
+	nint  = fvco/(refin * CLK_PLL_1M);
+
+	mask = pmask(pll, PLL_NINT);
+	index = pindex(pll, PLL_NINT);
+	shift = pshift(pll, PLL_NINT);
+	cfg[index].val |= (nint << shift) & mask;
+	cfg[index].msk |= mask;
+
+	mask = pmask(pll, PLL_KINT);
+	index = pindex(pll, PLL_KINT);
+	width = pwidth(pll, PLL_KINT);
+	shift = pshift(pll, PLL_KINT);
+	kint = DIV_ROUND_CLOSEST_ULL(((fvco - refin * nint * CLK_PLL_1M) /
+				      10000) * ((mask >> shift) + 1),
+				     refin * 100);
+	cfg[index].val |= (kint << shift) & mask;
+	cfg[index].msk |= mask;
+
+	ibias_val = pll_get_ibias(fvco, pll->itable);
+
+	mask = pmask(pll, PLL_IBIAS);
+	index = pindex(pll, PLL_IBIAS);
+	shift = pshift(pll, PLL_IBIAS);
+	cfg[index].val |= ibias_val << shift & mask;
+	cfg[index].msk |= mask;
+
+	for (i = 0; i < reg_num; i++) {
+		if (cfg[i].msk) {
+			sprd_pll_writel(pll, i, cfg[i].msk, cfg[i].val);
+			ret |= SPRD_PLL_WRITE_CHECK(pll, i, cfg[i].msk,
+						   cfg[i].val);
+		}
+	}
+
+	if (!ret)
+		udelay(pll->udelay);
+
+	return ret;
+}
+
+static unsigned long sprd_pll_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct sprd_pll *pll = hw_to_sprd_pll(hw);
+
+	return _sprd_pll_recalc_rate(pll, parent_rate);
+}
+
+static int sprd_pll_set_rate(struct clk_hw *hw,
+			     unsigned long rate,
+			     unsigned long parent_rate)
+{
+	struct sprd_pll *pll = hw_to_sprd_pll(hw);
+
+	return _sprd_pll_set_rate(pll, rate, parent_rate);
+}
+
+static int sprd_pll_clk_prepare(struct clk_hw *hw)
+{
+	struct sprd_pll *pll = hw_to_sprd_pll(hw);
+
+	udelay(pll->udelay);
+
+	return 0;
+}
+
+static long sprd_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	return rate;
+}
+
+const struct clk_ops sprd_pll_ops = {
+	.prepare = sprd_pll_clk_prepare,
+	.recalc_rate = sprd_pll_recalc_rate,
+	.round_rate = sprd_pll_round_rate,
+	.set_rate = sprd_pll_set_rate,
+};
+EXPORT_SYMBOL_GPL(sprd_pll_ops);
diff --git a/drivers/clk/sprd/pll.h b/drivers/clk/sprd/pll.h
new file mode 100644
index 0000000..af5b2da
--- /dev/null
+++ b/drivers/clk/sprd/pll.h
@@ -0,0 +1,133 @@
+/*
+ * Spreadtrum clock pll configurations
+ *
+ * Copyright (C) 2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _SPRD_PLL_H_
+#define _SPRD_PLL_H_
+
+#include "common.h"
+
+struct reg_cfg {
+	u32 val;
+	u32 msk;
+};
+
+struct clk_bit_field {
+	u8 shift;
+	u8 width;
+};
+
+enum {
+	PLL_LOCK_DONE,
+	PLL_DIV_S,
+	PLL_MOD_EN,
+	PLL_SDM_EN,
+	PLL_REFIN,
+	PLL_IBIAS,
+	PLL_N,
+	PLL_NINT,
+	PLL_KINT,
+	PLL_PREDIV,
+	PLL_POSTDIV,
+
+	PLL_FACT_MAX
+};
+
+/*
+ * struct sprd_pll - definition of adjustable pll clock
+ *
+ * @reg:	registers used to set the configuration of pll clock,
+ *		reg[0] shows how many registers this pll clock uses.
+ * @itable:	pll ibias table, itable[0] means how many items this
+ *		table includes
+ * @udelay	delay time after setting rate
+ * @factors	used to calculate the pll clock rate
+ * @fvco:	fvco threshold rate
+ * @fflag:	fvco flag
+ */
+struct sprd_pll {
+	const u32 *regs;
+	const u64 *itable;
+	const struct clk_bit_field *factors;
+	u16 udelay;
+	u16 k1;
+	u16 k2;
+	u16 fflag;
+	u64 fvco;
+
+	struct sprd_clk_common	common;
+};
+
+#define SPRD_PLL_WITH_ITABLE_K_FVCO(_struct, _name, _parent, _reg,	\
+				    _regs, _itable, _factors, _udelay,	\
+				    _k1, _k2, _fflag, _fvco)		\
+	struct sprd_pll _struct = {					\
+		.regs		= _regs,				\
+		.itable		= _itable,				\
+		.factors	= _factors,				\
+		.udelay		= _udelay,				\
+		.k1		= _k1,					\
+		.k2		= _k2,					\
+		.fflag		= _fflag,				\
+		.fvco		= _fvco,				\
+		.common		= {					\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &sprd_pll_ops,	\
+						      0),		\
+		},							\
+	}
+
+#define SPRD_PLL_WITH_ITABLE_K(_struct, _name, _parent, _reg,		\
+			       _regs, _itable, _factors,		\
+			       _udelay, _k1, _k2)			\
+	SPRD_PLL_WITH_ITABLE_K_FVCO(_struct, _name, _parent, _reg,	\
+				    _regs, _itable, _factors,		\
+				    _udelay, _k1, _k2, 0, 0)
+
+#define SPRD_PLL_WITH_ITABLE_1K(_struct, _name, _parent, _reg,		\
+				_regs, _itable, _factors, _udelay)	\
+	SPRD_PLL_WITH_ITABLE_K_FVCO(_struct, _name, _parent, _reg,	\
+				    _regs, _itable, _factors, _udelay,	\
+				    1000, 1000, 0, 0)
+
+static inline struct sprd_pll *hw_to_sprd_pll(struct clk_hw *hw)
+{
+	struct sprd_clk_common *common = hw_to_sprd_clk_common(hw);
+
+	return container_of(common, struct sprd_pll, common);
+}
+
+static inline u32 sprd_pll_readl(const struct sprd_pll *pll, u8 index)
+{
+	const struct sprd_clk_common *common = &pll->common;
+
+	if (WARN_ON(index >= pll->regs[0]))
+		return 0;
+
+	return readl(common->base + pll->regs[index + 1]);
+}
+
+static inline void sprd_pll_writel(const struct sprd_pll *pll, u8 index,
+				  u32 msk, u32 val)
+{
+	const struct sprd_clk_common *common = &pll->common;
+	void __iomem *addr;
+	u32 reg;
+
+	if (WARN_ON(index >= pll->regs[0]))
+		return;
+
+	addr = common->base + pll->regs[index + 1];
+	reg = readl(addr);
+	writel((reg & ~msk) | val, addr);
+}
+
+extern const struct clk_ops sprd_pll_ops;
+
+#endif /* _SPRD_PLL_H_ */
-- 
2.7.4
