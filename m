From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:56:55 +0000
Subject: [PATCH 07/20] ARM: sa1111: add shutdown hook to sa1111_driver
 structure
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPFf-00043y-Dj@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a shutdown hook to the sa1111_driver structure to allow drivers
to be notified of system reboots and shutdowns.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c               |    9 +++++++++
 arch/arm/include/asm/hardware/sa1111.h |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index b64a336..b0f9362 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1348,6 +1348,14 @@ static int sa1111_bus_resume(struct device *dev)
 	return ret;
 }
 
+static void sa1111_bus_shutdown(struct device *dev)
+{
+	struct sa1111_driver *drv = SA1111_DRV(dev->driver);
+
+	if (drv && drv->shutdown)
+		drv->shutdown(SA1111_DEV(dev));
+}
+
 static int sa1111_bus_probe(struct device *dev)
 {
 	struct sa1111_dev *sadev = SA1111_DEV(dev);
@@ -1377,6 +1385,7 @@ struct bus_type sa1111_bus_type = {
 	.remove		= sa1111_bus_remove,
 	.suspend	= sa1111_bus_suspend,
 	.resume		= sa1111_bus_resume,
+	.shutdown	= sa1111_bus_shutdown,
 };
 EXPORT_SYMBOL(sa1111_bus_type);
 
diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index 92ed254..29e320f 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -548,6 +548,7 @@ struct sa1111_driver {
 	int (*remove)(struct sa1111_dev *);
 	int (*suspend)(struct sa1111_dev *, pm_message_t);
 	int (*resume)(struct sa1111_dev *);
+	void (*shutdown)(struct sa1111_dev *);
 };
 
 #define SA1111_DRV(_d)	container_of((_d), struct sa1111_driver, drv)
-- 
1.7.4.4
