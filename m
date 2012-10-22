From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 23 Oct 2012 00:08:53 +0800
Subject: [PATCH v2 3/9] pinctrl: single: support pinconf generic
In-Reply-To: <1350922139-3693-1-git-send-email-haojian.zhuang@gmail.com>
References: <1350922139-3693-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1350922139-3693-4-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinconf generic support with POWER SOURCE, BIAS PULL.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/pinctrl/Kconfig          |    1 +
 drivers/pinctrl/pinctrl-single.c |  276 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 266 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 7bf914d..e9f2d2d 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -139,6 +139,7 @@ config PINCTRL_SINGLE
 	depends on OF
 	select PINMUX
 	select PINCONF
+	select GENERIC_PINCONF
 	help
 	  This selects the device tree based generic pinctrl driver.
 
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 6a0b24b..a20da78 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -20,6 +20,7 @@
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 
@@ -29,6 +30,9 @@
 #define PCS_MUX_PINS_NAME		"pinctrl-single,pins"
 #define PCS_MUX_BITS_NAME		"pinctrl-single,bits"
 #define PCS_GPIO_FUNC_NAME		"pinctrl-single,gpio-func"
+#define PCS_BIAS_NAME			"pinctrl-single,bias"
+#define PCS_POWER_SOURCE_NAME		"pinctrl-single,power-source"
+#define PCS_SCHMITT_NAME		"pinctrl-single,input-schmitt"
 #define PCS_REG_NAME_LEN		((sizeof(unsigned long) * 2) + 1)
 #define PCS_OFF_DISABLED		~0U
 #define PCS_MAX_GPIO_VALUES		3
