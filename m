From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 07 May 2014 23:13:05 +0200
Subject: [PATCH v2 05/11] clk: rockchip: add reset controller
In-Reply-To: <3477211.Gkyeur83TV@diego>
References: <3477211.Gkyeur83TV@diego>
Message-ID: <19175708.GYirOpr0Nh@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Rockchip SoCs at least down to the ARM9-based RK28xx include the reset-
controller for SoC peripherals in their clock controller.
While the older SoCs (ARM9 and Cortex-A8) use a regular scheme to change
register values, the Cortex-A9 SoCs use a hiword-mask making locking unecessary.
To be compatible with both schemes the reset controller takes a flag to
decide which scheme to use.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/Makefile  |   1 +
 drivers/clk/rockchip/clk.h     |  14 +++++
 drivers/clk/rockchip/softrst.c | 115 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 drivers/clk/rockchip/softrst.c

diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index 7748062..7e4a296 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -6,3 +6,4 @@ obj-y	+= clk-rockchip.o
 obj-y	+= clk.o
 obj-y	+= clk-pll.o
 obj-y	+= clk-cpu.o
+obj-$(CONFIG_RESET_CONTROLLER)	+= softrst.o
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 7d1c76c..b52e4c2 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -234,4 +234,18 @@ void rockchip_clk_register_armclk(unsigned int lookup_id,
 			unsigned int num_parents, void __iomem *reg_base,
 			struct device_node *np);
 
+#define ROCKCHIP_SOFTRST_HIWORD_MASK	BIT(0)
+
+#ifdef CONFIG_RESET_CONTROLLER
+void rockchip_register_softrst(struct device_node *np,
+			       unsigned int num_regs,
+			       void __iomem *base, u8 flags);
+#else
+static inline void rockchip_register_softrst(struct device_node *np,
+			       unsigned int num_regs,
+			       void __iomem *base, u8 flags)
+{
+}
+#endif
+
 #endif
diff --git a/drivers/clk/rockchip/softrst.c b/drivers/clk/rockchip/softrst.c
new file mode 100644
index 0000000..e981f6c
--- /dev/null
+++ b/drivers/clk/rockchip/softrst.c
@@ -0,0 +1,115 @@
+/*
+ * Copyright (c) 2014 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
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
+#include <linux/io.h>
+#include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+#include "clk.h"
+
+struct rockchip_softrst {
+	struct reset_controller_dev	rcdev;
+	void __iomem			*reg_base;
+	int				num_regs;
+	int				num_per_reg;
+	u8				flags;
+	spinlock_t			lock;
+};
+
+static int rockchip_softrst_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct rockchip_softrst *softrst = container_of(rcdev,
+						     struct rockchip_softrst,
+						     rcdev);
+	int bank = id / softrst->num_per_reg;
+	int offset = id % softrst->num_per_reg;
+
+	if (softrst->flags & ROCKCHIP_SOFTRST_HIWORD_MASK) {
+		writel(BIT(offset) | (BIT(offset) << 16),
+		       softrst->reg_base + (bank * 4));
+	} else {
+		unsigned long flags;
+		u32 reg;
+
+		spin_lock_irqsave(&softrst->lock, flags);
+
+		reg = readl(softrst->reg_base + (bank * 4));
+		writel(reg | BIT(offset), softrst->reg_base + (bank * 4));
+
+		spin_unlock_irqrestore(&softrst->lock, flags);
+	}
+
+	return 0;
+}
+
+static int rockchip_softrst_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct rockchip_softrst *softrst = container_of(rcdev,
+						     struct rockchip_softrst,
+						     rcdev);
+	int bank = id / BITS_PER_LONG;
+	int offset = id % BITS_PER_LONG;
+
+	if (softrst->flags & ROCKCHIP_SOFTRST_HIWORD_MASK) {
+		writel((BIT(offset) << 16), softrst->reg_base + (bank * 4));
+	} else {
+		unsigned long flags;
+		u32 reg;
+
+		spin_lock_irqsave(&softrst->lock, flags);
+
+		reg = readl(softrst->reg_base + (bank * 4));
+		writel(reg & ~BIT(offset), softrst->reg_base + (bank * 4));
+
+		spin_unlock_irqrestore(&softrst->lock, flags);
+	}
+
+	return 0;
+}
+
+static struct reset_control_ops rockchip_softrst_ops = {
+	.assert		= rockchip_softrst_assert,
+	.deassert	= rockchip_softrst_deassert,
+};
+
+void __init rockchip_register_softrst(struct device_node *np,
+				      unsigned int num_regs,
+				      void __iomem *base, u8 flags)
+{
+	struct rockchip_softrst *softrst;
+	int ret;
+
+	softrst = kzalloc(sizeof(*softrst), GFP_KERNEL);
+	if (!softrst)
+		return;
+
+	softrst->reg_base = base;
+	softrst->num_regs = num_regs;
+	softrst->num_per_reg = (flags & ROCKCHIP_SOFTRST_HIWORD_MASK) ? 16
+								      : 32;
+
+	softrst->rcdev.owner = THIS_MODULE;
+	softrst->rcdev.nr_resets =  num_regs * softrst->num_per_reg;
+	softrst->rcdev.ops = &rockchip_softrst_ops;
+	softrst->rcdev.of_node = np;
+	ret = reset_controller_register(&softrst->rcdev);
+	if (ret) {
+		pr_err("%s: could not register reset controller, %d\n",
+		       __func__, ret);
+		kfree(softrst);
+	}
+};
-- 
1.9.0
