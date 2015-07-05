From: heiko@sntech.de (Heiko Stuebner)
Date: Sun,  5 Jul 2015 11:00:14 +0200
Subject: [PATCH 1/7] clk: rockchip: add support for phase inverters
In-Reply-To: <1436086820-3757-1-git-send-email-heiko@sntech.de>
References: <1436086820-3757-1-git-send-email-heiko@sntech.de>
Message-ID: <1436086820-3757-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most Rockchip socs have optional phase inverters connected to some
clocks that move the clock-phase by 180 degrees.
While not having any actual influence on the rate, the inverter
provides its own simple recalc_rate callback as relying on the
fallback in the framework is for "lazy developers" according
to the documentation in the code.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/Makefile       |   1 +
 drivers/clk/rockchip/clk-inverter.c | 116 ++++++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/clk.c          |   7 +++
 drivers/clk/rockchip/clk.h          |  20 +++++++
 4 files changed, 144 insertions(+)
 create mode 100644 drivers/clk/rockchip/clk-inverter.c

diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index 2714097..fd71c7d 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -6,6 +6,7 @@ obj-y	+= clk-rockchip.o
 obj-y	+= clk.o
 obj-y	+= clk-pll.o
 obj-y	+= clk-cpu.o
+obj-y	+= clk-inverter.o
 obj-y	+= clk-mmc-phase.o
 obj-$(CONFIG_RESET_CONTROLLER)	+= softrst.o
 
diff --git a/drivers/clk/rockchip/clk-inverter.c b/drivers/clk/rockchip/clk-inverter.c
new file mode 100644
index 0000000..8054fdb
--- /dev/null
+++ b/drivers/clk/rockchip/clk-inverter.c
@@ -0,0 +1,116 @@
+/*
+ * Copyright 2015 Heiko Stuebner <heiko@sntech.de>
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
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+#include <linux/kernel.h>
+#include "clk.h"
+
+struct rockchip_inv_clock {
+	struct clk_hw	hw;
+	void __iomem	*reg;
+	int		shift;
+	int		flags;
+	spinlock_t	*lock;
+};
+
+#define to_inv_clock(_hw) container_of(_hw, struct rockchip_inv_clock, hw)
+
+#define INVERTER_MASK 0x1
+
+static int rockchip_inv_get_phase(struct clk_hw *hw)
+{
+	struct rockchip_inv_clock *inv_clock = to_inv_clock(hw);
+	u32 val;
+
+	val = readl(inv_clock->reg) >> inv_clock->shift;
+	val &= INVERTER_MASK;
+	return val ? 180 : 0;
+}
+
+static int rockchip_inv_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct rockchip_inv_clock *inv_clock = to_inv_clock(hw);
+	u32 val;
+
+	if (degrees % 180 == 0) {
+		val = !!degrees;
+	} else {
+		pr_err("%s: unsupported phase %d for %s\n",
+		       __func__, degrees, __clk_get_name(hw->clk));
+		return -EINVAL;
+	}
+
+	if (inv_clock->flags & ROCKCHIP_INVERTER_HIWORD_MASK) {
+		writel(HIWORD_UPDATE(val, INVERTER_MASK, inv_clock->shift),
+		       inv_clock->reg);
+	} else {
+		unsigned long flags;
+		u32 reg;
+
+		spin_lock_irqsave(inv_clock->lock, flags);
+
+		reg = readl(inv_clock->reg);
+		reg &= ~BIT(inv_clock->shift);
+		reg |= val;
+		writel(reg, inv_clock->reg);
+
+		spin_unlock_irqrestore(inv_clock->lock, flags);
+	}
+
+	return 0;
+}
+
+static const struct clk_ops rockchip_inv_clk_ops = {
+	.get_phase	= rockchip_inv_get_phase,
+	.set_phase	= rockchip_inv_set_phase,
+};
+
+struct clk *rockchip_clk_register_inverter(const char *name,
+				const char *const *parent_names, u8 num_parents,
+				void __iomem *reg, int shift, int flags,
+				spinlock_t *lock)
+{
+	struct clk_init_data init;
+	struct rockchip_inv_clock *inv_clock;
+	struct clk *clk;
+
+	inv_clock = kmalloc(sizeof(*inv_clock), GFP_KERNEL);
+	if (!inv_clock)
+		return NULL;
+
+	init.name = name;
+	init.num_parents = num_parents;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_names = parent_names;
+	init.ops = &rockchip_inv_clk_ops;
+
+	inv_clock->hw.init = &init;
+	inv_clock->reg = reg;
+	inv_clock->shift = shift;
+	inv_clock->flags = flags;
+	inv_clock->lock = lock;
+
+	clk = clk_register(NULL, &inv_clock->hw);
+	if (IS_ERR(clk))
+		goto err_free;
+
+	return clk;
+
+err_free:
+	kfree(inv_clock);
+	return NULL;
+}
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 052b94d..2493881 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -277,6 +277,13 @@ void __init rockchip_clk_register_branches(
 				list->div_shift
 			);
 			break;
+		case branch_inverter:
+			clk = rockchip_clk_register_inverter(
+				list->name, list->parent_names,
+				list->num_parents,
+				reg_base + list->muxdiv_offset,
+				list->div_shift, list->div_flags, &clk_lock);
+			break;
 		}
 
 		/* none of the cases above matched */
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 501f02e..b72dad0 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -182,6 +182,13 @@ struct clk *rockchip_clk_register_mmc(const char *name,
 				const char *const *parent_names, u8 num_parents,
 				void __iomem *reg, int shift);
 
+#define ROCKCHIP_INVERTER_HIWORD_MASK	BIT(0)
+
+struct clk *rockchip_clk_register_inverter(const char *name,
+				const char *const *parent_names, u8 num_parents,
+				void __iomem *reg, int shift, int flags,
+				spinlock_t *lock);
+
 #define PNAME(x) static const char *const x[] __initconst
 
 enum rockchip_clk_branch_type {
@@ -191,6 +198,7 @@ enum rockchip_clk_branch_type {
 	branch_fraction_divider,
 	branch_gate,
 	branch_mmc,
+	branch_inverter,
 };
 
 struct rockchip_clk_branch {
@@ -414,6 +422,18 @@ struct rockchip_clk_branch {
 		.div_shift	= shift,			\
 	}
 
+#define INVERTER(_id, cname, pname, io, is, if)			\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_inverter,		\
+		.name		= cname,			\
+		.parent_names	= (const char *[]){ pname },	\
+		.num_parents	= 1,				\
+		.muxdiv_offset	= io,				\
+		.div_shift	= is,				\
+		.div_flags	= if,				\
+	}
+
 void rockchip_clk_init(struct device_node *np, void __iomem *base,
 		       unsigned long nr_clks);
 struct regmap *rockchip_clk_get_grf(void);
-- 
2.1.4
