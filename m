From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 26 Aug 2015 14:28:17 +0200
Subject: [PATCH 05/16] deps: introduce initcalls annotated with a struct
 device_driver
In-Reply-To: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
References: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
Message-ID: <1440592108-3740-6-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make it possible to identify initcalls before calling them by adding
a pointer to a struct device_driver to the stored pointer to an initcall.

This is e.g. necessary in order to sort initcalls by whatever means
before calling them.

To annotate an initcall, the following changes are necessary on
drivers which want to offer that feature:

now				annotated
--------------------------------------------------------------------------
pure_initcall(fn)		annotated_initcall(pure, fn, dev_drv)
core_initcall(fn)		annotated_initcall(core, fn, dev_drv)
core_initcall_sync(fn)		annotated_initcall_sync(core, fn, dev_drv)
...
late_initcall(fn)		annotated_initcall(late, fn, dev_drv)
module_init(fn)			annotated_module_init(fn, dev_drv)

module_platform_driver(drv)	no changes necessary, done automatically
module_platform_driver_probe(drv, probe)	no changes necessary
module_i2c_driver(i2c_drv)	no changes necessary, done automatically

E.g. to make the driver sram offering an annotated initcall the
following patch is necessary:

----
-postcore_initcall(sram_init);
+annotated_initcall(postcore, sram_init, sram_driver.driver);
----

These changes can be done without any fear. If the feature is disabled,
which is the default, the new macros will just map to the old ones and
nothing is changed at all.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 arch/arm/kernel/vmlinux.lds.S     |  1 +
 include/asm-generic/vmlinux.lds.h |  6 ++++++
 include/linux/device.h            | 12 ++++++++++++
 include/linux/i2c.h               |  2 +-
 include/linux/init.h              | 33 +++++++++++++++++++++++++++++++++
 include/linux/module.h            |  2 ++
 include/linux/platform_device.h   | 16 ++++++++++++----
 init/Kconfig                      |  3 +++
 8 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 8b60fde..10a328f 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -213,6 +213,7 @@ SECTIONS
 #endif
 		INIT_SETUP(16)
 		INIT_CALLS
+		ANNOTATED_INITCALL
 		CON_INITCALL
 		SECURITY_INITCALL
 		INIT_RAM_FS
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8bd374d..7318ba7 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -660,6 +660,11 @@
 		INIT_CALLS_LEVEL(7)					\
 		VMLINUX_SYMBOL(__initcall_end) = .;
 
+#define ANNOTATED_INITCALL						\
+		VMLINUX_SYMBOL(__annotated_initcall_start) = .;		\
+		*(.annotated_initcall.init)				\
+		VMLINUX_SYMBOL(__annotated_initcall_end) = .;
+
 #define CON_INITCALL							\
 		VMLINUX_SYMBOL(__con_initcall_start) = .;		\
 		*(.con_initcall.init)					\
@@ -816,6 +821,7 @@
 		INIT_DATA						\
 		INIT_SETUP(initsetup_align)				\
 		INIT_CALLS						\
+		ANNOTATED_INITCALL					\
 		CON_INITCALL						\
 		SECURITY_INITCALL					\
 		INIT_RAM_FS						\
