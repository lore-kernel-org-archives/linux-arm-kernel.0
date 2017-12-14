From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 14 Dec 2017 15:21:35 +0100
Subject: [RFC PATCH 4/7] gpio: gpiolib: add bias support
In-Reply-To: <20171214142138.23008-1-ludovic.desroches@microchip.com>
References: <20171214142138.23008-1-ludovic.desroches@microchip.com>
Message-ID: <20171214142138.23008-5-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we want to setup the bias of a pin used as a GPIO, we have,
at least for some pin controllers, to declare it in the pinmuxing
in order to apply the configuration wanted.

If the pinmuxing strict mode is enabled, there is a conflict when
the device driver requests the GPIO. It is due to an ownership
mismatch. The device driver has requested the pin through the
pinctrl so the owner is the device. When the GPIO is requested,
there is a conflict because the owner of the GPIO is the pin
controller not the requester.

This patch provides a way to add the bias configuration to the
flags of a GPIO.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/gpio/gpiolib-of.c       |  9 +++++++++
 drivers/gpio/gpiolib.c          | 34 ++++++++++++++++++++++++++++------
 drivers/gpio/gpiolib.h          |  3 +++
 include/dt-bindings/gpio/gpio.h |  9 +++++++++
 include/linux/gpio/machine.h    |  3 +++
 include/linux/of_gpio.h         |  3 +++
 6 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 67b1a7ff1e97..9c6da8c2e97c 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -158,6 +158,15 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
 	if (of_flags & OF_GPIO_TRANSITORY)
 		*flags |= GPIO_TRANSITORY;
 
+	if (of_flags & OF_GPIO_BIAS_PULL_UP)
+		*flags |= GPIO_BIAS_PULL_UP;
+
+	if (of_flags & OF_GPIO_BIAS_PULL_DOWN)
+		*flags |= GPIO_BIAS_PULL_DOWN;
+
+	if (of_flags & OF_GPIO_BIAS_DISABLE)
+		*flags |= GPIO_BIAS_DISABLE;
+
 	return desc;
 }
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c887602ca0ff..2caec626dcd5 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2133,7 +2133,7 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 {
 	struct gpio_chip	*chip = desc->gdev->chip;
 	int			status;
-	unsigned long		flags;
+	unsigned long		flags, config = 0;
 
 	spin_lock_irqsave(&gpio_lock, flags);
 
@@ -2161,6 +2161,16 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 			goto done;
 		}
 	}
+	if (chip->set_config) {
+		/* The following flags are exclusive. */
+		if (test_bit(FLAG_BIAS_PULL_UP,  &desc->flags))
+			config |= pinconf_to_config_packed(PIN_CONFIG_BIAS_PULL_UP, 1);
+		else if (test_bit(FLAG_BIAS_PULL_DOWN,  &desc->flags))
+			config |= pinconf_to_config_packed(PIN_CONFIG_BIAS_PULL_DOWN, 1);
+		else if (test_bit(FLAG_BIAS_DISABLE,  &desc->flags))
+			config |= pinconf_to_config_packed(PIN_CONFIG_BIAS_DISABLE, 1);
+		chip->set_config(chip, gpio_chip_hwgpio(desc), config);
+	}
 	if (chip->get_direction) {
 		/* chip->get_direction may sleep */
 		spin_unlock_irqrestore(&gpio_lock, flags);
@@ -3587,6 +3597,16 @@ void gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 	if (lflags & GPIO_OPEN_SOURCE)
 		set_bit(FLAG_OPEN_SOURCE, &desc->flags);
 
+	if (lflags & GPIO_BIAS_PULL_UP)
+		set_bit(FLAG_BIAS_PULL_UP, &desc->flags);
+
+	if (lflags & GPIO_BIAS_PULL_DOWN)
+		set_bit(FLAG_BIAS_PULL_DOWN, &desc->flags);
+
+	if (lflags & GPIO_BIAS_DISABLE)
+		set_bit(FLAG_BIAS_DISABLE, &desc->flags);
+}
+
 int gpiod_process_flags(struct gpio_desc *desc, const char *con_id,
 		unsigned long lflags, enum gpiod_flags dflags)
 {
@@ -3760,10 +3780,6 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 	if (IS_ERR(desc))
 		return desc;
 
-	ret = gpiod_request(desc, label);
-	if (ret)
-		return ERR_PTR(ret);
-
 	if (active_low)
 		lflags |= GPIO_ACTIVE_LOW;
 
@@ -3777,7 +3793,13 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 	if (transitory)
 		lflags |= GPIO_TRANSITORY;
 
-	ret = gpiod_configure_and_process_flags(desc, propname, lflags, dflags);
+	gpiod_configure_flags(desc, propname, lflags, dflags);
+
+	ret = gpiod_request(desc, label);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = gpiod_process_flags(desc, propname, lflags, dflags);
 	if (ret < 0) {
 		gpiod_put(desc);
 		return ERR_PTR(ret);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index a03553d4be1c..381a7a1bf540 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -210,6 +210,9 @@ struct gpio_desc {
 #define FLAG_USED_AS_IRQ 9	/* GPIO is connected to an IRQ */
 #define FLAG_IS_HOGGED	11	/* GPIO is hogged */
 #define FLAG_TRANSITORY 12	/* GPIO may lose value in sleep or reset */
+#define FLAG_BIAS_PULL_UP 13
+#define FLAG_BIAS_PULL_DOWN 14
+#define FLAG_BIAS_DISABLE 15
 
 	/* Connection label */
 	const char		*label;
diff --git a/include/dt-bindings/gpio/gpio.h b/include/dt-bindings/gpio/gpio.h
index 2cc10ae4bbb7..28ccfce72c59 100644
--- a/include/dt-bindings/gpio/gpio.h
+++ b/include/dt-bindings/gpio/gpio.h
@@ -33,4 +33,13 @@
 #define GPIO_PERSISTENT 0
 #define GPIO_TRANSITORY 8
 
+/* Bit 4 express Bias Pull up */
+#define GPIO_BIAS_PULL_UP 16
+
+/* Bit 5 express Bias Pull down */
+#define GPIO_BIAS_PULL_DOWN 32
+
+/* Bit 6 express Bias Disable */
+#define GPIO_BIAS_DISABLE 64
+
 #endif
diff --git a/include/linux/gpio/machine.h b/include/linux/gpio/machine.h
index b2f2dc638463..e0b6ac64871f 100644
--- a/include/linux/gpio/machine.h
+++ b/include/linux/gpio/machine.h
@@ -12,6 +12,9 @@ enum gpio_lookup_flags {
 	GPIO_OPEN_SOURCE = (1 << 2),
 	GPIO_PERSISTENT = (0 << 3),
 	GPIO_TRANSITORY = (1 << 3),
+	GPIO_BIAS_PULL_UP = (1 << 4),
+	GPIO_BIAS_PULL_DOWN = (1 << 5),
+	GPIO_BIAS_DISABLE = (1 << 6),
 };
 
 /**
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index f928c2df2bcd..1b025e6680ea 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -33,6 +33,9 @@ enum of_gpio_flags {
 	OF_GPIO_SINGLE_ENDED	= BIT(1),
 	OF_GPIO_OPEN_DRAIN	= BIT(2),
 	OF_GPIO_TRANSITORY	= BIT(3),
+	OF_GPIO_BIAS_PULL_UP	= BIT(4),
+	OF_GPIO_BIAS_PULL_DOWN	= BIT(5),
+	OF_GPIO_BIAS_DISABLE	= BIT(6),
 };
 
 #ifdef CONFIG_OF_GPIO
-- 
2.12.2
