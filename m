From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Wed, 14 Oct 2015 22:07:24 +0200
Subject: [PATCH 4/7] pinctrl: Add support STM32 MCUs
In-Reply-To: <1444853247-31114-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1444853247-31114-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1444853247-31114-5-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pinctrl and GPIO support to STMicroelectronic's STM32
family of MCUs.

While it only supports STM32F429 for now, it has been designed to enable
support of other MCUs of the family (e.g. STM32F746).

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 drivers/pinctrl/Kconfig                   |    1 +
 drivers/pinctrl/Makefile                  |    4 +-
 drivers/pinctrl/stm32/Kconfig             |   16 +
 drivers/pinctrl/stm32/Makefile            |    5 +
 drivers/pinctrl/stm32/pinctrl-stm32.c     |  856 +++++++++++++++
 drivers/pinctrl/stm32/pinctrl-stm32.h     |   43 +
 drivers/pinctrl/stm32/pinctrl-stm32f429.c | 1598 +++++++++++++++++++++++++++++
 7 files changed, 2522 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pinctrl/stm32/Kconfig
 create mode 100644 drivers/pinctrl/stm32/Makefile
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32.c
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32.h
 create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32f429.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 84dd2ed..5749cc4 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -249,6 +249,7 @@ source "drivers/pinctrl/sunxi/Kconfig"
 source "drivers/pinctrl/uniphier/Kconfig"
 source "drivers/pinctrl/vt8500/Kconfig"
 source "drivers/pinctrl/mediatek/Kconfig"
