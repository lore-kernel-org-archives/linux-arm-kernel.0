From: simon.guinot@sequanux.org (Simon Guinot)
Date: Thu, 17 Sep 2015 17:59:29 +0200
Subject: [PATCH v4 1/3] leds: netxbig: add device tree binding
In-Reply-To: <1442505571-9744-1-git-send-email-simon.guinot@sequanux.org>
References: <1442505571-9744-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1442505571-9744-2-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree support for the netxbig LEDs.

This also introduces a additionnal DT binding for the GPIO extension bus
(netxbig-gpio-ext) used to configure the LEDs. Since this bus could also
be used to control other devices, then it seems more suitable to have it
in a separate DT binding.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/gpio/netxbig-gpio-ext.txt  |  22 ++
 .../devicetree/bindings/leds/leds-netxbig.txt      |  92 ++++++++
 drivers/leds/leds-netxbig.c                        | 258 +++++++++++++++++++--
 include/dt-bindings/leds/leds-netxbig.h            |  18 ++
 4 files changed, 369 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-netxbig.txt
 create mode 100644 include/dt-bindings/leds/leds-netxbig.h

Changes for v2:
- Check timer mode value retrieved from DT.
- In netxbig_leds_get_of_pdata, don't use unsigned long variables to get
  timer delay values from DT with function of_property_read_u32_index.
  Instead, use a temporary u32 variable. This allows to silence a static
  checker warning.
- Make timer property optional in the binding documentation. It is now
  aligned with the driver code.

Changes for v3:
- Fix pointer usage with the temporary u32 variable while calling
  of_property_read_u32_index.

Changes for v4:
- In DT binding document netxbig-gpio-ext.txt, detail byte order for
  registers and latch mechanism for "enable-gpio".
- In leds-netxbig.c, add some error messages.
- In leds-netxbig.c, fix some "sizeof" style issues.
- In leds-netxbig.c, in netxbig_leds_get_of_pdata(), move the
  of_property_read_string() calls after the error-prone checks.
- Add some Acked-by.

diff --git a/Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt b/Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
new file mode 100644
index 000000000000..50ec2e690701
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/netxbig-gpio-ext.txt
@@ -0,0 +1,22 @@
+Binding for the GPIO extension bus found on some LaCie/Seagate boards
+(Example: 2Big/5Big Network v2, 2Big NAS).
+
+Required properties:
+- compatible: "lacie,netxbig-gpio-ext".
+- addr-gpios: GPIOs representing the address register (LSB -> MSB).
+- data-gpios: GPIOs representing the data register (LSB -> MSB).
+- enable-gpio: latches the new configuration (address, data) on raising edge.
+
+Example:
+
+netxbig_gpio_ext: netxbig-gpio-ext {
+	compatible = "lacie,netxbig-gpio-ext";
+
+	addr-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH
+		      &gpio1 16 GPIO_ACTIVE_HIGH
+		      &gpio1 17 GPIO_ACTIVE_HIGH>;
+	data-gpios = <&gpio1 12 GPIO_ACTIVE_HIGH
+		      &gpio1 13 GPIO_ACTIVE_HIGH
+		      &gpio1 14 GPIO_ACTIVE_HIGH>;
+	enable-gpio = <&gpio0 29 GPIO_ACTIVE_HIGH>;
+};
diff --git a/Documentation/devicetree/bindings/leds/leds-netxbig.txt b/Documentation/devicetree/bindings/leds/leds-netxbig.txt
new file mode 100644
index 000000000000..efadbecbfeb9
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-netxbig.txt
@@ -0,0 +1,92 @@
+Binding for the CPLD LEDs (GPIO extension bus) found on some LaCie/Seagate
+boards (Example: 2Big/5Big Network v2, 2Big NAS).
+
+Required properties:
+- compatible: "lacie,netxbig-leds".
+- gpio-ext: Phandle for the gpio-ext bus.
+
+Optional properties:
+- timers: Timer array. Each timer entry is represented by three integers:
+  Mode (gpio-ext bus), delay_on and delay_off.
+
+Each LED is represented as a sub-node of the netxbig-leds device.
+
+Required sub-node properties:
+- mode-addr: Mode register address on gpio-ext bus.
+- mode-val: Mode to value mapping. Each entry is represented by two integers:
+  A mode and the corresponding value on the gpio-ext bus.
+- bright-addr: Brightness register address on gpio-ext bus.
+- bright-max: Maximum brightness value.
+
+Optional sub-node properties:
+- label: Name for this LED. If omitted, the label is taken from the node name.
+- linux,default-trigger: Trigger assigned to the LED.
+
+Example:
+
+netxbig-leds {
+	compatible = "lacie,netxbig-leds";
+
+	gpio-ext = &gpio_ext;
+
+	timers = <NETXBIG_LED_TIMER1 500 500
+		  NETXBIG_LED_TIMER2 500 1000>;
+
+	blue-power {
+		label = "netxbig:blue:power";
+		mode-addr = <0>;
+		mode-val = <NETXBIG_LED_OFF 0
+			    NETXBIG_LED_ON 1
+			    NETXBIG_LED_TIMER1 3
+			    NETXBIG_LED_TIMER2 7>;
+		bright-addr = <1>;
+		bright-max = <7>;
+	};
+	red-power {
+		label = "netxbig:red:power";
+		mode-addr = <0>;
+		mode-val = <NETXBIG_LED_OFF 0
+			    NETXBIG_LED_ON 2
+			    NETXBIG_LED_TIMER1 4>;
+		bright-addr = <1>;
+		bright-max = <7>;
+	};
+	blue-sata0 {
+		label = "netxbig:blue:sata0";
+		mode-addr = <3>;
+		mode-val = <NETXBIG_LED_OFF 0
+			    NETXBIG_LED_ON 7
+			    NETXBIG_LED_SATA 1
+			    NETXBIG_LED_TIMER1 3>;
+		bright-addr = <2>;
+		bright-max = <7>;
+	};
+	red-sata0 {
+		label = "netxbig:red:sata0";
+		mode-addr = <3>;
+		mode-val = <NETXBIG_LED_OFF 0
+			    NETXBIG_LED_ON 2
+			    NETXBIG_LED_TIMER1 4>;
+		bright-addr = <2>;
+		bright-max = <7>;
+	};
+	blue-sata1 {
+		label = "netxbig:blue:sata1";
+		mode-addr = <4>;
+		mode-val = <NETXBIG_LED_OFF 0
+			    NETXBIG_LED_ON 7
+			    NETXBIG_LED_SATA 1
+			    NETXBIG_LED_TIMER1 3>;
+		bright-addr = <2>;
+		bright-max = <7>;
+	};
+	red-sata1 {
+		label = "netxbig:red:sata1";
+		mode-addr = <4>;
+		mode-val = <NETXBIG_LED_OFF 0
+			    NETXBIG_LED_ON 2
+			    NETXBIG_LED_TIMER1 4>;
+		bright-addr = <2>;
+		bright-max = <7>;
+	};
+};
diff --git a/drivers/leds/leds-netxbig.c b/drivers/leds/leds-netxbig.c
index 25e419752a7b..dcd8302cccaf 100644
--- a/drivers/leds/leds-netxbig.c
+++ b/drivers/leds/leds-netxbig.c
@@ -26,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_data/leds-kirkwood-netxbig.h>
 
