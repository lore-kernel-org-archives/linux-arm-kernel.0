From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 14 Aug 2015 16:11:03 +0200
Subject: [PATCH v3 6/9] gpiolib-sysfs: Show gpio-name in
 /sys/class/gpio/gpio*/name
In-Reply-To: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
References: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1439561466-14350-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a sysfs attribute 'name' to gpios that were exported. It
exposes the newly added name property of gpio descriptors.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/gpio/gpiolib-sysfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 3e81f28e3aee..2022cfb00aeb 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -139,6 +139,17 @@ static ssize_t value_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(value);
 
+static ssize_t name_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct gpiod_data *data = dev_get_drvdata(dev);
+	struct gpio_desc *desc = data->desc;
+
+	return sprintf(buf, "%s\n", desc->name ? : "");
+}
+
+static DEVICE_ATTR_RO(name);
+
 static irqreturn_t gpio_sysfs_irq(int irq, void *priv)
 {
 	struct gpiod_data *data = priv;
@@ -377,6 +388,7 @@ static struct attribute *gpio_attrs[] = {
 	&dev_attr_edge.attr,
 	&dev_attr_value.attr,
 	&dev_attr_active_low.attr,
+	&dev_attr_name.attr,
 	NULL,
 };
 
-- 
2.4.6
