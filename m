From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 21 Dec 2012 17:45:11 +0800
Subject: [PATCH v6 1/8] pinctrl: single: support generic pinconf
In-Reply-To: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
References: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1356083118-18857-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the operation of generic pinconf. The supported config arguments
are INPUT_SCHMITT, INPUT_SCHMITT_DISABLE, POWER_SOURCE, BIAS_DISABLE,
BIAS_PULLUP, BIAS_PULLDOWN.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/pinctrl/Kconfig          |    1 +
 drivers/pinctrl/pinctrl-single.c |  292 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 287 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index c31aeb0..2434c21 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -143,6 +143,7 @@ config PINCTRL_SINGLE
 	depends on OF
 	select PINMUX
 	select PINCONF
+	select GENERIC_PINCONF
 	help
 	  This selects the device tree based generic pinctrl driver.
 
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 7964283..7d593b8 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -22,6 +22,7 @@
 
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinconf-generic.h>
 
 #include "core.h"
 
@@ -60,6 +61,19 @@ struct pcs_func_vals {
 };
 
 /**
+ * struct pcs_conf_vals - pinconf parameter, pinconf register offset
+ * and value/mask pair
+ * @param:	config parameter
+ * @val:	register value
+ * @mask:	mask of register value
+ */
+struct pcs_conf_vals {
+	enum pin_config_param param;
+	unsigned val;
+	unsigned mask;
+};
+
+/**
  * struct pcs_function - pinctrl function
  * @name:	pinctrl function name
  * @vals:	register and vals array
@@ -74,6 +88,8 @@ struct pcs_function {
 	unsigned nvals;
 	const char **pgnames;
 	int npgnames;
+	struct pcs_conf_vals *conf;
+	int nconfs;
 	struct list_head node;
 };
 
@@ -128,6 +144,7 @@ struct pcs_name {
  * @fshift:	function register shift
  * @foff:	value to turn mux off
  * @fmax:	max number of functions in fmask
+ * @is_pinconf:	whether supports pinconf
  * @names:	array of register names for pins
  * @pins:	physical pins on the SoC
  * @pgtree:	pingroup index radix tree
@@ -153,6 +170,7 @@ struct pcs_device {
 	unsigned foff;
 	unsigned fmax;
 	bool bits_per_mux;
+	bool is_pinconf;
 	struct pcs_name *names;
 	struct pcs_data pins;
 	struct radix_tree_root pgtree;
@@ -448,25 +466,149 @@ static struct pinmux_ops pcs_pinmux_ops = {
 static int pcs_pinconf_get(struct pinctrl_dev *pctldev,
 				unsigned pin, unsigned long *config)
 {
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	struct pin_desc *pdesc = pin_desc_get(pctldev, pin);
+	struct pcs_function *func;
+	const struct pinctrl_setting_mux *setting;
+	unsigned fselector, offset = 0, data = 0, i, j;
+
+	/* If pin is not described in DTS & enabled, mux_setting is NULL. */
+	setting = pdesc->mux_setting;
+	if (!setting)
+		return -ENOTSUPP;
+	fselector = setting->func;
+	func = radix_tree_lookup(&pcs->ftree, fselector);
+	if (!func) {
+		dev_err(pcs->dev, "%s could not find function%i\n",
+			__func__, fselector);
+		return -ENOTSUPP;
+	}
+
+	for (i = 0; i < func->nconfs; i++) {
+		if (pinconf_to_config_param(*config) != func->conf[i].param)
+			continue;
+		offset = pin * (pcs->width / BITS_PER_BYTE);
+		data = pcs->read(pcs->base + offset);
+		data &= func->conf[i].mask;
+		switch (func->conf[i].param) {
+		case PIN_CONFIG_BIAS_DISABLE:
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+		case PIN_CONFIG_BIAS_PULL_UP:
+		case PIN_CONFIG_INPUT_SCHMITT_DISABLE:
+			if (data != func->conf[i].val)
+				return -ENOTSUPP;
+			*config = data;
+			break;
+		case PIN_CONFIG_INPUT_SCHMITT:
+			/* either INPUT_SCHMITT or DISABLE */
+			for (j = 0; j < func->nconfs; j++) {
+				switch (func->conf[j].param) {
+				case PIN_CONFIG_INPUT_SCHMITT_DISABLE:
+					if (data == func->conf[j].val)
+						return -ENOTSUPP;
+					break;
+				default:
+					break;
+				}
+			}
+			*config = data;
+			break;
+		default:
+			*config = data;
+			break;
+		}
+		return 0;
+	}
 	return -ENOTSUPP;
 }
 
 static int pcs_pinconf_set(struct pinctrl_dev *pctldev,
 				unsigned pin, unsigned long config)
 {
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	struct pin_desc *pdesc = pin_desc_get(pctldev, pin);
+	struct pcs_function *func;
+	const struct pinctrl_setting_mux *setting;
+	unsigned fselector;
+	unsigned offset = 0, shift = 0, arg = 0, i, data;
+
+	/* If pin is not described in DTS & enabled, mux_setting is NULL. */
+	setting = pdesc->mux_setting;
+	if (!setting)
+		return -ENOTSUPP;
+	fselector = setting->func;
+	func = radix_tree_lookup(&pcs->ftree, fselector);
+	if (!func) {
+		dev_err(pcs->dev, "%s could not find function%i\n",
+			__func__, fselector);
+		return -ENOTSUPP;
+	}
+
+	for (i = 0; i < func->nconfs; i++) {
+		if (pinconf_to_config_param(config) == func->conf[i].param) {
+			offset = pin * (pcs->width / BITS_PER_BYTE);
+			data = pcs->read(pcs->base + offset);
+			switch (func->conf[i].param) {
+			case PIN_CONFIG_BIAS_DISABLE:
+			case PIN_CONFIG_BIAS_PULL_DOWN:
+			case PIN_CONFIG_BIAS_PULL_UP:
+			case PIN_CONFIG_INPUT_SCHMITT_DISABLE:
+				data &= ~func->conf[i].mask;
+				data |= func->conf[i].val;
+				break;
+			case PIN_CONFIG_INPUT_SCHMITT:
+			case PIN_CONFIG_POWER_SOURCE:
+				shift = ffs(func->conf[i].mask) - 1;
+				arg = pinconf_to_config_argument(config);
+				data &= ~func->conf[i].mask;
+				data |= (arg << shift) & func->conf[i].mask;
+				break;
+			default:
+				return -ENOTSUPP;
+			}
+			pcs->write(data, pcs->base + offset);
+			return 0;
+		}
+	}
 	return -ENOTSUPP;
 }
 
 static int pcs_pinconf_group_get(struct pinctrl_dev *pctldev,
 				unsigned group, unsigned long *config)
 {
-	return -ENOTSUPP;
+	const unsigned *pins;
+	unsigned npins, old;
+	int i, ret;
+
+	ret = pcs_get_group_pins(pctldev, group, &pins, &npins);
+	if (ret)
+		return ret;
+	for (i = 0; i < npins; i++) {
+		if (pcs_pinconf_get(pctldev, pins[i], config))
+			return -ENOTSUPP;
+		/* configs do not match between two pins */
+		if (i && (old != *config))
+			return -ENOTSUPP;
+		old = *config;
+	}
+	return 0;
 }
 
 static int pcs_pinconf_group_set(struct pinctrl_dev *pctldev,
 				unsigned group, unsigned long config)
 {
-	return -ENOTSUPP;
+	const unsigned *pins;
+	unsigned npins;
+	int i, ret;
+
+	ret = pcs_get_group_pins(pctldev, group, &pins, &npins);
+	if (ret)
+		return ret;
+	for (i = 0; i < npins; i++) {
+		if (pcs_pinconf_set(pctldev, pins[i], config))
+			return -ENOTSUPP;
+	}
+	return 0;
 }
 
 static void pcs_pinconf_dbg_show(struct pinctrl_dev *pctldev,
@@ -676,11 +818,137 @@ static int pcs_get_pin_by_offset(struct pcs_device *pcs, unsigned offset)
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
+static void add_config(struct pcs_conf_vals *conf, enum pin_config_param param,
+		       unsigned match, unsigned mask)
+{
+	conf->param = param;
+	conf->val = match;
+	conf->mask = mask;
+}
+
+static void add_setting(unsigned long *setting, enum pin_config_param param,
+			unsigned arg)
+{
+	*setting = pinconf_to_config_packed(param, arg);
+}
+
+static int pcs_parse_pinconf(struct pcs_device *pcs, struct device_node *np,
+			     struct pcs_function *func,
+			     struct pinctrl_map **map)
+
+{
+	struct pinctrl_map *m = *map;
+	int i = 0, c = 0, nconfs = 0, count = 0;
+	unsigned value[5];
+	unsigned long *settings;
+
+	/* If pinconf isn't supported, don't parse properties in below. */
+	if (!pcs->is_pinconf)
+		return 0;
+
+	if (of_find_property(np, "pinctrl-single,bias", NULL)) {
+		/* DISABLE, PULL_DOWN, PULL_UP */
+		count += 3;
+		nconfs++;
+	}
+	if (of_find_property(np, "pinctrl-single,power-source", NULL)) {
+		/* POWER_SOURCE */
+		count++;
+		nconfs++;
+	}
+	if (of_find_property(np, "pinctrl-single,input-schmitt", NULL)) {
+		/* DISABLE, INPUT_SCHMITT */
+		count += 2;
+		nconfs++;
+	}
+	if (!nconfs)
+		return 0;
+
+	func->conf = devm_kzalloc(pcs->dev,
+				  sizeof(struct pcs_conf_vals) * count,
+				  GFP_KERNEL);
+	if (!func->conf)
+		return -ENOMEM;
+	m++;
+	settings = devm_kzalloc(pcs->dev, sizeof(unsigned long) * nconfs,
+				GFP_KERNEL);
+	if (!settings)
+		return -ENOMEM;
+	func->nconfs = count;
+
+	if (!of_property_read_u32_array(np, "pinctrl-single,bias", value, 5)) {
+		value[0] &= value[1];	/* bias value to set */
+		value[2] &= value[1];	/* bias disable */
+		value[3] &= value[1];	/* bias pull down */
+		value[4] &= value[1];	/* bias pull up */
+		add_config(&func->conf[i++], PIN_CONFIG_BIAS_DISABLE,
+			   value[2], value[1]);
+		add_config(&func->conf[i++], PIN_CONFIG_BIAS_PULL_DOWN,
+			   value[3], value[1]);
+		add_config(&func->conf[i++], PIN_CONFIG_BIAS_PULL_UP,
+			   value[4], value[1]);
+		if (pcs_config_match(value[0], value[2])) {
+			add_setting(&settings[c++], PIN_CONFIG_BIAS_DISABLE, 1);
+		} else {
+			if ((value[0] & value[3]) == value[3])
+				add_setting(&settings[c++],
+					    PIN_CONFIG_BIAS_PULL_DOWN, 1);
+			else if ((value[0] & value[4]) == value[4])
+				add_setting(&settings[c++],
+					    PIN_CONFIG_BIAS_PULL_UP, 1);
+		}
+	}
+	if (!of_property_read_u32_array(np, "pinctrl-single,input-schmitt",
+					value, 3)) {
+		value[0] &= value[1];	/* input schmitt */
+		value[2] &= value[1];	/* input schmitt disable */
+		add_config(&func->conf[i++], PIN_CONFIG_INPUT_SCHMITT_DISABLE,
+			   value[2], value[1]);
+		add_config(&func->conf[i++], PIN_CONFIG_INPUT_SCHMITT,
+			   value[1], value[1]);
+		if (pcs_config_match(value[0], value[2]))
+			add_setting(&settings[c++],
+				    PIN_CONFIG_INPUT_SCHMITT_DISABLE, 1);
+		else
+			add_setting(&settings[c++],
+				    PIN_CONFIG_INPUT_SCHMITT, value[0]);
+	}
+	if (!of_property_read_u32_array(np, "pinctrl-single,power-source",
+					value, 2)) {
+		value[0] &= value[1];	/* power source */
+		add_config(&func->conf[i++], PIN_CONFIG_POWER_SOURCE,
+			   value[1], value[1]);
+		add_setting(&settings[c++], PIN_CONFIG_POWER_SOURCE, value[0]);
+	}
+	m->type = PIN_MAP_TYPE_CONFIGS_GROUP;
+	m->data.configs.group_or_pin = np->name;
+	m->data.configs.configs = settings;
+	m->data.configs.num_configs = nconfs;
+	return 0;
+}
+
+static void pcs_free_pingroups(struct pcs_device *pcs);
+
 /**
  * smux_parse_one_pinctrl_entry() - parses a device tree mux entry
  * @pcs: pinctrl driver instance
  * @np: device node of the mux entry
  * @map: map entry
+ * @num_maps: number of map
  * @pgnames: pingroup names
  *
  * Note that this binding currently supports only sets of one register + value.
@@ -697,6 +965,7 @@ static int pcs_get_pin_by_offset(struct pcs_device *pcs, unsigned offset)
 static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 						struct device_node *np,
 						struct pinctrl_map **map,
+						unsigned *num_maps,
 						const char **pgnames)
 {
 	struct pcs_func_vals *vals;
@@ -769,8 +1038,14 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	(*map)->data.mux.group = np->name;
 	(*map)->data.mux.function = np->name;
 
+	if (pcs_parse_pinconf(pcs, np, function, map))
+		goto free_pingroups;
+	*num_maps = 2;
 	return 0;
 
+free_pingroups:
+	pcs_free_pingroups(pcs);
+	*num_maps = 1;
 free_function:
 	pcs_remove_function(pcs, function);
 
@@ -799,7 +1074,8 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	pcs = pinctrl_dev_get_drvdata(pctldev);
 
-	*map = devm_kzalloc(pcs->dev, sizeof(**map), GFP_KERNEL);
+	/* create 2 maps. One is for pinmux, and the other is for pinconf. */
+	*map = devm_kzalloc(pcs->dev, sizeof(**map) * 2, GFP_KERNEL);
 	if (!*map)
 		return -ENOMEM;
 
@@ -811,13 +1087,13 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
 		goto free_map;
 	}
 
