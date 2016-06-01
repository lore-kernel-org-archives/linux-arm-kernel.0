From: hl@rock-chips.com (Lin Huang)
Date: Wed,  1 Jun 2016 17:35:36 +0800
Subject: [RFC PATCH 1/4] rockchip: rockchip: add new clock-type for the ddrclk
In-Reply-To: <1464773739-18152-1-git-send-email-hl@rock-chips.com>
References: <1464773739-18152-1-git-send-email-hl@rock-chips.com>
Message-ID: <1464773739-18152-2-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On new rockchip platform(rk3399 etc), there have dcf controller to
do ddr frequency scaling, and this controller will implement in
arm-trust-firmware. We add a special clock-type to handle that.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
 drivers/clk/rockchip/Makefile  |   1 +
 drivers/clk/rockchip/clk-ddr.c | 147 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/clk.c     |   9 +++
 drivers/clk/rockchip/clk.h     |  27 ++++++++
 4 files changed, 184 insertions(+)
 create mode 100644 drivers/clk/rockchip/clk-ddr.c

diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index f47a2fa..b5f2c8e 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -8,6 +8,7 @@ obj-y	+= clk-pll.o
 obj-y	+= clk-cpu.o
 obj-y	+= clk-inverter.o
 obj-y	+= clk-mmc-phase.o
+obj-y	+= clk-ddr.o
 obj-$(CONFIG_RESET_CONTROLLER)	+= softrst.o
 
 obj-y	+= clk-rk3036.o
diff --git a/drivers/clk/rockchip/clk-ddr.c b/drivers/clk/rockchip/clk-ddr.c
new file mode 100644
index 0000000..5b6630d
--- /dev/null
+++ b/drivers/clk/rockchip/clk-ddr.c
@@ -0,0 +1,147 @@
+/*
+ * Copyright (c) 2016 Rockchip Electronics Co. Ltd.
+ * Author: Lin Huang <hl@rock-chips.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include "clk.h"
+
+struct rockchip_ddrclk {
+	struct clk_hw	hw;
+	void __iomem	*reg_base;
+	int		mux_offset;
+	int		mux_shift;
+	int		mux_width;
+	int		mux_flag;
+	int		div_shift;
+	int		div_width;
+	int		div_flag;
+	spinlock_t	*lock;
+};
+
+#define to_rockchip_ddrclk_hw(hw) container_of(hw, struct rockchip_ddrclk, hw)
+#define val_mask(width)	((1 << (width)) - 1)
+
+static int rockchip_ddrclk_set_rate(struct clk_hw *hw, unsigned long drate,
+				    unsigned long prate)
+{
+	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
+	unsigned long flags;
+
+	spin_lock_irqsave(ddrclk->lock, flags);
+
+	/* TODO: set ddr rate in bl31 */
+
+	spin_unlock_irqrestore(ddrclk->lock, flags);
+
+	return 0;
+}
+
+static unsigned long
+rockchip_ddrclk_recalc_rate(struct clk_hw *hw,
+			    unsigned long parent_rate)
+{
+	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
+	int val;
+
+	val = clk_readl(ddrclk->reg_base +
+			ddrclk->mux_offset) >> ddrclk->div_shift;
+	val &= val_mask(ddrclk->div_width);
+
+	return DIV_ROUND_UP_ULL((u64)parent_rate, val + 1);
+}
+
+static long clk_ddrclk_round_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *prate)
+{
+	return rate;
+}
+
+static u8 rockchip_ddrclk_get_parent(struct clk_hw *hw)
+{
+	struct rockchip_ddrclk *ddrclk = to_rockchip_ddrclk_hw(hw);
+	int num_parents = clk_hw_get_num_parents(hw);
+	u32 val;
+
+	val = clk_readl(ddrclk->reg_base +
+			ddrclk->mux_offset) >> ddrclk->mux_shift;
+	val &= val_mask(ddrclk->mux_width);
+
+	if (val >= num_parents)
+		return -EINVAL;
+
+	return val;
+}
+
+static const struct clk_ops rockchip_ddrclk_ops = {
+	.recalc_rate = rockchip_ddrclk_recalc_rate,
+	.set_rate = rockchip_ddrclk_set_rate,
+	.round_rate = clk_ddrclk_round_rate,
+	.get_parent = rockchip_ddrclk_get_parent,
+};
+
+struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
+					 const char *const *parent_names,
+					 u8 num_parents, int mux_offset,
+					 int mux_shift, int mux_width,
+					 int mux_flag, int div_shift,
+					 int div_width, int div_flag,
+					 void __iomem *reg_base,
+					 spinlock_t *lock)
+{
+	struct rockchip_ddrclk *ddrclk;
+	struct clk_init_data init;
+	struct clk *clk;
+	int ret;
+
+	ddrclk = kzalloc(sizeof(*ddrclk), GFP_KERNEL);
+	if (!ddrclk)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+	init.ops = &rockchip_ddrclk_ops;
+
+	init.flags = flags;
+	init.flags |= CLK_SET_RATE_NO_REPARENT;
+	init.flags |= CLK_GET_RATE_NOCACHE;
+
+	ddrclk->reg_base = reg_base;
+	ddrclk->lock = lock;
+	ddrclk->hw.init = &init;
+	ddrclk->mux_offset = mux_offset;
+	ddrclk->mux_shift = mux_shift;
+	ddrclk->mux_width = mux_width;
+	ddrclk->mux_flag = mux_flag;
+	ddrclk->div_shift = div_shift;
+	ddrclk->div_width = div_width;
+	ddrclk->div_flag = div_flag;
+
+	clk = clk_register(NULL, &ddrclk->hw);
+	if (IS_ERR(clk)) {
+		pr_err("%s: could not register ddrclk %s\n", __func__,	name);
+		ret = PTR_ERR(clk);
+		goto free_ddrclk;
+	}
+
+	return clk;
+
+free_ddrclk:
+	kfree(ddrclk);
+	return ERR_PTR(ret);
+}
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 7ffd134..6ac1aa5 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -484,6 +484,15 @@ void __init rockchip_clk_register_branches(
 				list->gate_offset, list->gate_shift,
 				list->gate_flags, flags, &ctx->lock);
 			break;
