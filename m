From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Apr 2015 23:06:53 +0200
Subject: [PATCH] leds: fix !CONFIG_LEDS_TRIGGERS builds
Message-ID: <32374082.15Rv66z5Mo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent move of the header led trigger function declaration caused the
alternative wrappers to be entirely invisible if LEDS_TRIGGERS is
disabled, leading to a compile-time error:

drivers/leds/led-class.c: In function 'brightness_store':
drivers/leds/led-class.c:57:3: error: implicit declaration of function 'led_trigger_remove' [-Werror=implicit-function-declaration]

This moves the wrappers to an appropriate location and changes the
macros to inline functions to match the style of the surrounding code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 5a15d172057c ("leds: unify the location of led-trigger API")
---
This showed up in today's linux-next

diff --git a/include/linux/leds.h b/include/linux/leds.h
index 057970818961..e049cb374837 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -223,7 +223,6 @@ struct led_trigger {
 	struct list_head  next_trig;
 };
 
-#ifdef CONFIG_LEDS_TRIGGERS
 void led_trigger_set_default(struct led_classdev *led_cdev);
 void led_trigger_set(struct led_classdev *led_cdev,
 			struct led_trigger *trigger);
@@ -234,13 +233,6 @@ static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
 	return led_cdev->trigger_data;
 }
 
-#else
-#define led_trigger_set_default(x) do {} while (0)
-#define led_trigger_set(x, y) do {} while (0)
-#define led_trigger_remove(x) do {} while (0)
-#define led_get_trigger_data(x) (NULL)
-#endif
-
 ssize_t led_trigger_store(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count);
 ssize_t led_trigger_show(struct device *dev, struct device_attribute *attr,
@@ -286,6 +278,14 @@ extern void led_trigger_rename_static(const char *name,
 struct led_trigger {};
 
 /* Trigger inline empty functions */
+static inline void led_trigger_set_default(struct led_classdev *led_cdev) {}
+static inline void led_trigger_set(struct led_classdev *led_cdev,
+				   struct led_trigger *trigger) {}
+static inline void led_trigger_remove(struct led_classdev *led_cdev) {}
+static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
+{
+	return NULL;
+}
 static inline void led_trigger_register_simple(const char *name,
 					struct led_trigger **trigger) {}
 static inline void led_trigger_unregister_simple(struct led_trigger *trigger) {}
