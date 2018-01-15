From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 15 Jan 2018 17:22:32 +0100
Subject: [RFC PATCH 1/2] pinctrl: add consumer variant for gpio request
In-Reply-To: <20180115162233.6205-1-ludovic.desroches@microchip.com>
References: <20180115162233.6205-1-ludovic.desroches@microchip.com>
Message-ID: <20180115162233.6205-2-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a consumer variant to GPIO request relative functions. The goal
is to fix the bad ownership, which is arbitrary set to
"range->name:gpio", of a GPIO.

There is a lack of configuration features for GPIO. For instance,
we can't set the bias. Some pin controllers manage both device's
pins and GPIOs. GPIOs can benefit from pin configuration. Usually,
a pinctrl node is used to mux the pin as a GPIO and to set up its
configuration.

The pinmuxing strict mode involves that a pin which is muxed can't
be requested as a GPIO if the owner is not the same. Unfortunately,
the ownership of a GPIO is set arbitrarily to "range->name:gpio".
So there is a mismatch about the ownership which prevents a device
from being the owner of the pinmuxing and requesting the same pin as
a GPIO.

Adding some consumer variants for GPIO request stuff will allow to
pass the name of the device which requests the GPIO to not return an
error if it's also the owner of the pinmuxing.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/pinctrl/core.c           | 13 ++++++++++---
 drivers/pinctrl/pinmux.c         | 16 ++++++++++++++--
 drivers/pinctrl/pinmux.h         | 10 ++++++++++
 include/linux/pinctrl/consumer.h |  6 ++++++
 4 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 2c0dbfcff3e6..51c75a6057b2 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -733,14 +733,15 @@ int pinctrl_get_group_selector(struct pinctrl_dev *pctldev,
 }
 
 /**
- * pinctrl_gpio_request() - request a single pin to be used as GPIO
+ * pinctrl_gpio_request_consumer() - request a single pin to be used as GPIO
  * @gpio: the GPIO pin number from the GPIO subsystem number space
+ * @consumer: the name of the device requesting the GPIO
  *
  * This function should *ONLY* be used from gpiolib-based GPIO drivers,
  * as part of their gpio_request() semantics, platforms and individual drivers
  * shall *NOT* request GPIO pins to be muxed in.
  */
-int pinctrl_gpio_request(unsigned gpio)
+int pinctrl_gpio_request_consumer(unsigned gpio, const char *consumer)
 {
 	struct pinctrl_dev *pctldev;
 	struct pinctrl_gpio_range *range;
@@ -759,12 +760,18 @@ int pinctrl_gpio_request(unsigned gpio)
 	/* Convert to the pin controllers number space */
 	pin = gpio_to_pin(range, gpio);
 
-	ret = pinmux_request_gpio(pctldev, range, pin, gpio);
+	ret = pinmux_request_gpio_consumer(pctldev, range, pin, gpio, consumer);
 
 	mutex_unlock(&pctldev->mutex);
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pinctrl_gpio_request_consumer);
+
+int pinctrl_gpio_request(unsigned gpio)
+{
+	return pinctrl_gpio_request_consumer(gpio, NULL);
+}
 EXPORT_SYMBOL_GPL(pinctrl_gpio_request);
 
 /**
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 55502fc4479c..8d422eb0ed38 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -232,14 +232,19 @@ static const char *pin_free(struct pinctrl_dev *pctldev, int pin,
  * @pctldev: pin controller device affected
  * @pin: the pin to mux in for GPIO
  * @range: the applicable GPIO range
+ * @consumer: the name of the device requesting the GPIO
  */
-int pinmux_request_gpio(struct pinctrl_dev *pctldev,
+int pinmux_request_gpio_consumer(struct pinctrl_dev *pctldev,
 			struct pinctrl_gpio_range *range,
-			unsigned pin, unsigned gpio)
+			unsigned pin, unsigned gpio,
+			const char *consumer)
 {
 	const char *owner;
 	int ret;
 
+	if (consumer)
+		return pin_request(pctldev, pin, consumer, range);
+
 	/* Conjure some name stating what chip and pin this is taken by */
 	owner = kasprintf(GFP_KERNEL, "%s:%d", range->name, gpio);
 	if (!owner)
@@ -252,6 +257,13 @@ int pinmux_request_gpio(struct pinctrl_dev *pctldev,
 	return ret;
 }
 
+int pinmux_request_gpio(struct pinctrl_dev *pctldev,
+			struct pinctrl_gpio_range *range,
+			unsigned pin, unsigned gpio)
+{
+	return pinmux_request_gpio_consumer(pctldev, range, pin, gpio, NULL);
+}
+
 /**
  * pinmux_free_gpio() - release a pin from GPIO muxing
  * @pctldev: the pin controller device for the pin
diff --git a/drivers/pinctrl/pinmux.h b/drivers/pinctrl/pinmux.h
index a331fcdbedd9..837599922a42 100644
--- a/drivers/pinctrl/pinmux.h
+++ b/drivers/pinctrl/pinmux.h
@@ -19,6 +19,9 @@ int pinmux_validate_map(const struct pinctrl_map *map, int i);
 int pinmux_request_gpio(struct pinctrl_dev *pctldev,
 			struct pinctrl_gpio_range *range,
 			unsigned pin, unsigned gpio);
+int pinmux_request_gpio_consumer(struct pinctrl_dev *pctldev,
+			struct pinctrl_gpio_range *range,
+			unsigned pin, unsigned gpio, const char *consumer);
 void pinmux_free_gpio(struct pinctrl_dev *pctldev, unsigned pin,
 		      struct pinctrl_gpio_range *range);
 int pinmux_gpio_direction(struct pinctrl_dev *pctldev,
@@ -50,6 +53,13 @@ static inline int pinmux_request_gpio(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static inline int pinmux_request_gpio_consumer(struct pinctrl_dev *pctldev,
+			struct pinctrl_gpio_range *range,
+			unsigned pin, unsigned gpio, const char *consumer)
+{
+	return 0;
+}
+
 static inline void pinmux_free_gpio(struct pinctrl_dev *pctldev,
 				    unsigned pin,
 				    struct pinctrl_gpio_range *range)
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 0412cc9833e9..8c521a14db43 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -26,6 +26,7 @@ struct device;
 
 /* External interface to pin control */
 extern int pinctrl_gpio_request(unsigned gpio);
+extern int pinctrl_gpio_request_consumer(unsigned gpio, const char *consumer);
 extern void pinctrl_gpio_free(unsigned gpio);
 extern int pinctrl_gpio_direction_input(unsigned gpio);
 extern int pinctrl_gpio_direction_output(unsigned gpio);
@@ -67,6 +68,11 @@ static inline int pinctrl_gpio_request(unsigned gpio)
 	return 0;
 }
 
+static inline int pinctrl_gpio_request_consumer(unsigned gpio, const char *consumer);
+{
+	return 0;
+}
+
 static inline void pinctrl_gpio_free(unsigned gpio)
 {
 }
-- 
2.12.2
