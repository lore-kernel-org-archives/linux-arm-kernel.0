From: henryc.chen@mediatek.com (Henry Chen)
Date: Fri, 30 Jan 2015 13:13:13 +0800
Subject: [PATCH v4 2/7] clk: mediatek: Add initial common clock support for
 Mediatek SoCs.
In-Reply-To: <1422594798-13375-1-git-send-email-henryc.chen@mediatek.com>
References: <1422594798-13375-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <1422594798-13375-3-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Liao <jamesjj.liao@mediatek.com>

This patch adds common clock support for Mediatek SoCs, including plls,
muxes and clock gates.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/clk/Makefile            |   1 +
 drivers/clk/mediatek/Makefile   |   1 +
 drivers/clk/mediatek/clk-gate.c | 140 ++++++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-gate.h |  49 +++++++++++++
 drivers/clk/mediatek/clk-mtk.c  | 154 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.h  | 132 ++++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-pll.c  |  63 ++++++++++++++++
 drivers/clk/mediatek/clk-pll.h  |  52 ++++++++++++++
 8 files changed, 592 insertions(+)
 create mode 100644 drivers/clk/mediatek/Makefile
 create mode 100644 drivers/clk/mediatek/clk-gate.c
 create mode 100644 drivers/clk/mediatek/clk-gate.h
 create mode 100644 drivers/clk/mediatek/clk-mtk.c
 create mode 100644 drivers/clk/mediatek/clk-mtk.h
 create mode 100644 drivers/clk/mediatek/clk-pll.c
 create mode 100644 drivers/clk/mediatek/clk-pll.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d5fba5b..ce6c250 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_ARCH_HI3xxx)		+= hisilicon/
 obj-$(CONFIG_ARCH_HIP04)		+= hisilicon/
 obj-$(CONFIG_ARCH_HIX5HD2)		+= hisilicon/
 obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
