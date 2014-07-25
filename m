From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 25 Jul 2014 15:23:53 +0100
Subject: [PATCH 5/5] platform: Make platform_bus device a platform device
In-Reply-To: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
References: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1406298233-27876-5-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... describing the root of the device tree, so one can write
a platform driver initializing the platform.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/base/platform.c         | 20 ++++++++++++++------
 include/linux/platform_device.h |  2 +-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index eee48c4..9caffa7 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -30,8 +30,8 @@
 /* For automatically allocated device IDs */
 static DEFINE_IDA(platform_devid_ida);
 
-struct device platform_bus = {
-	.init_name	= "platform",
+struct platform_device platform_bus = {
+	.name	= "platform",
 };
 EXPORT_SYMBOL_GPL(platform_bus);
 
@@ -300,7 +300,7 @@ int platform_device_add(struct platform_device *pdev)
 		return -EINVAL;
 
 	if (!pdev->dev.parent)
-		pdev->dev.parent = &platform_bus;
+		pdev->dev.parent = &platform_bus.dev;
 
 	pdev->dev.bus = &platform_bus_type;
 
@@ -946,12 +946,20 @@ int __init platform_bus_init(void)
 
 	early_platform_cleanup();
 
-	error = device_register(&platform_bus);
+	dev_set_name(&platform_bus.dev, "%s", platform_bus.name);
+	error = device_register(&platform_bus.dev);
 	if (error)
 		return error;
 	error =  bus_register(&platform_bus_type);
-	if (error)
-		device_unregister(&platform_bus);
+	if (!error) {
+#ifdef CONFIG_OF
+		platform_bus.dev.of_node = of_allnodes;
+#endif
+		platform_bus.dev.bus = &platform_bus_type;
+		bus_add_device(&platform_bus.dev);
+	} else {
+		device_unregister(&platform_bus.dev);
+	}
 	return error;
 }
 
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 16f6654..a99032a 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -44,7 +44,7 @@ extern int platform_device_register(struct platform_device *);
 extern void platform_device_unregister(struct platform_device *);
 
 extern struct bus_type platform_bus_type;
-extern struct device platform_bus;
+extern struct platform_device platform_bus;
 
 extern void arch_setup_pdev_archdata(struct platform_device *);
 extern struct resource *platform_get_resource(struct platform_device *,
-- 
1.9.1
