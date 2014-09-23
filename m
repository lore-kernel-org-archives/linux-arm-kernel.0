From: srv_hongzhou.yang@mediatek.com (Hongzhou.Yang)
Date: Tue, 23 Sep 2014 11:39:03 +0800
Subject: [PATCH v2 2/4] ARM: mediatek: Add Pinctrl/GPIO driver for mt8135.
In-Reply-To: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
References: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
Message-ID: <1411443545-24951-3-git-send-email-srv_hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hongzhou Yang <hongzhou.yang@mediatek.com>

The mediatek SoCs have GPIO controller that handle both the muxing
and GPIOs.

The GPIO controller have pinmux, pull enable, pull select, direction
and output high/low control.

This driver include common and mt8135 part. It implements the pinctrl
part and gpio part.

Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
---
 arch/arm/mach-mediatek/Kconfig                |    1 +
 drivers/pinctrl/Kconfig                       |    1 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/mediatek/Kconfig              |   12 +
 drivers/pinctrl/mediatek/Makefile             |    5 +
 drivers/pinctrl/mediatek/pinctrl-mt8135.c     |   82 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |  792 ++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |   95 +
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h | 2460 +++++++++++++++++++++++++
 include/dt-bindings/pinctrl/mt65xx.h          |   23 +
 10 files changed, 3472 insertions(+)
 create mode 100644 drivers/pinctrl/mediatek/Kconfig
 create mode 100644 drivers/pinctrl/mediatek/Makefile
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8135.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h
 create mode 100644 include/dt-bindings/pinctrl/mt65xx.h

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 25fe6cf..cd57639 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -1,6 +1,7 @@
 menuconfig ARCH_MEDIATEK
 	bool "Mediatek MT65xx & MT81xx SoC" if ARCH_MULTI_V7
 	select ARM_GIC
+	select PINCTRL
 	select MTK_TIMER
 	help
 	  Support for Mediatek MT65xx & MT81xx SoCs
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index bfd2c2e..0be9314 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -314,6 +314,7 @@ source "drivers/pinctrl/sh-pfc/Kconfig"
 source "drivers/pinctrl/spear/Kconfig"
 source "drivers/pinctrl/sunxi/Kconfig"
 source "drivers/pinctrl/vt8500/Kconfig"
