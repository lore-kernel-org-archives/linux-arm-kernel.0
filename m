From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 27 Nov 2014 12:20:50 +0100
Subject: [PATCH v4 4/7] regulator: Use ena_gpio supplied with generic regulator
 bindings
In-Reply-To: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
References: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1417087253-12306-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use ena_gpio from regulator constraints (filled by parsing generic
bindings) to initialize the GPIO enable control. Support also the old
way: ena_gpio supplied in regulator_config structure.

This also adds a new set_ena_gpio() callback in regulator_ops structure
which driver may provide to actually enable the GPIO control in
hardware.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/core.c         | 96 ++++++++++++++++++++++++++++++----------
 include/linux/regulator/driver.h |  5 +++
 2 files changed, 78 insertions(+), 23 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index bbf93c9caca3..1760184cd8dc 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -26,6 +26,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/regmap.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/consumer.h>
@@ -1044,6 +1045,14 @@ static int set_machine_constraints(struct regulator_dev *rdev,
 		}
 	}
 
+	if (rdev->constraints->use_ena_gpio && ops->set_ena_gpio) {
+		ret = ops->set_ena_gpio(rdev);
+		if (ret < 0) {
+			rdev_err(rdev, "failed to set enable GPIO control\n");
+			goto out;
+		}
+	}
+
 	print_constraints(rdev);
 	return 0;
 out:
@@ -1660,36 +1669,36 @@ EXPORT_SYMBOL_GPL(regulator_bulk_unregister_supply_alias);
 
 /* Manage enable GPIO list. Same GPIO pin can be shared among regulators */
 static int regulator_ena_gpio_request(struct regulator_dev *rdev,
-				const struct regulator_config *config)
+					unsigned int gpio,
+					bool gpio_invert,
+					unsigned int gpio_flags)
 {
 	struct regulator_enable_gpio *pin;
 	struct gpio_desc *gpiod;
 	int ret;
 
-	gpiod = gpio_to_desc(config->ena_gpio);
+	gpiod = gpio_to_desc(gpio);
 
 	list_for_each_entry(pin, &regulator_ena_gpio_list, list) {
 		if (pin->gpiod == gpiod) {
-			rdev_dbg(rdev, "GPIO %d is already used\n",
-				config->ena_gpio);
+			rdev_dbg(rdev, "GPIO %d is already used\n", gpio);
 			goto update_ena_gpio_to_rdev;
 		}
 	}
 
-	ret = gpio_request_one(config->ena_gpio,
-				GPIOF_DIR_OUT | config->ena_gpio_flags,
+	ret = gpio_request_one(gpio, GPIOF_DIR_OUT | gpio_flags,
 				rdev_get_name(rdev));
 	if (ret)
 		return ret;
 
 	pin = kzalloc(sizeof(struct regulator_enable_gpio), GFP_KERNEL);
 	if (pin == NULL) {
-		gpio_free(config->ena_gpio);
+		gpio_free(gpio);
 		return -ENOMEM;
 	}
 
 	pin->gpiod = gpiod;
-	pin->ena_gpio_invert = config->ena_gpio_invert;
+	pin->ena_gpio_invert = gpio_invert;
 	list_add(&pin->list, &regulator_ena_gpio_list);
 
 update_ena_gpio_to_rdev:
@@ -1698,6 +1707,59 @@ update_ena_gpio_to_rdev:
 	return 0;
 }
 
+/*
+ * Request GPIO for enable control from regulator_config
+ * or init_data->constraints.
+ */
+static int regulator_ena_gpio_setup(struct regulator_dev *rdev,
+			const struct regulator_config *config,
+			const struct regulator_init_data *init_data)
+{
+	unsigned int gpio_flags;
+	bool gpio_invert;
+	int gpio, ret;
+
+	if (config->ena_gpio || config->ena_gpio_initialized) {
+		gpio = config->ena_gpio;
+		gpio_invert = config->ena_gpio_invert;
+		gpio_flags = config->ena_gpio_flags;
+	} else if (init_data && init_data->constraints.use_ena_gpio) {
+		const struct regulation_constraints *c = &init_data->constraints;
+
+		gpio = c->ena_gpio;
+		gpio_invert = false;
+		gpio_flags = GPIOF_OUT_INIT_HIGH;
+
+		if (c->ena_gpio_flags & OF_GPIO_ACTIVE_LOW) {
+			gpio_invert = true;
+			gpio_flags = GPIOF_OUT_INIT_LOW;
+		}
+
+		if (c->ena_gpio_open_drain)
+			gpio_flags |= GPIOF_OPEN_DRAIN;
+	} else {
+		return 0;
+	}
+
+	if (!gpio_is_valid(gpio))
+		return 0;
+
+	ret = regulator_ena_gpio_request(rdev, gpio, gpio_invert, gpio_flags);
+	if (ret != 0) {
+		rdev_err(rdev, "Failed to request enable GPIO%d: %d\n",
+				 gpio, ret);
+		return ret;
+	}
+
+	if (gpio_flags & GPIOF_OUT_INIT_HIGH)
+		rdev->ena_gpio_state = 1;
+
+	if (gpio_invert)
+		rdev->ena_gpio_state = !rdev->ena_gpio_state;
+
+	return 0;
+}
+
 static void regulator_ena_gpio_free(struct regulator_dev *rdev)
 {
 	struct regulator_enable_gpio *pin, *n;
@@ -3650,21 +3712,9 @@ regulator_register(const struct regulator_desc *regulator_desc,
 
 	dev_set_drvdata(&rdev->dev, rdev);
 
-	if ((config->ena_gpio || config->ena_gpio_initialized) &&
-	    gpio_is_valid(config->ena_gpio)) {
-		ret = regulator_ena_gpio_request(rdev, config);
-		if (ret != 0) {
-			rdev_err(rdev, "Failed to request enable GPIO%d: %d\n",
-				 config->ena_gpio, ret);
-			goto wash;
-		}
-
-		if (config->ena_gpio_flags & GPIOF_OUT_INIT_HIGH)
-			rdev->ena_gpio_state = 1;
-
-		if (config->ena_gpio_invert)
-			rdev->ena_gpio_state = !rdev->ena_gpio_state;
-	}
+	ret = regulator_ena_gpio_setup(rdev, config, init_data);
+	if (ret != 0)
+		goto wash;
 
 	/* set regulator constraints */
 	if (init_data)
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 28da08e4671f..fe967a0c6ce7 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -118,6 +118,9 @@ struct regulator_linear_range {
  *                       suspended.
  * @set_suspend_mode: Set the operating mode for the regulator when the
  *                    system is suspended.
+ * @set_ena_gpio: Turn on GPIO enable control for given regulator. Called
+ *                by core during registration of regulator when regulator
+ *                was configured for this mode by standard binding.
  *
  * This struct describes regulator operations which can be implemented by
  * regulator chip drivers.
@@ -183,6 +186,8 @@ struct regulator_ops {
 
 	/* set regulator suspend operating mode (defined in consumer.h) */
 	int (*set_suspend_mode) (struct regulator_dev *, unsigned int mode);
+
+	int (*set_ena_gpio)(struct regulator_dev *);
 };
 
 /*
-- 
1.9.1