@@ -140,6 +141,11 @@ struct netxbig_led_data {
 	spinlock_t		lock;
 };
 
+struct netxbig_led_priv {
+	struct netxbig_led_platform_data *pdata;
+	struct netxbig_led_data leds_data[];
+};
+
 static int netxbig_led_get_timer_mode(enum netxbig_led_mode *mode,
 				      unsigned long delay_on,
 				      unsigned long delay_off,
@@ -304,12 +310,12 @@ static void delete_netxbig_led(struct netxbig_led_data *led_dat)
 	led_classdev_unregister(&led_dat->cdev);
 }
 
-static int
-create_netxbig_led(struct platform_device *pdev,
-		   struct netxbig_led_data *led_dat,
-		   const struct netxbig_led *template)
+static int create_netxbig_led(struct platform_device *pdev, int led,
+			      struct netxbig_led_priv *priv)
 {
-	struct netxbig_led_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct netxbig_led_platform_data *pdata = priv->pdata;
+	struct netxbig_led_data *led_dat = &priv->leds_data[led];
+	const struct netxbig_led *template = &priv->pdata->leds[led];
 
 	spin_lock_init(&led_dat->lock);
 	led_dat->gpio_ext = pdata->gpio_ext;
@@ -346,38 +352,249 @@ create_netxbig_led(struct platform_device *pdev,
 	return led_classdev_register(&pdev->dev, &led_dat->cdev);
 }
 
+#ifdef CONFIG_OF_GPIO
+static int gpio_ext_get_of_pdata(struct device *dev, struct device_node *np,
+				 struct netxbig_gpio_ext *gpio_ext)
+{
+	int *addr, *data;
+	int num_addr, num_data;
+	int ret;
+	int i;
+
+	ret = of_gpio_named_count(np, "addr-gpios");
+	if (ret < 0) {
+		dev_err(dev,
+			"Failed to count GPIOs in DT property addr-gpios\n");
+		return ret;
+	}
+	num_addr = ret;
+	addr = devm_kzalloc(dev, num_addr * sizeof(*addr), GFP_KERNEL);
+	if (!addr)
+		return -ENOMEM;
+
+	for (i = 0; i < num_addr; i++) {
+		ret = of_get_named_gpio(np, "addr-gpios", i);
+		if (ret < 0)
+			return ret;
+		addr[i] = ret;
+	}
+	gpio_ext->addr = addr;
+	gpio_ext->num_addr = num_addr;
+
+	ret = of_gpio_named_count(np, "data-gpios");
+	if (ret < 0) {
+		dev_err(dev,
+			"Failed to count GPIOs in DT property data-gpios\n");
+		return ret;
+	}
+	num_data = ret;
+	data = devm_kzalloc(dev, num_data * sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	for (i = 0; i < num_data; i++) {
+		ret = of_get_named_gpio(np, "data-gpios", i);
+		if (ret < 0)
+			return ret;
+		data[i] = ret;
+	}
+	gpio_ext->data = data;
+	gpio_ext->num_data = num_data;
+
+	ret = of_get_named_gpio(np, "enable-gpio", 0);
+	if (ret < 0) {
+		dev_err(dev,
+			"Failed to get GPIO from DT property enable-gpio\n");
+		return ret;
+	}
+	gpio_ext->enable = ret;
+
+	return 0;
+}
+
+static int netxbig_leds_get_of_pdata(struct device *dev,
+				     struct netxbig_led_platform_data *pdata)
+{
+	struct device_node *np = dev->of_node;
+	struct device_node *gpio_ext_np;
+	struct device_node *child;
+	struct netxbig_gpio_ext *gpio_ext;
+	struct netxbig_led_timer *timers;
+	struct netxbig_led *leds, *led;
+	int num_timers;
+	int num_leds = 0;
+	int ret;
+	int i;
+
+	/* GPIO extension */
+	gpio_ext_np = of_parse_phandle(np, "gpio-ext", 0);
+	if (!gpio_ext_np) {
+		dev_err(dev, "Failed to get DT handle gpio-ext\n");
+		return -EINVAL;
+	}
+
+	gpio_ext = devm_kzalloc(dev, sizeof(*gpio_ext), GFP_KERNEL);
+	if (!gpio_ext)
+		return -ENOMEM;
+	ret = gpio_ext_get_of_pdata(dev, gpio_ext_np, gpio_ext);
+	if (ret)
+		return ret;
+	of_node_put(gpio_ext_np);
+	pdata->gpio_ext = gpio_ext;
+
+	/* Timers (optional) */
+	ret = of_property_count_u32_elems(np, "timers");
+	if (ret > 0) {
+		if (ret % 3)
+			return -EINVAL;
+		num_timers = ret / 3;
+		timers = devm_kzalloc(dev, num_timers * sizeof(*timers),
+				      GFP_KERNEL);
+		if (!timers)
+			return -ENOMEM;
+		for (i = 0; i < num_timers; i++) {
+			u32 tmp;
+
+			of_property_read_u32_index(np, "timers", 3 * i,
+						   &timers[i].mode);
+			if (timers[i].mode >= NETXBIG_LED_MODE_NUM)
+				return -EINVAL;
+			of_property_read_u32_index(np, "timers",
+						   3 * i + 1, &tmp);
+			timers[i].delay_on = tmp;
+			of_property_read_u32_index(np, "timers",
+						   3 * i + 2, &tmp);
+			timers[i].delay_off = tmp;
+		}
+		pdata->timer = timers;
+		pdata->num_timer = num_timers;
+	}
+
+	/* LEDs */
+	num_leds = of_get_child_count(np);
+	if (!num_leds) {
+		dev_err(dev, "No LED subnodes found in DT\n");
+		return -ENODEV;
+	}
+
+	leds = devm_kzalloc(dev, num_leds * sizeof(*leds), GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	led = leds;
+	for_each_child_of_node(np, child) {
+		const char *string;
+		int *mode_val;
+		int num_modes;
+
+		if (of_property_read_u32(child, "mode-addr",
+					 &led->mode_addr))
+			return -EINVAL;
+
+		if (of_property_read_u32(child, "bright-addr",
+					 &led->bright_addr))
+			return -EINVAL;
+
+		mode_val =
+			devm_kzalloc(dev,
+				     NETXBIG_LED_MODE_NUM * sizeof(*mode_val),
+				     GFP_KERNEL);
+		if (!mode_val)
+			return -ENOMEM;
+
+		for (i = 0; i < NETXBIG_LED_MODE_NUM; i++)
+			mode_val[i] = NETXBIG_LED_INVALID_MODE;
+
+		ret = of_property_count_u32_elems(child, "mode-val");
+		if (ret < 0 || ret % 2)
+			return -EINVAL;
+		num_modes = ret / 2;
+		if (num_modes > NETXBIG_LED_MODE_NUM)
+			return -EINVAL;
+
+		for (i = 0; i < num_modes; i++) {
+			int mode;
+			int val;
+
+			of_property_read_u32_index(child,
+						   "mode-val", 2 * i, &mode);
+			of_property_read_u32_index(child,
+						   "mode-val", 2 * i + 1, &val);
+			if (mode >= NETXBIG_LED_MODE_NUM)
+				return -EINVAL;
+			mode_val[mode] = val;
+		}
+		led->mode_val = mode_val;
+
+		if (!of_property_read_string(child, "label", &string))
+			led->name = string;
+		else
+			led->name = child->name;
+
+		if (!of_property_read_string(child,
+					     "linux,default-trigger", &string))
+			led->default_trigger = string;
+
+		led++;
+	}
+
+	pdata->leds = leds;
+	pdata->num_leds = num_leds;
+
+	return 0;
+}
+
+static const struct of_device_id of_netxbig_leds_match[] = {
+	{ .compatible = "lacie,netxbig-leds", },
+	{},
+};
+#else
+static int netxbig_leds_get_of_pdata(struct device *dev,
+				     struct netxbig_led_platform_data *pdata)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_OF_GPIO */
+
 static int netxbig_led_probe(struct platform_device *pdev)
 {
 	struct netxbig_led_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct netxbig_led_data *leds_data;
+	struct netxbig_led_priv *priv;
 	int i;
 	int ret;
 
-	if (!pdata)
-		return -EINVAL;
+	if (!pdata) {
+		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+		ret = netxbig_leds_get_of_pdata(&pdev->dev, pdata);
+		if (ret)
+			return ret;
+	}
 
-	leds_data = devm_kzalloc(&pdev->dev,
-		sizeof(struct netxbig_led_data) * pdata->num_leds, GFP_KERNEL);
-	if (!leds_data)
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv) +
+			    pdata->num_leds * sizeof(struct netxbig_led_data),
+			    GFP_KERNEL);
+	if (!priv)
 		return -ENOMEM;
+	priv->pdata = pdata;
 
 	ret = gpio_ext_init(pdata->gpio_ext);
 	if (ret < 0)
 		return ret;
 
 	for (i = 0; i < pdata->num_leds; i++) {
-		ret = create_netxbig_led(pdev, &leds_data[i], &pdata->leds[i]);
+		ret = create_netxbig_led(pdev, i, priv);
 		if (ret < 0)
 			goto err_free_leds;
 	}
-
-	platform_set_drvdata(pdev, leds_data);
+	platform_set_drvdata(pdev, priv);
 
 	return 0;
 
 err_free_leds:
 	for (i = i - 1; i >= 0; i--)
-		delete_netxbig_led(&leds_data[i]);
+		delete_netxbig_led(&priv->leds_data[i]);
 
 	gpio_ext_free(pdata->gpio_ext);
 	return ret;
@@ -385,14 +602,12 @@ err_free_leds:
 
 static int netxbig_led_remove(struct platform_device *pdev)
 {
-	struct netxbig_led_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct netxbig_led_data *leds_data;
+	struct netxbig_led_priv *priv = platform_get_drvdata(pdev);
+	struct netxbig_led_platform_data *pdata = priv->pdata;
 	int i;
 
-	leds_data = platform_get_drvdata(pdev);
-
 	for (i = 0; i < pdata->num_leds; i++)
-		delete_netxbig_led(&leds_data[i]);
+		delete_netxbig_led(&priv->leds_data[i]);
 
 	gpio_ext_free(pdata->gpio_ext);
 
@@ -403,7 +618,8 @@ static struct platform_driver netxbig_led_driver = {
 	.probe		= netxbig_led_probe,
 	.remove		= netxbig_led_remove,
 	.driver		= {
-		.name	= "leds-netxbig",
+		.name		= "leds-netxbig",
+		.of_match_table	= of_match_ptr(of_netxbig_leds_match),
 	},
 };
 
diff --git a/include/dt-bindings/leds/leds-netxbig.h b/include/dt-bindings/leds/leds-netxbig.h
new file mode 100644
index 000000000000..92658b0310b2
--- /dev/null
+++ b/include/dt-bindings/leds/leds-netxbig.h
@@ -0,0 +1,18 @@
+/*
+ * This header provides constants for netxbig LED bindings.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef _DT_BINDINGS_LEDS_NETXBIG_H
+#define _DT_BINDINGS_LEDS_NETXBIG_H
+
+#define NETXBIG_LED_OFF		0
+#define NETXBIG_LED_ON		1
+#define NETXBIG_LED_SATA	2
+#define NETXBIG_LED_TIMER1	3
+#define NETXBIG_LED_TIMER2	4
+
+#endif /* _DT_BINDINGS_LEDS_NETXBIG_H */
-- 
2.1.4
