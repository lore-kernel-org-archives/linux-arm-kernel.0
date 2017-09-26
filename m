From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 26 Sep 2017 22:47:10 +0200
Subject: [PATCH] PM: ARM: sa1111: Drop suspend and resume bus type callbacks
Message-ID: <2654085.Tx1JnNWXkX@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

None of the sa1111 drivers in the tree implements the suspend and
resume callbacks from struct sa1111_driver, so drop them and drop
the corresponding callbacks from sa1111_bus_type.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/arm/common/sa1111.c               |   24 ------------------------
 arch/arm/include/asm/hardware/sa1111.h |    2 --
 2 files changed, 26 deletions(-)

Index: linux-pm/arch/arm/include/asm/hardware/sa1111.h
===================================================================
--- linux-pm.orig/arch/arm/include/asm/hardware/sa1111.h
+++ linux-pm/arch/arm/include/asm/hardware/sa1111.h
@@ -430,8 +430,6 @@ struct sa1111_driver {
 	unsigned int		devid;
 	int (*probe)(struct sa1111_dev *);
 	int (*remove)(struct sa1111_dev *);
-	int (*suspend)(struct sa1111_dev *, pm_message_t);
-	int (*resume)(struct sa1111_dev *);
 	void (*shutdown)(struct sa1111_dev *);
 };
 
Index: linux-pm/arch/arm/common/sa1111.c
===================================================================
--- linux-pm.orig/arch/arm/common/sa1111.c
+++ linux-pm/arch/arm/common/sa1111.c
@@ -1379,28 +1379,6 @@ static int sa1111_match(struct device *_
 	return !!(dev->devid & drv->devid);
 }
 
-static int sa1111_bus_suspend(struct device *dev, pm_message_t state)
-{
-	struct sa1111_dev *sadev = to_sa1111_device(dev);
-	struct sa1111_driver *drv = SA1111_DRV(dev->driver);
-	int ret = 0;
-
-	if (drv && drv->suspend)
-		ret = drv->suspend(sadev, state);
-	return ret;
-}
-
-static int sa1111_bus_resume(struct device *dev)
-{
-	struct sa1111_dev *sadev = to_sa1111_device(dev);
-	struct sa1111_driver *drv = SA1111_DRV(dev->driver);
-	int ret = 0;
-
-	if (drv && drv->resume)
-		ret = drv->resume(sadev);
-	return ret;
-}
-
 static void sa1111_bus_shutdown(struct device *dev)
 {
 	struct sa1111_driver *drv = SA1111_DRV(dev->driver);
@@ -1436,8 +1414,6 @@ struct bus_type sa1111_bus_type = {
 	.match		= sa1111_match,
 	.probe		= sa1111_bus_probe,
 	.remove		= sa1111_bus_remove,
-	.suspend	= sa1111_bus_suspend,
-	.resume		= sa1111_bus_resume,
 	.shutdown	= sa1111_bus_shutdown,
 };
 EXPORT_SYMBOL(sa1111_bus_type);
