From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed,  7 Nov 2012 23:19:36 +0800
Subject: [PATCH v4 3/9] pinctrl: single: support pinconf generic
In-Reply-To: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
References: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1352301582-12244-4-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinconf generic support with POWER SOURCE, BIAS PULL.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/pinctrl/Kconfig          |    1 +
 drivers/pinctrl/pinctrl-single.c |  354 +++++++++++++++++++++++++++++++-------
 2 files changed, 293 insertions(+), 62 deletions(-)

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
index a7c5fdd..77aec05 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -20,6 +20,7 @@
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 
@@ -30,7 +31,7 @@
 #define PCS_MUX_BITS_NAME		"pinctrl-single,bits"
 #define PCS_REG_NAME_LEN		((sizeof(unsigned long) * 2) + 1)
 #define PCS_OFF_DISABLED		~0U
-#define PCS_MAX_GPIO_VALUES		3
+#define PCS_MAX_GPIO_VALUES		2
 
 /**
  * struct pcs_pingroup - pingroups for a function
@@ -81,12 +82,20 @@ struct pcs_function {
  * struct pcs_gpio_range - pinctrl gpio range
  * @range:	subrange of the GPIO number space
  * @gpio_func:	gpio function value in the pinmux register
- * @func_en:	need to handle gpio function in the pinmux register
  */
 struct pcs_gpio_range {
 	struct pinctrl_gpio_range range;
 	int gpio_func;
-	unsigned func_en:1;
+};
+
+/**
+ * struct pcs_conf - configuration of pinctrl device
+ * @nconf:	number of configuration that is defined for pinconf
+ * @is_generic:	for pin controller that want to use the generic interface
+ */
+struct pcs_conf {
+	unsigned nconfs;
+	bool is_generic;
 };
 
 /**
@@ -130,16 +139,24 @@ struct pcs_name {
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
+ * @conf:	value of pinconf
  * @pgtree:	pingroup index radix tree
  * @ftree:	function index radix tree
  * @pingroups:	list of pingroups
  * @functions:	list of functions
- * @ranges:	list of gpio ranges
  * @ngroups:	number of pingroups
  * @nfuncs:	number of functions
- * @nranges:	number of gpio ranges
  * @desc:	pin controller descriptor
  * @read:	register read function to use
  * @write:	register write function to use
@@ -156,17 +173,25 @@ struct pcs_device {
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
+	struct pcs_conf conf;
 	struct radix_tree_root pgtree;
 	struct radix_tree_root ftree;
 	struct list_head pingroups;
 	struct list_head functions;
-	struct list_head ranges;
 	unsigned ngroups;
 	unsigned nfuncs;
-	unsigned nranges;
 	struct pinctrl_desc desc;
 	unsigned (*read)(void __iomem *reg);
 	void (*write)(unsigned val, void __iomem *reg);
@@ -428,8 +453,6 @@ static int pcs_request_gpio(struct pinctrl_dev *pctldev,
 	unsigned data;
 
 	gpio = container_of(range, struct pcs_gpio_range, range);
-	if (!gpio->func_en)
-		return -ENOTSUPP;
 	end = range->pin_base + range->npins - 1;
 	if (pin < range->pin_base || pin > end) {
 		dev_err(pctldev->dev, "pin %d isn't in the range of "
@@ -452,28 +475,163 @@ static struct pinmux_ops pcs_pinmux_ops = {
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
+	data = pcs->read(pcs->base + offset);
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
+	ret = pcs->read(pcs->base + offset) & ~mask;
+	pcs->write(ret | data, pcs->base + offset);
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
+		ret = pcs->read(pcs->base + offset) & ~mask;
+		pcs->write(ret | data, pcs->base + offset);
+	}
+	return 0;
 }
 
 static void pcs_pinconf_dbg_show(struct pinctrl_dev *pctldev,
@@ -688,6 +846,7 @@ static int pcs_get_pin_by_offset(struct pcs_device *pcs, unsigned offset)
  * @pcs: pinctrl driver instance
  * @np: device node of the mux entry
  * @map: map entry
+ * @num_configs: number of pin configurations
  * @pgnames: pingroup names
  *
  * Note that this binding currently supports only sets of one register + value.
@@ -707,9 +866,12 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 						const char **pgnames)
 {
 	struct pcs_func_vals *vals;
+	struct pinctrl_map *p = *map;
 	const __be32 *mux;
 	int size, params, rows, *pins, index = 0, found = 0, res = -ENOMEM;
 	struct pcs_function *function;
+	unsigned long *config;
+	u32 value, nconfs;
 
 	if (pcs->bits_per_mux) {
 		params = 3;
@@ -763,6 +925,7 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 		pins[found++] = pin;
 	}
 
+	nconfs = pcs->conf.nconfs;
 	pgnames[0] = np->name;
 	function = pcs_add_function(pcs, np, np->name, vals, found, pgnames, 1);
 	if (!function)
@@ -772,12 +935,42 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	if (res < 0)
 		goto free_function;
 
-	(*map)->type = PIN_MAP_TYPE_MUX_GROUP;
-	(*map)->data.mux.group = np->name;
-	(*map)->data.mux.function = np->name;
+	p->type = PIN_MAP_TYPE_MUX_GROUP;
+	p->data.mux.group = np->name;
+	p->data.mux.function = np->name;
+
+	if (!nconfs)
+		return 0;
+
+	config = devm_kzalloc(pcs->dev, sizeof(*config) * nconfs, GFP_KERNEL);
+	if (!config) {
+		res = -ENOMEM;
+		goto free_pingroup;
+	}
+	index = 0;
+	if (!of_property_read_u32(np, "pinctrl-single,input-schmitt", &value))
+		config[index++] =
+			pinconf_to_config_packed(PIN_CONFIG_INPUT_SCHMITT,
+						 value & 0xffff);
+	if (!of_property_read_u32(np, "pinctrl-single,bias", &value))
+		config[index++] =
+			pinconf_to_config_packed(PIN_CONFIG_BIAS_DISABLE,
+						 value & 0xffff);
+	if (!of_property_read_u32(np, "pinctrl-single,power-source", &value))
+		config[index++] =
+			pinconf_to_config_packed(PIN_CONFIG_POWER_SOURCE,
+						 value & 0xffff);
+	p++;
+	p->type = PIN_MAP_TYPE_CONFIGS_GROUP;
+	p->data.configs.group_or_pin = np->name;
+	p->data.configs.configs = config;
+	p->data.configs.num_configs = nconfs;
 
 	return 0;
 
+free_pingroup:
+	pcs_free_pingroups(pcs);
+
 free_function:
 	pcs_remove_function(pcs, function);
 
@@ -789,6 +982,7 @@ free_vals:
 
 	return res;
 }
+
 /**
  * pcs_dt_node_to_map() - allocates and parses pinctrl maps
  * @pctldev: pinctrl instance
@@ -806,34 +1000,27 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	pcs = pinctrl_dev_get_drvdata(pctldev);
 
-	*map = devm_kzalloc(pcs->dev, sizeof(**map), GFP_KERNEL);
-	if (!map)
-		return -ENOMEM;
+	if (!pcs->conf.nconfs)
+		*num_maps = 1;
+	else
+		*num_maps = 2;
 
-	*num_maps = 0;
+	*map = devm_kzalloc(pcs->dev, sizeof(**map) * (*num_maps), GFP_KERNEL);
+	if (!*map)
+		return -ENOMEM;
 
 	pgnames = devm_kzalloc(pcs->dev, sizeof(*pgnames), GFP_KERNEL);
-	if (!pgnames) {
-		ret = -ENOMEM;
-		goto free_map;
-	}
+	if (!pgnames)
+		return -ENOMEM;
 
 	ret = pcs_parse_one_pinctrl_entry(pcs, np_config, map, pgnames);
 	if (ret < 0) {
 		dev_err(pcs->dev, "no pins entries for %s\n",
 			np_config->name);
-		goto free_pgnames;
+		return ret;
 	}
-	*num_maps = 1;
 
 	return 0;
-
-free_pgnames:
-	devm_kfree(pcs->dev, pgnames);
-free_map:
-	devm_kfree(pcs->dev, *map);
-
-	return ret;
 }
 
 /**
@@ -918,52 +1105,40 @@ static int __devinit pcs_add_gpio_range(struct device_node *node,
 					struct pcs_device *pcs)
 {
 	struct pcs_gpio_range *gpio;
-	struct device_node *np;
-	const __be32 *list;
-	const char list_name[] = "pinctrl-single,gpio-ranges";
+	struct device_node *child;
+	struct resource r;
 	const char name[] = "pinctrl-single";
 	u32 gpiores[PCS_MAX_GPIO_VALUES];
-	int ret, size, i, mux_bytes = 0;
+	int ret, i = 0, mux_bytes = 0;
 
-	list = of_get_property(node, list_name, &size);
-	if (!list)
-		return 0;
-	size = size / sizeof(*list);
-	for (i = 0; i < size; i++) {
-		np = of_parse_phandle(node, list_name, i);
+	for_each_child_of_node(node, child) {
+		ret = of_address_to_resource(child, 0, &r);
+		if (ret < 0)
+			continue;
 		memset(gpiores, 0, sizeof(u32) * PCS_MAX_GPIO_VALUES);
-		ret = of_property_read_u32_array(np, "pinctrl-single,gpio",
+		ret = of_property_read_u32_array(child, "pinctrl-single,gpio",
 						 gpiores, PCS_MAX_GPIO_VALUES);
 		if (ret < 0)
-			return -ENOENT;
+			continue;
 		gpio = devm_kzalloc(pcs->dev, sizeof(*gpio), GFP_KERNEL);
 		if (!gpio) {
 			dev_err(pcs->dev, "failed to allocate pcs gpio\n");
 			return -ENOMEM;
 		}
-		gpio->range.id = i;
-		gpio->range.base = gpiores[0];
-		gpio->range.npins = gpiores[1];
 		gpio->range.name = devm_kzalloc(pcs->dev, sizeof(name),
 						GFP_KERNEL);
 		if (!gpio->range.name) {
 			dev_err(pcs->dev, "failed to allocate range name\n");
 			return -ENOMEM;
 		}
-		memcpy(&gpio->range.name, name, sizeof(name));
-		mux_bytes = pcs->width / BITS_PER_BYTE;
-		gpio->range.pin_base = gpiores[2] / mux_bytes;
-		memset(gpiores, 0, sizeof(u32) * PCS_MAX_GPIO_VALUES);
-		ret = of_property_read_u32(np, "pinctrl-single,gpio-func",
-					   &gpio->gpio_func);
-		if (ret < 0)
-			return -ENOENT;
-		gpio->func_en = 1;
+		memcpy((char *)gpio->range.name, name, sizeof(name));
 
-		mutex_lock(&pcs->mutex);
-		list_add_tail(&gpio->range.node, &pcs->ranges);
-		pcs->nranges++;
-		mutex_unlock(&pcs->mutex);
+		gpio->range.id = i++;
+		gpio->range.base = gpiores[0];
+		gpio->gpio_func = gpiores[1];
+		mux_bytes = pcs->width / BITS_PER_BYTE;
+		gpio->range.pin_base = (r.start - pcs->res->start) / mux_bytes;
+		gpio->range.npins = (r.end - r.start) / mux_bytes + 1;
 
 		pinctrl_add_gpio_range(pcs->pctl, &gpio->range);
 	}
@@ -976,11 +1151,13 @@ static int __devinit pcs_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct resource *res;
 	struct pcs_device *pcs;
+	const struct pcs_conf *conf;
 	int ret;
 
 	match = of_match_device(pcs_of_match, &pdev->dev);
 	if (!match)
 		return -EINVAL;
+	conf = match->data;
 
 	pcs = devm_kzalloc(&pdev->dev, sizeof(*pcs), GFP_KERNEL);
 	if (!pcs) {
@@ -988,10 +1165,10 @@ static int __devinit pcs_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	pcs->dev = &pdev->dev;
+	memcpy(&pcs->conf, conf, sizeof(*conf));
 	mutex_init(&pcs->mutex);
 	INIT_LIST_HEAD(&pcs->pingroups);
 	INIT_LIST_HEAD(&pcs->functions);
-	INIT_LIST_HEAD(&pcs->ranges);
 
 	PCS_GET_PROP_U32("pinctrl-single,register-width", &pcs->width,
 			 "register width not specified\n");
@@ -1009,6 +1186,46 @@ static int __devinit pcs_probe(struct platform_device *pdev)
 	pcs->bits_per_mux = of_property_read_bool(np,
 						  "pinctrl-single,bit-per-mux");
 
+	if (conf->nconfs) {
+		pcs_pinconf_ops.is_generic = true;
+		ret = of_property_read_u32(np,
+				"pinctrl-single,power-source-mask",
+				&pcs->psmask);
+		if (ret) {
+			pcs->psmask = PCS_OFF_DISABLED;
+			pcs->psshift = PCS_OFF_DISABLED;
+		} else
+			pcs->psshift = ffs(pcs->psmask) - 1;
+		ret = of_property_read_u32(np,
+				"pinctrl-single,bias-mask", &pcs->bmask);
+		if (ret) {
+			pcs->bmask = PCS_OFF_DISABLED;
+			pcs->bshift = PCS_OFF_DISABLED;
+		} else
+			pcs->bshift = ffs(pcs->bmask) - 1;
+		ret = of_property_read_u32(np,
+				"pinctrl-single,bias-disable", &pcs->bdis);
+		if (ret)
+			pcs->bdis = PCS_OFF_DISABLED;
+		ret = of_property_read_u32(np,
+				"pinctrl-single,bias-pull-up", &pcs->bpullup);
+		if (ret)
+			pcs->bpullup = PCS_OFF_DISABLED;
+		ret = of_property_read_u32(np,
+				"pinctrl-single,bias-pull-down",
+				&pcs->bpulldown);
+		if (ret)
+			pcs->bpulldown = PCS_OFF_DISABLED;
+		ret = of_property_read_u32(np,
+				"pinctrl-single,input-schmitt-mask",
+				&pcs->ismask);
+		if (ret) {
+			pcs->ismask = PCS_OFF_DISABLED;
+			pcs->isshift = PCS_OFF_DISABLED;
+		} else
+			pcs->isshift = ffs(pcs->ismask) - 1;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(pcs->dev, "could not get resource\n");
@@ -1094,8 +1311,21 @@ static int __devexit pcs_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* PINCONF isn't supported */
+static struct pcs_conf pinctrl_conf __devinitdata = {
+	.nconfs = 0,
+	.is_generic = false,
+};
+
+/* Generic PINCONF is supported. */
+static struct pcs_conf pinconf_conf __devinitdata = {
+	.nconfs = 7,
+	.is_generic = true,
+};
+
 static struct of_device_id pcs_of_match[] __devinitdata = {
-	{ .compatible = DRIVER_NAME, },
+	{ .compatible = "pinctrl-single", .data = &pinctrl_conf },
+	{ .compatible = "pinconf-single", .data = &pinconf_conf },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, pcs_of_match);
-- 
1.7.10.4
