From: peda@lysator.liu.se (Peter Rosin)
Date: Fri, 27 Nov 2015 22:36:12 +0100
Subject: [RFC PATCH 1/2] gpio: Add isr property of gpio pins
In-Reply-To: <1448660173-29214-1-git-send-email-peda@lysator.liu.se>
References: <1448660173-29214-1-git-send-email-peda@lysator.liu.se>
Message-ID: <1448660173-29214-2-git-send-email-peda@lysator.liu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Rosin <peda@axentia.se>

Adds the possibility to read the interrupt status register bit for the
gpio pin. Expose the bit as an isr file in sysfs.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/gpio/sysfs.txt  |   12 ++++++++++++
 drivers/gpio/gpiolib-sysfs.c  |   30 ++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.c        |   15 +++++++++++++++
 include/linux/gpio/consumer.h |    1 +
 include/linux/gpio/driver.h   |    2 ++
 5 files changed, 60 insertions(+)

diff --git a/Documentation/gpio/sysfs.txt b/Documentation/gpio/sysfs.txt
index 535b6a8a7a7c..ded7ef9d01be 100644
--- a/Documentation/gpio/sysfs.txt
+++ b/Documentation/gpio/sysfs.txt
@@ -97,6 +97,18 @@ and have the following read/write attributes:
 		for "rising" and "falling" edges will follow this
 		setting.
 
+	"isr" ... reads as either 0 (false) or 1 (true). Reading the
+		file will clear the value, so that reading a 1 means
+		that there has been an interrupt-triggering action
+		on the pin since the file was last read.
+
+		This file exists only if the gpio chip supports reading
+		the interrupt status register bit for the pin.
+
+		Note that if reading the isr register for this pin
+		interferes with active interrupts, the read will fail
+		with an error.
+
 GPIO controllers have paths like /sys/class/gpio/gpiochip42/ (for the
 controller implementing GPIOs starting at #42) and have the following
 read-only attributes:
diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index b57ed8e55ab5..f6fe68fab191 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -139,6 +139,28 @@ static ssize_t value_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(value);
 
+static ssize_t isr_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gpiod_data	*data = dev_get_drvdata(dev);
+	struct gpio_desc	*desc = data->desc;
+	ssize_t			status;
+	int			isr;
+
+	mutex_lock(&data->mutex);
+
+	isr = gpiod_get_isr_cansleep(desc);
+	if (isr < 0)
+		status = isr;
+	else
+		status = sprintf(buf, "%d\n", isr);
+
+	mutex_unlock(&data->mutex);
+
+	return status;
+}
+static DEVICE_ATTR_RO(isr);
+
 static irqreturn_t gpio_sysfs_irq(int irq, void *priv)
 {
 	struct gpiod_data *data = priv;
@@ -367,6 +389,13 @@ static umode_t gpio_is_visible(struct kobject *kobj, struct attribute *attr,
 			mode = 0;
 		if (!show_direction && test_bit(FLAG_IS_OUT, &desc->flags))
 			mode = 0;
+	} else if (attr == &dev_attr_isr.attr) {
+		if (!desc->chip->get_isr)
+			mode = 0;
+		if (gpiod_to_irq(desc) < 0)
+			mode = 0;
+		if (!show_direction && test_bit(FLAG_IS_OUT, &desc->flags))
+			mode = 0;
 	}
 
 	return mode;
@@ -377,6 +406,7 @@ static struct attribute *gpio_attrs[] = {
 	&dev_attr_edge.attr,
 	&dev_attr_value.attr,
 	&dev_attr_active_low.attr,
+	&dev_attr_isr.attr,
 	NULL,
 };
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index bf4bd1d120c3..b45e70b2713e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1572,6 +1572,21 @@ int gpiod_get_value_cansleep(const struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_get_value_cansleep);
 
+int gpiod_get_isr_cansleep(const struct gpio_desc *desc)
+{
+	struct gpio_chip *chip;
+	int offset;
+
+	might_sleep_if(extra_checks);
+	if (!desc)
+		return -EINVAL;
+
+	chip = desc->chip;
+	offset = gpio_chip_hwgpio(desc);
+	return chip->get_isr ? chip->get_isr(chip, offset) : -ENXIO;
+}
+EXPORT_SYMBOL_GPL(gpiod_get_isr_cansleep);
+
 /**
  * gpiod_set_raw_value_cansleep() - assign a gpio's raw value
  * @desc: gpio whose value will be assigned
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index adac255aee86..d0290c14dc84 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -119,6 +119,7 @@ void gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value);
 void gpiod_set_raw_array_value_cansleep(unsigned int array_size,
 					struct gpio_desc **desc_array,
 					int *value_array);
+int gpiod_get_isr_cansleep(const struct gpio_desc *desc);
 
 int gpiod_set_debounce(struct gpio_desc *desc, unsigned debounce);
 
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index c8393cd4d44f..dccfb12f9112 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -96,6 +96,8 @@ struct gpio_chip {
 						unsigned offset);
 	void			(*set)(struct gpio_chip *chip,
 						unsigned offset, int value);
+	int			(*get_isr)(struct gpio_chip *chip,
+						unsigned offset);
 	void			(*set_multiple)(struct gpio_chip *chip,
 						unsigned long *mask,
 						unsigned long *bits);
-- 
1.7.10.4
