From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Oct 2012 14:53:32 +0200
Subject: [PATCH 1/2] i2c: mux: Add dt support to i2c-mux-gpio driver
In-Reply-To: <1350910413-23925-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1350910413-23925-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1350910413-23925-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the i2c-mux-gpio to be used by a device tree enabled device. The
bindings are inspired by the one found in the i2c-mux-pinctrl driver.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/i2c/i2c-mux-gpio.txt       |   81 ++++++++++
 drivers/i2c/muxes/i2c-mux-gpio.c                   |  169 +++++++++++++++-----
 2 files changed, 211 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
new file mode 100644
index 0000000..335fc4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
@@ -0,0 +1,81 @@
+GPIO-based I2C Bus Mux
+
+This binding describes an I2C bus multiplexer that uses GPIOs to
+route the I2C signals.
+
+                                  +-----+  +-----+
+                                  | dev |  | dev |
+    +------------+                +-----+  +-----+
+    | SoC        |                   |        |
+    |            |          /--------+--------+
+    |   +------+ |  +------+    child bus A, on GPIO value set to 0
+    |   | I2C  |-|--| Mux  |
+    |   +------+ |  +--+---+    child bus B, on GPIO value set to 1
+    |            |     |    \----------+--------+--------+
+    |   +------+ |     |               |        |        |
+    |   | GPIO |-|-----+            +-----+  +-----+  +-----+
+    |   +------+ |                  | dev |  | dev |  | dev |
+    +------------+                  +-----+  +-----+  +-----+
+
+Required properties:
+- compatible: i2c-mux-gpio
+- i2c-parent: The phandle of the I2C bus that this multiplexer's master-side
+  port is connected to.
+- mux-gpios: list of gpios to use to control the muxer
+* Standard I2C mux properties. See mux.txt in this directory.
+* I2C child bus nodes. See mux.txt in this directory.
+
+Optional properties:
+- idle-state: value to set to the muxer when idle. When no value is
+  given, it defaults to the last value used.
+
+For each i2c child node, an I2C child bus will be created. They will
+be numbered based on the reg property of each node.
+
+Whenever an access is made to a device on a child bus, the value set
+in the revelant node's reg property will be output using the list of
+GPIOs, the first in the list holding the most-significant value.
+
+If an idle state is defined, using the idle-state (optional) property,
+whenever an access is not being made to a device on a child bus, the
+idle value will be programmed into the GPIOs.
+
+If an idle state is not defined, the most recently used value will be
+left programmed into hardware whenever no access is being made of a
+device on a child bus.
+
+Example:
+	i2cmux {
+		compatible = "i2c-mux-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		mux-gpios = <&gpio1 22 0 &gpio1 23 0>;
+		i2c-parent = <&i2c1>;
+
+		i2c at 1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ssd1307: oled at 3c {
+				compatible = "solomon,ssd1307fb-i2c";
+				reg = <0x3c>;
+				pwms = <&pwm 4 3000>;
+				reset-gpios = <&gpio2 7 1>;
+				reset-active-low;
+			};
+		};
+
+		i2c at 3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pca9555: pca9555 at 20 {
+				compatible = "nxp,pca9555";
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x20>;
+			};
+		};
+	};
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index 566a675..7ebef01 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -16,11 +16,13 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/gpio.h>
+#include <linux/of_i2c.h>
+#include <linux/of_gpio.h>
 
 struct gpiomux {
 	struct i2c_adapter *parent;
 	struct i2c_adapter **adap; /* child busses */
-	struct i2c_mux_gpio_platform_data data;
+	struct i2c_mux_gpio_platform_data *data;
 	unsigned gpio_base;
 };
 
