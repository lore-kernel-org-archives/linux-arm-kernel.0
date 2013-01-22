From: stigge@antcom.de (Roland Stigge)
Date: Tue, 22 Jan 2013 13:06:42 +0100
Subject: [PATCH 4/6 v14] gpiolib: Fix default attributes for class
In-Reply-To: <1358856404-8975-1-git-send-email-stigge@antcom.de>
References: <1358856404-8975-1-git-send-email-stigge@antcom.de>
Message-ID: <1358856404-8975-5-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a race condition between creating a gpio or gpiochip device and adding
default attributes. This patch fixes this by defining the default attributes as
dev_attrs of the class. For this, it was necessary to create a separate
gpiochip_class besides gpio_class.

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 Documentation/ABI/testing/sysfs-gpio |   11 ++++
 drivers/gpio/gpiolib.c               |   78 ++++++++++++++---------------------
 2 files changed, 44 insertions(+), 45 deletions(-)

--- linux-2.6.orig/Documentation/ABI/testing/sysfs-gpio
+++ linux-2.6/Documentation/ABI/testing/sysfs-gpio
@@ -20,6 +20,17 @@ Description:
 	    /value ... always readable, writes fail for input GPIOs
 	    /direction ... r/w as: in, out (default low); write: high, low
 	    /edge ... r/w as: none, falling, rising, both
+
+What:		/sys/class/gpiochip/
+Date:		October 2012
+KernelVersion:	3.7
+Contact:	Roland Stigge <stigge@antcom.de>
+Description:
+
+  Each gpiochip is represented by a separate device having the following
+  attributes:
+
+    /sys/class/gpiochip
 	/gpiochipN ... for each gpiochip; #N is its first GPIO
 	    /base ... (r/o) same as N
 	    /label ... (r/o) descriptive, not necessarily unique
--- linux-2.6.orig/drivers/gpio/gpiolib.c
+++ linux-2.6/drivers/gpio/gpiolib.c
@@ -362,9 +362,6 @@ static ssize_t gpio_value_store(struct d
 	return status;
 }
 