+obj-$(CONFIG_ARCH_MEDIATEK)		+= mediatek/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)			+= mmp/
 endif
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
new file mode 100644
index 0000000..c384e97
--- /dev/null
+++ b/drivers/clk/mediatek/Makefile
@@ -0,0 +1 @@
+obj-y += clk-mtk.o clk-pll.o clk-gate.o
diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
new file mode 100644
index 0000000..f05507a
--- /dev/null
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -0,0 +1,140 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/clkdev.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+static int mtk_cg_bit_is_cleared(struct clk_hw *hw)
+{
+	struct mtk_clk_gate *cg = to_clk_gate(hw);
+	u32 mask;
+	u32 val;
+
+	mask = BIT(cg->bit);
+	val = mask & readl(cg->sta_addr);
+
+	return val == 0;
+}
+
+static int mtk_cg_bit_is_set(struct clk_hw *hw)
+{
+	struct mtk_clk_gate *cg = to_clk_gate(hw);
+	u32 mask;
+	u32 val;
+
+	mask = BIT(cg->bit);
+	val = mask & readl(cg->sta_addr);
+
+	return val != 0;
+}
+
+static void mtk_cg_set_bit(struct clk_hw *hw)
+{
+	struct mtk_clk_gate *cg = to_clk_gate(hw);
+
+	writel_relaxed(BIT(cg->bit), cg->set_addr);
+}
+
+static void mtk_cg_clr_bit(struct clk_hw *hw)
+{
+	struct mtk_clk_gate *cg = to_clk_gate(hw);
+
+	writel_relaxed(BIT(cg->bit), cg->clr_addr);
+}
+
+static int mtk_cg_enable(struct clk_hw *hw)
+{
+	mtk_cg_clr_bit(hw);
+
+	return 0;
+}
+
+static void mtk_cg_disable(struct clk_hw *hw)
+{
+	mtk_cg_set_bit(hw);
+}
+
+static int mtk_cg_enable_inv(struct clk_hw *hw)
+{
+	mtk_cg_set_bit(hw);
+
+	return 0;
+}
+
+static void mtk_cg_disable_inv(struct clk_hw *hw)
+{
+	mtk_cg_clr_bit(hw);
+}
+
+const struct clk_ops mtk_clk_gate_ops_setclr = {
+	.is_enabled	= mtk_cg_bit_is_cleared,
+	.enable		= mtk_cg_enable,
+	.disable	= mtk_cg_disable,
+};
+
+const struct clk_ops mtk_clk_gate_ops_setclr_inv = {
+	.is_enabled	= mtk_cg_bit_is_set,
+	.enable		= mtk_cg_enable_inv,
+	.disable	= mtk_cg_disable_inv,
+};
+
+struct clk *mtk_clk_register_gate(
+		const char *name,
+		const char *parent_name,
+		void __iomem *set_addr,
+		void __iomem *clr_addr,
+		void __iomem *sta_addr,
+		u8 bit,
+		const struct clk_ops *ops,
+		spinlock_t *lock)
+{
+	struct mtk_clk_gate *cg;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	if (!lock)
+		return ERR_PTR(-EINVAL);
+
+	cg = kzalloc(sizeof(*cg), GFP_KERNEL);
+	if (!cg)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+	init.ops = ops;
+
+	cg->set_addr = set_addr;
+	cg->clr_addr = clr_addr;
+	cg->sta_addr = sta_addr;
+	cg->bit = bit;
+	cg->lock = lock;
+
+	cg->hw.init = &init;
+
+	clk = clk_register(NULL, &cg->hw);
+	if (IS_ERR(clk))
+		kfree(cg);
+
+	return clk;
+}
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
new file mode 100644
index 0000000..d67a574
--- /dev/null
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -0,0 +1,49 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __DRV_CLK_GATE_H
+#define __DRV_CLK_GATE_H
+
+/*
+ * This is a private header file. DO NOT include it except clk-*.c.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+struct mtk_clk_gate {
+	struct clk_hw	hw;
+	void __iomem	*set_addr;
+	void __iomem	*clr_addr;
+	void __iomem	*sta_addr;
+	u8		bit;
+	spinlock_t	*lock;
+};
+
+#define to_clk_gate(_hw) container_of(_hw, struct mtk_clk_gate, hw)
+
+extern const struct clk_ops mtk_clk_gate_ops_setclr;
+extern const struct clk_ops mtk_clk_gate_ops_setclr_inv;
+
+struct clk *mtk_clk_register_gate(
+		const char *name,
+		const char *parent_name,
+		void __iomem *set_addr,
+		void __iomem *clr_addr,
+		void __iomem *sta_addr,
+		u8 bit,
+		const struct clk_ops *ops,
+		spinlock_t *lock);
+
+#endif /* __DRV_CLK_GATE_H */
diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
new file mode 100644
index 0000000..ce4f2ac
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -0,0 +1,154 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/clkdev.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+void mtk_init_factors(struct mtk_fixed_factor *clks, int num,
+		struct clk_onecell_data *clk_data)
+{
+	int i;
+	struct clk *clk;
+
+	for (i = 0; i < num; i++) {
+		struct mtk_fixed_factor *ff = &clks[i];
+
+		clk = clk_register_fixed_factor(NULL, ff->name, ff->parent_name,
+				CLK_SET_RATE_PARENT, ff->mult, ff->div);
+
+		if (IS_ERR(clk)) {
+			pr_err("Failed to register clk %s: %ld\n",
+					ff->name, PTR_ERR(clk));
+			continue;
+		}
+
+		if (clk_data)
+			clk_data->clks[ff->id] = clk;
+	}
+}
+
+void mtk_init_clk_gates(void __iomem *reg_base,
+		struct mtk_gate *clks, int num,
+		struct clk_onecell_data *clk_data, spinlock_t *lock)
+{
+	int i;
+	struct clk *clk;
+
+	for (i = 0; i < num; i++) {
+		struct mtk_gate *gate = &clks[i];
+
+		clk = mtk_clk_register_gate(gate->name, gate->parent_name,
+				reg_base + gate->regs->set_ofs,
+				reg_base + gate->regs->clr_ofs,
+				reg_base + gate->regs->sta_ofs,
+				gate->shift, gate->ops, lock);
+
+		if (IS_ERR(clk)) {
+			pr_err("Failed to register clk %s: %ld\n",
+					gate->name, PTR_ERR(clk));
+			continue;
+		}
+
+		if (clk_data)
+			clk_data->clks[gate->id] = clk;
+	}
+}
+
+struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
+{
+	int i;
+	struct clk_onecell_data *clk_data;
+
+	clk_data = kzalloc(sizeof(clk_data), GFP_KERNEL);
+	if (!clk_data)
+		return NULL;
+
+	clk_data->clks = kcalloc(clk_num, sizeof(struct clk *), GFP_KERNEL);
+	if (!clk_data->clks) {
+		kfree(clk_data);
+		return NULL;
+	}
+
+	clk_data->clk_num = clk_num;
+
+	for (i = 0; i < clk_num; ++i)
+		clk_data->clks[i] = ERR_PTR(-ENOENT);
+
+	return clk_data;
+}
+
+struct clk *mtk_clk_register_mux(
+		const char *name,
+		const char **parent_names,
+		u8 num_parents,
+		void __iomem *base_addr,
+		u8 shift,
+		u8 width,
+		u8 gate_bit,
+		spinlock_t *lock)
+{
+	struct clk *clk;
+	struct clk_mux *mux;
+	struct clk_gate *gate = NULL;
+	struct clk_hw *gate_hw = NULL;
+	const struct clk_ops *gate_ops = NULL;
+	u32 mask = BIT(width) - 1;
+
+	mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	mux->reg = base_addr;
+	mux->mask = mask;
+	mux->shift = shift;
+	mux->flags = 0;
+	mux->lock = lock;
+
+	if (gate_bit <= MAX_MUX_GATE_BIT) {
+		gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
+		if (!gate) {
+			kfree(mux);
+			return ERR_PTR(-ENOMEM);
+		}
+
+		gate->reg = base_addr;
+		gate->bit_idx = gate_bit;
+		gate->flags = CLK_GATE_SET_TO_DISABLE;
+		gate->lock = lock;
+
+		gate_hw = &gate->hw;
+		gate_ops = &clk_gate_ops;
+	}
+
+	clk = clk_register_composite(NULL, name, parent_names, num_parents,
+		&mux->hw, &clk_mux_ops,
+		NULL, NULL,
+		gate_hw, gate_ops,
+		CLK_SET_RATE_PARENT);
+
+	if (IS_ERR(clk)) {
+		kfree(gate);
+		kfree(mux);
+	}
+
+	return clk;
+}
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
new file mode 100644
index 0000000..559e71b
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -0,0 +1,132 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __DRV_CLK_MTK_H
+#define __DRV_CLK_MTK_H
+
+/*
+ * This is a private header file. DO NOT include it except clk-*.c.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+#define MAX_MUX_GATE_BIT	31
+#define INVALID_MUX_GATE_BIT	(MAX_MUX_GATE_BIT + 1)
+
+struct mtk_fixed_factor {
+	int id;
+	const char *name;
+	const char *parent_name;
+	int mult;
+	int div;
+};
+
+#define FACTOR(_id, _name, _parent, _mult, _div) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.mult = _mult,				\
+		.div = _div,				\
+	}
+
+extern void mtk_init_factors(struct mtk_fixed_factor *clks, int num,
+		struct clk_onecell_data *clk_data);
+
+struct mtk_mux {
+	int id;
+	const char *name;
+	uint32_t reg;
+	int shift;
+	int width;
+	int gate;
+	const char **parent_names;
+	int num_parents;
+};
+
+#define MUX(_id, _name, _parents, _reg, _shift, _width, _gate) {	\
+		.id = _id,						\
+		.name = _name,						\
+		.reg = _reg,						\
+		.shift = _shift,					\
+		.width = _width,					\
+		.gate = _gate,						\
+		.parent_names = (const char **)_parents,		\
+		.num_parents = ARRAY_SIZE(_parents),			\
+	}
+
+struct mtk_pll {
+	int id;
+	const char *name;
+	const char *parent_name;
+	uint32_t reg;
+	uint32_t pwr_reg;
+	uint32_t en_mask;
+	unsigned int flags;
+	const struct clk_ops *ops;
+};
+
+#define PLL(_id, _name, _parent, _reg, _pwr_reg, _en_mask, _flags, _ops) { \
+		.id = _id,						\
+		.name = _name,						\
+		.parent_name = _parent,					\
+		.reg = _reg,						\
+		.pwr_reg = _pwr_reg,					\
+		.en_mask = _en_mask,					\
+		.flags = _flags,					\
+		.ops = _ops,						\
+	}
+
+struct mtk_gate_regs {
+	u32 sta_ofs;
+	u32 clr_ofs;
+	u32 set_ofs;
+};
+
+struct mtk_gate {
+	int id;
+	const char *name;
+	const char *parent_name;
+	struct mtk_gate_regs *regs;
+	int shift;
+	const struct clk_ops *ops;
+};
+
+#define GATE(_id, _name, _parent, _regs, _shift, _ops) {	\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.regs = &_regs,					\
+		.shift = _shift,				\
+		.ops = _ops,					\
+	}
+
+extern void mtk_init_clk_gates(void __iomem *reg_base,
+		struct mtk_gate *clks, int num,
+		struct clk_onecell_data *clk_data, spinlock_t *lock);
+
+extern struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
+
+struct clk *mtk_clk_register_mux(
+		const char *name,
+		const char **parent_names,
+		u8 num_parents,
+		void __iomem *base_addr,
+		u8 shift,
+		u8 width,
+		u8 gate_bit,
+		spinlock_t *lock);
+
+#endif /* __DRV_CLK_MTK_H */
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
new file mode 100644
index 0000000..59dee83
--- /dev/null
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -0,0 +1,63 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/clkdev.h>
+
+#include "clk-mtk.h"
+#include "clk-pll.h"
+
+struct clk *mtk_clk_register_pll(
+		const char *name,
+		const char *parent_name,
+		u32 *base_addr,
+		u32 *pwr_addr,
+		u32 en_mask,
+		u32 flags,
+		const struct clk_ops *ops,
+		spinlock_t *lock)
+{
+	struct mtk_clk_pll *pll;
+	struct clk_init_data init;
+	struct clk *clk;
+
+	pr_debug("%s(): name: %s\n", __func__, name);
+
+	if (!lock)
+		return ERR_PTR(-EINVAL);
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base_addr = base_addr;
+	pll->pwr_addr = pwr_addr;
+	pll->en_mask = en_mask;
+	pll->flags = flags;
+	pll->lock = lock;
+	pll->hw.init = &init;
+
+	init.name = name;
+	init.ops = ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	clk = clk_register(NULL, &pll->hw);
+
+	if (IS_ERR(clk))
+		kfree(pll);
+
+	return clk;
+}
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
new file mode 100644
index 0000000..341d2fe
--- /dev/null
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __DRV_CLK_PLL_H
+#define __DRV_CLK_PLL_H
+
+/*
+ * This is a private header file. DO NOT include it except clk-*.c.
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+struct mtk_clk_pll {
+	struct clk_hw	hw;
+	void __iomem	*base_addr;
+	void __iomem	*pwr_addr;
+	u32		en_mask;
+	u32		flags;
+	spinlock_t	*lock;
+};
+
+#define to_mtk_clk_pll(_hw) container_of(_hw, struct mtk_clk_pll, hw)
+
+#define HAVE_RST_BAR	BIT(0)
+#define HAVE_PLL_HP	BIT(1)
+#define HAVE_FIX_FRQ	BIT(2)
+#define PLL_AO		BIT(3)
+
+struct clk *mtk_clk_register_pll(
+		const char *name,
+		const char *parent_name,
+		u32 *base_addr,
+		u32 *pwr_addr,
+		u32 en_mask,
+		u32 flags,
+		const struct clk_ops *ops,
+		spinlock_t *lock);
+
+#endif /* __DRV_CLK_PLL_H */
-- 
1.8.1.1.dirty
