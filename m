From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 15 Nov 2012 16:36:34 +0800
Subject: [PATCH v5 05/10] pinctrl: single: support pinconf generic
In-Reply-To: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
References: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1352968600-15345-6-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinconf generic support with POWER SOURCE, BIAS PULL.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/pinctrl/Kconfig          |    1 +
 drivers/pinctrl/pinctrl-single.c |  322 +++++++++++++++++++++++++++++++++++---
 2 files changed, 305 insertions(+), 18 deletions(-)

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
index 2476a68..be12aca 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -20,6 +20,8 @@
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 
+#include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 
@@ -33,6 +35,26 @@
 #define PCS_MAX_GPIO_VALUES		2
 
 /**
+ * union pcs_pinconf_argument_t -- upper 16-bit in the pinconf data
+ *
+ * The 32-bit pinmux register value could be divided into some different
+ * config arguments. Each config parameter binds to one config argument.
+ * And each config argument can't exceed 5-bit value.
+ * @data:	argument of config in pinconf generic
+ * @value:	5-bit value
+ * @mask:	5-bit mask
+ * @shift:	shift of value/mask field in pinmux register
+ */
+union pcs_pinconf_argument_t {
+	u16 data;
+	struct {
+		unsigned value:5;
+		unsigned mask:5;
+		unsigned shift:5;
+	} bits;
+};
+
+/**
  * struct pcs_pingroup - pingroups for a function
  * @np:		pingroup device node pointer
  * @name:	pingroup name
@@ -88,6 +110,16 @@ struct pcs_gpio_range {
 };
 
 /**
+ * struct pcs_conf - configuration of pinctrl device
+ * @nconf:	number of configuration that is defined for pinconf
+ * @is_generic:	for pin controller that want to use the generic interface
+ */
+struct pcs_conf {
+	unsigned nconfs;
+	bool is_generic;
+};
+
+/**
  * struct pcs_data - wrapper for data needed by pinctrl framework
  * @pa:		pindesc array
  * @cur:	index to current element
@@ -130,6 +162,7 @@ struct pcs_name {
  * @fmax:	max number of functions in fmask
  * @names:	array of register names for pins
  * @pins:	physical pins on the SoC
+ * @conf:	value of pinconf
  * @pgtree:	pingroup index radix tree
  * @ftree:	function index radix tree
  * @pingroups:	list of pingroups
@@ -155,6 +188,7 @@ struct pcs_device {
 	bool bits_per_mux;
 	struct pcs_name *names;
 	struct pcs_data pins;
+	struct pcs_conf conf;
 	struct radix_tree_root pgtree;
 	struct radix_tree_root ftree;
 	struct list_head pingroups;
@@ -445,28 +479,168 @@ static struct pinmux_ops pcs_pinmux_ops = {
 	.gpio_request_enable = pcs_request_gpio,
 };
 
+static void pcs_free_pingroups(struct pcs_device *pcs);
+
+static int pcs_pinconf_get_config(struct pinctrl_dev *pctldev, unsigned pin,
+				  enum pin_config_param config_param)
+{
+	const struct pinctrl_map *map;
+	enum pin_config_param param;
+	const unsigned *pins = NULL;
+	const char *name;
+	unsigned long *conf;
+	unsigned count, group, i, npins;
+	int found = 0;
+
+	count = pcs_get_groups_count(pctldev);
+	for (group = 0; group < count; group++) {
+		if (pcs_get_group_pins(pctldev, group, &pins, &npins))
+			return -EINVAL;
+		for (i = 0; i < npins; i++) {
+			if (pins[i] == pin) {
+				found = 1;
+				break;
+			}
+		}
+		if (found)
+			break;
+	}
+	if (!found)
+		return -ENOTSUPP;
+
+	name = pcs_get_group_name(pctldev, group);
+	if (!name)
+		return -EINVAL;
+	map = pinctrl_lookup_map(pctldev->p, name, PIN_MAP_TYPE_CONFIGS_GROUP);
+	if (!map)
+		return -ENOTSUPP;
+
+	conf = map->data.configs.configs;
+	for (i = 0; i < map->data.configs.num_configs; i++) {
+		param = pinconf_to_config_param(conf[i]);
+		if (config_param == param)
+			return conf[i];
+	}
+	return -ENOTSUPP;
+}
+
 static int pcs_pinconf_get(struct pinctrl_dev *pctldev,
 				unsigned pin, unsigned long *config)
 {
-	return -ENOTSUPP;
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_param = pinconf_to_config_param(*config);
+	union pcs_pinconf_argument_t arg;
+	u32 offset;
+	unsigned data;
+	int ret;
+
+	if (!pcs->conf.nconfs)
+		return -ENOTSUPP;
+
+	ret = pcs_pinconf_get_config(pctldev, pin, config_param);
+	if (ret < 0)
+		return ret;
+
+	offset = pin * (pcs->width / BITS_PER_BYTE);
+	data = pcs->read(pcs->base + offset);
+
+	arg.data = pinconf_to_config_argument(ret);
+	data = (data >> arg.bits.shift) & arg.bits.mask;
+	arg.bits.value = data;
+	*config = pinconf_to_config_packed(config_param, arg.data);
+	return 0;
 }
 
 static int pcs_pinconf_set(struct pinctrl_dev *pctldev,
 				unsigned pin, unsigned long config)
 {
-	return -ENOTSUPP;
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param config_param = pinconf_to_config_param(config);
+	union pcs_pinconf_argument_t arg;
+	u32 offset;
+	unsigned data;
+	int ret;
+
+	if (!pcs->conf.nconfs)
+		return -ENOTSUPP;
+
+	ret = pcs_pinconf_get_config(pctldev, pin, config_param);
+	if (ret < 0)
+		return ret;
+
+	offset = pin * (pcs->width / BITS_PER_BYTE);
+	data = pcs->read(pcs->base + offset);
+
+	arg.data = pinconf_to_config_argument(config);
+	data = (data >> arg.bits.shift) & arg.bits.mask;
+	arg.bits.value = data;
+	data = pinconf_to_config_packed(config_param, arg.data);
+	pcs->write(data, pcs->base + offset);
+	return 0;
 }
 
 static int pcs_pinconf_group_get(struct pinctrl_dev *pctldev,
 				unsigned group, unsigned long *config)
 {
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	const struct pinctrl_map *map;
+	enum pin_config_param param, config_param;
+	union pcs_pinconf_argument_t arg;
+	const char *name;
+	unsigned long *conf;
+	int i;
+
+	if (!pcs->conf.nconfs)
+		return -ENOTSUPP;
+
+	name = pcs_get_group_name(pctldev, group);
+	if (!name)
+		return -EINVAL;
+	map = pinctrl_lookup_map(pctldev->p, name, PIN_MAP_TYPE_CONFIGS_GROUP);
+	if (!map)
+		return -ENOTSUPP;
+	config_param = pinconf_to_config_param(*config);
+	conf = map->data.configs.configs;
+	for (i = 0; i < map->data.configs.num_configs; i++) {
+		param = pinconf_to_config_param(conf[i]);
+		if (config_param == param) {
+			arg.data = pinconf_to_config_argument(conf[i]);
+			*config = pinconf_to_config_packed(param, arg.data);
+			return 0;
+		}
+	}
 	return -ENOTSUPP;
 }
 
 static int pcs_pinconf_group_set(struct pinctrl_dev *pctldev,
 				unsigned group, unsigned long config)
 {
-	return -ENOTSUPP;
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	struct pcs_pingroup *pins;
+	union pcs_pinconf_argument_t arg;
+	u32 offset, data;
+	unsigned ret, mask;
+	int i, mux_bytes;
+
+	if (!pcs->conf.nconfs)
+		return -ENOTSUPP;
+
+	pins = radix_tree_lookup(&pcs->pgtree, group);
+	if (!pins) {
+		dev_err(pcs->dev, "%s could not find pingroup%i\n",
+			__func__, group);
+		return -EINVAL;
+	}
+	mux_bytes = pcs->width / BITS_PER_BYTE;
+	arg.data = pinconf_to_config_argument(config);
+	mask = arg.bits.mask << arg.bits.shift;
+	data = arg.bits.value << arg.bits.shift;
+	for (i = 0; i < pins->ngpins; i++) {
+		offset = pins->gpins[i] * mux_bytes;
+		ret = pcs->read(pcs->base + offset) & ~mask;
+		pcs->write(ret | data, pcs->base + offset);
+	}
+	return 0;
 }
 
 static void pcs_pinconf_dbg_show(struct pinctrl_dev *pctldev,
@@ -676,8 +850,22 @@ static int pcs_get_pin_by_offset(struct pcs_device *pcs, unsigned offset)
 	return index;
 }
 
+static int pcs_config_match(unsigned data, unsigned match)
+{
+	int ret = 0;
+
+	if (!match) {
+		if (!data)
+			ret = 1;
+	} else {
+		if ((data & match) == match)
+			ret = 1;
+	}
+	return ret;
+}
+
 /**
- * smux_parse_one_pinctrl_entry() - parses a device tree mux entry
+ * pcs_parse_one_pinctrl_entry() - parses a device tree mux entry
  * @pcs: pinctrl driver instance
  * @np: device node of the mux entry
  * @map: map entry
@@ -700,9 +888,13 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 						const char **pgnames)
 {
 	struct pcs_func_vals *vals;
+	struct pinctrl_map *m = *map;
 	const __be32 *mux;
-	int size, params, rows, *pins, index = 0, found = 0, res = -ENOMEM;
+	int size, params, rows, *pins, i = 0, found = 0, res = -ENOMEM;
 	struct pcs_function *function;
+	unsigned long *conf;
+	union pcs_pinconf_argument_t arg;
+	u32 value[8], data, nconfs;
 
 	if (pcs->bits_per_mux) {
 		params = 3;
@@ -733,16 +925,16 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	if (!pins)
 		goto free_vals;
 
-	while (index < size) {
+	while (i < size) {
 		unsigned offset, val;
 		int pin;
 
-		offset = be32_to_cpup(mux + index++);
-		val = be32_to_cpup(mux + index++);
+		offset = be32_to_cpup(mux + i++);
+		val = be32_to_cpup(mux + i++);
 		vals[found].reg = pcs->base + offset;
 		vals[found].val = val;
 		if (params == 3) {
-			val = be32_to_cpup(mux + index++);
+			val = be32_to_cpup(mux + i++);
 			vals[found].mask = val;
 		}
 
@@ -756,6 +948,7 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 		pins[found++] = pin;
 	}
 
+	nconfs = pcs->conf.nconfs;
 	pgnames[0] = np->name;
 	function = pcs_add_function(pcs, np, np->name, vals, found, pgnames, 1);
 	if (!function)
@@ -765,12 +958,82 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	if (res < 0)
 		goto free_function;
 
-	(*map)->type = PIN_MAP_TYPE_MUX_GROUP;
-	(*map)->data.mux.group = np->name;
-	(*map)->data.mux.function = np->name;
+	m->type = PIN_MAP_TYPE_MUX_GROUP;
+	m->data.mux.group = np->name;
+	m->data.mux.function = np->name;
+
+	if (!nconfs)
+		return 0;
+
+	conf = devm_kzalloc(pcs->dev, sizeof(*conf) * nconfs, GFP_KERNEL);
+	if (!conf) {
+		res = -ENOMEM;
+		goto free_pingroup;
+	}
+	i = 0;
+	if (!of_property_read_u32_array(np, "pinctrl-single,bias",
+					value, 5)) {
+		/* array: bias value, mask, disable, pull down, pull up */
+		data = value[0] & value[1];
+		arg.bits.shift = ffs(value[1]) - 1;
+		arg.bits.mask = value[1] >> arg.bits.shift;
+		if (pcs_config_match(data, value[2])) {
+			arg.bits.value = value[2] >> arg.bits.shift;
+			conf[i++] = PIN_CONF_PACKED(PIN_CONFIG_BIAS_DISABLE,
+						    arg.data);
+		}
+		if (pcs_config_match(data, value[3])) {
+			arg.bits.value = value[3] >> arg.bits.shift;
+			conf[i++] = PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_DOWN,
+						    arg.data);
+		}
+		if (pcs_config_match(data, value[4])) {
+			arg.bits.value = value[4] >> arg.bits.shift;
+			conf[i++] = PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_UP,
+						    arg.data);
+		}
+	}
+	if (!of_property_read_u32_array(np, "pinctrl-single,power-source",
+					value, 2)) {
+		/* array: power source value, mask */
+		data = value[0] & value[1];
+		arg.bits.shift = ffs(value[1]) - 1;
+		arg.bits.mask = value[1] >> arg.bits.shift;
+		arg.bits.value = data >> arg.bits.shift;
+		conf[i++] = PIN_CONF_PACKED(PIN_CONFIG_POWER_SOURCE, arg.data);
+	}
+	if (!of_property_read_u32_array(np, "pinctrl-single,input-schmitt",
+					value, 3)) {
+		/* array: input schmitt value, mask, disable */
+		data = value[0] & value[1];
+		arg.bits.shift = ffs(value[1]) - 1;
+		arg.bits.mask = value[1] >> arg.bits.shift;
+		if (pcs_config_match(data, value[2])) {
+			arg.bits.value = value[2] >> arg.bits.shift;
+			conf[i++] = PIN_CONF_PACKED(PIN_CONFIG_INPUT_SCHMITT_DISABLE,
+						    arg.data);
+		} else {
+			arg.bits.value = data >> arg.bits.shift;
+			conf[i++] = PIN_CONF_PACKED(PIN_CONFIG_INPUT_SCHMITT,
+						    arg.data);
+		}
+	}
+	m++;
+	m->type = PIN_MAP_TYPE_CONFIGS_GROUP;
+	m->data.configs.group_or_pin = np->name;
+	m->data.configs.configs = conf;
+	if (i > nconfs) {
+		dev_err(pcs->dev, "pinconf items (%d) more than nconfs (%d)\n",
+			i, nconfs);
+		i = nconfs;
+	}
+	m->data.configs.num_configs = i;
 
 	return 0;
 