-	ret = pcs_parse_one_pinctrl_entry(pcs, np_config, map, pgnames);
+	ret = pcs_parse_one_pinctrl_entry(pcs, np_config, map, num_maps,
+					  pgnames);
 	if (ret < 0) {
 		dev_err(pcs->dev, "no pins entries for %s\n",
 			np_config->name);
 		goto free_pgnames;
 	}
-	*num_maps = 1;
 
 	return 0;
 
@@ -972,6 +1248,7 @@ static int __devinit pcs_probe(struct platform_device *pdev)
 	mutex_init(&pcs->mutex);
 	INIT_LIST_HEAD(&pcs->pingroups);
 	INIT_LIST_HEAD(&pcs->functions);
+	pcs->is_pinconf = match->data;
 
 	PCS_GET_PROP_U32("pinctrl-single,register-width", &pcs->width,
 			 "register width not specified\n");
@@ -1035,6 +1312,8 @@ static int __devinit pcs_probe(struct platform_device *pdev)
 	pcs->desc.pmxops = &pcs_pinmux_ops;
 	pcs->desc.confops = &pcs_pinconf_ops;
 	pcs->desc.owner = THIS_MODULE;
+	if (match->data)
+		pcs_pinconf_ops.is_generic = true;
 
 	ret = pcs_allocate_pin_table(pcs);
 	if (ret < 0)
@@ -1075,7 +1354,8 @@ static int pcs_remove(struct platform_device *pdev)
 }
 
 static struct of_device_id pcs_of_match[] = {
-	{ .compatible = DRIVER_NAME, },
+	{ .compatible = "pinctrl-single", .data = (void *)false },
+	{ .compatible = "pinconf-single", .data = (void *)true },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, pcs_of_match);
-- 
1.7.10.4
