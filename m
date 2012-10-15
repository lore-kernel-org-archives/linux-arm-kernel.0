From: simon.guinot@sequanux.org (Simon Guinot)
Date: Mon, 15 Oct 2012 17:34:52 +0200
Subject: [PATCH 1/4] leds: leds-ns2: add device tree binding
In-Reply-To: <1350315295-14567-1-git-send-email-simon.guinot@sequanux.org>
References: <1350315295-14567-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1350315295-14567-2-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 .../devicetree/bindings/gpio/leds-ns2.txt          |   26 ++++++
 drivers/leds/leds-ns2.c                            |   84 +++++++++++++++++++-
 2 files changed, 107 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/leds-ns2.txt

diff --git a/Documentation/devicetree/bindings/gpio/leds-ns2.txt b/Documentation/devicetree/bindings/gpio/leds-ns2.txt
new file mode 100644
index 0000000..1a84969
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/leds-ns2.txt
@@ -0,0 +1,26 @@
+Binding for dual-GPIO LED found on Network Space v2 (and parents).
+
+Required properties:
+- compatible: "ns2-leds".
+
+Each LED is represented as a sub-node of the ns2-leds device.
+
+Required sub-node properties:
+- cmd-gpio: Command LED GPIO. See OF device-tree GPIO specification.
+- slow-gpio: Slow LED GPIO. See OF device-tree GPIO specification.
+
+Optional sub-node properties:
+- label: Name for this LED. If omitted, the label is taken from the node name.
+- linux,default-trigger: Trigger assigned to the LED.
+
+Example:
+
+ns2-leds {
+	compatible = "ns2-leds";
+
+	blue-sata {
+		label = "ns2:blue:sata";
+		slow-gpio = <&gpio0 29 0>;
+		cmd-gpio = <&gpio0 30 0>;
+	};
+};
diff --git a/drivers/leds/leds-ns2.c b/drivers/leds/leds-ns2.c
index d176ec8..55d199b 100644
--- a/drivers/leds/leds-ns2.c
+++ b/drivers/leds/leds-ns2.c
@@ -30,6 +30,7 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/platform_data/leds-kirkwood-ns2.h>
+#include <linux/of_gpio.h>
 
 /*
  * The Network Space v2 dual-GPIO LED is wired to a CPLD and can blink in
@@ -263,6 +264,68 @@ static void delete_ns2_led(struct ns2_led_data *led_dat)
 	gpio_free(led_dat->slow);
 }
 
+#ifdef CONFIG_OF_GPIO
+/*
+ * Translate OpenFirmware node properties into platform_data.
+ */
+static int __devinit
+ns2_leds_get_of_pdata(struct device *dev, struct ns2_led_platform_data *pdata)
+{
+	struct device_node *np = dev->of_node;
+	struct device_node *child;
+	struct ns2_led *leds;
+	int num_leds = 0;
+	int i = 0;
+
+	num_leds = of_get_child_count(np);
+	if (!num_leds)
+		return -ENODEV;
+
+	leds = devm_kzalloc(dev, num_leds * sizeof(struct ns2_led),
+			    GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	for_each_child_of_node(np, child) {
+		const char *string;
+		int ret;
+
+		ret = of_get_named_gpio(child, "cmd-gpio", 0);
+		if (ret < 0)
+			return ret;
+		leds[i].cmd = ret;
+		ret = of_get_named_gpio(child, "slow-gpio", 0);
+		if (ret < 0)
+			return ret;
+		leds[i].slow = ret;
+		ret = of_property_read_string(child, "label", &string);
+		leds[i].name = (ret == 0) ? string : child->name;
+		ret = of_property_read_string(child, "linux,default-trigger",
+					      &string);
+		if (ret == 0)
+			leds[i].default_trigger = string;
+
+		i++;
+	}
+
+	pdata->leds = leds;
+	pdata->num_leds = num_leds;
+
+	return 0;
+}
+
+static const struct of_device_id of_ns2_leds_match[] = {
+	{ .compatible = "ns2-leds", },
+	{},
+};
+#else
+static int __devinit
+ns2_leds_get_of_pdata(struct device *dev, struct ns2_led_platform_data *pdata)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_OF_GPIO */
+
 static int __devinit ns2_led_probe(struct platform_device *pdev)
 {
 	struct ns2_led_platform_data *pdata = pdev->dev.platform_data;
@@ -270,11 +333,25 @@ static int __devinit ns2_led_probe(struct platform_device *pdev)
 	int i;
 	int ret;
 
+#ifdef CONFIG_OF_GPIO
+	if (!pdata) {
+		pdata = devm_kzalloc(&pdev->dev,
+				     sizeof(struct ns2_led_platform_data),
+				     GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+
+		ret = ns2_leds_get_of_pdata(&pdev->dev, pdata);
+		if (ret)
+			return ret;
+	}
+#else
 	if (!pdata)
 		return -EINVAL;
+#endif /* CONFIG_OF_GPIO */
 
 	leds_data = devm_kzalloc(&pdev->dev, sizeof(struct ns2_led_data) *
-			    pdata->num_leds, GFP_KERNEL);
+				 pdata->num_leds, GFP_KERNEL);
 	if (!leds_data)
 		return -ENOMEM;
 
@@ -312,8 +389,9 @@ static struct platform_driver ns2_led_driver = {
 	.probe		= ns2_led_probe,
 	.remove		= __devexit_p(ns2_led_remove),
 	.driver		= {
-		.name	= "leds-ns2",
-		.owner	= THIS_MODULE,
+		.name		= "leds-ns2",
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(of_ns2_leds_match),
 	},
 };
 
-- 
1.7.10
