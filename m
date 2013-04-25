From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Apr 2013 19:28:59 +0200
Subject: [PATCH 16/21] OF: remove #ifdef from linux/of_platform.h
In-Reply-To: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
Message-ID: <1366910944-3033663-17-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A lot of code uses the functions from of_platform.h when built for
devicetree-enabled platforms but can also be built without them.
In order to avoid using #ifdef everywhere in drivers, this
makes all the function declarations visible, which means we
can use "if (IS_ENABLED(CONFIG_OF))" in driver code and get build
coverage over the code but let the compiler drop the reference
in the object code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 include/linux/of_platform.h | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 2a93b64..ff83462 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -14,7 +14,6 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 
-#ifdef CONFIG_OF_DEVICE
 #include <linux/pm.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -82,7 +81,6 @@ extern struct platform_device *of_device_alloc(struct device_node *np,
 					 struct device *parent);
 extern struct platform_device *of_find_device_by_node(struct device_node *np);
 
-#ifdef CONFIG_OF_ADDRESS /* device reg helpers depend on OF_ADDRESS */
 /* Platform devices and busses creation */
 extern struct platform_device *of_platform_device_create(struct device_node *np,
 						   const char *bus_id,
@@ -91,17 +89,12 @@ extern struct platform_device *of_platform_device_create(struct device_node *np,
 extern int of_platform_bus_probe(struct device_node *root,
 				 const struct of_device_id *matches,
 				 struct device *parent);
+#ifdef CONFIG_OF_ADDRESS
 extern int of_platform_populate(struct device_node *root,
 				const struct of_device_id *matches,
 				const struct of_dev_auxdata *lookup,
 				struct device *parent);
-#endif /* CONFIG_OF_ADDRESS */
-
-#endif /* CONFIG_OF_DEVICE */
-
-#if !defined(CONFIG_OF_ADDRESS)
-struct of_dev_auxdata;
-struct device_node;
+#else
 static inline int of_platform_populate(struct device_node *root,
 					const struct of_device_id *matches,
 					const struct of_dev_auxdata *lookup,
@@ -109,6 +102,6 @@ static inline int of_platform_populate(struct device_node *root,
 {
 	return -ENODEV;
 }
-#endif /* !CONFIG_OF_ADDRESS */
+#endif
 
 #endif	/* _LINUX_OF_PLATFORM_H */
-- 
1.8.1.2
