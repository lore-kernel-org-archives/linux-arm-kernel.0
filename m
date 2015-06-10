From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 10 Jun 2015 17:04:56 +0200
Subject: [RESEND PATCH 1/2] pinctrl: change function behavior for per pin
 muxing controllers
In-Reply-To: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
References: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1433948699-19800-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When having a controller which allows per pin muxing, declaring with
which groups a function can be used is a useless constraint since groups
are something virtual.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/pinctrl/pinmux.c       | 58 +++++++++++++++++++++++-------------------
 include/linux/pinctrl/pinmux.h |  3 +++
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index b874458..15fe3f7 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -40,7 +40,7 @@ int pinmux_check_ops(struct pinctrl_dev *pctldev)
 	if (!ops ||
 	    !ops->get_functions_count ||
 	    !ops->get_function_name ||
-	    !ops->get_function_groups ||
+	    (!ops->get_function_groups & !ops->mux_per_pin) ||
 	    !ops->set_mux) {
 		dev_err(pctldev->dev, "pinmux ops lacks necessary functions\n");
 		return -EINVAL;
@@ -338,36 +338,42 @@ int pinmux_map_to_setting(struct pinctrl_map const *map,
 	}
 	setting->data.mux.func = ret;
 
-	ret = pmxops->get_function_groups(pctldev, setting->data.mux.func,
-					  &groups, &num_groups);
-	if (ret < 0) {
-		dev_err(pctldev->dev, "can't query groups for function %s\n",
-			map->data.mux.function);
-		return ret;
-	}
-	if (!num_groups) {
-		dev_err(pctldev->dev,
-			"function %s can't be selected on any group\n",
-			map->data.mux.function);
-		return -EINVAL;
-	}
-	if (map->data.mux.group) {
-		bool found = false;
-		group = map->data.mux.group;
-		for (i = 0; i < num_groups; i++) {
-			if (!strcmp(group, groups[i])) {
-				found = true;
-				break;
-			}
+	if (!pmxops->mux_per_pin) {
+		ret = pmxops->get_function_groups(pctldev,
+						  setting->data.mux.func,
+						  &groups, &num_groups);
+		if (ret < 0) {
+			dev_err(pctldev->dev,
+				"can't query groups for function %s\n",
+				map->data.mux.function);
+			return ret;
 		}
-		if (!found) {
+		if (!num_groups) {
 			dev_err(pctldev->dev,
-				"invalid group \"%s\" for function \"%s\"\n",
-				group, map->data.mux.function);
+				"function %s can't be selected on any group\n",
+				map->data.mux.function);
 			return -EINVAL;
 		}
+		if (map->data.mux.group) {
+			bool found = false;
+			group = map->data.mux.group;
+			for (i = 0; i < num_groups; i++) {
+				if (!strcmp(group, groups[i])) {
+					found = true;
+					break;
+				}
+			}
+			if (!found) {
+				dev_err(pctldev->dev,
+					"invalid group \"%s\" for function \"%s\"\n",
+					group, map->data.mux.function);
+				return -EINVAL;
+			}
+		} else {
+			group = groups[0];
+		}
 	} else {
-		group = groups[0];
+		group = map->data.mux.group;
 	}
 
 	ret = pinctrl_get_group_selector(pctldev, group);
diff --git a/include/linux/pinctrl/pinmux.h b/include/linux/pinctrl/pinmux.h
index 511bda9..51b84eb 100644
--- a/include/linux/pinctrl/pinmux.h
+++ b/include/linux/pinctrl/pinmux.h
@@ -23,6 +23,8 @@ struct pinctrl_dev;
 /**
  * struct pinmux_ops - pinmux operations, to be implemented by pin controller
  * drivers that support pinmuxing
+ * @mux_per_pin: in case of per pin muxing, it removes the need to declare
+ *	with which groups a function can be used.
  * @request: called by the core to see if a certain pin can be made
  *	available for muxing. This is called by the core to acquire the pins
  *	before selecting any actual mux setting across a function. The driver
@@ -58,6 +60,7 @@ struct pinctrl_dev;
  *	to the GPIO controllers that need pin muxing.
  */
 struct pinmux_ops {
+	bool mux_per_pin;
 	int (*request) (struct pinctrl_dev *pctldev, unsigned offset);
 	int (*free) (struct pinctrl_dev *pctldev, unsigned offset);
 	int (*get_functions_count) (struct pinctrl_dev *pctldev);
-- 
2.2.0
