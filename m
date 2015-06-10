From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 10 Jun 2015 17:04:57 +0200
Subject: [RESEND PATCH 2/2] pinctrl: introduce complex pin description
In-Reply-To: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
References: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1433948699-19800-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using a string to describe a pin in the device tree can be not enough.
Some controllers may need extra information to fully describe a pin. It
concerns mainly controllers which have a per pin muxing approach which
don't fit well the notions of groups and functions.
Instead of using a pin name, a 32 bit value is used. The 16 least
significant bits are used for the pin number. Other 16 bits can be used to
store extra parameters.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/pinctrl/pinconf-generic.c | 44 ++++++++++++++++++++++++++++++---------
 include/linux/pinctrl/pinctrl.h   |  6 ++++++
 2 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index e63ad9f..46048cb 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -278,17 +278,25 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		unsigned *reserved_maps, unsigned *num_maps,
 		enum pinctrl_map_type type)
 {
-	int ret;
+	int ret, i = 0;
 	const char *function;
 	struct device *dev = pctldev->dev;
 	unsigned long *configs = NULL;
 	unsigned num_configs = 0;
-	unsigned reserve, strings_count;
+	unsigned reserve, items_count, pin_id;
 	struct property *prop;
 	const char *group;
 	const char *subnode_target_type = "pins";
-
-	ret = of_property_count_strings(np, "pins");
+	const char **items_name = NULL;
+	struct pinctrl_desc *pctldesc = pctldev->desc;
+	const __be32 *cur;
+	u32 val;
+	bool pins_prop = true;
+
+	if (pctldesc->complex_pin_desc)
+		ret = of_property_count_u32_elems(np, "pins");
+	else
+		ret = of_property_count_strings(np, "pins");
 	if (ret < 0) {
 		ret = of_property_count_strings(np, "groups");
 		if (ret < 0)
@@ -297,11 +305,12 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		if (type == PIN_MAP_TYPE_INVALID)
 			type = PIN_MAP_TYPE_CONFIGS_GROUP;
 		subnode_target_type = "groups";
+		pins_prop = false;
 	} else {
 		if (type == PIN_MAP_TYPE_INVALID)
 			type = PIN_MAP_TYPE_CONFIGS_PIN;
 	}
-	strings_count = ret;
+	items_count = ret;
 
 	ret = of_property_read_string(np, "function", &function);
 	if (ret < 0) {
@@ -326,17 +335,31 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	if (num_configs)
 		reserve++;
 
-	reserve *= strings_count;
+	reserve *= items_count;
 
 	ret = pinctrl_utils_reserve_map(pctldev, map, reserved_maps,
 			num_maps, reserve);
 	if (ret < 0)
 		goto exit;
 
-	of_property_for_each_string(np, subnode_target_type, prop, group) {
+	items_name = kmalloc_array(items_count, sizeof(char *), GFP_KERNEL);
+	if (!items_name)
+		goto exit;
+	if (pctldesc->complex_pin_desc && pins_prop) {
+		of_property_for_each_u32(np, subnode_target_type, prop, cur, val) {
+			pin_id = val & PINCTRL_PIN_MASK;
+			items_name[i++] = pctldesc->pins[pin_id].name;
+		}
+	} else {
+		of_property_for_each_string(np, subnode_target_type, prop, group) {
+			items_name[i++] = group;
+		}
+	}
+
+	for (i = 0; i < items_count; i++) {
 		if (function) {
 			ret = pinctrl_utils_add_map_mux(pctldev, map,
-					reserved_maps, num_maps, group,
+					reserved_maps, num_maps, items_name[i],
 					function);
 			if (ret < 0)
 				goto exit;
@@ -344,8 +367,8 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 
 		if (num_configs) {
 			ret = pinctrl_utils_add_map_configs(pctldev, map,
-					reserved_maps, num_maps, group, configs,
-					num_configs, type);
+					reserved_maps, num_maps, items_name[i],
+					configs, num_configs, type);
 			if (ret < 0)
 				goto exit;
 		}
@@ -353,6 +376,7 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	ret = 0;
 
 exit:
+	kfree(items_name);
 	kfree(configs);
 	return ret;
 }
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index 66e4697..116c059 100644
--- a/include/linux/pinctrl/pinctrl.h
+++ b/include/linux/pinctrl/pinctrl.h
@@ -45,6 +45,8 @@ struct pinctrl_pin_desc {
 #define PINCTRL_PIN(a, b) { .number = a, .name = b }
 #define PINCTRL_PIN_ANON(a) { .number = a }
 
+#define PINCTRL_PIN_MASK	0xffff
+
 /**
  * struct pinctrl_gpio_range - each pin controller can provide subranges of
  * the GPIO number space to be handled by the controller
@@ -112,6 +114,9 @@ struct pinctrl_ops {
  *	this pin controller
  * @npins: number of descriptors in the array, usually just ARRAY_SIZE()
  *	of the pins field above
+ * @complex_pin_desc: some pin controllers need more information than the pin
+ *	name. In this case, pins property uses u32 instead of string. In this
+ *	value there is the pin number plus optional parameters.
  * @pctlops: pin control operation vtable, to support global concepts like
  *	grouping of pins, this is optional.
  * @pmxops: pinmux operations vtable, if you support pinmuxing in your driver
@@ -129,6 +134,7 @@ struct pinctrl_desc {
 	const char *name;
 	struct pinctrl_pin_desc const *pins;
 	unsigned int npins;
+	bool complex_pin_desc;
 	const struct pinctrl_ops *pctlops;
 	const struct pinmux_ops *pmxops;
 	const struct pinconf_ops *confops;
-- 
2.2.0
