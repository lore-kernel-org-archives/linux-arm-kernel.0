From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 27 Jul 2016 03:09:52 +0900
Subject: [PATCH v5 1/2] clk: uniphier: add core support code for UniPhier
 clock drivers
In-Reply-To: <1469556593-11369-1-git-send-email-yamada.masahiro@socionext.com>
References: <1469556593-11369-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1469556593-11369-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the common code for the clock drivers of UniPhier SoCs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 MAINTAINERS                                      |   1 +
 drivers/clk/Kconfig                              |   1 +
 drivers/clk/Makefile                             |   1 +
 drivers/clk/uniphier/Kconfig                     |   9 ++
 drivers/clk/uniphier/Makefile                    |   6 ++
 drivers/clk/uniphier/clk-uniphier-core.c         | 125 +++++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier-fixed-factor.c |  49 +++++++++
 drivers/clk/uniphier/clk-uniphier-fixed-rate.c   |  48 +++++++++
 drivers/clk/uniphier/clk-uniphier-gate.c         |  97 ++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier-mux.c          |  95 +++++++++++++++++
 drivers/clk/uniphier/clk-uniphier.h              |  83 +++++++++++++++
 11 files changed, 515 insertions(+)
 create mode 100644 drivers/clk/uniphier/Kconfig
 create mode 100644 drivers/clk/uniphier/Makefile
 create mode 100644 drivers/clk/uniphier/clk-uniphier-core.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-fixed-factor.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-fixed-rate.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-gate.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier-mux.c
 create mode 100644 drivers/clk/uniphier/clk-uniphier.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d28df0b..2bbf3fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1824,6 +1824,7 @@ F:	arch/arm/mach-uniphier/
 F:	arch/arm/mm/cache-uniphier.c
 F:	arch/arm64/boot/dts/socionext/
 F:	drivers/bus/uniphier-system-bus.c
+F:	drivers/clk/uniphier/
 F:	drivers/i2c/busses/i2c-uniphier*
 F:	drivers/pinctrl/uniphier/
 F:	drivers/tty/serial/8250/8250_uniphier.c
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index e2d9bd7..584c10d 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -218,5 +218,6 @@ source "drivers/clk/samsung/Kconfig"
 source "drivers/clk/sunxi-ng/Kconfig"
 source "drivers/clk/tegra/Kconfig"
 source "drivers/clk/ti/Kconfig"
+source "drivers/clk/uniphier/Kconfig"
 
 endmenu
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 3b6f9cf..7d66cef 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
 obj-$(CONFIG_ARCH_SUNXI)		+= sunxi-ng/
 obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
 obj-y					+= ti/
+obj-$(CONFIG_CLK_UNIPHIER)		+= uniphier/
 obj-$(CONFIG_ARCH_U8500)		+= ux500/
 obj-$(CONFIG_COMMON_CLK_VERSATILE)	+= versatile/
 obj-$(CONFIG_X86)			+= x86/
