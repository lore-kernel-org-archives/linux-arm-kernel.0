From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 10 Dec 2014 16:48:24 +0100
Subject: [RFC 06/15] gpio: add restrack support
In-Reply-To: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1418226513-14105-7-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO supports different methods of lookup.
The patch adds restrack support only to DT based GPIOs.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpio/gpiolib.c        | 81 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/gpio/consumer.h |  4 +++
 include/linux/restrack.h      |  1 +
 3 files changed, 86 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 78fcec9..5d85e20 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -15,6 +15,7 @@
 #include <linux/acpi.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
+#include <linux/restrack.h>
 
 #include "gpiolib.h"
 
@@ -278,6 +279,8 @@ int gpiochip_add(struct gpio_chip *chip)
 	if (status)
 		goto fail;
 
+	restrack_up(RESTRACK_TYPE_GPIO, chip->of_node, chip);
+
 	status = gpiochip_export(chip);
 	if (status)
 		goto fail;
@@ -313,6 +316,7 @@ void gpiochip_remove(struct gpio_chip *chip)
 	unsigned long	flags;
 	unsigned	id;
 
+	restrack_down(RESTRACK_TYPE_GPIO, chip->of_node, chip);
 	acpi_gpiochip_remove(chip);
 
 	spin_lock_irqsave(&gpio_lock, flags);
@@ -1770,6 +1774,83 @@ void gpiod_put(struct gpio_desc *desc)
 }
 EXPORT_SYMBOL_GPL(gpiod_put);
 
+struct gpiod_restrack_desc {
+	struct gpio_desc **ptr;
+	const char *name;
+	enum gpiod_flags flags;
+	struct of_phandle_args spec;
+	struct restrack_desc desc;
+};
+
+static int gpiod_restrack_init(struct device *dev, struct restrack_desc *desc)
+{
+	struct gpiod_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+	int ret;
+
+	ret = of_get_gpiod_spec(dev, rd->name, 0, &rd->spec);
+	if (!ret)
+		desc->if_id = rd->spec.np;
+	return ret;
+}
+
+static void gpiod_restrack_destroy(struct device *dev,
+		struct restrack_desc *desc)
+{
+	struct gpiod_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+
+	of_node_put(desc->if_id);
+	kfree(rd);
+}
+
+static int gpiod_restrack_ifup(struct device *dev, struct restrack_desc *desc,
+		void *data)
+{
+	struct gpiod_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+
+	*rd->ptr = gpiod_get(dev, rd->name, rd->flags);
+	return PTR_ERR_OR_ZERO(*rd->ptr);
+}
+
+static void gpiod_restrack_ifdown(struct device *dev,
+		struct restrack_desc *desc, void *data)
+{
+	struct gpiod_restrack_desc *rd = restrack_desc_to_rd(rd, desc);
+
+	gpiod_put(*rd->ptr);
+	*rd->ptr = ERR_PTR(-EPROBE_DEFER);
+}
+
+static const struct restrack_ops gpiod_restrack_ops = {
+	.if_type = RESTRACK_TYPE_GPIO,
+	.init = gpiod_restrack_init,
+	.destroy = gpiod_restrack_destroy,
+	.if_up = gpiod_restrack_ifup,
+	.if_down = gpiod_restrack_ifdown,
+};
+
+/**
+ * gpiod_restrack_desc - gpio resource descriptor allocator
+ * @gpiod: pointer to variable which will be set to gpiod handle
+ * @name: name of gpio
+ * @flags: gpiod flags
+ *
+ * The function creates resource description for gpio, which shall be used
+ * by *restrack_register functions.
+ */
+struct restrack_desc *gpiod_restrack_desc(struct gpio_desc **gpiod,
+		const char *con_id, enum gpiod_flags flags)
+{
+	struct gpiod_restrack_desc *rd;
+
+	RESTRACK_DESC_ALLOC(rd, gpiod_restrack_ops, gpiod, con_id);
+	if (!rd)
+		return ERR_PTR(-ENOMEM);
+
+	rd->flags = flags;
+	return &rd->desc;
+}
+EXPORT_SYMBOL_GPL(gpiod_restrack_desc);
+
 #ifdef CONFIG_DEBUG_FS
 
 static void gpiolib_dbg_show(struct seq_file *s, struct gpio_chip *chip)
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 12f146f..55f2e4e 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -94,6 +94,10 @@ int gpiod_to_irq(const struct gpio_desc *desc);
 struct gpio_desc *gpio_to_desc(unsigned gpio);
 int desc_to_gpio(const struct gpio_desc *desc);
 
+struct restrack_desc;
+struct restrack_desc *gpiod_restrack_desc(struct gpio_desc **gpiod,
+		const char *con_id, enum gpiod_flags flags);
+
 #else /* CONFIG_GPIOLIB */
 
 static inline struct gpio_desc *__must_check __gpiod_get(struct device *dev,
diff --git a/include/linux/restrack.h b/include/linux/restrack.h
index 4e4eec6..e1aded0 100644
--- a/include/linux/restrack.h
+++ b/include/linux/restrack.h
@@ -5,6 +5,7 @@
 
 #define RESTRACK_TYPE_DRM_PANEL 1
 #define RESTRACK_TYPE_REGULATOR 2
+#define RESTRACK_TYPE_GPIO 3
 
 struct device;
 struct restrack_ctx;
-- 
1.9.1
