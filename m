From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu,  2 Jul 2015 19:56:40 +0200
Subject: [PATCH v2 1/4] leds: leds-ns2: move LED modes mapping outside of the
 driver
In-Reply-To: <1435859803-19583-1-git-send-email-simon.guinot@sequanux.org>
References: <1435859803-19583-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1435859803-19583-2-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vincent Donnefort <vdonnefort@gmail.com>

On the board n090401 (Seagate NAS 4-Bay), the LED mode mapping (GPIO
values to LED mode) is different from the one used on other boards
supported by the leds-ns2 driver.

With this patch the hardcoded mapping is removed from leds-ns2. Now,
it must be defined either in the platform data (if an old-fashion board
setup file is used) or in the DT node. In order to allow the later, this
patch also introduces a modes-map property for the leds-ns2 DT binding.

Signed-off-by: Vincent Donnefort <vdonnefort@gmail.com>
---
 .../devicetree/bindings/leds/leds-ns2.txt          |   9 ++
 drivers/leds/leds-ns2.c                            | 102 +++++++++++----------
 include/dt-bindings/leds/leds-ns2.h                |   8 ++
 include/linux/platform_data/leds-kirkwood-ns2.h    |  14 +++
 4 files changed, 85 insertions(+), 48 deletions(-)
 create mode 100644 include/dt-bindings/leds/leds-ns2.h

diff --git a/Documentation/devicetree/bindings/leds/leds-ns2.txt b/Documentation/devicetree/bindings/leds/leds-ns2.txt
index aef3aca34d2d..9f81258a5b6e 100644
--- a/Documentation/devicetree/bindings/leds/leds-ns2.txt
+++ b/Documentation/devicetree/bindings/leds/leds-ns2.txt
@@ -8,6 +8,9 @@ Each LED is represented as a sub-node of the ns2-leds device.
 Required sub-node properties:
 - cmd-gpio: Command LED GPIO. See OF device-tree GPIO specification.
 - slow-gpio: Slow LED GPIO. See OF device-tree GPIO specification.
+- modes-map: A mapping between LED modes (off, on or SATA activity blinking) and
+  the corresponding cmd-gpio/slow-gpio values. All the GPIO values combinations
+  should be given in order to avoid having an unknown mode at driver probe time.
 
 Optional sub-node properties:
 - label: Name for this LED. If omitted, the label is taken from the node name.
@@ -15,6 +18,8 @@ Optional sub-node properties:
 
 Example:
 
+#include <dt-bindings/leds/leds-ns2.h>
+
 ns2-leds {
 	compatible = "lacie,ns2-leds";
 
@@ -22,5 +27,9 @@ ns2-leds {
 		label = "ns2:blue:sata";
 		slow-gpio = <&gpio0 29 0>;
 		cmd-gpio = <&gpio0 30 0>;
+		modes-map = <NS_V2_LED_OFF  0 1
+			     NS_V2_LED_ON   1 0
+			     NS_V2_LED_ON   0 0
+			     NS_V2_LED_SATA 1 1>;
 	};
 };
diff --git a/drivers/leds/leds-ns2.c b/drivers/leds/leds-ns2.c
index 1fd6adbb43b7..b0bc03539dbb 100644
--- a/drivers/leds/leds-ns2.c
+++ b/drivers/leds/leds-ns2.c
@@ -33,46 +33,20 @@
 #include <linux/of_gpio.h>
 
 /*
- * The Network Space v2 dual-GPIO LED is wired to a CPLD and can blink in
- * relation with the SATA activity. This capability is exposed through the
- * "sata" sysfs attribute.
- *
- * The following array detail the different LED registers and the combination
- * of their possible values:
- *
- *  cmd_led   |  slow_led  | /SATA active | LED state
- *            |            |              |
- *     1      |     0      |      x       |  off
- *     -      |     1      |      x       |  on
- *     0      |     0      |      1       |  on
- *     0      |     0      |      0       |  blink (rate 300ms)
+ * The Network Space v2 dual-GPIO LED is wired to a CPLD. Three different LED
+ * modes are available: off, on and SATA activity blinking. The LED modes are
+ * controlled through two GPIOs (command and slow): each combination of values
+ * for the command/slow GPIOs corresponds to a LED mode.
  */
 
