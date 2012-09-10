From: jm@lentin.co.uk (Jamie Lentin)
Date: Mon, 10 Sep 2012 14:51:51 +0100
Subject: [PATCH V2 1/2] hwmon: Add devicetree bindings to gpio-fan
In-Reply-To: <1347285112-13542-1-git-send-email-jm@lentin.co.uk>
References: <1347035675-23907-1-git-send-email-jm@lentin.co.uk>
 <1347285112-13542-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1347285112-13542-2-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow a gpio-fan to be defined in devicetree, see binding documentation
for details.

Changes since V1:-
* Don't hide return codes [Guenter Roeck]
* Remove typecast noise [Guenter Roeck]
* Use of_find_property instead of counting u32s [Guenter Roeck]
* Don't count GPIOs twice [Andrew Lunn]
* Use of_prop_next_u32 to get records in a more obvious fashion
* Use CONFIG_OF_GPIO instead of CONFIG_OF
* Apply __devinitdata to of_gpio_fan_match [Andrew Lunn]

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 .../devicetree/bindings/gpio/gpio-fan.txt          |   25 +++++
 drivers/hwmon/gpio-fan.c                           |  116 ++++++++++++++++++++
 2 files changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-fan.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-fan.txt b/Documentation/devicetree/bindings/gpio/gpio-fan.txt
new file mode 100644
index 0000000..2dd457a
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-fan.txt
@@ -0,0 +1,25 @@
+Bindings for fan connected to GPIO lines
+
+Required properties:
+- compatible : "gpio-fan"
+- gpios: Specifies the pins that map to bits in the control value,
+  ordered MSB-->LSB.
+- gpio-fan,speed-map: A mapping of possible fan RPM speeds and the
+  control value that should be set to achieve them. This array
+  must have the RPM values in ascending order.
+
+Optional properties:
+- alarm-gpios: This pin going active indicates something is wrong with
+  the fan, and a udev event will be fired.
+
+Examples:
+
+	gpio_fan {
+		compatible = "gpio-fan";
+		gpios = <&gpio1 14 1
+			 &gpio1 13 1>;
+		gpio-fan,speed-map = <0    0
+				      3000 1
+				      6000 2>;
+		alarm-gpios = <&gpio1 15 1>;
+	};
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index 2f4b01b..f0a803b 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -31,6 +31,8 @@
 #include <linux/hwmon.h>
 #include <linux/gpio.h>
 #include <linux/gpio-fan.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
 
 struct gpio_fan_data {
 	struct platform_device	*pdev;
@@ -400,14 +402,127 @@ static ssize_t show_name(struct device *dev,
 
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
+
+#ifdef CONFIG_OF_GPIO
+/*
+ * Translate OpenFirmware node properties into platform_data
+ */
+static int gpio_fan_get_of_pdata(struct device *dev,
+			    struct gpio_fan_platform_data *pdata)
+{
+	struct device_node *node;
+	struct gpio_fan_speed  *speed;
+	unsigned *ctrl;
+	unsigned i;
+	u32 u;
+	struct property *prop;
+	const __be32 *p;
+
+	node = dev->of_node;
+
+	/* Fill GPIO pin array */
+	pdata->num_ctrl = of_gpio_count(node);
+	ctrl = devm_kzalloc(dev, pdata->num_ctrl * sizeof(unsigned),
+				GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+	for (i = 0; i < pdata->num_ctrl; i++) {
+		int val;
+
+		val = of_get_gpio(node, i);
+		if (val < 0)
+			return val;
+		ctrl[i] = val;
+	}
+	pdata->ctrl = ctrl;
+
+	/* Get number of RPM/ctrl_val pairs in speed map */
+	prop = of_find_property(node, "gpio-fan,speed-map", &i);
+	if (!prop) {
+		dev_err(dev, "gpio-fan,speed-map node missing from DT");
+		return -ENODEV;
+	}
+	i = i / sizeof(u32);
+	if (i == 0 || i & 1) {
+		dev_err(dev, "gpio-fan,speed-map contains zero/odd number of entries");
+		return -ENODEV;
+	}
+	pdata->num_speed = i / 2;
+
+	/*
+	 * Populate speed map
+	 * Speed map is in the form <RPM ctrl_val RPM ctrl_val ...>
+	 * this needs splitting into pairs to create gpio_fan_speed structs
+	 */
+	speed = devm_kzalloc(dev,
+			pdata->num_speed * sizeof(struct gpio_fan_speed),
+			GFP_KERNEL);
+	if (!speed)
+		return -ENOMEM;
+	p = NULL;
+	for (i = 0; i < pdata->num_speed; i++) {
+		p = of_prop_next_u32(prop, p, &u);
+		if (!p)
+			return -ENODEV;
+		speed[i].rpm = u;
+		p = of_prop_next_u32(prop, p, &u);
+		if (!p)
+			return -ENODEV;
+		speed[i].ctrl_val = u;
+	}
+	pdata->speed = speed;
+
+	/* Alarm GPIO if one exists */
+	if (of_gpio_named_count(node, "alarm-gpios")) {
+		struct gpio_fan_alarm *alarm;
+		int val;
+		enum of_gpio_flags flags;
+
+		alarm = devm_kzalloc(dev, sizeof(struct gpio_fan_alarm),
+					GFP_KERNEL);
+		if (!alarm)
+			return -ENOMEM;
+
+		val = of_get_named_gpio_flags(node, "alarm-gpios", 0, &flags);
+		if (val < 0)
+			return val;
+		alarm->gpio = val;
+		alarm->active_low = flags & OF_GPIO_ACTIVE_LOW;
+
+		pdata->alarm = alarm;
+	}
+
+	return 0;
+}
+
+static struct of_device_id of_gpio_fan_match[] __devinitdata = {
+	{ .compatible = "gpio-fan", },
+	{},
+};
+#endif /* CONFIG_OF_GPIO */
+
 static int __devinit gpio_fan_probe(struct platform_device *pdev)
 {
 	int err;
 	struct gpio_fan_data *fan_data;
 	struct gpio_fan_platform_data *pdata = pdev->dev.platform_data;
 
+#ifdef CONFIG_OF_GPIO
+	if (!pdata) {
+		pdata = devm_kzalloc(&pdev->dev,
+					sizeof(struct gpio_fan_platform_data),
+					GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+
+		err = gpio_fan_get_of_pdata(&pdev->dev, pdata);
+		if (err)
+			return err;
+	}
+#else /* CONFIG_OF_GPIO */
 	if (!pdata)
 		return -EINVAL;
+#endif /* CONFIG_OF_GPIO */
 
 	fan_data = devm_kzalloc(&pdev->dev, sizeof(struct gpio_fan_data),
 				GFP_KERNEL);
@@ -511,6 +626,7 @@ static struct platform_driver gpio_fan_driver = {
 	.driver	= {
 		.name	= "gpio-fan",
 		.pm	= GPIO_FAN_PM,
+		.of_match_table = of_match_ptr(of_gpio_fan_match),
 	},
 };
 
-- 
1.7.10.4
