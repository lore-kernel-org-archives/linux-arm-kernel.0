From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 27 Aug 2018 18:10:01 +0800
Subject: [PATCH 02/16] pinctrl: mediatek: add pinctrl-moore that implements
 the generic pinctrl dt-bindings
In-Reply-To: <cover.1535363951.git.sean.wang@mediatek.com>
References: <cover.1535363951.git.sean.wang@mediatek.com>
Message-ID: <c2edd25040c4a0868c0df02b590ed01873fed84c.1535363951.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add a generic driver pinctrl-moore.c for MT762x SoC and any other SoC
that would like to use generic dt-binding. The patch is furtherly
refactored from pinctrl-mt7622.c that totally uses the functions back by
the generic pinctrl core such as GENERIC_PINCONF, GENERIC_PINCTRL_GROUPS,
and GENERIC_PINMUX_FUNCTIONS and its binding also completely follows up
pinctrl-bindings.txt in Documentation/devicetree/bindings/pinctrl/ to
implement.

Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/Kconfig          |  19 +-
 drivers/pinctrl/mediatek/Makefile         |   3 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c  | 687 ++++++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-moore.h  |  45 ++
 drivers/pinctrl/mediatek/pinctrl-mt7622.c | 723 +-----------------------------
 5 files changed, 758 insertions(+), 719 deletions(-)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-moore.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-moore.h

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 9905dc6..f7d7a19 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -3,7 +3,7 @@ menu "MediaTek pinctrl drivers"
 
 config EINT_MTK
 	bool "MediaTek External Interrupt Support"
-	depends on PINCTRL_MTK || PINCTRL_MT7622 || COMPILE_TEST
+	depends on PINCTRL_MTK || PINCTRL_MTK_MOORE || COMPILE_TEST
 	select IRQ_DOMAIN
 
 config PINCTRL_MTK
@@ -15,6 +15,15 @@ config PINCTRL_MTK
 	select EINT_MTK
 	select OF_GPIO
 
+config PINCTRL_MTK_MOORE
+	bool "MediaTek Moore Core that implements generic binding"
+	depends on OF
+	select GENERIC_PINCONF
+	select GENERIC_PINCTRL_GROUPS
+	select GENERIC_PINMUX_FUNCTIONS
+	select GPIOLIB
+	select OF_GPIO
+
 # For ARMv7 SoCs
 config PINCTRL_MT2701
 	bool "Mediatek MT2701 pin control"
@@ -47,13 +56,9 @@ config PINCTRL_MT2712
 
 config PINCTRL_MT7622
 	bool "MediaTek MT7622 pin control"
-	depends on OF
 	depends on ARM64 || COMPILE_TEST
-	select GENERIC_PINCONF
-	select GENERIC_PINCTRL_GROUPS
-	select GENERIC_PINMUX_FUNCTIONS
-	select GPIOLIB
-	select OF_GPIO
+	depends on PINCTRL_MTK_MOORE
+	default y
 
 config PINCTRL_MT8173
 	bool "Mediatek MT8173 pin control"
diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
index e3c4ffa..911d927 100644
--- a/drivers/pinctrl/mediatek/Makefile
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -2,12 +2,13 @@
 # Core
 obj-$(CONFIG_EINT_MTK)		+= mtk-eint.o
 obj-$(CONFIG_PINCTRL_MTK)	+= pinctrl-mtk-common.o
+obj-$(CONFIG_PINCTRL_MTK_MOORE) += pinctrl-moore.o pinctrl-mtk-common-v2.o
 
 # SoC Drivers
 obj-$(CONFIG_PINCTRL_MT2701)	+= pinctrl-mt2701.o
 obj-$(CONFIG_PINCTRL_MT2712)	+= pinctrl-mt2712.o
 obj-$(CONFIG_PINCTRL_MT8135)	+= pinctrl-mt8135.o
 obj-$(CONFIG_PINCTRL_MT8127)	+= pinctrl-mt8127.o
-obj-$(CONFIG_PINCTRL_MT7622)	+= pinctrl-mtk-common-v2.o pinctrl-mt7622.o
+obj-$(CONFIG_PINCTRL_MT7622)	+= pinctrl-mt7622.o
 obj-$(CONFIG_PINCTRL_MT8173)	+= pinctrl-mt8173.o
 obj-$(CONFIG_PINCTRL_MT6397)	+= pinctrl-mt6397.o
diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
new file mode 100644
index 0000000..fef8db8
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -0,0 +1,687 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MediaTek Pinctrl Moore Driver, which implement the generic dt-binding
+ * pinctrl-bindings.txt for MediaTek SoC.
+ *
+ * Copyright (C) 2017-2018 MediaTek Inc.
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+#include "pinctrl-moore.h"
+
+#define PINCTRL_PINCTRL_DEV		KBUILD_MODNAME
+
+/* Custom pinconf parameters */
+#define MTK_PIN_CONFIG_TDSEL	(PIN_CONFIG_END + 1)
+#define MTK_PIN_CONFIG_RDSEL	(PIN_CONFIG_END + 2)
+
+static const struct pinconf_generic_params mtk_custom_bindings[] = {
+	{"mediatek,tdsel",	MTK_PIN_CONFIG_TDSEL,		0},
+	{"mediatek,rdsel",	MTK_PIN_CONFIG_RDSEL,		0},
+};
+
+#ifdef CONFIG_DEBUG_FS
+static const struct pin_config_item mtk_conf_items[] = {
+	PCONFDUMP(MTK_PIN_CONFIG_TDSEL, "tdsel", NULL, true),
+	PCONFDUMP(MTK_PIN_CONFIG_RDSEL, "rdsel", NULL, true),
+};
+#endif
+
+static int mtk_pinmux_set_mux(struct pinctrl_dev *pctldev,
+			      unsigned int selector, unsigned int group)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+	struct function_desc *func;
+	struct group_desc *grp;
+	int i;
+
+	func = pinmux_generic_get_function(pctldev, selector);
+	if (!func)
+		return -EINVAL;
+
+	grp = pinctrl_generic_get_group(pctldev, group);
+	if (!grp)
+		return -EINVAL;
+
+	dev_dbg(pctldev->dev, "enable function %s group %s\n",
+		func->name, grp->name);
+
+	for (i = 0; i < grp->num_pins; i++) {
+		int *pin_modes = grp->data;
+
+		mtk_hw_set_value(hw, grp->pins[i], PINCTRL_PIN_REG_MODE,
+				 pin_modes[i]);
+	}
+
+	return 0;
+}
+
+static int mtk_pinmux_gpio_request_enable(struct pinctrl_dev *pctldev,
+					  struct pinctrl_gpio_range *range,
+					  unsigned int pin)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+
+	return mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_MODE, MTK_GPIO_MODE);
+}
+
+static int mtk_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
+					 struct pinctrl_gpio_range *range,
+					 unsigned int pin, bool input)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+
+	/* hardware would take 0 as input direction */
+	return mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DIR, !input);
+}
+
+static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
+			   unsigned int pin, unsigned long *config)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+	u32 param = pinconf_to_config_param(*config);
+	int val, val2, err, reg, ret = 1;
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_PU, &val);
+		if (err)
+			return err;
+
+		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_PD, &val2);
+		if (err)
+			return err;
+
+		if (val || val2)
+			return -EINVAL;
+
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+	case PIN_CONFIG_SLEW_RATE:
+		reg = (param == PIN_CONFIG_BIAS_PULL_UP) ?
+		      PINCTRL_PIN_REG_PU :
+		      (param == PIN_CONFIG_BIAS_PULL_DOWN) ?
+		      PINCTRL_PIN_REG_PD : PINCTRL_PIN_REG_SR;
+
+		err = mtk_hw_get_value(hw, pin, reg, &val);
+		if (err)
+			return err;
+
+		if (!val)
+			return -EINVAL;
+
+		break;
+	case PIN_CONFIG_INPUT_ENABLE:
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_DIR, &val);
+		if (err)
+			return err;
+
+		/* HW takes input mode as zero; output mode as non-zero */
+		if ((val && param == PIN_CONFIG_INPUT_ENABLE) ||
+		    (!val && param == PIN_CONFIG_OUTPUT_ENABLE))
+			return -EINVAL;
+
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_DIR, &val);
+		if (err)
+			return err;
+
+		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_SMT, &val2);
+		if (err)
+			return err;
+
+		if (val || !val2)
+			return -EINVAL;
+
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_E4, &val);
+		if (err)
+			return err;
+
+		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_E8, &val2);
+		if (err)
+			return err;
+
+		/* 4mA when (e8, e4) = (0, 0); 8mA when (e8, e4) = (0, 1)
+		 * 12mA when (e8, e4) = (1, 0); 16mA when (e8, e4) = (1, 1)
+		 */
+		ret = ((val2 << 1) + val + 1) * 4;
+
+		break;
+	case MTK_PIN_CONFIG_TDSEL:
+	case MTK_PIN_CONFIG_RDSEL:
+		reg = (param == MTK_PIN_CONFIG_TDSEL) ?
+		       PINCTRL_PIN_REG_TDSEL : PINCTRL_PIN_REG_RDSEL;
+
+		err = mtk_hw_get_value(hw, pin, reg, &val);
+		if (err)
+			return err;
+
+		ret = val;
+
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, ret);
+
+	return 0;
+}
+
+static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
+			   unsigned long *configs, unsigned int num_configs)
+{
+	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+	u32 reg, param, arg;
+	int cfg, err = 0;
+
+	for (cfg = 0; cfg < num_configs; cfg++) {
+		param = pinconf_to_config_param(configs[cfg]);
+		arg = pinconf_to_config_argument(configs[cfg]);
+
+		switch (param) {
+		case PIN_CONFIG_BIAS_DISABLE:
+		case PIN_CONFIG_BIAS_PULL_UP:
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			arg = (param == PIN_CONFIG_BIAS_DISABLE) ? 0 :
+			       (param == PIN_CONFIG_BIAS_PULL_UP) ? 1 : 2;
+
+			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_PU,
+					       arg & 1);
+			if (err)
+				goto err;
+
+			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_PD,
+					       !!(arg & 2));
+			if (err)
+				goto err;
+			break;
+		case PIN_CONFIG_OUTPUT_ENABLE:
+			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_SMT,
+					       MTK_DISABLE);
+			if (err)
+				goto err;
+			/* else: fall through */
+		case PIN_CONFIG_INPUT_ENABLE:
+		case PIN_CONFIG_SLEW_RATE:
+			reg = (param == PIN_CONFIG_SLEW_RATE) ?
+			       PINCTRL_PIN_REG_SR : PINCTRL_PIN_REG_DIR;
+
+			arg = (param == PIN_CONFIG_INPUT_ENABLE) ? 0 :
+			      (param == PIN_CONFIG_OUTPUT_ENABLE) ? 1 : arg;
+			err = mtk_hw_set_value(hw, pin, reg, arg);
+			if (err)
+				goto err;
+
+			break;
+		case PIN_CONFIG_OUTPUT:
+			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DIR,
+					       MTK_OUTPUT);
+			if (err)
+				goto err;
+
+			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DO,
+					       arg);
+			if (err)
+				goto err;
+			break;
+		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+			/* arg = 1: Input mode & SMT enable ;
+			 * arg = 0: Output mode & SMT disable
+			 */
+			arg = arg ? 2 : 1;
+			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DIR,
+					       arg & 1);
+			if (err)
+				goto err;
+
+			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_SMT,
+					       !!(arg & 2));
+			if (err)
+				goto err;
+			break;
+		case PIN_CONFIG_DRIVE_STRENGTH:
+			/* 4mA when (e8, e4) = (0, 0);
+			 * 8mA when (e8, e4) = (0, 1);
+			 * 12mA when (e8, e4) = (1, 0);
+			 * 16mA when (e8, e4) = (1, 1)
+			 */
+			if (!(arg % 4) && (arg >= 4 && arg <= 16)) {
+				arg = arg / 4 - 1;
+				err = mtk_hw_set_value(hw, pin,
+						       PINCTRL_PIN_REG_E4,
+						       arg & 0x1);
+				if (err)
+					goto err;
+
+				err = mtk_hw_set_value(hw, pin,
+						       PINCTRL_PIN_REG_E8,
+						       (arg & 0x2) >> 1);
+				if (err)
+					goto err;
+			} else {
+				err = -ENOTSUPP;
+			}
+			break;
+		case MTK_PIN_CONFIG_TDSEL:
+		case MTK_PIN_CONFIG_RDSEL:
+			reg = (param == MTK_PIN_CONFIG_TDSEL) ?
+			       PINCTRL_PIN_REG_TDSEL : PINCTRL_PIN_REG_RDSEL;
+
+			err = mtk_hw_set_value(hw, pin, reg, arg);
+			if (err)
+				goto err;
+			break;
+		default:
+			err = -ENOTSUPP;
+		}
+	}
+err:
+	return err;
+}
+
+static int mtk_pinconf_group_get(struct pinctrl_dev *pctldev,
+				 unsigned int group, unsigned long *config)
+{
+	const unsigned int *pins;
+	unsigned int i, npins, old = 0;
+	int ret;
+
+	ret = pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < npins; i++) {
+		if (mtk_pinconf_get(pctldev, pins[i], config))
+			return -ENOTSUPP;
+
+		/* configs do not match between two pins */
+		if (i && old != *config)
+			return -ENOTSUPP;
+
+		old = *config;
+	}
+
+	return 0;
+}
+
+static int mtk_pinconf_group_set(struct pinctrl_dev *pctldev,
+				 unsigned int group, unsigned long *configs,
+				 unsigned int num_configs)
+{
+	const unsigned int *pins;
+	unsigned int i, npins;
+	int ret;
+
+	ret = pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < npins; i++) {
+		ret = mtk_pinconf_set(pctldev, pins[i], configs, num_configs);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct pinctrl_ops mtk_pctlops = {
+	.get_groups_count = pinctrl_generic_get_group_count,
+	.get_group_name = pinctrl_generic_get_group_name,
+	.get_group_pins = pinctrl_generic_get_group_pins,
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
+	.dt_free_map = pinconf_generic_dt_free_map,
+};
+
+static const struct pinmux_ops mtk_pmxops = {
+	.get_functions_count = pinmux_generic_get_function_count,
+	.get_function_name = pinmux_generic_get_function_name,
+	.get_function_groups = pinmux_generic_get_function_groups,
+	.set_mux = mtk_pinmux_set_mux,
+	.gpio_request_enable = mtk_pinmux_gpio_request_enable,
+	.gpio_set_direction = mtk_pinmux_gpio_set_direction,
+	.strict = true,
+};
+
+static const struct pinconf_ops mtk_confops = {
+	.is_generic = true,
+	.pin_config_get = mtk_pinconf_get,
+	.pin_config_set = mtk_pinconf_set,
+	.pin_config_group_get = mtk_pinconf_group_get,
+	.pin_config_group_set = mtk_pinconf_group_set,
+	.pin_config_config_dbg_show = pinconf_generic_dump_config,
+};
+
+static struct pinctrl_desc mtk_desc = {
+	.name = PINCTRL_PINCTRL_DEV,
+	.pctlops = &mtk_pctlops,
+	.pmxops = &mtk_pmxops,
+	.confops = &mtk_confops,
+	.owner = THIS_MODULE,
+};
+
+static int mtk_gpio_get(struct gpio_chip *chip, unsigned int gpio)
+{
+	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
+	int value, err;
+
+	err = mtk_hw_get_value(hw, gpio, PINCTRL_PIN_REG_DI, &value);
+	if (err)
+		return err;
+
+	return !!value;
+}
+
+static void mtk_gpio_set(struct gpio_chip *chip, unsigned int gpio, int value)
+{
+	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
+
+	mtk_hw_set_value(hw, gpio, PINCTRL_PIN_REG_DO, !!value);
+}
+
+static int mtk_gpio_direction_input(struct gpio_chip *chip, unsigned int gpio)
+{
+	return pinctrl_gpio_direction_input(chip->base + gpio);
+}
+
+static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
+				     int value)
+{
+	mtk_gpio_set(chip, gpio, value);
+
+	return pinctrl_gpio_direction_output(chip->base + gpio);
+}
+
+static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
+{
+	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
+	unsigned long eint_n;
+
+	if (!hw->eint)
+		return -ENOTSUPP;
+
+	eint_n = offset;
+
+	return mtk_eint_find_irq(hw->eint, eint_n);
+}
+
+static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
+			       unsigned long config)
+{
+	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
+	unsigned long eint_n;
+	u32 debounce;
+
+	if (!hw->eint ||
+	    pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
+		return -ENOTSUPP;
+
+	debounce = pinconf_to_config_argument(config);
+	eint_n = offset;
+
+	return mtk_eint_set_debounce(hw->eint, eint_n, debounce);
+}
+
+static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
+{
+	struct gpio_chip *chip = &hw->chip;
+	int ret;
+
+	chip->label		= PINCTRL_PINCTRL_DEV;
+	chip->parent		= hw->dev;
+	chip->request		= gpiochip_generic_request;
+	chip->free		= gpiochip_generic_free;
+	chip->direction_input	= mtk_gpio_direction_input;
+	chip->direction_output	= mtk_gpio_direction_output;
+	chip->get		= mtk_gpio_get;
+	chip->set		= mtk_gpio_set;
+	chip->to_irq		= mtk_gpio_to_irq,
+	chip->set_config	= mtk_gpio_set_config,
+	chip->base		= -1;
+	chip->ngpio		= hw->soc->npins;
+	chip->of_node		= np;
+	chip->of_gpio_n_cells	= 2;
+
+	ret = gpiochip_add_data(chip, hw);
+	if (ret < 0)
+		return ret;
+
+	/* Just for backward compatible for these old pinctrl nodes without
+	 * "gpio-ranges" property. Otherwise, called directly from a
+	 * DeviceTree-supported pinctrl driver is DEPRECATED.
+	 * Please see Section 2.1 of
+	 * Documentation/devicetree/bindings/gpio/gpio.txt on how to
+	 * bind pinctrl and gpio drivers via the "gpio-ranges" property.
+	 */
+	if (!of_find_property(np, "gpio-ranges", NULL)) {
+		ret = gpiochip_add_pin_range(chip, dev_name(hw->dev), 0, 0,
+					     chip->ngpio);
+		if (ret < 0) {
+			gpiochip_remove(chip);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int mtk_build_groups(struct mtk_pinctrl *hw)
+{
+	int err, i;
+
+	for (i = 0; i < hw->soc->ngrps; i++) {
+		const struct group_desc *group = hw->soc->grps + i;
+
+		err = pinctrl_generic_add_group(hw->pctrl, group->name,
+						group->pins, group->num_pins,
+						group->data);
+		if (err < 0) {
+			dev_err(hw->dev, "Failed to register group %s\n",
+				group->name);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int mtk_build_functions(struct mtk_pinctrl *hw)
+{
+	int i, err;
+
+	for (i = 0; i < hw->soc->nfuncs ; i++) {
+		const struct function_desc *func = hw->soc->funcs + i;
+
+		err = pinmux_generic_add_function(hw->pctrl, func->name,
+						  func->group_names,
+						  func->num_group_names,
+						  func->data);
+		if (err < 0) {
+			dev_err(hw->dev, "Failed to register function %s\n",
+				func->name);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int mtk_xt_get_gpio_n(void *data, unsigned long eint_n,
+			     unsigned int *gpio_n,
+			     struct gpio_chip **gpio_chip)
+{
+	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
+
+	*gpio_chip = &hw->chip;
+	*gpio_n = eint_n;
+
+	return 0;
+}
+
+static int mtk_xt_get_gpio_state(void *data, unsigned long eint_n)
+{
+	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
+	struct gpio_chip *gpio_chip;
+	unsigned int gpio_n;
+	int err;
+
+	err = mtk_xt_get_gpio_n(hw, eint_n, &gpio_n, &gpio_chip);
+	if (err)
+		return err;
+
+	return mtk_gpio_get(gpio_chip, gpio_n);
+}
+
+static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
+{
+	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
+	struct gpio_chip *gpio_chip;
+	unsigned int gpio_n;
+	int err;
+
+	err = mtk_xt_get_gpio_n(hw, eint_n, &gpio_n, &gpio_chip);
+	if (err)
+		return err;
+
+	err = mtk_hw_set_value(hw, gpio_n, PINCTRL_PIN_REG_MODE,
+			       MTK_GPIO_MODE);
+	if (err)
+		return err;
+
+	err = mtk_hw_set_value(hw, gpio_n, PINCTRL_PIN_REG_DIR, MTK_INPUT);
+	if (err)
+		return err;
+
+	err = mtk_hw_set_value(hw, gpio_n, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static const struct mtk_eint_xt mtk_eint_xt = {
+	.get_gpio_n = mtk_xt_get_gpio_n,
+	.get_gpio_state = mtk_xt_get_gpio_state,
+	.set_gpio_as_eint = mtk_xt_set_gpio_as_eint,
+};
+
+static int
+mtk_build_eint(struct mtk_pinctrl *hw, struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *res;
+
+	if (!IS_ENABLED(CONFIG_EINT_MTK))
+		return 0;
+
+	if (!of_property_read_bool(np, "interrupt-controller"))
+		return -ENODEV;
+
+	hw->eint = devm_kzalloc(hw->dev, sizeof(*hw->eint), GFP_KERNEL);
+	if (!hw->eint)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "eint");
+	if (!res) {
+		dev_err(&pdev->dev, "Unable to get eint resource\n");
+		return -ENODEV;
+	}
+
+	hw->eint->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(hw->eint->base))
+		return PTR_ERR(hw->eint->base);
+
+	hw->eint->irq = irq_of_parse_and_map(np, 0);
+	if (!hw->eint->irq)
+		return -EINVAL;
+
+	hw->eint->dev = &pdev->dev;
+	hw->eint->hw = hw->soc->eint_hw;
+	hw->eint->pctl = hw;
+	hw->eint->gpio_xlate = &mtk_eint_xt;
+
+	return mtk_eint_do_init(hw->eint);
+}
+
+int mtk_moore_pinctrl_probe(struct platform_device *pdev,
+			    const struct mtk_pin_soc *soc)
+{
+	struct resource *res;
+	struct mtk_pinctrl *hw;
+	int err;
+
+	hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
+	if (!hw)
+		return -ENOMEM;
+
+	hw->soc = soc;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "missing IO resource\n");
+		return -ENXIO;
+	}
+
+	hw->dev = &pdev->dev;
+	hw->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(hw->base))
+		return PTR_ERR(hw->base);
+
+	/* Setup pins descriptions per SoC types */
+	mtk_desc.pins = hw->soc->pins;
+	mtk_desc.npins = hw->soc->npins;
+	mtk_desc.num_custom_params = ARRAY_SIZE(mtk_custom_bindings);
+	mtk_desc.custom_params = mtk_custom_bindings;
+#ifdef CONFIG_DEBUG_FS
+	mtk_desc.custom_conf_items = mtk_conf_items;
+#endif
+
+	err = devm_pinctrl_register_and_init(&pdev->dev, &mtk_desc, hw,
+					     &hw->pctrl);
+	if (err)
+		return err;
+
+	/* Setup groups descriptions per SoC types */
+	err = mtk_build_groups(hw);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to build groups\n");
+		return err;
+	}
+
+	/* Setup functions descriptions per SoC types */
+	err = mtk_build_functions(hw);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to build functions\n");
+		return err;
+	}
+
+	/* For able to make pinctrl_claim_hogs, we must not enable pinctrl
+	 * until all groups and functions are being added one.
+	 */
+	err = pinctrl_enable(hw->pctrl);
+	if (err)
+		return err;
+
+	err = mtk_build_eint(hw, pdev);
+	if (err)
+		dev_warn(&pdev->dev,
+			 "Failed to add EINT, but pinctrl still can work\n");
+
+	/* Build gpiochip should be after pinctrl_enable is done */
+	err = mtk_build_gpiochip(hw, pdev->dev.of_node);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to add gpio_chip\n");
+		return err;
+	}
+
+	platform_set_drvdata(pdev, hw);
+
+	return 0;
+}
diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.h b/drivers/pinctrl/mediatek/pinctrl-moore.h
new file mode 100644
index 0000000..72cbf37
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2017-2018 MediaTek Inc.
+ *
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+#ifndef __PINCTRL_MOORE_H
+#define __PINCTRL_MOORE_H
+
+#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/regmap.h>
+
+#include "../core.h"
+#include "../pinconf.h"
+#include "../pinmux.h"
+#include "mtk-eint.h"
+#include "pinctrl-mtk-common-v2.h"
+
+#define MTK_RANGE(_a)		{ .range = (_a), .nranges = ARRAY_SIZE(_a), }
+#define PINCTRL_PIN_GROUP(name, id)			\
+	{						\
+		name,					\
+		id##_pins,				\
+		ARRAY_SIZE(id##_pins),			\
+		id##_funcs,				\
+	}
+
+int mtk_moore_pinctrl_probe(struct platform_device *pdev,
+			    const struct mtk_pin_soc *soc);
+
+#endif /* __PINCTRL_MOORE_H */
+
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index c69dfd7..224fc01 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -6,40 +6,7 @@
  *
  */
 
-#include <linux/gpio.h>
-#include <linux/gpio/driver.h>
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/mfd/syscon.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
-#include <linux/platform_device.h>
-#include <linux/pinctrl/pinctrl.h>
-#include <linux/pinctrl/pinmux.h>
-#include <linux/pinctrl/pinconf.h>
-#include <linux/pinctrl/pinconf-generic.h>
-#include <linux/regmap.h>
-
-#include "../core.h"
-#include "../pinconf.h"
-#include "../pinmux.h"
-#include "mtk-eint.h"
-#include "pinctrl-mtk-common-v2.h"
-
-#define PINCTRL_PINCTRL_DEV		KBUILD_MODNAME
-#define MTK_RANGE(_a)		{ .range = (_a), .nranges = ARRAY_SIZE(_a), }
-#define PINCTRL_PIN_GROUP(name, id)			\
-	{						\
-		name,					\
-		id##_pins,				\
-		ARRAY_SIZE(id##_pins),			\
-		id##_funcs,				\
-	}
-
-/* Custom pinconf parameters */
-#define MTK_PIN_CONFIG_TDSEL	(PIN_CONFIG_END + 1)
-#define MTK_PIN_CONFIG_RDSEL	(PIN_CONFIG_END + 2)
+#include "pinctrl-moore.h"
 
 static const struct mtk_pin_field_calc mt7622_pin_mode_range[] = {
 	{0, 0, 0x320, 0x10, 16, 4},
@@ -809,18 +776,6 @@ static const struct function_desc mt7622_functions[] = {
 	{"watchdog", mt7622_wdt_groups, ARRAY_SIZE(mt7622_wdt_groups)},
 };
 
-static const struct pinconf_generic_params mtk_custom_bindings[] = {
-	{"mediatek,tdsel",	MTK_PIN_CONFIG_TDSEL,		0},
-	{"mediatek,rdsel",	MTK_PIN_CONFIG_RDSEL,		0},
-};
-
-#ifdef CONFIG_DEBUG_FS
-static const struct pin_config_item mtk_conf_items[] = {
-	PCONFDUMP(MTK_PIN_CONFIG_TDSEL, "tdsel", NULL, true),
-	PCONFDUMP(MTK_PIN_CONFIG_RDSEL, "rdsel", NULL, true),
-};
-#endif
-
 static const struct mtk_eint_hw mt7622_eint_hw = {
 	.port_mask = 7,
 	.ports     = 7,
@@ -839,680 +794,26 @@ static const struct mtk_pin_soc mt7622_data = {
 	.eint_hw = &mt7622_eint_hw,
 };
 
-static int mtk_pinmux_set_mux(struct pinctrl_dev *pctldev,
-			      unsigned int selector, unsigned int group)
-{
-	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
-	struct function_desc *func;
-	struct group_desc *grp;
-	int i;
-
-	func = pinmux_generic_get_function(pctldev, selector);
-	if (!func)
-		return -EINVAL;
-
-	grp = pinctrl_generic_get_group(pctldev, group);
-	if (!grp)
-		return -EINVAL;
-
-	dev_dbg(pctldev->dev, "enable function %s group %s\n",
-		func->name, grp->name);
-
-	for (i = 0; i < grp->num_pins; i++) {
-		int *pin_modes = grp->data;
-
-		mtk_hw_set_value(hw, grp->pins[i], PINCTRL_PIN_REG_MODE,
-				 pin_modes[i]);
-	}
-
-	return 0;
-}
-
-static int mtk_pinmux_gpio_request_enable(struct pinctrl_dev *pctldev,
-					  struct pinctrl_gpio_range *range,
-					  unsigned int pin)
-{
-	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
-
-	return mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_MODE, MTK_GPIO_MODE);
-}
-
-static int mtk_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
-					 struct pinctrl_gpio_range *range,
-					 unsigned int pin, bool input)
-{
-	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
-
-	/* hardware would take 0 as input direction */
-	return mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DIR, !input);
-}
-
-static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
-			   unsigned int pin, unsigned long *config)
-{
-	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
-	u32 param = pinconf_to_config_param(*config);
-	int val, val2, err, reg, ret = 1;
-
-	switch (param) {
-	case PIN_CONFIG_BIAS_DISABLE:
-		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_PU, &val);
-		if (err)
-			return err;
-
-		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_PD, &val2);
-		if (err)
-			return err;
-
-		if (val || val2)
-			return -EINVAL;
-
-		break;
-	case PIN_CONFIG_BIAS_PULL_UP:
-	case PIN_CONFIG_BIAS_PULL_DOWN:
-	case PIN_CONFIG_SLEW_RATE:
-		reg = (param == PIN_CONFIG_BIAS_PULL_UP) ?
-		      PINCTRL_PIN_REG_PU :
-		      (param == PIN_CONFIG_BIAS_PULL_DOWN) ?
-		      PINCTRL_PIN_REG_PD : PINCTRL_PIN_REG_SR;
-
-		err = mtk_hw_get_value(hw, pin, reg, &val);
-		if (err)
-			return err;
-
-		if (!val)
-			return -EINVAL;
-
-		break;
-	case PIN_CONFIG_INPUT_ENABLE:
-	case PIN_CONFIG_OUTPUT_ENABLE:
-		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_DIR, &val);
-		if (err)
-			return err;
-
-		/* HW takes input mode as zero; output mode as non-zero */
-		if ((val && param == PIN_CONFIG_INPUT_ENABLE) ||
-		    (!val && param == PIN_CONFIG_OUTPUT_ENABLE))
-			return -EINVAL;
-
-		break;
-	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
-		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_DIR, &val);
-		if (err)
-			return err;
-
-		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_SMT, &val2);
-		if (err)
-			return err;
-
-		if (val || !val2)
-			return -EINVAL;
-
-		break;
-	case PIN_CONFIG_DRIVE_STRENGTH:
-		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_E4, &val);
-		if (err)
-			return err;
-
-		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_E8, &val2);
-		if (err)
-			return err;
-
-		/* 4mA when (e8, e4) = (0, 0); 8mA when (e8, e4) = (0, 1)
-		 * 12mA when (e8, e4) = (1, 0); 16mA when (e8, e4) = (1, 1)
-		 */
-		ret = ((val2 << 1) + val + 1) * 4;
-
-		break;
-	case MTK_PIN_CONFIG_TDSEL:
-	case MTK_PIN_CONFIG_RDSEL:
-		reg = (param == MTK_PIN_CONFIG_TDSEL) ?
-		       PINCTRL_PIN_REG_TDSEL : PINCTRL_PIN_REG_RDSEL;
-
-		err = mtk_hw_get_value(hw, pin, reg, &val);
-		if (err)
-			return err;
-
-		ret = val;
-
-		break;
-	default:
-		return -ENOTSUPP;
-	}
-
-	*config = pinconf_to_config_packed(param, ret);
-
-	return 0;
-}
-
-static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
-			   unsigned long *configs, unsigned int num_configs)
-{
-	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
-	u32 reg, param, arg;
-	int cfg, err = 0;
-
-	for (cfg = 0; cfg < num_configs; cfg++) {
-		param = pinconf_to_config_param(configs[cfg]);
-		arg = pinconf_to_config_argument(configs[cfg]);
-
-		switch (param) {
-		case PIN_CONFIG_BIAS_DISABLE:
-		case PIN_CONFIG_BIAS_PULL_UP:
-		case PIN_CONFIG_BIAS_PULL_DOWN:
-			arg = (param == PIN_CONFIG_BIAS_DISABLE) ? 0 :
-			       (param == PIN_CONFIG_BIAS_PULL_UP) ? 1 : 2;
-
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_PU,
-					       arg & 1);
-			if (err)
-				goto err;
-
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_PD,
-					       !!(arg & 2));
-			if (err)
-				goto err;
-			break;
-		case PIN_CONFIG_OUTPUT_ENABLE:
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_SMT,
-					       MTK_DISABLE);
-			if (err)
-				goto err;
-			/* else: fall through */
-		case PIN_CONFIG_INPUT_ENABLE:
-		case PIN_CONFIG_SLEW_RATE:
-			reg = (param == PIN_CONFIG_SLEW_RATE) ?
-			       PINCTRL_PIN_REG_SR : PINCTRL_PIN_REG_DIR;
-
-			arg = (param == PIN_CONFIG_INPUT_ENABLE) ? 0 :
-			      (param == PIN_CONFIG_OUTPUT_ENABLE) ? 1 : arg;
-			err = mtk_hw_set_value(hw, pin, reg, arg);
-			if (err)
-				goto err;
-
-			break;
-		case PIN_CONFIG_OUTPUT:
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DIR,
-					       MTK_OUTPUT);
-			if (err)
-				goto err;
-
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DO,
-					       arg);
-			if (err)
-				goto err;
-			break;
-		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
-			/* arg = 1: Input mode & SMT enable ;
-			 * arg = 0: Output mode & SMT disable
-			 */
-			arg = arg ? 2 : 1;
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DIR,
-					       arg & 1);
-			if (err)
-				goto err;
-
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_SMT,
-					       !!(arg & 2));
-			if (err)
-				goto err;
-			break;
-		case PIN_CONFIG_DRIVE_STRENGTH:
-			/* 4mA when (e8, e4) = (0, 0);
-			 * 8mA when (e8, e4) = (0, 1);
-			 * 12mA when (e8, e4) = (1, 0);
-			 * 16mA when (e8, e4) = (1, 1)
-			 */
-			if (!(arg % 4) && (arg >= 4 && arg <= 16)) {
-				arg = arg / 4 - 1;
-				err = mtk_hw_set_value(hw, pin,
-						       PINCTRL_PIN_REG_E4,
-						       arg & 0x1);
-				if (err)
-					goto err;
-
-				err = mtk_hw_set_value(hw, pin,
-						       PINCTRL_PIN_REG_E8,
-						       (arg & 0x2) >> 1);
-				if (err)
-					goto err;
-			} else {
-				err = -ENOTSUPP;
-			}
-			break;
-		case MTK_PIN_CONFIG_TDSEL:
-		case MTK_PIN_CONFIG_RDSEL:
-			reg = (param == MTK_PIN_CONFIG_TDSEL) ?
-			       PINCTRL_PIN_REG_TDSEL : PINCTRL_PIN_REG_RDSEL;
-
-			err = mtk_hw_set_value(hw, pin, reg, arg);
-			if (err)
-				goto err;
-			break;
-		default:
-			err = -ENOTSUPP;
-		}
-	}
-err:
-	return err;
-}
-
-static int mtk_pinconf_group_get(struct pinctrl_dev *pctldev,
-				 unsigned int group, unsigned long *config)
-{
-	const unsigned int *pins;
-	unsigned int i, npins, old = 0;
-	int ret;
-
-	ret = pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < npins; i++) {
-		if (mtk_pinconf_get(pctldev, pins[i], config))
-			return -ENOTSUPP;
-
-		/* configs do not match between two pins */
-		if (i && old != *config)
-			return -ENOTSUPP;
-
-		old = *config;
-	}
-
-	return 0;
-}
-
-static int mtk_pinconf_group_set(struct pinctrl_dev *pctldev,
-				 unsigned int group, unsigned long *configs,
-				 unsigned int num_configs)
-{
-	const unsigned int *pins;
-	unsigned int i, npins;
-	int ret;
-
-	ret = pinctrl_generic_get_group_pins(pctldev, group, &pins, &npins);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < npins; i++) {
-		ret = mtk_pinconf_set(pctldev, pins[i], configs, num_configs);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static const struct pinctrl_ops mtk_pctlops = {
-	.get_groups_count = pinctrl_generic_get_group_count,
-	.get_group_name = pinctrl_generic_get_group_name,
-	.get_group_pins = pinctrl_generic_get_group_pins,
-	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
-	.dt_free_map = pinconf_generic_dt_free_map,
-};
-
-static const struct pinmux_ops mtk_pmxops = {
-	.get_functions_count = pinmux_generic_get_function_count,
-	.get_function_name = pinmux_generic_get_function_name,
-	.get_function_groups = pinmux_generic_get_function_groups,
-	.set_mux = mtk_pinmux_set_mux,
-	.gpio_request_enable = mtk_pinmux_gpio_request_enable,
-	.gpio_set_direction = mtk_pinmux_gpio_set_direction,
-	.strict = true,
-};
-
-static const struct pinconf_ops mtk_confops = {
-	.is_generic = true,
-	.pin_config_get = mtk_pinconf_get,
-	.pin_config_set = mtk_pinconf_set,
-	.pin_config_group_get = mtk_pinconf_group_get,
-	.pin_config_group_set = mtk_pinconf_group_set,
-	.pin_config_config_dbg_show = pinconf_generic_dump_config,
-};
-
-static struct pinctrl_desc mtk_desc = {
-	.name = PINCTRL_PINCTRL_DEV,
-	.pctlops = &mtk_pctlops,
-	.pmxops = &mtk_pmxops,
-	.confops = &mtk_confops,
-	.owner = THIS_MODULE,
-};
-
-static int mtk_gpio_get(struct gpio_chip *chip, unsigned int gpio)
-{
-	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
-	int value, err;
-
-	err = mtk_hw_get_value(hw, gpio, PINCTRL_PIN_REG_DI, &value);
-	if (err)
-		return err;
-
-	return !!value;
-}
-
-static void mtk_gpio_set(struct gpio_chip *chip, unsigned int gpio, int value)
-{
-	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
-
-	mtk_hw_set_value(hw, gpio, PINCTRL_PIN_REG_DO, !!value);
-}
-
-static int mtk_gpio_direction_input(struct gpio_chip *chip, unsigned int gpio)
-{
-	return pinctrl_gpio_direction_input(chip->base + gpio);
-}
-
-static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
-				     int value)
-{
-	mtk_gpio_set(chip, gpio, value);
-
-	return pinctrl_gpio_direction_output(chip->base + gpio);
-}
-
-static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
-{
-	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
-	unsigned long eint_n;
-
-	if (!hw->eint)
-		return -ENOTSUPP;
-
-	eint_n = offset;
-
-	return mtk_eint_find_irq(hw->eint, eint_n);
-}
-
-static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
-			       unsigned long config)
-{
-	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
-	unsigned long eint_n;
-	u32 debounce;
-
-	if (!hw->eint ||
-	    pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
-		return -ENOTSUPP;
-
-	debounce = pinconf_to_config_argument(config);
-	eint_n = offset;
-
-	return mtk_eint_set_debounce(hw->eint, eint_n, debounce);
-}
-
-static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
-{
-	struct gpio_chip *chip = &hw->chip;
-	int ret;
-
-	chip->label		= PINCTRL_PINCTRL_DEV;
-	chip->parent		= hw->dev;
-	chip->request		= gpiochip_generic_request;
-	chip->free		= gpiochip_generic_free;
-	chip->direction_input	= mtk_gpio_direction_input;
-	chip->direction_output	= mtk_gpio_direction_output;
-	chip->get		= mtk_gpio_get;
-	chip->set		= mtk_gpio_set;
-	chip->to_irq		= mtk_gpio_to_irq,
-	chip->set_config	= mtk_gpio_set_config,
-	chip->base		= -1;
-	chip->ngpio		= hw->soc->npins;
-	chip->of_node		= np;
-	chip->of_gpio_n_cells	= 2;
-
-	ret = gpiochip_add_data(chip, hw);
-	if (ret < 0)
-		return ret;
-
-	/* Just for backward compatible for these old pinctrl nodes without
-	 * "gpio-ranges" property. Otherwise, called directly from a
-	 * DeviceTree-supported pinctrl driver is DEPRECATED.
-	 * Please see Section 2.1 of
-	 * Documentation/devicetree/bindings/gpio/gpio.txt on how to
-	 * bind pinctrl and gpio drivers via the "gpio-ranges" property.
-	 */
-	if (!of_find_property(np, "gpio-ranges", NULL)) {
-		ret = gpiochip_add_pin_range(chip, dev_name(hw->dev), 0, 0,
-					     chip->ngpio);
-		if (ret < 0) {
-			gpiochip_remove(chip);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
-static int mtk_build_groups(struct mtk_pinctrl *hw)
-{
-	int err, i;
-
-	for (i = 0; i < hw->soc->ngrps; i++) {
-		const struct group_desc *group = hw->soc->grps + i;
-
-		err = pinctrl_generic_add_group(hw->pctrl, group->name,
-						group->pins, group->num_pins,
-						group->data);
-		if (err < 0) {
-			dev_err(hw->dev, "Failed to register group %s\n",
-				group->name);
-			return err;
-		}
-	}
-
-	return 0;
-}
-
-static int mtk_build_functions(struct mtk_pinctrl *hw)
-{
-	int i, err;
-
-	for (i = 0; i < hw->soc->nfuncs ; i++) {
-		const struct function_desc *func = hw->soc->funcs + i;
-
-		err = pinmux_generic_add_function(hw->pctrl, func->name,
-						  func->group_names,
-						  func->num_group_names,
-						  func->data);
-		if (err < 0) {
-			dev_err(hw->dev, "Failed to register function %s\n",
-				func->name);
-			return err;
-		}
-	}
-
-	return 0;
-}
-
-static int mtk_xt_get_gpio_n(void *data, unsigned long eint_n,
-			     unsigned int *gpio_n,
-			     struct gpio_chip **gpio_chip)
-{
-	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
-
-	*gpio_chip = &hw->chip;
-	*gpio_n = eint_n;
-
-	return 0;
-}
-
-static int mtk_xt_get_gpio_state(void *data, unsigned long eint_n)
-{
-	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
-	struct gpio_chip *gpio_chip;
-	unsigned int gpio_n;
-	int err;
-
-	err = mtk_xt_get_gpio_n(hw, eint_n, &gpio_n, &gpio_chip);
-	if (err)
-		return err;
-
-	return mtk_gpio_get(gpio_chip, gpio_n);
-}
-
-static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
-{
-	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
-	struct gpio_chip *gpio_chip;
-	unsigned int gpio_n;
-	int err;
-
-	err = mtk_xt_get_gpio_n(hw, eint_n, &gpio_n, &gpio_chip);
-	if (err)
-		return err;
-
-	err = mtk_hw_set_value(hw, gpio_n, PINCTRL_PIN_REG_MODE,
-			       MTK_GPIO_MODE);
-	if (err)
-		return err;
-
-	err = mtk_hw_set_value(hw, gpio_n, PINCTRL_PIN_REG_DIR, MTK_INPUT);
-	if (err)
-		return err;
-
-	err = mtk_hw_set_value(hw, gpio_n, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
-	if (err)
-		return err;
-
-	return 0;
-}
-
-static const struct mtk_eint_xt mtk_eint_xt = {
-	.get_gpio_n = mtk_xt_get_gpio_n,
-	.get_gpio_state = mtk_xt_get_gpio_state,
-	.set_gpio_as_eint = mtk_xt_set_gpio_as_eint,
-};
-
-static int
-mtk_build_eint(struct mtk_pinctrl *hw, struct platform_device *pdev)
-{
-	struct device_node *np = pdev->dev.of_node;
-	struct resource *res;
-
-	if (!IS_ENABLED(CONFIG_EINT_MTK))
-		return 0;
-
-	if (!of_property_read_bool(np, "interrupt-controller"))
-		return -ENODEV;
-
-	hw->eint = devm_kzalloc(hw->dev, sizeof(*hw->eint), GFP_KERNEL);
-	if (!hw->eint)
-		return -ENOMEM;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "eint");
-	if (!res) {
-		dev_err(&pdev->dev, "Unable to get eint resource\n");
-		return -ENODEV;
-	}
-
-	hw->eint->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(hw->eint->base))
-		return PTR_ERR(hw->eint->base);
-
-	hw->eint->irq = irq_of_parse_and_map(np, 0);
-	if (!hw->eint->irq)
-		return -EINVAL;
-
-	hw->eint->dev = &pdev->dev;
-	hw->eint->hw = hw->soc->eint_hw;
-	hw->eint->pctl = hw;
-	hw->eint->gpio_xlate = &mtk_eint_xt;
-
-	return mtk_eint_do_init(hw->eint);
-}
-
-static const struct of_device_id mtk_pinctrl_of_match[] = {
-	{ .compatible = "mediatek,mt7622-pinctrl", .data = &mt7622_data},
+static const struct of_device_id mt7622_pinctrl_of_match[] = {
+	{ .compatible = "mediatek,mt7622-pinctrl", },
 	{ }
 };
 
-static int mtk_pinctrl_probe(struct platform_device *pdev)
+static int mt7622_pinctrl_probe(struct platform_device *pdev)
 {
-	struct resource *res;
-	struct mtk_pinctrl *hw;
-	const struct of_device_id *of_id =
-		of_match_device(mtk_pinctrl_of_match, &pdev->dev);
-	int err;
-
-	hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
-	if (!hw)
-		return -ENOMEM;
-
-	hw->soc = of_id->data;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "missing IO resource\n");
-		return -ENXIO;
-	}
-
-	hw->dev = &pdev->dev;
-	hw->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(hw->base))
-		return PTR_ERR(hw->base);
-
-	/* Setup pins descriptions per SoC types */
-	mtk_desc.pins = hw->soc->pins;
-	mtk_desc.npins = hw->soc->npins;
-	mtk_desc.num_custom_params = ARRAY_SIZE(mtk_custom_bindings);
-	mtk_desc.custom_params = mtk_custom_bindings;
-#ifdef CONFIG_DEBUG_FS
-	mtk_desc.custom_conf_items = mtk_conf_items;
-#endif
-
-	err = devm_pinctrl_register_and_init(&pdev->dev, &mtk_desc, hw,
-					     &hw->pctrl);
-	if (err)
-		return err;
-
-	/* Setup groups descriptions per SoC types */
-	err = mtk_build_groups(hw);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to build groups\n");
-		return err;
-	}
-
-	/* Setup functions descriptions per SoC types */
-	err = mtk_build_functions(hw);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to build functions\n");
-		return err;
-	}
-
-	/* For able to make pinctrl_claim_hogs, we must not enable pinctrl
-	 * until all groups and functions are being added one.
-	 */
-	err = pinctrl_enable(hw->pctrl);
-	if (err)
-		return err;
-
-	err = mtk_build_eint(hw, pdev);
-	if (err)
-		dev_warn(&pdev->dev,
-			 "Failed to add EINT, but pinctrl still can work\n");
-
-	/* Build gpiochip should be after pinctrl_enable is done */
-	err = mtk_build_gpiochip(hw, pdev->dev.of_node);
-	if (err) {
-		dev_err(&pdev->dev, "Failed to add gpio_chip\n");
-		return err;
-	}
-
-	platform_set_drvdata(pdev, hw);
-
-	return 0;
+	return mtk_moore_pinctrl_probe(pdev, &mt7622_data);
 }
 
-static struct platform_driver mtk_pinctrl_driver = {
+static struct platform_driver mt7622_pinctrl_driver = {
 	.driver = {
-		.name = "mtk-pinctrl",
-		.of_match_table = mtk_pinctrl_of_match,
+		.name = "mt7622-pinctrl",
+		.of_match_table = mt7622_pinctrl_of_match,
 	},
-	.probe = mtk_pinctrl_probe,
+	.probe = mt7622_pinctrl_probe,
 };
 
-static int __init mtk_pinctrl_init(void)
+static int __init mt7622_pinctrl_init(void)
 {
-	return platform_driver_register(&mtk_pinctrl_driver);
+	return platform_driver_register(&mt7622_pinctrl_driver);
 }
-arch_initcall(mtk_pinctrl_init);
+arch_initcall(mt7622_pinctrl_init);
-- 
2.7.4