+		case branch_ddrc:
+			clk = rockchip_clk_register_ddrclk(
+				list->name, list->flags,
+				list->parent_names, list->num_parents,
+				list->muxdiv_offset, list->mux_shift,
+				list->mux_width, list->mux_flags,
+				list->div_shift, list->div_width,
+				list->div_flags, ctx->reg_base, &ctx->lock);
+			break;
 		}
 
 		/* none of the cases above matched */
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 2194ffa..4033fe4 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -281,6 +281,13 @@ struct clk *rockchip_clk_register_mmc(const char *name,
 				const char *const *parent_names, u8 num_parents,
 				void __iomem *reg, int shift);
 
+struct clk *rockchip_clk_register_ddrclk(const char *name, int flags,
+			const char *const *parent_names, u8 num_parents,
+			int mux_offset, int mux_shift, int mux_width,
+			int mux_flag, int div_shift, int div_width,
+			int div_flag, void __iomem *reg_base,
+			spinlock_t *lock);
+
 #define ROCKCHIP_INVERTER_HIWORD_MASK	BIT(0)
 
 struct clk *rockchip_clk_register_inverter(const char *name,
@@ -299,6 +306,7 @@ enum rockchip_clk_branch_type {
 	branch_mmc,
 	branch_inverter,
 	branch_factor,
+	branch_ddrc,
 };
 
 struct rockchip_clk_branch {
@@ -488,6 +496,25 @@ struct rockchip_clk_branch {
 		.child		= ch,				\
 	}
 
+#define COMPOSITE_DDRC(_id, cname, pnames, f, mo, ms, mw, mf,	\
+			 ds, dw, df)				\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_ddrc,			\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.muxdiv_offset	= mo,				\
+		.mux_shift	= ms,				\
+		.mux_width	= mw,				\
+		.mux_flags	= mf,				\
+		.div_shift	= ds,				\
+		.div_width	= dw,				\
+		.div_flags	= df,				\
+		.gate_offset	= -1,				\
+	}
+
 #define MUX(_id, cname, pnames, f, o, s, w, mf)			\
 	{							\
 		.id		= _id,				\
-- 
1.9.1
