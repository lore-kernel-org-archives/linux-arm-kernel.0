From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Mon, 24 Oct 2016 18:46:26 +0200
Subject: [PATCH/RFT v2 09/17] regulator: fixed: Add over current event
In-Reply-To: <20161024164634.4330-1-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
Message-ID: <20161024164634.4330-10-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

Some regulator supplies have an over-current pin that is
activated when the hw detects an over current condition.
When this happens, the hardware enters a current limited
mode.

Extend the fixed regulator driver with the ability
to handle irq's from the over-current pin and report
an over current event to the consumers via a regulator
notifier. Also, add device tree bindings to allow to
pass a gpio for over current monitoring.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 .../bindings/regulator/fixed-regulator.txt         |  4 ++
 drivers/regulator/fixed.c                          | 64 ++++++++++++++++++++++
 include/linux/regulator/consumer.h                 |  5 ++
 include/linux/regulator/fixed.h                    |  3 +
 4 files changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
index 4fae41d..d20bf67 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
@@ -11,6 +11,8 @@ If this property is missing, the default assumed is Active low.
 - gpio-open-drain: GPIO is open drain type.
   If this property is missing then default assumption is false.
 -vin-supply: Input supply name.
+- oc-gpio: Input gpio that signals an over current condition
+- oc-active-high: The polarity of the over current pin is high
 
 Any property defined as part of the core regulator
 binding, defined in regulator.txt, can also be used.
@@ -26,9 +28,11 @@ Example:
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		gpio = <&gpio1 16 0>;
+		oc-gpio = <&gpio1 18 0>;
 		startup-delay-us = <70000>;
 		enable-active-high;
 		regulator-boot-on;
 		gpio-open-drain;
+		oc-active-high;
 		vin-supply = <&parent_reg>;
 	};
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 988a747..e7964bb 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -30,10 +30,14 @@
 #include <linux/of_gpio.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/machine.h>
+#include <linux/interrupt.h>
 
 struct fixed_voltage_data {
 	struct regulator_desc desc;
 	struct regulator_dev *dev;
+	int oc_gpio;
+	unsigned has_oc_gpio:1;
+	unsigned oc_high:1;
 };
 
 
@@ -82,6 +86,14 @@ struct fixed_voltage_data {
 	if ((config->gpio < 0) && (config->gpio != -ENOENT))
 		return ERR_PTR(config->gpio);
 
+	config->oc_gpio = of_get_named_gpio(np, "oc-gpio", 0);
+	if (config->oc_gpio >= 0)
+		config->has_oc_gpio = true;
+	else if (config->oc_gpio != -ENOENT)
+		return ERR_PTR(config->oc_gpio);
+
+	config->oc_high = of_property_read_bool(np, "oc-active-high");
+
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
 
 	config->enable_high = of_property_read_bool(np, "enable-active-high");
@@ -94,7 +106,34 @@ struct fixed_voltage_data {
 	return config;
 }
 
+static irqreturn_t reg_fixed_overcurrent_irq(int irq, void *data)
+{
+	struct fixed_voltage_data *drvdata = data;
+
+	regulator_notifier_call_chain(drvdata->dev,
+			REGULATOR_EVENT_OVER_CURRENT, NULL);
+
+	return IRQ_HANDLED;
+}
+
+static unsigned int reg_fixed_get_mode(struct regulator_dev *rdev)
+{
+	struct fixed_voltage_data *drvdata = rdev_get_drvdata(rdev);
+	unsigned int ret = REGULATOR_MODE_NORMAL;
+	int oc_value;
+
+	if (!drvdata->has_oc_gpio)
+		return ret;
+
+	oc_value = gpio_get_value(drvdata->oc_gpio);
+	if ((oc_value && drvdata->oc_high) || (!oc_value && !drvdata->oc_high))
+		ret = REGULATOR_MODE_OVERCURRENT;
+
+	return ret;
+}
+
 static struct regulator_ops fixed_voltage_ops = {
+	.get_mode = reg_fixed_get_mode,
 };
 
 static int reg_fixed_voltage_probe(struct platform_device *pdev)
@@ -175,6 +214,31 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	cfg.driver_data = drvdata;
 	cfg.of_node = pdev->dev.of_node;
 
+	if (config->has_oc_gpio && gpio_is_valid(config->oc_gpio)) {
+		ret = devm_gpio_request_one(&pdev->dev,
+					config->oc_gpio,
+					GPIOF_DIR_IN, "oc_gpio");
+		if (ret) {
+			pr_err("Failed to request gpio: %d\n", ret);
+			return ret;
+		}
+
+		ret = devm_request_threaded_irq(&pdev->dev,
+				gpio_to_irq(config->oc_gpio), NULL,
+				reg_fixed_overcurrent_irq,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+				IRQF_ONESHOT,
+				"over_current", drvdata);
+		if (ret) {
+			pr_err("Failed to request irq: %d\n", ret);
+			return ret;
+		}
+
+		drvdata->oc_gpio = config->oc_gpio;
+		drvdata->oc_high = config->oc_high;
+		drvdata->has_oc_gpio = config->has_oc_gpio;
+	}
+
 	drvdata->dev = devm_regulator_register(&pdev->dev, &drvdata->desc,
 					       &cfg);
 	if (IS_ERR(drvdata->dev)) {
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 6921082..9269217 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -74,6 +74,10 @@
  *             the most noisy and may not be able to handle fast load
  *             switching.
  *
+ * OVERCURRENT Regulator has detected an overcurrent condition, and
+ *             may be limiting the supply output.
+ *
+ *
  * NOTE: Most regulators will only support a subset of these modes. Some
  * will only just support NORMAL.
  *
@@ -84,6 +88,7 @@
 #define REGULATOR_MODE_NORMAL			0x2
 #define REGULATOR_MODE_IDLE			0x4
 #define REGULATOR_MODE_STANDBY			0x8
+#define REGULATOR_MODE_OVERCURRENT		0x10
 
 /*
  * Regulator notifier events.
diff --git a/include/linux/regulator/fixed.h b/include/linux/regulator/fixed.h
index 48918be..79357be 100644
--- a/include/linux/regulator/fixed.h
+++ b/include/linux/regulator/fixed.h
@@ -50,10 +50,13 @@ struct fixed_voltage_config {
 	const char *input_supply;
 	int microvolts;
 	int gpio;
+	int oc_gpio;
 	unsigned startup_delay;
 	unsigned gpio_is_open_drain:1;
 	unsigned enable_high:1;
 	unsigned enabled_at_boot:1;
+	unsigned has_oc_gpio:1;
+	unsigned oc_high:1;
 	struct regulator_init_data *init_data;
 };
 
-- 
1.9.1