-static const DEVICE_ATTR(value, 0644,
-		gpio_value_show, gpio_value_store);
-
 static irqreturn_t gpio_sysfs_irq(int irq, void *priv)
 {
 	struct sysfs_dirent	*value_sd = priv;
@@ -585,19 +582,6 @@ static ssize_t gpio_active_low_store(str
 	return status ? : size;
 }
 
-static const DEVICE_ATTR(active_low, 0644,
-		gpio_active_low_show, gpio_active_low_store);
-
-static const struct attribute *gpio_attrs[] = {
-	&dev_attr_value.attr,
-	&dev_attr_active_low.attr,
-	NULL,
-};
-
-static const struct attribute_group gpio_attr_group = {
-	.attrs = (struct attribute **) gpio_attrs,
-};
-
 /*
  * /sys/class/gpio/gpiochipN/
  *   /base ... matching gpio_chip.base (N)
@@ -612,7 +596,6 @@ static ssize_t chip_base_show(struct dev
 
 	return sprintf(buf, "%d\n", chip->base);
 }
-static DEVICE_ATTR(base, 0444, chip_base_show, NULL);
 
 static ssize_t chip_label_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -621,7 +604,6 @@ static ssize_t chip_label_show(struct de
 
 	return sprintf(buf, "%s\n", chip->label ? : "");
 }
-static DEVICE_ATTR(label, 0444, chip_label_show, NULL);
 
 static ssize_t chip_ngpio_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
@@ -630,18 +612,6 @@ static ssize_t chip_ngpio_show(struct de
 
 	return sprintf(buf, "%u\n", chip->ngpio);
 }
-static DEVICE_ATTR(ngpio, 0444, chip_ngpio_show, NULL);
-
-static const struct attribute *gpiochip_attrs[] = {
-	&dev_attr_base.attr,
-	&dev_attr_label.attr,
-	&dev_attr_ngpio.attr,
-	NULL,
-};
-
-static const struct attribute_group gpiochip_attr_group = {
-	.attrs = (struct attribute **) gpiochip_attrs,
-};
 
 /*
  * /sys/class/gpio/export ... write-only
@@ -720,11 +690,32 @@ static struct class_attribute gpio_class
 	__ATTR_NULL,
 };
 
+static struct device_attribute gpio_attrs[] = {
+	__ATTR(active_low, 0644, gpio_active_low_show, gpio_active_low_store),
+	__ATTR(value, 0644, gpio_value_show, gpio_value_store),
+	__ATTR_NULL,
+};
+
 static struct class gpio_class = {
 	.name =		"gpio",
 	.owner =	THIS_MODULE,
 
-	.class_attrs =	gpio_class_attrs,
+	.class_attrs = gpio_class_attrs,
+	.dev_attrs = gpio_attrs,
+};
+
+static struct device_attribute gpiochip_attrs[] = {
+	__ATTR(label, 0444, chip_label_show, NULL),
+	__ATTR(base, 0444, chip_base_show, NULL),
+	__ATTR(ngpio, 0444, chip_ngpio_show, NULL),
+	__ATTR_NULL,
+};
+
+static struct class gpiochip_class = {
+	.name =		"gpiochip",
+	.owner =	THIS_MODULE,
+
+	.dev_attrs =	gpiochip_attrs,
 };
 
 
@@ -791,10 +782,6 @@ int gpio_export(unsigned gpio, bool dire
 		goto fail_unlock;
 	}
 
-	status = sysfs_create_group(&dev->kobj, &gpio_attr_group);
-	if (status)
-		goto fail_unregister_device;
-
 	if (direction_may_change) {
 		status = device_create_file(dev, &dev_attr_direction);
 		if (status)
@@ -962,25 +949,22 @@ EXPORT_SYMBOL_GPL(gpio_unexport);
 
 static int gpiochip_export(struct gpio_chip *chip)
 {
-	int		status;
+	int		status = 0;
 	struct device	*dev;
 
 	/* Many systems register gpio chips for SOC support very early,
 	 * before driver model support is available.  In those cases we
 	 * export this later, in gpiolib_sysfs_init() ... here we just
-	 * verify that _some_ field of gpio_class got initialized.
+	 * verify that _some_ field of gpiochip_class got initialized.
 	 */
-	if (!gpio_class.p)
+	if (!gpiochip_class.p)
 		return 0;
 
 	/* use chip->base for the ID; it's already known to be unique */
 	mutex_lock(&sysfs_lock);
-	dev = device_create(&gpio_class, chip->dev, MKDEV(0, 0), chip,
-				"gpiochip%d", chip->base);
-	if (!IS_ERR(dev)) {
-		status = sysfs_create_group(&dev->kobj,
-				&gpiochip_attr_group);
-	} else
+	dev = device_create(&gpiochip_class, chip->dev, MKDEV(0, 0), chip,
+			    "gpiochip%d", chip->base);
+	if (IS_ERR(dev))
 		status = PTR_ERR(dev);
 	chip->exported = (status == 0);
 	mutex_unlock(&sysfs_lock);
@@ -1008,7 +992,7 @@ static void gpiochip_unexport(struct gpi
 	struct device		*dev;
 
 	mutex_lock(&sysfs_lock);
-	dev = class_find_device(&gpio_class, NULL, chip, match_export);
+	dev = class_find_device(&gpiochip_class, NULL, chip, match_export);
 	if (dev) {
 		put_device(dev);
 		device_unregister(dev);
@@ -1267,6 +1251,10 @@ static int __init gpiolib_sysfs_init(voi
 	if (status < 0)
 		return status;
 
+	status = class_register(&gpiochip_class);
+	if (status < 0)
+		return status;
+
 	status = class_register(&gpio_block_class);
 	if (status < 0)
 		return status;