diff --git a/drivers/clk/uniphier/Kconfig b/drivers/clk/uniphier/Kconfig
new file mode 100644
index 0000000..a67c133
--- /dev/null
+++ b/drivers/clk/uniphier/Kconfig
@@ -0,0 +1,9 @@
+config CLK_UNIPHIER
+	tristate "Clock driver for UniPhier SoCs"
+	depends on ARCH_UNIPHIER || COMPILE_TEST
+	depends on OF && MFD_SYSCON
+	default ARCH_UNIPHIER
+	help
+	  Support for clock controllers on UniPhier SoCs.
+	  Say Y if you want to control clocks provided by System Control
+	  block, Media I/O block, Peripheral Block.
diff --git a/drivers/clk/uniphier/Makefile b/drivers/clk/uniphier/Makefile
new file mode 100644
index 0000000..8f359aa
--- /dev/null
+++ b/drivers/clk/uniphier/Makefile
@@ -0,0 +1,6 @@
+obj-$(CONFIG_CLK_UNIPHIER)	+= clk-uniphier.o
+clk-uniphier-y			+= clk-uniphier-core.o
+clk-uniphier-y			+= clk-uniphier-fixed-factor.o
+clk-uniphier-y			+= clk-uniphier-fixed-rate.o
+clk-uniphier-y			+= clk-uniphier-gate.o
+clk-uniphier-y			+= clk-uniphier-mux.o
diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
new file mode 100644
index 0000000..fcb7582
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-core.c
@@ -0,0 +1,125 @@
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
+#include <linux/module.h>
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
+		dev_err(dev, "unsupported clock type\n");
+		return ERR_PTR(-EINVAL);
+	}
+}
+
+static const struct of_device_id uniphier_clk_match[] = {
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, uniphier_clk_match);
+
+int uniphier_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *match;
+	struct clk_hw_onecell_data *hw_data;
+	struct device_node *parent;
+	struct regmap *regmap;
+	const struct uniphier_clk_data *p;
+	int clk_num = 0;
+
+	match = of_match_node(uniphier_clk_match, dev->of_node);
+	if (!match)
+		return -ENODEV;
+
+	parent = of_get_parent(dev->of_node); /* parent should be syscon node */
+	regmap = syscon_node_to_regmap(parent);
+	of_node_put(parent);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "failed to get regmap (error %ld)\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	for (p = match->data; p->name; p++)
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
+	for (p = match->data; p->name; p++) {
+		struct clk_hw *hw;
+
+		dev_dbg(dev, "register %s (index=%d)\n", p->name,
+			p->output_index);
+		hw = uniphier_clk_register(dev, regmap, p);
+		if (IS_ERR(hw)) {
+			dev_err(dev, "failed to register %s (error %ld)\n",
+				p->name, PTR_ERR(hw));
+			return PTR_ERR(hw);
+		}
+
+		if (p->output_index >= 0)
+			hw_data->hws[p->output_index] = hw;
+	}
+
+	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
+				      hw_data);
+}
+
+int uniphier_clk_remove(struct platform_device *pdev)
+{
+	of_clk_del_provider(pdev->dev.of_node);
+
+	return 0;
+}
+
+static struct platform_driver uniphier_clk_driver = {
+	.probe = uniphier_clk_probe,
+	.remove = uniphier_clk_remove,
+	.driver = {
+		.name = "uniphier-clk",
+		.of_match_table = uniphier_clk_match,
+	},
+};
+module_platform_driver(uniphier_clk_driver);
+
+MODULE_AUTHOR("Masahiro Yamada <yamada.masahiro@socionext.com>");
+MODULE_DESCRIPTION("UniPhier Clock Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/uniphier/clk-uniphier-fixed-factor.c b/drivers/clk/uniphier/clk-uniphier-fixed-factor.c
new file mode 100644
index 0000000..d64ea61
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-fixed-factor.c
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
diff --git a/drivers/clk/uniphier/clk-uniphier-fixed-rate.c b/drivers/clk/uniphier/clk-uniphier-fixed-rate.c
new file mode 100644
index 0000000..e0f55ca
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-fixed-rate.c
@@ -0,0 +1,48 @@
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
diff --git a/drivers/clk/uniphier/clk-uniphier-gate.c b/drivers/clk/uniphier/clk-uniphier-gate.c
new file mode 100644
index 0000000..f4488fa
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-gate.c
@@ -0,0 +1,97 @@
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
+};
+
+#define to_uniphier_clk_gate(_hw) \
+				container_of(_hw, struct uniphier_clk_gate, hw)
+
+static int uniphier_clk_gate_endisable(struct clk_hw *hw, int enable)
+{
+	struct uniphier_clk_gate *gate = to_uniphier_clk_gate(hw);
+
+	return regmap_write_bits(gate->regmap, gate->reg, gate->mask,
+				 enable ? gate->mask : 0);
+}
+
+static int uniphier_clk_gate_enable(struct clk_hw *hw)
+{
+	return uniphier_clk_gate_endisable(hw, 1);
+}
+
+static void uniphier_clk_gate_disable(struct clk_hw *hw)
+{
+	if (uniphier_clk_gate_endisable(hw, 0) < 0)
+		pr_warn("failed to disable clk\n");
+}
+
+static int uniphier_clk_gate_is_enabled(struct clk_hw *hw)
+{
+	struct uniphier_clk_gate *gate = to_uniphier_clk_gate(hw);
+	unsigned int val;
+
+	if (regmap_read(gate->regmap, gate->reg, &val) < 0)
+		pr_warn("is_enabled() may return wrong result\n");
+
+	return !(~val & gate->mask);
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
+	gate->hw.init = &init;
+
+	ret = devm_clk_hw_register(dev, &gate->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &gate->hw;
+}
diff --git a/drivers/clk/uniphier/clk-uniphier-mux.c b/drivers/clk/uniphier/clk-uniphier-mux.c
new file mode 100644
index 0000000..15a2f2c
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier-mux.c
@@ -0,0 +1,95 @@
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
diff --git a/drivers/clk/uniphier/clk-uniphier.h b/drivers/clk/uniphier/clk-uniphier.h
new file mode 100644
index 0000000..364953c
--- /dev/null
+++ b/drivers/clk/uniphier/clk-uniphier.h
@@ -0,0 +1,83 @@
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
+#endif /* __CLK_UNIPHIER_H__ */
-- 
1.9.1
