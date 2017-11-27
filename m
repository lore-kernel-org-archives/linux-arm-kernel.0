From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 27 Nov 2017 18:38:35 +0000
Subject: [PATCH 1/6] ARM: sa1111: remove legacy shutdown method
In-Reply-To: <20171127183811.GM31757@n2100.armlinux.org.uk>
References: <20171127183811.GM31757@n2100.armlinux.org.uk>
Message-ID: <E1eJOId-0006oK-Tf@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the only user of the SA1111 device driver shutdown method has now
gone, we can kill the bus level support code and the entry in the
sa1111 device driver structure.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/common/sa1111.c               | 9 ---------
 arch/arm/include/asm/hardware/sa1111.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 4ecd5120fce7..1fcf06d1cda8 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1401,14 +1401,6 @@ static int sa1111_bus_resume(struct device *dev)
 	return ret;
 }
 
-static void sa1111_bus_shutdown(struct device *dev)
-{
-	struct sa1111_driver *drv = SA1111_DRV(dev->driver);
-
-	if (drv && drv->shutdown)
-		drv->shutdown(to_sa1111_device(dev));
-}
-
 static int sa1111_bus_probe(struct device *dev)
 {
 	struct sa1111_dev *sadev = to_sa1111_device(dev);
@@ -1438,7 +1430,6 @@ struct bus_type sa1111_bus_type = {
 	.remove		= sa1111_bus_remove,
 	.suspend	= sa1111_bus_suspend,
 	.resume		= sa1111_bus_resume,
-	.shutdown	= sa1111_bus_shutdown,
 };
 EXPORT_SYMBOL(sa1111_bus_type);
 
diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index 0bbf163d1ed3..b4411add2ea8 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -433,7 +433,6 @@ struct sa1111_driver {
 	int (*remove)(struct sa1111_dev *);
 	int (*suspend)(struct sa1111_dev *, pm_message_t);
 	int (*resume)(struct sa1111_dev *);
-	void (*shutdown)(struct sa1111_dev *);
 };
 
 #define SA1111_DRV(_d)	container_of((_d), struct sa1111_driver, drv)
-- 
2.7.4
