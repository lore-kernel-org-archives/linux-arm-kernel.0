From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 14 Dec 2017 15:21:33 +0100
Subject: [RFC PATCH 2/7] gpio: gpiolib: split the gpiod_configure_flags
 function
In-Reply-To: <20171214142138.23008-1-ludovic.desroches@microchip.com>
References: <20171214142138.23008-1-ludovic.desroches@microchip.com>
Message-ID: <20171214142138.23008-3-ludovic.desroches@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpiod_configure_flags function doesn't only configure flags, it
also performs some processing. It implies that it should be called
after having requested the GPIO. Split configuration and processing
to allow flags configuration before requesting the GPIO. It is
needed if we want to set the pin configuration.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/gpio/gpiolib.c | 49 +++++++++++++++++++++++++++++++------------------
 drivers/gpio/gpiolib.h |  7 ++++++-
 2 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0621baddfddc..c887602ca0ff 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3564,23 +3564,9 @@ struct gpio_desc *__must_check gpiod_get_optional(struct device *dev,
 EXPORT_SYMBOL_GPL(gpiod_get_optional);
 
 
-/**
- * gpiod_configure_flags - helper function to configure a given GPIO
- * @desc:	gpio whose value will be assigned
- * @con_id:	function within the GPIO consumer
- * @lflags:	gpio_lookup_flags - returned from of_find_gpio() or
- *		of_get_gpio_hog()
- * @dflags:	gpiod_flags - optional GPIO initialization flags
- *
- * Return 0 on success, -ENOENT if no GPIO has been assigned to the
- * requested function and/or index, or another IS_ERR() code if an error
- * occurred while trying to acquire the GPIO.
- */
-int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
+void gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 		unsigned long lflags, enum gpiod_flags dflags)
 {
-	int status;
-
 	if (lflags & GPIO_ACTIVE_LOW)
 		set_bit(FLAG_ACTIVE_LOW, &desc->flags);
 
@@ -3601,6 +3587,11 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 	if (lflags & GPIO_OPEN_SOURCE)
 		set_bit(FLAG_OPEN_SOURCE, &desc->flags);
 
+int gpiod_process_flags(struct gpio_desc *desc, const char *con_id,
+		unsigned long lflags, enum gpiod_flags dflags)
+{
+	int status;
+
 	status = gpiod_set_transitory(desc, (lflags & GPIO_TRANSITORY));
 	if (status < 0)
 		return status;
@@ -3622,6 +3613,28 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 }
 
 /**
+ * gpiod_configure_and_process_flags - helper function to configure a
+ *				       given GPIO
+ * @desc:	gpio whose value will be assigned
+ * @con_id:	function within the GPIO consumer
+ * @lflags:	gpio_lookup_flags - returned from of_find_gpio() or
+ *		of_get_gpio_hog()
+ * @dflags:	gpiod_flags - optional GPIO initialization flags
+ *
+ * Return 0 on success, -ENOENT if no GPIO has been assigned to the
+ * requested function and/or index, or another IS_ERR() code if an error
+ * occurred while trying to acquire the GPIO.
+ */
+int gpiod_configure_and_process_flags(struct gpio_desc *desc,
+				      const char *con_id,
+				      unsigned long lflags,
+				      enum gpiod_flags dflags)
+{
+	gpiod_configure_flags(desc, con_id, lflags, dflags);
+	return gpiod_process_flags(desc, con_id, lflags, dflags);
+}
+
+/**
  * gpiod_get_index - obtain a GPIO from a multi-index GPIO function
  * @dev:	GPIO consumer, can be NULL for system-global GPIOs
  * @con_id:	function within the GPIO consumer
@@ -3675,7 +3688,7 @@ struct gpio_desc *__must_check gpiod_get_index(struct device *dev,
 	if (status < 0)
 		return ERR_PTR(status);
 
-	status = gpiod_configure_flags(desc, con_id, lookupflags, flags);
+	status = gpiod_configure_and_process_flags(desc, con_id, lookupflags, flags);
 	if (status < 0) {
 		dev_dbg(dev, "setup of GPIO %s failed\n", con_id);
 		gpiod_put(desc);
@@ -3764,7 +3777,7 @@ struct gpio_desc *fwnode_get_named_gpiod(struct fwnode_handle *fwnode,
 	if (transitory)
 		lflags |= GPIO_TRANSITORY;
 
-	ret = gpiod_configure_flags(desc, propname, lflags, dflags);
+	ret = gpiod_configure_and_process_flags(desc, propname, lflags, dflags);
 	if (ret < 0) {
 		gpiod_put(desc);
 		return ERR_PTR(ret);
@@ -3830,7 +3843,7 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
 		return status;
 	}
 
-	status = gpiod_configure_flags(desc, name, lflags, dflags);
+	status = gpiod_configure_and_process_flags(desc, name, lflags, dflags);
 	if (status < 0) {
 		pr_err("setup of hog GPIO %s (chip %s, offset %d) failed, %d\n",
 		       name, chip->label, hwnum, status);
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 5e1f7cc6eeb6..a03553d4be1c 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -219,8 +219,13 @@ struct gpio_desc {
 
 int gpiod_request(struct gpio_desc *desc, const char *label);
 void gpiod_free(struct gpio_desc *desc);
-int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
+void gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
 		unsigned long lflags, enum gpiod_flags dflags);
+int gpiod_process_flags(struct gpio_desc *desc, const char *con_id,
+		unsigned long lflags, enum gpiod_flags dflags);
+int gpiod_configure_and_process_flags(struct gpio_desc *desc,
+		const char *con_id, unsigned long lflags,
+		enum gpiod_flags dflags);
 int gpiod_hog(struct gpio_desc *desc, const char *name,
 		unsigned long lflags, enum gpiod_flags dflags);
 
-- 
2.12.2
