From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 24 Apr 2018 19:30:43 +0200
Subject: [PATCH 03/11] platform: make support for early platform devices
 conditional
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
References: <20180424173051.15099-1-brgl@bgdev.pl>
Message-ID: <20180424173051.15099-4-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to add support for device tree based early platform devices.

In order not to introduce additional bloat for all users when we extend
struct device to accomodate early platform DT support, let's make the
current machine code support conditional.

The only current user of the early platform infrastructure is SuperH so
make it select the appropriate Kconfig option.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/sh/Kconfig                 |  1 +
 drivers/base/Kconfig            |  4 ++++
 drivers/base/platform.c         |  3 +++
 include/linux/platform_device.h | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 97fe29316476..1b2c0b2ce402 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -50,6 +50,7 @@ config SUPERH
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
+	select EARLY_PLATFORM_DEVICES
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 29b0eb452b3a..37de5e1d6217 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -205,6 +205,10 @@ config DEBUG_TEST_DRIVER_REMOVE
 	  unusable. You should say N here unless you are explicitly looking to
 	  test this functionality.
 
+config EARLY_PLATFORM_DEVICES
+	bool
+	default n
+
 source "drivers/base/test/Kconfig"
 
 config SYS_HYPERVISOR
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8075ddc70a17..af440d703f0b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1186,6 +1186,8 @@ u64 dma_get_required_mask(struct device *dev)
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
 #endif
 
+#ifdef CONFIG_EARLY_PLATFORM_DEVICES
+
 static __initdata LIST_HEAD(early_platform_driver_list);
 static __initdata LIST_HEAD(early_platform_device_list);
 
@@ -1471,3 +1473,4 @@ void __init early_platform_cleanup(void)
 	}
 }
 
+#endif /* CONFIG_EARLY_PLATFORM_DEVICES */
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index a06b194ba30b..514ada776004 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -297,6 +297,8 @@ struct early_platform_driver {
 #define EARLY_PLATFORM_ID_UNSET -2
 #define EARLY_PLATFORM_ID_ERROR -3
 
+#ifdef CONFIG_EARLY_PLATFORM_DEVICES
+
 extern int early_platform_driver_register(struct early_platform_driver *epdrv,
 					  char *buf);
 extern void early_platform_add_devices(struct platform_device **devs, int num);
@@ -350,6 +352,36 @@ static inline char *early_platform_driver_setup_func(void)		\
 }
 #endif /* MODULE */
 
+#else /* CONFIG_EARLY_PLATFORM_DEVICES */
+static inline int
+early_platform_driver_register(struct early_platform_driver *epdrv, char *buf)
+{
+	return -ENOSYS;
+}
+static inline void
+early_platform_add_devices(struct platform_device **devs, int num) {}
+static inline void early_platform_add_device(struct platform_device *pdev) {}
+static inline int is_early_platform_device(struct platform_device *pdev)
+{
+	return -ENOSYS;
+}
+static inline void early_platform_driver_register_all(char *class_str) {}
+static inline int early_platform_driver_probe(char *class_str,
+					      int nr_probe, int user_only)
+{
+	return -ENOSYS;
+}
+static inline int early_platform_driver_register_probe_all(char *class_str,
+							   int nr_probe,
+							   int user_only)
+{
+	return -ENOSYS;
+}
+static inline void early_platform_cleanup(void) {}
+#define early_platform_init(class_string, platdrv)
+#define early_platform_init_buffer(class_string, platdrv, buf, bufsiz)
+#endif /* CONFIG_EARLY_PLATFORM_DEVICES */
+
 #ifdef CONFIG_SUSPEND
 extern int platform_pm_suspend(struct device *dev);
 extern int platform_pm_resume(struct device *dev);
-- 
2.17.0