+source "drivers/pinctrl/mediatek/Kconfig"
 
 config PINCTRL_XWAY
 	bool
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 05d2275..f9b69a0 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -64,3 +64,4 @@ obj-$(CONFIG_SUPERH)		+= sh-pfc/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
+obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
new file mode 100644
index 0000000..bae4be6
--- /dev/null
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -0,0 +1,12 @@
+if ARCH_MEDIATEK
+
+config PINCTRL_MTK_COMMON
+	bool
+	select PINMUX
+	select GENERIC_PINCONF
+
+config PINCTRL_MT8135
+	def_bool MACH_MT8135
+	select PINCTRL_MTK_COMMON
+
+endif
diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
new file mode 100644
index 0000000..8157dad
--- /dev/null
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -0,0 +1,5 @@
+# Core
+obj-$(CONFIG_PINCTRL_MTK_COMMON)	+= pinctrl-mtk-common.o
+
+# SoC Drivers
+obj-$(CONFIG_PINCTRL_MT8135)		+= pinctrl-mt8135.o
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8135.c b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
new file mode 100644
index 0000000..f6367a2
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
@@ -0,0 +1,82 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Hongzhou.Yang <hongzhou.yang@mediatek.com>
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
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+
+#include "pinctrl-mtk-common.h"
+#include "pinctrl-mtk-mt8135.h"
+
+static const struct mt_gpio_devdata mt8135_pinctrl_data = {
+	.pins = mt_pins_mt8135,
+	.npins = ARRAY_SIZE(mt_pins_mt8135),
+	.dir_offset = 0x0000,
+	.pullen_offset = 0x0200,
+	.pullsel_offset = 0x0400,
+	.invser_offset = 0x0600,
+	.dout_offset = 0x0800,
+	.din_offset = 0x0A00,
+	.pinmux_offset = 0x0C00,
+	.type1_start = 34,
+	.type1_end = 149,
+};
+
+static int mt8135_pinctrl_probe(struct platform_device *pdev)
+{
+	return mt_pctrl_init(pdev, &mt8135_pinctrl_data);
+}
+
+static int mt8135_pinctrl_remove(struct platform_device *pdev)
+{
+	return mt_pctrl_remove(pdev);
+}
+
+
+static struct of_device_id mt8135_pctrl_match[] = {
+	{
+		.compatible = "mediatek,mt8135-pinctrl",
+	}, {
+	}
+};
+MODULE_DEVICE_TABLE(of, mt8135_pctrl_match);
+
+static struct platform_driver mt_pinctrl_driver = {
+	.probe = mt8135_pinctrl_probe,
+	.remove = mt8135_pinctrl_remove,
+	.driver = {
+		.name = "mediatek-pinctrl",
+		.owner = THIS_MODULE,
+		.of_match_table = mt8135_pctrl_match,
+	},
+};
+
+static int __init mtk_pinctrl_init(void)
+{
+	return platform_driver_register(&mt_pinctrl_driver);
+}
+
+static void __exit mtk_pinctrl_exit(void)
+{
+	platform_driver_unregister(&mt_pinctrl_driver);
+}
+
+postcore_initcall(mtk_pinctrl_init);
+module_exit(mtk_pinctrl_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MediaTek Pinctrl Driver");
+MODULE_AUTHOR("Hongzhou Yang <hongzhou.yang@mediatek.com>");
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
new file mode 100644
index 0000000..6f7dc73
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -0,0 +1,792 @@
+/*
+ * mt65xx pinctrl driver based on Allwinner A1X pinctrl driver.
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Hongzhou.Yang <hongzhou.yang@mediatek.com>
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
+#include <linux/gpio.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <dt-bindings/pinctrl/mt65xx.h>
+
+#include "../pinconf.h"
+#include "pinctrl-mtk-common.h"
+
+#define PINMUX_MAX_VAL 8
+#define MAX_GPIO_MODE_PER_REG 5
+#define GPIO_MODE_BITS        3
+
+static const char * const mt_gpio_functions[] = {
+	"func0", "func1", "func2", "func3",
+	"func4", "func5", "func6", "func7",
+};
+
+static void __iomem *mt_get_base_addr(struct mt_pinctrl *pctl,
+		unsigned long pin)
+{
+	if (pin >= pctl->devdata->type1_start && pin < pctl->devdata->type1_end)
+		return pctl->membase2;
+	return pctl->membase1;
+}
+
+static void mt_pctrl_write_reg(struct mt_pinctrl *pctl,
+		unsigned long pin,
+		u32 reg, u32 d)
+{
+	writel(d, mt_get_base_addr(pctl, pin) + reg);
+}
+
+static unsigned int mt_get_port(unsigned long pin)
+{
+	return ((pin >> 4) & 0xf) << 4;
+}
+
+static int mt_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
+			struct pinctrl_gpio_range *range,
+			unsigned offset,
+			bool input)
+{
+	unsigned int reg_addr;
+	unsigned int bit;
+	struct mt_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	reg_addr = mt_get_port(offset) + pctl->devdata->dir_offset;
+	bit = 1 << (offset & 0xf);
+
+	if (input)
+		reg_addr += (4 << 1);
+	else
+		reg_addr += 4;
+
+	writel(bit, pctl->membase1 + reg_addr);
+	return 0;
+}
+
+static void mt_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	unsigned int reg_addr;
+	unsigned int bit;
+	struct mt_pinctrl *pctl = dev_get_drvdata(chip->dev);
+
+	reg_addr = mt_get_port(offset) + pctl->devdata->dout_offset;
+	bit = 1 << (offset & 0xf);
+
+	if (value)
+		writel(bit, pctl->membase1 + reg_addr + 4);
+	else
+		writel(bit, pctl->membase1 + reg_addr + (4 << 1));
+}
+
+static int mt_gpio_set_pull_conf(struct pinctrl_dev *pctldev,
+		unsigned long pin, enum pin_config_param param,
+		enum pin_config_param argument)
+{
+	unsigned int reg_pullen, reg_pullsel;
+	unsigned int bit;
+	struct mt_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	int pullen = 0;
+	int pullsel = 0;
+
+	bit = 1 << (pin & 0xf);
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		pullen = 0;
+		pullsel = 0;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		mt_pmx_gpio_set_direction(pctldev, NULL, pin, 1);
+		pullen = 1;
+		pullsel = 1;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		mt_pmx_gpio_set_direction(pctldev, NULL, pin, 1);
+		pullen = 1;
+		pullsel = 0;
+		break;
+
+	case PIN_CONFIG_INPUT_ENABLE:
+		mt_pmx_gpio_set_direction(pctldev, NULL, pin, 1);
+		break;
+
+	case PIN_CONFIG_OUTPUT:
+		mt_pmx_gpio_set_direction(pctldev, NULL, pin, 0);
+		mt_gpio_set(pctl->chip, pin, argument);
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (pullen)
+		reg_pullen = mt_get_port(pin) +
+			pctl->devdata->pullen_offset + 4;
+	else
+		reg_pullen = mt_get_port(pin) +
+			pctl->devdata->pullen_offset + (4 << 1);
+
+	if (pullsel)
+		reg_pullsel = mt_get_port(pin) +
+			pctl->devdata->pullsel_offset + 4;
+	else
+		reg_pullsel = mt_get_port(pin) +
+			pctl->devdata->pullsel_offset + (4 << 1);
+
+	mt_pctrl_write_reg(pctl, pin, reg_pullen, bit);
+	mt_pctrl_write_reg(pctl, pin, reg_pullsel, bit);
+	return 0;
+}
+
+static int mt_pconf_group_get(struct pinctrl_dev *pctldev,
+				 unsigned group,
+				 unsigned long *config)
+{
+	struct mt_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*config = pctl->groups[group].config;
+
+	return 0;
+}
+
+static int mt_pconf_group_set(struct pinctrl_dev *pctldev, unsigned group,
+				 unsigned long *configs, unsigned num_configs)
+{
+	struct mt_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct mt_pinctrl_group *g = &pctl->groups[group];
+	int i;
+
+	for (i = 0; i < num_configs; i++) {
+		mt_gpio_set_pull_conf(pctldev, g->pin,
+				pinconf_to_config_param(configs[i]),
+				pinconf_to_config_argument(configs[i]));
+
+		g->config = configs[i];
+	}
+
+	return 0;
+}
+
+static const struct pinconf_ops mt_pconf_ops = {
+	.pin_config_group_get	= mt_pconf_group_get,
+	.pin_config_group_set	= mt_pconf_group_set,
+};
+
+static struct mt_pinctrl_group *
+mt_pctrl_find_group_by_pin(struct mt_pinctrl *pctl, u32 pin)
+{
+	int i;
+
+	for (i = 0; i < pctl->ngroups; i++) {
+		struct mt_pinctrl_group *grp = pctl->groups + i;
+
+		if (grp->pin == pin)
+			return grp;
+	}
+
+	return NULL;
+}
+
+static int mt_pctrl_is_function_valid(struct mt_pinctrl *pctl,
+		u32 pin_num, u32 fnum)
+{
+	int i;
+
+	for (i = 0; i < pctl->devdata->npins; i++) {
+		const struct mt_desc_pin *pin = pctl->devdata->pins + i;
+
+		if (pin->pin.number == pin_num) {
+			struct mt_desc_function *func = pin->functions + fnum;
+
+			if (func->name)
+				return 1;
+			else
+				return 0;
+		}
+	}
+
+	return 0;
+}
+
+static int mt_pctrl_dt_node_to_map_func(struct mt_pinctrl *pctl, u32 pin,
+		u32 fnum, struct pinctrl_map **maps)
+{
+	int ret;
+	struct mt_pinctrl_group *grp;
+	struct pinctrl_map *map = *maps;
+
+	grp = mt_pctrl_find_group_by_pin(pctl, pin);
+	if (!grp) {
+		dev_err(pctl->dev, "unable to match pin %d to group\n", pin);
+		return -EINVAL;
+	}
+
+	map->type = PIN_MAP_TYPE_MUX_GROUP;
+	map->data.mux.group = grp->name;
+
+	ret = mt_pctrl_is_function_valid(pctl, pin, fnum);
+	if (!ret) {
+		dev_err(pctl->dev, "invalid mediatek,function %d on pin %d .\n",
+				fnum, pin);
+		return -EINVAL;
+	}
+
+	map->data.mux.function = mt_gpio_functions[fnum];
+	(*maps)++;
+
+	return 0;
+}
+
+static int mt_pctrl_dt_node_to_map_config(struct mt_pinctrl *pctl, u32 pin,
+		unsigned long *configs, unsigned num_configs,
+		struct pinctrl_map **maps)
+{
+	struct mt_pinctrl_group *grp;
+	unsigned long *cfgs;
+	struct pinctrl_map *map = *maps;
+
+	cfgs = kmemdup(configs, num_configs * sizeof(*cfgs),
+		       GFP_KERNEL);
+	if (cfgs == NULL)
+		return -ENOMEM;
+
+	grp = mt_pctrl_find_group_by_pin(pctl, pin);
+	if (!grp) {
+		dev_err(pctl->dev, "unable to match pin %d to group\n", pin);
+		return -EINVAL;
+	}
+
+	map->type = PIN_MAP_TYPE_CONFIGS_GROUP;
+	map->data.configs.group_or_pin = grp->name;
+	map->data.configs.configs = cfgs;
+	map->data.configs.num_configs = num_configs;
+	(*maps)++;
+
+	return 0;
+}
+
+static void mt_pctrl_dt_free_map(struct pinctrl_dev *pctldev,
+				    struct pinctrl_map *map,
+				    unsigned num_maps)
+{
+	int i;
+
+	for (i = 0; i < num_maps; i++) {
+		if (map[i].type == PIN_MAP_TYPE_CONFIGS_GROUP)
+			kfree(map[i].data.configs.configs);
+	}
+
+	kfree(map);
+}
+
+static int mt_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
+				      struct device_node *node,
+				      struct pinctrl_map **map,
+				      unsigned *num_maps)
+{
+	struct pinctrl_map *maps, *cur_map;
+	struct property *pins;
+	u32 pinfunc, pin, func;
+	int num_pins, num_funcs, maps_per_pin;
+	unsigned long *configs;
+	unsigned int num_configs;
+	bool has_config = 0;
+	int i, err;
+	struct mt_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*map = NULL;
+	*num_maps = 0;
+
+	pins = of_find_property(node, "mediatek,pinfunc", NULL);
+	if (!pins) {
+		dev_err(pctl->dev, "missing mediatek,pinfunc property in node %s .\n",
+				node->name);
+		return -EINVAL;
+	}
+
+	err = pinconf_generic_parse_dt_config(node, &configs, &num_configs);
+	if (num_configs)
+		has_config = 1;
+
+	num_pins = pins->length / sizeof(u32);
+	num_funcs = num_pins;
+
+	maps_per_pin = 0;
+	if (num_funcs)
+		maps_per_pin++;
+	if (has_config && num_pins >= 1)
+		maps_per_pin++;
+
+	cur_map = maps = kzalloc(num_pins * maps_per_pin * sizeof(*maps),
+				 GFP_KERNEL);
+	if (!maps)
+		return -ENOMEM;
+
+	for (i = 0; i < num_pins; i++) {
+		err = of_property_read_u32_index(node, "mediatek,pinfunc",
+				i, &pinfunc);
+		if (err)
+			goto fail;
+
+		pin = MT_GET_PIN_NO(pinfunc);
+		func = MT_GET_PIN_FUNC(pinfunc);
+
+		if (pin >= pctl->devdata->npins ||
+				func >= ARRAY_SIZE(mt_gpio_functions)) {
+			dev_err(pctl->dev, "invalid mediatek,pinfunc value.\n");
+			err = -EINVAL;
+			goto fail;
+		}
+
+		err = mt_pctrl_dt_node_to_map_func(pctl, pin, func, &cur_map);
+		if (err)
+			goto fail;
+
+		if (has_config) {
+			err = mt_pctrl_dt_node_to_map_config(pctl, pin,
+					configs, num_configs, &cur_map);
+			if (err)
+				goto fail;
+		}
+	}
+
+	*map = maps;
+	*num_maps = num_pins * maps_per_pin;
+	return 0;
+
+fail:
+	mt_pctrl_dt_free_map(pctldev, maps, num_pins * maps_per_pin);
+	return err;
+}
+
+static int mt_pctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct mt_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->ngroups;
+}
+
+static const char *mt_pctrl_get_group_name(struct pinctrl_dev *pctldev,
+					      unsigned group)
+{
+	struct mt_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->groups[group].name;
+}
+
+static int mt_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
+				      unsigned group,
+				      const unsigned **pins,
+				      unsigned *num_pins)
+{
+	struct mt_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = (unsigned *)&pctl->groups[group].pin;
+	*num_pins = 1;
+
+	return 0;
+}
+
+static const struct pinctrl_ops mt_pctrl_ops = {
+	.dt_node_to_map		= mt_pctrl_dt_node_to_map,
+	.dt_free_map		= mt_pctrl_dt_free_map,
+	.get_groups_count	= mt_pctrl_get_groups_count,
+	.get_group_name		= mt_pctrl_get_group_name,
+	.get_group_pins		= mt_pctrl_get_group_pins,
+};
+
+static int mt_pmx_get_funcs_cnt(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(mt_gpio_functions);
+}
+
+static const char *mt_pmx_get_func_name(struct pinctrl_dev *pctldev,
+					   unsigned selector)
+{
+	return mt_gpio_functions[selector];
+}
+
+static int mt_pmx_get_func_groups(struct pinctrl_dev *pctldev,
+				     unsigned function,
+				     const char * const **groups,
+				     unsigned * const num_groups)
+{
+	struct mt_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = pctl->grp_names;
+	*num_groups = pctl->ngroups;
+
+	return 0;
+}
+
+static int mt_gpio_set_mode(struct pinctrl_dev *pctldev,
+		unsigned long pin, unsigned long mode)
+{
+	unsigned int reg_addr;
+	unsigned char bit;
+	unsigned int val;
+	unsigned long flags;
+	unsigned int mask = (1L << GPIO_MODE_BITS) - 1;
+	struct mt_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	reg_addr = ((pin / 5) << 4) + pctl->devdata->pinmux_offset;
+
+	spin_lock_irqsave(&pctl->lock, flags);
+	val = readl(pctl->membase1 + reg_addr);
+	bit = pin % MAX_GPIO_MODE_PER_REG;
+	val &= ~(mask << (GPIO_MODE_BITS * bit));
+	val |= (mode << (GPIO_MODE_BITS * bit));
+	writel(val, pctl->membase1 + reg_addr);
+	spin_unlock_irqrestore(&pctl->lock, flags);
+	return 0;
+}
+
+static struct mt_desc_function *
+mt_pctrl_desc_find_function_by_number(struct mt_pinctrl *pctl,
+					 const char *pin_name,
+					 unsigned number)
+{
+	int i;
+
+	for (i = 0; i < pctl->devdata->npins; i++) {
+		const struct mt_desc_pin *pin = pctl->devdata->pins + i;
+
+		if (!strcmp(pin->pin.name, pin_name)) {
+			struct mt_desc_function *func = pin->functions;
+
+			return func + number;
+		}
+	}
+
+	return NULL;
+}
+
+static struct mt_desc_function *
+mt_pctrl_desc_find_irq_by_name(struct mt_pinctrl *pctl,
+					 const char *pin_name)
+{
+	int i, j;
+
+	for (i = 0; i < pctl->devdata->npins; i++) {
+		const struct mt_desc_pin *pin = pctl->devdata->pins + i;
+
+		if (!strcmp(pin->pin.name, pin_name)) {
+			struct mt_desc_function *func = pin->functions;
+
+			for (j = 0; j < PINMUX_MAX_VAL; j++) {
+				if (func->irqnum != 255)
+					return func;
+
+				func++;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static int mt_pmx_enable(struct pinctrl_dev *pctldev,
+			    unsigned function,
+			    unsigned group)
+{
+	int ret;
+	struct mt_desc_function *desc;
+	struct mt_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct mt_pinctrl_group *g = pctl->groups + group;
+
+	ret = mt_pctrl_is_function_valid(pctl, g->pin, function);
+	if (!ret) {
+		dev_err(pctl->dev, "invaild function %d on group %d .\n",
+				function, group);
+		return -EINVAL;
+	}
+
+	desc = mt_pctrl_desc_find_function_by_number(pctl, g->name, function);
+	if (!desc)
+		return -EINVAL;
+	mt_gpio_set_mode(pctldev, g->pin, desc->muxval);
+	return 0;
+}
+
+static const struct pinmux_ops mt_pmx_ops = {
+	.get_functions_count	= mt_pmx_get_funcs_cnt,
+	.get_function_name	= mt_pmx_get_func_name,
+	.get_function_groups	= mt_pmx_get_func_groups,
+	.enable			= mt_pmx_enable,
+	.gpio_set_direction	= mt_pmx_gpio_set_direction,
+};
+
+static int mt_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	return pinctrl_request_gpio(chip->base + offset);
+}
+
+static void mt_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	pinctrl_free_gpio(chip->base + offset);
+}
+
+static int mt_gpio_direction_input(struct gpio_chip *chip,
+					unsigned offset)
+{
+	return pinctrl_gpio_direction_input(chip->base + offset);
+}
+
+static int mt_gpio_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	return pinctrl_gpio_direction_output(chip->base + offset);
+}
+
+static int mt_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	unsigned int reg_addr;
+	unsigned int bit;
+	unsigned int read_val = 0;
+
+	struct mt_pinctrl *pctl = dev_get_drvdata(chip->dev);
+
+	reg_addr =  mt_get_port(offset) + pctl->devdata->dir_offset;
+	bit = 1 << (offset & 0xf);
+	read_val = readl(pctl->membase1 + reg_addr);
+	return ((read_val & bit) != 0) ? 1 : 0;
+}
+
+static int mt_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	unsigned int reg_addr;
+	unsigned int bit;
+	unsigned int read_val = 0;
+	struct mt_pinctrl *pctl = dev_get_drvdata(chip->dev);
+
+	if (mt_gpio_get_direction(chip, offset))
+		reg_addr = mt_get_port(offset) + pctl->devdata->dout_offset;
+	else
+		reg_addr = mt_get_port(offset) + pctl->devdata->din_offset;
+
+	bit = 1 << (offset & 0xf);
+	read_val = readl(pctl->membase1 + reg_addr);
+	return ((read_val & bit) != 0) ? 1 : 0;
+}
+
+static int mt_gpio_of_xlate(struct gpio_chip *gc,
+				const struct of_phandle_args *gpiospec,
+				u32 *flags)
+{
+	int pin;
+
+	pin = gpiospec->args[0];
+
+	if (pin > (gc->base + gc->ngpio))
+		return -EINVAL;
+
+	if (flags)
+		*flags = gpiospec->args[1];
+
+	return pin;
+}
+
+static int mt_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct mt_pinctrl *pctl = dev_get_drvdata(chip->dev);
+	struct mt_pinctrl_group *g = pctl->groups + offset;
+	struct mt_desc_function *desc = mt_pctrl_desc_find_irq_by_name(
+			pctl, g->name);
+	if (!desc)
+		return -EINVAL;
+
+	mt_gpio_set_mode(pctl->pctl_dev, g->pin, desc->muxval);
+	return desc->irqnum;
+}
+
+static struct gpio_chip mt_gpio_chip = {
+	.owner			= THIS_MODULE,
+	.request		= mt_gpio_request,
+	.free			= mt_gpio_free,
+	.direction_input	= mt_gpio_direction_input,
+	.direction_output	= mt_gpio_direction_output,
+	.get			= mt_gpio_get,
+	.set			= mt_gpio_set,
+	.of_xlate		= mt_gpio_of_xlate,
+	.to_irq			= mt_gpio_to_irq,
+	.of_gpio_n_cells	= 2,
+};
+
+static int mt_pctrl_build_state(struct platform_device *pdev)
+{
+	struct mt_pinctrl *pctl = platform_get_drvdata(pdev);
+	int i;
+
+	pctl->ngroups = pctl->devdata->npins;
+
+	pctl->groups = devm_kzalloc(&pdev->dev,
+				    pctl->ngroups * sizeof(*pctl->groups),
+				    GFP_KERNEL);
+	if (!pctl->groups)
+		return -ENOMEM;
+
+	pctl->grp_names = devm_kzalloc(&pdev->dev,
+				    pctl->ngroups * sizeof(*pctl->grp_names),
+				    GFP_KERNEL);
+	if (!pctl->grp_names)
+		return -ENOMEM;
+
+	for (i = 0; i < pctl->devdata->npins; i++) {
+		const struct mt_desc_pin *pin = pctl->devdata->pins + i;
+		struct mt_pinctrl_group *group = pctl->groups + i;
+		const char **func_grp;
+
+		group->name = pin->pin.name;
+		group->pin = pin->pin.number;
+
+		func_grp = pctl->grp_names;
+		while (*func_grp)
+			func_grp++;
+
+		*func_grp = pin->pin.name;
+	}
+
+	return 0;
+}
+
+static struct pinctrl_desc mt_pctrl_desc = {
+	.confops	= &mt_pconf_ops,
+	.pctlops	= &mt_pctrl_ops,
+	.pmxops		= &mt_pmx_ops,
+};
+
+int mt_pctrl_init(struct platform_device *pdev,
+		const struct mt_gpio_devdata *data)
+{
+	struct pinctrl_pin_desc *pins;
+	struct mt_pinctrl *pctl;
+	struct resource *res;
+	int i, ret;
+
+	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
+	if (!pctl)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pctl);
+
+	spin_lock_init(&pctl->lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pctl->membase1 = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pctl->membase1))
+		return PTR_ERR(pctl->membase1);
+
+	/* Only 8135 has two base addr, other SoCs have only one. */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	pctl->membase2 = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pctl->membase2))
+		return PTR_ERR(pctl->membase2);
+
+	pctl->devdata = data;
+	ret = mt_pctrl_build_state(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "build state failed: %d\n", ret);
+		return -EINVAL;
+	}
+
+	pins = devm_kzalloc(&pdev->dev,
+			    pctl->devdata->npins * sizeof(*pins),
+			    GFP_KERNEL);
+	if (!pins)
+		return -ENOMEM;
+
+	for (i = 0; i < pctl->devdata->npins; i++)
+		pins[i] = pctl->devdata->pins[i].pin;
+	mt_pctrl_desc.name = dev_name(&pdev->dev);
+	mt_pctrl_desc.owner = THIS_MODULE;
+	mt_pctrl_desc.pins = pins;
+	mt_pctrl_desc.npins = pctl->devdata->npins;
+	pctl->dev = &pdev->dev;
+	pctl->pctl_dev = pinctrl_register(&mt_pctrl_desc, &pdev->dev, pctl);
+	if (!pctl->pctl_dev) {
+		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
+		return -EINVAL;
+	}
+
+	pctl->chip = devm_kzalloc(&pdev->dev, sizeof(*pctl->chip), GFP_KERNEL);
+	if (!pctl->chip) {
+		ret = -ENOMEM;
+		goto pctrl_error;
+	}
+
+	pctl->chip = &mt_gpio_chip;
+	pctl->chip->ngpio = pctl->devdata->npins;
+	pctl->chip->label = dev_name(&pdev->dev);
+	pctl->chip->dev = &pdev->dev;
+	pctl->chip->base = 0;
+
+	ret = gpiochip_add(pctl->chip);
+	if (ret) {
+		ret = -EINVAL;
+		goto pctrl_error;
+	}
+
+	for (i = 0; i < pctl->devdata->npins; i++) {
+		const struct mt_desc_pin *pin = pctl->devdata->pins + i;
+
+		ret = gpiochip_add_pin_range(pctl->chip, dev_name(&pdev->dev),
+					     pin->pin.number,
+					     pin->pin.number, 1);
+		if (ret) {
+			ret = -EINVAL;
+			goto chip_error;
+		}
+	}
+
+	return 0;
+
+chip_error:
+	if (gpiochip_remove(pctl->chip))
+		dev_err(&pdev->dev, "failed to remove gpio chip\n");
+
+pctrl_error:
+	pinctrl_unregister(pctl->pctl_dev);
+	return ret;
+}
+
+int mt_pctrl_remove(struct platform_device *pdev)
+{
+	int ret;
+	struct mt_pinctrl *pctl = platform_get_drvdata(pdev);
+
+	pinctrl_unregister(pctl->pctl_dev);
+
+	ret = gpiochip_remove(pctl->chip);
+	if (ret) {
+		dev_err(&pdev->dev, "%s failed, %d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MediaTek Pinctrl Driver");
+MODULE_AUTHOR("Hongzhou Yang <hongzhou.yang@mediatek.com>");
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
new file mode 100644
index 0000000..06c7ebd
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -0,0 +1,95 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Hongzhou.Yang <hongzhou.yang@mediatek.com>
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
+#ifndef __PINCTRL_MTK_H
+#define __PINCTRL_MTK_H
+
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/spinlock.h>
+
+struct mt_desc_function {
+	const char *name;
+	unsigned char muxval;
+	unsigned char irqnum;
+};
+
+struct mt_desc_pin {
+	struct pinctrl_pin_desc pin;
+	const char *chip;
+	struct mt_desc_function *functions;
+};
+
+#define MT_PIN(_pin, _pad, _chip, ...)				\
+	{							\
+		.pin = _pin,					\
+		.chip = _chip,					\
+		.functions = (struct mt_desc_function[]){	\
+			__VA_ARGS__, { } },			\
+	}
+
+#define MT_FUNCTION(_val, _name)				\
+	{							\
+		.name = _name,					\
+		.muxval = _val,					\
+		.irqnum = 255,					\
+	}
+
+#define MT_FUNCTION_IRQ(_val, _name, _irq)			\
+	{							\
+		.name = _name,					\
+		.muxval = _val,					\
+		.irqnum = _irq,					\
+	}
+
+struct mt_pinctrl_group {
+	const char	*name;
+	unsigned long	config;
+	unsigned	pin;
+};
+
+struct mt_gpio_devdata {
+	const struct mt_desc_pin *pins;
+	int npins;
+	unsigned int dir_offset;
+	unsigned int ies_offset;
+	unsigned int pullen_offset;
+	unsigned int pullsel_offset;
+	unsigned int drv_offset;
+	unsigned int invser_offset;
+	unsigned int dout_offset;
+	unsigned int din_offset;
+	unsigned int pinmux_offset;
+	unsigned short type1_start;
+	unsigned short type1_end;
+};
+
+struct mt_pinctrl {
+	void __iomem		*membase1;
+	void __iomem		*membase2;
+	struct device		*dev;
+	struct gpio_chip	*chip;
+	spinlock_t		lock;
+	struct mt_pinctrl_group *groups;
+	unsigned		ngroups;
+	const char		**grp_names;
+	struct pinctrl_dev	*pctl_dev;
+	const struct mt_gpio_devdata	*devdata;
+};
+
+int mt_pctrl_init(struct platform_device *pdev,
+		const struct mt_gpio_devdata *data);
+
+int mt_pctrl_remove(struct platform_device *pdev);
+
+#endif /* __PINCTRL_MT65XX_H */
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h
new file mode 100644
index 0000000..5f7d82c
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8135.h
@@ -0,0 +1,2460 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Hongzhou.Yang <hongzhou.yang@mediatek.com>
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
+#ifndef __PINCTRL_MTK_MT8135_H
+#define __PINCTRL_MTK_MT8135_H
+
+#include <linux/pinctrl/pinctrl.h>
+#include <pinctrl-mtk-common.h>
+
+static const struct mt_desc_pin mt_pins_mt8135[] = {
+	MT_PIN(
+		PINCTRL_PIN(0, "MSDC0_DAT7"),
+		"D21", "mt8135",
+		MT_FUNCTION(0, "GPIO0"),
+		MT_FUNCTION(1, "MSDC0_DAT7"),
+		MT_FUNCTION_IRQ(2, "EINT49", 49),
+		MT_FUNCTION(3, "I2SOUT_DAT"),
+		MT_FUNCTION(4, "DAC_DAT_OUT"),
+		MT_FUNCTION(5, "PCM1_DO"),
+		MT_FUNCTION(6, "SPI1_MO"),
+		MT_FUNCTION(7, "NALE")
+	),
+	MT_PIN(
+		PINCTRL_PIN(1, "MSDC0_DAT6"),
+		"D22", "mt8135",
+		MT_FUNCTION(0, "GPIO1"),
+		MT_FUNCTION(1, "MSDC0_DAT6"),
+		MT_FUNCTION_IRQ(2, "EINT48", 48),
+		MT_FUNCTION(3, "I2SIN_WS"),
+		MT_FUNCTION(4, "DAC_WS"),
+		MT_FUNCTION(5, "PCM1_WS"),
+		MT_FUNCTION(6, "SPI1_CSN"),
+		MT_FUNCTION(7, "NCLE")
+	),
+	MT_PIN(
+		PINCTRL_PIN(2, "MSDC0_DAT5"),
+		"E22", "mt8135",
+		MT_FUNCTION(0, "GPIO2"),
+		MT_FUNCTION(1, "MSDC0_DAT5"),
+		MT_FUNCTION_IRQ(2, "EINT47", 47),
+		MT_FUNCTION(3, "I2SIN_CK"),
+		MT_FUNCTION(4, "DAC_CK"),
+		MT_FUNCTION(5, "PCM1_CK"),
+		MT_FUNCTION(6, "SPI1_CLK"),
+		MT_FUNCTION(7, "NLD4")
+	),
+	MT_PIN(
+		PINCTRL_PIN(3, "MSDC0_DAT4"),
+		"F21", "mt8135",
+		MT_FUNCTION(0, "GPIO3"),
+		MT_FUNCTION(1, "MSDC0_DAT4"),
+		MT_FUNCTION_IRQ(2, "EINT46", 46),
+		MT_FUNCTION(3, "A_FUNC_CK"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, "LSCE1B_2X"),
+		MT_FUNCTION(7, "NLD5")
+	),
+	MT_PIN(
+		PINCTRL_PIN(4, "MSDC0_CMD"),
+		"F20", "mt8135",
+		MT_FUNCTION(0, "GPIO4"),
+		MT_FUNCTION(1, "MSDC0_CMD"),
+		MT_FUNCTION_IRQ(2, "EINT41", 41),
+		MT_FUNCTION(3, "A_FUNC_DOUT[0]"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[0]"),
+		MT_FUNCTION(6, "LRSTB_2X"),
+		MT_FUNCTION(7, "NRNB")
+	),
+	MT_PIN(
+		PINCTRL_PIN(5, "MSDC0_CLK"),
+		"G18", "mt8135",
+		MT_FUNCTION(0, "GPIO5"),
+		MT_FUNCTION(1, "MSDC0_CLK"),
+		MT_FUNCTION_IRQ(2, "EINT40", 40),
+		MT_FUNCTION(3, "A_FUNC_DOUT[1]"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[1]"),
+		MT_FUNCTION(6, "LPTE"),
+		MT_FUNCTION(7, "NREB")
+	),
+	MT_PIN(
+		PINCTRL_PIN(6, "MSDC0_DAT3"),
+		"G21", "mt8135",
+		MT_FUNCTION(0, "GPIO6"),
+		MT_FUNCTION(1, "MSDC0_DAT3"),
+		MT_FUNCTION_IRQ(2, "EINT45", 45),
+		MT_FUNCTION(3, "A_FUNC_DOUT[2]"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[2]"),
+		MT_FUNCTION(6, "LSCE0B_2X"),
+		MT_FUNCTION(7, "NLD7")
+	),
+	MT_PIN(
+		PINCTRL_PIN(7, "MSDC0_DAT2"),
+		"E21", "mt8135",
+		MT_FUNCTION(0, "GPIO7"),
+		MT_FUNCTION(1, "MSDC0_DAT2"),
+		MT_FUNCTION_IRQ(2, "EINT44", 44),
+		MT_FUNCTION(3, "A_FUNC_DOUT[3]"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[3]"),
+		MT_FUNCTION(6, "LSA0_2X"),
+		MT_FUNCTION(7, "NLD14")
+	),
+	MT_PIN(
+		PINCTRL_PIN(8, "MSDC0_DAT1"),
+		"E23", "mt8135",
+		MT_FUNCTION(0, "GPIO8"),
+		MT_FUNCTION(1, "MSDC0_DAT1"),
+		MT_FUNCTION_IRQ(2, "EINT43", 43),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[4]"),
+		MT_FUNCTION(6, "LSCK_2X"),
+		MT_FUNCTION(7, "NLD11")
+	),
+	MT_PIN(
+		PINCTRL_PIN(9, "MSDC0_DAT0"),
+		"F22", "mt8135",
+		MT_FUNCTION(0, "GPIO9"),
+		MT_FUNCTION(1, "MSDC0_DAT0"),
+		MT_FUNCTION_IRQ(2, "EINT42", 42),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[5]"),
+		MT_FUNCTION(6, "LSDA_2X"),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(10, "NCEB0"),
+		"G20", "mt8135",
+		MT_FUNCTION(0, "GPIO10"),
+		MT_FUNCTION(1, "NCEB0"),
+		MT_FUNCTION_IRQ(2, "EINT139", 139),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT4")
+	),
+	MT_PIN(
+		PINCTRL_PIN(11, "NCEB1"),
+		"L17", "mt8135",
+		MT_FUNCTION(0, "GPIO11"),
+		MT_FUNCTION(1, "NCEB1"),
+		MT_FUNCTION_IRQ(2, "EINT140", 140),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, "USB_DRVVBUS"),
+		MT_FUNCTION(7, "TESTA_OUT5")
+	),
+	MT_PIN(
+		PINCTRL_PIN(12, "NRNB"),
+		"G19", "mt8135",
+		MT_FUNCTION(0, "GPIO12"),
+		MT_FUNCTION(1, "NRNB"),
+		MT_FUNCTION_IRQ(2, "EINT141", 141),
+		MT_FUNCTION(3, "A_FUNC_DOUT[4]"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT6")
+	),
+	MT_PIN(
+		PINCTRL_PIN(13, "NCLE"),
+		"J18", "mt8135",
+		MT_FUNCTION(0, "GPIO13"),
+		MT_FUNCTION(1, "NCLE"),
+		MT_FUNCTION_IRQ(2, "EINT142", 142),
+		MT_FUNCTION(3, "A_FUNC_DOUT[5]"),
+		MT_FUNCTION(4, "CM2PDN_1X"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, "NALE"),
+		MT_FUNCTION(7, "TESTA_OUT7")
+	),
+	MT_PIN(
+		PINCTRL_PIN(14, "NALE"),
+		"J19", "mt8135",
+		MT_FUNCTION(0, "GPIO14"),
+		MT_FUNCTION(1, "NALE"),
+		MT_FUNCTION_IRQ(2, "EINT143", 143),
+		MT_FUNCTION(3, "A_FUNC_DOUT[6]"),
+		MT_FUNCTION(4, "CM2MCLK_1X"),
+		MT_FUNCTION(5, "IRDA_RXD"),
+		MT_FUNCTION(6, "NCLE"),
+		MT_FUNCTION(7, "TESTA_OUT8")
+	),
+	MT_PIN(
+		PINCTRL_PIN(15, "NREB"),
+		"L18", "mt8135",
+		MT_FUNCTION(0, "GPIO15"),
+		MT_FUNCTION(1, "NREB"),
+		MT_FUNCTION_IRQ(2, "EINT144", 144),
+		MT_FUNCTION(3, "A_FUNC_DOUT[7]"),
+		MT_FUNCTION(4, "CM2RST_1X"),
+		MT_FUNCTION(5, "IRDA_TXD"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT9")
+	),
+	MT_PIN(
+		PINCTRL_PIN(16, "NWEB"),
+		"J20", "mt8135",
+		MT_FUNCTION(0, "GPIO16"),
+		MT_FUNCTION(1, "NWEB"),
+		MT_FUNCTION_IRQ(2, "EINT145", 145),
+		MT_FUNCTION(3, "A_FUNC_DIN[0]"),
+		MT_FUNCTION(4, "CM2PCLK_1X"),
+		MT_FUNCTION(5, "IRDA_PDN"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT10")
+	),
+	MT_PIN(
+		PINCTRL_PIN(17, "NLD0"),
+		"K21", "mt8135",
+		MT_FUNCTION(0, "GPIO17"),
+		MT_FUNCTION(1, "NLD0"),
+		MT_FUNCTION_IRQ(2, "EINT146", 146),
+		MT_FUNCTION(3, "A_FUNC_DIN[1]"),
+		MT_FUNCTION(4, "CM2DAT_1X[0]"),
+		MT_FUNCTION(5, "I2SIN_CK"),
+		MT_FUNCTION(6, "DAC_CK"),
+		MT_FUNCTION(7, "TESTA_OUT11")
+	),
+	MT_PIN(
+		PINCTRL_PIN(18, "NLD1"),
+		"K22", "mt8135",
+		MT_FUNCTION(0, "GPIO18"),
+		MT_FUNCTION(1, "NLD1"),
+		MT_FUNCTION_IRQ(2, "EINT147", 147),
+		MT_FUNCTION(3, "A_FUNC_DIN[2]"),
+		MT_FUNCTION(4, "CM2DAT_1X[1]"),
+		MT_FUNCTION(5, "I2SIN_WS"),
+		MT_FUNCTION(6, "DAC_WS"),
+		MT_FUNCTION(7, "TESTA_OUT12")
+	),
+	MT_PIN(
+		PINCTRL_PIN(19, "NLD2"),
+		"J21", "mt8135",
+		MT_FUNCTION(0, "GPIO19"),
+		MT_FUNCTION(1, "NLD2"),
+		MT_FUNCTION_IRQ(2, "EINT148", 148),
+		MT_FUNCTION(3, "A_FUNC_DIN[3]"),
+		MT_FUNCTION(4, "CM2DAT_1X[2]"),
+		MT_FUNCTION(5, "I2SOUT_DAT"),
+		MT_FUNCTION(6, "DAC_DAT_OUT"),
+		MT_FUNCTION(7, "TESTA_OUT13")
+	),
+	MT_PIN(
+		PINCTRL_PIN(20, "NLD3"),
+		"J23", "mt8135",
+		MT_FUNCTION(0, "GPIO20"),
+		MT_FUNCTION(1, "NLD3"),
+		MT_FUNCTION_IRQ(2, "EINT149", 149),
+		MT_FUNCTION(3, "A_FUNC_DIN[4]"),
+		MT_FUNCTION(4, "CM2DAT_1X[3]"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT14")
+	),
+	MT_PIN(
+		PINCTRL_PIN(21, "NLD4"),
+		"J22", "mt8135",
+		MT_FUNCTION(0, "GPIO21"),
+		MT_FUNCTION(1, "NLD4"),
+		MT_FUNCTION_IRQ(2, "EINT150", 150),
+		MT_FUNCTION(3, "A_FUNC_DIN[5]"),
+		MT_FUNCTION(4, "CM2DAT_1X[4]"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT15")
+	),
+	MT_PIN(
+		PINCTRL_PIN(22, "NLD5"),
+		"H21", "mt8135",
+		MT_FUNCTION(0, "GPIO22"),
+		MT_FUNCTION(1, "NLD5"),
+		MT_FUNCTION_IRQ(2, "EINT151", 151),
+		MT_FUNCTION(3, "A_FUNC_DIN[6]"),
+		MT_FUNCTION(4, "CM2DAT_1X[5]"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT16")
+	),
+	MT_PIN(
+		PINCTRL_PIN(23, "NLD6"),
+		"H22", "mt8135",
+		MT_FUNCTION(0, "GPIO23"),
+		MT_FUNCTION(1, "NLD6"),
+		MT_FUNCTION_IRQ(2, "EINT152", 152),
+		MT_FUNCTION(3, "A_FUNC_DIN[7]"),
+		MT_FUNCTION(4, "CM2DAT_1X[6]"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT17")
+	),
+	MT_PIN(
+		PINCTRL_PIN(24, "NLD7"),
+		"H20", "mt8135",
+		MT_FUNCTION(0, "GPIO24"),
+		MT_FUNCTION(1, "NLD7"),
+		MT_FUNCTION_IRQ(2, "EINT153", 153),
+		MT_FUNCTION(3, "A_FUNC_DIN[8]"),
+		MT_FUNCTION(4, "CM2DAT_1X[7]"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT18")
+	),
+	MT_PIN(
+		PINCTRL_PIN(25, "NLD8"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO25"),
+		MT_FUNCTION(1, "NLD8"),
+		MT_FUNCTION_IRQ(2, "EINT154", 154),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2DAT_1X[8]"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(26, "NLD9"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO26"),
+		MT_FUNCTION(1, "NLD9"),
+		MT_FUNCTION_IRQ(2, "EINT155", 155),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2DAT_1X[9]"),
+		MT_FUNCTION(5, "PWM1"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(27, "NLD10"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO27"),
+		MT_FUNCTION(1, "NLD10"),
+		MT_FUNCTION_IRQ(2, "EINT156", 156),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2VSYNC_1X"),
+		MT_FUNCTION(5, "PWM2"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(28, "NLD11"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO28"),
+		MT_FUNCTION(1, "NLD11"),
+		MT_FUNCTION_IRQ(2, "EINT157", 157),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2HSYNC_1X"),
+		MT_FUNCTION(5, "PWM3"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(29, "NLD12"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO29"),
+		MT_FUNCTION(1, "NLD12"),
+		MT_FUNCTION_IRQ(2, "EINT158", 158),
+		MT_FUNCTION(3, "I2SIN_CK"),
+		MT_FUNCTION(4, "DAC_CK"),
+		MT_FUNCTION(5, "PCM1_CK"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(30, "NLD13"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO30"),
+		MT_FUNCTION(1, "NLD13"),
+		MT_FUNCTION_IRQ(2, "EINT159", 159),
+		MT_FUNCTION(3, "I2SIN_WS"),
+		MT_FUNCTION(4, "DAC_WS"),
+		MT_FUNCTION(5, "PCM1_WS"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(31, "NLD14"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO31"),
+		MT_FUNCTION(1, "NLD14"),
+		MT_FUNCTION_IRQ(2, "EINT160", 160),
+		MT_FUNCTION(3, "I2SOUT_DAT"),
+		MT_FUNCTION(4, "DAC_DAT_OUT"),
+		MT_FUNCTION(5, "PCM1_DO"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(32, "NLD15"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO32"),
+		MT_FUNCTION(1, "NLD15"),
+		MT_FUNCTION_IRQ(2, "EINT161", 161),
+		MT_FUNCTION(3, "DISP_PWM"),
+		MT_FUNCTION(4, "PWM4"),
+		MT_FUNCTION(5, "PCM1_DI"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(33, "MSDC0_RSTB"),
+		"G22", "mt8135",
+		MT_FUNCTION(0, "GPIO33"),
+		MT_FUNCTION(1, "MSDC0_RSTB"),
+		MT_FUNCTION_IRQ(2, "EINT50", 50),
+		MT_FUNCTION(3, "I2SIN_DAT"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "PCM1_DI"),
+		MT_FUNCTION(6, "SPI1_MI"),
+		MT_FUNCTION(7, "NLD10")
+	),
+	MT_PIN(
+		PINCTRL_PIN(34, "IDDIG"),
+		"N17", "mt8135",
+		MT_FUNCTION(0, "GPIO34"),
+		MT_FUNCTION(1, "IDDIG"),
+		MT_FUNCTION_IRQ(2, "EINT34", 34),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(35, "SCL3"),
+		"L19", "mt8135",
+		MT_FUNCTION(0, "GPIO35"),
+		MT_FUNCTION(1, "SCL3"),
+		MT_FUNCTION_IRQ(2, "EINT96", 96),
+		MT_FUNCTION(3, "CLKM6"),
+		MT_FUNCTION(4, "PWM6"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(36, "SDA3"),
+		"L20", "mt8135",
+		MT_FUNCTION(0, "GPIO36"),
+		MT_FUNCTION(1, "SDA3"),
+		MT_FUNCTION_IRQ(2, "EINT97", 97),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(37, "AUD_CLK_MOSI"),
+		"L21", "mt8135",
+		MT_FUNCTION(0, "GPIO37"),
+		MT_FUNCTION(1, "AUD_CLK"),
+		MT_FUNCTION(2, "ADC_CK"),
+		MT_FUNCTION(3, " HDMI_SDATA0"),
+		MT_FUNCTION_IRQ(4, "EINT19", 19),
+		MT_FUNCTION(5, "USB_TEST_IO[6]"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT19")
+	),
+	MT_PIN(
+		PINCTRL_PIN(38, "AUD_DAT_MOSI"),
+		"L23", "mt8135",
+		MT_FUNCTION(0, "GPIO38"),
+		MT_FUNCTION(1, "AUD_DAT_MOSI"),
+		MT_FUNCTION(2, "ADC_WS"),
+		MT_FUNCTION(3, "AUD_DAT_MISO"),
+		MT_FUNCTION_IRQ(4, "EINT21", 21),
+		MT_FUNCTION(5, "USB_TEST_IO[7]"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT20")
+	),
+	MT_PIN(
+		PINCTRL_PIN(39, "AUD_DAT_MISO"),
+		"L22", "mt8135",
+		MT_FUNCTION(0, "GPIO39"),
+		MT_FUNCTION(1, "AUD_DAT_MISO"),
+		MT_FUNCTION(2, "ADC_DAT_IN"),
+		MT_FUNCTION(3, "AUD_DAT_MOSI"),
+		MT_FUNCTION_IRQ(4, "EINT20", 20),
+		MT_FUNCTION(5, "USB_TEST_IO[8]"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT21")
+	),
+	MT_PIN(
+		PINCTRL_PIN(40, "DAC_CLK"),
+		"P21", "mt8135",
+		MT_FUNCTION(0, "GPIO40"),
+		MT_FUNCTION(1, "DAC_CK"),
+		MT_FUNCTION_IRQ(2, "EINT22", 22),
+		MT_FUNCTION(3, " HDMI_SDATA1"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[9]"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT22")
+	),
+	MT_PIN(
+		PINCTRL_PIN(41, "DAC_WS"),
+		"N18", "mt8135",
+		MT_FUNCTION(0, "GPIO41"),
+		MT_FUNCTION(1, "DAC_WS"),
+		MT_FUNCTION_IRQ(2, "EINT24", 24),
+		MT_FUNCTION(3, " HDMI_SDATA2"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[10]"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT23")
+	),
+	MT_PIN(
+		PINCTRL_PIN(42, "DAC_DAT_OUT"),
+		"N22", "mt8135",
+		MT_FUNCTION(0, "GPIO42"),
+		MT_FUNCTION(1, "DAC_DAT_OUT"),
+		MT_FUNCTION_IRQ(2, "EINT23", 23),
+		MT_FUNCTION(3, " HDMI_SDATA3"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[11]"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT24")
+	),
+	MT_PIN(
+		PINCTRL_PIN(43, "PWRAP_SPI0_MO"),
+		"M22", "mt8135",
+		MT_FUNCTION(0, "GPIO43"),
+		MT_FUNCTION(1, "PWRAP_SPIDI"),
+		MT_FUNCTION_IRQ(2, "EINT29", 29),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(44, "PWRAP_SPI0_MI"),
+		"P23", "mt8135",
+		MT_FUNCTION(0, "GPIO44"),
+		MT_FUNCTION(1, "PWRAP_SPIDO"),
+		MT_FUNCTION_IRQ(2, "EINT28", 28),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(45, "PWRAP_SPI0_CSN"),
+		"M21", "mt8135",
+		MT_FUNCTION(0, "GPIO45"),
+		MT_FUNCTION(1, "PWRAP_SPICS_B_I"),
+		MT_FUNCTION_IRQ(2, "EINT27", 27),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(46, "PWRAP_SPI0_CLK"),
+		"P22", "mt8135",
+		MT_FUNCTION(0, "GPIO46"),
+		MT_FUNCTION(1, "PWRAP_SPICK_I"),
+		MT_FUNCTION_IRQ(2, "EINT26", 26),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(47, "PWRAP_EVENT"),
+		"M23", "mt8135",
+		MT_FUNCTION(0, "GPIO47"),
+		MT_FUNCTION(1, "PWRAP_EVENT_IN"),
+		MT_FUNCTION_IRQ(2, "EINT25", 25),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT2")
+	),
+	MT_PIN(
+		PINCTRL_PIN(48, "RTC32K_CK"),
+		"N20", "mt8135",
+		MT_FUNCTION(0, "GPIO48"),
+		MT_FUNCTION(1, "RTC32K_CK"),
+		MT_FUNCTION(2, NULL),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(49, "WATCHDOG"),
+		"R22", "mt8135",
+		MT_FUNCTION(0, "GPIO49"),
+		MT_FUNCTION(1, "WATCHDOG"),
+		MT_FUNCTION_IRQ(2, "EINT36", 36),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(50, "SRCLKENA"),
+		"T22", "mt8135",
+		MT_FUNCTION(0, "GPIO50"),
+		MT_FUNCTION(1, "SRCLKENA"),
+		MT_FUNCTION_IRQ(2, "EINT38", 38),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(51, "SRCVOLTEN"),
+		"T23", "mt8135",
+		MT_FUNCTION(0, "GPIO51"),
+		MT_FUNCTION(1, "SRCVOLTEN"),
+		MT_FUNCTION_IRQ(2, "EINT37", 37),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(52, "EINT0"),
+		"T21", "mt8135",
+		MT_FUNCTION(0, "GPIO52"),
+		MT_FUNCTION_IRQ(1, "EINT0", 0),
+		MT_FUNCTION(2, "PWM1"),
+		MT_FUNCTION(3, "CLKM0"),
+		MT_FUNCTION(4, " SPDIF_OUT"),
+		MT_FUNCTION(5, "USB_TEST_IO[12]"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "USB_SCL")
+	),
+	MT_PIN(
+		PINCTRL_PIN(53, "URXD2"),
+		"R18", "mt8135",
+		MT_FUNCTION(0, "GPIO53"),
+		MT_FUNCTION(1, "URXD2"),
+		MT_FUNCTION_IRQ(2, "EINT83", 83),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, " HDMI_LRCK"),
+		MT_FUNCTION(5, "CLKM3"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "UTXD2")
+	),
+	MT_PIN(
+		PINCTRL_PIN(54, "UTXD2"),
+		"R17", "mt8135",
+		MT_FUNCTION(0, "GPIO54"),
+		MT_FUNCTION(1, "UTXD2"),
+		MT_FUNCTION_IRQ(2, "EINT82", 82),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, " HDMI_BCK_OUT"),
+		MT_FUNCTION(5, "CLKM2"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "URXD2")
+	),
+	MT_PIN(
+		PINCTRL_PIN(55, "UCTS2"),
+		"R20", "mt8135",
+		MT_FUNCTION(0, "GPIO55"),
+		MT_FUNCTION(1, "UCTS2"),
+		MT_FUNCTION_IRQ(2, "EINT84", 84),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "PWM1"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "URTS2")
+	),
+	MT_PIN(
+		PINCTRL_PIN(56, "URTS2"),
+		"R19", "mt8135",
+		MT_FUNCTION(0, "GPIO56"),
+		MT_FUNCTION(1, "URTS2"),
+		MT_FUNCTION_IRQ(2, "EINT85", 85),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "PWM2"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "UCTS2")
+	),
+	MT_PIN(
+		PINCTRL_PIN(57, "JTCK"),
+		"V17", "mt8135",
+		MT_FUNCTION(0, "GPIO57"),
+		MT_FUNCTION(1, "JTCK"),
+		MT_FUNCTION_IRQ(2, "EINT188", 188),
+		MT_FUNCTION(3, "DSP1_ICK"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(58, "JTDO"),
+		"T16", "mt8135",
+		MT_FUNCTION(0, "GPIO58"),
+		MT_FUNCTION(1, "JTDO"),
+		MT_FUNCTION_IRQ(2, "EINT190", 190),
+		MT_FUNCTION(3, "DSP2_IMS"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(59, "JTRST_B"),
+		"T19", "mt8135",
+		MT_FUNCTION(0, "GPIO59"),
+		MT_FUNCTION(1, "JTRST_B"),
+		MT_FUNCTION_IRQ(2, "EINT0", 0),
+		MT_FUNCTION(3, "DSP2_ICK"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(60, "JTDI"),
+		"T18", "mt8135",
+		MT_FUNCTION(0, "GPIO60"),
+		MT_FUNCTION(1, "JTDI"),
+		MT_FUNCTION_IRQ(2, "EINT189", 189),
+		MT_FUNCTION(3, "DSP1_IMS"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(61, "JRTCK"),
+		"T20", "mt8135",
+		MT_FUNCTION(0, "GPIO61"),
+		MT_FUNCTION(1, "JRTCK"),
+		MT_FUNCTION_IRQ(2, "EINT187", 187),
+		MT_FUNCTION(3, "DSP1_ID"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(62, "JTMS"),
+		"T17", "mt8135",
+		MT_FUNCTION(0, "GPIO62"),
+		MT_FUNCTION(1, "JTMS"),
+		MT_FUNCTION_IRQ(2, "EINT191", 191),
+		MT_FUNCTION(3, "DSP2_ID"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(63, "MSDC1_INSI"),
+		"V18", "mt8135",
+		MT_FUNCTION(0, "GPIO63"),
+		MT_FUNCTION(1, "MSDC1_INSI"),
+		MT_FUNCTION_IRQ(2, "EINT57", 57),
+		MT_FUNCTION(3, "SCL5"),
+		MT_FUNCTION(4, "PWM6"),
+		MT_FUNCTION(5, "CLKM5"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTB_OUT6")
+	),
+	MT_PIN(
+		PINCTRL_PIN(64, "MSDC1_SDWPI"),
+		"W18", "mt8135",
+		MT_FUNCTION(0, "GPIO64"),
+		MT_FUNCTION(1, "MSDC1_SDWPI"),
+		MT_FUNCTION_IRQ(2, "EINT58", 58),
+		MT_FUNCTION(3, "SDA5"),
+		MT_FUNCTION(4, "PWM7"),
+		MT_FUNCTION(5, "CLKM6"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTB_OUT7")
+	),
+	MT_PIN(
+		PINCTRL_PIN(65, "MSDC2_INSI"),
+		"U22", "mt8135",
+		MT_FUNCTION(0, "GPIO65"),
+		MT_FUNCTION(1, "MSDC2_INSI"),
+		MT_FUNCTION_IRQ(2, "EINT65", 65),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[27]"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT3")
+	),
+	MT_PIN(
+		PINCTRL_PIN(66, "MSDC2_SDWPI"),
+		"U21", "mt8135",
+		MT_FUNCTION(0, "GPIO66"),
+		MT_FUNCTION(1, "MSDC2_SDWPI"),
+		MT_FUNCTION_IRQ(2, "EINT66", 66),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[28]"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(67, "URXD4"),
+		"V23", "mt8135",
+		MT_FUNCTION(0, "GPIO67"),
+		MT_FUNCTION(1, "URXD4"),
+		MT_FUNCTION_IRQ(2, "EINT89", 89),
+		MT_FUNCTION(3, "URXD1"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, "UTXD4"),
+		MT_FUNCTION(7, "TESTB_OUT10")
+	),
+	MT_PIN(
+		PINCTRL_PIN(68, "UTXD4"),
+		"V22", "mt8135",
+		MT_FUNCTION(0, "GPIO68"),
+		MT_FUNCTION(1, "UTXD4"),
+		MT_FUNCTION_IRQ(2, "EINT88", 88),
+		MT_FUNCTION(3, "UTXD1"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, "URXD4"),
+		MT_FUNCTION(7, "TESTB_OUT11")
+	),
+	MT_PIN(
+		PINCTRL_PIN(69, "URXD1"),
+		"W22", "mt8135",
+		MT_FUNCTION(0, "GPIO69"),
+		MT_FUNCTION(1, "URXD1"),
+		MT_FUNCTION_IRQ(2, "EINT79", 79),
+		MT_FUNCTION(3, "URXD4"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, "UTXD1"),
+		MT_FUNCTION(7, "TESTB_OUT24")
+	),
+	MT_PIN(
+		PINCTRL_PIN(70, "UTXD1"),
+		"V21", "mt8135",
+		MT_FUNCTION(0, "GPIO70"),
+		MT_FUNCTION(1, "UTXD1"),
+		MT_FUNCTION_IRQ(2, "EINT78", 78),
+		MT_FUNCTION(3, "UTXD4"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, "URXD1"),
+		MT_FUNCTION(7, "TESTB_OUT25")
+	),
+	MT_PIN(
+		PINCTRL_PIN(71, "UCTS1"),
+		"V19", "mt8135",
+		MT_FUNCTION(0, "GPIO71"),
+		MT_FUNCTION(1, "UCTS1"),
+		MT_FUNCTION_IRQ(2, "EINT80", 80),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "CLKM0"),
+		MT_FUNCTION(6, "URTS1"),
+		MT_FUNCTION(7, "TESTB_OUT31")
+	),
+	MT_PIN(
+		PINCTRL_PIN(72, "URTS1"),
+		"V20", "mt8135",
+		MT_FUNCTION(0, "GPIO72"),
+		MT_FUNCTION(1, "URTS1"),
+		MT_FUNCTION_IRQ(2, "EINT81", 81),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "CLKM1"),
+		MT_FUNCTION(6, "UCTS1"),
+		MT_FUNCTION(7, "TESTB_OUT21")
+	),
+	MT_PIN(
+		PINCTRL_PIN(73, "PWM1"),
+		"W17", "mt8135",
+		MT_FUNCTION(0, "GPIO73"),
+		MT_FUNCTION(1, "PWM1"),
+		MT_FUNCTION_IRQ(2, "EINT73", 73),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_DRVVBUS"),
+		MT_FUNCTION(6, "DISP_PWM"),
+		MT_FUNCTION(7, "TESTB_OUT8")
+	),
+	MT_PIN(
+		PINCTRL_PIN(74, "PWM2"),
+		"Y17", "mt8135",
+		MT_FUNCTION(0, "GPIO74"),
+		MT_FUNCTION(1, "PWM2"),
+		MT_FUNCTION_IRQ(2, "EINT74", 74),
+		MT_FUNCTION(3, "DPI33_CK"),
+		MT_FUNCTION(4, "PWM5"),
+		MT_FUNCTION(5, "URXD2"),
+		MT_FUNCTION(6, "DISP_PWM"),
+		MT_FUNCTION(7, "TESTB_OUT9")
+	),
+	MT_PIN(
+		PINCTRL_PIN(75, "PWM3"),
+		"Y19", "mt8135",
+		MT_FUNCTION(0, "GPIO75"),
+		MT_FUNCTION(1, "PWM3"),
+		MT_FUNCTION_IRQ(2, "EINT75", 75),
+		MT_FUNCTION(3, "DPI33_D0"),
+		MT_FUNCTION(4, "PWM6"),
+		MT_FUNCTION(5, "UTXD2"),
+		MT_FUNCTION(6, "DISP_PWM"),
+		MT_FUNCTION(7, "TESTB_OUT12")
+	),
+	MT_PIN(
+		PINCTRL_PIN(76, "PWM4"),
+		"W19", "mt8135",
+		MT_FUNCTION(0, "GPIO76"),
+		MT_FUNCTION(1, "PWM4"),
+		MT_FUNCTION_IRQ(2, "EINT76", 76),
+		MT_FUNCTION(3, "DPI33_D1"),
+		MT_FUNCTION(4, "PWM7"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, "DISP_PWM"),
+		MT_FUNCTION(7, "TESTB_OUT13")
+	),
+	MT_PIN(
+		PINCTRL_PIN(77, "MSDC2_DAT2"),
+		"W21", "mt8135",
+		MT_FUNCTION(0, "GPIO77"),
+		MT_FUNCTION(1, "MSDC2_DAT2"),
+		MT_FUNCTION_IRQ(2, "EINT63", 63),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "DSP2_IMS"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, "DPI33_D6"),
+		MT_FUNCTION(7, "TESTA_OUT25")
+	),
+	MT_PIN(
+		PINCTRL_PIN(78, "MSDC2_DAT3"),
+		"AA23", "mt8135",
+		MT_FUNCTION(0, "GPIO78"),
+		MT_FUNCTION(1, "MSDC2_DAT3"),
+		MT_FUNCTION_IRQ(2, "EINT64", 64),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "DSP2_ID"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, "DPI33_D7"),
+		MT_FUNCTION(7, "TESTA_OUT26")
+	),
+	MT_PIN(
+		PINCTRL_PIN(79, "MSDC2_CMD"),
+		"Y22", "mt8135",
+		MT_FUNCTION(0, "GPIO79"),
+		MT_FUNCTION(1, "MSDC2_CMD"),
+		MT_FUNCTION_IRQ(2, "EINT60", 60),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "DSP1_IMS"),
+		MT_FUNCTION(5, "PCM1_WS"),
+		MT_FUNCTION(6, "DPI33_D3"),
+		MT_FUNCTION(7, "TESTA_OUT0")
+	),
+	MT_PIN(
+		PINCTRL_PIN(80, "MSDC2_CLK"),
+		"AA22", "mt8135",
+		MT_FUNCTION(0, "GPIO80"),
+		MT_FUNCTION(1, "MSDC2_CLK"),
+		MT_FUNCTION_IRQ(2, "EINT59", 59),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "DSP1_ICK"),
+		MT_FUNCTION(5, "PCM1_CK"),
+		MT_FUNCTION(6, "DPI33_D2"),
+		MT_FUNCTION(7, "TESTA_OUT1")
+	),
+	MT_PIN(
+		PINCTRL_PIN(81, "MSDC2_DAT1"),
+		"Y21", "mt8135",
+		MT_FUNCTION(0, "GPIO81"),
+		MT_FUNCTION(1, "MSDC2_DAT1"),
+		MT_FUNCTION_IRQ(2, "EINT62", 62),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "DSP2_ICK"),
+		MT_FUNCTION(5, "PCM1_DO"),
+		MT_FUNCTION(6, "DPI33_D5"),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(82, "MSDC2_DAT0"),
+		"AB22", "mt8135",
+		MT_FUNCTION(0, "GPIO82"),
+		MT_FUNCTION(1, "MSDC2_DAT0"),
+		MT_FUNCTION_IRQ(2, "EINT61", 61),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "DSP1_ID"),
+		MT_FUNCTION(5, "PCM1_DI"),
+		MT_FUNCTION(6, "DPI33_D4"),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(83, "MSDC1_DAT0"),
+		"AC19", "mt8135",
+		MT_FUNCTION(0, "GPIO83"),
+		MT_FUNCTION(1, "MSDC1_DAT0"),
+		MT_FUNCTION_IRQ(2, "EINT53", 53),
+		MT_FUNCTION(3, "SCL1"),
+		MT_FUNCTION(4, "PWM2"),
+		MT_FUNCTION(5, "CLKM1"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTB_OUT2")
+	),
+	MT_PIN(
+		PINCTRL_PIN(84, "MSDC1_DAT1"),
+		"AA19", "mt8135",
+		MT_FUNCTION(0, "GPIO84"),
+		MT_FUNCTION(1, "MSDC1_DAT1"),
+		MT_FUNCTION_IRQ(2, "EINT54", 54),
+		MT_FUNCTION(3, "SDA1"),
+		MT_FUNCTION(4, "PWM3"),
+		MT_FUNCTION(5, "CLKM2"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTB_OUT3")
+	),
+	MT_PIN(
+		PINCTRL_PIN(85, "MSDC1_CMD"),
+		"AA20", "mt8135",
+		MT_FUNCTION(0, "GPIO85"),
+		MT_FUNCTION(1, "MSDC1_CMD"),
+		MT_FUNCTION_IRQ(2, "EINT52", 52),
+		MT_FUNCTION(3, "SDA0"),
+		MT_FUNCTION(4, "PWM1"),
+		MT_FUNCTION(5, "CLKM0"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTB_OUT1")
+	),
+	MT_PIN(
+		PINCTRL_PIN(86, "MSDC1_CLK"),
+		"AB19", "mt8135",
+		MT_FUNCTION(0, "GPIO86"),
+		MT_FUNCTION(1, "MSDC1_CLK"),
+		MT_FUNCTION_IRQ(2, "EINT51", 51),
+		MT_FUNCTION(3, "SCL0"),
+		MT_FUNCTION(4, "DISP_PWM"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTB_OUT0")
+	),
+	MT_PIN(
+		PINCTRL_PIN(87, "MSDC1_DAT2"),
+		"AA21", "mt8135",
+		MT_FUNCTION(0, "GPIO87"),
+		MT_FUNCTION(1, "MSDC1_DAT2"),
+		MT_FUNCTION_IRQ(2, "EINT55", 55),
+		MT_FUNCTION(3, "SCL4"),
+		MT_FUNCTION(4, "PWM4"),
+		MT_FUNCTION(5, "CLKM3"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTB_OUT4")
+	),
+	MT_PIN(
+		PINCTRL_PIN(88, "MSDC1_DAT3"),
+		"AB20", "mt8135",
+		MT_FUNCTION(0, "GPIO88"),
+		MT_FUNCTION(1, "MSDC1_DAT3"),
+		MT_FUNCTION_IRQ(2, "EINT56", 56),
+		MT_FUNCTION(3, "SDA4"),
+		MT_FUNCTION(4, "PWM5"),
+		MT_FUNCTION(5, "CLKM4"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTB_OUT5")
+	),
+	MT_PIN(
+		PINCTRL_PIN(89, "MSDC4_DAT0"),
+		"AB8", "mt8135",
+		MT_FUNCTION(0, "GPIO89"),
+		MT_FUNCTION(1, "MSDC4_DAT0"),
+		MT_FUNCTION_IRQ(2, "EINT133", 133),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "EXT_FRAME_SYNC"),
+		MT_FUNCTION(5, "USB_DRVVBUS"),
+		MT_FUNCTION(6, "A_FUNC_DIN[9]"),
+		MT_FUNCTION(7, "LPTE")
+	),
+	MT_PIN(
+		PINCTRL_PIN(90, "MSDC4_DAT1"),
+		"AB7", "mt8135",
+		MT_FUNCTION(0, "GPIO90"),
+		MT_FUNCTION(1, "MSDC4_DAT1"),
+		MT_FUNCTION_IRQ(2, "EINT134", 134),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, "A_FUNC_DIN[10]"),
+		MT_FUNCTION(7, "LRSTB_1X")
+	),
+	MT_PIN(
+		PINCTRL_PIN(91, "MSDC4_DAT5"),
+		"AA8", "mt8135",
+		MT_FUNCTION(0, "GPIO91"),
+		MT_FUNCTION(1, "MSDC4_DAT5"),
+		MT_FUNCTION_IRQ(2, "EINT136", 136),
+		MT_FUNCTION(3, "I2SIN_WS"),
+		MT_FUNCTION(4, "DAC_WS"),
+		MT_FUNCTION(5, "PCM1_WS"),
+		MT_FUNCTION(6, "A_FUNC_DIN[11]"),
+		MT_FUNCTION(7, "SPI1_CSN")
+	),
+	MT_PIN(
+		PINCTRL_PIN(92, "MSDC4_DAT6"),
+		"AC4", "mt8135",
+		MT_FUNCTION(0, "GPIO92"),
+		MT_FUNCTION(1, "MSDC4_DAT6"),
+		MT_FUNCTION_IRQ(2, "EINT137", 137),
+		MT_FUNCTION(3, "I2SOUT_DAT"),
+		MT_FUNCTION(4, "DAC_DAT_OUT"),
+		MT_FUNCTION(5, "PCM1_DO"),
+		MT_FUNCTION(6, "A_FUNC_DIN[12]"),
+		MT_FUNCTION(7, "SPI1_MO")
+	),
+	MT_PIN(
+		PINCTRL_PIN(93, "MSDC4_DAT7"),
+		"AC6", "mt8135",
+		MT_FUNCTION(0, "GPIO93"),
+		MT_FUNCTION(1, "MSDC4_DAT7"),
+		MT_FUNCTION_IRQ(2, "EINT138", 138),
+		MT_FUNCTION(3, "I2SIN_DAT"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "PCM1_DI"),
+		MT_FUNCTION(6, "A_FUNC_DIN[13]"),
+		MT_FUNCTION(7, "SPI1_MI")
+	),
+	MT_PIN(
+		PINCTRL_PIN(94, "MSDC4_DAT4"),
+		"AA7", "mt8135",
+		MT_FUNCTION(0, "GPIO94"),
+		MT_FUNCTION(1, "MSDC4_DAT4"),
+		MT_FUNCTION_IRQ(2, "EINT135", 135),
+		MT_FUNCTION(3, "I2SIN_CK"),
+		MT_FUNCTION(4, "DAC_CK"),
+		MT_FUNCTION(5, "PCM1_CK"),
+		MT_FUNCTION(6, "A_FUNC_DIN[14]"),
+		MT_FUNCTION(7, "SPI1_CLK")
+	),
+	MT_PIN(
+		PINCTRL_PIN(95, "MSDC4_DAT2"),
+		"AB6", "mt8135",
+		MT_FUNCTION(0, "GPIO95"),
+		MT_FUNCTION(1, "MSDC4_DAT2"),
+		MT_FUNCTION_IRQ(2, "EINT131", 131),
+		MT_FUNCTION(3, "I2SIN_WS"),
+		MT_FUNCTION(4, "CM2PDN_2X"),
+		MT_FUNCTION(5, "DAC_WS"),
+		MT_FUNCTION(6, "PCM1_WS"),
+		MT_FUNCTION(7, "LSCE0B_1X")
+	),
+	MT_PIN(
+		PINCTRL_PIN(96, "MSDC4_CLK"),
+		"AB5", "mt8135",
+		MT_FUNCTION(0, "GPIO96"),
+		MT_FUNCTION(1, "MSDC4_CLK"),
+		MT_FUNCTION_IRQ(2, "EINT129", 129),
+		MT_FUNCTION(3, "DPI1_CK_2X"),
+		MT_FUNCTION(4, "CM2PCLK_2X"),
+		MT_FUNCTION(5, "PWM4"),
+		MT_FUNCTION(6, "PCM1_DI"),
+		MT_FUNCTION(7, "LSCK_1X")
+	),
+	MT_PIN(
+		PINCTRL_PIN(97, "MSDC4_DAT3"),
+		"Y8", "mt8135",
+		MT_FUNCTION(0, "GPIO97"),
+		MT_FUNCTION(1, "MSDC4_DAT3"),
+		MT_FUNCTION_IRQ(2, "EINT132", 132),
+		MT_FUNCTION(3, "I2SOUT_DAT"),
+		MT_FUNCTION(4, "CM2RST_2X"),
+		MT_FUNCTION(5, "DAC_DAT_OUT"),
+		MT_FUNCTION(6, "PCM1_DO"),
+		MT_FUNCTION(7, "LSCE1B_1X")
+	),
+	MT_PIN(
+		PINCTRL_PIN(98, "MSDC4_CMD"),
+		"AC3", "mt8135",
+		MT_FUNCTION(0, "GPIO98"),
+		MT_FUNCTION(1, "MSDC4_CMD"),
+		MT_FUNCTION_IRQ(2, "EINT128", 128),
+		MT_FUNCTION(3, "DPI1_DE_2X"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "PWM3"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "LSDA_1X")
+	),
+	MT_PIN(
+		PINCTRL_PIN(99, "MSDC4_RSTB"),
+		"AB4", "mt8135",
+		MT_FUNCTION(0, "GPIO99"),
+		MT_FUNCTION(1, "MSDC4_RSTB"),
+		MT_FUNCTION_IRQ(2, "EINT130", 130),
+		MT_FUNCTION(3, "I2SIN_CK"),
+		MT_FUNCTION(4, "CM2MCLK_2X"),
+		MT_FUNCTION(5, "DAC_CK"),
+		MT_FUNCTION(6, "PCM1_CK"),
+		MT_FUNCTION(7, "LSA0_1X")
+	),
+	MT_PIN(
+		PINCTRL_PIN(100, "SDA0"),
+		"W9", "mt8135",
+		MT_FUNCTION(0, "GPIO100"),
+		MT_FUNCTION(1, "SDA0"),
+		MT_FUNCTION_IRQ(2, "EINT91", 91),
+		MT_FUNCTION(3, "CLKM1"),
+		MT_FUNCTION(4, "PWM1"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "A_FUNC_DIN[15]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(101, "SCL0"),
+		"W11", "mt8135",
+		MT_FUNCTION(0, "GPIO101"),
+		MT_FUNCTION(1, "SCL0"),
+		MT_FUNCTION_IRQ(2, "EINT90", 90),
+		MT_FUNCTION(3, "CLKM0"),
+		MT_FUNCTION(4, "DISP_PWM"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "A_FUNC_DIN[16]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(102, "EINT10_AUXIN2"),
+		"AA3", "mt8135",
+		MT_FUNCTION(0, "GPIO102"),
+		MT_FUNCTION_IRQ(1, "EINT10", 10),
+		MT_FUNCTION(2, NULL),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[16]"),
+		MT_FUNCTION(6, "TESTB_OUT16"),
+		MT_FUNCTION(7, "A_FUNC_DIN[17]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(103, "EINT11_AUXIN3"),
+		"AB2", "mt8135",
+		MT_FUNCTION(0, "GPIO103"),
+		MT_FUNCTION_IRQ(1, "EINT11", 11),
+		MT_FUNCTION(2, NULL),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[17]"),
+		MT_FUNCTION(6, "TESTB_OUT17"),
+		MT_FUNCTION(7, "A_FUNC_DIN[18]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(104, "EINT16_AUXIN4"),
+		"AB3", "mt8135",
+		MT_FUNCTION(0, "GPIO104"),
+		MT_FUNCTION_IRQ(1, "EINT16", 16),
+		MT_FUNCTION(2, NULL),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[18]"),
+		MT_FUNCTION(6, "TESTB_OUT18"),
+		MT_FUNCTION(7, "A_FUNC_DIN[19]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(105, "I2S_CLK"),
+		"W6", "mt8135",
+		MT_FUNCTION(0, "GPIO105"),
+		MT_FUNCTION(1, "I2SIN_CK"),
+		MT_FUNCTION_IRQ(2, "EINT10", 10),
+		MT_FUNCTION(3, "DAC_CK"),
+		MT_FUNCTION(4, "PCM1_CK"),
+		MT_FUNCTION(5, "USB_TEST_IO[19]"),
+		MT_FUNCTION(6, "TESTB_OUT19"),
+		MT_FUNCTION(7, "A_FUNC_DIN[20]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(106, "I2S_WS"),
+		"AA6", "mt8135",
+		MT_FUNCTION(0, "GPIO106"),
+		MT_FUNCTION(1, "I2SIN_WS"),
+		MT_FUNCTION_IRQ(2, "EINT13", 13),
+		MT_FUNCTION(3, "DAC_WS"),
+		MT_FUNCTION(4, "PCM1_WS"),
+		MT_FUNCTION(5, "USB_TEST_IO[20]"),
+		MT_FUNCTION(6, "TESTB_OUT20"),
+		MT_FUNCTION(7, "A_FUNC_DIN[21]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(107, "I2S_DATA_IN"),
+		"AA5", "mt8135",
+		MT_FUNCTION(0, "GPIO107"),
+		MT_FUNCTION(1, "I2SIN_DAT"),
+		MT_FUNCTION_IRQ(2, "EINT11", 11),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "PCM1_DI"),
+		MT_FUNCTION(5, "USB_TEST_IO[21]"),
+		MT_FUNCTION(6, "TESTB_OUT22"),
+		MT_FUNCTION(7, "A_FUNC_DIN[22]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(108, "I2S_DATA_OUT"),
+		"AA4", "mt8135",
+		MT_FUNCTION(0, "GPIO108"),
+		MT_FUNCTION(1, "I2SOUT_DAT"),
+		MT_FUNCTION_IRQ(2, "EINT12", 12),
+		MT_FUNCTION(3, "DAC_DAT_OUT"),
+		MT_FUNCTION(4, "PCM1_DO"),
+		MT_FUNCTION(5, "USB_TEST_IO[22]"),
+		MT_FUNCTION(6, "TESTB_OUT23"),
+		MT_FUNCTION(7, "A_FUNC_DIN[23]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(109, "EINT5"),
+		"W5", "mt8135",
+		MT_FUNCTION(0, "GPIO109"),
+		MT_FUNCTION_IRQ(1, "EINT5", 5),
+		MT_FUNCTION(2, "PWM5"),
+		MT_FUNCTION(3, "CLKM3"),
+		MT_FUNCTION(4, "GPU_JTRSTB"),
+		MT_FUNCTION(5, "USB_TEST_IO[23]"),
+		MT_FUNCTION(6, "TESTB_OUT26"),
+		MT_FUNCTION(7, "A_FUNC_DIN[24]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(110, "EINT6"),
+		"V5", "mt8135",
+		MT_FUNCTION(0, "GPIO110"),
+		MT_FUNCTION_IRQ(1, "EINT6", 6),
+		MT_FUNCTION(2, "PWM6"),
+		MT_FUNCTION(3, "CLKM4"),
+		MT_FUNCTION(4, "GPU_JTMS"),
+		MT_FUNCTION(5, "USB_TEST_IO[24]"),
+		MT_FUNCTION(6, "TESTB_OUT27"),
+		MT_FUNCTION(7, "A_FUNC_DIN[25]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(111, "EINT7"),
+		"W3", "mt8135",
+		MT_FUNCTION(0, "GPIO111"),
+		MT_FUNCTION_IRQ(1, "EINT7", 7),
+		MT_FUNCTION(2, "PWM7"),
+		MT_FUNCTION(3, "CLKM5"),
+		MT_FUNCTION(4, "GPU_JTDO"),
+		MT_FUNCTION(5, "USB_TEST_IO[25]"),
+		MT_FUNCTION(6, "TESTB_OUT28"),
+		MT_FUNCTION(7, "A_FUNC_DIN[26]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(112, "EINT8"),
+		"V6", "mt8135",
+		MT_FUNCTION(0, "GPIO112"),
+		MT_FUNCTION_IRQ(1, "EINT8", 8),
+		MT_FUNCTION(2, "DISP_PWM"),
+		MT_FUNCTION(3, "CLKM6"),
+		MT_FUNCTION(4, "GPU_JTDI"),
+		MT_FUNCTION(5, "USB_TEST_IO[26]"),
+		MT_FUNCTION(6, "TESTB_OUT29"),
+		MT_FUNCTION(7, "EXT_FRAME_SYNC")
+	),
+	MT_PIN(
+		PINCTRL_PIN(113, "EINT9"),
+		"W8", "mt8135",
+		MT_FUNCTION(0, "GPIO113"),
+		MT_FUNCTION_IRQ(1, "EINT9", 9),
+		MT_FUNCTION(2, NULL),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "GPU_JTCK"),
+		MT_FUNCTION(5, "USB_DRVVBUS"),
+		MT_FUNCTION(6, "TESTB_OUT30"),
+		MT_FUNCTION(7, "A_FUNC_DIN[27]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(114, "LPCE1B"),
+		"W4", "mt8135",
+		MT_FUNCTION(0, "GPIO114"),
+		MT_FUNCTION(1, "LPCE1B"),
+		MT_FUNCTION_IRQ(2, "EINT127", 127),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "PWM2"),
+		MT_FUNCTION(6, "TESTB_OUT14"),
+		MT_FUNCTION(7, "A_FUNC_DIN[28]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(115, "LPCE0B"),
+		"T5", "mt8135",
+		MT_FUNCTION(0, "GPIO115"),
+		MT_FUNCTION(1, "LPCE0B"),
+		MT_FUNCTION_IRQ(2, "EINT126", 126),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "PWM1"),
+		MT_FUNCTION(6, "TESTB_OUT15"),
+		MT_FUNCTION(7, "A_FUNC_DIN[29]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(116, "DISP_PWM"),
+		"V4", "mt8135",
+		MT_FUNCTION(0, "GPIO116"),
+		MT_FUNCTION(1, "DISP_PWM"),
+		MT_FUNCTION_IRQ(2, "EINT77", 77),
+		MT_FUNCTION(3, "LSDI"),
+		MT_FUNCTION(4, "PWM1"),
+		MT_FUNCTION(5, "PWM2"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "PWM3")
+	),
+	MT_PIN(
+		PINCTRL_PIN(117, "EINT1"),
+		"T6", "mt8135",
+		MT_FUNCTION(0, "GPIO117"),
+		MT_FUNCTION_IRQ(1, "EINT1", 1),
+		MT_FUNCTION(2, "PWM2"),
+		MT_FUNCTION(3, "CLKM1"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[13]"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "USB_SDA")
+	),
+	MT_PIN(
+		PINCTRL_PIN(118, "EINT2"),
+		"T4", "mt8135",
+		MT_FUNCTION(0, "GPIO118"),
+		MT_FUNCTION_IRQ(1, "EINT2", 2),
+		MT_FUNCTION(2, "PWM3"),
+		MT_FUNCTION(3, "CLKM2"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[14]"),
+		MT_FUNCTION(6, "SRCLKENAI2"),
+		MT_FUNCTION(7, "A_FUNC_DIN[30]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(119, "EINT3"),
+		"R4", "mt8135",
+		MT_FUNCTION(0, "GPIO119"),
+		MT_FUNCTION_IRQ(1, "EINT3", 3),
+		MT_FUNCTION(2, NULL),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_TEST_IO[15]"),
+		MT_FUNCTION(6, "SRCLKENAI1"),
+		MT_FUNCTION(7, "EXT_26M_CK")
+	),
+	MT_PIN(
+		PINCTRL_PIN(120, "EINT4"),
+		"R5", "mt8135",
+		MT_FUNCTION(0, "GPIO120"),
+		MT_FUNCTION_IRQ(1, "EINT4", 4),
+		MT_FUNCTION(2, "PWM4"),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "USB_DRVVBUS"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "A_FUNC_DIN[31]")
+	),
+	MT_PIN(
+		PINCTRL_PIN(121, "DPIDE"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO121"),
+		MT_FUNCTION(1, "DPI0_DE"),
+		MT_FUNCTION_IRQ(2, "EINT100", 100),
+		MT_FUNCTION(3, "I2SOUT_DAT"),
+		MT_FUNCTION(4, "DAC_DAT_OUT"),
+		MT_FUNCTION(5, "PCM1_DO"),
+		MT_FUNCTION(6, "IRDA_TXD"),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(122, "DPICK"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO122"),
+		MT_FUNCTION(1, "DPI0_CK"),
+		MT_FUNCTION_IRQ(2, "EINT101", 101),
+		MT_FUNCTION(3, "I2SIN_DAT"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "PCM1_DI"),
+		MT_FUNCTION(6, "IRDA_PDN"),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(123, "DPIG4"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO123"),
+		MT_FUNCTION(1, "DPI0_G4"),
+		MT_FUNCTION_IRQ(2, "EINT114", 114),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2DAT_2X[0]"),
+		MT_FUNCTION(5, "DSP2_ID"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(124, "DPIG5"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO124"),
+		MT_FUNCTION(1, "DPI0_G5"),
+		MT_FUNCTION_IRQ(2, "EINT115", 115),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2DAT_2X[1]"),
+		MT_FUNCTION(5, "DSP2_ICK"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(125, "DPIR3"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO125"),
+		MT_FUNCTION(1, "DPI0_R3"),
+		MT_FUNCTION_IRQ(2, "EINT121", 121),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2DAT_2X[7]"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(126, "DPIG1"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO126"),
+		MT_FUNCTION(1, "DPI0_G1"),
+		MT_FUNCTION_IRQ(2, "EINT111", 111),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "DSP1_ICK"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(127, "DPIVSYNC"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO127"),
+		MT_FUNCTION(1, "DPI0_VSYNC"),
+		MT_FUNCTION_IRQ(2, "EINT98", 98),
+		MT_FUNCTION(3, "I2SIN_CK"),
+		MT_FUNCTION(4, "DAC_CK"),
+		MT_FUNCTION(5, "PCM1_CK"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(128, "DPIHSYNC"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO128"),
+		MT_FUNCTION(1, "DPI0_HSYNC"),
+		MT_FUNCTION_IRQ(2, "EINT99", 99),
+		MT_FUNCTION(3, "I2SIN_WS"),
+		MT_FUNCTION(4, "DAC_WS"),
+		MT_FUNCTION(5, "PCM1_WS"),
+		MT_FUNCTION(6, "IRDA_RXD"),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(129, "DPIB0"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO129"),
+		MT_FUNCTION(1, "DPI0_B0"),
+		MT_FUNCTION_IRQ(2, "EINT102", 102),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "SCL0"),
+		MT_FUNCTION(5, "DISP_PWM"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(130, "DPIB1"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO130"),
+		MT_FUNCTION(1, "DPI0_B1"),
+		MT_FUNCTION_IRQ(2, "EINT103", 103),
+		MT_FUNCTION(3, "CLKM0"),
+		MT_FUNCTION(4, "SDA0"),
+		MT_FUNCTION(5, "PWM1"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(131, "DPIB2"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO131"),
+		MT_FUNCTION(1, "DPI0_B2"),
+		MT_FUNCTION_IRQ(2, "EINT104", 104),
+		MT_FUNCTION(3, "CLKM1"),
+		MT_FUNCTION(4, "SCL1"),
+		MT_FUNCTION(5, "PWM2"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(132, "DPIB3"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO132"),
+		MT_FUNCTION(1, "DPI0_B3"),
+		MT_FUNCTION_IRQ(2, "EINT105", 105),
+		MT_FUNCTION(3, "CLKM2"),
+		MT_FUNCTION(4, "SDA1"),
+		MT_FUNCTION(5, "PWM3"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(133, "DPIB4"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO133"),
+		MT_FUNCTION(1, "DPI0_B4"),
+		MT_FUNCTION_IRQ(2, "EINT106", 106),
+		MT_FUNCTION(3, "CLKM3"),
+		MT_FUNCTION(4, "SCL2"),
+		MT_FUNCTION(5, "PWM4"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(134, "DPIB5"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO134"),
+		MT_FUNCTION(1, "DPI0_B5"),
+		MT_FUNCTION_IRQ(2, "EINT107", 107),
+		MT_FUNCTION(3, "CLKM4"),
+		MT_FUNCTION(4, "SDA2"),
+		MT_FUNCTION(5, "PWM5"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(135, "DPIB6"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO135"),
+		MT_FUNCTION(1, "DPI0_B6"),
+		MT_FUNCTION_IRQ(2, "EINT108", 108),
+		MT_FUNCTION(3, "CLKM5"),
+		MT_FUNCTION(4, "SCL3"),
+		MT_FUNCTION(5, "PWM6"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(136, "DPIB7"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO136"),
+		MT_FUNCTION(1, "DPI0_B7"),
+		MT_FUNCTION_IRQ(2, "EINT109", 109),
+		MT_FUNCTION(3, "CLKM6"),
+		MT_FUNCTION(4, "SDA3"),
+		MT_FUNCTION(5, "PWM7"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(137, "DPIG0"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO137"),
+		MT_FUNCTION(1, "DPI0_G0"),
+		MT_FUNCTION_IRQ(2, "EINT110", 110),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "DSP1_ID"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(138, "DPIG2"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO138"),
+		MT_FUNCTION(1, "DPI0_G2"),
+		MT_FUNCTION_IRQ(2, "EINT112", 112),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "DSP1_IMS"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(139, "DPIG3"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO139"),
+		MT_FUNCTION(1, "DPI0_G3"),
+		MT_FUNCTION_IRQ(2, "EINT113", 113),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "DSP2_IMS"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(140, "DPIG6"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO140"),
+		MT_FUNCTION(1, "DPI0_G6"),
+		MT_FUNCTION_IRQ(2, "EINT116", 116),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2DAT_2X[2]"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(141, "DPIG7"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO141"),
+		MT_FUNCTION(1, "DPI0_G7"),
+		MT_FUNCTION_IRQ(2, "EINT117", 117),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2DAT_2X[3]"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(142, "DPIR0"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO142"),
+		MT_FUNCTION(1, "DPI0_R0"),
+		MT_FUNCTION_IRQ(2, "EINT118", 118),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2DAT_2X[4]"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(143, "DPIR1"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO143"),
+		MT_FUNCTION(1, "DPI0_R1"),
+		MT_FUNCTION_IRQ(2, "EINT119", 119),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2DAT_2X[5]"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(144, "DPIR2"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO144"),
+		MT_FUNCTION(1, "DPI0_R2"),
+		MT_FUNCTION_IRQ(2, "EINT120", 120),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2DAT_2X[6]"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(145, "DPIR4"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO145"),
+		MT_FUNCTION(1, "DPI0_R4"),
+		MT_FUNCTION_IRQ(2, "EINT122", 122),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2DAT_2X[8]"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(146, "DPIR5"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO146"),
+		MT_FUNCTION(1, "DPI0_R5"),
+		MT_FUNCTION_IRQ(2, "EINT123", 123),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2DAT_2X[9]"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(147, "DPIR6"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO147"),
+		MT_FUNCTION(1, "DPI0_R6"),
+		MT_FUNCTION_IRQ(2, "EINT124", 124),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2VSYNC_2X"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(148, "DPIR7"),
+		NULL, "mt8135",
+		MT_FUNCTION(0, "GPIO148"),
+		MT_FUNCTION(1, "DPI0_R7"),
+		MT_FUNCTION_IRQ(2, "EINT125", 125),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, "CM2HSYNC_2X"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(149, "TDN3/LVDS(TDN3)"),
+		"AA2", "mt8135",
+		MT_FUNCTION(0, "GPIO149"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT36", 36),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(150, "TDP3/LVDS(TDP3)"),
+		"AA1", "mt8135",
+		MT_FUNCTION(0, "GPIO150"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT35", 35),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(151, "TDN2/LVDS(TCN)"),
+		"Y2", "mt8135",
+		MT_FUNCTION(0, "GPIO151"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT169", 169),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(152, "TDP2/LVDS(TCP)"),
+		"Y1", "mt8135",
+		MT_FUNCTION(0, "GPIO152"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT168", 168),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(153, "TCN/LVDS(TDN2)"),
+		"W2", "mt8135",
+		MT_FUNCTION(0, "GPIO153"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT163", 163),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(154, "TCP/LVDS(TDP2)"),
+		"W1", "mt8135",
+		MT_FUNCTION(0, "GPIO154"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT162", 162),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(155, "TDN1/LVDS(TDN1)"),
+		"V3", "mt8135",
+		MT_FUNCTION(0, "GPIO155"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT167", 167),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(156, "TDP1/LVDS(TDP1)"),
+		"V2", "mt8135",
+		MT_FUNCTION(0, "GPIO156"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT166", 166),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(157, "TDN0/LVDS(TDN0)"),
+		"U3", "mt8135",
+		MT_FUNCTION(0, "GPIO157"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT165", 165),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(158, "TDP0/LVDS(TDP0)"),
+		"U2", "mt8135",
+		MT_FUNCTION(0, "GPIO158"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT164", 164),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(159, "RDN3"),
+		"N5", "mt8135",
+		MT_FUNCTION(0, "GPIO159"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT18", 18),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(160, "RDP3"),
+		"N4", "mt8135",
+		MT_FUNCTION(0, "GPIO160"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT30", 30),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(161, "RDN2"),
+		"T2", "mt8135",
+		MT_FUNCTION(0, "GPIO161"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT31", 31),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(162, "RDP2"),
+		"T3", "mt8135",
+		MT_FUNCTION(0, "GPIO162"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT32", 32),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(163, "RCN"),
+		"P2", "mt8135",
+		MT_FUNCTION(0, "GPIO163"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT33", 33),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(164, "RCP"),
+		"P3", "mt8135",
+		MT_FUNCTION(0, "GPIO164"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION_IRQ(2, "EINT39", 39),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(165, "RDN1"),
+		"R3", "mt8135",
+		MT_FUNCTION(0, "GPIO165"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION(2, NULL),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(166, "RDP1"),
+		"R2", "mt8135",
+		MT_FUNCTION(0, "GPIO166"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION(2, NULL),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(167, "RDN0"),
+		"N3", "mt8135",
+		MT_FUNCTION(0, "GPIO167"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION(2, NULL),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(168, "RDP0"),
+		"N2", "mt8135",
+		MT_FUNCTION(0, "GPIO168"),
+		MT_FUNCTION(1, NULL),
+		MT_FUNCTION(2, NULL),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(169, "RDN1_A"),
+		"M4", "mt8135",
+		MT_FUNCTION(0, "GPIO169"),
+		MT_FUNCTION(1, "CMDAT6"),
+		MT_FUNCTION_IRQ(2, "EINT175", 175),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(170, "RDP1_A"),
+		"M3", "mt8135",
+		MT_FUNCTION(0, "GPIO170"),
+		MT_FUNCTION(1, "CMDAT7"),
+		MT_FUNCTION_IRQ(2, "EINT174", 174),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(171, "RCN_A"),
+		"L3", "mt8135",
+		MT_FUNCTION(0, "GPIO171"),
+		MT_FUNCTION(1, "CMDAT8"),
+		MT_FUNCTION_IRQ(2, "EINT171", 171),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(172, "RCP_A"),
+		"L2", "mt8135",
+		MT_FUNCTION(0, "GPIO172"),
+		MT_FUNCTION(1, "CMDAT9"),
+		MT_FUNCTION_IRQ(2, "EINT170", 170),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(173, "RDN0_A"),
+		"M2", "mt8135",
+		MT_FUNCTION(0, "GPIO173"),
+		MT_FUNCTION(1, "CMHSYNC"),
+		MT_FUNCTION_IRQ(2, "EINT173", 173),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(174, "RDP0_A"),
+		"M1", "mt8135",
+		MT_FUNCTION(0, "GPIO174"),
+		MT_FUNCTION(1, "CMVSYNC"),
+		MT_FUNCTION_IRQ(2, "EINT172", 172),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(175, "RDN1_B"),
+		"H2", "mt8135",
+		MT_FUNCTION(0, "GPIO175"),
+		MT_FUNCTION(1, "CMDAT2"),
+		MT_FUNCTION_IRQ(2, "EINT181", 181),
+		MT_FUNCTION(3, "CMCSD2"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(176, "RDP1_B"),
+		"H1", "mt8135",
+		MT_FUNCTION(0, "GPIO176"),
+		MT_FUNCTION(1, "CMDAT3"),
+		MT_FUNCTION_IRQ(2, "EINT180", 180),
+		MT_FUNCTION(3, "CMCSD3"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(177, "RCN_B"),
+		"K3", "mt8135",
+		MT_FUNCTION(0, "GPIO177"),
+		MT_FUNCTION(1, "CMDAT4"),
+		MT_FUNCTION_IRQ(2, "EINT177", 177),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(178, "RCP_B"),
+		"K2", "mt8135",
+		MT_FUNCTION(0, "GPIO178"),
+		MT_FUNCTION(1, "CMDAT5"),
+		MT_FUNCTION_IRQ(2, "EINT176", 176),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(179, "RDN0_B"),
+		"J3", "mt8135",
+		MT_FUNCTION(0, "GPIO179"),
+		MT_FUNCTION(1, "CMDAT0"),
+		MT_FUNCTION_IRQ(2, "EINT179", 179),
+		MT_FUNCTION(3, "CMCSD0"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(180, "RDP0_B"),
+		"J2", "mt8135",
+		MT_FUNCTION(0, "GPIO180"),
+		MT_FUNCTION(1, "CMDAT1"),
+		MT_FUNCTION_IRQ(2, "EINT178", 178),
+		MT_FUNCTION(3, "CMCSD1"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(181, "CMPCLK"),
+		"K4", "mt8135",
+		MT_FUNCTION(0, "GPIO181"),
+		MT_FUNCTION(1, "CMPCLK"),
+		MT_FUNCTION_IRQ(2, "EINT182", 182),
+		MT_FUNCTION(3, "CMCSK"),
+		MT_FUNCTION(4, "CM2MCLK_4X"),
+		MT_FUNCTION(5, "TS_AUXADC_SEL[3]"),
+		MT_FUNCTION(6, "VENC_TEST_CK"),
+		MT_FUNCTION(7, "TESTA_OUT27")
+	),
+	MT_PIN(
+		PINCTRL_PIN(182, "CMMCLK"),
+		"J5", "mt8135",
+		MT_FUNCTION(0, "GPIO182"),
+		MT_FUNCTION(1, "CMMCLK"),
+		MT_FUNCTION_IRQ(2, "EINT183", 183),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "TS_AUXADC_SEL[2]"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT28")
+	),
+	MT_PIN(
+		PINCTRL_PIN(183, "CMRST"),
+		"J6", "mt8135",
+		MT_FUNCTION(0, "GPIO183"),
+		MT_FUNCTION(1, "CMRST"),
+		MT_FUNCTION_IRQ(2, "EINT185", 185),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "TS_AUXADC_SEL[1]"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT30")
+	),
+	MT_PIN(
+		PINCTRL_PIN(184, "CMPDN"),
+		"J4", "mt8135",
+		MT_FUNCTION(0, "GPIO184"),
+		MT_FUNCTION(1, "CMPDN"),
+		MT_FUNCTION_IRQ(2, "EINT184", 184),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "TS_AUXADC_SEL[0]"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, "TESTA_OUT29")
+	),
+	MT_PIN(
+		PINCTRL_PIN(185, "CMFLASH"),
+		"G4", "mt8135",
+		MT_FUNCTION(0, "GPIO185"),
+		MT_FUNCTION(1, "CMFLASH"),
+		MT_FUNCTION_IRQ(2, "EINT186", 186),
+		MT_FUNCTION(3, "CM2MCLK_3X"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, "MFG_TEST_CK_1"),
+		MT_FUNCTION(7, "TESTA_OUT31")
+	),
+	MT_PIN(
+		PINCTRL_PIN(186, "MRG_I2S_PCM_CLK"),
+		"F5", "mt8135",
+		MT_FUNCTION(0, "GPIO186"),
+		MT_FUNCTION(1, "MRG_I2S_PCM_CLK"),
+		MT_FUNCTION_IRQ(2, "EINT14", 14),
+		MT_FUNCTION(3, "I2SIN_CK"),
+		MT_FUNCTION(4, "PCM0_CK"),
+		MT_FUNCTION(5, "DSP2_ICK"),
+		MT_FUNCTION(6, "IMG_TEST_CK"),
+		MT_FUNCTION(7, "USB_SCL")
+	),
+	MT_PIN(
+		PINCTRL_PIN(187, "MRG_I2S_PCM_SYNC"),
+		"G6", "mt8135",
+		MT_FUNCTION(0, "GPIO187"),
+		MT_FUNCTION(1, "MRG_I2S_PCM_SYNC"),
+		MT_FUNCTION_IRQ(2, "EINT16", 16),
+		MT_FUNCTION(3, "I2SIN_WS"),
+		MT_FUNCTION(4, "PCM0_WS"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, "DISP_TEST_CK"),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(188, "MRG_I2S_PCM_RX"),
+		"G3", "mt8135",
+		MT_FUNCTION(0, "GPIO188"),
+		MT_FUNCTION(1, "MRG_I2S_PCM_RX"),
+		MT_FUNCTION_IRQ(2, "EINT15", 15),
+		MT_FUNCTION(3, "I2SIN_DAT"),
+		MT_FUNCTION(4, "PCM0_DI"),
+		MT_FUNCTION(5, "DSP2_ID"),
+		MT_FUNCTION(6, "MFG_TEST_CK"),
+		MT_FUNCTION(7, "USB_SDA")
+	),
+	MT_PIN(
+		PINCTRL_PIN(189, "MRG_I2S_PCM_TX"),
+		"G5", "mt8135",
+		MT_FUNCTION(0, "GPIO189"),
+		MT_FUNCTION(1, "MRG_I2S_PCM_TX"),
+		MT_FUNCTION_IRQ(2, "EINT17", 17),
+		MT_FUNCTION(3, "I2SOUT_DAT"),
+		MT_FUNCTION(4, "PCM0_DO"),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, "VDEC_TEST_CK"),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(190, "SRCLKENAI"),
+		"K5", "mt8135",
+		MT_FUNCTION(0, "GPIO190"),
+		MT_FUNCTION(1, "SRCLKENAI"),
+		MT_FUNCTION(2, NULL),
+		MT_FUNCTION(3, NULL),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, NULL),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(191, "URXD3"),
+		"C3", "mt8135",
+		MT_FUNCTION(0, "GPIO191"),
+		MT_FUNCTION(1, "URXD3"),
+		MT_FUNCTION_IRQ(2, "EINT87", 87),
+		MT_FUNCTION(3, "UTXD3"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "TS_AUX_ST"),
+		MT_FUNCTION(6, "PWM4"),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(192, "UTXD3"),
+		"B2", "mt8135",
+		MT_FUNCTION(0, "GPIO192"),
+		MT_FUNCTION(1, "UTXD3"),
+		MT_FUNCTION_IRQ(2, "EINT86", 86),
+		MT_FUNCTION(3, "URXD3"),
+		MT_FUNCTION(4, NULL),
+		MT_FUNCTION(5, "TS_AUX_CS_B"),
+		MT_FUNCTION(6, "PWM3"),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(193, "SDA2"),
+		"G2", "mt8135",
+		MT_FUNCTION(0, "GPIO193"),
+		MT_FUNCTION(1, "SDA2"),
+		MT_FUNCTION_IRQ(2, "EINT95", 95),
+		MT_FUNCTION(3, "CLKM5"),
+		MT_FUNCTION(4, "PWM5"),
+		MT_FUNCTION(5, "TS_AUX_PWDB"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(194, "SCL2"),
+		"F4", "mt8135",
+		MT_FUNCTION(0, "GPIO194"),
+		MT_FUNCTION(1, "SCL2"),
+		MT_FUNCTION_IRQ(2, "EINT94", 94),
+		MT_FUNCTION(3, "CLKM4"),
+		MT_FUNCTION(4, "PWM4"),
+		MT_FUNCTION(5, "TS_AUXADC_TEST_CK"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(195, "SDA1"),
+		"F2", "mt8135",
+		MT_FUNCTION(0, "GPIO195"),
+		MT_FUNCTION(1, "SDA1"),
+		MT_FUNCTION_IRQ(2, "EINT93", 93),
+		MT_FUNCTION(3, "CLKM3"),
+		MT_FUNCTION(4, "PWM3"),
+		MT_FUNCTION(5, "TS_AUX_SCLK_PWDB"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(196, "SCL1"),
+		"F3", "mt8135",
+		MT_FUNCTION(0, "GPIO196"),
+		MT_FUNCTION(1, "SCL1"),
+		MT_FUNCTION_IRQ(2, "EINT92", 92),
+		MT_FUNCTION(3, "CLKM2"),
+		MT_FUNCTION(4, "PWM2"),
+		MT_FUNCTION(5, "TS_AUX_DIN"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(197, "MSDC3_DAT2"),
+		"E1", "mt8135",
+		MT_FUNCTION(0, "GPIO197"),
+		MT_FUNCTION(1, "MSDC3_DAT2"),
+		MT_FUNCTION_IRQ(2, "EINT71", 71),
+		MT_FUNCTION(3, "SCL6"),
+		MT_FUNCTION(4, "PWM5"),
+		MT_FUNCTION(5, "CLKM4"),
+		MT_FUNCTION(6, "MFG_TEST_CK_2"),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(198, "MSDC3_DAT3"),
+		"C2", "mt8135",
+		MT_FUNCTION(0, "GPIO198"),
+		MT_FUNCTION(1, "MSDC3_DAT3"),
+		MT_FUNCTION_IRQ(2, "EINT72", 72),
+		MT_FUNCTION(3, "SDA6"),
+		MT_FUNCTION(4, "PWM6"),
+		MT_FUNCTION(5, "CLKM5"),
+		MT_FUNCTION(6, "MFG_TEST_CK_3"),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(199, "MSDC3_CMD"),
+		"D2", "mt8135",
+		MT_FUNCTION(0, "GPIO199"),
+		MT_FUNCTION(1, "MSDC3_CMD"),
+		MT_FUNCTION_IRQ(2, "EINT68", 68),
+		MT_FUNCTION(3, "SDA2"),
+		MT_FUNCTION(4, "PWM2"),
+		MT_FUNCTION(5, "CLKM1"),
+		MT_FUNCTION(6, "MFG_TEST_CK_4"),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(200, "MSDC3_CLK"),
+		"E2", "mt8135",
+		MT_FUNCTION(0, "GPIO200"),
+		MT_FUNCTION(1, "MSDC3_CLK"),
+		MT_FUNCTION_IRQ(2, "EINT67", 67),
+		MT_FUNCTION(3, "SCL2"),
+		MT_FUNCTION(4, "PWM1"),
+		MT_FUNCTION(5, "CLKM0"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(201, "MSDC3_DAT1"),
+		"D3", "mt8135",
+		MT_FUNCTION(0, "GPIO201"),
+		MT_FUNCTION(1, "MSDC3_DAT1"),
+		MT_FUNCTION_IRQ(2, "EINT70", 70),
+		MT_FUNCTION(3, "SDA3"),
+		MT_FUNCTION(4, "PWM4"),
+		MT_FUNCTION(5, "CLKM3"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+	MT_PIN(
+		PINCTRL_PIN(202, "MSDC3_DAT0"),
+		"E3", "mt8135",
+		MT_FUNCTION(0, "GPIO202"),
+		MT_FUNCTION(1, "MSDC3_DAT0"),
+		MT_FUNCTION_IRQ(2, "EINT69", 69),
+		MT_FUNCTION(3, "SCL3"),
+		MT_FUNCTION(4, "PWM3"),
+		MT_FUNCTION(5, "CLKM2"),
+		MT_FUNCTION(6, NULL),
+		MT_FUNCTION(7, NULL)
+	),
+};
+
+#endif /*__PINCTRL_MTK_MT8135_H*/
diff --git a/include/dt-bindings/pinctrl/mt65xx.h b/include/dt-bindings/pinctrl/mt65xx.h
new file mode 100644
index 0000000..4c2faff
--- /dev/null
+++ b/include/dt-bindings/pinctrl/mt65xx.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Hongzhou.Yang <hongzhou.yang@mediatek.com>
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
+#ifndef _DT_BINDINGS_PINCTRL_MT65XX_H
+#define _DT_BINDINGS_PINCTRL_MT65XX_H
+
+#define MT_PIN_NO(x) ((x) << 8)
+#define MT_GET_PIN_NO(x) ((x) >> 8)
+#define MT_GET_PIN_FUNC(x) ((x) & 0xf)
+
+
+#endif /* _DT_BINDINGS_PINCTRL_MT65XX_H */
-- 
1.8.1.1.dirty