@@ -28,8 +30,8 @@ static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
 {
 	int i;
 
-	for (i = 0; i < mux->data.n_gpios; i++)
-		gpio_set_value(mux->gpio_base + mux->data.gpios[i],
+	for (i = 0; i < mux->data->n_gpios; i++)
+		gpio_set_value(mux->gpio_base + mux->data->gpios[i],
 			       val & (1 << i));
 }
 
@@ -37,7 +39,7 @@ static int i2c_mux_gpio_select(struct i2c_adapter *adap, void *data, u32 chan)
 {
 	struct gpiomux *mux = data;
 
-	i2c_mux_gpio_set(mux, mux->data.values[chan]);
+	i2c_mux_gpio_set(mux, mux->data->values[chan]);
 
 	return 0;
 }
@@ -46,7 +48,7 @@ static int i2c_mux_gpio_deselect(struct i2c_adapter *adap, void *data, u32 chan)
 {
 	struct gpiomux *mux = data;
 
-	i2c_mux_gpio_set(mux, mux->data.idle);
+	i2c_mux_gpio_set(mux, mux->data->idle);
 
 	return 0;
 }
@@ -57,29 +59,118 @@ static int __devinit match_gpio_chip_by_label(struct gpio_chip *chip,
 	return !strcmp(chip->label, data);
 }
 
+#ifdef CONFIG_OF
+static int __devinit i2c_mux_gpio_probe_dt(struct gpiomux *mux,
+					struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *adapter_np, *child;
+	struct i2c_adapter *adapter;
+	unsigned *values, *gpios;
+	int i = 0;
+
+	if (!np)
+		return 0;
+
+	mux->data = devm_kzalloc(&pdev->dev, sizeof(*mux->data),
+				GFP_KERNEL);
+	if (!mux->data) {
+		dev_err(&pdev->dev, "Cannot allocate platform_data");
+		return -ENOMEM;
+	}
+
+	adapter_np = of_parse_phandle(np, "i2c-parent", 0);
+	if (!adapter_np) {
+		dev_err(&pdev->dev, "Cannot parse i2c-parent\n");
+		return -ENODEV;
+	}
+	adapter = of_find_i2c_adapter_by_node(adapter_np);
+	if (!adapter) {
+		dev_err(&pdev->dev, "Cannot find parent bus\n");
+		return -ENODEV;
+	}
+	mux->data->parent = i2c_adapter_id(adapter);
+	put_device(&adapter->dev);
+
+	mux->data->n_values = of_get_child_count(np);
+
+	values = devm_kzalloc(&pdev->dev,
+			      sizeof(*mux->data->values) * mux->data->n_values,
+			      GFP_KERNEL);
+	if (!values) {
+		dev_err(&pdev->dev, "Cannot allocate values array");
+		return -ENOMEM;
+	}
+
+	for_each_child_of_node(np, child) {
+		of_property_read_u32(child, "reg", values + i);
+		i++;
+	}
+	mux->data->values = values;
+
+	if (of_property_read_u32(np, "idle-state", &mux->data->idle))
+		mux->data->idle = I2C_MUX_GPIO_NO_IDLE;
+
+	mux->data->n_gpios = of_gpio_named_count(np, "mux-gpios");
+	if (mux->data->n_gpios < 0) {
+		dev_err(&pdev->dev, "Missing mux-gpios property in the DT.\n");
+		return -EINVAL;
+	}
+
+	gpios = devm_kzalloc(&pdev->dev,
+			     sizeof(*mux->data->gpios) * mux->data->n_gpios,
+                             GFP_KERNEL);
+	if (!gpios) {
+		dev_err(&pdev->dev, "Cannot allocate gpios array");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < mux->data->n_gpios; i++)
+		gpios[i] = of_get_named_gpio(np, "mux-gpios", i);
+
+	mux->data->gpios = gpios;
+
+	return 0;
+}
+#else
+static int __devinit i2c_mux_gpio_probe_dt(struct gpiomux *mux,
+					struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
 static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
 {
 	struct gpiomux *mux;
-	struct i2c_mux_gpio_platform_data *pdata;
 	struct i2c_adapter *parent;
 	int (*deselect) (struct i2c_adapter *, void *, u32);
 	unsigned initial_state, gpio_base;
 	int i, ret;
 
-	pdata = pdev->dev.platform_data;
-	if (!pdata) {
-		dev_err(&pdev->dev, "Missing platform data\n");
-		return -ENODEV;
+	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
+	if (!mux) {
+		dev_err(&pdev->dev, "Cannot allocate gpiomux structure");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, mux);
+
+	mux->data = pdev->dev.platform_data;
+	if (!mux->data) {
+		ret = i2c_mux_gpio_probe_dt(mux, pdev);
+		if (ret < 0)
+			return ret;
 	}
 
 	/*
 	 * If a GPIO chip name is provided, the GPIO pin numbers provided are
 	 * relative to its base GPIO number. Otherwise they are absolute.
 	 */
-	if (pdata->gpio_chip) {
+	if (mux->data->gpio_chip) {
 		struct gpio_chip *gpio;
 
-		gpio = gpiochip_find(pdata->gpio_chip,
+		gpio = gpiochip_find(mux->data->gpio_chip,
 				     match_gpio_chip_by_label);
 		if (!gpio)
 			return -EPROBE_DEFER;
@@ -89,49 +180,44 @@ static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
 		gpio_base = 0;
 	}
 
-	parent = i2c_get_adapter(pdata->parent);
+	parent = i2c_get_adapter(mux->data->parent);
 	if (!parent) {
 		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
-			pdata->parent);
+			mux->data->parent);
 		return -ENODEV;
 	}
 
-	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
-	if (!mux) {
-		ret = -ENOMEM;
-		goto alloc_failed;
-	}
-
 	mux->parent = parent;
-	mux->data = *pdata;
 	mux->gpio_base = gpio_base;
+
 	mux->adap = devm_kzalloc(&pdev->dev,
-				 sizeof(*mux->adap) * pdata->n_values,
+				 sizeof(*mux->adap) * mux->data->n_values,
 				 GFP_KERNEL);
 	if (!mux->adap) {
+		dev_err(&pdev->dev, "Cannot allocate i2c_adapter structure");
 		ret = -ENOMEM;
 		goto alloc_failed;
 	}
 
-	if (pdata->idle != I2C_MUX_GPIO_NO_IDLE) {
-		initial_state = pdata->idle;
+	if (mux->data->idle != I2C_MUX_GPIO_NO_IDLE) {
+		initial_state = mux->data->idle;
 		deselect = i2c_mux_gpio_deselect;
 	} else {
-		initial_state = pdata->values[0];
+		initial_state = mux->data->values[0];
 		deselect = NULL;
 	}
 
-	for (i = 0; i < pdata->n_gpios; i++) {
-		ret = gpio_request(gpio_base + pdata->gpios[i], "i2c-mux-gpio");
+	for (i = 0; i < mux->data->n_gpios; i++) {
+		ret = gpio_request(gpio_base + mux->data->gpios[i], "i2c-mux-gpio");
 		if (ret)
 			goto err_request_gpio;
-		gpio_direction_output(gpio_base + pdata->gpios[i],
+		gpio_direction_output(gpio_base + mux->data->gpios[i],
 				      initial_state & (1 << i));
 	}
 
-	for (i = 0; i < pdata->n_values; i++) {
-		u32 nr = pdata->base_nr ? (pdata->base_nr + i) : 0;
-		unsigned int class = pdata->classes ? pdata->classes[i] : 0;
+	for (i = 0; i < mux->data->n_values; i++) {
+		u32 nr = mux->data->base_nr ? (mux->data->base_nr + i) : 0;
+		unsigned int class = mux->data->classes ? mux->data->classes[i] : 0;
 
 		mux->adap[i] = i2c_add_mux_adapter(parent, &pdev->dev, mux, nr,
 						   i, class,
@@ -144,19 +230,17 @@ static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
 	}
 
 	dev_info(&pdev->dev, "%d port mux on %s adapter\n",
-		 pdata->n_values, parent->name);
-
-	platform_set_drvdata(pdev, mux);
+		 mux->data->n_values, parent->name);
 
 	return 0;
 
 add_adapter_failed:
 	for (; i > 0; i--)
 		i2c_del_mux_adapter(mux->adap[i - 1]);
-	i = pdata->n_gpios;
+	i = mux->data->n_gpios;
 err_request_gpio:
 	for (; i > 0; i--)
-		gpio_free(gpio_base + pdata->gpios[i - 1]);
+		gpio_free(gpio_base + mux->data->gpios[i - 1]);
 alloc_failed:
 	i2c_put_adapter(parent);
 
@@ -168,11 +252,11 @@ static int __devexit i2c_mux_gpio_remove(struct platform_device *pdev)
 	struct gpiomux *mux = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < mux->data.n_values; i++)
+	for (i = 0; i < mux->data->n_values; i++)
 		i2c_del_mux_adapter(mux->adap[i]);
 
-	for (i = 0; i < mux->data.n_gpios; i++)
-		gpio_free(mux->gpio_base + mux->data.gpios[i]);
+	for (i = 0; i < mux->data->n_gpios; i++)
+		gpio_free(mux->gpio_base + mux->data->gpios[i]);
 
 	platform_set_drvdata(pdev, NULL);
 	i2c_put_adapter(mux->parent);
@@ -180,12 +264,19 @@ static int __devexit i2c_mux_gpio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id i2c_mux_gpio_of_match[] __devinitconst = {
+	{ .compatible = "i2c-mux-gpio", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, i2c_mux_gpio_of_match);
+
 static struct platform_driver i2c_mux_gpio_driver = {
 	.probe	= i2c_mux_gpio_probe,
 	.remove	= __devexit_p(i2c_mux_gpio_remove),
 	.driver	= {
 		.owner	= THIS_MODULE,
 		.name	= "i2c-mux-gpio",
+		.of_match_table = of_match_ptr(i2c_mux_gpio_of_match),
 	},
 };
 
-- 
1.7.9.5
