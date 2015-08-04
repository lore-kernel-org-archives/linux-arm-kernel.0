From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue,  4 Aug 2015 11:23:19 +0200
Subject: [PATCH 2/6] gpio: Introduce gpio descriptor 'name'
In-Reply-To: <1438680203-13432-1-git-send-email-mpa@pengutronix.de>
References: <1438680203-13432-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1438680203-13432-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest gpio hogging mechanism assigns each gpio a 'line-name' in the
devicetree. The 'name' field is different from the 'label' field.
'label' is only used for requested GPIOs to describe its current use by
driver or userspace.

The 'name' field describes the GPIO itself, not the use. This is most
likely identical to the label in the schematic on the GPIO line and
should help to find this particular GPIO.

This patch adds a helper function to find gpio descriptors by name
instead of gpio number.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/gpio/gpiolib.c        | 32 ++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.h        |  3 +++
 include/linux/gpio/consumer.h |  7 +++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index bf4bd1d120c3..edfeb0485112 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -90,6 +90,38 @@ struct gpio_desc *gpio_to_desc(unsigned gpio)
 EXPORT_SYMBOL_GPL(gpio_to_desc);
 
 /**
+ * Convert a GPIO name to its descriptor
+ */
+struct gpio_desc *gpio_name_to_desc(const char *name)
+{
+	struct gpio_chip *chip;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	list_for_each_entry(chip, &gpio_chips, list) {
+		int i;
+
+		for (i = 0; i != chip->ngpio; ++i) {
+			struct gpio_desc *gpio = &chip->desc[i];
+
+			if (!gpio->name)
+				continue;
+
+			if (!strcmp(gpio->name, name)) {
+				spin_unlock_irqrestore(&gpio_lock, flags);
+				return gpio;
+			}
+		}
+	}
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(gpio_name_to_desc);
+
+/**
  * Get the GPIO descriptor corresponding to the given hw number for this chip.
  */
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip,
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index bf343004b008..78e634d1c719 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -89,7 +89,10 @@ struct gpio_desc {
 #define FLAG_USED_AS_IRQ 9	/* GPIO is connected to an IRQ */
 #define FLAG_IS_HOGGED	11	/* GPIO is hogged */
 
+	/* Connection label */
 	const char		*label;
+	/* Name of the GPIO */
+	const char		*name;
 };
 
 int gpiod_request(struct gpio_desc *desc, const char *label);
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index adac255aee86..a873b8b47ab3 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -130,6 +130,7 @@ int gpiod_to_irq(const struct gpio_desc *desc);
 /* Convert between the old gpio_ and new gpiod_ interfaces */
 struct gpio_desc *gpio_to_desc(unsigned gpio);
 int desc_to_gpio(const struct gpio_desc *desc);
+struct gpio_desc *gpio_name_to_desc(const char *name);
 
 /* Child properties interface */
 struct fwnode_handle;
@@ -400,6 +401,12 @@ static inline struct gpio_desc *gpio_to_desc(unsigned gpio)
 {
 	return ERR_PTR(-EINVAL);
 }
+
+static inline struct gpio_desc *gpio_name_to_desc(const char *name)
+{
+	return ERR_PTR(-EINVAL);
+}
+
 static inline int desc_to_gpio(const struct gpio_desc *desc)
 {
 	/* GPIO can never have been requested */
-- 
2.1.4
