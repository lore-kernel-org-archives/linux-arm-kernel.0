From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 2 Apr 2015 11:38:14 +0200
Subject: [RFC PATCH 2/4] pinctrl: introduce complex pin description
In-Reply-To: <1427967496-22533-1-git-send-email-ludovic.desroches@atmel.com>
References: <1427967496-22533-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1427967496-22533-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some extra information may be needed to describe a pin, mainly for
controllers support per pin muxing where groups are an abstract concept.
Instead of using its name, use a 32 bit value whose 16 lowest bits are used
for the pin number and the 16 highest ones can be used for extra information.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/pinctrl/pinconf-generic.c | 115 +++++++++++++++++++++++++++-----------
 include/linux/pinctrl/pinctrl.h   |   5 ++
 2 files changed, 86 insertions(+), 34 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index e088666..11f9d1b 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -268,28 +268,53 @@ out:
 	return ret;
 }
 
-int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
+int pinconf_generic_dt_subnode_to_mux_map(struct pinctrl_dev *pctldev,
 		struct device_node *np, struct pinctrl_map **map,
 		unsigned *reserved_maps, unsigned *num_maps,
-		enum pinctrl_map_type type)
+		const char *function)
 {
 	int ret;
-	const char *function;
-	struct device *dev = pctldev->dev;
-	unsigned long *configs = NULL;
-	unsigned num_configs = 0;
-	unsigned reserve;
-	struct property *prop;
 	const char *group;
-	const char *subnode_target_type = "pins";
+	struct property *prop;
+	struct device *dev = pctldev->dev;
 
 	ret = of_property_read_string(np, "function", &function);
-	if (ret < 0) {
-		/* EINVAL=missing, which is fine since it's optional */
-		if (ret != -EINVAL)
-			dev_err(dev, "could not parse property function\n");
-		function = NULL;
+
+	of_property_for_each_string(np, "groups", prop, group) {
+
+		ret = pinctrl_utils_reserve_map(pctldev, map, reserved_maps,
+				num_maps, 1);
+		if (ret < 0)
+			goto exit;
+
+		ret = pinctrl_utils_add_map_mux(pctldev, map, reserved_maps,
+			num_maps, group, function);
+		if (ret < 0)
+			goto exit;
 	}
+	ret = 0;
+
+exit:
+	return ret;
+}
+
+int pinconf_generic_dt_subnode_to_conf_map(struct pinctrl_dev *pctldev,
+		struct device_node *np, struct pinctrl_map **map,
+		unsigned *reserved_maps, unsigned *num_maps,
+		enum pinctrl_map_type type)
+{
+	const struct pinctrl_desc *pctldesc = pctldev->desc;
+	int ret;
+	unsigned reserve, pin_id;
+	unsigned long *configs = NULL;
+	const char *pin;
+	const char *group;
+	const char *subnode_target_type = "pins";
+	struct property *prop;
+	const __be32 *cur;
+	u32 val;
+	unsigned num_configs = 0;
+	struct device *dev = pctldev->dev;
 
 	ret = pinconf_generic_parse_dt_config(np, pctldev, &configs,
 					      &num_configs);
@@ -298,14 +323,7 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		return ret;
 	}
 
-	reserve = 0;
-	if (function != NULL)
-		reserve++;
-	if (num_configs)
-		reserve++;
-
-	ret = of_property_count_strings(np, "pins");
-	if (ret < 0) {
+	if (!of_property_read_bool(np, "pins")) {
 		ret = of_property_count_strings(np, "groups");
 		if (ret < 0) {
 			dev_err(dev, "could not parse property pins/groups\n");
@@ -315,26 +333,35 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 			type = PIN_MAP_TYPE_CONFIGS_GROUP;
 		subnode_target_type = "groups";
 	} else {
+		if (pctldesc->complex_pin_desc)
+			ret = of_property_count_u32_elems(np, "pins");
+		else
+			ret = of_property_count_strings(np, "pins");
+
+		if (ret < 0) {
+			dev_err(dev, "could not parse property pins\n");
+			goto exit;
+		}
 		if (type == PIN_MAP_TYPE_INVALID)
 			type = PIN_MAP_TYPE_CONFIGS_PIN;
 	}
-	reserve *= ret;
+	reserve = ret;
 
 	ret = pinctrl_utils_reserve_map(pctldev, map, reserved_maps,
 			num_maps, reserve);
 	if (ret < 0)
 		goto exit;
 
-	of_property_for_each_string(np, subnode_target_type, prop, group) {
-		if (function) {
-			ret = pinctrl_utils_add_map_mux(pctldev, map,
-					reserved_maps, num_maps, group,
-					function);
-			if (ret < 0)
-				goto exit;
+	if (pctldesc->complex_pin_desc) {
+		of_property_for_each_u32(np, subnode_target_type, prop, cur, val) {
+			pin_id = val & PINCTRL_PIN_MASK;
+			pin = pctldesc->pins[pin_id].name;
+			ret = pinctrl_utils_add_map_configs(pctldev, map,
+					reserved_maps, num_maps, pin, configs,
+					num_configs, type);
 		}
-
-		if (num_configs) {
+	} else {
+		of_property_for_each_string(np, subnode_target_type, prop, group) {
 			ret = pinctrl_utils_add_map_configs(pctldev, map,
 					reserved_maps, num_maps, group, configs,
 					num_configs, type);
@@ -342,12 +369,32 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 				goto exit;
 		}
 	}
-	ret = 0;
-
 exit:
 	kfree(configs);
 	return ret;
 }
+
+int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
+		struct device_node *np, struct pinctrl_map **map,
+		unsigned *reserved_maps, unsigned *num_maps,
+		enum pinctrl_map_type type)
+{
+	int ret;
+	const char *function;
+	struct device *dev = pctldev->dev;
+
+	ret = of_property_read_string(np, "function", &function);
+	if (ret < 0) {
+		/* EINVAL=missing, which is fine since it's optional */
+		if (ret != -EINVAL)
+			dev_err(dev, "could not parse property function\n");
+		return pinconf_generic_dt_subnode_to_conf_map(pctldev,
+				np, map, reserved_maps, num_maps, type);
+	} else {
+		return pinconf_generic_dt_subnode_to_mux_map(pctldev,
+				np, map, reserved_maps, num_maps, function);
+	}
+}
 EXPORT_SYMBOL_GPL(pinconf_generic_dt_subnode_to_map);
 
 int pinconf_generic_dt_node_to_map(struct pinctrl_dev *pctldev,
diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
index c58b3e1..06a070a 100644
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
@@ -112,6 +114,8 @@ struct pinctrl_ops {
  *	this pin controller
  * @npins: number of descriptors in the array, usually just ARRAY_SIZE()
  *	of the pins field above
+ * @complex_pin_desc: some pin controller needs more information than the pin
+ * 	name. In this case pins property uses u32 elements instead of strings
  * @pctlops: pin control operation vtable, to support global concepts like
  *	grouping of pins, this is optional.
  * @pmxops: pinmux operations vtable, if you support pinmuxing in your driver
@@ -126,6 +130,7 @@ struct pinctrl_desc {
 	const char *name;
 	struct pinctrl_pin_desc const *pins;
 	unsigned int npins;
+	bool complex_pin_desc;
 	const struct pinctrl_ops *pctlops;
 	const struct pinmux_ops *pmxops;
 	const struct pinconf_ops *confops;
-- 
2.2.0
