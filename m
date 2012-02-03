From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:57:56 +0000
Subject: [PATCH 10/20] ARM: sa1111: change devid to be a bitmask
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPGe-00044A-DX@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the sa1111 device id to be a bitmask.  This allows us to
specify the actual device, while allowing a single driver to bind
to both PS2 devices.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c               |   12 ++++++------
 arch/arm/include/asm/hardware/sa1111.h |   20 +++++++++++---------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 1366e82..4bdf1bb 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -158,7 +158,7 @@ static struct sa1111_dev_info sa1111_devices[] = {
 	{
 		.offset		= SA1111_KBD,
 		.skpcr_mask	= SKPCR_PTCLKEN,
-		.devid		= SA1111_DEVID_PS2,
+		.devid		= SA1111_DEVID_PS2_KBD,
 		.irq = {
 			IRQ_TPRXINT,
 			IRQ_TPTXINT
@@ -167,7 +167,7 @@ static struct sa1111_dev_info sa1111_devices[] = {
 	{
 		.offset		= SA1111_MSE,
 		.skpcr_mask	= SKPCR_PMCLKEN,
-		.devid		= SA1111_DEVID_PS2,
+		.devid		= SA1111_DEVID_PS2_MSE,
 		.irq = {
 			IRQ_MSRXINT,
 			IRQ_MSTXINT
@@ -835,12 +835,12 @@ __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	has_devs = ~0;
 	if (machine_is_assabet() || machine_is_jornada720() ||
 	    machine_is_badge4())
-		has_devs &= ~(1 << 4);
+		has_devs &= ~SA1111_DEVID_PS2_MSE;
 	else
-		has_devs &= ~(1 << 1);
+		has_devs &= ~SA1111_DEVID_SAC;
 
 	for (i = 0; i < ARRAY_SIZE(sa1111_devices); i++)
-		if (has_devs & (1 << i))
+		if (sa1111_devices[i].devid & has_devs)
 			sa1111_init_one_child(sachip, mem, &sa1111_devices[i]);
 
 	return 0;
@@ -1335,7 +1335,7 @@ static int sa1111_match(struct device *_dev, struct device_driver *_drv)
 	struct sa1111_dev *dev = SA1111_DEV(_dev);
 	struct sa1111_driver *drv = SA1111_DRV(_drv);
 
-	return dev->devid == drv->devid;
+	return dev->devid & drv->devid;
 }
 
 static int sa1111_bus_suspend(struct device *dev, pm_message_t state)
diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index d54d781..37ad29d 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -516,15 +516,17 @@
 
 extern struct bus_type sa1111_bus_type;
 
-#define SA1111_DEVID_SBI	0
-#define SA1111_DEVID_SK		1
-#define SA1111_DEVID_USB	2
-#define SA1111_DEVID_SAC	3
-#define SA1111_DEVID_SSP	4
-#define SA1111_DEVID_PS2	5
-#define SA1111_DEVID_GPIO	6
-#define SA1111_DEVID_INT	7
-#define SA1111_DEVID_PCMCIA	8
+#define SA1111_DEVID_SBI	(1 << 0)
+#define SA1111_DEVID_SK		(1 << 1)
+#define SA1111_DEVID_USB	(1 << 2)
+#define SA1111_DEVID_SAC	(1 << 3)
+#define SA1111_DEVID_SSP	(1 << 4)
+#define SA1111_DEVID_PS2	(3 << 5)
+#define SA1111_DEVID_PS2_KBD	(1 << 5)
+#define SA1111_DEVID_PS2_MSE	(1 << 6)
+#define SA1111_DEVID_GPIO	(1 << 7)
+#define SA1111_DEVID_INT	(1 << 8)
+#define SA1111_DEVID_PCMCIA	(1 << 9)
 
 struct sa1111_dev {
 	struct device	dev;
-- 
1.7.4.4
