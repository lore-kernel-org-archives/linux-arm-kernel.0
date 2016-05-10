From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 10 May 2016 18:50:43 +0900
Subject: [RFC PATCH 02/21] clk: uniphier: add core support for UniPhier clock
 driver
In-Reply-To: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462873862-30940-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462873862-30940-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core support for the clock drivers of all UniPhier SoCs.

This part is the update from the version 2.
https://lkml.org/lkml/2016/5/2/721

After discussing Stephen and Michael, I changed various things
in this version:

  - Change to platform drivers instead of OF_CLK_DECLARE
  - Split into a core part + SoC drivers
    SoC drivers just consist of tables of SoC-specific data.
    This allows reviewer to concentrate on the core-part
  - Hard-code parent clock names for cascading

Another big change is that the clock drivers are populated
from the parent MFD.
On UniPhier SoCs, registers for clock, reset, and other system
controlling are mixed in one hardware block.  It is difficult
to have one independent clock node.
So, I chose to use MFD from which clocks and resets (and
power in the future) are populated.

This series is just for review.
Please do not apply this patch.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 MAINTAINERS                                      |  1 +
 drivers/clk/uniphier/Kconfig                     |  9 +++
 drivers/clk/uniphier/Makefile                    |  5 ++
 drivers/clk/uniphier/clk-uniphier-core.c         | 99 ++++++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier-fixed-factor.c | 50 ++++++++++++
 drivers/clk/uniphier/clk-uniphier-fixed-rate.c   | 49 ++++++++++++
 drivers/clk/uniphier/clk-uniphier-gate.c         | 98 +++++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier-mux.c          | 96 +++++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier.h              | 89 +++++++++++++++++++++
 9 files changed, 496 insertions(+)
 create mode 100644 drivers/clk/uniphier/Kconfig
 create mode 100644 drivers/clk/uniphier/Makefile
 create mode 100644 drivers/clk/uniphier/clk-uniphier-core.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-fixed-factor.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-fixed-rate.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-gate.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-mux.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c987ca..38c6bb5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1727,6 +1727,7 @@ F:	arch/arm/mach-uniphier/
 F:	arch/arm/mm/cache-uniphier.c
 F:	arch/arm64/boot/dts/socionext/
 F:	drivers/bus/uniphier-system-bus.c
+F:	drivers/clk/uniphier/
 F:	drivers/i2c/busses/i2c-uniphier*
 F:	drivers/mfd/uniphier-mfd.c
 F:	drivers/mmc/host/uniphier-sd.c
