From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 27 Nov 2017 18:38:41 +0000
Subject: [PATCH 2/6] ARM: sa1111: remove legacy suspend/resume methods
In-Reply-To: <20171127183811.GM31757@n2100.armlinux.org.uk>
References: <20171127183811.GM31757@n2100.armlinux.org.uk>
Message-ID: <E1eJOIj-0006oR-1t@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The legacy device-driver suspend/resume methods are not used by any of
our drivers, so let's remove this redundant code.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/common/sa1111.c               | 24 ------------------------
 arch/arm/include/asm/hardware/sa1111.h |  2 --
 2 files changed, 26 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 1fcf06d1cda8..c5f5341c05b7 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1379,28 +1379,6 @@ static int sa1111_match(struct device *_dev, struct device_driver *_drv)
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
 static int sa1111_bus_probe(struct device *dev)
 {
 	struct sa1111_dev *sadev = to_sa1111_device(dev);
@@ -1428,8 +1406,6 @@ struct bus_type sa1111_bus_type = {
 	.match		= sa1111_match,
 	.probe		= sa1111_bus_probe,
 	.remove		= sa1111_bus_remove,
-	.suspend	= sa1111_bus_suspend,
-	.resume		= sa1111_bus_resume,
 };
 EXPORT_SYMBOL(sa1111_bus_type);
 
diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index b4411add2ea8..29fb44f51c92 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -431,8 +431,6 @@ struct sa1111_driver {
 	unsigned int		devid;
 	int (*probe)(struct sa1111_dev *);
 	int (*remove)(struct sa1111_dev *);
-	int (*suspend)(struct sa1111_dev *, pm_message_t);
-	int (*resume)(struct sa1111_dev *);
 };
 
 #define SA1111_DRV(_d)	container_of((_d), struct sa1111_driver, drv)
-- 
2.7.4