+free_pingroup:
+	pcs_free_pingroups(pcs);
+
 free_function:
 	pcs_remove_function(pcs, function);
 
@@ -782,6 +1045,7 @@ free_vals:
 
 	return res;
 }
+
 /**
  * pcs_dt_node_to_map() - allocates and parses pinctrl maps
  * @pctldev: pinctrl instance
@@ -797,13 +1061,17 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
 	const char **pgnames;
 	int ret;
 
+
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
 	if (!pgnames) {
@@ -817,7 +1085,6 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
 			np_config->name);
 		goto free_pgnames;
 	}
-	*num_maps = 1;
 
 	return 0;
 
@@ -957,11 +1224,13 @@ static int __devinit pcs_probe(struct platform_device *pdev)
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
@@ -969,6 +1238,7 @@ static int __devinit pcs_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	pcs->dev = &pdev->dev;
+	memcpy(&pcs->conf, conf, sizeof(*conf));
 	mutex_init(&pcs->mutex);
 	INIT_LIST_HEAD(&pcs->pingroups);
 	INIT_LIST_HEAD(&pcs->functions);
@@ -989,6 +1259,9 @@ static int __devinit pcs_probe(struct platform_device *pdev)
 	pcs->bits_per_mux = of_property_read_bool(np,
 						  "pinctrl-single,bit-per-mux");
 
+	if (conf->nconfs)
+		pcs_pinconf_ops.is_generic = true;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(pcs->dev, "could not get resource\n");
@@ -1074,8 +1347,21 @@ static int __devexit pcs_remove(struct platform_device *pdev)
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
