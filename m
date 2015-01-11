From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sun, 11 Jan 2015 16:18:23 +0100
Subject: [PATCH 1/2] ARM: sa1111: Remove legacy suspend/resume support
Message-ID: <1420989504-29845-1-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are currently no sa1111 device drivers that implement suspend/resume
and this patch removes the bus specific legacy suspend and resume callbacks.
This will allow us to eventually remove struct bus_type legacy suspend and
resume support altogether.

sa1111 device drivers wanting to implement suspend and resume can use dev PM
ops which will work out of the box without further modifications necessary.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/arm/common/sa1111.c               | 24 ------------------------
 arch/arm/include/asm/hardware/sa1111.h |  2 --
 2 files changed, 26 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 5cc779c..a292b9a 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1295,28 +1295,6 @@ static int sa1111_match(struct device *_dev, struct device_driver *_drv)
 	return dev->devid & drv->devid;
 }
 
-static int sa1111_bus_suspend(struct device *dev, pm_message_t state)
-{
-	struct sa1111_dev *sadev = SA1111_DEV(dev);
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
-	struct sa1111_dev *sadev = SA1111_DEV(dev);
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
@@ -1352,8 +1330,6 @@ struct bus_type sa1111_bus_type = {
 	.match		= sa1111_match,
 	.probe		= sa1111_bus_probe,
 	.remove		= sa1111_bus_remove,
-	.suspend	= sa1111_bus_suspend,
-	.resume		= sa1111_bus_resume,
 	.shutdown	= sa1111_bus_shutdown,
 };
 EXPORT_SYMBOL(sa1111_bus_type);
diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index 7c2bbc7..8fc6363 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -430,8 +430,6 @@ struct sa1111_driver {
 	unsigned int		devid;
 	int (*probe)(struct sa1111_dev *);
 	int (*remove)(struct sa1111_dev *);
-	int (*suspend)(struct sa1111_dev *, pm_message_t);
-	int (*resume)(struct sa1111_dev *);
 	void (*shutdown)(struct sa1111_dev *);
 };
 
-- 
1.8.0
