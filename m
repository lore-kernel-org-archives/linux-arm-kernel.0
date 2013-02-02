From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun,  3 Feb 2013 01:25:51 +0800
Subject: [PATCH v8 10/12] pinctrl: single: support generic pinconf
In-Reply-To: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1359825953-15663-11-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the operation of generic pinconf. The supported config arguments
are INPUT_SCHMITT, INPUT_SCHMITT_DISABLE, POWER_SOURCE, BIAS_DISABLE,
BIAS_PULLUP, BIAS_PULLDOWN, SLEW_RATE.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/pinctrl/Kconfig          |    1 +
 drivers/pinctrl/pinctrl-single.c |  339 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 333 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 9db3497..066581c 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -154,6 +154,7 @@ config PINCTRL_SINGLE
 	depends on OF
 	select PINMUX
 	select PINCONF
+	select GENERIC_PINCONF
 	help
 	  This selects the device tree based generic pinctrl driver.
 
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index fe8f321..1d9f3cc 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -22,8 +22,10 @@
 
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinconf-generic.h>
 
 #include "core.h"
+#include "pinconf.h"
 
 #define DRIVER_NAME			"pinctrl-single"
 #define PCS_MUX_PINS_NAME		"pinctrl-single,pins"
@@ -59,6 +61,31 @@ struct pcs_func_vals {
 };
 
 /**
+ * struct pcs_conf_vals - pinconf parameter, pinconf register offset
+ * and value, match, mask
+ * @param:	config parameter
+ * @val:	register value
+ * @match:	register match value
+ * @mask:	mask of register value
+ */
+struct pcs_conf_vals {
+	enum pin_config_param param;
+	unsigned val;
+	unsigned match;
+	unsigned mask;
+};
+
+/**
+ * struct pcs_conf_type - pinconf property name, pinconf param pair
+ * @name:	property name in DTS file
+ * @param:	config parameter
+ */
+struct pcs_conf_type {
+	const char *name;
+	enum pin_config_param param;
+};
+
+/**
  * struct pcs_function - pinctrl function
  * @name:	pinctrl function name
  * @vals:	register and vals array
@@ -73,6 +100,8 @@ struct pcs_function {
 	unsigned nvals;
 	const char **pgnames;
 	int npgnames;
+	struct pcs_conf_vals *conf;
+	int nconfs;
 	struct list_head node;
 };
 
@@ -131,6 +160,7 @@ struct pcs_name {
  * @fshift:	function register shift
  * @foff:	value to turn mux off
  * @fmax:	max number of functions in fmask
+ * @is_pinconf:	whether supports pinconf
  * @names:	array of register names for pins
  * @pins:	physical pins on the SoC
  * @pgtree:	pingroup index radix tree
@@ -157,6 +187,7 @@ struct pcs_device {
 	unsigned foff;
 	unsigned fmax;
 	bool bits_per_mux;
+	bool is_pinconf;
 	struct pcs_name *names;
 	struct pcs_data pins;
 	struct radix_tree_root pgtree;
@@ -342,6 +373,28 @@ static int pcs_get_function_groups(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int pcs_get_function(struct pinctrl_dev *pctldev, unsigned pin,
+			    struct pcs_function **func)
+{
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	struct pin_desc *pdesc = pin_desc_get(pctldev, pin);
+	const struct pinctrl_setting_mux *setting;
+	unsigned fselector;
+
+	/* If pin is not described in DTS & enabled, mux_setting is NULL. */
+	setting = pdesc->mux_setting;
+	if (!setting)
+		return -ENOTSUPP;
+	fselector = setting->func;
+	*func = radix_tree_lookup(&pcs->ftree, fselector);
+	if (!(*func)) {
+		dev_err(pcs->dev, "%s could not find function%i\n",
+			__func__, fselector);
+		return -ENOTSUPP;
+	}
+	return 0;
+}
+
 static int pcs_enable(struct pinctrl_dev *pctldev, unsigned fselector,
 	unsigned group)
 {
@@ -464,29 +517,137 @@ static struct pinmux_ops pcs_pinmux_ops = {
 static int pcs_pinconf_get(struct pinctrl_dev *pctldev,
 				unsigned pin, unsigned long *config)
 {
+	struct pcs_device *pcs = pinctrl_dev_get_drvdata(pctldev);
+	struct pcs_function *func;
+	unsigned offset = 0, data = 0, i, j, ret;
+
+	ret = pcs_get_function(pctldev, pin, &func);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < func->nconfs; i++) {
+		if (pinconf_to_config_param(*config) != func->conf[i].param)
+			continue;
+		offset = pin * (pcs->width / BITS_PER_BYTE);
+		data = pcs->read(pcs->base + offset) & func->conf[i].mask;
+		switch (func->conf[i].param) {
+		/* 3 parameters */
+		case PIN_CONFIG_BIAS_DISABLE:
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+		case PIN_CONFIG_BIAS_PULL_UP:
+		case PIN_CONFIG_INPUT_SCHMITT_DISABLE:
+			if (data != func->conf[i].match)
+				return -ENOTSUPP;
+			*config = data;
+			break;
+		case PIN_CONFIG_INPUT_SCHMITT:
+			/* either INPUT_SCHMITT or DISABLE */
+			for (j = 0; j < func->nconfs; j++) {
+				switch (func->conf[j].param) {
+				case PIN_CONFIG_INPUT_SCHMITT_DISABLE:
+					if (data == func->conf[j].match)
+						return -ENOTSUPP;
+					break;
+				default:
+					break;
+				}
+			}
+			*config = data;
+			break;
+		case PIN_CONFIG_DRIVE_STRENGTH:
+		case PIN_CONFIG_SLEW_RATE:
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
+	struct pcs_function *func;
+	unsigned offset = 0, shift = 0, arg = 0, i, data, ret;
+
+	ret = pcs_get_function(pctldev, pin, &func);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < func->nconfs; i++) {
+		if (pinconf_to_config_param(config) == func->conf[i].param) {
+			offset = pin * (pcs->width / BITS_PER_BYTE);
+			data = pcs->read(pcs->base + offset);
+			switch (func->conf[i].param) {
+			/* 2 parameters */
+			case PIN_CONFIG_INPUT_SCHMITT:
+			case PIN_CONFIG_DRIVE_STRENGTH:
+			case PIN_CONFIG_SLEW_RATE:
+				shift = ffs(func->conf[i].mask) - 1;
+				arg = pinconf_to_config_argument(config);
+				data &= ~func->conf[i].mask;
+				data |= (arg << shift) & func->conf[i].mask;
+				break;
+			/* 3 parameters */
+			case PIN_CONFIG_BIAS_DISABLE:
+			case PIN_CONFIG_BIAS_PULL_DOWN:
+			case PIN_CONFIG_BIAS_PULL_UP:
+			case PIN_CONFIG_INPUT_SCHMITT_DISABLE:
+				data &= ~func->conf[i].mask;
+				data |= func->conf[i].val;
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
+	unsigned npins, old = 0;
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
-				struct seq_file *s, unsigned offset)
+				struct seq_file *s, unsigned pin)
 {
 }
 
@@ -495,6 +656,13 @@ static void pcs_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
 {
 }
 
+static void pcs_pinconf_config_dbg_show(struct pinctrl_dev *pctldev,
+					struct seq_file *s,
+					unsigned long config)
+{
+	pinconf_generic_dump_config(pctldev, s, config);
+}
+
 static struct pinconf_ops pcs_pinconf_ops = {
 	.pin_config_get = pcs_pinconf_get,
 	.pin_config_set = pcs_pinconf_set,
@@ -502,6 +670,7 @@ static struct pinconf_ops pcs_pinconf_ops = {
 	.pin_config_group_set = pcs_pinconf_group_set,
 	.pin_config_dbg_show = pcs_pinconf_dbg_show,
 	.pin_config_group_dbg_show = pcs_pinconf_group_dbg_show,
+	.pin_config_config_dbg_show = pcs_pinconf_config_dbg_show,
 };
 
 /**
@@ -692,11 +861,151 @@ static int pcs_get_pin_by_offset(struct pcs_device *pcs, unsigned offset)
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
+static void add_config(struct pcs_conf_vals **conf, enum pin_config_param param,
+		       unsigned value, unsigned match, unsigned mask)
+{
+	(*conf)->param = param;
+	(*conf)->val = value;
+	(*conf)->match = match;
+	(*conf)->mask = mask;
+	(*conf)++;
+}
+
+static void add_setting(unsigned long **setting, enum pin_config_param param,
+			unsigned arg)
+{
+	**setting = pinconf_to_config_packed(param, arg);
+	(*setting)++;
+}
+
+/* add pinconf setting with 2 parameters */
+static void pcs_add_conf2(struct device_node *np, const char *name,
+			  enum pin_config_param param,
+			  struct pcs_conf_vals **conf,
+			  unsigned long **settings)
+{
+	unsigned value[2];
+	int ret;
+
+	ret = of_property_read_u32_array(np, name, value, 2);
+	if (ret)
+		return;
+	/* value to set,  mask */
+	value[0] &= value[1];
+	add_config(conf, param, value[0], 0, value[1]);
+	add_setting(settings, param, value[0]);
+}
+
+/* add pinconf setting with 3 parameters */
+static void pcs_add_conf3(struct device_node *np, const char *name,
+			  enum pin_config_param param,
+			  struct pcs_conf_vals **conf,
+			  unsigned long **settings)
+{
+	unsigned value[3];
+	int ret;
+
+	ret = of_property_read_u32_array(np, name, value, 3);
+	if (ret)
+		return;
+	/* value to set, match, mask */
+	value[0] &= value[2];
+	value[1] &= value[2];
+	add_config(conf, param, value[0], value[1], value[2]);
+	if (pcs_config_match(value[0], value[1]))
+		ret = 1;
+	else
+		ret = 0;
+	add_setting(settings, param, ret);
+}
+
+static int pcs_parse_pinconf(struct pcs_device *pcs, struct device_node *np,
+			     struct pcs_function *func,
+			     struct pinctrl_map **map)
+
+{
+	struct pinctrl_map *m = *map;
+	int i = 0, nconfs = 0;
+	unsigned long *settings = NULL, *s = NULL;
+	struct pcs_conf_vals *conf = NULL;
+	struct pcs_conf_type prop2[] = {
+		{ "pinctrl-single,drive-strength", PIN_CONFIG_DRIVE_STRENGTH, },
+		{ "pinctrl-single,slew-rate", PIN_CONFIG_SLEW_RATE, },
+		{ "pinctrl-single,input-schmitt", PIN_CONFIG_INPUT_SCHMITT, },
+	};
+	struct pcs_conf_type prop3[] = {
+		{ "pinctrl-single,bias-disable", PIN_CONFIG_BIAS_DISABLE, },
+		{ "pinctrl-single,bias-pullup", PIN_CONFIG_BIAS_PULL_UP, },
+		{ "pinctrl-single,bias-pulldown", PIN_CONFIG_BIAS_PULL_DOWN, },
+		{ "pinctrl-single,input-schmitt-disable",
+			PIN_CONFIG_INPUT_SCHMITT_DISABLE, },
+	};
+
+	/* If pinconf isn't supported, don't parse properties in below. */
+	if (!pcs->is_pinconf)
+		return 0;
+
+	/* cacluate how much properties are supported in current node */
+	for (i = 0; i < ARRAY_SIZE(prop2); i++) {
+		if (of_find_property(np, prop2[i].name, NULL))
+			nconfs++;
+	}
+	for (i = 0; i < ARRAY_SIZE(prop3); i++) {
+		if (of_find_property(np, prop3[i].name, NULL))
+			nconfs++;
+	}
+	if (!nconfs)
+		return 0;
+
+	func->conf = devm_kzalloc(pcs->dev,
+				  sizeof(struct pcs_conf_vals) * nconfs,
+				  GFP_KERNEL);
+	if (!func->conf)
+		return -ENOMEM;
+	func->nconfs = nconfs;
+	conf = &(func->conf[0]);
+	m++;
+	settings = devm_kzalloc(pcs->dev, sizeof(unsigned long) * nconfs,
+				GFP_KERNEL);
+	if (!settings)
+		return -ENOMEM;
+	s = &settings[0];
+
+	for (i = 0; i < ARRAY_SIZE(prop2); i++) {
+		pcs_add_conf2(np, prop2[i].name, prop2[i].param, &conf, &s);
+	}
+	for (i = 0; i < ARRAY_SIZE(prop3); i++) {
+		pcs_add_conf3(np, prop3[i].name, prop3[i].param, &conf, &s);
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
@@ -713,6 +1022,7 @@ static int pcs_get_pin_by_offset(struct pcs_device *pcs, unsigned offset)
 static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 						struct device_node *np,
 						struct pinctrl_map **map,
+						unsigned *num_maps,
 						const char **pgnames)
 {
 	struct pcs_func_vals *vals;
@@ -785,8 +1095,18 @@ static int pcs_parse_one_pinctrl_entry(struct pcs_device *pcs,
 	(*map)->data.mux.group = np->name;
 	(*map)->data.mux.function = np->name;
 
+	if (pcs->is_pinconf) {
+		if (pcs_parse_pinconf(pcs, np, function, map))
+			goto free_pingroups;
+		*num_maps = 2;
+	} else {
+		*num_maps = 1;
+	}
 	return 0;
 
+free_pingroups:
+	pcs_free_pingroups(pcs);
+	*num_maps = 1;
 free_function:
 	pcs_remove_function(pcs, function);
 
@@ -815,7 +1135,8 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	pcs = pinctrl_dev_get_drvdata(pctldev);
 
-	*map = devm_kzalloc(pcs->dev, sizeof(**map), GFP_KERNEL);
+	/* create 2 maps. One is for pinmux, and the other is for pinconf. */
+	*map = devm_kzalloc(pcs->dev, sizeof(**map) * 2, GFP_KERNEL);
 	if (!*map)
 		return -ENOMEM;
 
@@ -827,13 +1148,13 @@ static int pcs_dt_node_to_map(struct pinctrl_dev *pctldev,
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
 
@@ -976,6 +1297,7 @@ static int pcs_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&pcs->pingroups);
 	INIT_LIST_HEAD(&pcs->functions);
 	INIT_LIST_HEAD(&pcs->gpiofuncs);
+	pcs->is_pinconf = match->data;
 
 	PCS_GET_PROP_U32("pinctrl-single,register-width", &pcs->width,
 			 "register width not specified\n");
@@ -1046,6 +1368,8 @@ static int pcs_probe(struct platform_device *pdev)
 	pcs->desc.pmxops = &pcs_pinmux_ops;
 	pcs->desc.confops = &pcs_pinconf_ops;
 	pcs->desc.owner = THIS_MODULE;
+	if (match->data)
+		pcs_pinconf_ops.is_generic = true;
 
 	ret = pcs_allocate_pin_table(pcs);
 	if (ret < 0)
@@ -1086,7 +1410,8 @@ static int pcs_remove(struct platform_device *pdev)
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
