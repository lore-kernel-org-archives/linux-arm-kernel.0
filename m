From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Dec 2012 23:08:16 +0100
Subject: [PATCH 1/6] ARM: sunxi: Add pinctrl driver for Allwinner SoCs
In-Reply-To: <1355177301-31928-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1355177301-31928-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1355177301-31928-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner SoCs have an IP module that handle both the muxing and the
GPIOs.

This IP has 8 banks of 32 bits, with a number of pins actually useful
for each of these banks varying from one to another, and depending on
the SoC used on the board.

This driver only implements the pinctrl part, the gpio part will come
eventually.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   77 ++++
 arch/arm/mach-sunxi/Kconfig                        |    1 +
 drivers/pinctrl/Kconfig                            |    5 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-sunxi.c                    |  435 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-sunxi.h                    |  315 ++++++++++++++
 6 files changed, 834 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-sunxi.c
 create mode 100644 drivers/pinctrl/pinctrl-sunxi.h

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
new file mode 100644
index 0000000..f1968e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -0,0 +1,77 @@
+* Allwinner A1X Pin Controller
+
+The pins controlled by sunXi pin controller are organized in banks,
+each bank has 32 pins.  Each pin has 7 multiplexing functions, with
+the first two functions being GPIO in and out. The configuration on
+the pins includes drive strength and pull-up.
+
+Required properties:
+- compatible: "allwinner,<soc>-pinctrl". Supported SoCs for now are:
+  sun5i.
+- reg: Should contain the register physical address and length for the
+  pin controller.
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices.
+
+A pinctrl node should contain at least one subnodes representing the
+pinctrl groups available on the machine. Each subnode will list the
+pins it needs, and how they should be configured, with regard to muxer
+configuration, drive strength and pullups. If one of these options is
+not set, its actual value will be unspecified.
+
+Required subnode-properties:
+
+
+- allwinner,pin-ids: An integer array. Each integer in the array
+  specify a pin with given mux function, with bank, pin and mux packed
+  as below.
+
+    [15..12] : bank number
+    [11..4]  : pin number
+    [3..0]   : mux selection
+
+  This integer with mux selection packed is used as an entity by both group
+  and config nodes to identify a pin.  The mux selection in the integer takes
+  effects only on group node, and will get ignored by driver with config node,
+  since config node is only meant to set up pin configurations.
+
+  Valid values for these integers are listed below.
+
+- reg: Should be the index of the group nodes for same function.  This property
+  is required only for group nodes, and should not be present in any config
+  nodes.
+
+Optional subnode-properties:
+- allwinner,drive: Integer.
+    0: To be documented
+    1: To be documented
+    2: To be documented
+    3: To be documented
+- allwinner,pull: Integer.
+    0: No resistor
+    1: Pull-up resistor
+    2: Pull-down resistor
+
+Examples:
+
+pinctrl at 01c20800 {
+	compatible = "allwinner,sun5i-pinctrl";
+	reg = <0x01c20800 0x400>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	uart1_pins_a: uart1 at 0 {
+		reg = <0>;
+		allwinner,pin-ids = <0x40a4 0x40b4>;
+		allwinner,drive = <0>;
+		allwinner,pull = <0>;
+	};
+
+	uart1_pins_b: uart1 at 1 {
+		reg = <1>;
+		allwinner,pin-ids = <0x6034 0x6044>;
+		allwinner,drive = <0>;
+		allwinner,pull = <0>;
+	};
+};
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 3fdd008..8709a39 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -7,3 +7,4 @@ config ARCH_SUNXI
 	select PINCTRL
 	select SPARSE_IRQ
 	select SUNXI_TIMER
+	select PINCTRL_SUNXI
\ No newline at end of file
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index d96caef..94925ab 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -147,6 +147,11 @@ config PINCTRL_SIRF
 	depends on ARCH_PRIMA2
 	select PINMUX
 
+config PINCTRL_SUNXI
+	bool
+	select PINMUX
+	select PINCONF
+
 config PINCTRL_TEGRA
 	bool
 
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index f395ba5..8f3ddea 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_PINCTRL_PXA168)	+= pinctrl-pxa168.o
 obj-$(CONFIG_PINCTRL_PXA910)	+= pinctrl-pxa910.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_SIRF)	+= pinctrl-sirf.o
+obj-$(CONFIG_PINCTRL_SUNXI)	+= pinctrl-sunxi.o
 obj-$(CONFIG_PINCTRL_TEGRA)	+= pinctrl-tegra.o
 obj-$(CONFIG_PINCTRL_TEGRA20)	+= pinctrl-tegra20.o
 obj-$(CONFIG_PINCTRL_TEGRA30)	+= pinctrl-tegra30.o
diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
new file mode 100644
index 0000000..1da6d3e
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -0,0 +1,435 @@
+/*
+ * Allwinner A1X SoCs PIO driver (GPIO + pinctrl).
+ *
+ * Copyright (C) 2012 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "core.h"
+#include "pinctrl-sunxi.h"
+
+static int sunxi_pctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->ngroups;
+}
+
+static const char *sunxi_pctrl_get_group_name(struct pinctrl_dev *pctldev,
+					      unsigned group)
+{
+	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->groups[group].name;
+}
+
+static int sunxi_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
+				      unsigned group,
+				      const unsigned **pins,
+				      unsigned *num_pins)
+{
+	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = (unsigned *)pctl->groups[group].pins;
+	*num_pins = pctl->groups[group].npins;
+
+	return 0;
+}
+
+static int sunxi_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
+				      struct device_node *node,
+				      struct pinctrl_map **map,
+				      unsigned *num_maps)
+{
+	struct pinctrl_map *new_map;
+	unsigned long *pinconfig;
+	unsigned long config = 0;
+	char *group;
+	u32 reg, val;
+	int ret;
+
+	if (of_property_read_u32(node, "reg", &reg)) {
+		dev_err(pctldev->dev, "No reg property found!\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(node, "allwinner,drive", &val);
+	if (!ret)
+		config |= val << DLEVEL_SHIFT | DLEVEL_PRESENT;
+
+	ret = of_property_read_u32(node, "allwinner,pull", &val);
+	if (!ret)
+		config |= val << PULL_SHIFT | PULL_PRESENT;
+
+	new_map = devm_kzalloc(pctldev->dev, sizeof(*new_map) * 2, GFP_KERNEL);
+	if (!new_map)
+		return -ENOMEM;
+
+	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
+	new_map[0].data.mux.function = node->name;
+
+	/* Compose group name */
+	group = devm_kzalloc(pctldev->dev, strlen(node->name) + 4, GFP_KERNEL);
+	if (!group)
+		return -ENOMEM;
+
+	snprintf(group, strlen(node->name) + 4, "%s.%d", node->name, reg);
+	new_map[0].data.mux.group = group;
+
+	pinconfig = kmemdup(&config, sizeof(config), GFP_KERNEL);
+	if (!pinconfig)
+		return -ENOMEM;
+
+	new_map[1].type = PIN_MAP_TYPE_CONFIGS_GROUP;
+	new_map[1].data.configs.group_or_pin = group;
+	new_map[1].data.configs.configs = pinconfig;
+	new_map[1].data.configs.num_configs = 1;
+
+	*map = new_map;
+	*num_maps = 2;
+
+	return 0;
+}
+
+static void sunxi_pctrl_dt_free_map(struct pinctrl_dev *pctldev,
+				    struct pinctrl_map *map,
+				    unsigned num_maps)
+{
+	int i;
+
+	for (i = 0; i < num_maps; i++) {
+		if (map[i].type == PIN_MAP_TYPE_CONFIGS_GROUP)
+			kfree(map[i].data.configs.configs);
+	}
+}
+
+static struct pinctrl_ops sunxi_pctrl_ops = {
+	.dt_node_to_map		= sunxi_pctrl_dt_node_to_map,
+	.dt_free_map		= sunxi_pctrl_dt_free_map,
+	.get_groups_count	= sunxi_pctrl_get_groups_count,
+	.get_group_name		= sunxi_pctrl_get_group_name,
+	.get_group_pins		= sunxi_pctrl_get_group_pins,
+};
+
+static int sunxi_pconf_group_get(struct pinctrl_dev *pctldev,
+				 unsigned group,
+				 unsigned long *config)
+{
+	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*config = pctl->groups[group].pctlcfg;
+
+	return 0;
+}
+
+static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
+				 unsigned group,
+				 unsigned long config)
+{
+	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct sunxi_pinctrl_group *g = &pctl->groups[group];
+	int i;
+
+	for (i = 0; i < g->npins; i++) {
+		u32 val, mask;
+
+		/* dlevel */
+		if (config & DLEVEL_PRESENT) {
+			u8 dlevel = CONFIG_TO_DLEVEL(config);
+			val = readl(pctl->membase + DLEVEL_REG(g->pins[i]));
+			mask = ((1 << DLEVEL_PINS_BITS) - 1) << DLEVEL_OFFSET(g->pins[i]);
+			val &= ~mask;
+			val |= dlevel << DLEVEL_OFFSET(g->pins[i]);
+			writel(val, pctl->membase + DLEVEL_REG(g->pins[i]));
+		}
+
+		/* pull */
+		if (config & PULL_PRESENT) {
+			u8 pull = CONFIG_TO_PULL(config);
+			val = readl(pctl->membase + PULL_REG(g->pins[i]));
+			mask = ((1 << PULL_PINS_BITS) - 1) << PULL_OFFSET(g->pins[i]);
+			val &= ~mask;
+			val |= pull << PULL_OFFSET(g->pins[i]);
+			writel(val, pctl->membase + PULL_REG(g->pins[i]));
+		}
+	}
+
+	/* cache the config value */
+	g->pctlcfg = config;
+
+	return 0;
+}
+
+static struct pinconf_ops sunxi_pconf_ops = {
+	.pin_config_group_get	= sunxi_pconf_group_get,
+	.pin_config_group_set	= sunxi_pconf_group_set,
+};
+
+static int sunxi_pmx_get_funcs_cnt(struct pinctrl_dev *pctldev)
+{
+	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->nfunctions;
+}
+
+static const char *sunxi_pmx_get_func_name(struct pinctrl_dev *pctldev,
+					   unsigned function)
+{
+	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->functions[function].name;
+}
+
+static int sunxi_pmx_get_func_groups(struct pinctrl_dev *pctldev,
+				     unsigned function,
+				     const char * const **groups,
+				     unsigned * const num_groups)
+{
+	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = pctl->functions[function].groups;
+	*num_groups = pctl->functions[function].ngroups;
+
+	return 0;
+}
+
+static void sunxi_pmx_set_config(struct pinctrl_dev *pctldev,
+				 unsigned pin,
+				 u8 config)
+{
+	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	u32 val = readl(pctl->membase + CFG_REG(pin));
+	u32 mask = ((1 << CFG_PINS_BITS) - 1) << CFG_OFFSET(pin);
+	writel((val & ~mask) | config << CFG_OFFSET(pin),
+		pctl->membase + CFG_REG(pin));
+}
+
+static int sunxi_pmx_enable(struct pinctrl_dev *pctldev,
+			    unsigned function,
+			    unsigned group)
+{
+	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct sunxi_pinctrl_group *g = &pctl->groups[group];
+	int i;
+
+	for (i = 0; i < g->npins; i++)
+		sunxi_pmx_set_config(pctldev, g->pins[i], g->muxcfg[i]);
+
+	return 0;
+}
+
+static struct pinmux_ops sunxi_pmx_ops = {
+	.get_functions_count	= sunxi_pmx_get_funcs_cnt,
+	.get_function_name	= sunxi_pmx_get_func_name,
+	.get_function_groups	= sunxi_pmx_get_func_groups,
+	.enable			= sunxi_pmx_enable,
+};
+
+static struct pinctrl_desc sunxi_pctrl_desc = {
+	.confops	= &sunxi_pconf_ops,
+	.pctlops	= &sunxi_pctrl_ops,
+	.pmxops		= &sunxi_pmx_ops,
+};
+
+static struct of_device_id sunxi_pinctrl_match[] __devinitconst = {
+	{}
+};
+MODULE_DEVICE_TABLE(of, sunxi_pinctrl_match);
+
+static int __devinit sunxi_pinctrl_parse_group(struct platform_device *pdev,
+					       struct device_node *node,
+					       int idx,
+					       const char **out_name)
+{
+	struct sunxi_pinctrl *pctl = platform_get_drvdata(pdev);
+	struct sunxi_pinctrl_group *group = pctl->groups + idx;
+	struct property *prop;
+	char *group_name;
+	int i;
+	u32 val, proplen;
+
+	group_name = devm_kzalloc(&pdev->dev, strlen(node->name) + 4,
+				  GFP_KERNEL);
+	if (!group_name)
+		return -ENOMEM;
+	if (of_property_read_u32(node, "reg", &val))
+		snprintf(group_name, strlen(node->name), "%s", node->name);
+	else
+		snprintf(group_name, strlen(node->name) + 4,
+			 "%s.%d", node->name, val);
+	group->name = group_name;
+
+	prop = of_find_property(node, "allwinner,pin-ids", &proplen);
+	if (!prop)
+		return -EINVAL;
+	group->npins = proplen / sizeof(u32);
+
+	group->pins = devm_kzalloc(&pdev->dev,
+				   group->npins * sizeof(*group->pins),
+				   GFP_KERNEL);
+	if (!group->pins)
+		return -ENOMEM;
+
+	group->muxcfg = devm_kzalloc(&pdev->dev,
+				     group->npins * sizeof(*group->muxcfg),
+				     GFP_KERNEL);
+	if (!group->muxcfg)
+		return -ENOMEM;
+
+	of_property_read_u32_array(node, "allwinner,pin-ids", group->pins,
+				   group->npins);
+	for (i = 0; i < group->npins; i++) {
+		group->muxcfg[i] = MUXID_TO_MUXCFG(group->pins[i]);
+		group->pins[i] = MUXID_TO_PIN(group->pins[i]);
+	}
+
+	if (out_name)
+		*out_name = group->name;
+
+	return 0;
+}
+
+static int __devinit sunxi_pinctrl_probe_dt(struct platform_device *pdev, struct sunxi_pinctrl *pctl)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *child;
+	struct sunxi_pinctrl_function *func;
+	const char *func_name;
+	int i = 0, idxf = 0, idxg = 0;
+	int ret;
+
+	pctl->membase = of_iomap(node, 0);
+	if (!pctl->membase)
+		return -ENOMEM;
+
+	child = of_get_next_child(node, NULL);
+	if (!child) {
+		dev_err(&pdev->dev, "no group is defined\n");
+		return -ENOENT;
+	}
+
+	/* Count total functions and groups */
+	func_name = "";
+	for_each_child_of_node(node, child) {
+		pctl->ngroups++;
+		if (strcmp(func_name, child->name)) {
+			func_name = child->name;
+			pctl->nfunctions++;
+		}
+	}
+
+	pctl->functions = devm_kzalloc(&pdev->dev,
+				       pctl->nfunctions * sizeof(*pctl->functions),
+				       GFP_KERNEL);
+	if (!pctl->functions)
+		return -ENOMEM;
+
+	pctl->groups = devm_kzalloc(&pdev->dev,
+				    pctl->ngroups * sizeof(*pctl->groups),
+				    GFP_KERNEL);
+	if (!pctl->groups)
+		return -ENOMEM;
+
+	/* Count groups for each function */
+	func_name = "";
+	func = &pctl->functions[idxf];
+	for_each_child_of_node(node, child) {
+		if (strcmp(func_name, child->name)) {
+			func = &pctl->functions[idxf++];
+			func->name = func_name = child->name;
+		}
+		func->ngroups++;
+	};
+
+	/* Get groups for each function */
+	idxf = 0;
+	func_name = "";
+	func = &pctl->functions[idxf];
+	for_each_child_of_node(node, child) {
+		if (strcmp(func_name, child->name)) {
+			func = &pctl->functions[idxf++];
+			func->groups = devm_kzalloc(&pdev->dev,
+						    func->ngroups * sizeof(*func->groups),
+						    GFP_KERNEL);
+			if (!func->groups)
+				return -ENOMEM;
+			func_name = child->name;
+			i = 0;
+		}
+
+		ret = sunxi_pinctrl_parse_group(pdev, child, idxg++,
+						&func->groups[i++]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int __devinit sunxi_pinctrl_probe(struct platform_device *pdev)
+{
+	struct sunxi_pinctrl *pctl;
+	int i, ret;
+
+	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
+	if (!pctl)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, pctl);
+
+	ret = sunxi_pinctrl_probe_dt(pdev, pctl);
+	if (ret) {
+		dev_err(&pdev->dev, "dt probe failed: %d\n", ret);
+		return ret;
+	}
+
+	pctl->data = (struct sunxi_pinctrl_data *)of_match_device(sunxi_pinctrl_match, &pdev->dev)->data;
+
+	sunxi_pctrl_desc.name = dev_name(&pdev->dev);
+	sunxi_pctrl_desc.owner = THIS_MODULE;
+	sunxi_pctrl_desc.pins = pctl->data->pins;
+	sunxi_pctrl_desc.npins = pctl->data->npins;
+	pctl->dev = &pdev->dev;
+	pctl->pctl_dev = pinctrl_register(&sunxi_pctrl_desc,
+					  &pdev->dev, pctl);
+	if (!pctl->pctl_dev) {
+		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
+		return -EINVAL;
+	}
+
+	dev_info(&pdev->dev, "initialized sunXi pin control driver\n");
+
+	return 0;
+}
+
+static struct platform_driver sunxi_pinctrl_driver = {
+	.probe = sunxi_pinctrl_probe,
+	.driver = {
+		.name = "sunxi-pinctrl",
+		.owner = THIS_MODULE,
+		.of_match_table = sunxi_pinctrl_match,
+	},
+};
+module_platform_driver(sunxi_pinctrl_driver);
+
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard at free-electrons.com");
+MODULE_DESCRIPTION("Allwinner A1X pinctrl driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pinctrl/pinctrl-sunxi.h b/drivers/pinctrl/pinctrl-sunxi.h
new file mode 100644
index 0000000..9b540bd
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-sunxi.h
@@ -0,0 +1,315 @@
+/*
+ * Allwinner A1X SoCs pinctrl driver.
+ *
+ * Copyright (C) 2012 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PINCTRL_SUNXI_H
+#define __PINCTRL_SUNXI_H
+
+#include <linux/kernel.h>
+
+#define PINS_PER_BANK	32
+
+#define CFG_REG(pin)	(round_down(					\
+				(pin / PINS_PER_BANK) * 0x24 +		\
+				((pin % PINS_PER_BANK) / 8) * 0x04, 4))
+#define CFG_OFFSET(pin)	((pin % 8) * 4)
+
+#define DLEVEL_REG(pin)	(round_down(					\
+				(pin / PINS_PER_BANK) * 0x24 +		\
+				((pin % PINS_PER_BANK) / 16) * 0x04 +	\
+				0x14, 4))
+#define DLEVEL_OFFSET(pin)	((pin % 16) * 2)
+
+#define PULL_REG(pin)	(round_down(					\
+				(pin / PINS_PER_BANK) * 0x24 +		\
+				((pin % PINS_PER_BANK) / 16) * 0x04 +	\
+				0x1c, 4))
+#define PULL_OFFSET(pin)	((pin % 16) * 2)
+
+#define CFG_PINS_PER_REG	8
+#define CFG_PINS_BITS		4
+#define DLEVEL_PINS_PER_REG	16
+#define DLEVEL_PINS_BITS	2
+#define PULL_PINS_PER_REG	16
+#define PULL_PINS_BITS		2
+
+#define MUXID_TO_PIN(id)	((((id) >> 12 & 0xf) * 32) + ((id) >> 4 & 0xff))
+#define MUXID_TO_MUXCFG(id)	((id) & 0xf)
+
+#define PULL_PRESENT		(1 << 5)
+#define PULL_SHIFT		3
+#define DLEVEL_PRESENT		(1 << 2)
+#define DLEVEL_SHIFT		0
+#define CONFIG_TO_PULL(c)	((c) >> PULL_SHIFT & 0x3)
+#define CONFIG_TO_DLEVEL(c)	((c) >> DLEVEL_SHIFT & 0x3)
+
+#define SUNXI_PINCTRL_PIN_PA0	PINCTRL_PIN(0 + 0, "PA0")
+#define SUNXI_PINCTRL_PIN_PA1	PINCTRL_PIN(0 + 1, "PA1")
+#define SUNXI_PINCTRL_PIN_PA2	PINCTRL_PIN(0 + 2, "PA2")
+#define SUNXI_PINCTRL_PIN_PA3	PINCTRL_PIN(0 + 3, "PA3")
+#define SUNXI_PINCTRL_PIN_PA4	PINCTRL_PIN(0 + 4, "PA4")
+#define SUNXI_PINCTRL_PIN_PA5	PINCTRL_PIN(0 + 5, "PA5")
+#define SUNXI_PINCTRL_PIN_PA6	PINCTRL_PIN(0 + 6, "PA6")
+#define SUNXI_PINCTRL_PIN_PA7	PINCTRL_PIN(0 + 7, "PA7")
+#define SUNXI_PINCTRL_PIN_PA8	PINCTRL_PIN(0 + 8, "PA8")
+#define SUNXI_PINCTRL_PIN_PA9	PINCTRL_PIN(0 + 9, "PA9")
+#define SUNXI_PINCTRL_PIN_PA10	PINCTRL_PIN(0 + 10, "PA10")
+#define SUNXI_PINCTRL_PIN_PA11	PINCTRL_PIN(0 + 11, "PA11")
+#define SUNXI_PINCTRL_PIN_PA12	PINCTRL_PIN(0 + 12, "PA12")
+#define SUNXI_PINCTRL_PIN_PA13	PINCTRL_PIN(0 + 13, "PA13")
+#define SUNXI_PINCTRL_PIN_PA14	PINCTRL_PIN(0 + 14, "PA14")
+#define SUNXI_PINCTRL_PIN_PA15	PINCTRL_PIN(0 + 15, "PA15")
+#define SUNXI_PINCTRL_PIN_PA16	PINCTRL_PIN(0 + 16, "PA16")
+#define SUNXI_PINCTRL_PIN_PA17	PINCTRL_PIN(0 + 17, "PA17")
+#define SUNXI_PINCTRL_PIN_PA18	PINCTRL_PIN(0 + 18, "PA18")
+#define SUNXI_PINCTRL_PIN_PA19	PINCTRL_PIN(0 + 19, "PA19")
+#define SUNXI_PINCTRL_PIN_PA20	PINCTRL_PIN(0 + 20, "PA20")
+#define SUNXI_PINCTRL_PIN_PA21	PINCTRL_PIN(0 + 21, "PA21")
+#define SUNXI_PINCTRL_PIN_PA22	PINCTRL_PIN(0 + 22, "PA22")
+#define SUNXI_PINCTRL_PIN_PA23	PINCTRL_PIN(0 + 23, "PA23")
+#define SUNXI_PINCTRL_PIN_PA24	PINCTRL_PIN(0 + 24, "PA24")
+#define SUNXI_PINCTRL_PIN_PA25	PINCTRL_PIN(0 + 25, "PA25")
+#define SUNXI_PINCTRL_PIN_PA26	PINCTRL_PIN(0 + 26, "PA26")
+#define SUNXI_PINCTRL_PIN_PA27	PINCTRL_PIN(0 + 27, "PA27")
+#define SUNXI_PINCTRL_PIN_PA28	PINCTRL_PIN(0 + 28, "PA28")
+#define SUNXI_PINCTRL_PIN_PA29	PINCTRL_PIN(0 + 29, "PA29")
+#define SUNXI_PINCTRL_PIN_PA30	PINCTRL_PIN(0 + 30, "PA30")
+#define SUNXI_PINCTRL_PIN_PA31	PINCTRL_PIN(0 + 31, "PA31")
+
+#define SUNXI_PINCTRL_PIN_PB0	PINCTRL_PIN(32 + 0, "PB0")
+#define SUNXI_PINCTRL_PIN_PB1	PINCTRL_PIN(32 + 1, "PB1")
+#define SUNXI_PINCTRL_PIN_PB2	PINCTRL_PIN(32 + 2, "PB2")
+#define SUNXI_PINCTRL_PIN_PB3	PINCTRL_PIN(32 + 3, "PB3")
+#define SUNXI_PINCTRL_PIN_PB4	PINCTRL_PIN(32 + 4, "PB4")
+#define SUNXI_PINCTRL_PIN_PB5	PINCTRL_PIN(32 + 5, "PB5")
+#define SUNXI_PINCTRL_PIN_PB6	PINCTRL_PIN(32 + 6, "PB6")
+#define SUNXI_PINCTRL_PIN_PB7	PINCTRL_PIN(32 + 7, "PB7")
+#define SUNXI_PINCTRL_PIN_PB8	PINCTRL_PIN(32 + 8, "PB8")
+#define SUNXI_PINCTRL_PIN_PB9	PINCTRL_PIN(32 + 9, "PB9")
+#define SUNXI_PINCTRL_PIN_PB10	PINCTRL_PIN(32 + 10, "PB10")
+#define SUNXI_PINCTRL_PIN_PB11	PINCTRL_PIN(32 + 11, "PB11")
+#define SUNXI_PINCTRL_PIN_PB12	PINCTRL_PIN(32 + 12, "PB12")
+#define SUNXI_PINCTRL_PIN_PB13	PINCTRL_PIN(32 + 13, "PB13")
+#define SUNXI_PINCTRL_PIN_PB14	PINCTRL_PIN(32 + 14, "PB14")
+#define SUNXI_PINCTRL_PIN_PB15	PINCTRL_PIN(32 + 15, "PB15")
+#define SUNXI_PINCTRL_PIN_PB16	PINCTRL_PIN(32 + 16, "PB16")
+#define SUNXI_PINCTRL_PIN_PB17	PINCTRL_PIN(32 + 17, "PB17")
+#define SUNXI_PINCTRL_PIN_PB18	PINCTRL_PIN(32 + 18, "PB18")
+#define SUNXI_PINCTRL_PIN_PB19	PINCTRL_PIN(32 + 19, "PB19")
+#define SUNXI_PINCTRL_PIN_PB20	PINCTRL_PIN(32 + 20, "PB20")
+#define SUNXI_PINCTRL_PIN_PB21	PINCTRL_PIN(32 + 21, "PB21")
+#define SUNXI_PINCTRL_PIN_PB22	PINCTRL_PIN(32 + 22, "PB22")
+#define SUNXI_PINCTRL_PIN_PB23	PINCTRL_PIN(32 + 23, "PB23")
+#define SUNXI_PINCTRL_PIN_PB24	PINCTRL_PIN(32 + 24, "PB24")
+#define SUNXI_PINCTRL_PIN_PB25	PINCTRL_PIN(32 + 25, "PB25")
+#define SUNXI_PINCTRL_PIN_PB26	PINCTRL_PIN(32 + 26, "PB26")
+#define SUNXI_PINCTRL_PIN_PB27	PINCTRL_PIN(32 + 27, "PB27")
+#define SUNXI_PINCTRL_PIN_PB28	PINCTRL_PIN(32 + 28, "PB28")
+#define SUNXI_PINCTRL_PIN_PB29	PINCTRL_PIN(32 + 29, "PB29")
+#define SUNXI_PINCTRL_PIN_PB30	PINCTRL_PIN(32 + 30, "PB30")
+#define SUNXI_PINCTRL_PIN_PB31	PINCTRL_PIN(32 + 31, "PB31")
+
+#define SUNXI_PINCTRL_PIN_PC0	PINCTRL_PIN(64 + 0, "PC0")
+#define SUNXI_PINCTRL_PIN_PC1	PINCTRL_PIN(64 + 1, "PC1")
+#define SUNXI_PINCTRL_PIN_PC2	PINCTRL_PIN(64 + 2, "PC2")
+#define SUNXI_PINCTRL_PIN_PC3	PINCTRL_PIN(64 + 3, "PC3")
+#define SUNXI_PINCTRL_PIN_PC4	PINCTRL_PIN(64 + 4, "PC4")
+#define SUNXI_PINCTRL_PIN_PC5	PINCTRL_PIN(64 + 5, "PC5")
+#define SUNXI_PINCTRL_PIN_PC6	PINCTRL_PIN(64 + 6, "PC6")
+#define SUNXI_PINCTRL_PIN_PC7	PINCTRL_PIN(64 + 7, "PC7")
+#define SUNXI_PINCTRL_PIN_PC8	PINCTRL_PIN(64 + 8, "PC8")
+#define SUNXI_PINCTRL_PIN_PC9	PINCTRL_PIN(64 + 9, "PC9")
+#define SUNXI_PINCTRL_PIN_PC10	PINCTRL_PIN(64 + 10, "PC10")
+#define SUNXI_PINCTRL_PIN_PC11	PINCTRL_PIN(64 + 11, "PC11")
+#define SUNXI_PINCTRL_PIN_PC12	PINCTRL_PIN(64 + 12, "PC12")
+#define SUNXI_PINCTRL_PIN_PC13	PINCTRL_PIN(64 + 13, "PC13")
+#define SUNXI_PINCTRL_PIN_PC14	PINCTRL_PIN(64 + 14, "PC14")
+#define SUNXI_PINCTRL_PIN_PC15	PINCTRL_PIN(64 + 15, "PC15")
+#define SUNXI_PINCTRL_PIN_PC16	PINCTRL_PIN(64 + 16, "PC16")
+#define SUNXI_PINCTRL_PIN_PC17	PINCTRL_PIN(64 + 17, "PC17")
+#define SUNXI_PINCTRL_PIN_PC18	PINCTRL_PIN(64 + 18, "PC18")
+#define SUNXI_PINCTRL_PIN_PC19	PINCTRL_PIN(64 + 19, "PC19")
+#define SUNXI_PINCTRL_PIN_PC20	PINCTRL_PIN(64 + 20, "PC20")
+#define SUNXI_PINCTRL_PIN_PC21	PINCTRL_PIN(64 + 21, "PC21")
+#define SUNXI_PINCTRL_PIN_PC22	PINCTRL_PIN(64 + 22, "PC22")
+#define SUNXI_PINCTRL_PIN_PC23	PINCTRL_PIN(64 + 23, "PC23")
+#define SUNXI_PINCTRL_PIN_PC24	PINCTRL_PIN(64 + 24, "PC24")
+#define SUNXI_PINCTRL_PIN_PC25	PINCTRL_PIN(64 + 25, "PC25")
+#define SUNXI_PINCTRL_PIN_PC26	PINCTRL_PIN(64 + 26, "PC26")
+#define SUNXI_PINCTRL_PIN_PC27	PINCTRL_PIN(64 + 27, "PC27")
+#define SUNXI_PINCTRL_PIN_PC28	PINCTRL_PIN(64 + 28, "PC28")
+#define SUNXI_PINCTRL_PIN_PC29	PINCTRL_PIN(64 + 29, "PC29")
+#define SUNXI_PINCTRL_PIN_PC30	PINCTRL_PIN(64 + 30, "PC30")
+#define SUNXI_PINCTRL_PIN_PC31	PINCTRL_PIN(64 + 31, "PC31")
+
+#define SUNXI_PINCTRL_PIN_PD0	PINCTRL_PIN(96 + 0, "PD0")
+#define SUNXI_PINCTRL_PIN_PD1	PINCTRL_PIN(96 + 1, "PD1")
+#define SUNXI_PINCTRL_PIN_PD2	PINCTRL_PIN(96 + 2, "PD2")
+#define SUNXI_PINCTRL_PIN_PD3	PINCTRL_PIN(96 + 3, "PD3")
+#define SUNXI_PINCTRL_PIN_PD4	PINCTRL_PIN(96 + 4, "PD4")
+#define SUNXI_PINCTRL_PIN_PD5	PINCTRL_PIN(96 + 5, "PD5")
+#define SUNXI_PINCTRL_PIN_PD6	PINCTRL_PIN(96 + 6, "PD6")
+#define SUNXI_PINCTRL_PIN_PD7	PINCTRL_PIN(96 + 7, "PD7")
+#define SUNXI_PINCTRL_PIN_PD8	PINCTRL_PIN(96 + 8, "PD8")
+#define SUNXI_PINCTRL_PIN_PD9	PINCTRL_PIN(96 + 9, "PD9")
+#define SUNXI_PINCTRL_PIN_PD10	PINCTRL_PIN(96 + 10, "PD10")
+#define SUNXI_PINCTRL_PIN_PD11	PINCTRL_PIN(96 + 11, "PD11")
+#define SUNXI_PINCTRL_PIN_PD12	PINCTRL_PIN(96 + 12, "PD12")
+#define SUNXI_PINCTRL_PIN_PD13	PINCTRL_PIN(96 + 13, "PD13")
+#define SUNXI_PINCTRL_PIN_PD14	PINCTRL_PIN(96 + 14, "PD14")
+#define SUNXI_PINCTRL_PIN_PD15	PINCTRL_PIN(96 + 15, "PD15")
+#define SUNXI_PINCTRL_PIN_PD16	PINCTRL_PIN(96 + 16, "PD16")
+#define SUNXI_PINCTRL_PIN_PD17	PINCTRL_PIN(96 + 17, "PD17")
+#define SUNXI_PINCTRL_PIN_PD18	PINCTRL_PIN(96 + 18, "PD18")
+#define SUNXI_PINCTRL_PIN_PD19	PINCTRL_PIN(96 + 19, "PD19")
+#define SUNXI_PINCTRL_PIN_PD20	PINCTRL_PIN(96 + 20, "PD20")
+#define SUNXI_PINCTRL_PIN_PD21	PINCTRL_PIN(96 + 21, "PD21")
+#define SUNXI_PINCTRL_PIN_PD22	PINCTRL_PIN(96 + 22, "PD22")
+#define SUNXI_PINCTRL_PIN_PD23	PINCTRL_PIN(96 + 23, "PD23")
+#define SUNXI_PINCTRL_PIN_PD24	PINCTRL_PIN(96 + 24, "PD24")
+#define SUNXI_PINCTRL_PIN_PD25	PINCTRL_PIN(96 + 25, "PD25")
+#define SUNXI_PINCTRL_PIN_PD26	PINCTRL_PIN(96 + 26, "PD26")
+#define SUNXI_PINCTRL_PIN_PD27	PINCTRL_PIN(96 + 27, "PD27")
+#define SUNXI_PINCTRL_PIN_PD28	PINCTRL_PIN(96 + 28, "PD28")
+#define SUNXI_PINCTRL_PIN_PD29	PINCTRL_PIN(96 + 29, "PD29")
+#define SUNXI_PINCTRL_PIN_PD30	PINCTRL_PIN(96 + 30, "PD30")
+#define SUNXI_PINCTRL_PIN_PD31	PINCTRL_PIN(96 + 31, "PD31")
+
+#define SUNXI_PINCTRL_PIN_PE0	PINCTRL_PIN(128 + 0, "PE0")
+#define SUNXI_PINCTRL_PIN_PE1	PINCTRL_PIN(128 + 1, "PE1")
+#define SUNXI_PINCTRL_PIN_PE2	PINCTRL_PIN(128 + 2, "PE2")
+#define SUNXI_PINCTRL_PIN_PE3	PINCTRL_PIN(128 + 3, "PE3")
+#define SUNXI_PINCTRL_PIN_PE4	PINCTRL_PIN(128 + 4, "PE4")
+#define SUNXI_PINCTRL_PIN_PE5	PINCTRL_PIN(128 + 5, "PE5")
+#define SUNXI_PINCTRL_PIN_PE6	PINCTRL_PIN(128 + 6, "PE6")
+#define SUNXI_PINCTRL_PIN_PE7	PINCTRL_PIN(128 + 7, "PE7")
+#define SUNXI_PINCTRL_PIN_PE8	PINCTRL_PIN(128 + 8, "PE8")
+#define SUNXI_PINCTRL_PIN_PE9	PINCTRL_PIN(128 + 9, "PE9")
+#define SUNXI_PINCTRL_PIN_PE10	PINCTRL_PIN(128 + 10, "PE10")
+#define SUNXI_PINCTRL_PIN_PE11	PINCTRL_PIN(128 + 11, "PE11")
+#define SUNXI_PINCTRL_PIN_PE12	PINCTRL_PIN(128 + 12, "PE12")
+#define SUNXI_PINCTRL_PIN_PE13	PINCTRL_PIN(128 + 13, "PE13")
+#define SUNXI_PINCTRL_PIN_PE14	PINCTRL_PIN(128 + 14, "PE14")
+#define SUNXI_PINCTRL_PIN_PE15	PINCTRL_PIN(128 + 15, "PE15")
+#define SUNXI_PINCTRL_PIN_PE16	PINCTRL_PIN(128 + 16, "PE16")
+#define SUNXI_PINCTRL_PIN_PE17	PINCTRL_PIN(128 + 17, "PE17")
+#define SUNXI_PINCTRL_PIN_PE18	PINCTRL_PIN(128 + 18, "PE18")
+#define SUNXI_PINCTRL_PIN_PE19	PINCTRL_PIN(128 + 19, "PE19")
+#define SUNXI_PINCTRL_PIN_PE20	PINCTRL_PIN(128 + 20, "PE20")
+#define SUNXI_PINCTRL_PIN_PE21	PINCTRL_PIN(128 + 21, "PE21")
+#define SUNXI_PINCTRL_PIN_PE22	PINCTRL_PIN(128 + 22, "PE22")
+#define SUNXI_PINCTRL_PIN_PE23	PINCTRL_PIN(128 + 23, "PE23")
+#define SUNXI_PINCTRL_PIN_PE24	PINCTRL_PIN(128 + 24, "PE24")
+#define SUNXI_PINCTRL_PIN_PE25	PINCTRL_PIN(128 + 25, "PE25")
+#define SUNXI_PINCTRL_PIN_PE26	PINCTRL_PIN(128 + 26, "PE26")
+#define SUNXI_PINCTRL_PIN_PE27	PINCTRL_PIN(128 + 27, "PE27")
+#define SUNXI_PINCTRL_PIN_PE28	PINCTRL_PIN(128 + 28, "PE28")
+#define SUNXI_PINCTRL_PIN_PE29	PINCTRL_PIN(128 + 29, "PE29")
+#define SUNXI_PINCTRL_PIN_PE30	PINCTRL_PIN(128 + 30, "PE30")
+#define SUNXI_PINCTRL_PIN_PE31	PINCTRL_PIN(128 + 31, "PE31")
+
+#define SUNXI_PINCTRL_PIN_PF0	PINCTRL_PIN(160 + 0, "PF0")
+#define SUNXI_PINCTRL_PIN_PF1	PINCTRL_PIN(160 + 1, "PF1")
+#define SUNXI_PINCTRL_PIN_PF2	PINCTRL_PIN(160 + 2, "PF2")
+#define SUNXI_PINCTRL_PIN_PF3	PINCTRL_PIN(160 + 3, "PF3")
+#define SUNXI_PINCTRL_PIN_PF4	PINCTRL_PIN(160 + 4, "PF4")
+#define SUNXI_PINCTRL_PIN_PF5	PINCTRL_PIN(160 + 5, "PF5")
+#define SUNXI_PINCTRL_PIN_PF6	PINCTRL_PIN(160 + 6, "PF6")
+#define SUNXI_PINCTRL_PIN_PF7	PINCTRL_PIN(160 + 7, "PF7")
+#define SUNXI_PINCTRL_PIN_PF8	PINCTRL_PIN(160 + 8, "PF8")
+#define SUNXI_PINCTRL_PIN_PF9	PINCTRL_PIN(160 + 9, "PF9")
+#define SUNXI_PINCTRL_PIN_PF10	PINCTRL_PIN(160 + 10, "PF10")
+#define SUNXI_PINCTRL_PIN_PF11	PINCTRL_PIN(160 + 11, "PF11")
+#define SUNXI_PINCTRL_PIN_PF12	PINCTRL_PIN(160 + 12, "PF12")
+#define SUNXI_PINCTRL_PIN_PF13	PINCTRL_PIN(160 + 13, "PF13")
+#define SUNXI_PINCTRL_PIN_PF14	PINCTRL_PIN(160 + 14, "PF14")
+#define SUNXI_PINCTRL_PIN_PF15	PINCTRL_PIN(160 + 15, "PF15")
+#define SUNXI_PINCTRL_PIN_PF16	PINCTRL_PIN(160 + 16, "PF16")
+#define SUNXI_PINCTRL_PIN_PF17	PINCTRL_PIN(160 + 17, "PF17")
+#define SUNXI_PINCTRL_PIN_PF18	PINCTRL_PIN(160 + 18, "PF18")
+#define SUNXI_PINCTRL_PIN_PF19	PINCTRL_PIN(160 + 19, "PF19")
+#define SUNXI_PINCTRL_PIN_PF20	PINCTRL_PIN(160 + 20, "PF20")
+#define SUNXI_PINCTRL_PIN_PF21	PINCTRL_PIN(160 + 21, "PF21")
+#define SUNXI_PINCTRL_PIN_PF22	PINCTRL_PIN(160 + 22, "PF22")
+#define SUNXI_PINCTRL_PIN_PF23	PINCTRL_PIN(160 + 23, "PF23")
+#define SUNXI_PINCTRL_PIN_PF24	PINCTRL_PIN(160 + 24, "PF24")
+#define SUNXI_PINCTRL_PIN_PF25	PINCTRL_PIN(160 + 25, "PF25")
+#define SUNXI_PINCTRL_PIN_PF26	PINCTRL_PIN(160 + 26, "PF26")
+#define SUNXI_PINCTRL_PIN_PF27	PINCTRL_PIN(160 + 27, "PF27")
+#define SUNXI_PINCTRL_PIN_PF28	PINCTRL_PIN(160 + 28, "PF28")
+#define SUNXI_PINCTRL_PIN_PF29	PINCTRL_PIN(160 + 29, "PF29")
+#define SUNXI_PINCTRL_PIN_PF30	PINCTRL_PIN(160 + 30, "PF30")
+#define SUNXI_PINCTRL_PIN_PF31	PINCTRL_PIN(160 + 31, "PF31")
+
+#define SUNXI_PINCTRL_PIN_PG0	PINCTRL_PIN(192 + 0, "PG0")
+#define SUNXI_PINCTRL_PIN_PG1	PINCTRL_PIN(192 + 1, "PG1")
+#define SUNXI_PINCTRL_PIN_PG2	PINCTRL_PIN(192 + 2, "PG2")
+#define SUNXI_PINCTRL_PIN_PG3	PINCTRL_PIN(192 + 3, "PG3")
+#define SUNXI_PINCTRL_PIN_PG4	PINCTRL_PIN(192 + 4, "PG4")
+#define SUNXI_PINCTRL_PIN_PG5	PINCTRL_PIN(192 + 5, "PG5")
+#define SUNXI_PINCTRL_PIN_PG6	PINCTRL_PIN(192 + 6, "PG6")
+#define SUNXI_PINCTRL_PIN_PG7	PINCTRL_PIN(192 + 7, "PG7")
+#define SUNXI_PINCTRL_PIN_PG8	PINCTRL_PIN(192 + 8, "PG8")
+#define SUNXI_PINCTRL_PIN_PG9	PINCTRL_PIN(192 + 9, "PG9")
+#define SUNXI_PINCTRL_PIN_PG10	PINCTRL_PIN(192 + 10, "PG10")
+#define SUNXI_PINCTRL_PIN_PG11	PINCTRL_PIN(192 + 11, "PG11")
+#define SUNXI_PINCTRL_PIN_PG12	PINCTRL_PIN(192 + 12, "PG12")
+#define SUNXI_PINCTRL_PIN_PG13	PINCTRL_PIN(192 + 13, "PG13")
+#define SUNXI_PINCTRL_PIN_PG14	PINCTRL_PIN(192 + 14, "PG14")
+#define SUNXI_PINCTRL_PIN_PG15	PINCTRL_PIN(192 + 15, "PG15")
+#define SUNXI_PINCTRL_PIN_PG16	PINCTRL_PIN(192 + 16, "PG16")
+#define SUNXI_PINCTRL_PIN_PG17	PINCTRL_PIN(192 + 17, "PG17")
+#define SUNXI_PINCTRL_PIN_PG18	PINCTRL_PIN(192 + 18, "PG18")
+#define SUNXI_PINCTRL_PIN_PG19	PINCTRL_PIN(192 + 19, "PG19")
+#define SUNXI_PINCTRL_PIN_PG20	PINCTRL_PIN(192 + 20, "PG20")
+#define SUNXI_PINCTRL_PIN_PG21	PINCTRL_PIN(192 + 21, "PG21")
+#define SUNXI_PINCTRL_PIN_PG22	PINCTRL_PIN(192 + 22, "PG22")
+#define SUNXI_PINCTRL_PIN_PG23	PINCTRL_PIN(192 + 23, "PG23")
+#define SUNXI_PINCTRL_PIN_PG24	PINCTRL_PIN(192 + 24, "PG24")
+#define SUNXI_PINCTRL_PIN_PG25	PINCTRL_PIN(192 + 25, "PG25")
+#define SUNXI_PINCTRL_PIN_PG26	PINCTRL_PIN(192 + 26, "PG26")
+#define SUNXI_PINCTRL_PIN_PG27	PINCTRL_PIN(192 + 27, "PG27")
+#define SUNXI_PINCTRL_PIN_PG28	PINCTRL_PIN(192 + 28, "PG28")
+#define SUNXI_PINCTRL_PIN_PG29	PINCTRL_PIN(192 + 29, "PG29")
+#define SUNXI_PINCTRL_PIN_PG30	PINCTRL_PIN(192 + 30, "PG30")
+#define SUNXI_PINCTRL_PIN_PG31	PINCTRL_PIN(192 + 31, "PG31")
+
+struct sunxi_pinctrl_data {
+	const struct pinctrl_pin_desc	*pins;
+	int				npins;
+};
+
+struct sunxi_pinctrl_function {
+	const char	*name;
+	const char	**groups;
+	unsigned	ngroups;
+};
+
+struct sunxi_pinctrl_group {
+	const char	*name;
+	unsigned long	pctlcfg;
+	unsigned	*muxcfg;
+	unsigned	*pins;
+	unsigned	npins;
+};
+
+struct sunxi_pinctrl {
+	void __iomem			*membase;
+	struct sunxi_pinctrl_data	*data;
+	struct device			*dev;
+	struct sunxi_pinctrl_function	*functions;
+	unsigned			nfunctions;
+	struct sunxi_pinctrl_group	*groups;
+	unsigned			ngroups;
+	struct pinctrl_dev		*pctl_dev;
+};
+
+#endif /* __PINCTRL_SUNXI_H */
-- 
1.7.9.5
