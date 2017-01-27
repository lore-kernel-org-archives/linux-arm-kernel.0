From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 27 Jan 2017 17:34:02 +0100
Subject: [PATCH 1/5] gpio: Add the devm_get_index_gpiod_from_child() helper
In-Reply-To: <1485534846-28111-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1485534846-28111-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1485534846-28111-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_get_gpiod_from_child() currently allows GPIO users to request a GPIO
that is defined in a child fwnode instead of directly in the device
fwnode. Extend this API by adding the devm_get_index_gpiod_from_child()
helpers which does the same except you can also specify an index in case
the 'xx-gpios' property describe several GPIOs.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
I've added a new function instead of modifying the existing
devm_get_gpiod_from_child() helper to avoid patching all users of this
function.
Note that fwnode_get_named_gpiod() has been modified because there's no
external users.
---
 drivers/gpio/devres.c         | 30 +++++++++++++++++++++++++-----
 drivers/gpio/gpiolib.c        |  9 +++++----
 include/linux/gpio/consumer.h | 15 +++++++++++++--
 3 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/devres.c b/drivers/gpio/devres.c
index b760cbbb41d8..4dbab629a05e 100644
--- a/drivers/gpio/devres.c
+++ b/drivers/gpio/devres.c
@@ -123,17 +123,20 @@ struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
 EXPORT_SYMBOL(devm_gpiod_get_index);
 
 /**
- * devm_get_gpiod_from_child - get a GPIO descriptor from a device's child node
+ * devm_get_index_gpiod_from_child - get a GPIO descriptor from a device's
+ *				     child node
  * @dev:	GPIO consumer
  * @con_id:	function within the GPIO consumer
+ * @index:	index of the GPIO to obtain in the consumer
  * @child:	firmware node (child of @dev)
  *
  * GPIO descriptors returned from this function are automatically disposed on
  * driver detach.
  */
-struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
-					    const char *con_id,
-					    struct fwnode_handle *child)
+struct gpio_desc *devm_get_index_gpiod_from_child(struct device *dev,
+						  const char *con_id,
+						  int index,
+						  struct fwnode_handle *child)
 {
 	static const char * const suffixes[] = { "gpios", "gpio" };
 	char prop_name[32]; /* 32 is max size of property name */
@@ -154,7 +157,7 @@ struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
 			snprintf(prop_name, sizeof(prop_name), "%s",
 							       suffixes[i]);
 
-		desc = fwnode_get_named_gpiod(child, prop_name);
+		desc = fwnode_get_named_gpiod(child, prop_name, index);
 		if (!IS_ERR(desc) || (PTR_ERR(desc) != -ENOENT))
 			break;
 	}
@@ -168,6 +171,23 @@ struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
 
 	return desc;
 }
+EXPORT_SYMBOL(devm_get_index_gpiod_from_child);
+
+/**
+ * devm_get_gpiod_from_child - get a GPIO descriptor from a device's child node
+ * @dev:	GPIO consumer
+ * @con_id:	function within the GPIO consumer
+ * @child:	firmware node (child of @dev)
+ *
+ * GPIO descriptors returned from this function are automatically disposed on
+ * driver detach.
+ */
+struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
+					    const char *con_id,
+					    struct fwnode_handle *child)
+{
+	return devm_get_index_gpiod_from_child(dev, con_id, 0, child);
+}
 EXPORT_SYMBOL(devm_get_gpiod_from_child);
 
 /**
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 86bf3b84ada5..9b7a7734e742 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3309,6 +3309,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_index);
  * fwnode_get_named_gpiod - obtain a GPIO from firmware node
  * @fwnode:	handle of the firmware node
  * @propname:	name of the firmware property representing the GPIO
+ * @index:	index of the GPIO to obtain in the consumer
  *
  * This function can be used for drivers that get their configuration
  * from firmware.
@@ -3320,7 +3321,7 @@ EXPORT_SYMBOL_GPL(gpiod_get_index);
  * In case of error an ERR_PTR() is returned.
  */
 struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
-					 const char *propname)
+					 const char *propname, int index)
 {
 	struct gpio_desc *desc = ERR_PTR(-ENODEV);
 	bool active_low = false;
@@ -3333,8 +3334,8 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 	if (is_of_node(fwnode)) {
 		enum of_gpio_flags flags;
 
-		desc = of_get_named_gpiod_flags(to_of_node(fwnode), propname, 0,
-						&flags);
+		desc = of_get_named_gpiod_flags(to_of_node(fwnode), propname,
+						index, &flags);
 		if (!IS_ERR(desc)) {
 			active_low = flags & OF_GPIO_ACTIVE_LOW;
 			single_ended = flags & OF_GPIO_SINGLE_ENDED;
@@ -3342,7 +3343,7 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 	} else if (is_acpi_node(fwnode)) {
 		struct acpi_gpio_info info;
 
-		desc = acpi_node_get_gpiod(fwnode, propname, 0, &info);
+		desc = acpi_node_get_gpiod(fwnode, propname, index, &info);
 		if (!IS_ERR(desc))
 			active_low = info.polarity == GPIO_ACTIVE_LOW;
 	}
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index fb0fde686cb1..5b3c025333a6 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -135,7 +135,11 @@ int desc_to_gpio(const struct gpio_desc *desc);
 struct fwnode_handle;
 
 struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
-					 const char *propname);
+					 const char *propname, int index);
+struct gpio_desc *devm_get_index_gpiod_from_child(struct device *dev,
+						  const char *con_id,
+						  int index,
+						  struct fwnode_handle *child);
 struct gpio_desc *devm_get_gpiod_from_child(struct device *dev,
 					    const char *con_id,
 					    struct fwnode_handle *child);
@@ -412,7 +416,14 @@ static inline int desc_to_gpio(const struct gpio_desc *desc)
 struct fwnode_handle;
 
 static inline struct gpio_desc *fwnode_get_named_gpiod(
-	struct fwnode_handle *fwnode, const char *propname)
+	struct fwnode_handle *fwnode, const char *propname, int index)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+static inline struct gpio_desc *devm_get_index_gpiod_from_child(
+	struct device *dev, const char *con_id, int index,
+	struct fwnode_handle *child)
 {
 	return ERR_PTR(-ENOSYS);
 }
-- 
2.7.4
