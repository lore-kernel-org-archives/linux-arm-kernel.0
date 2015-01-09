From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri,  9 Jan 2015 07:43:45 -0800
Subject: [PATCH v4 1/7] pinctrl: pinconf-generic: Infer map type from DT
 property
In-Reply-To: <1420818231-13451-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1420818231-13451-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1420818231-13451-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the new 'groups' property, the DT parser can infer the map type
from the fact whether 'pins' or 'groups' is used to specify the pin
group to work on.
To maintain backwards compatibitliy with current usage of the DT
binding, this is only done when PIN_MAP_TYPE_INVALID is passed to the
parsing function as type.
Also, a new helper 'pinconf_generic_dt_node_to_map_all()' is introduced,
which can be used by drivers as generic callback for dt_node_to_map() to
leverage the new feature.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Tested-by: Andreas F?rber <afaerber@suse.de>
---
Changes since v2:
 - rename dt_pin_specifier to subnode_target_type
 - add additional comment in header file explaining passing an invalid
   map type
 - mention map_all() helper in commit message
Changes since RFC v2:
 - none
---
 drivers/pinctrl/pinconf-generic.c       | 17 ++++++++++++++---
 include/linux/pinctrl/pinconf-generic.h | 11 +++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index f78b416d7984..21b3d90ebb2d 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -264,6 +264,7 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	unsigned reserve;
 	struct property *prop;
 	const char *group;
+	const char *subnode_target_type = "pins";
 
 	ret = of_property_read_string(np, "function", &function);
 	if (ret < 0) {
@@ -284,10 +285,20 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		reserve++;
 	if (num_configs)
 		reserve++;
+
 	ret = of_property_count_strings(np, "pins");
 	if (ret < 0) {
-		dev_err(dev, "could not parse property pins\n");
-		goto exit;
+		ret = of_property_count_strings(np, "groups");
+		if (ret < 0) {
+			dev_err(dev, "could not parse property pins/groups\n");
+			goto exit;
+		}
+		if (type == PIN_MAP_TYPE_INVALID)
+			type = PIN_MAP_TYPE_CONFIGS_GROUP;
+		subnode_target_type = "groups";
+	} else {
+		if (type == PIN_MAP_TYPE_INVALID)
+			type = PIN_MAP_TYPE_CONFIGS_PIN;
 	}
 	reserve *= ret;
 
@@ -296,7 +307,7 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	if (ret < 0)
 		goto exit;
 
-	of_property_for_each_string(np, "pins", prop, group) {
+	of_property_for_each_string(np, subnode_target_type, prop, group) {
 		if (function) {
 			ret = pinctrl_utils_add_map_mux(pctldev, map,
 					reserved_maps, num_maps, group,
diff --git a/include/linux/pinctrl/pinconf-generic.h b/include/linux/pinctrl/pinconf-generic.h
index d578a60eff23..83c89f5ab705 100644
--- a/include/linux/pinctrl/pinconf-generic.h
+++ b/include/linux/pinctrl/pinconf-generic.h
@@ -174,6 +174,17 @@ static inline int pinconf_generic_dt_node_to_map_pin(
 			PIN_MAP_TYPE_CONFIGS_PIN);
 }
 
+static inline int pinconf_generic_dt_node_to_map_all(
+		struct pinctrl_dev *pctldev, struct device_node *np_config,
+		struct pinctrl_map **map, unsigned *num_maps)
+{
+	/*
+	 * passing the type as PIN_MAP_TYPE_INVALID causes the underlying parser
+	 * to infer the map type from the DT properties used.
+	 */
+	return pinconf_generic_dt_node_to_map(pctldev, np_config, map, num_maps,
+			PIN_MAP_TYPE_INVALID);
+}
 #endif
 
 #endif /* CONFIG_GENERIC_PINCONF */
-- 
2.2.1.1.gb42cc81
