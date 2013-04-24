From: syin@broadcom.com (Sherman Yin)
Date: Wed, 24 Apr 2013 15:03:30 -0700
Subject: [PATCH] ARM: Adds pin config API to set all configs in one
 function
Message-ID: <1366841010-2823-1-git-send-email-syin@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, when setting pin configuration in the pinctrl framework,
pin_config_set() or pin_config_group_set() is called in a loop to set one
configuration at a time for the specified pin or group.

pin_config_set_all() and pin_config_group_set_all() are defined to set all
configurations for the specified pin or group at the same time.  These optional
APIs allow pinctrl drivers to optimize and combine pin configurations to reduce
the number of register writes required to configure a pin.

If both pin_config_set() and pin_config_set_all() are defined by a driver, the
latter takes precedence.  Similarly for pin_config_group_set_all().

Signed-off-by: Sherman Yin <syin@broadcom.com>
---
 drivers/pinctrl/pinconf.c       |   74 ++++++++++++++++++++++++++-------------
 include/linux/pinctrl/pinconf.h |   11 ++++--
 2 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/pinconf.c b/drivers/pinctrl/pinconf.c
index d611ecf..568e4f2 100644
--- a/drivers/pinctrl/pinconf.c
+++ b/drivers/pinctrl/pinconf.c
@@ -34,7 +34,8 @@ int pinconf_check_ops(struct pinctrl_dev *pctldev)
 		return -EINVAL;
 	}
 	/* We have to be able to config the pins in SOME way */
-	if (!ops->pin_config_set && !ops->pin_config_group_set) {
+	if (!ops->pin_config_set && !ops->pin_config_group_set &&
+		!ops->pin_config_set_all && !ops->pin_config_group_set_all) {
 		dev_err(pctldev->dev,
 			"pinconf has to be able to set a pins config\n");
 		return -EINVAL;
@@ -338,40 +339,65 @@ int pinconf_apply_setting(struct pinctrl_setting const *setting)
 
 	switch (setting->type) {
 	case PIN_MAP_TYPE_CONFIGS_PIN:
-		if (!ops->pin_config_set) {
-			dev_err(pctldev->dev, "missing pin_config_set op\n");
-			return -EINVAL;
-		}
-		for (i = 0; i < setting->data.configs.num_configs; i++) {
-			ret = ops->pin_config_set(pctldev,
-					setting->data.configs.group_or_pin,
-					setting->data.configs.configs[i]);
+		if (ops->pin_config_set_all) {
+			ret = ops->pin_config_set_all(pctldev,
+				&setting->data.configs);
 			if (ret < 0) {
 				dev_err(pctldev->dev,
-					"pin_config_set op failed for pin %d config %08lx\n",
-					setting->data.configs.group_or_pin,
-					setting->data.configs.configs[i]);
+					"pin_config_set_all op failed for pin %d\n",
+					setting->data.configs.group_or_pin);
 				return ret;
 			}
-		}
-		break;
-	case PIN_MAP_TYPE_CONFIGS_GROUP:
-		if (!ops->pin_config_group_set) {
+		} else if (ops->pin_config_set) {
+			for (i = 0; i < setting->data.configs.num_configs; i++) {
+				ret = ops->pin_config_set(pctldev,
+						setting->data.configs.group_or_pin,
+						setting->data.configs.configs[i]);
+				if (ret < 0) {
+					dev_err(pctldev->dev,
+						"pin_config_set op failed for "
+						"pin %d config %08lx\n",
+						setting->data.configs.group_or_pin,
+						setting->data.configs.configs[i]);
+					return ret;
+				}
+			}
+		} else {
 			dev_err(pctldev->dev,
-				"missing pin_config_group_set op\n");
+				"missing pin_config_set or "
+				"pin_config_set_all op\n");
 			return -EINVAL;
 		}
-		for (i = 0; i < setting->data.configs.num_configs; i++) {
-			ret = ops->pin_config_group_set(pctldev,
-					setting->data.configs.group_or_pin,
-					setting->data.configs.configs[i]);
+		break;
+	case PIN_MAP_TYPE_CONFIGS_GROUP:
+		if (ops->pin_config_group_set_all) {
+			ret = ops->pin_config_group_set_all(pctldev,
+					&setting->data.configs);
 			if (ret < 0) {
 				dev_err(pctldev->dev,
-					"pin_config_group_set op failed for group %d config %08lx\n",
-					setting->data.configs.group_or_pin,
-					setting->data.configs.configs[i]);
+					"pin_config_group_set_all op failed for group %d\n",
+					setting->data.configs.group_or_pin);
 				return ret;
 			}
+		} else if (ops->pin_config_group_set) {
+			for (i = 0; i < setting->data.configs.num_configs; i++) {
+				ret = ops->pin_config_group_set(pctldev,
+						setting->data.configs.group_or_pin,
+						setting->data.configs.configs[i]);
+				if (ret < 0) {
+					dev_err(pctldev->dev,
+						"pin_config_group_set op failed "
+						"for group %d config %08lx\n",
+						setting->data.configs.group_or_pin,
+						setting->data.configs.configs[i]);
+					return ret;
+				}
+			}
+		} else {
+			dev_err(pctldev->dev,
+				"missing pin_config_group_set or "
+				"pin_config_group_set_all op\n");
+			return -EINVAL;
 		}
 		break;
 	default:
diff --git a/include/linux/pinctrl/pinconf.h b/include/linux/pinctrl/pinconf.h
index e7a7201..b838756 100644
--- a/include/linux/pinctrl/pinconf.h
+++ b/include/linux/pinctrl/pinconf.h
@@ -16,6 +16,7 @@
 
 struct pinctrl_dev;
 struct seq_file;
+struct pinctrl_setting_configs;
 
 /**
  * struct pinconf_ops - pin config operations, to be implemented by
@@ -25,9 +26,11 @@ struct seq_file;
  * @pin_config_get: get the config of a certain pin, if the requested config
  *	is not available on this controller this should return -ENOTSUPP
  *	and if it is available but disabled it should return -EINVAL
- * @pin_config_set: configure an individual pin
+ * @pin_config_set: apply one configuration to an individual pin
+ * @pin_config_set_all: apply all configurations to an individual pin
  * @pin_config_group_get: get configurations for an entire pin group
- * @pin_config_group_set: configure all pins in a group
+ * @pin_config_group_set: apply one configuration to all pins in a group
+ * @pin_config_group_set_all: apply all configurations to all pins in a group
  * @pin_config_dbg_show: optional debugfs display hook that will provide
  *	per-device info for a certain pin in debugfs
  * @pin_config_group_dbg_show: optional debugfs display hook that will provide
@@ -45,12 +48,16 @@ struct pinconf_ops {
 	int (*pin_config_set) (struct pinctrl_dev *pctldev,
 			       unsigned pin,
 			       unsigned long config);
+	int (*pin_config_set_all) (struct pinctrl_dev *pctldev,
+				   const struct pinctrl_setting_configs *configs);
 	int (*pin_config_group_get) (struct pinctrl_dev *pctldev,
 				     unsigned selector,
 				     unsigned long *config);
 	int (*pin_config_group_set) (struct pinctrl_dev *pctldev,
 				     unsigned selector,
 				     unsigned long config);
+	int (*pin_config_group_set_all) (struct pinctrl_dev *pctldev,
+					 const struct pinctrl_setting_configs *configs);
 	void (*pin_config_dbg_show) (struct pinctrl_dev *pctldev,
 				     struct seq_file *s,
 				     unsigned offset);
-- 
1.7.9.5
