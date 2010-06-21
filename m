From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 21 Jun 2010 22:22:32 +0800
Subject: [PATCH 1/3] [ARM] pxa: move pmu device back into mach-pxa/
Message-ID: <1277130154-25912-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not tested and enabled on MMP at this moment, and since the IRQ
is different from mach-pxa, I'd prefer to move the PMU device
back into mach-pxa/. Will introduce the PMU device to MMP once
it's enabled and tested.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/devices.c |   14 ++++++++++++++
 arch/arm/mach-pxa/devices.h |    1 +
 arch/arm/mach-pxa/pxa25x.c  |    1 +
 arch/arm/mach-pxa/pxa27x.c  |    1 +
 arch/arm/mach-pxa/pxa3xx.c  |    1 +
 arch/arm/plat-pxa/Makefile  |    1 -
 arch/arm/plat-pxa/pmu.c     |   33 ---------------------------------
 7 files changed, 18 insertions(+), 34 deletions(-)
 delete mode 100644 arch/arm/plat-pxa/pmu.c

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 8e10db1..65447dc 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -4,6 +4,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 
+#include <asm/pmu.h>
 #include <mach/udc.h>
 #include <mach/pxafb.h>
 #include <mach/mmc.h>
@@ -31,6 +32,19 @@ void __init pxa_register_device(struct platform_device *dev, void *data)
 		dev_err(&dev->dev, "unable to register device: %d\n", ret);
 }
 
+static struct resource pxa_resource_pmu = {
+	.start	= IRQ_PMU,
+	.end	= IRQ_PMU,
+	.flags	= IORESOURCE_IRQ,
+};
+
+struct platform_device pxa_device_pmu = {
+	.name		= "arm-pmu",
+	.id		= ARM_PMU_DEVICE_CPU,
+	.resource	= &pxa_resource_pmu,
+	.num_resources	= 1,
+};
+
 static struct resource pxamci_resources[] = {
 	[0] = {
 		.start	= 0x41100000,
diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 93817d9..50353ea 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -1,3 +1,4 @@
+extern struct platform_device pxa_device_pmu;
 extern struct platform_device pxa_device_mci;
 extern struct platform_device pxa3xx_device_mci2;
 extern struct platform_device pxa3xx_device_mci3;
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 0b9ad30..de53f2e 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -322,6 +322,7 @@ void __init pxa26x_init_irq(void)
 
 static struct platform_device *pxa25x_devices[] __initdata = {
 	&pxa25x_device_udc,
+	&pxa_device_pmu,
 	&pxa_device_i2s,
 	&sa1100_device_rtc,
 	&pxa25x_device_ssp,
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 0af3617..c3d53dd 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -383,6 +383,7 @@ void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 
 static struct platform_device *devices[] __initdata = {
 	&pxa27x_device_udc,
+	&pxa_device_pmu,
 	&pxa_device_i2s,
 	&sa1100_device_rtc,
 	&pxa_device_rtc,
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index c18d2df..acfa9f7 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -608,6 +608,7 @@ void __init pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 
 static struct platform_device *devices[] __initdata = {
 	&pxa27x_device_udc,
+	&pxa_device_pmu,
 	&pxa_device_i2s,
 	&sa1100_device_rtc,
 	&pxa_device_rtc,
diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
index a17cc0c..4aacdd1 100644
--- a/arch/arm/plat-pxa/Makefile
+++ b/arch/arm/plat-pxa/Makefile
@@ -4,7 +4,6 @@
 
 obj-y	:= dma.o
 
-obj-$(CONFIG_ARCH_PXA)		+= pmu.o
 obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
 obj-$(CONFIG_PXA3xx)		+= mfp.o
 obj-$(CONFIG_ARCH_MMP)		+= mfp.o
diff --git a/arch/arm/plat-pxa/pmu.c b/arch/arm/plat-pxa/pmu.c
deleted file mode 100644
index 267ceb6..0000000
--- a/arch/arm/plat-pxa/pmu.c
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * PMU IRQ registration for the PXA xscale PMU families.
- * Copyright (C) 2010 Will Deacon, ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#include <linux/platform_device.h>
-#include <asm/pmu.h>
-#include <mach/irqs.h>
-
-static struct resource pmu_resource = {
-	.start	= IRQ_PMU,
-	.end	= IRQ_PMU,
-	.flags	= IORESOURCE_IRQ,
-};
-
-static struct platform_device pmu_device = {
-	.name		= "arm-pmu",
-	.id		= ARM_PMU_DEVICE_CPU,
-	.resource	= &pmu_resource,
-	.num_resources	= 1,
-};
-
-static int __init pxa_pmu_init(void)
-{
-	platform_device_register(&pmu_device);
-	return 0;
-}
-arch_initcall(pxa_pmu_init);
-- 
1.7.1
