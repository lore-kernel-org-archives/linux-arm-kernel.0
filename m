From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Mon, 15 Jan 2018 17:22:33 +0100
Subject: [RFC PATCH 2/2] gpio: provide a consumer when requesting a gpio
In-Reply-To: <20180115162233.6205-1-ludovic.desroches@microchip.com>
References: <20180115162233.6205-1-ludovic.desroches@microchip.com>
Message-ID: <20180115162233.6205-3-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It can be useful for the pinmuxing layer to know which device is
requesting a GPIO. Add a consumer variant for gpiod_request to
reach this goal.

GPIO chips managed by pin controllers should provide the new
request_consumer operation. They can rely on
gpiochip_generic_request_consumer instead of
gpiochip_generic_request.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/gpio/gpiolib.c      | 40 +++++++++++++++++++++++++++++++++-------
 include/linux/gpio/driver.h |  5 +++++
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 39a0144d5be5..e6645101ec74 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1970,6 +1970,20 @@ int gpiochip_generic_request(struct gpio_chip *chip, unsigned offset)
 EXPORT_SYMBOL_GPL(gpiochip_generic_request);
 
 /**
+ * gpiochip_generic_request_consumer() - request the gpio function for a pin
+ * @chip: the gpiochip owning the GPIO
+ * @offset: the offset of the GPIO to request for GPIO function
+ * @consumer: name of the device requesting the GPIO
+ */
+int gpiochip_generic_request_consumer(struct gpio_chip *chip, unsigned offset,
+				      const char *consumer)
+{
+	return pinctrl_gpio_request_consumer(chip->gpiodev->base + offset,
+					     consumer);
+}
+EXPORT_SYMBOL_GPL(gpiochip_generic_request_consumer);
+
+/**
  * gpiochip_generic_free() - free the gpio function from a pin
  * @chip: the gpiochip to request the gpio function for
  * @offset: the offset of the GPIO to free from GPIO function
@@ -2119,7 +2133,8 @@ EXPORT_SYMBOL_GPL(gpiochip_remove_pin_ranges);
  * on each other, and help provide better diagnostics in debugfs.
  * They're called even less than the "set direction" calls.
  */
-static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
+static int gpiod_request_commit(struct gpio_desc *desc, const char *label,
+				const char *consumer)
 {
 	struct gpio_chip	*chip = desc->gdev->chip;
 	int			status;
@@ -2139,10 +2154,14 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 		goto done;
 	}
 
-	if (chip->request) {
+	if (chip->request || chip->request_consumer) {
 		/* chip->request may sleep */
 		spin_unlock_irqrestore(&gpio_lock, flags);
-		status = chip->request(chip, gpio_chip_hwgpio(desc));
+		if (chip->request_consumer)
+			status = chip->request_consumer(chip,
+					gpio_chip_hwgpio(desc), consumer);
+		else
+			status = chip->request(chip, gpio_chip_hwgpio(desc));
 		spin_lock_irqsave(&gpio_lock, flags);
 
 		if (status < 0) {
@@ -2200,7 +2219,8 @@ static int validate_desc(const struct gpio_desc *desc, const char *func)
 		return; \
 	} while (0)
 
-int gpiod_request(struct gpio_desc *desc, const char *label)
+int gpiod_request_consumer(struct gpio_desc *desc, const char *label,
+			   const char *consumer)
 {
 	int status = -EPROBE_DEFER;
 	struct gpio_device *gdev;
@@ -2209,7 +2229,7 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
 	gdev = desc->gdev;
 
 	if (try_module_get(gdev->owner)) {
-		status = gpiod_request_commit(desc, label);
+		status = gpiod_request_commit(desc, label, consumer);
 		if (status < 0)
 			module_put(gdev->owner);
 		else
@@ -2222,6 +2242,11 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
 	return status;
 }
 
+int gpiod_request(struct gpio_desc *desc, const char *label)
+{
+	return gpiod_request_consumer(desc, label, NULL);
+}
+
 static bool gpiod_free_commit(struct gpio_desc *desc)
 {
 	bool			ret = false;
@@ -2320,7 +2345,7 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *chip, u16 hwnum,
 		return desc;
 	}
 
-	err = gpiod_request_commit(desc, label);
+	err = gpiod_request_commit(desc, label, NULL);
 	if (err < 0)
 		return ERR_PTR(err);
 
@@ -3672,7 +3697,8 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 	}
 
 	/* If a connection label was passed use that, else use the device name as label */
-	status = gpiod_request(desc, con_id ? con_id : dev_name(dev));
+	status = gpiod_request_consumer(desc, con_id ? con_id : dev_name(dev),
+					dev_name(dev));
 	if (status < 0)
 		return ERR_PTR(status);
 
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 1ba9a331ec51..6bc5c57f0cbd 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -228,6 +228,9 @@ struct gpio_chip {
 
 	int			(*request)(struct gpio_chip *chip,
 						unsigned offset);
+	int			(*request_consumer)(struct gpio_chip *chip,
+						unsigned offset,
+						const char *consumer);
 	void			(*free)(struct gpio_chip *chip,
 						unsigned offset);
 	int			(*get_direction)(struct gpio_chip *chip,
@@ -500,6 +503,8 @@ static inline int gpiochip_irqchip_add_nested(struct gpio_chip *gpiochip,
 #endif /* CONFIG_GPIOLIB_IRQCHIP */
 
 int gpiochip_generic_request(struct gpio_chip *chip, unsigned offset);
+int gpiochip_generic_request_consumer(struct gpio_chip *chip, unsigned offset,
+				      const char *consumer);
 void gpiochip_generic_free(struct gpio_chip *chip, unsigned offset);
 int gpiochip_generic_config(struct gpio_chip *chip, unsigned offset,
 			    unsigned long config);
-- 
2.12.2
