From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sun, 11 Jan 2015 16:18:24 +0100
Subject: [PATCH 2/2] ARM: locomo: Remove legacy suspend/resume support
In-Reply-To: <1420989504-29845-1-git-send-email-lars@metafoo.de>
References: <1420989504-29845-1-git-send-email-lars@metafoo.de>
Message-ID: <1420989504-29845-2-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are currently no locomo device driver that implements suspend/resume
and this patch removes the bus specific legacy suspend and resume callbacks.
This will allow us to eventually remove struct bus_type legacy suspend and
resume support altogether.

Locomo device drivers wanting to implement suspend and resume can use dev PM
ops which will work out of the box without further modifications necessary.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/arm/common/locomo.c               | 28 ----------------------------
 arch/arm/include/asm/hardware/locomo.h |  2 --
 2 files changed, 30 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index b55c362..371f864 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -519,10 +519,6 @@ static int locomo_remove(struct platform_device *dev)
 static struct platform_driver locomo_device_driver = {
 	.probe		= locomo_probe,
 	.remove		= locomo_remove,
-#ifdef CONFIG_PM
-	.suspend	= locomo_suspend,
-	.resume		= locomo_resume,
-#endif
 	.driver		= {
 		.name	= "locomo",
 	},
@@ -826,28 +822,6 @@ static int locomo_match(struct device *_dev, struct device_driver *_drv)
 	return dev->devid == drv->devid;
 }
 
-static int locomo_bus_suspend(struct device *dev, pm_message_t state)
-{
-	struct locomo_dev *ldev = LOCOMO_DEV(dev);
-	struct locomo_driver *drv = LOCOMO_DRV(dev->driver);
-	int ret = 0;
-
-	if (drv && drv->suspend)
-		ret = drv->suspend(ldev, state);
-	return ret;
-}
-
-static int locomo_bus_resume(struct device *dev)
-{
-	struct locomo_dev *ldev = LOCOMO_DEV(dev);
-	struct locomo_driver *drv = LOCOMO_DRV(dev->driver);
-	int ret = 0;
-
-	if (drv && drv->resume)
-		ret = drv->resume(ldev);
-	return ret;
-}
-
 static int locomo_bus_probe(struct device *dev)
 {
 	struct locomo_dev *ldev = LOCOMO_DEV(dev);
@@ -875,8 +849,6 @@ struct bus_type locomo_bus_type = {
 	.match		= locomo_match,
 	.probe		= locomo_bus_probe,
 	.remove		= locomo_bus_remove,
-	.suspend	= locomo_bus_suspend,
-	.resume		= locomo_bus_resume,
 };
 
 int locomo_driver_register(struct locomo_driver *driver)
diff --git a/arch/arm/include/asm/hardware/locomo.h b/arch/arm/include/asm/hardware/locomo.h
index 74e51d6b..f8712e3 100644
--- a/arch/arm/include/asm/hardware/locomo.h
+++ b/arch/arm/include/asm/hardware/locomo.h
@@ -189,8 +189,6 @@ struct locomo_driver {
 	unsigned int		devid;
 	int (*probe)(struct locomo_dev *);
 	int (*remove)(struct locomo_dev *);
-	int (*suspend)(struct locomo_dev *, pm_message_t);
-	int (*resume)(struct locomo_dev *);
 };
 
 #define LOCOMO_DRV(_d)	container_of((_d), struct locomo_driver, drv)
-- 
1.8.0
