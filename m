From: himangi774@gmail.com (Himangi Saraogi)
Date: Sun, 6 Jul 2014 23:17:46 +0530
Subject: [PATCH 1/5] gpiolib: devres: Introduce the function
 devm_request_gpio_array
In-Reply-To: <cover.1404665589.git.himangi774@gmail.com>
References: <cover.1404665589.git.himangi774@gmail.com>
Message-ID: <1a1752ce7455bac8f2505a9790da891a830699f5.1404665589.git.himangi774@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces the function devm_request_gpio_array that
allocates multiple GPIOs in a single call in a managed manner. The
function is also included in the documentation and a declaration is
added in include/linux/gpio.h.

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
---
 Documentation/driver-model/devres.txt |  1 +
 drivers/gpio/devres.c                 | 21 +++++++++++++++++++++
 include/linux/gpio.h                  |  2 ++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 9e2098e..756f6cf 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -337,6 +337,7 @@ GPIO
   devm_gpiod_put()
   devm_gpio_request()
   devm_gpio_request_one()
+  devm_gpio_request_array()
   devm_gpio_free()
 
 SND
diff --git a/drivers/gpio/devres.c b/drivers/gpio/devres.c
index 65978cf..adae7fa 100644
--- a/drivers/gpio/devres.c
+++ b/drivers/gpio/devres.c
@@ -229,6 +229,27 @@ int devm_gpio_request_one(struct device *dev, unsigned gpio,
 EXPORT_SYMBOL(devm_gpio_request_one);
 
 /**
+ *	devm_gpio_request_array - request multiple GPIOs in a single call
+ *	@dev:   device to request for
+ *	@array:	array of the 'struct gpio'
+ *	@num:	how many GPIOs in the array
+ */
+int devm_gpio_request_array(struct device *dev, const struct gpio *array,
+			    size_t num)
+{
+	int i, err;
+
+	for (i = 0; i < num; i++, array++) {
+		err = devm_gpio_request_one(dev, array->gpio, array->flags,
+					    array->label);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_gpio_request_array);
+
+/**
  *      devm_gpio_free - free a GPIO
  *      @dev: device to free GPIO for
  *      @gpio: GPIO to free
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 85aa5d0..c85f243 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -84,6 +84,8 @@ struct device;
 int devm_gpio_request(struct device *dev, unsigned gpio, const char *label);
 int devm_gpio_request_one(struct device *dev, unsigned gpio,
 			  unsigned long flags, const char *label);
+int devm_gpio_request_array(struct device *dev, const struct gpio *array,
+			    size_t num);
 void devm_gpio_free(struct device *dev, unsigned int gpio);
 
 #else /* ! CONFIG_GPIOLIB */
-- 
1.9.1
