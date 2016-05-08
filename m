From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  8 May 2016 22:01:37 +0200
Subject: [PATCH 02/16] clk: sunxi-ng: Add common infrastructure
In-Reply-To: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1462737711-10017-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Start our new clock infrastructure by adding the registration code, common
structure and common code.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/Makefile              |   1 +
 drivers/clk/sunxi-ng/Makefile     |   2 +
 drivers/clk/sunxi-ng/ccu_common.c | 108 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_common.h |  74 ++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_factor.h |  15 ++++++
 drivers/clk/sunxi-ng/ccu_mux.h    |  20 +++++++
 drivers/clk/sunxi-ng/ccu_reset.c  |  55 +++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_reset.h  |  40 ++++++++++++++
 8 files changed, 315 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/Makefile
 create mode 100644 drivers/clk/sunxi-ng/ccu_common.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_common.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_factor.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_mux.h
 create mode 100644 drivers/clk/sunxi-ng/ccu_reset.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_reset.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 4ef71a13ab37..83a93cd9e21d 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
 obj-$(CONFIG_ARCH_STI)			+= st/
 obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
+obj-$(CONFIG_ARCH_SUNXI)		+= sunxi-ng/
 obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
 obj-y					+= ti/
 obj-$(CONFIG_ARCH_U8500)		+= ux500/
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
new file mode 100644
index 000000000000..bd3461b0f38c
--- /dev/null
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -0,0 +1,2 @@
+obj-y += ccu_common.o
+obj-y += ccu_reset.o
diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu_common.c
new file mode 100644
index 000000000000..1d9242566fbd
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_common.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright 2016 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
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
+#include <linux/clk-provider.h>
+#include <linux/iopoll.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+#include "ccu_common.h"
+#include "ccu_reset.h"
+
+static DEFINE_SPINLOCK(ccu_lock);
+
+void ccu_helper_wait_for_lock(struct ccu_common *common, u32 lock)
+{
+	u32 reg;
+
+	if (!(common->features & CCU_FEATURE_LOCK))
+		return;
+
+	WARN_ON(readl_relaxed_poll_timeout(common->base + common->reg, reg,
+					   !(reg & lock), 0, 500));
+}
+
+int sunxi_ccu_probe(struct device_node *node,
+		    const struct sunxi_ccu_desc *desc)
+{
+	struct ccu_common **cclks = desc->clks;
+	size_t num_clks = desc->num_clks;
+	struct clk_onecell_data *data;
+	struct ccu_reset *reset;
+	struct clk **clks;
+	void __iomem *reg;
+	int i, ret;
+	
+	reg = of_iomap(node, 0);
+	if (IS_ERR(reg)) {
+		pr_err("%s: Could not map the clock registers\n",
+		       of_node_full_name(node));
+		return PTR_ERR(reg);
+	}
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	clks = kcalloc(num_clks, sizeof(struct clk *), GFP_KERNEL);
+	if (!clks)
+		return -ENOMEM;
+
+	data->clks = clks;
+	data->clk_num = num_clks;
+
+	for (i = 0; i < num_clks; i++) {
+		struct ccu_common *cclk = cclks[i];
+		struct clk *clk;
+
+		if (!cclk) {
+			cclk = ERR_PTR(-ENOENT);
+			continue;
+		}
+
+		cclk->base = reg;
+		cclk->lock = &ccu_lock;
+
+		clk = clk_register(NULL, &cclk->hw);
+		if (IS_ERR(clk))
+			continue;
+
+		clks[i] = clk;
+	}
+
+	ret = of_clk_add_provider(node, of_clk_src_onecell_get, data);
+	if (ret)
+		goto err_clk_unreg;
+
+	reset = kzalloc(sizeof(*reset), GFP_KERNEL);
+	reset->rcdev.of_node = node;
+	reset->rcdev.ops = &ccu_reset_ops;
+	reset->rcdev.owner = THIS_MODULE;
+	reset->rcdev.nr_resets = desc->num_resets;
+	reset->base = reg;
+	reset->lock = &ccu_lock;
+	reset->reset_map = desc->resets;
+
+	ret = reset_controller_register(&reset->rcdev);
+	if (ret)
+		goto err_of_clk_unreg;
+
+	return 0;
+
+err_of_clk_unreg:
+err_clk_unreg:
+	return ret;
+}
diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
new file mode 100644
index 000000000000..e8b477fcd320
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -0,0 +1,74 @@
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
+#ifndef _COMMON_H_
+#define _COMMON_H_
+
+#include <linux/compiler.h>
+#include <linux/clk-provider.h>
+
+#define CCU_FEATURE_GATE		BIT(0)
+#define CCU_FEATURE_LOCK		BIT(1)
+#define CCU_FEATURE_FRACTIONAL		BIT(2)
+#define CCU_FEATURE_VARIABLE_PREDIV	BIT(3)
+#define CCU_FEATURE_FIXED_PREDIV	BIT(4)
+#define CCU_FEATURE_FIXED_POSTDIV	BIT(5)
+
+struct device_node;
+
+#define SUNXI_HW_INIT(_name, _parent, _ops, _flags)			\
+	&(struct clk_init_data) {					\
+		.flags		= _flags,				\
+		.name		= _name,				\
+		.parent_names	= (const char *[]) { _parent },		\
+		.num_parents	= 1,					\
+		.ops 		= _ops,					\
+	}
+
+#define SUNXI_HW_INIT_PARENTS(_name, _parents, _ops, _flags)		\
+	&(struct clk_init_data) {					\
+		.flags		= _flags,				\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.ops 		= _ops,					\
+	}
+
+struct ccu_common {
+	void __iomem	*base;
+	unsigned long	reg;
+
+	unsigned long	features;
+	spinlock_t	*lock;
+	struct clk_hw	hw;
+};
+
+static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
+{
+	return container_of(hw, struct ccu_common, hw);
+}
+
+struct sunxi_ccu_desc {
+	struct ccu_common	**clks;
+	unsigned long		num_clks;
+
+	struct ccu_reset_map	*resets;
+	unsigned long		num_resets;
+};
+
+void ccu_helper_wait_for_lock(struct ccu_common *common, u32 lock);
+
+int sunxi_ccu_probe(struct device_node *node,
+		    const struct sunxi_ccu_desc *desc);
+
+#endif /* _COMMON_H_ */
diff --git a/drivers/clk/sunxi-ng/ccu_factor.h b/drivers/clk/sunxi-ng/ccu_factor.h
new file mode 100644
index 000000000000..e7cc564aaea0
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_factor.h
@@ -0,0 +1,15 @@
+#ifndef _CLK_FACTOR_H_
+#define _CLK_FACTOR_H_
+
+struct ccu_factor {
+	u8	shift;
+	u8	width;
+};
+
+#define SUNXI_CLK_FACTOR(_shift, _width)	\
+	{					\
+		.shift	= _shift,		\
+		.width	= _width,		\
+	}
+
+#endif /* _CLK_FACTOR_H_ */
diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
new file mode 100644
index 000000000000..17cedad4e433
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -0,0 +1,20 @@
+#ifndef _CCU_MUX_H_
+#define _CCU_MUX_H_
+
+#include "common.h"
+
+struct ccu_mux_internal {
+	u8	shift;
+	u8	width;
+
+	u8	*map;
+};
+
+#define SUNXI_CLK_MUX(_shift, _width, _map)	\
+	{					\
+		.map	= _map,			\
+		.shift	= _shift,		\
+		.width	= _width,		\
+	}
+
+#endif /* _CCU_MUX_H_ */
diff --git a/drivers/clk/sunxi-ng/ccu_reset.c b/drivers/clk/sunxi-ng/ccu_reset.c
new file mode 100644
index 000000000000..6c31d48783a7
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_reset.c
@@ -0,0 +1,55 @@
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
+#include <linux/io.h>
+#include <linux/reset-controller.h>
+
+#include "ccu_reset.h"
+
+static int ccu_reset_assert(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	struct ccu_reset *ccu = rcdev_to_ccu_reset(rcdev);
+	const struct ccu_reset_map *map = &ccu->reset_map[id];
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(ccu->lock, flags);
+
+	reg = readl(ccu->base + map->reg);
+	writel(reg & ~map->bit, ccu->base + map->reg);
+
+	spin_unlock_irqrestore(ccu->lock, flags);
+
+	return 0;
+}
+
+static int ccu_reset_deassert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct ccu_reset *ccu = rcdev_to_ccu_reset(rcdev);
+	const struct ccu_reset_map *map = &ccu->reset_map[id];
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(ccu->lock, flags);
+
+	reg = readl(ccu->base + map->reg);
+	writel(reg | map->bit, ccu->base + map->reg);
+
+	spin_unlock_irqrestore(ccu->lock, flags);
+
+	return 0;
+}
+
+const struct reset_control_ops ccu_reset_ops = {
+	.assert		= ccu_reset_assert,
+	.deassert	= ccu_reset_deassert,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_reset.h b/drivers/clk/sunxi-ng/ccu_reset.h
new file mode 100644
index 000000000000..36a4679210bd
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_reset.h
@@ -0,0 +1,40 @@
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
+#ifndef _CCU_RESET_H_
+#define _CCU_RESET_H_
+
+#include <linux/reset-controller.h>
+
+struct ccu_reset_map {
+	u16	reg;
+	u32	bit;
+};
+
+
+struct ccu_reset {
+	void __iomem			*base;
+	struct ccu_reset_map		*reset_map;
+	spinlock_t			*lock;
+
+	struct reset_controller_dev	rcdev;
+};
+
+static inline struct ccu_reset *rcdev_to_ccu_reset(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct ccu_reset, rcdev);
+}
+
+extern const struct reset_control_ops ccu_reset_ops;
+
+#endif /* _CCU_RESET_H_ */
-- 
2.8.2
