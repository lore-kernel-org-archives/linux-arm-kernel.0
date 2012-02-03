From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:34:31 +0000
Subject: [PATCH 10/17] ARM: sa11x0: neponset: dynamically create neponset
 child devices
In-Reply-To: <20120203193059.GF14129@n2100.arm.linux.org.uk>
References: <20120203193059.GF14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtOtz-0001CC-Ht@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use platform_device_register_full() to dynamically create the various
neponset child platform devices, and place them below the neponset
device itself to ensure proper PM ordering and device structure.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/neponset.c |   56 +++++++++++++++++++-------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 6f0aa91..164bc98 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -1,6 +1,7 @@
 /*
  * linux/arch/arm/mach-sa1100/neponset.c
  */
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
@@ -22,6 +23,8 @@
 #include <mach/neponset.h>
 
 struct neponset_drvdata {
+	struct platform_device *sa1111;
+	struct platform_device *smc91x;
 #ifdef CONFIG_PM_SLEEP
 	u32 ncr0;
 	u32 mdm_ctl_0;
@@ -178,20 +181,6 @@ static struct sa1111_platform_data sa1111_info = {
 	.irq_base	= IRQ_BOARD_END,
 };
 
-static u64 sa1111_dmamask = 0xffffffffUL;
-
-static struct platform_device sa1111_device = {
-	.name		= "sa1111",
-	.id		= 0,
-	.dev		= {
-		.dma_mask = &sa1111_dmamask,
-		.coherent_dma_mask = 0xffffffff,
-		.platform_data = &sa1111_info,
-	},
-	.num_resources	= ARRAY_SIZE(sa1111_resources),
-	.resource	= sa1111_resources,
-};
-
 static struct resource smc91x_resources[] = {
 	[0] = DEFINE_RES_MEM_NAMED(SA1100_CS3_PHYS, 0x02000000, "smc91x-regs"),
 	[1] = DEFINE_RES_IRQ(IRQ_NEPONSET_SMC9196),
@@ -199,16 +188,26 @@ static struct resource smc91x_resources[] = {
 			0x02000000, "smc91x-attrib"),
 };
 
-static struct platform_device smc91x_device = {
-	.name		= "smc91x",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(smc91x_resources),
-	.resource	= smc91x_resources,
-};
-
 static int __devinit neponset_probe(struct platform_device *dev)
 {
 	struct neponset_drvdata *d;
+	struct platform_device_info sa1111_devinfo = {
+		.parent = &dev->dev,
+		.name = "sa1111",
+		.id = 0,
+		.res = sa1111_resources,
+		.num_res = ARRAY_SIZE(sa1111_resources),
+		.data = &sa1111_info,
+		.size_data = sizeof(sa1111_info),
+		.dma_mask = 0xffffffffUL,
+	};
+	struct platform_device_info smc91x_devinfo = {
+		.parent = &dev->dev,
+		.name = "smc91x",
+		.id = 0,
+		.res = smc91x_resources,
+		.num_res = ARRAY_SIZE(smc91x_resources),
+	};
 	int ret;
 
 	d = kzalloc(sizeof(*d), GFP_KERNEL);
@@ -251,6 +250,9 @@ static int __devinit neponset_probe(struct platform_device *dev)
 	 */
 	NCR_0 = NCR_GP01_OFF;
 
+	d->sa1111 = platform_device_register_full(&sa1111_devinfo);
+	d->smc91x = platform_device_register_full(&smc91x_devinfo);
+
 	platform_set_drvdata(dev, d);
 
 	return 0;
@@ -263,6 +265,10 @@ static int __devexit neponset_remove(struct platform_device *dev)
 {
 	struct neponset_drvdata *d = platform_get_drvdata(dev);
 
+	if (!IS_ERR(d->sa1111))
+		platform_device_unregister(d->sa1111);
+	if (!IS_ERR(d->smc91x))
+		platform_device_unregister(d->smc91x);
 	irq_set_chained_handler(IRQ_GPIO25, NULL);
 
 	kfree(d);
@@ -318,12 +324,6 @@ static struct platform_device neponset_device = {
 	.resource	= neponset_resources,
 };
 
-static struct platform_device *devices[] __initdata = {
-	&neponset_device,
-	&sa1111_device,
-	&smc91x_device,
-};
-
 extern void sa1110_mb_disable(void);
 
 static int __init neponset_init(void)
@@ -354,7 +354,7 @@ static int __init neponset_init(void)
 		return -ENODEV;
 	}
 
-	return platform_add_devices(devices, ARRAY_SIZE(devices));
+	return platform_device_register(&neponset_device);
 }
 
 subsys_initcall(neponset_init);
-- 
1.7.4.4
