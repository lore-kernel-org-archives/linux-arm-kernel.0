From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 24 Apr 2018 19:30:49 +0200
Subject: [PATCH 09/11] platform: provide early_platform_driver()
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
Message-ID: <20180424173051.15099-10-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Implement a macro similar to module_platform_driver() which allows to
register early platform drivers with the default early class.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/platform_device.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 514ada776004..b565a1237fa6 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -297,6 +297,8 @@ struct early_platform_driver {
 #define EARLY_PLATFORM_ID_UNSET -2
 #define EARLY_PLATFORM_ID_ERROR -3
 
+#define EARLY_PLATFORM_DEFAULT_CLASS	"earlydev"
+
 #ifdef CONFIG_EARLY_PLATFORM_DEVICES
 
 extern int early_platform_driver_register(struct early_platform_driver *epdrv,
@@ -352,6 +354,9 @@ static inline char *early_platform_driver_setup_func(void)		\
 }
 #endif /* MODULE */
 
+#define early_platform_driver(__platdrv)				\
+	early_platform_init(EARLY_PLATFORM_DEFAULT_CLASS, &(__platdrv))
+
 #else /* CONFIG_EARLY_PLATFORM_DEVICES */
 static inline int
 early_platform_driver_register(struct early_platform_driver *epdrv, char *buf)
@@ -380,6 +385,7 @@ static inline int early_platform_driver_register_probe_all(char *class_str,
 static inline void early_platform_cleanup(void) {}
 #define early_platform_init(class_string, platdrv)
 #define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)
+#define early_platform_driver(__platdrv)
 #endif /* CONFIG_EARLY_PLATFORM_DEVICES */
 
 #ifdef CONFIG_SUSPEND
-- 
2.17.0
