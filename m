From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 10 Jun 2013 20:59:32 +0400
Subject: [PATCH v4 3/3] leds: leds-mc13783: Add devicetree support
In-Reply-To: <1370883572-877-1-git-send-email-shc_work@mail.ru>
References: <1370883572-877-1-git-send-email-shc_work@mail.ru>
Message-ID: <1370883572-877-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/mfd/mc13xxx.txt | 39 +++++++++++++
 drivers/leds/leds-mc13783.c                       | 69 +++++++++++++++++++----
 2 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mc13xxx.txt b/Documentation/devicetree/bindings/mfd/mc13xxx.txt
index abd9e3c..96c7f3a 100644
--- a/Documentation/devicetree/bindings/mfd/mc13xxx.txt
+++ b/Documentation/devicetree/bindings/mfd/mc13xxx.txt
@@ -12,6 +12,13 @@ Optional properties:
 Sub-nodes:
 - regulators : Contain the regulator nodes. The regulators are bound using
   their names as listed below with their registers and bits for enabling.
+- leds : Contain the led nodes and initial register values in property
+  "led_control". Number of register depends of used IC, for MC13783 is 6,
+  for MC13892 is 4. See datasheet for bits definitions of these register.
+  Each led node should contain "id", which is described below, and "max_cur"
+  which selects value current depending on the led (Values should be taken
+  from IC datasheet). Optional properties "label" and "linux,default-trigger"
+  is described in Documentation/devicetree/bindings/leds/common.txt
 
 MC13783 regulators:
     sw1a      : regulator SW1A      (register 24, bit 0)
@@ -72,6 +79,28 @@ MC13892 regulators:
   The bindings details of individual regulator device can be found in:
   Documentation/devicetree/bindings/regulator/regulator.txt
 
+MC13783 LED IDs:
+    0  : Main display
+    1  : AUX display
+    2  : Keypad
+    3  : Red 1
+    4  : Green 1
+    5  : Blue 1
+    6  : Red 2
+    7  : Green 2
+    8  : Blue 2
+    9  : Red 3
+    10 : Green 3
+    11 : Blue 3
+
+MC13892 LED IDs:
+    12 : Main display
+    13 : AUX display
+    14 : Keypad
+    15 : Red
+    16 : Green
+    17 : Blue
+
 Examples:
 
 ecspi at 70010000 { /* ECSPI1 */
@@ -89,6 +118,16 @@ ecspi at 70010000 { /* ECSPI1 */
 		interrupt-parent = <&gpio0>;
 		interrupts = <8>;
 
+		leds {
+			led_control = <0x0 0x0 0x0 0x0>;
+			led_r {
+				id = <15>;
+				label = "system:red:live";
+				linux,default-trigger = "heartbeat";
+				max-cur = <6>;
+			};
+		};
+
 		regulators {
 			sw1_reg: mc13892__sw1 {
 				regulator-min-microvolt = <600000>;
diff --git a/drivers/leds/leds-mc13783.c b/drivers/leds/leds-mc13783.c
index f656fd5..65a06a8 100644
--- a/drivers/leds/leds-mc13783.c
+++ b/drivers/leds/leds-mc13783.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/leds.h>
+#include <linux/of.h>
 #include <linux/workqueue.h>
 #include <linux/mfd/mc13xxx.h>
 
@@ -207,35 +208,55 @@ static int __init mc13xxx_led_probe(struct platform_device *pdev)
 	struct mc13xxx *mcdev = dev_get_drvdata(pdev->dev.parent);
 	struct mc13xxx_led_devtype *devtype =
 		(struct mc13xxx_led_devtype *)pdev->id_entry->driver_data;
+	struct device_node *parent, *child = NULL;
 	struct mc13xxx_leds *leds;
-	int i, id, num_leds, ret;
-	u32 reg, init_led = 0;
+	int i, id, num_leds, ret = -EINVAL;
+	u32 reg, ctrls[MAX_LED_CONTROL_REGS], init_led = 0;
 
-	if (!pdata) {
+	of_node_get(pdev->dev.parent->of_node);
+	parent = of_find_node_by_name(pdev->dev.parent->of_node, "leds");
+	if (!parent && !pdata) {
 		dev_err(&pdev->dev, "Missing platform data\n");
 		return -ENODEV;
 	}
 
-	num_leds = pdata->num_leds;
+	if (parent)
+		num_leds = of_get_child_count(parent);
+	else
+		num_leds = pdata->num_leds;
 
 	if ((num_leds < 1) ||
 	    (num_leds > (devtype->led_max - devtype->led_min + 1))) {
 		dev_err(&pdev->dev, "Invalid LED count %d\n", num_leds);
-		return -EINVAL;
+		goto out_node_put;
 	}
 
 	leds = devm_kzalloc(&pdev->dev, num_leds * sizeof(struct mc13xxx_led) +
 			    sizeof(struct mc13xxx_leds), GFP_KERNEL);
-	if (!leds)
-		return -ENOMEM;
+	if (!leds) {
+		ret = -ENOMEM;
+		goto out_node_put;
+	}
 
 	leds->devtype = devtype;
 	leds->num_leds = num_leds;
 	platform_set_drvdata(pdev, leds);
 
+	if (parent) {
+		ret = of_property_read_u32_array(parent, "led_control", ctrls,
+						 devtype->num_regs);
+		if (ret) {
+			dev_err(&pdev->dev, "Missing led_control settings\n");
+			goto out_node_put;
+		}
+	}
+
 	mc13xxx_lock(mcdev);
 	for (i = 0; i < devtype->num_regs; i++) {
-		reg = pdata->led_control[i];
+		if (parent)
+			reg = ctrls[i];
+		else
+			reg = pdata->led_control[i];
 		WARN_ON(reg >= (1 << 24));
 		ret = mc13xxx_reg_write(mcdev, MC13XXX_REG_LED_CONTROL(i), reg);
 		if (ret)
@@ -250,14 +271,34 @@ static int __init mc13xxx_led_probe(struct platform_device *pdev)
 
 	for (i = 0; i < num_leds; i++) {
 		const char *name, *trig;
+		const __be32 *prop;
 		char max_current;
 
 		ret = -EINVAL;
 
-		id = pdata->led[i].id;
-		name = pdata->led[i].name;
-		trig = pdata->led[i].default_trigger;
-		max_current = pdata->led[i].max_current;
+		if (parent) {
+			child = of_get_next_child(parent, child);
+			prop = of_get_property(child, "id", NULL);
+			if (!prop) {
+				dev_err(&pdev->dev, "Missing LED ID\n");
+				break;
+			} else
+				id = be32_to_cpu(*prop);
+			name = of_get_property(child, "label", NULL);
+			trig = of_get_property(child, "linux,default-trigger",
+					       NULL);
+			prop = of_get_property(child, "max-cur", NULL);
+			if (!prop) {
+				dev_err(&pdev->dev, "Missing LED max-cur\n");
+				break;
+			} else
+				max_current = be32_to_cpu(*prop);
+		} else {
+			id = pdata->led[i].id;
+			name = pdata->led[i].name;
+			trig = pdata->led[i].default_trigger;
+			max_current = pdata->led[i].max_current;
+		}
 
 		if ((id > devtype->led_max) || (id < devtype->led_min)) {
 			dev_err(&pdev->dev, "Invalid ID %i\n", id);
@@ -299,6 +340,10 @@ static int __init mc13xxx_led_probe(struct platform_device *pdev)
 			cancel_work_sync(&leds->led[i].work);
 		}
 
+out_node_put:
+	if (parent)
+		of_node_put(parent);
+
 	return ret;
 }
 
-- 
1.8.1.5
