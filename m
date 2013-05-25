From: clbchenlibo.chen@huawei.com (Libo Chen)
Date: Sat, 25 May 2013 12:40:50 +0800
Subject: [PATCH] module: use a macro instead of platform_driver_register
Message-ID: <51A040D2.20708@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


I found a lot of mistakes using struct platform_driver without owner
so I make a macro instead of the function platform_driver_register.
It can set owner in it, then guys don`t care about module owner again.

Signed-off-by: Libo Chen <libo.chen@huawei.com>
---
 drivers/base/platform.c         |    8 +++++---
 include/linux/platform_device.h |    8 +++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 9eda842..ed75cf6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -523,11 +523,13 @@ static void platform_drv_shutdown(struct device *_dev)
 }

 /**
- * platform_driver_register - register a driver for platform-level devices
+ * __platform_driver_register - register a driver for platform-level devices
  * @drv: platform driver structure
  */
-int platform_driver_register(struct platform_driver *drv)
+int __platform_driver_register(struct platform_driver *drv,
+				struct module *owner)
 {
+	drv->driver.owner = owner;
 	drv->driver.bus = &platform_bus_type;
 	if (drv->probe)
 		drv->driver.probe = platform_drv_probe;
@@ -538,7 +540,7 @@ int platform_driver_register(struct platform_driver *drv)

 	return driver_register(&drv->driver);
 }
-EXPORT_SYMBOL_GPL(platform_driver_register);
+EXPORT_SYMBOL_GPL(__platform_driver_register);

 /**
  * platform_driver_unregister - unregister a driver for platform-level devices
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 9abf1db..cd46ee5 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -180,7 +180,13 @@ struct platform_driver {
 	const struct platform_device_id *id_table;
 };

-extern int platform_driver_register(struct platform_driver *);
+/*
+ * use a macro to avoid include chaining to get THIS_MODULE
+ */
+#define platform_driver_register(drv) \
+	__platform_driver_register(drv, THIS_MODULE)
+extern int __platform_driver_register(struct platform_driver *,
+					struct module *);
 extern void platform_driver_unregister(struct platform_driver *);

 /* non-hotpluggable platform devices may use this so that probe() and
-- 
1.7.1
