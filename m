From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Sep 2014 11:22:57 +0200
Subject: [PATCH 2/2] pinctrl: abx500: refactor DT parser to take two paths
Message-ID: <1412068977-24296-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We refactor the DT parser to look for either a config or a
function and then look for further nodes and reserve maps,
not the two things mixed up like prior to this patch.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/nomadik/pinctrl-abx500.c | 54 +++++++++++++++++---------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/nomadik/pinctrl-abx500.c b/drivers/pinctrl/nomadik/pinctrl-abx500.c
index be95f5e68c01..af0d417fe3fb 100644
--- a/drivers/pinctrl/nomadik/pinctrl-abx500.c
+++ b/drivers/pinctrl/nomadik/pinctrl-abx500.c
@@ -893,19 +893,32 @@ static int abx500_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	unsigned long *configs;
 	unsigned int nconfigs = 0;
 	bool has_config = 0;
-	unsigned reserve = 0;
 	struct property *prop;
 	const char *group, *gpio_name;
 	struct device_node *np_config;
 
 	ret = of_property_read_string(np, "ste,function", &function);
-	if (ret >= 0)
-		reserve = 1;
+	if (ret >= 0) {
+		ret = of_property_count_strings(np, "ste,pins");
+		if (ret < 0)
+			goto exit;
+
+		ret = pinctrl_utils_reserve_map(pctldev, map, reserved_maps,
+						num_maps, ret);
+		if (ret < 0)
+			goto exit;
+
+		of_property_for_each_string(np, "ste,pins", prop, group) {
+			ret = abx500_dt_add_map_mux(map, reserved_maps,
+					num_maps, group, function);
+			if (ret < 0)
+				goto exit;
+		}
+	}
 
 	ret = pinconf_generic_parse_dt_config(np, &configs, &nconfigs);
 	if (nconfigs)
 		has_config = 1;
-
 	np_config = of_parse_phandle(np, "ste,config", 0);
 	if (np_config) {
 		ret = pinconf_generic_parse_dt_config(np_config, &configs,
@@ -914,29 +927,18 @@ static int abx500_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 			goto exit;
 		has_config |= nconfigs;
 	}
+	if (has_config) {
+		ret = of_property_count_strings(np, "ste,pins");
+		if (ret < 0)
+			goto exit;
 
-	ret = of_property_count_strings(np, "ste,pins");
-	if (ret < 0)
-		goto exit;
-
-	if (has_config)
-		reserve++;
-
-	reserve *= ret;
-
-	ret = pinctrl_utils_reserve_map(pctldev, map, reserved_maps,
-					num_maps, reserve);
-	if (ret < 0)
-		goto exit;
+		ret = pinctrl_utils_reserve_map(pctldev, map,
+						reserved_maps,
+						num_maps, ret);
+		if (ret < 0)
+			goto exit;
 
-	of_property_for_each_string(np, "ste,pins", prop, group) {
-		if (function) {
-			ret = abx500_dt_add_map_mux(map, reserved_maps,
-					num_maps, group, function);
-			if (ret < 0)
-				goto exit;
-		}
-		if (has_config) {
+		of_property_for_each_string(np, "ste,pins", prop, group) {
 			gpio_name = abx500_find_pin_name(pctldev, group);
 
 			ret = abx500_dt_add_map_configs(map, reserved_maps,
@@ -944,8 +946,8 @@ static int abx500_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 			if (ret < 0)
 				goto exit;
 		}
-
 	}
+
 exit:
 	return ret;
 }
-- 
1.9.3
