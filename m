From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:51 +0200
Subject: [RFC PATCH 09/16] Add DEVM_GPIO_NAMED()
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-10-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/gpio/devres.c         | 16 ++++++++++++++++
 include/linux/gpio/consumer.h | 11 +++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpio/devres.c b/drivers/gpio/devres.c
index 07ba82317ece..b1e7a51ff72d 100644
--- a/drivers/gpio/devres.c
+++ b/drivers/gpio/devres.c
@@ -390,3 +390,19 @@ void devm_gpio_free(struct device *dev, unsigned int gpio)
 		&gpio));
 }
 EXPORT_SYMBOL(devm_gpio_free);
+
+int devm_acquire_gpio_named(struct device *dev,
+			    const struct devm_resource *resource)
+{
+	struct gpio_desc *desc, **descp;
+
+	desc = devm_get_gpiod_from_child(dev, resource->name, dev->fwnode);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	descp = dev_get_drvdata(dev) + resource->offset;
+	*descp = desc;
+
+	return 0;
+}
+EXPORT_SYMBOL(devm_acquire_gpio_named);
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index adac255aee86..df868f7c4dc7 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 
 struct device;
+struct devm_resource;
 
 /**
  * Opaque descriptor for a GPIO. These are obtained using gpiod_get() and are
@@ -139,6 +140,16 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
 					    const char *con_id,
 					    struct fwnode_handle *child);
+
+int devm_acquire_gpio_named(struct device *dev,
+			    const struct devm_resource *resource);
+
+#define DEVM_GPIO_NAMED(_struct, _member, _name) {			\
+	.initfunc = devm_acquire_gpio_named,				\
+	.offset = offsetof_t(struct _struct, _member, struct gpio_desc *),\
+	.name = _name,							\
+}
+
 #else /* CONFIG_GPIOLIB */
 
 static inline int gpiod_count(struct device *dev, const char *con_id)
-- 
2.4.3
