From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 10 Feb 2012 01:47:48 +0100
Subject: [PATCH] pinctrl: changes hog mechanism to be self-referential
Message-ID: <1328834868-25030-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of a specific boolean field to indicate if a map entry shall
be hogged, treat self-reference as an indication of desired hogging.
This drops one field off the map struct and has a nice Douglas R.
Hofstadter-feel to it.

Suggested-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/pinctrl.txt       |    8 ++++----
 drivers/pinctrl/core.c          |    6 ++----
 include/linux/pinctrl/machine.h |   18 ++++++------------
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/Documentation/pinctrl.txt b/Documentation/pinctrl.txt
index 2e71323..acb9078 100644
--- a/Documentation/pinctrl.txt
+++ b/Documentation/pinctrl.txt
@@ -989,21 +989,21 @@ is registered. This means that the core will attempt to call pinctrl_get() and
 pinctrl_enable() on it immediately after the pin control device has been
 registered.
 
-This is enabled by simply setting the .hog_on_boot field in the map to true,
-like this:
+This is enabled by simply setting the .dev_name field in the map to the name
+of the pin controller itself, like this:
 
 {
 	.name = "POWERMAP"
 	.ctrl_dev_name = "pinctrl-foo",
 	.function = "power_func",
-	.hog_on_boot = true,
+	.dev_name = "pinctrl-foo",
 },
 
 Since it may be common to request the core to hog a few always-applicable
 mux settings on the primary pin controller, there is a convenience macro for
 this:
 
-PIN_MAP_PRIMARY_SYS_HOG("POWERMAP", "power_func")
+PIN_MAP_PRIMARY_SYS_HOG("POWERMAP", "pinctrl-foo". "power_func")
 
 This gives the exact same result as the above construction.
 
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index ec32c54..c5f76ad 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -793,11 +793,9 @@ int pinctrl_hog_maps(struct pinctrl_dev *pctldev)
 	for (i = 0; i < pinctrl_maps_num; i++) {
 		struct pinctrl_map const *map = &pinctrl_maps[i];
 
-		if (!map->hog_on_boot)
-			continue;
-
 		if (map->ctrl_dev_name &&
-		    !strcmp(map->ctrl_dev_name, devname)) {
+		    !strcmp(map->ctrl_dev_name, devname) &&
+		    !strcmp(map->dev_name, devname)) {
 			/* OK time to hog! */
 			ret = pinctrl_hog_map(pctldev, map);
 			if (ret)
diff --git a/include/linux/pinctrl/machine.h b/include/linux/pinctrl/machine.h
index a2ab524..af145d5 100644
--- a/include/linux/pinctrl/machine.h
+++ b/include/linux/pinctrl/machine.h
@@ -26,13 +26,9 @@
  *	selects a certain specific pin group to activate for the function, if
  *	left as NULL, the first applicable group will be used
  * @dev_name: the name of the device using this specific mapping, the name
- *	must be the same as in your struct device*
- * @hog_on_boot: if this is set to true, the pin control subsystem will itself
- *	hog the mappings as the pinmux device drivers are attached, so this is
- *	typically used with system maps (mux mappings without an assigned
- *	device) that you want to get hogged and enabled by default as soon as
- *	a pinmux device supporting it is registered. These maps will not be
- *	disabled and put until the system shuts down.
+ *	must be the same as in your struct device*. If this name is set to the
+ *	same name as the pin controllers own dev_name(), the map entry will be
+ *	hogged by the driver itself upon registration
  */
 struct pinctrl_map {
 	const char *name;
@@ -40,7 +36,6 @@ struct pinctrl_map {
 	const char *function;
 	const char *group;
 	const char *dev_name;
-	bool hog_on_boot;
 };
 
 /*
@@ -62,8 +57,7 @@ struct pinctrl_map {
  * to be hogged by the pin control core until the system shuts down.
  */
 #define PIN_MAP_SYS_HOG(a, b, c) \
-	{ .name = a, .ctrl_dev_name = b, .function = c, \
-	  .hog_on_boot = true }
+	{ .name = a, .ctrl_dev_name = b, .dev_name = b, .function = c, }
 
 /*
  * Convenience macro to map a system function onto a certain pinctrl device
@@ -71,8 +65,8 @@ struct pinctrl_map {
  * system shuts down.
  */
 #define PIN_MAP_SYS_HOG_GROUP(a, b, c, d)		\
-	{ .name = a, .ctrl_dev_name = b, .function = c, .group = d, \
-	  .hog_on_boot = true }
+	{ .name = a, .ctrl_dev_name = b, .dev_name = b, .function = c, \
+	  .group = d, }
 
 #ifdef CONFIG_PINMUX
 
-- 
1.7.7.6