@@ -131,6 +135,15 @@ struct pcs_name {
  * @fshift:	function register shift
  * @foff:	value to turn mux off
  * @fmax:	max number of functions in fmask
+ * @bmask:	bias mask in pinconf
+ * @bshift:	bias register shift
+ * @bdis:	bias disable value in pinconf
+ * @bpullup:	bias pull up value in pinconf
+ * @bpulldown:	bias pull down value in pinconf
+ * @ismask:	input schmitt mask in pinconf
+ * @isshift:	input schmitt register shift
+ * @psmask:	power source mask in pinconf
+ * @psshift:	power source register shift
  * @names:	array of register names for pins
  * @pins:	physical pins on the SoC
  * @pgtree:	pingroup index radix tree
@@ -157,6 +170,15 @@ struct pcs_device {
 	unsigned fshift;
 	unsigned foff;
 	unsigned fmax;
+	unsigned bmask;
+	unsigned bshift;
+	unsigned bdis;
+	unsigned bpullup;
+	unsigned bpulldown;
+	unsigned ismask;
+	unsigned isshift;
+	unsigned psmask;
+	unsigned psshift;
 	bool bits_per_mux;
 	struct pcs_name *names;
 	struct pcs_data pins;
@@ -453,28 +475,163 @@ static struct pinmux_ops pcs_pinmux_ops = {
 	.gpio_request_enable = pcs_request_gpio,
 };
 
+static void pcs_free_pingroups(struct pcs_device *pcs);
+
 static int pcs_pinconf_get(struct pinctrl_dev *pctldev,
 				unsigned pin, unsigned long *config)
 {
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param param = pinconf_to_config_param(*config);
+	unsigned data;
+	u32 offset;
+
+	offset = pin * (pcs->width / BITS_PER_BYTE);
+	data = pcs_readl(pcs->base + offset);
+
+	switch (param) {
+	case PIN_CONFIG_POWER_SOURCE:
+		if (pcs->psmask == PCS_OFF_DISABLED
+			|| pcs->psshift == PCS_OFF_DISABLED)
+			return -ENOTSUPP;
+		data &= pcs->psmask;
+		data = data >> pcs->psshift;
+		*config = data;
+		return 0;
+		break;
+	case PIN_CONFIG_BIAS_DISABLE:
+		if (pcs->bmask == PCS_OFF_DISABLED
+			|| pcs->bshift == PCS_OFF_DISABLED
+			|| pcs->bdis == PCS_OFF_DISABLED)
+			return -ENOTSUPP;
+		data &= pcs->bmask;
+		*config = 0;
+		if (data == pcs->bdis)
+			return 0;
+		else
+			return -EINVAL;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		if (pcs->bmask == PCS_OFF_DISABLED
+			|| pcs->bshift == PCS_OFF_DISABLED
+			|| pcs->bpullup == PCS_OFF_DISABLED)
+			return -ENOTSUPP;
+		data &= pcs->bmask;
+		*config = 0;
+		if (data == pcs->bpullup)
+			return 0;
+		else
+			return -EINVAL;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		if (pcs->bmask == PCS_OFF_DISABLED
+			|| pcs->bshift == PCS_OFF_DISABLED
+			|| pcs->bpulldown == PCS_OFF_DISABLED)
+			return -ENOTSUPP;
+		data &= pcs->bmask;
+		*config = 0;
+		if (data == pcs->bpulldown)
+			return 0;
+		else
+			return -EINVAL;
+		break;
+	default:
+		break;
+	}
 	return -ENOTSUPP;
 }
 
 static int pcs_pinconf_set(struct pinctrl_dev *pctldev,
 				unsigned pin, unsigned long config)
 {
-	return -ENOTSUPP;
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_param = pinconf_to_config_param(config);
+	unsigned ret, mask = ~0UL;
+	u32 offset, data;
+
+	switch (config_param) {
+	case PIN_CONFIG_POWER_SOURCE:
+		if (pcs->psmask == PCS_OFF_DISABLED
+			|| pcs->psshift == PCS_OFF_DISABLED)
+			return 0;
+		mask = pcs->psmask;
+		data = (pinconf_to_config_argument(config) << pcs->psshift)
+			& pcs->psmask;
+		break;
+	case PIN_CONFIG_BIAS_DISABLE:
+		if (pcs->bmask == PCS_OFF_DISABLED
+			|| pcs->bshift == PCS_OFF_DISABLED)
+			return 0;
+		mask = pcs->bmask;
+		data = (pinconf_to_config_argument(config) << pcs->bshift)
+			& pcs->bmask;
+		break;
+	default:
+		return 0;
+	}
+	offset = pin * (pcs->width / BITS_PER_BYTE);
+	ret = pcs_readl(pcs->base + offset) & ~mask;
+	pcs_writel(ret | data, pcs->base + offset);
+	return 0;
 }
 
 static int pcs_pinconf_group_get(struct pinctrl_dev *pctldev,
 				unsigned group, unsigned long *config)
 {
-	return -ENOTSUPP;
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	struct pcs_pingroup *pins;
+
+	pins = radix_tree_lookup(&pcs->pgtree, group);
+	if (!pins) {
+		dev_err(pcs->dev, "%s could not find pingroup%i\n",
+			__func__, group);
+		return -EINVAL;
+	}
+	return pcs_pinconf_get(pctldev, pins->gpins[0], config);
 }
 
 static int pcs_pinconf_group_set(struct pinctrl_dev *pctldev,
 				unsigned group, unsigned long config)
 {
-	return -ENOTSUPP;
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_param = pinconf_to_config_param(config);
+	struct pcs_pingroup *pins;
+	u32 offset, data;
+	unsigned ret, mask = ~0UL;
+	int i;
+
+	switch (config_param) {
+	case PIN_CONFIG_POWER_SOURCE:
+		if (pcs->psmask == PCS_OFF_DISABLED
+			|| pcs->psshift == PCS_OFF_DISABLED)
+			return 0;
+		mask = pcs->psmask;
+		data = (pinconf_to_config_argument(config) << pcs->psshift)
+			& pcs->psmask;
+		break;
+	case PIN_CONFIG_BIAS_DISABLE:
+		if (pcs->bmask == PCS_OFF_DISABLED
+			|| pcs->bshift == PCS_OFF_DISABLED)
+			return 0;
+		mask = pcs->bmask;
+		data = (pinconf_to_config_argument(config) << pcs->bshift)
+			& pcs->bmask;
+		break;
+	default:
+		return 0;
+	}
+
+	pins = radix_tree_lookup(&pcs->pgtree, group);
+	if (!pins) {
+		dev_err(pcs->dev, "%s could not find pingroup%i\n",
+			__func__, group);
+		return -EINVAL;
+	}
+	for (i = 0; i < pins->ngpins; i++) {
+		offset = pins->gpins[i] * (pcs->width / BITS_PER_BYTE);
+		ret = pcs_readl(pcs->base + offset) & ~mask;
+		pcs_writel(ret | data, pcs->base + offset);
+	}
+	return 0;
 }
 
 static void pcs_pinconf_dbg_show(struct pinctrl_dev *pctldev,
@@ -488,6 +645,7 @@ static void pcs_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 }
 
 static struct pinconf_ops pcs_pinconf_ops = {
+	.is_generic = true,
 	.pin_config_get = pcs_pinconf_get,
 	.pin_config_set = pcs_pinconf_set,
 	.pin_config_group_get = pcs_pinconf_group_get,
@@ -689,6 +847,7 @@ static int pcs_get_pin_by_offset(struct pcs_device *pcs, unsigned offset)
  * @pcs: pinctrl driver instance
  * @np: device node of the mux entry
  * @map: map entry
+ * @num_configs: number of pin configurations
  * @pgnames: pingroup names
  *
  * Note that this binding currently supports only sets of one register + value.
@@ -705,12 +864,16 @@ static int pcs_get_pin_by_offset(struct pcs_device *pcs, unsigned offset)
 static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 						struct device_node *np,
 						struct pinctrl_map **map,
+						unsigned num_configs,
 						const char **pgnames)
 {
 	struct pcs_func_vals *vals;
+	struct pinctrl_map *p = *map;
 	const __be32 *mux;
 	int size, params, rows, *pins, index = 0, found = 0, res = -ENOMEM;
 	struct pcs_function *function;
+	unsigned long *config;
+	u32 value;
 
 	if (pcs->bits_per_mux) {
 		params = 3;
@@ -773,12 +936,42 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	if (res < 0)
 		goto free_function;
 
-	(*map)->type = PIN_MAP_TYPE_MUX_GROUP;
-	(*map)->data.mux.group = np->name;
-	(*map)->data.mux.function = np->name;
+	p->type = PIN_MAP_TYPE_MUX_GROUP;
+	p->data.mux.group = np->name;
+	p->data.mux.function = np->name;
+
+	if (!num_configs)
+		return 0;
+	config = devm_kzalloc(pcs->dev, sizeof(*config) * num_configs,
+			      GFP_KERNEL);
+	if (!config) {
+		res = -ENOMEM;
+		goto free_pingroup;
+	}
+	index = 0;
+	if (!of_property_read_u32(np, PCS_SCHMITT_NAME, &value))
+		config[index++] =
+			pinconf_to_config_packed(PIN_CONFIG_INPUT_SCHMITT,
+						 value & 0xffff);
+	if (!of_property_read_u32(np, PCS_BIAS_NAME, &value))
+		config[index++] =
+			pinconf_to_config_packed(PIN_CONFIG_BIAS_DISABLE,
+						 value & 0xffff);
+	if (!of_property_read_u32(np, PCS_POWER_SOURCE_NAME, &value))
+		config[index++] =
+			pinconf_to_config_packed(PIN_CONFIG_POWER_SOURCE,
+						 value & 0xffff);
+	p++;
+	p->type = PIN_MAP_TYPE_CONFIGS_GROUP;
+	p->data.configs.group_or_pin = np->name;
+	p->data.configs.configs = config;
+	p->data.configs.num_configs = num_configs;
 
 	return 0;
 
+free_pingroup:
+	pcs_free_pingroups(pcs);
+
 free_function:
 	pcs_remove_function(pcs, function);
 
@@ -790,6 +983,30 @@ free_vals:
 
 	return res;
 }
+
+static int pcs_dt_check_maps(struct device_node *np, unsigned *num_maps,
+			     unsigned *num_configs)
+{
+	unsigned size;
+
+	*num_maps = 0;
+	*num_configs = 0;
+	if (of_get_property(np, PCS_MUX_PINS_NAME, &size)
+		|| of_get_property(np, PCS_MUX_BITS_NAME, &size))
+		(*num_maps)++;
+	if (of_get_property(np, PCS_SCHMITT_NAME, &size))
+		(*num_configs)++;
+	if (of_get_property(np, PCS_BIAS_NAME, &size))
+		(*num_configs)++;
+	if (of_get_property(np, PCS_POWER_SOURCE_NAME, &size))
+		(*num_configs)++;
+	if (*num_configs)
+		(*num_maps)++;
+	if (!(*num_maps))
+		return -EINVAL;
+	return 0;
+}
+
 /**
  * pcs_dt_node_to_map() - allocates and parses pinctrl maps
  * @pctldev: pinctrl instance
@@ -803,29 +1020,32 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
 {
 	struct pcs_device *pcs;
 	const char **pgnames;
+	unsigned num_configs;
 	int ret;
 
 	pcs = pinctrl_dev_get_drvdata(pctldev);
 
-	*map = devm_kzalloc(pcs->dev, sizeof(**map), GFP_KERNEL);
+	ret = pcs_dt_check_maps(np_config, num_maps, &num_configs);
+	if (ret)
+		return ret;
+
+	*map = devm_kzalloc(pcs->dev, sizeof(**map) * (*num_maps), GFP_KERNEL);
 	if (!map)
 		return -ENOMEM;
 
-	*num_maps = 0;
-
 	pgnames = devm_kzalloc(pcs->dev, sizeof(*pgnames), GFP_KERNEL);
 	if (!pgnames) {
 		ret = -ENOMEM;
 		goto free_map;
 	}
 
-	ret = pcs_parse_one_pinctrl_entry(pcs, np_config, map, pgnames);
+	ret = pcs_parse_one_pinctrl_entry(pcs, np_config, map,
+					  num_configs, pgnames);
 	if (ret < 0) {
 		dev_err(pcs->dev, "no pins entries for %s\n",
 			np_config->name);
 		goto free_pgnames;
 	}
-	*num_maps = 1;
 
 	return 0;
 
@@ -1003,6 +1223,40 @@ static int __devinit pcs_probe(struct platform_device *pdev)
 	pcs->bits_per_mux = of_property_read_bool(np,
 						  "pinctrl-single,bit-per-mux");
 
+	ret = of_property_read_u32(np, "pinctrl-single,power-source-mask",
+					&pcs->psmask);
+	if (ret) {
+		pcs->psmask = PCS_OFF_DISABLED;
+		pcs->psshift = PCS_OFF_DISABLED;
+	} else
+		pcs->psshift = ffs(pcs->psmask) - 1;
+	ret = of_property_read_u32(np, "pinctrl-single,bias-mask",
+					&pcs->bmask);
+	if (ret) {
+		pcs->bmask = PCS_OFF_DISABLED;
+		pcs->bshift = PCS_OFF_DISABLED;
+	} else
+		pcs->bshift = ffs(pcs->bmask) - 1;
+	ret = of_property_read_u32(np, "pinctrl-single,bias-disable",
+					&pcs->bdis);
+	if (ret)
+		pcs->bdis = PCS_OFF_DISABLED;
+	ret = of_property_read_u32(np, "pinctrl-single,bias-pull-up",
+					&pcs->bpullup);
+	if (ret)
+		pcs->bpullup = PCS_OFF_DISABLED;
+	ret = of_property_read_u32(np, "pinctrl-single,bias-pull-down",
+					&pcs->bpulldown);
+	if (ret)
+		pcs->bpulldown = PCS_OFF_DISABLED;
+	ret = of_property_read_u32(np, "pinctrl-single,input-schmitt-mask",
+					&pcs->ismask);
+	if (ret) {
+		pcs->ismask = PCS_OFF_DISABLED;
+		pcs->isshift = PCS_OFF_DISABLED;
+	} else
+		pcs->isshift = ffs(pcs->ismask) - 1;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(pcs->dev, "could not get resource\n");
-- 
1.7.0.4