-enum ns2_led_modes {
-	NS_V2_LED_OFF,
-	NS_V2_LED_ON,
-	NS_V2_LED_SATA,
-};
-
-struct ns2_led_mode_value {
-	enum ns2_led_modes	mode;
-	int			cmd_level;
-	int			slow_level;
-};
-
-static struct ns2_led_mode_value ns2_led_modval[] = {
-	{ NS_V2_LED_OFF	, 1, 0 },
-	{ NS_V2_LED_ON	, 0, 1 },
-	{ NS_V2_LED_ON	, 1, 1 },
-	{ NS_V2_LED_SATA, 0, 0 },
-};
-
 struct ns2_led_data {
 	struct led_classdev	cdev;
 	unsigned		cmd;
 	unsigned		slow;
 	unsigned char		sata; /* True when SATA mode active. */
 	rwlock_t		rw_lock; /* Lock GPIOs. */
+	int			num_modes;
+	struct ns2_led_modval	*modval;
 };
 
 static int ns2_led_get_mode(struct ns2_led_data *led_dat,
@@ -88,10 +62,10 @@ static int ns2_led_get_mode(struct ns2_led_data *led_dat,
 	cmd_level = gpio_get_value(led_dat->cmd);
 	slow_level = gpio_get_value(led_dat->slow);
 
-	for (i = 0; i < ARRAY_SIZE(ns2_led_modval); i++) {
-		if (cmd_level == ns2_led_modval[i].cmd_level &&
-		    slow_level == ns2_led_modval[i].slow_level) {
-			*mode = ns2_led_modval[i].mode;
+	for (i = 0; i < led_dat->num_modes; i++) {
+		if (cmd_level == led_dat->modval[i].cmd_level &&
+		    slow_level == led_dat->modval[i].slow_level) {
+			*mode = led_dat->modval[i].mode;
 			ret = 0;
 			break;
 		}
@@ -110,12 +84,12 @@ static void ns2_led_set_mode(struct ns2_led_data *led_dat,
 
 	write_lock_irqsave(&led_dat->rw_lock, flags);
 
-	for (i = 0; i < ARRAY_SIZE(ns2_led_modval); i++) {
-		if (mode == ns2_led_modval[i].mode) {
+	for (i = 0; i < led_dat->num_modes; i++) {
+		if (mode == led_dat->modval[i].mode) {
 			gpio_set_value(led_dat->cmd,
-				       ns2_led_modval[i].cmd_level);
+				       led_dat->modval[i].cmd_level);
 			gpio_set_value(led_dat->slow,
-				       ns2_led_modval[i].slow_level);
+				       led_dat->modval[i].slow_level);
 		}
 	}
 
@@ -228,6 +202,8 @@ create_ns2_led(struct platform_device *pdev, struct ns2_led_data *led_dat,
 	led_dat->cdev.groups = ns2_led_groups;
 	led_dat->cmd = template->cmd;
 	led_dat->slow = template->slow;
+	led_dat->modval = template->modval;
+	led_dat->num_modes = template->num_modes;
 
 	ret = ns2_led_get_mode(led_dat, &mode);
 	if (ret < 0)
@@ -259,9 +235,8 @@ ns2_leds_get_of_pdata(struct device *dev, struct ns2_led_platform_data *pdata)
 {
 	struct device_node *np = dev->of_node;
 	struct device_node *child;
-	struct ns2_led *leds;
+	struct ns2_led *led, *leds;
 	int num_leds = 0;
-	int i = 0;
 
 	num_leds = of_get_child_count(np);
 	if (!num_leds)
@@ -272,26 +247,57 @@ ns2_leds_get_of_pdata(struct device *dev, struct ns2_led_platform_data *pdata)
 	if (!leds)
 		return -ENOMEM;
 
+	led = leds;
 	for_each_child_of_node(np, child) {
 		const char *string;
-		int ret;
+		int ret, i, num_modes;
+		struct ns2_led_modval *modval;
 
 		ret = of_get_named_gpio(child, "cmd-gpio", 0);
 		if (ret < 0)
 			return ret;
-		leds[i].cmd = ret;
+		led->cmd = ret;
 		ret = of_get_named_gpio(child, "slow-gpio", 0);
 		if (ret < 0)
 			return ret;
-		leds[i].slow = ret;
+		led->slow = ret;
 		ret = of_property_read_string(child, "label", &string);
-		leds[i].name = (ret == 0) ? string : child->name;
+		led->name = (ret == 0) ? string : child->name;
 		ret = of_property_read_string(child, "linux,default-trigger",
 					      &string);
 		if (ret == 0)
-			leds[i].default_trigger = string;
+			led->default_trigger = string;
+
+		ret = of_property_count_u32_elems(child, "modes-map");
+		if (ret < 0 || ret % 3) {
+			dev_err(dev,
+				"Missing or malformed modes-map property\n");
+			return -EINVAL;
+		}
+
+		num_modes = ret / 3;
+		modval = devm_kzalloc(dev,
+				      num_modes * sizeof(struct ns2_led_modval),
+				      GFP_KERNEL);
+		if (!modval)
+			return -ENOMEM;
+
+		for (i = 0; i < num_modes; i++) {
+			of_property_read_u32_index(child,
+						"modes-map", 3 * i,
+						(u32 *) &modval[i].mode);
+			of_property_read_u32_index(child,
+						"modes-map", 3 * i + 1,
+						(u32 *) &modval[i].cmd_level);
+			of_property_read_u32_index(child,
+						"modes-map", 3 * i + 2,
+						(u32 *) &modval[i].slow_level);
+		}
+
+		led->num_modes = num_modes;
+		led->modval = modval;
 
-		i++;
+		led++;
 	}
 
 	pdata->leds = leds;
diff --git a/include/dt-bindings/leds/leds-ns2.h b/include/dt-bindings/leds/leds-ns2.h
new file mode 100644
index 000000000000..491c5f974a92
--- /dev/null
+++ b/include/dt-bindings/leds/leds-ns2.h
@@ -0,0 +1,8 @@
+#ifndef _DT_BINDINGS_LEDS_NS2_H
+#define _DT_BINDINGS_LEDS_NS2_H
+
+#define NS_V2_LED_OFF	0
+#define NS_V2_LED_ON	1
+#define NS_V2_LED_SATA	2
+
+#endif
diff --git a/include/linux/platform_data/leds-kirkwood-ns2.h b/include/linux/platform_data/leds-kirkwood-ns2.h
index 6a9fed57f346..eb8a6860e816 100644
--- a/include/linux/platform_data/leds-kirkwood-ns2.h
+++ b/include/linux/platform_data/leds-kirkwood-ns2.h
@@ -9,11 +9,25 @@
 #ifndef __LEDS_KIRKWOOD_NS2_H
 #define __LEDS_KIRKWOOD_NS2_H
 
+enum ns2_led_modes {
+	NS_V2_LED_OFF,
+	NS_V2_LED_ON,
+	NS_V2_LED_SATA,
+};
+
+struct ns2_led_modval {
+	enum ns2_led_modes	mode;
+	int			cmd_level;
+	int			slow_level;
+};
+
 struct ns2_led {
 	const char	*name;
 	const char	*default_trigger;
 	unsigned	cmd;
 	unsigned	slow;
+	int		num_modes;
+	struct ns2_led_modval *modval;
 };
 
 struct ns2_led_platform_data {
-- 
2.1.4
