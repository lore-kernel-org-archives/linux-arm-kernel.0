From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 12 Feb 2015 10:03:29 +0100
Subject: [PATCH] RFC: let gpiod_get_optional et all return NULL when GPIOLIB
 is not enabled
Message-ID: <1423731809-4800-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If you look for example at sound/soc/codecs/adau1977.c it has:

	adau1977->reset_gpio = devm_gpiod_get(dev, "reset");
	if (IS_ERR(adau1977->reset_gpio)) {
		ret = PTR_ERR(adau1977->reset_gpio);
		if (ret != -ENOENT && ret != -ENOSYS)
			return PTR_ERR(adau1977->reset_gpio);
		adau1977->reset_gpio = NULL;
	}

This code could better make use of devm_gpiod_get_optional like:

	adau1977->reset_gpio = devm_gpiod_get_optional(dev, "reset",
						       GPIOD_OUT_LOW);
	if (IS_ERR(adau1977->reset_gpio))
		return PTR_ERR(adau1977->reset_gpio);

but this slightly changes semantics. I.e. if GPIOLIB is not enabled
devm_gpiod_get_optional unconditionally returns -ENOSYS which is ignored
explicitly above but an error in the changed code.

I wonder if gpiod_get_optional et all should be changed to return NULL
instead. The obvious downside is that if the device tree specifies a
reset-gpio and the kernel just fails to use it because there is some
code missing, this should better be an error. (The adau1977 code has
this problem already know, but when changing devm_gpiod_get_optional all
callers are affected.)

What do you think?
---
 include/linux/gpio/consumer.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index fd85cb120ee0..f68244ffd3a9 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -132,14 +132,14 @@ static inline struct gpio_desc *__must_check
 __gpiod_get_optional(struct device *dev, const char *con_id,
 		     enum gpiod_flags flags)
 {
-	return ERR_PTR(-ENOSYS);
+	return NULL;
 }
 
 static inline struct gpio_desc *__must_check
 __gpiod_get_index_optional(struct device *dev, const char *con_id,
 			   unsigned int index, enum gpiod_flags flags)
 {
-	return ERR_PTR(-ENOSYS);
+	return NULL;
 }
 
 static inline void gpiod_put(struct gpio_desc *desc)
@@ -171,14 +171,14 @@ static inline struct gpio_desc *__must_check
 __devm_gpiod_get_optional(struct device *dev, const char *con_id,
 			  enum gpiod_flags flags)
 {
-	return ERR_PTR(-ENOSYS);
+	return NULL;
 }
 
 static inline struct gpio_desc *__must_check
 __devm_gpiod_get_index_optional(struct device *dev, const char *con_id,
 				unsigned int index, enum gpiod_flags flags)
 {
-	return ERR_PTR(-ENOSYS);
+	return NULL;
 }
 
 static inline void devm_gpiod_put(struct device *dev, struct gpio_desc *desc)
-- 
2.1.4