+source "drivers/pinctrl/stm32/Kconfig"
 
 config PINCTRL_XWAY
 	bool
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index cad077c..6112e91 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -51,5 +51,7 @@ obj-$(CONFIG_PINCTRL_SH_PFC)	+= sh-pfc/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_UNIPHIER)	+= uniphier/
-obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
+obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
+obj-$(CONFIG_ARCH_STM32)	+= stm32/
+
diff --git a/drivers/pinctrl/stm32/Kconfig b/drivers/pinctrl/stm32/Kconfig
new file mode 100644
index 0000000..0f28841
--- /dev/null
+++ b/drivers/pinctrl/stm32/Kconfig
@@ -0,0 +1,16 @@
+if ARCH_STM32 || COMPILE_TEST
+
+config PINCTRL_STM32
+	bool
+	depends on OF
+	select PINMUX
+	select GENERIC_PINCONF
+	select GPIOLIB
+
+config PINCTRL_STM32F429
+	bool "STMicroelectronics STM32F429 pin control" if COMPILE_TEST && !MACH_STM32F429
+	depends on OF
+	default MACH_STM32F429
+	select PINCTRL_STM32
+
+endif
diff --git a/drivers/pinctrl/stm32/Makefile b/drivers/pinctrl/stm32/Makefile
new file mode 100644
index 0000000..fc17d42
--- /dev/null
+++ b/drivers/pinctrl/stm32/Makefile
@@ -0,0 +1,5 @@
+# Core
+obj-$(CONFIG_PINCTRL_STM32) += pinctrl-stm32.o
+
+# SoC Drivers
+obj-$(CONFIG_PINCTRL_STM32F429)	+= pinctrl-stm32f429.o
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
new file mode 100644
index 0000000..4ebceaa
--- /dev/null
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -0,0 +1,856 @@
+/*
+ * Copyright (C) Maxime Coquelin 2015
+ * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
+ * License terms:  GNU General Public License (GPL), version 2
+ *
+ * Heavily based on Mediatek's pinctrl driver
+ */
+#include <linux/clk.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/pinctrl/pinctrl-stm32.h>
+
+#include "../core.h"
+#include "../pinconf.h"
+#include "../pinctrl-utils.h"
+#include "pinctrl-stm32.h"
+
+#define STM32_GPIO_MODER	0x00
+#define STM32_GPIO_TYPER	0x04
+#define STM32_GPIO_SPEEDR	0x08
+#define STM32_GPIO_PUPDR	0x0c
+#define STM32_GPIO_IDR		0x10
+#define STM32_GPIO_ODR		0x14
+#define STM32_GPIO_BSRR		0x18
+#define STM32_GPIO_LCKR		0x1c
+#define STM32_GPIO_AFRL		0x20
+#define STM32_GPIO_AFRH		0x24
+
+#define STM32_GPIO_PINS_PER_BANK 16
+
+#define gpio_range_to_bank(chip) \
+		container_of(chip, struct stm32_gpio_bank, range)
+
+#define gpio_chip_to_bank(chip) \
+		container_of(chip, struct stm32_gpio_bank, gpio_chip)
+
+static const char * const stm32_gpio_functions[] = {
+	"gpio", "af0", "af1",
+	"af2", "af3", "af4",
+	"af5", "af6", "af7",
+	"af8", "af9", "af10",
+	"af11", "af12", "af13",
+	"af14", "af15", "analog",
+};
+
+struct stm32_pinctrl_group {
+	const char *name;
+	unsigned long config;
+	unsigned pin;
+};
+
+struct stm32_gpio_bank {
+	void __iomem *base;
+	struct clk *clk;
+	spinlock_t lock;
+	struct gpio_chip gpio_chip;
+	struct pinctrl_gpio_range range;
+};
+
+struct stm32_pinctrl {
+	struct device *dev;
+	struct pinctrl_dev *pctl_dev;
+	struct pinctrl_desc pctl_desc;
+	struct stm32_pinctrl_group *groups;
+	unsigned ngroups;
+	const char **grp_names;
+	struct stm32_gpio_bank *banks;
+	unsigned nbanks;
+	const struct stm32_pinctrl_match_data *match_data;
+};
+
+static inline int stm32_gpio_pin(int gpio)
+{
+	return gpio % STM32_GPIO_PINS_PER_BANK;
+}
+
+static inline u32 stm32_gpio_get_mode(u32 function)
+{
+	switch (function) {
+	case STM32_PIN_GPIO:
+		return 0;
+	case STM32_PIN_AF(0) ... STM32_PIN_AF(15):
+		return 2;
+	case STM32_PIN_ANALOG:
+		return 3;
+	}
+
+	return 0;
+}
+
+static inline u32 stm32_gpio_get_alt(u32 function)
+{
+	switch (function) {
+	case STM32_PIN_GPIO:
+		return 0;
+	case STM32_PIN_AF(0) ... STM32_PIN_AF(15):
+		return function - 1;
+	case STM32_PIN_ANALOG:
+		return 0;
+	}
+
+	return 0;
+}
+
+/* GPIO functions */
+
+static inline void __stm32_gpio_set(struct stm32_gpio_bank *bank,
+	unsigned offset, int value)
+{
+	if (!value)
+		offset += STM32_GPIO_PINS_PER_BANK;
+
+	clk_enable(bank->clk);
+
+	writel_relaxed(BIT(offset), bank->base + STM32_GPIO_BSRR);
+
+	clk_disable(bank->clk);
+}
+
+static int stm32_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	return pinctrl_request_gpio(chip->base + offset);
+}
+
+static void stm32_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	pinctrl_free_gpio(chip->base + offset);
+}
+
+static int stm32_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct stm32_gpio_bank *bank = gpio_chip_to_bank(chip);
+	int ret;
+
+	clk_enable(bank->clk);
+
+	ret = !!(readl_relaxed(bank->base + STM32_GPIO_IDR) & BIT(offset));
+
+	clk_disable(bank->clk);
+
+	return ret;
+}
+
+static void stm32_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct stm32_gpio_bank *bank = gpio_chip_to_bank(chip);
+
+	__stm32_gpio_set(bank, offset, value);
+}
+
+static int stm32_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	return pinctrl_gpio_direction_input(chip->base + offset);
+}
+
+static int stm32_gpio_direction_output(struct gpio_chip *chip,
+	unsigned offset, int value)
+{
+	struct stm32_gpio_bank *bank = gpio_chip_to_bank(chip);
+
+	__stm32_gpio_set(bank, offset, value);
+	pinctrl_gpio_direction_output(chip->base + offset);
+
+	return 0;
+}
+
+static struct gpio_chip stm32_gpio_template = {
+	.request		= stm32_gpio_request,
+	.free			= stm32_gpio_free,
+	.get			= stm32_gpio_get,
+	.set			= stm32_gpio_set,
+	.direction_input	= stm32_gpio_direction_input,
+	.direction_output	= stm32_gpio_direction_output,
+};
+
+/* Pinctrl functions */
+
+static struct stm32_pinctrl_group *
+stm32_pctrl_find_group_by_pin(struct stm32_pinctrl *pctl, u32 pin)
+{
+	int i;
+
+	for (i = 0; i < pctl->ngroups; i++) {
+		struct stm32_pinctrl_group *grp = pctl->groups + i;
+
+		if (grp->pin == pin)
+			return grp;
+	}
+
+	return NULL;
+}
+
+static const struct stm32_desc_function *stm32_pctrl_find_function_by_pin(
+		struct stm32_pinctrl *pctl, u32 pin_num, u32 fnum)
+{
+	const struct stm32_desc_pin *pin = pctl->match_data->pins + pin_num;
+	const struct stm32_desc_function *func = pin->functions;
+
+	while (func && func->name) {
+		if (func->num == fnum)
+			return func;
+		func++;
+	}
+
+	return NULL;
+}
+
+static bool stm32_pctrl_is_function_valid(struct stm32_pinctrl *pctl,
+		u32 pin_num, u32 fnum)
+{
+	int i;
+
+	for (i = 0; i < pctl->match_data->npins; i++) {
+		const struct stm32_desc_pin *pin = pctl->match_data->pins + i;
+		const struct stm32_desc_function *func = pin->functions;
+
+		if (pin->pin.number != pin_num)
+			continue;
+
+		while (func && func->name) {
+			if (func->num == fnum)
+				return true;
+			func++;
+		}
+
+		break;
+	}
+
+	return false;
+}
+
+static int stm32_pctrl_dt_node_to_map_func(struct stm32_pinctrl *pctl,
+		u32 pin, u32 fnum, struct stm32_pinctrl_group *grp,
+		struct pinctrl_map **map, unsigned *reserved_maps,
+		unsigned *num_maps)
+{
+	if (*num_maps == *reserved_maps)
+		return -ENOSPC;
+
+	(*map)[*num_maps].type = PIN_MAP_TYPE_MUX_GROUP;
+	(*map)[*num_maps].data.mux.group = grp->name;
+
+	if (!stm32_pctrl_is_function_valid(pctl, pin, fnum)) {
+		dev_err(pctl->dev, "invalid function %d on pin %d .\n",
+				fnum, pin);
+		return -EINVAL;
+	}
+
+	(*map)[*num_maps].data.mux.function = stm32_gpio_functions[fnum];
+	(*num_maps)++;
+
+	return 0;
+}
+
+static int stm32_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
+				      struct device_node *node,
+				      struct pinctrl_map **map,
+				      unsigned *reserved_maps,
+				      unsigned *num_maps)
+{
+	struct stm32_pinctrl *pctl;
+	struct stm32_pinctrl_group *grp;
+	struct property *pins;
+	u32 pinfunc, pin, func;
+	unsigned long *configs;
+	unsigned int num_configs;
+	bool has_config = 0;
+	unsigned reserve = 0;
+	int num_pins, num_funcs, maps_per_pin, i, err;
+
+	pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	pins = of_find_property(node, "pinmux", NULL);
+	if (!pins) {
+		dev_err(pctl->dev, "missing pins property in node %s .\n",
+				node->name);
+		return -EINVAL;
+	}
+
+	err = pinconf_generic_parse_dt_config(node, pctldev, &configs,
+		&num_configs);
+	if (num_configs)
+		has_config = 1;
+
+	num_pins = pins->length / sizeof(u32);
+	num_funcs = num_pins;
+	maps_per_pin = 0;
+	if (num_funcs)
+		maps_per_pin++;
+	if (has_config && num_pins >= 1)
+		maps_per_pin++;
+
+	if (!num_pins || !maps_per_pin)
+		return -EINVAL;
+
+	reserve = num_pins * maps_per_pin;
+
+	err = pinctrl_utils_reserve_map(pctldev, map,
+			reserved_maps, num_maps, reserve);
+	if (err < 0)
+		goto fail;
+
+	for (i = 0; i < num_pins; i++) {
+		err = of_property_read_u32_index(node, "pinmux",
+				i, &pinfunc);
+		if (err)
+			goto fail;
+
+		pin = STM32_GET_PIN_NO(pinfunc);
+		func = STM32_GET_PIN_FUNC(pinfunc);
+
+		if (pin >= pctl->match_data->npins) {
+			dev_err(pctl->dev, "invalid pin number.\n");
+			err = -EINVAL;
+			goto fail;
+		}
+
+		if (!stm32_pctrl_is_function_valid(pctl, pin, func)) {
+			dev_err(pctl->dev, "invalid function.\n");
+			err = -EINVAL;
+			goto fail;
+		}
+
+		grp = stm32_pctrl_find_group_by_pin(pctl, pin);
+		if (!grp) {
+			dev_err(pctl->dev, "unable to match pin %d to group\n",
+					pin);
+			return -EINVAL;
+		}
+
+		err = stm32_pctrl_dt_node_to_map_func(pctl, pin, func, grp, map,
+				reserved_maps, num_maps);
+		if (err < 0)
+			goto fail;
+
+		if (has_config) {
+			err = pinctrl_utils_add_map_configs(pctldev, map,
+					reserved_maps, num_maps, grp->name,
+					configs, num_configs,
+					PIN_MAP_TYPE_CONFIGS_GROUP);
+			if (err < 0)
+				goto fail;
+		}
+	}
+
+	return 0;
+
+fail:
+	return err;
+}
+
+static int stm32_pctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
+				 struct device_node *np_config,
+				 struct pinctrl_map **map, unsigned *num_maps)
+{
+	struct device_node *np;
+	unsigned reserved_maps;
+	int ret;
+
+	*map = NULL;
+	*num_maps = 0;
+	reserved_maps = 0;
+
+	for_each_child_of_node(np_config, np) {
+		ret = stm32_pctrl_dt_subnode_to_map(pctldev, np, map,
+				&reserved_maps, num_maps);
+		if (ret < 0) {
+			pinctrl_utils_dt_free_map(pctldev, *map, *num_maps);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int stm32_pctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct stm32_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->ngroups;
+}
+
+static const char *stm32_pctrl_get_group_name(struct pinctrl_dev *pctldev,
+					      unsigned group)
+{
+	struct stm32_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctl->groups[group].name;
+}
+
+static int stm32_pctrl_get_group_pins(struct pinctrl_dev *pctldev,
+				      unsigned group,
+				      const unsigned **pins,
+				      unsigned *num_pins)
+{
+	struct stm32_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = (unsigned *)&pctl->groups[group].pin;
+	*num_pins = 1;
+
+	return 0;
+}
+
+static const struct pinctrl_ops stm32_pctrl_ops = {
+	.dt_node_to_map		= stm32_pctrl_dt_node_to_map,
+	.dt_free_map		= pinctrl_utils_dt_free_map,
+	.get_groups_count	= stm32_pctrl_get_groups_count,
+	.get_group_name		= stm32_pctrl_get_group_name,
+	.get_group_pins		= stm32_pctrl_get_group_pins,
+};
+
+
+/* Pinmux functions */
+
+static int stm32_pmx_get_funcs_cnt(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(stm32_gpio_functions);
+}
+
+static const char *stm32_pmx_get_func_name(struct pinctrl_dev *pctldev,
+					   unsigned selector)
+{
+	return stm32_gpio_functions[selector];
+}
+
+static int stm32_pmx_get_func_groups(struct pinctrl_dev *pctldev,
+				     unsigned function,
+				     const char * const **groups,
+				     unsigned * const num_groups)
+{
+	struct stm32_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = pctl->grp_names;
+	*num_groups = pctl->ngroups;
+
+	return 0;
+}
+
+static void stm32_pmx_set_mode(struct stm32_gpio_bank *bank,
+		int pin, u32 mode, u32 alt)
+{
+	u32 val;
+	int alt_shift = (pin % 8) * 4;
+	int alt_offset = STM32_GPIO_AFRL + (pin / 8) * 4;
+	unsigned long flags;
+
+	clk_enable(bank->clk);
+	spin_lock_irqsave(&bank->lock, flags);
+
+	val = readl_relaxed(bank->base + alt_offset);
+	val &= ~GENMASK(alt_shift + 3, alt_shift);
+	val |= (alt << alt_shift);
+	writel_relaxed(val, bank->base + alt_offset);
+
+	val = readl_relaxed(bank->base + STM32_GPIO_MODER);
+	val &= ~GENMASK(pin * 2 + 1, pin * 2);
+	val |= mode << (pin * 2);
+	writel_relaxed(val, bank->base + STM32_GPIO_MODER);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+	clk_disable(bank->clk);
+}
+
+static int stm32_pmx_set_mux(struct pinctrl_dev *pctldev,
+			    unsigned function,
+			    unsigned group)
+{
+	bool ret;
+	const struct stm32_desc_function *desc;
+	struct stm32_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct stm32_pinctrl_group *g = pctl->groups + group;
+	struct pinctrl_gpio_range *range;
+	struct stm32_gpio_bank *bank;
+	u32 mode, alt;
+	int pin;
+
+	ret = stm32_pctrl_is_function_valid(pctl, g->pin, function);
+	if (!ret) {
+		dev_err(pctl->dev, "invalid function %d on group %d .\n",
+				function, group);
+		return -EINVAL;
+	}
+
+	desc = stm32_pctrl_find_function_by_pin(pctl, g->pin, function);
+	if (!desc)
+		return -EINVAL;
+
+	range = pinctrl_find_gpio_range_from_pin(pctldev, g->pin);
+	bank = gpio_range_to_bank(range);
+	pin = stm32_gpio_pin(g->pin);
+
+	mode = stm32_gpio_get_mode(function);
+	alt = stm32_gpio_get_alt(function);
+
+	stm32_pmx_set_mode(bank, pin, mode, alt);
+
+	return 0;
+}
+
+static int stm32_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
+			struct pinctrl_gpio_range *range, unsigned gpio,
+			bool input)
+{
+	struct stm32_gpio_bank *bank = gpio_range_to_bank(range);
+	int pin = stm32_gpio_pin(gpio);
+
+	stm32_pmx_set_mode(bank, pin, !input, 0);
+
+	return 0;
+}
+
+static const struct pinmux_ops stm32_pmx_ops = {
+	.get_functions_count	= stm32_pmx_get_funcs_cnt,
+	.get_function_name	= stm32_pmx_get_func_name,
+	.get_function_groups	= stm32_pmx_get_func_groups,
+	.set_mux		= stm32_pmx_set_mux,
+	.gpio_set_direction	= stm32_pmx_gpio_set_direction,
+};
+
+/* Pinconf functions */
+
+static void stm32_pconf_set_driving(struct stm32_gpio_bank *bank,
+	unsigned offset, u32 drive)
+{
+	unsigned long flags;
+	u32 val;
+
+	clk_enable(bank->clk);
+	spin_lock_irqsave(&bank->lock, flags);
+
+	val = readl_relaxed(bank->base + STM32_GPIO_TYPER);
+	val &= ~BIT(offset);
+	val |= drive << offset;
+	writel_relaxed(val, bank->base + STM32_GPIO_TYPER);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+	clk_disable(bank->clk);
+}
+
+static void stm32_pconf_set_speed(struct stm32_gpio_bank *bank,
+	unsigned offset, u32 speed)
+{
+	unsigned long flags;
+	u32 val;
+
+	clk_enable(bank->clk);
+	spin_lock_irqsave(&bank->lock, flags);
+
+	val = readl_relaxed(bank->base + STM32_GPIO_SPEEDR);
+	val &= ~GENMASK(offset * 2 + 1, offset * 2);
+	val |= speed << (offset * 2);
+	writel_relaxed(val, bank->base + STM32_GPIO_SPEEDR);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+	clk_disable(bank->clk);
+}
+
+static void stm32_pconf_set_bias(struct stm32_gpio_bank *bank,
+	unsigned offset, u32 bias)
+{
+	unsigned long flags;
+	u32 val;
+
+	clk_enable(bank->clk);
+	spin_lock_irqsave(&bank->lock, flags);
+
+	val = readl_relaxed(bank->base + STM32_GPIO_PUPDR);
+	val &= ~GENMASK(offset * 2 + 1, offset * 2);
+	val |= bias << (offset * 2);
+	writel_relaxed(val, bank->base + STM32_GPIO_PUPDR);
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+	clk_disable(bank->clk);
+}
+
+static int stm32_pconf_parse_conf(struct pinctrl_dev *pctldev,
+		unsigned int pin, enum pin_config_param param,
+		enum pin_config_param arg)
+{
+	struct pinctrl_gpio_range *range;
+	struct stm32_gpio_bank *bank;
+	int offset, ret = 0;
+
+	range = pinctrl_find_gpio_range_from_pin(pctldev, pin);
+	bank = gpio_range_to_bank(range);
+	offset = stm32_gpio_pin(pin);
+
+	switch (param) {
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		stm32_pconf_set_driving(bank, offset, 0);
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		stm32_pconf_set_driving(bank, offset, 1);
+		break;
+	case PIN_CONFIG_SLEW_RATE:
+		stm32_pconf_set_speed(bank, offset, arg);
+		break;
+	case PIN_CONFIG_BIAS_DISABLE:
+		stm32_pconf_set_bias(bank, offset, 0);
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		stm32_pconf_set_bias(bank, offset, 1);
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		stm32_pconf_set_bias(bank, offset, 2);
+		break;
+	case PIN_CONFIG_OUTPUT:
+		__stm32_gpio_set(bank, offset, arg);
+		ret = stm32_pmx_gpio_set_direction(pctldev, NULL, pin, false);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int stm32_pconf_group_get(struct pinctrl_dev *pctldev,
+				 unsigned group,
+				 unsigned long *config)
+{
+	struct stm32_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+
+	*config = pctl->groups[group].config;
+
+	return 0;
+}
+
+static int stm32_pconf_group_set(struct pinctrl_dev *pctldev, unsigned group,
+				 unsigned long *configs, unsigned num_configs)
+{
+	struct stm32_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct stm32_pinctrl_group *g = &pctl->groups[group];
+	int i, ret;
+
+	for (i = 0; i < num_configs; i++) {
+		ret = stm32_pconf_parse_conf(pctldev, g->pin,
+			pinconf_to_config_param(configs[i]),
+			pinconf_to_config_argument(configs[i]));
+		if (ret < 0)
+			return ret;
+
+		g->config = configs[i];
+	}
+
+	return 0;
+}
+
+static const struct pinconf_ops stm32_pconf_ops = {
+	.pin_config_group_get	= stm32_pconf_group_get,
+	.pin_config_group_set	= stm32_pconf_group_set,
+};
+
+static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
+	struct device_node *np)
+{
+	int bank_nr = pctl->nbanks;
+	struct stm32_gpio_bank *bank = &pctl->banks[bank_nr];
+	struct pinctrl_gpio_range *range = &bank->range;
+	struct device *dev = pctl->dev;
+	struct resource res;
+	struct reset_control *rstc;
+	int err, npins;
+
+	rstc = of_reset_control_get(np, NULL);
+	if (!IS_ERR(rstc))
+		reset_control_deassert(rstc);
+
+	if (of_address_to_resource(np, 0, &res))
+		return -ENODEV;
+
+	bank->base = devm_ioremap_resource(dev, &res);
+	if (IS_ERR(bank->base))
+		return PTR_ERR(bank->base);
+
+	bank->clk = of_clk_get_by_name(np, NULL);
+	if (IS_ERR(bank->clk)) {
+		dev_err(dev, "failed to get clk (%ld)\n", PTR_ERR(bank->clk));
+		return PTR_ERR(bank->clk);
+	}
+
+	err = clk_prepare(bank->clk);
+	if (err) {
+		dev_err(dev, "failed to prepare clk (%d)\n", err);
+		return err;
+	}
+
+	npins = pctl->match_data->npins;
+	npins -= bank_nr * STM32_GPIO_PINS_PER_BANK;
+	if (npins < 0)
+		return -EINVAL;
+	else if (npins > STM32_GPIO_PINS_PER_BANK)
+		npins = STM32_GPIO_PINS_PER_BANK;
+
+	bank->gpio_chip = stm32_gpio_template;
+	bank->gpio_chip.base = bank_nr * STM32_GPIO_PINS_PER_BANK;
+	bank->gpio_chip.ngpio = npins;
+	bank->gpio_chip.of_node = np;
+	bank->gpio_chip.dev = dev;
+	spin_lock_init(&bank->lock);
+
+	of_property_read_string(np, "st,bank-name", &range->name);
+	bank->gpio_chip.label = range->name;
+
+	range->id = bank_nr;
+	range->pin_base = range->base = range->id * STM32_GPIO_PINS_PER_BANK;
+	range->npins = bank->gpio_chip.ngpio;
+	range->gc = &bank->gpio_chip;
+	err  = gpiochip_add(&bank->gpio_chip);
+	if (err) {
+		dev_err(dev, "Failed to add gpiochip(%d)!\n", bank_nr);
+		return err;
+	}
+
+	dev_info(dev, "%s bank added\n", range->name);
+	return 0;
+}
+
+static int stm32_pctrl_build_state(struct platform_device *pdev)
+{
+	struct stm32_pinctrl *pctl = platform_get_drvdata(pdev);
+	int i;
+
+	pctl->ngroups = pctl->match_data->npins;
+
+	/* Allocate groups */
+	pctl->groups = devm_kcalloc(&pdev->dev, pctl->ngroups,
+				    sizeof(*pctl->groups), GFP_KERNEL);
+	if (!pctl->groups)
+		return -ENOMEM;
+
+	/* We assume that one pin is one group, use pin name as group name. */
+	pctl->grp_names = devm_kcalloc(&pdev->dev, pctl->ngroups,
+				       sizeof(*pctl->grp_names), GFP_KERNEL);
+	if (!pctl->grp_names)
+		return -ENOMEM;
+
+	for (i = 0; i < pctl->match_data->npins; i++) {
+		const struct stm32_desc_pin *pin = pctl->match_data->pins + i;
+		struct stm32_pinctrl_group *group = pctl->groups + i;
+
+		group->name = pin->pin.name;
+		group->pin = pin->pin.number;
+
+		pctl->grp_names[i] = pin->pin.name;
+	}
+
+	return 0;
+}
+
+int stm32_pctl_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *child;
+	const struct of_device_id *match;
+	struct device *dev = &pdev->dev;
+	struct stm32_pinctrl *pctl;
+	struct pinctrl_pin_desc *pins;
+	int i, ret, banks = 0;
+
+	if (!np)
+		return -EINVAL;
+
+	match = of_match_device(dev->driver->of_match_table, dev);
+	if (!match || !match->data)
+		return -EINVAL;
+
+	if (!of_find_property(np, "pins-are-numbered", NULL)) {
+		dev_err(dev, "only support pins-are-numbered format\n");
+		return -EINVAL;
+	}
+
+	pctl = devm_kzalloc(dev, sizeof(*pctl), GFP_KERNEL);
+	if (!pctl)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pctl);
+
+	pctl->dev = dev;
+	pctl->match_data = match->data;
+	ret = stm32_pctrl_build_state(pdev);
+	if (ret) {
+		dev_err(dev, "build state failed: %d\n", ret);
+		return -EINVAL;
+	}
+
+	for_each_child_of_node(np, child)
+		if (of_property_read_bool(child, "gpio-controller"))
+			banks++;
+
+	if (!banks) {
+		dev_err(dev, "at least one GPIO bank is required\n");
+		return -EINVAL;
+	}
+
+	pctl->banks = devm_kcalloc(dev, banks, sizeof(*pctl->banks),
+			GFP_KERNEL);
+	if (!pctl->banks)
+		return -ENOMEM;
+
+	for_each_child_of_node(np, child) {
+		if (of_property_read_bool(child, "gpio-controller")) {
+			ret = stm32_gpiolib_register_bank(pctl, child);
+			if (ret)
+				return ret;
+
+			pctl->nbanks++;
+		}
+	}
+
+	pins = devm_kcalloc(&pdev->dev, pctl->match_data->npins, sizeof(*pins),
+			    GFP_KERNEL);
+	if (!pins)
+		return -ENOMEM;
+
+	for (i = 0; i < pctl->match_data->npins; i++)
+		pins[i] = pctl->match_data->pins[i].pin;
+
+	pctl->pctl_desc.name = dev_name(&pdev->dev);
+	pctl->pctl_desc.owner = THIS_MODULE;
+	pctl->pctl_desc.pins = pins;
+	pctl->pctl_desc.npins = pctl->match_data->npins;
+	pctl->pctl_desc.confops = &stm32_pconf_ops;
+	pctl->pctl_desc.pctlops = &stm32_pctrl_ops;
+	pctl->pctl_desc.pmxops = &stm32_pmx_ops;
+	pctl->dev = &pdev->dev;
+
+	pctl->pctl_dev = pinctrl_register(&pctl->pctl_desc, &pdev->dev, pctl);
+	if (!pctl->pctl_dev) {
+		dev_err(&pdev->dev, "Failed pinctrl registration\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < pctl->nbanks; i++)
+		pinctrl_add_gpio_range(pctl->pctl_dev, &pctl->banks[i].range);
+
+	dev_info(dev, "Pinctrl STM32 initialized\n");
+
+	return 0;
+}
+
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.h b/drivers/pinctrl/stm32/pinctrl-stm32.h
new file mode 100644
index 0000000..1b7c369
--- /dev/null
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright (C) Maxime Coquelin 2015
+ * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+#ifndef __PINCTRL_STM32_H
+#define __PINCTRL_STM32_H
+
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinconf-generic.h>
+
+struct stm32_desc_function {
+	const char *name;
+	const unsigned char num;
+};
+
+struct stm32_desc_pin {
+	struct pinctrl_pin_desc pin;
+	const struct stm32_desc_function *functions;
+};
+
+#define STM32_PIN(_pin, ...)					\
+	{							\
+		.pin = _pin,					\
+		.functions = (struct stm32_desc_function[]){	\
+			__VA_ARGS__, { } },			\
+	}
+
+#define STM32_FUNCTION(_num, _name)		\
+	{							\
+		.num = _num,					\
+		.name = _name,					\
+	}
+
+struct stm32_pinctrl_match_data {
+	const struct stm32_desc_pin *pins;
+	const unsigned int npins;
+};
+
+int stm32_pctl_probe(struct platform_device *pdev);
+
+#endif /* __PINCTRL_STM32_H */
+
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32f429.c b/drivers/pinctrl/stm32/pinctrl-stm32f429.c
new file mode 100644
index 0000000..3535037
--- /dev/null
+++ b/drivers/pinctrl/stm32/pinctrl-stm32f429.c
@@ -0,0 +1,1598 @@
+/*
+ * Copyright (C) Maxime Coquelin 2015
+ * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "pinctrl-stm32.h"
+
+static const struct stm32_desc_pin stm32f429_pins[] = {
+	STM32_PIN(
+		PINCTRL_PIN(0, "PA0"),
+		STM32_FUNCTION(0, "GPIOA0"),
+		STM32_FUNCTION(2, "TIM2_CH1 TIM2_ETR"),
+		STM32_FUNCTION(3, "TIM5_CH1"),
+		STM32_FUNCTION(4, "TIM8_ETR"),
+		STM32_FUNCTION(8, "USART2_CTS"),
+		STM32_FUNCTION(9, "UART4_TX"),
+		STM32_FUNCTION(12, "ETH_MII_CRS"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(1, "PA1"),
+		STM32_FUNCTION(0, "GPIOA1"),
+		STM32_FUNCTION(2, "TIM2_CH2"),
+		STM32_FUNCTION(3, "TIM5_CH2"),
+		STM32_FUNCTION(8, "USART2_RTS"),
+		STM32_FUNCTION(9, "UART4_RX"),
+		STM32_FUNCTION(12, "ETH_MII_RX_CLK ETH_RMII_REF_CLK"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(2, "PA2"),
+		STM32_FUNCTION(0, "GPIOA2"),
+		STM32_FUNCTION(2, "TIM2_CH3"),
+		STM32_FUNCTION(3, "TIM5_CH3"),
+		STM32_FUNCTION(4, "TIM9_CH1"),
+		STM32_FUNCTION(8, "USART2_TX"),
+		STM32_FUNCTION(12, "ETH_MDIO"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(3, "PA3"),
+		STM32_FUNCTION(0, "GPIOA3"),
+		STM32_FUNCTION(2, "TIM2_CH4"),
+		STM32_FUNCTION(3, "TIM5_CH4"),
+		STM32_FUNCTION(4, "TIM9_CH2"),
+		STM32_FUNCTION(8, "USART2_RX"),
+		STM32_FUNCTION(11, "OTG_HS_ULPI_D0"),
+		STM32_FUNCTION(12, "ETH_MII_COL"),
+		STM32_FUNCTION(15, "LCD_B5"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(4, "PA4"),
+		STM32_FUNCTION(0, "GPIOA4"),
+		STM32_FUNCTION(6, "SPI1_NSS"),
+		STM32_FUNCTION(7, "SPI3_NSS I2S3_WS"),
+		STM32_FUNCTION(8, "USART2_CK"),
+		STM32_FUNCTION(13, "OTG_HS_SOF"),
+		STM32_FUNCTION(14, "DCMI_HSYNC"),
+		STM32_FUNCTION(15, "LCD_VSYNC"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(5, "PA5"),
+		STM32_FUNCTION(0, "GPIOA5"),
+		STM32_FUNCTION(2, "TIM2_CH1 TIM2_ETR"),
+		STM32_FUNCTION(4, "TIM8_CH1N"),
+		STM32_FUNCTION(6, "SPI1_SCK"),
+		STM32_FUNCTION(11, "OTG_HS_ULPI_CK"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(6, "PA6"),
+		STM32_FUNCTION(0, "GPIOA6"),
+		STM32_FUNCTION(2, "TIM1_BKIN"),
+		STM32_FUNCTION(3, "TIM3_CH1"),
+		STM32_FUNCTION(4, "TIM8_BKIN"),
+		STM32_FUNCTION(6, "SPI1_MISO"),
+		STM32_FUNCTION(10, "TIM13_CH1"),
+		STM32_FUNCTION(14, "DCMI_PIXCLK"),
+		STM32_FUNCTION(15, "LCD_G2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(7, "PA7"),
+		STM32_FUNCTION(0, "GPIOA7"),
+		STM32_FUNCTION(2, "TIM1_CH1N"),
+		STM32_FUNCTION(3, "TIM3_CH2"),
+		STM32_FUNCTION(4, "TIM8_CH1N"),
+		STM32_FUNCTION(6, "SPI1_MOSI"),
+		STM32_FUNCTION(10, "TIM14_CH1"),
+		STM32_FUNCTION(12, "ETH_MII_RX_DV ETH_RMII_CRS_DV"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(8, "PA8"),
+		STM32_FUNCTION(0, "GPIOA8"),
+		STM32_FUNCTION(1, "MCO1"),
+		STM32_FUNCTION(2, "TIM1_CH1"),
+		STM32_FUNCTION(5, "I2C3_SCL"),
+		STM32_FUNCTION(8, "USART1_CK"),
+		STM32_FUNCTION(11, "OTG_FS_SOF"),
+		STM32_FUNCTION(15, "LCD_R6"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(9, "PA9"),
+		STM32_FUNCTION(0, "GPIOA9"),
+		STM32_FUNCTION(2, "TIM1_CH2"),
+		STM32_FUNCTION(5, "I2C3_SMBA"),
+		STM32_FUNCTION(8, "USART1_TX"),
+		STM32_FUNCTION(14, "DCMI_D0"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(10, "PA10"),
+		STM32_FUNCTION(0, "GPIOA10"),
+		STM32_FUNCTION(2, "TIM1_CH3"),
+		STM32_FUNCTION(8, "USART1_RX"),
+		STM32_FUNCTION(11, "OTG_FS_ID"),
+		STM32_FUNCTION(14, "DCMI_D1"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(11, "PA11"),
+		STM32_FUNCTION(0, "GPIOA11"),
+		STM32_FUNCTION(2, "TIM1_CH4"),
+		STM32_FUNCTION(8, "USART1_CTS"),
+		STM32_FUNCTION(10, "CAN1_RX"),
+		STM32_FUNCTION(11, "OTG_FS_DM"),
+		STM32_FUNCTION(15, "LCD_R4"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(12, "PA12"),
+		STM32_FUNCTION(0, "GPIOA12"),
+		STM32_FUNCTION(2, "TIM1_ETR"),
+		STM32_FUNCTION(8, "USART1_RTS"),
+		STM32_FUNCTION(10, "CAN1_TX"),
+		STM32_FUNCTION(11, "OTG_FS_DP"),
+		STM32_FUNCTION(15, "LCD_R5"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(13, "PA13"),
+		STM32_FUNCTION(0, "GPIOA13"),
+		STM32_FUNCTION(1, "JTMS SWDIO"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(14, "PA14"),
+		STM32_FUNCTION(0, "GPIOA14"),
+		STM32_FUNCTION(1, "JTCK SWCLK"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(15, "PA15"),
+		STM32_FUNCTION(0, "GPIOA15"),
+		STM32_FUNCTION(1, "JTDI"),
+		STM32_FUNCTION(2, "TIM2_CH1 TIM2_ETR"),
+		STM32_FUNCTION(6, "SPI1_NSS"),
+		STM32_FUNCTION(7, "SPI3_NSS I2S3_WS"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(16, "PB0"),
+		STM32_FUNCTION(0, "GPIOB0"),
+		STM32_FUNCTION(2, "TIM1_CH2N"),
+		STM32_FUNCTION(3, "TIM3_CH3"),
+		STM32_FUNCTION(4, "TIM8_CH2N"),
+		STM32_FUNCTION(10, "LCD_R3"),
+		STM32_FUNCTION(11, "OTG_HS_ULPI_D1"),
+		STM32_FUNCTION(12, "ETH_MII_RXD2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(17, "PB1"),
+		STM32_FUNCTION(0, "GPIOB1"),
+		STM32_FUNCTION(2, "TIM1_CH3N"),
+		STM32_FUNCTION(3, "TIM3_CH4"),
+		STM32_FUNCTION(4, "TIM8_CH3N"),
+		STM32_FUNCTION(10, "LCD_R6"),
+		STM32_FUNCTION(11, "OTG_HS_ULPI_D2"),
+		STM32_FUNCTION(12, "ETH_MII_RXD3"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(18, "PB2"),
+		STM32_FUNCTION(0, "GPIOB2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(19, "PB3"),
+		STM32_FUNCTION(0, "GPIOB3"),
+		STM32_FUNCTION(1, "JTDO TRACESWO"),
+		STM32_FUNCTION(2, "TIM2_CH2"),
+		STM32_FUNCTION(6, "SPI1_SCK"),
+		STM32_FUNCTION(7, "SPI3_SCK I2S3_CK"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(20, "PB4"),
+		STM32_FUNCTION(0, "GPIOB4"),
+		STM32_FUNCTION(1, "NJTRST"),
+		STM32_FUNCTION(3, "TIM3_CH1"),
+		STM32_FUNCTION(6, "SPI1_MISO"),
+		STM32_FUNCTION(7, "SPI3_MISO"),
+		STM32_FUNCTION(8, "I2S3EXT_SD"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(21, "PB5"),
+		STM32_FUNCTION(0, "GPIOB5"),
+		STM32_FUNCTION(3, "TIM3_CH2"),
+		STM32_FUNCTION(5, "I2C1_SMBA"),
+		STM32_FUNCTION(6, "SPI1_MOSI"),
+		STM32_FUNCTION(7, "SPI3_MOSI I2S3_SD"),
+		STM32_FUNCTION(10, "CAN2_RX"),
+		STM32_FUNCTION(11, "OTG_HS_ULPI_D7"),
+		STM32_FUNCTION(12, "ETH_PPS_OUT"),
+		STM32_FUNCTION(13, "FMC_SDCKE1"),
+		STM32_FUNCTION(14, "DCMI_D10"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(22, "PB6"),
+		STM32_FUNCTION(0, "GPIOB6"),
+		STM32_FUNCTION(3, "TIM4_CH1"),
+		STM32_FUNCTION(5, "I2C1_SCL"),
+		STM32_FUNCTION(8, "USART1_TX"),
+		STM32_FUNCTION(10, "CAN2_TX"),
+		STM32_FUNCTION(13, "FMC_SDNE1"),
+		STM32_FUNCTION(14, "DCMI_D5"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(23, "PB7"),
+		STM32_FUNCTION(0, "GPIOB7"),
+		STM32_FUNCTION(3, "TIM4_CH2"),
+		STM32_FUNCTION(5, "I2C1_SDA"),
+		STM32_FUNCTION(8, "USART1_RX"),
+		STM32_FUNCTION(13, "FMC_NL"),
+		STM32_FUNCTION(14, "DCMI_VSYNC"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(24, "PB8"),
+		STM32_FUNCTION(0, "GPIOB8"),
+		STM32_FUNCTION(3, "TIM4_CH3"),
+		STM32_FUNCTION(4, "TIM10_CH1"),
+		STM32_FUNCTION(5, "I2C1_SCL"),
+		STM32_FUNCTION(10, "CAN1_RX"),
+		STM32_FUNCTION(12, "ETH_MII_TXD3"),
+		STM32_FUNCTION(13, "SDIO_D4"),
+		STM32_FUNCTION(14, "DCMI_D6"),
+		STM32_FUNCTION(15, "LCD_B6"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(25, "PB9"),
+		STM32_FUNCTION(0, "GPIOB9"),
+		STM32_FUNCTION(3, "TIM4_CH4"),
+		STM32_FUNCTION(4, "TIM11_CH1"),
+		STM32_FUNCTION(5, "I2C1_SDA"),
+		STM32_FUNCTION(6, "SPI2_NSS I2S2_WS"),
+		STM32_FUNCTION(10, "CAN1_TX"),
+		STM32_FUNCTION(13, "SDIO_D5"),
+		STM32_FUNCTION(14, "DCMI_D7"),
+		STM32_FUNCTION(15, "LCD_B7"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(26, "PB10"),
+		STM32_FUNCTION(0, "GPIOB10"),
+		STM32_FUNCTION(2, "TIM2_CH3"),
+		STM32_FUNCTION(5, "I2C2_SCL"),
+		STM32_FUNCTION(6, "SPI2_SCK I2S2_CK"),
+		STM32_FUNCTION(8, "USART3_TX"),
+		STM32_FUNCTION(11, "OTG_HS_ULPI_D3"),
+		STM32_FUNCTION(12, "ETH_MII_RX_ER"),
+		STM32_FUNCTION(15, "LCD_G4"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(27, "PB11"),
+		STM32_FUNCTION(0, "GPIOB11"),
+		STM32_FUNCTION(2, "TIM2_CH4"),
+		STM32_FUNCTION(5, "I2C2_SDA"),
+		STM32_FUNCTION(8, "USART3_RX"),
+		STM32_FUNCTION(11, "OTG_HS_ULPI_D4"),
+		STM32_FUNCTION(12, "ETH_MII_TX_EN ETH_RMII_TX_EN"),
+		STM32_FUNCTION(15, "LCD_G5"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(28, "PB12"),
+		STM32_FUNCTION(0, "GPIOB12"),
+		STM32_FUNCTION(2, "TIM1_BKIN"),
+		STM32_FUNCTION(5, "I2C2_SMBA"),
+		STM32_FUNCTION(6, "SPI2_NSS I2S2_WS"),
+		STM32_FUNCTION(8, "USART3_CK"),
+		STM32_FUNCTION(10, "CAN2_RX"),
+		STM32_FUNCTION(11, "OTG_HS_ULPI_D5"),
+		STM32_FUNCTION(12, "ETH_MII_TXD0 ETH_RMII_TXD0"),
+		STM32_FUNCTION(13, "OTG_HS_ID"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(29, "PB13"),
+		STM32_FUNCTION(0, "GPIOB13"),
+		STM32_FUNCTION(2, "TIM1_CH1N"),
+		STM32_FUNCTION(6, "SPI2_SCK I2S2_CK"),
+		STM32_FUNCTION(8, "USART3_CTS"),
+		STM32_FUNCTION(10, "CAN2_TX"),
+		STM32_FUNCTION(11, "OTG_HS_ULPI_D6"),
+		STM32_FUNCTION(12, "ETH_MII_TXD1 ETH_RMII_TXD1"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(30, "PB14"),
+		STM32_FUNCTION(0, "GPIOB14"),
+		STM32_FUNCTION(2, "TIM1_CH2N"),
+		STM32_FUNCTION(4, "TIM8_CH2N"),
+		STM32_FUNCTION(6, "SPI2_MISO"),
+		STM32_FUNCTION(7, "I2S2EXT_SD"),
+		STM32_FUNCTION(8, "USART3_RTS"),
+		STM32_FUNCTION(10, "TIM12_CH1"),
+		STM32_FUNCTION(13, "OTG_HS_DM"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(31, "PB15"),
+		STM32_FUNCTION(0, "GPIOB15"),
+		STM32_FUNCTION(1, "RTC_REFIN"),
+		STM32_FUNCTION(2, "TIM1_CH3N"),
+		STM32_FUNCTION(4, "TIM8_CH3N"),
+		STM32_FUNCTION(6, "SPI2_MOSI I2S2_SD"),
+		STM32_FUNCTION(10, "TIM12_CH2"),
+		STM32_FUNCTION(13, "OTG_HS_DP"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(32, "PC0"),
+		STM32_FUNCTION(0, "GPIOC0"),
+		STM32_FUNCTION(11, "OTG_HS_ULPI_STP"),
+		STM32_FUNCTION(13, "FMC_SDNWE"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(33, "PC1"),
+		STM32_FUNCTION(0, "GPIOC1"),
+		STM32_FUNCTION(12, "ETH_MDC"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(34, "PC2"),
+		STM32_FUNCTION(0, "GPIOC2"),
+		STM32_FUNCTION(6, "SPI2_MISO"),
+		STM32_FUNCTION(7, "I2S2EXT_SD"),
+		STM32_FUNCTION(11, "OTG_HS_ULPI_DIR"),
+		STM32_FUNCTION(12, "ETH_MII_TXD2"),
+		STM32_FUNCTION(13, "FMC_SDNE0"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(35, "PC3"),
+		STM32_FUNCTION(0, "GPIOC3"),
+		STM32_FUNCTION(6, "SPI2_MOSI I2S2_SD"),
+		STM32_FUNCTION(11, "OTG_HS_ULPI_NXT"),
+		STM32_FUNCTION(12, "ETH_MII_TX_CLK"),
+		STM32_FUNCTION(13, "FMC_SDCKE0"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(36, "PC4"),
+		STM32_FUNCTION(0, "GPIOC4"),
+		STM32_FUNCTION(12, "ETH_MII_RXD0 ETH_RMII_RXD0"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(37, "PC5"),
+		STM32_FUNCTION(0, "GPIOC5"),
+		STM32_FUNCTION(12, "ETH_MII_RXD1 ETH_RMII_RXD1"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(38, "PC6"),
+		STM32_FUNCTION(0, "GPIOC6"),
+		STM32_FUNCTION(3, "TIM3_CH1"),
+		STM32_FUNCTION(4, "TIM8_CH1"),
+		STM32_FUNCTION(6, "I2S2_MCK"),
+		STM32_FUNCTION(9, "USART6_TX"),
+		STM32_FUNCTION(13, "SDIO_D6"),
+		STM32_FUNCTION(14, "DCMI_D0"),
+		STM32_FUNCTION(15, "LCD_HSYNC"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(39, "PC7"),
+		STM32_FUNCTION(0, "GPIOC7"),
+		STM32_FUNCTION(3, "TIM3_CH2"),
+		STM32_FUNCTION(4, "TIM8_CH2"),
+		STM32_FUNCTION(7, "I2S3_MCK"),
+		STM32_FUNCTION(9, "USART6_RX"),
+		STM32_FUNCTION(13, "SDIO_D7"),
+		STM32_FUNCTION(14, "DCMI_D1"),
+		STM32_FUNCTION(15, "LCD_G6"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(40, "PC8"),
+		STM32_FUNCTION(0, "GPIOC8"),
+		STM32_FUNCTION(3, "TIM3_CH3"),
+		STM32_FUNCTION(4, "TIM8_CH3"),
+		STM32_FUNCTION(9, "USART6_CK"),
+		STM32_FUNCTION(13, "SDIO_D0"),
+		STM32_FUNCTION(14, "DCMI_D2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(41, "PC9"),
+		STM32_FUNCTION(0, "GPIOC9"),
+		STM32_FUNCTION(1, "MCO2"),
+		STM32_FUNCTION(3, "TIM3_CH4"),
+		STM32_FUNCTION(4, "TIM8_CH4"),
+		STM32_FUNCTION(5, "I2C3_SDA"),
+		STM32_FUNCTION(6, "I2S_CKIN"),
+		STM32_FUNCTION(13, "SDIO_D1"),
+		STM32_FUNCTION(14, "DCMI_D3"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(42, "PC10"),
+		STM32_FUNCTION(0, "GPIOC10"),
+		STM32_FUNCTION(7, "SPI3_SCK I2S3_CK"),
+		STM32_FUNCTION(8, "USART3_TX"),
+		STM32_FUNCTION(9, "UART4_TX"),
+		STM32_FUNCTION(13, "SDIO_D2"),
+		STM32_FUNCTION(14, "DCMI_D8"),
+		STM32_FUNCTION(15, "LCD_R2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(43, "PC11"),
+		STM32_FUNCTION(0, "GPIOC11"),
+		STM32_FUNCTION(6, "I2S3EXT_SD"),
+		STM32_FUNCTION(7, "SPI3_MISO"),
+		STM32_FUNCTION(8, "USART3_RX"),
+		STM32_FUNCTION(9, "UART4_RX"),
+		STM32_FUNCTION(13, "SDIO_D3"),
+		STM32_FUNCTION(14, "DCMI_D4"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(44, "PC12"),
+		STM32_FUNCTION(0, "GPIOC12"),
+		STM32_FUNCTION(7, "SPI3_MOSI I2S3_SD"),
+		STM32_FUNCTION(8, "USART3_CK"),
+		STM32_FUNCTION(9, "UART5_TX"),
+		STM32_FUNCTION(13, "SDIO_CK"),
+		STM32_FUNCTION(14, "DCMI_D9"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(45, "PC13"),
+		STM32_FUNCTION(0, "GPIOC13"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(46, "PC14"),
+		STM32_FUNCTION(0, "GPIOC14"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(47, "PC15"),
+		STM32_FUNCTION(0, "GPIOC15"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(48, "PD0"),
+		STM32_FUNCTION(0, "GPIOD0"),
+		STM32_FUNCTION(10, "CAN1_RX"),
+		STM32_FUNCTION(13, "FMC_D2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(49, "PD1"),
+		STM32_FUNCTION(0, "GPIOD1"),
+		STM32_FUNCTION(10, "CAN1_TX"),
+		STM32_FUNCTION(13, "FMC_D3"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(50, "PD2"),
+		STM32_FUNCTION(0, "GPIOD2"),
+		STM32_FUNCTION(3, "TIM3_ETR"),
+		STM32_FUNCTION(9, "UART5_RX"),
+		STM32_FUNCTION(13, "SDIO_CMD"),
+		STM32_FUNCTION(14, "DCMI_D11"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(51, "PD3"),
+		STM32_FUNCTION(0, "GPIOD3"),
+		STM32_FUNCTION(6, "SPI2_SCK I2S2_CK"),
+		STM32_FUNCTION(8, "USART2_CTS"),
+		STM32_FUNCTION(13, "FMC_CLK"),
+		STM32_FUNCTION(14, "DCMI_D5"),
+		STM32_FUNCTION(15, "LCD_G7"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(52, "PD4"),
+		STM32_FUNCTION(0, "GPIOD4"),
+		STM32_FUNCTION(8, "USART2_RTS"),
+		STM32_FUNCTION(13, "FMC_NOE"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(53, "PD5"),
+		STM32_FUNCTION(0, "GPIOD5"),
+		STM32_FUNCTION(8, "USART2_TX"),
+		STM32_FUNCTION(13, "FMC_NWE"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(54, "PD6"),
+		STM32_FUNCTION(0, "GPIOD6"),
+		STM32_FUNCTION(6, "SPI3_MOSI I2S3_SD"),
+		STM32_FUNCTION(7, "SAI1_SD_A"),
+		STM32_FUNCTION(8, "USART2_RX"),
+		STM32_FUNCTION(13, "FMC_NWAIT"),
+		STM32_FUNCTION(14, "DCMI_D10"),
+		STM32_FUNCTION(15, "LCD_B2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(55, "PD7"),
+		STM32_FUNCTION(0, "GPIOD7"),
+		STM32_FUNCTION(8, "USART2_CK"),
+		STM32_FUNCTION(13, "FMC_NE1 FMC_NCE2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(56, "PD8"),
+		STM32_FUNCTION(0, "GPIOD8"),
+		STM32_FUNCTION(8, "USART3_TX"),
+		STM32_FUNCTION(13, "FMC_D13"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(57, "PD9"),
+		STM32_FUNCTION(0, "GPIOD9"),
+		STM32_FUNCTION(8, "USART3_RX"),
+		STM32_FUNCTION(13, "FMC_D14"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(58, "PD10"),
+		STM32_FUNCTION(0, "GPIOD10"),
+		STM32_FUNCTION(8, "USART3_CK"),
+		STM32_FUNCTION(13, "FMC_D15"),
+		STM32_FUNCTION(15, "LCD_B3"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(59, "PD11"),
+		STM32_FUNCTION(0, "GPIOD11"),
+		STM32_FUNCTION(8, "USART3_CTS"),
+		STM32_FUNCTION(13, "FMC_A16"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(60, "PD12"),
+		STM32_FUNCTION(0, "GPIOD12"),
+		STM32_FUNCTION(3, "TIM4_CH1"),
+		STM32_FUNCTION(8, "USART3_RTS"),
+		STM32_FUNCTION(13, "FMC_A17"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(61, "PD13"),
+		STM32_FUNCTION(0, "GPIOD13"),
+		STM32_FUNCTION(3, "TIM4_CH2"),
+		STM32_FUNCTION(13, "FMC_A18"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(62, "PD14"),
+		STM32_FUNCTION(0, "GPIOD14"),
+		STM32_FUNCTION(3, "TIM4_CH3"),
+		STM32_FUNCTION(13, "FMC_D0"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(63, "PD15"),
+		STM32_FUNCTION(0, "GPIOD15"),
+		STM32_FUNCTION(3, "TIM4_CH4"),
+		STM32_FUNCTION(13, "FMC_D1"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(64, "PE0"),
+		STM32_FUNCTION(0, "GPIOE0"),
+		STM32_FUNCTION(3, "TIM4_ETR"),
+		STM32_FUNCTION(9, "UART8_RX"),
+		STM32_FUNCTION(13, "FMC_NBL0"),
+		STM32_FUNCTION(14, "DCMI_D2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(65, "PE1"),
+		STM32_FUNCTION(0, "GPIOE1"),
+		STM32_FUNCTION(9, "UART8_TX"),
+		STM32_FUNCTION(13, "FMC_NBL1"),
+		STM32_FUNCTION(14, "DCMI_D3"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(66, "PE2"),
+		STM32_FUNCTION(0, "GPIOE2"),
+		STM32_FUNCTION(1, "TRACECLK"),
+		STM32_FUNCTION(6, "SPI4_SCK"),
+		STM32_FUNCTION(7, "SAI1_MCLK_A"),
+		STM32_FUNCTION(12, "ETH_MII_TXD3"),
+		STM32_FUNCTION(13, "FMC_A23"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(67, "PE3"),
+		STM32_FUNCTION(0, "GPIOE3"),
+		STM32_FUNCTION(1, "TRACED0"),
+		STM32_FUNCTION(7, "SAI1_SD_B"),
+		STM32_FUNCTION(13, "FMC_A19"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(68, "PE4"),
+		STM32_FUNCTION(0, "GPIOE4"),
+		STM32_FUNCTION(1, "TRACED1"),
+		STM32_FUNCTION(6, "SPI4_NSS"),
+		STM32_FUNCTION(7, "SAI1_FS_A"),
+		STM32_FUNCTION(13, "FMC_A20"),
+		STM32_FUNCTION(14, "DCMI_D4"),
+		STM32_FUNCTION(15, "LCD_B0"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(69, "PE5"),
+		STM32_FUNCTION(0, "GPIOE5"),
+		STM32_FUNCTION(1, "TRACED2"),
+		STM32_FUNCTION(4, "TIM9_CH1"),
+		STM32_FUNCTION(6, "SPI4_MISO"),
+		STM32_FUNCTION(7, "SAI1_SCK_A"),
+		STM32_FUNCTION(13, "FMC_A21"),
+		STM32_FUNCTION(14, "DCMI_D6"),
+		STM32_FUNCTION(15, "LCD_G0"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(70, "PE6"),
+		STM32_FUNCTION(0, "GPIOE6"),
+		STM32_FUNCTION(1, "TRACED3"),
+		STM32_FUNCTION(4, "TIM9_CH2"),
+		STM32_FUNCTION(6, "SPI4_MOSI"),
+		STM32_FUNCTION(7, "SAI1_SD_A"),
+		STM32_FUNCTION(13, "FMC_A22"),
+		STM32_FUNCTION(14, "DCMI_D7"),
+		STM32_FUNCTION(15, "LCD_G1"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(71, "PE7"),
+		STM32_FUNCTION(0, "GPIOE7"),
+		STM32_FUNCTION(2, "TIM1_ETR"),
+		STM32_FUNCTION(9, "UART7_RX"),
+		STM32_FUNCTION(13, "FMC_D4"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(72, "PE8"),
+		STM32_FUNCTION(0, "GPIOE8"),
+		STM32_FUNCTION(2, "TIM1_CH1N"),
+		STM32_FUNCTION(9, "UART7_TX"),
+		STM32_FUNCTION(13, "FMC_D5"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(73, "PE9"),
+		STM32_FUNCTION(0, "GPIOE9"),
+		STM32_FUNCTION(2, "TIM1_CH1"),
+		STM32_FUNCTION(13, "FMC_D6"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(74, "PE10"),
+		STM32_FUNCTION(0, "GPIOE10"),
+		STM32_FUNCTION(2, "TIM1_CH2N"),
+		STM32_FUNCTION(13, "FMC_D7"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(75, "PE11"),
+		STM32_FUNCTION(0, "GPIOE11"),
+		STM32_FUNCTION(2, "TIM1_CH2"),
+		STM32_FUNCTION(6, "SPI4_NSS"),
+		STM32_FUNCTION(13, "FMC_D8"),
+		STM32_FUNCTION(15, "LCD_G3"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(76, "PE12"),
+		STM32_FUNCTION(0, "GPIOE12"),
+		STM32_FUNCTION(2, "TIM1_CH3N"),
+		STM32_FUNCTION(6, "SPI4_SCK"),
+		STM32_FUNCTION(13, "FMC_D9"),
+		STM32_FUNCTION(15, "LCD_B4"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(77, "PE13"),
+		STM32_FUNCTION(0, "GPIOE13"),
+		STM32_FUNCTION(2, "TIM1_CH3"),
+		STM32_FUNCTION(6, "SPI4_MISO"),
+		STM32_FUNCTION(13, "FMC_D10"),
+		STM32_FUNCTION(15, "LCD_DE"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(78, "PE14"),
+		STM32_FUNCTION(0, "GPIOE14"),
+		STM32_FUNCTION(2, "TIM1_CH4"),
+		STM32_FUNCTION(6, "SPI4_MOSI"),
+		STM32_FUNCTION(13, "FMC_D11"),
+		STM32_FUNCTION(15, "LCD_CLK"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(79, "PE15"),
+		STM32_FUNCTION(0, "GPIOE15"),
+		STM32_FUNCTION(2, "TIM1_BKIN"),
+		STM32_FUNCTION(13, "FMC_D12"),
+		STM32_FUNCTION(15, "LCD_R7"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(80, "PF0"),
+		STM32_FUNCTION(0, "GPIOF0"),
+		STM32_FUNCTION(5, "I2C2_SDA"),
+		STM32_FUNCTION(13, "FMC_A0"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(81, "PF1"),
+		STM32_FUNCTION(0, "GPIOF1"),
+		STM32_FUNCTION(5, "I2C2_SCL"),
+		STM32_FUNCTION(13, "FMC_A1"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(82, "PF2"),
+		STM32_FUNCTION(0, "GPIOF2"),
+		STM32_FUNCTION(5, "I2C2_SMBA"),
+		STM32_FUNCTION(13, "FMC_A2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(83, "PF3"),
+		STM32_FUNCTION(0, "GPIOF3"),
+		STM32_FUNCTION(13, "FMC_A3"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(84, "PF4"),
+		STM32_FUNCTION(0, "GPIOF4"),
+		STM32_FUNCTION(13, "FMC_A4"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(85, "PF5"),
+		STM32_FUNCTION(0, "GPIOF5"),
+		STM32_FUNCTION(13, "FMC_A5"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(86, "PF6"),
+		STM32_FUNCTION(0, "GPIOF6"),
+		STM32_FUNCTION(4, "TIM10_CH1"),
+		STM32_FUNCTION(6, "SPI5_NSS"),
+		STM32_FUNCTION(7, "SAI1_SD_B"),
+		STM32_FUNCTION(9, "UART7_RX"),
+		STM32_FUNCTION(13, "FMC_NIORD"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(87, "PF7"),
+		STM32_FUNCTION(0, "GPIOF7"),
+		STM32_FUNCTION(4, "TIM11_CH1"),
+		STM32_FUNCTION(6, "SPI5_SCK"),
+		STM32_FUNCTION(7, "SAI1_MCLK_B"),
+		STM32_FUNCTION(9, "UART7_TX"),
+		STM32_FUNCTION(13, "FMC_NREG"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(88, "PF8"),
+		STM32_FUNCTION(0, "GPIOF8"),
+		STM32_FUNCTION(6, "SPI5_MISO"),
+		STM32_FUNCTION(7, "SAI1_SCK_B"),
+		STM32_FUNCTION(10, "TIM13_CH1"),
+		STM32_FUNCTION(13, "FMC_NIOWR"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(89, "PF9"),
+		STM32_FUNCTION(0, "GPIOF9"),
+		STM32_FUNCTION(6, "SPI5_MOSI"),
+		STM32_FUNCTION(7, "SAI1_FS_B"),
+		STM32_FUNCTION(10, "TIM14_CH1"),
+		STM32_FUNCTION(13, "FMC_CD"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(90, "PF10"),
+		STM32_FUNCTION(0, "GPIOF10"),
+		STM32_FUNCTION(13, "FMC_INTR"),
+		STM32_FUNCTION(14, "DCMI_D11"),
+		STM32_FUNCTION(15, "LCD_DE"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(91, "PF11"),
+		STM32_FUNCTION(0, "GPIOF11"),
+		STM32_FUNCTION(6, "SPI5_MOSI"),
+		STM32_FUNCTION(13, "FMC_SDNRAS"),
+		STM32_FUNCTION(14, "DCMI_D12"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(92, "PF12"),
+		STM32_FUNCTION(0, "GPIOF12"),
+		STM32_FUNCTION(13, "FMC_A6"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(93, "PF13"),
+		STM32_FUNCTION(0, "GPIOF13"),
+		STM32_FUNCTION(13, "FMC_A7"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(94, "PF14"),
+		STM32_FUNCTION(0, "GPIOF14"),
+		STM32_FUNCTION(13, "FMC_A8"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(95, "PF15"),
+		STM32_FUNCTION(0, "GPIOF15"),
+		STM32_FUNCTION(13, "FMC_A9"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(96, "PG0"),
+		STM32_FUNCTION(0, "GPIOG0"),
+		STM32_FUNCTION(13, "FMC_A10"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(97, "PG1"),
+		STM32_FUNCTION(0, "GPIOG1"),
+		STM32_FUNCTION(13, "FMC_A11"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(98, "PG2"),
+		STM32_FUNCTION(0, "GPIOG2"),
+		STM32_FUNCTION(13, "FMC_A12"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(99, "PG3"),
+		STM32_FUNCTION(0, "GPIOG3"),
+		STM32_FUNCTION(13, "FMC_A13"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(100, "PG4"),
+		STM32_FUNCTION(0, "GPIOG4"),
+		STM32_FUNCTION(13, "FMC_A14 FMC_BA0"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(101, "PG5"),
+		STM32_FUNCTION(0, "GPIOG5"),
+		STM32_FUNCTION(13, "FMC_A15 FMC_BA1"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(102, "PG6"),
+		STM32_FUNCTION(0, "GPIOG6"),
+		STM32_FUNCTION(13, "FMC_INT2"),
+		STM32_FUNCTION(14, "DCMI_D12"),
+		STM32_FUNCTION(15, "LCD_R7"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(103, "PG7"),
+		STM32_FUNCTION(0, "GPIOG7"),
+		STM32_FUNCTION(9, "USART6_CK"),
+		STM32_FUNCTION(13, "FMC_INT3"),
+		STM32_FUNCTION(14, "DCMI_D13"),
+		STM32_FUNCTION(15, "LCD_CLK"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(104, "PG8"),
+		STM32_FUNCTION(0, "GPIOG8"),
+		STM32_FUNCTION(6, "SPI6_NSS"),
+		STM32_FUNCTION(9, "USART6_RTS"),
+		STM32_FUNCTION(12, "ETH_PPS_OUT"),
+		STM32_FUNCTION(13, "FMC_SDCLK"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(105, "PG9"),
+		STM32_FUNCTION(0, "GPIOG9"),
+		STM32_FUNCTION(9, "USART6_RX"),
+		STM32_FUNCTION(13, "FMC_NE2 FMC_NCE3"),
+		STM32_FUNCTION(14, "DCMI_VSYNC"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(106, "PG10"),
+		STM32_FUNCTION(0, "GPIOG10"),
+		STM32_FUNCTION(10, "LCD_G3"),
+		STM32_FUNCTION(13, "FMC_NCE4_1 FMC_NE3"),
+		STM32_FUNCTION(14, "DCMI_D2"),
+		STM32_FUNCTION(15, "LCD_B2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(107, "PG11"),
+		STM32_FUNCTION(0, "GPIOG11"),
+		STM32_FUNCTION(12, "ETH_MII_TX_EN ETH_RMII_TX_EN"),
+		STM32_FUNCTION(13, "FMC_NCE4_2"),
+		STM32_FUNCTION(14, "DCMI_D3"),
+		STM32_FUNCTION(15, "LCD_B3"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(108, "PG12"),
+		STM32_FUNCTION(0, "GPIOG12"),
+		STM32_FUNCTION(6, "SPI6_MISO"),
+		STM32_FUNCTION(9, "USART6_RTS"),
+		STM32_FUNCTION(10, "LCD_B4"),
+		STM32_FUNCTION(13, "FMC_NE4"),
+		STM32_FUNCTION(15, "LCD_B1"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(109, "PG13"),
+		STM32_FUNCTION(0, "GPIOG13"),
+		STM32_FUNCTION(6, "SPI6_SCK"),
+		STM32_FUNCTION(9, "USART6_CTS"),
+		STM32_FUNCTION(12, "ETH_MII_TXD0 ETH_RMII_TXD0"),
+		STM32_FUNCTION(13, "FMC_A24"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(110, "PG14"),
+		STM32_FUNCTION(0, "GPIOG14"),
+		STM32_FUNCTION(6, "SPI6_MOSI"),
+		STM32_FUNCTION(9, "USART6_TX"),
+		STM32_FUNCTION(12, "ETH_MII_TXD1 ETH_RMII_TXD1"),
+		STM32_FUNCTION(13, "FMC_A25"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(111, "PG15"),
+		STM32_FUNCTION(0, "GPIOG15"),
+		STM32_FUNCTION(9, "USART6_CTS"),
+		STM32_FUNCTION(13, "FMC_SDNCAS"),
+		STM32_FUNCTION(14, "DCMI_D13"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(112, "PH0"),
+		STM32_FUNCTION(0, "GPIOH0"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(113, "PH1"),
+		STM32_FUNCTION(0, "GPIOH1"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(114, "PH2"),
+		STM32_FUNCTION(0, "GPIOH2"),
+		STM32_FUNCTION(12, "ETH_MII_CRS"),
+		STM32_FUNCTION(13, "FMC_SDCKE0"),
+		STM32_FUNCTION(15, "LCD_R0"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(115, "PH3"),
+		STM32_FUNCTION(0, "GPIOH3"),
+		STM32_FUNCTION(12, "ETH_MII_COL"),
+		STM32_FUNCTION(13, "FMC_SDNE0"),
+		STM32_FUNCTION(15, "LCD_R1"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(116, "PH4"),
+		STM32_FUNCTION(0, "GPIOH4"),
+		STM32_FUNCTION(5, "I2C2_SCL"),
+		STM32_FUNCTION(11, "OTG_HS_ULPI_NXT"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(117, "PH5"),
+		STM32_FUNCTION(0, "GPIOH5"),
+		STM32_FUNCTION(5, "I2C2_SDA"),
+		STM32_FUNCTION(6, "SPI5_NSS"),
+		STM32_FUNCTION(13, "FMC_SDNWE"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(118, "PH6"),
+		STM32_FUNCTION(0, "GPIOH6"),
+		STM32_FUNCTION(5, "I2C2_SMBA"),
+		STM32_FUNCTION(6, "SPI5_SCK"),
+		STM32_FUNCTION(10, "TIM12_CH1"),
+		STM32_FUNCTION(12, "ETH_MII_RXD2"),
+		STM32_FUNCTION(13, "FMC_SDNE1"),
+		STM32_FUNCTION(14, "DCMI_D8"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(119, "PH7"),
+		STM32_FUNCTION(0, "GPIOH7"),
+		STM32_FUNCTION(5, "I2C3_SCL"),
+		STM32_FUNCTION(6, "SPI5_MISO"),
+		STM32_FUNCTION(12, "ETH_MII_RXD3"),
+		STM32_FUNCTION(13, "FMC_SDCKE1"),
+		STM32_FUNCTION(14, "DCMI_D9"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(120, "PH8"),
+		STM32_FUNCTION(0, "GPIOH8"),
+		STM32_FUNCTION(5, "I2C3_SDA"),
+		STM32_FUNCTION(13, "FMC_D16"),
+		STM32_FUNCTION(14, "DCMI_HSYNC"),
+		STM32_FUNCTION(15, "LCD_R2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(121, "PH9"),
+		STM32_FUNCTION(0, "GPIOH9"),
+		STM32_FUNCTION(5, "I2C3_SMBA"),
+		STM32_FUNCTION(10, "TIM12_CH2"),
+		STM32_FUNCTION(13, "FMC_D17"),
+		STM32_FUNCTION(14, "DCMI_D0"),
+		STM32_FUNCTION(15, "LCD_R3"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(122, "PH10"),
+		STM32_FUNCTION(0, "GPIOH10"),
+		STM32_FUNCTION(3, "TIM5_CH1"),
+		STM32_FUNCTION(13, "FMC_D18"),
+		STM32_FUNCTION(14, "DCMI_D1"),
+		STM32_FUNCTION(15, "LCD_R4"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(123, "PH11"),
+		STM32_FUNCTION(0, "GPIOH11"),
+		STM32_FUNCTION(3, "TIM5_CH2"),
+		STM32_FUNCTION(13, "FMC_D19"),
+		STM32_FUNCTION(14, "DCMI_D2"),
+		STM32_FUNCTION(15, "LCD_R5"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(124, "PH12"),
+		STM32_FUNCTION(0, "GPIOH12"),
+		STM32_FUNCTION(3, "TIM5_CH3"),
+		STM32_FUNCTION(13, "FMC_D20"),
+		STM32_FUNCTION(14, "DCMI_D3"),
+		STM32_FUNCTION(15, "LCD_R6"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(125, "PH13"),
+		STM32_FUNCTION(0, "GPIOH13"),
+		STM32_FUNCTION(4, "TIM8_CH1N"),
+		STM32_FUNCTION(10, "CAN1_TX"),
+		STM32_FUNCTION(13, "FMC_D21"),
+		STM32_FUNCTION(15, "LCD_G2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(126, "PH14"),
+		STM32_FUNCTION(0, "GPIOH14"),
+		STM32_FUNCTION(4, "TIM8_CH2N"),
+		STM32_FUNCTION(13, "FMC_D22"),
+		STM32_FUNCTION(14, "DCMI_D4"),
+		STM32_FUNCTION(15, "LCD_G3"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(127, "PH15"),
+		STM32_FUNCTION(0, "GPIOH15"),
+		STM32_FUNCTION(4, "TIM8_CH3N"),
+		STM32_FUNCTION(13, "FMC_D23"),
+		STM32_FUNCTION(14, "DCMI_D11"),
+		STM32_FUNCTION(15, "LCD_G4"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(128, "PI0"),
+		STM32_FUNCTION(0, "GPIOI0"),
+		STM32_FUNCTION(3, "TIM5_CH4"),
+		STM32_FUNCTION(6, "SPI2_NSS I2S2_WS"),
+		STM32_FUNCTION(13, "FMC_D24"),
+		STM32_FUNCTION(14, "DCMI_D13"),
+		STM32_FUNCTION(15, "LCD_G5"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(129, "PI1"),
+		STM32_FUNCTION(0, "GPIOI1"),
+		STM32_FUNCTION(6, "SPI2_SCK I2S2_CK"),
+		STM32_FUNCTION(13, "FMC_D25"),
+		STM32_FUNCTION(14, "DCMI_D8"),
+		STM32_FUNCTION(15, "LCD_G6"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(130, "PI2"),
+		STM32_FUNCTION(0, "GPIOI2"),
+		STM32_FUNCTION(4, "TIM8_CH4"),
+		STM32_FUNCTION(6, "SPI2_MISO"),
+		STM32_FUNCTION(7, "I2S2EXT_SD"),
+		STM32_FUNCTION(13, "FMC_D26"),
+		STM32_FUNCTION(14, "DCMI_D9"),
+		STM32_FUNCTION(15, "LCD_G7"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(131, "PI3"),
+		STM32_FUNCTION(0, "GPIOI3"),
+		STM32_FUNCTION(4, "TIM8_ETR"),
+		STM32_FUNCTION(6, "SPI2_MOSI I2S2_SD"),
+		STM32_FUNCTION(13, "FMC_D27"),
+		STM32_FUNCTION(14, "DCMI_D10"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(132, "PI4"),
+		STM32_FUNCTION(0, "GPIOI4"),
+		STM32_FUNCTION(4, "TIM8_BKIN"),
+		STM32_FUNCTION(13, "FMC_NBL2"),
+		STM32_FUNCTION(14, "DCMI_D5"),
+		STM32_FUNCTION(15, "LCD_B4"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(133, "PI5"),
+		STM32_FUNCTION(0, "GPIOI5"),
+		STM32_FUNCTION(4, "TIM8_CH1"),
+		STM32_FUNCTION(13, "FMC_NBL3"),
+		STM32_FUNCTION(14, "DCMI_VSYNC"),
+		STM32_FUNCTION(15, "LCD_B5"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(134, "PI6"),
+		STM32_FUNCTION(0, "GPIOI6"),
+		STM32_FUNCTION(4, "TIM8_CH2"),
+		STM32_FUNCTION(13, "FMC_D28"),
+		STM32_FUNCTION(14, "DCMI_D6"),
+		STM32_FUNCTION(15, "LCD_B6"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(135, "PI7"),
+		STM32_FUNCTION(0, "GPIOI7"),
+		STM32_FUNCTION(4, "TIM8_CH3"),
+		STM32_FUNCTION(13, "FMC_D29"),
+		STM32_FUNCTION(14, "DCMI_D7"),
+		STM32_FUNCTION(15, "LCD_B7"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(136, "PI8"),
+		STM32_FUNCTION(0, "GPIOI8"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(137, "PI9"),
+		STM32_FUNCTION(0, "GPIOI9"),
+		STM32_FUNCTION(10, "CAN1_RX"),
+		STM32_FUNCTION(13, "FMC_D30"),
+		STM32_FUNCTION(15, "LCD_VSYNC"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(138, "PI10"),
+		STM32_FUNCTION(0, "GPIOI10"),
+		STM32_FUNCTION(12, "ETH_MII_RX_ER"),
+		STM32_FUNCTION(13, "FMC_D31"),
+		STM32_FUNCTION(15, "LCD_HSYNC"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(139, "PI11"),
+		STM32_FUNCTION(0, "GPIOI11"),
+		STM32_FUNCTION(11, "OTG_HS_ULPI_DIR"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(140, "PI12"),
+		STM32_FUNCTION(0, "GPIOI12"),
+		STM32_FUNCTION(15, "LCD_HSYNC"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(141, "PI13"),
+		STM32_FUNCTION(0, "GPIOI13"),
+		STM32_FUNCTION(15, "LCD_VSYNC"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(142, "PI14"),
+		STM32_FUNCTION(0, "GPIOI14"),
+		STM32_FUNCTION(15, "LCD_CLK"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(143, "PI15"),
+		STM32_FUNCTION(0, "GPIOI15"),
+		STM32_FUNCTION(15, "LCD_R0"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(144, "PJ0"),
+		STM32_FUNCTION(0, "GPIOJ0"),
+		STM32_FUNCTION(15, "LCD_R1"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(145, "PJ1"),
+		STM32_FUNCTION(0, "GPIOJ1"),
+		STM32_FUNCTION(15, "LCD_R2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(146, "PJ2"),
+		STM32_FUNCTION(0, "GPIOJ2"),
+		STM32_FUNCTION(15, "LCD_R3"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(147, "PJ3"),
+		STM32_FUNCTION(0, "GPIOJ3"),
+		STM32_FUNCTION(15, "LCD_R4"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(148, "PJ4"),
+		STM32_FUNCTION(0, "GPIOJ4"),
+		STM32_FUNCTION(15, "LCD_R5"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(149, "PJ5"),
+		STM32_FUNCTION(0, "GPIOJ5"),
+		STM32_FUNCTION(15, "LCD_R6"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(150, "PJ6"),
+		STM32_FUNCTION(0, "GPIOJ6"),
+		STM32_FUNCTION(15, "LCD_R7"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(151, "PJ7"),
+		STM32_FUNCTION(0, "GPIOJ7"),
+		STM32_FUNCTION(15, "LCD_G0"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(152, "PJ8"),
+		STM32_FUNCTION(0, "GPIOJ8"),
+		STM32_FUNCTION(15, "LCD_G1"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(153, "PJ9"),
+		STM32_FUNCTION(0, "GPIOJ9"),
+		STM32_FUNCTION(15, "LCD_G2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(154, "PJ10"),
+		STM32_FUNCTION(0, "GPIOJ10"),
+		STM32_FUNCTION(15, "LCD_G3"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(155, "PJ11"),
+		STM32_FUNCTION(0, "GPIOJ11"),
+		STM32_FUNCTION(15, "LCD_G4"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(156, "PJ12"),
+		STM32_FUNCTION(0, "GPIOJ12"),
+		STM32_FUNCTION(15, "LCD_B0"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(157, "PJ13"),
+		STM32_FUNCTION(0, "GPIOJ13"),
+		STM32_FUNCTION(15, "LCD_B1"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(158, "PJ14"),
+		STM32_FUNCTION(0, "GPIOJ14"),
+		STM32_FUNCTION(15, "LCD_B2"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(159, "PJ15"),
+		STM32_FUNCTION(0, "GPIOJ15"),
+		STM32_FUNCTION(15, "LCD_B3"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(160, "PK0"),
+		STM32_FUNCTION(0, "GPIOK0"),
+		STM32_FUNCTION(15, "LCD_G5"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(161, "PK1"),
+		STM32_FUNCTION(0, "GPIOK1"),
+		STM32_FUNCTION(15, "LCD_G6"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(162, "PK2"),
+		STM32_FUNCTION(0, "GPIOK2"),
+		STM32_FUNCTION(15, "LCD_G7"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(163, "PK3"),
+		STM32_FUNCTION(0, "GPIOK3"),
+		STM32_FUNCTION(15, "LCD_B4"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(164, "PK4"),
+		STM32_FUNCTION(0, "GPIOK4"),
+		STM32_FUNCTION(15, "LCD_B5"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(165, "PK5"),
+		STM32_FUNCTION(0, "GPIOK5"),
+		STM32_FUNCTION(15, "LCD_B6"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(166, "PK6"),
+		STM32_FUNCTION(0, "GPIOK6"),
+		STM32_FUNCTION(15, "LCD_B7"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+	STM32_PIN(
+		PINCTRL_PIN(167, "PK7"),
+		STM32_FUNCTION(0, "GPIOK7"),
+		STM32_FUNCTION(15, "LCD_DE"),
+		STM32_FUNCTION(16, "EVENTOUT"),
+		STM32_FUNCTION(17, "ANALOG")
+	),
+};
+
+struct stm32_pinctrl_match_data stm32f429_match_data = {
+	.pins = stm32f429_pins,
+	.npins = ARRAY_SIZE(stm32f429_pins),
+};
+
+static const struct of_device_id stm32f429_pctrl_match[] = {
+	{
+		.compatible = "st,stm32f429-pinctrl",
+		.data = &stm32f429_match_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, stm32f429_pctrl_match);
+
+static struct platform_driver stm32f429_pinctrl_driver = {
+	.probe = stm32_pctl_probe,
+	.driver = {
+		.name = "stm32f429-pinctrl",
+		.of_match_table = stm32f429_pctrl_match,
+	},
+};
+
+static int __init stm32f429_pinctrl_init(void)
+{
+	return platform_driver_register(&stm32f429_pinctrl_driver);
+}
+
+module_init(stm32f429_pinctrl_init);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("STM32F429 Pinctrl Driver");
+MODULE_AUTHOR("Maxime Coquelin <mcoquelin.stm32@gmail.com>");
-- 
1.9.1