diff --git a/drivers/clk/uniphier/Kconfig b/drivers/clk/uniphier/Kconfig
new file mode 100644
index 0000000..f36529a
--- /dev/null
+++ b/drivers/clk/uniphier/Kconfig
@@ -0,0 +1,9 @@
+menuconfig CLK_UNIPHIER
+	bool "Clock drivers for UniPhier SoCs"
+	depends on (ARCH_UNIPHIER && MFD_UNIPHIER) || COMPILE_TEST
+	depends on OF && MFD_CORE && MFD_SYSCON
+	default ARCH_UNIPHIER && MFD_UNIPHIER
+
+if CLK_UNIPHIER
+
+endif
diff --git a/drivers/clk/uniphier/Makefile b/drivers/clk/uniphier/Makefile
new file mode 100644
index 0000000..4d6daa8
--- /dev/null
+++ b/drivers/clk/uniphier/Makefile
@@ -0,0 +1,5 @@
+obj-y				+= clk-uniphier-core.o
+obj-y				+= clk-uniphier-fixed-factor.o
+obj-y				+= clk-uniphier-fixed-rate.o
+obj-y				+= clk-uniphier-gate.o
+obj-y				+= clk-uniphier-mux.o
diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
new file mode 100644
index 0000000..72953a0
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "clk-uniphier.h"
+
+static struct clk_hw *uniphier_clk_register(struct device *dev,
+					    struct regmap *regmap,
+					const struct uniphier_clk_data *data)
+{
+	switch (data->type) {
+	case UNIPHIER_CLK_TYPE_FIXED_FACTOR:
+		return uniphier_clk_register_fixed_factor(dev, data->name,
+							  &data->data.factor);
+	case UNIPHIER_CLK_TYPE_FIXED_RATE:
+		return uniphier_clk_register_fixed_rate(dev, data->name,
+							&data->data.rate);
+	case UNIPHIER_CLK_TYPE_GATE:
+		return uniphier_clk_register_gate(dev, regmap, data->name,
+						  &data->data.gate);
+	case UNIPHIER_CLK_TYPE_MUX:
+		return uniphier_clk_register_mux(dev, regmap, data->name,
+						 &data->data.mux);
+	default:
+		WARN(1, "unsupported clock type\n");
+		return ERR_PTR(-EINVAL);
+	}
+}
+
+int uniphier_clk_probe(struct platform_device *pdev,
+		       const struct uniphier_clk_data *data)
+{
+	struct device *dev = &pdev->dev;
+	struct clk_hw_onecell_data *hw_data;
+	struct regmap *regmap;
+	const struct uniphier_clk_data *p;
+	int clk_num = 0;
+
+	/* parent should be MFD and syscon node */
+	regmap = syscon_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "failed to get regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	for (p = data; p->name; p++)
+		clk_num = max(clk_num, p->output_index + 1);
+
+	hw_data = devm_kzalloc(dev,
+			sizeof(*hw_data) + clk_num * sizeof(struct clk_hw *),
+			GFP_KERNEL);
+	if (!hw_data)
+		return -ENOMEM;
+
+	hw_data->num = clk_num;
+
+	for (p = data; p->name; p++) {
+		struct clk_hw *hw;
+
+		dev_dbg(dev, "register %s (index=%d)\n", p->name,
+			p->output_index);
+		hw = uniphier_clk_register(dev, regmap, p);
+		if (IS_ERR(hw)) {
+			dev_err(dev, "failed to register %s\n", p->name);
+			return PTR_ERR(hw);
+		}
+
+		if (p->output_index >= 0)
+			hw_data->hws[p->output_index] = hw;
+	}
+
+	return of_clk_add_hw_provider(dev->parent->of_node,
+				      of_clk_hw_onecell_get, hw_data);
+}
+EXPORT_SYMBOL_GPL(uniphier_clk_probe);
+
+int uniphier_clk_remove(struct platform_device *pdev)
+{
+	of_clk_del_provider(pdev->dev.parent->of_node);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uniphier_clk_remove);
diff --git a/drivers/clk/uniphier/clk-uniphier-fixed-factor.c b/drivers/clk/uniphier/clk-uniphier-fixed-factor.c
new file mode 100644
index 0000000..2a2d5bd
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-fixed-factor.c
@@ -0,0 +1,50 @@
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
+#include <linux/device.h>
+
+#include "clk-uniphier.h"
+
+struct clk_hw *uniphier_clk_register_fixed_factor(struct device *dev,
+						  const char *name,
+			const struct uniphier_clk_fixed_factor_data *data)
+{
+	struct clk_fixed_factor *fix;
+	struct clk_init_data init;
+	int ret;
+
+	fix = devm_kzalloc(dev, sizeof(*fix), GFP_KERNEL);
+	if (!fix)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_fixed_factor_ops;
+	init.flags = data->parent_name ? CLK_SET_RATE_PARENT : 0;
+	init.flags |= CLK_IS_BASIC;
+	init.parent_names = data->parent_name ? &data->parent_name : NULL;
+	init.num_parents = data->parent_name ? 1 : 0;
+
+	fix->mult = data->mult;
+	fix->div = data->div;
+	fix->hw.init = &init;
+
+	ret = devm_clk_hw_register(dev, &fix->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &fix->hw;
+}
+EXPORT_SYMBOL_GPL(uniphier_clk_register_fixed_factor);
diff --git a/drivers/clk/uniphier/clk-uniphier-fixed-rate.c b/drivers/clk/uniphier/clk-uniphier-fixed-rate.c
new file mode 100644
index 0000000..1fc6258
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-fixed-rate.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
+#include <linux/device.h>
+
+#include "clk-uniphier.h"
+
+struct clk_hw *uniphier_clk_register_fixed_rate(struct device *dev,
+						const char *name,
+				const struct uniphier_clk_fixed_rate_data *data)
+{
+	struct clk_fixed_rate *fixed;
+	struct clk_init_data init;
+	int ret;
+
+	/* allocate fixed-rate clock */
+	fixed = devm_kzalloc(dev, sizeof(*fixed), GFP_KERNEL);
+	if (!fixed)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_fixed_rate_ops;
+	init.flags = CLK_IS_BASIC;
+	init.parent_names = NULL;
+	init.num_parents = 0;
+
+	fixed->fixed_rate = data->fixed_rate;
+	fixed->hw.init = &init;
+
+	ret = devm_clk_hw_register(dev, &fixed->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &fixed->hw;
+}
+EXPORT_SYMBOL_GPL(uniphier_clk_register_fixed_rate);
diff --git a/drivers/clk/uniphier/clk-uniphier-gate.c b/drivers/clk/uniphier/clk-uniphier-gate.c
new file mode 100644
index 0000000..c42b0a8
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-gate.c
@@ -0,0 +1,98 @@
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+#include "clk-uniphier.h"
+
+struct uniphier_clk_gate {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	unsigned int reg;
+	unsigned int mask;
+	unsigned int enable_val;
+};
+
+#define to_uniphier_clk_gate(_hw) \
+				container_of(_hw, struct uniphier_clk_gate, hw)
+
+static int uniphier_clk_gate_enable(struct clk_hw *hw)
+{
+	struct uniphier_clk_gate *gate = to_uniphier_clk_gate(hw);
+
+	return regmap_write_bits(gate->regmap, gate->reg, gate->mask,
+				 gate->enable_val);
+}
+
+static void uniphier_clk_gate_disable(struct clk_hw *hw)
+{
+	struct uniphier_clk_gate *gate = to_uniphier_clk_gate(hw);
+
+	if (regmap_write_bits(gate->regmap, gate->reg, gate->mask,
+			      ~gate->enable_val) < 0)
+		pr_warn("regmap_write_bits failed. clk may not be disabled\n");
+}
+
+static int uniphier_clk_gate_is_enabled(struct clk_hw *hw)
+{
+	struct uniphier_clk_gate *gate = to_uniphier_clk_gate(hw);
+	unsigned int val;
+
+	if (regmap_read(gate->regmap, gate->reg, &val) < 0)
+		pr_warn("regmap_read failed. is_enabled() may return wrong result\n");
+
+	return (val & gate->mask) == gate->enable_val;
+}
+
+static const struct clk_ops uniphier_clk_gate_ops = {
+	.enable = uniphier_clk_gate_enable,
+	.disable = uniphier_clk_gate_disable,
+	.is_enabled = uniphier_clk_gate_is_enabled,
+};
+
+struct clk_hw *uniphier_clk_register_gate(struct device *dev,
+					  struct regmap *regmap,
+					  const char *name,
+				const struct uniphier_clk_gate_data *data)
+{
+	struct uniphier_clk_gate *gate;
+	struct clk_init_data init;
+	int ret;
+
+	gate = devm_kzalloc(dev, sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &uniphier_clk_gate_ops;
+	init.flags = data->parent_name ? CLK_SET_RATE_PARENT : 0;
+	init.parent_names = data->parent_name ? &data->parent_name : NULL;
+	init.num_parents = data->parent_name ? 1 : 0;
+
+	gate->regmap = regmap;
+	gate->reg = data->reg;
+	gate->mask = data->mask;
+	gate->enable_val = data->enable_val;
+	gate->hw.init = &init;
+
+	ret = devm_clk_hw_register(dev, &gate->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &gate->hw;
+}
+EXPORT_SYMBOL_GPL(uniphier_clk_register_gate);
diff --git a/drivers/clk/uniphier/clk-uniphier-mux.c b/drivers/clk/uniphier/clk-uniphier-mux.c
new file mode 100644
index 0000000..e18d5d3
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-mux.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+#include "clk-uniphier.h"
+
+struct uniphier_clk_mux {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	unsigned int reg;
+	const unsigned int *masks;
+	const unsigned int *vals;
+};
+
+#define to_uniphier_clk_mux(_hw) container_of(_hw, struct uniphier_clk_mux, hw)
+
+static int uniphier_clk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct uniphier_clk_mux *mux = to_uniphier_clk_mux(hw);
+
+	return regmap_write_bits(mux->regmap, mux->reg, mux->masks[index],
+				 mux->vals[index]);
+}
+
+static u8 uniphier_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct uniphier_clk_mux *mux = to_uniphier_clk_mux(hw);
+	int num_parents = clk_hw_get_num_parents(hw);
+	int ret;
+	u32 val;
+	u8 i;
+
+	ret = regmap_read(mux->regmap, mux->reg, &val);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < num_parents; i++)
+		if ((mux->masks[i] & val) == mux->vals[i])
+			return i;
+
+	return -EINVAL;
+}
+
+static const struct clk_ops uniphier_clk_mux_ops = {
+	.determine_rate = __clk_mux_determine_rate,
+	.set_parent = uniphier_clk_mux_set_parent,
+	.get_parent = uniphier_clk_mux_get_parent,
+};
+
+struct clk_hw *uniphier_clk_register_mux(struct device *dev,
+					 struct regmap *regmap,
+					 const char *name,
+				const struct uniphier_clk_mux_data *data)
+{
+	struct uniphier_clk_mux *mux;
+	struct clk_init_data init;
+	int ret;
+
+	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &uniphier_clk_mux_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_names = data->parent_names;
+	init.num_parents = data->num_parents,
+
+	mux->regmap = regmap;
+	mux->reg = data->reg;
+	mux->masks = data->masks;
+	mux->vals = data->vals;
+	mux->hw.init = &init;
+
+	ret = devm_clk_hw_register(dev, &mux->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &mux->hw;
+}
+EXPORT_SYMBOL_GPL(uniphier_clk_register_mux);
diff --git a/drivers/clk/uniphier/clk-uniphier.h b/drivers/clk/uniphier/clk-uniphier.h
new file mode 100644
index 0000000..d5f3948
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier.h
@@ -0,0 +1,89 @@
+/*
+ * Copyright (C) 2016 Socionext Inc.
+ *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
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
+#ifndef __CLK_UNIPHIER_H__
+#define __CLK_UNIPHIER_H__
+
+struct clk_hw;
+struct device;
+struct platform_device;
+struct regmap;
+
+#define UNIPHIER_CLK_MUX_MAX_PARENTS	8
+
+enum uniphier_clk_type {
+	UNIPHIER_CLK_TYPE_FIXED_FACTOR,
+	UNIPHIER_CLK_TYPE_FIXED_RATE,
+	UNIPHIER_CLK_TYPE_GATE,
+	UNIPHIER_CLK_TYPE_MUX,
+};
+
+struct uniphier_clk_fixed_factor_data {
+	const char *parent_name;
+	unsigned int mult;
+	unsigned int div;
+};
+
+struct uniphier_clk_fixed_rate_data {
+	unsigned long fixed_rate;
+};
+
+struct uniphier_clk_gate_data {
+	const char *parent_name;
+	unsigned int reg;
+	unsigned int mask;
+	unsigned int enable_val;
+};
+
+struct uniphier_clk_mux_data {
+	const char *parent_names[UNIPHIER_CLK_MUX_MAX_PARENTS];
+	unsigned int num_parents;
+	unsigned int reg;
+	unsigned int masks[UNIPHIER_CLK_MUX_MAX_PARENTS];
+	unsigned int vals[UNIPHIER_CLK_MUX_MAX_PARENTS];
+};
+
+struct uniphier_clk_data {
+	const char *name;
+	enum uniphier_clk_type type;
+	int output_index;
+	union {
+		struct uniphier_clk_fixed_factor_data factor;
+		struct uniphier_clk_fixed_rate_data rate;
+		struct uniphier_clk_gate_data gate;
+		struct uniphier_clk_mux_data mux;
+	} data;
+};
+
+struct clk_hw *uniphier_clk_register_fixed_factor(struct device *dev,
+						  const char *name,
+			const struct uniphier_clk_fixed_factor_data *data);
+struct clk_hw *uniphier_clk_register_fixed_rate(struct device *dev,
+						const char *name,
+			const struct uniphier_clk_fixed_rate_data *data);
+struct clk_hw *uniphier_clk_register_gate(struct device *dev,
+					  struct regmap *regmap,
+					  const char *name,
+				const struct uniphier_clk_gate_data *data);
+struct clk_hw *uniphier_clk_register_mux(struct device *dev,
+					 struct regmap *regmap,
+					 const char *name,
+				const struct uniphier_clk_mux_data *data);
+
+int uniphier_clk_probe(struct platform_device *pdev,
+		       const struct uniphier_clk_data *data);
+int uniphier_clk_remove(struct platform_device *pdev);
+
+#endif /* __CLK_UNIPHIER_H__ */
-- 
1.9.1