diff --git a/include/linux/device.h b/include/linux/device.h
index a2b4ea7..128fddd 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1321,4 +1321,16 @@ static int __init __driver##_init(void) \
 } \
 device_initcall(__driver##_init);
 
+#define annotated_module_driver(__driver, __register, __unregister, ...) \
+static int __init __driver##_init(void) \
+{ \
+	return __register(&(__driver), ##__VA_ARGS__); \
+} \
+annotated_module_init(__driver##_init, __driver.driver); \
+static void __exit __driver##_exit(void) \
+{ \
+	__unregister(&(__driver), ##__VA_ARGS__); \
+} \
+module_exit(__driver##_exit)
+
 #endif /* _DEVICE_H_ */
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index e83a738..fa63ec1 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -626,7 +626,7 @@ static inline int i2c_adapter_id(struct i2c_adapter *adap)
  * use this macro once, and calling it replaces module_init() and module_exit()
  */
 #define module_i2c_driver(__i2c_driver) \
-	module_driver(__i2c_driver, i2c_add_driver, \
+	annotated_module_driver(__i2c_driver, i2c_add_driver, \
 			i2c_del_driver)
 
 #endif /* I2C */
diff --git a/include/linux/init.h b/include/linux/init.h
index b449f37..52ea986 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -124,6 +124,15 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
+struct device_driver;
+
+struct _annotated_initcall {
+	initcall_t initcall;
+	struct device_driver *driver;
+};
+extern struct _annotated_initcall __annotated_initcall_start[],
+				  __annotated_initcall_end[];
+
 extern initcall_t __con_initcall_start[], __con_initcall_end[];
 extern initcall_t __security_initcall_start[], __security_initcall_end[];
 
@@ -184,6 +193,11 @@ extern bool initcall_debug;
 	__attribute__((__section__(".initcall" #id ".init"))) = fn; \
 	LTO_REFERENCE_INITCALL(__initcall_##fn##id)
 
+#define __define_annotated_initcall(fn, drv) \
+	static struct _annotated_initcall __annotated_initcall_##fn __used \
+	__attribute__((__section__(".annotated_initcall.init"))) = \
+							{ fn, &(drv) }
+
 /*
  * Early initcalls run before initializing SMP.
  *
@@ -216,6 +230,25 @@ extern bool initcall_debug;
 #define late_initcall(fn)		__define_initcall(fn, 7)
 #define late_initcall_sync(fn)		__define_initcall(fn, 7s)
 
+/*
+ * Annotated initcalls are accompanied by a struct device_driver.
+ * This makes initcalls identifiable and is used to order initcalls.
+ *
+ * If disabled, nothing is changed and the classic level based
+ * initialization sequence is in use.
+ */
+#ifdef CONFIG_ANNOTATED_INITCALLS
+#define annotated_module_init(fn, drv)	__define_annotated_initcall(fn, drv)
+#define annotated_initcall(level, fn, drv) \
+					__define_annotated_initcall(fn, drv)
+#define annotated_initcall_sync(level, fn, drv) \
+					__define_annotated_initcall(fn, drv)
+#else
+#define annotated_module_init(fn, drv)	module_init(fn)
+#define annotated_initcall(level, fn, drv)	level ## _initcall(fn)
+#define annotated_initcall_sync(level, fn, drv)	level ## _initcall_sync(fn)
+#endif
+
 #define __initcall(fn) device_initcall(fn)
 
 #define __exitcall(fn) \
diff --git a/include/linux/module.h b/include/linux/module.h
index 3a19c79..6079d28 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -119,6 +119,8 @@ extern void cleanup_module(void);
 #define device_initcall_sync(fn)	module_init(fn)
 #define late_initcall(fn)		module_init(fn)
 #define late_initcall_sync(fn)		module_init(fn)
+#define annotated_initcall(level, fn, drv)	module_init(fn)
+#define annotated_module_init(fn, drv)	module_init(fn)
 
 #define console_initcall(fn)		module_init(fn)
 #define security_initcall(fn)		module_init(fn)
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index bba08f4..baa5a66 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -218,9 +218,17 @@ static inline void platform_set_drvdata(struct platform_device *pdev,
  * boilerplate.  Each module may only use this macro once, and
  * calling it replaces module_init() and module_exit()
  */
-#define module_platform_driver(__platform_driver) \
-	module_driver(__platform_driver, platform_driver_register, \
-			platform_driver_unregister)
+#define module_platform_driver(__driver) \
+static int __init __driver##_init(void) \
+{ \
+	return platform_driver_register(&(__driver)); \
+} \
+annotated_module_init(__driver##_init, __driver.driver); \
+static void __exit __driver##_exit(void) \
+{ \
+	platform_driver_unregister(&(__driver)); \
+} \
+module_exit(__driver##_exit)
 
 /* builtin_platform_driver() - Helper macro for builtin drivers that
  * don't do anything special in driver init.  This eliminates some
@@ -242,7 +250,7 @@ static int __init __platform_driver##_init(void) \
 	return platform_driver_probe(&(__platform_driver), \
 				     __platform_probe);    \
 } \
-module_init(__platform_driver##_init); \
+annotated_module_init(__platform_driver##_init, __platform_driver.driver); \
 static void __exit __platform_driver##_exit(void) \
 { \
 	platform_driver_unregister(&(__platform_driver)); \
diff --git a/init/Kconfig b/init/Kconfig
index af09b4f..5cfd7c4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -26,6 +26,9 @@ config IRQ_WORK
 config BUILDTIME_EXTABLE_SORT
 	bool
 
+config ANNOTATED_INITCALLS
+	bool
+
 menu "General setup"
 
 config BROKEN
-- 
2.1.0
