From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 May 2010 22:06:36 +0900
Subject: [PATCH v2 1/9] ARM: SAMSUNG: Moving ADC device definition to
	plat-samsung.
Message-ID: <1273755996-3065-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna <ch.naveen@samsung.com>

This patch moves ADC device definition to plat-samsung.
Because that is generic to the S3C64XX and S5P Series SoCs.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/Kconfig            |    1 +
 arch/arm/mach-s3c64xx/Makefile           |    1 -
 arch/arm/mach-s3c64xx/dev-adc.c          |   46 ------------------------------
 arch/arm/mach-s3c64xx/include/mach/map.h |    1 +
 arch/arm/mach-s3c64xx/s3c6410.c          |    2 +
 arch/arm/plat-samsung/Kconfig            |    5 +++
 arch/arm/plat-samsung/Makefile           |    1 +
 arch/arm/plat-samsung/dev-adc.c          |   46 ++++++++++++++++++++++++++++++
 8 files changed, 56 insertions(+), 47 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/dev-adc.c
 create mode 100644 arch/arm/plat-samsung/dev-adc.c

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 959df38..69e9fbf 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -85,6 +85,7 @@ config MACH_ANW6410
 config MACH_SMDK6410
 	bool "SMDK6410"
 	select CPU_S3C6410
+	select SAMSUNG_DEV_ADC
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_I2C1
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 3758e15..da66278 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -58,5 +58,4 @@ obj-$(CONFIG_MACH_HMT)		+= mach-hmt.o
 obj-y				+= dev-uart.o
 obj-y				+= dev-rtc.o
 obj-y				+= dev-audio.o
-obj-$(CONFIG_S3C_ADC)		+= dev-adc.o
 obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
diff --git a/arch/arm/mach-s3c64xx/dev-adc.c b/arch/arm/mach-s3c64xx/dev-adc.c
deleted file mode 100644
index fafef9b..0000000
--- a/arch/arm/mach-s3c64xx/dev-adc.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/* linux/arch/arm/plat-s3c64xx/dev-adc.c
- *
- * Copyright 2010 Maurus Cuelenaere
- *
- * S3C64xx series device definition for ADC device
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/adc.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-static struct resource s3c_adc_resource[] = {
-	[0] = {
-		.start = S3C64XX_PA_ADC,
-		.end   = S3C64XX_PA_ADC + SZ_256 - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_TC,
-		.end   = IRQ_TC,
-		.flags = IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start = IRQ_ADC,
-		.end   = IRQ_ADC,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_adc = {
-	.name		= "s3c64xx-adc",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_adc_resource),
-	.resource	= s3c_adc_resource,
-};
diff --git a/arch/arm/mach-s3c64xx/include/mach/map.h b/arch/arm/mach-s3c64xx/include/mach/map.h
index 801c1c0..869c8e0 100644
--- a/arch/arm/mach-s3c64xx/include/mach/map.h
+++ b/arch/arm/mach-s3c64xx/include/mach/map.h
@@ -103,5 +103,6 @@
 #define S3C_PA_USBHOST		S3C64XX_PA_USBHOST
 #define S3C_PA_USB_HSOTG	S3C64XX_PA_USB_HSOTG
 #define S3C_VA_USB_HSPHY	S3C64XX_VA_USB_HSPHY
+#define SAMSUNG_PA_ADC		S3C64XX_PA_ADC
 
 #endif /* __ASM_ARCH_6400_MAP_H */
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 59635d1..31e53fa 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -38,6 +38,7 @@
 #include <plat/clock.h>
 #include <plat/sdhci.h>
 #include <plat/iic-core.h>
+#include <plat/adc.h>
 #include <mach/s3c6400.h>
 #include <mach/s3c6410.h>
 
@@ -52,6 +53,7 @@ void __init s3c6410_map_io(void)
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
 
+	s3c_device_adc.name	= "s3c64xx-adc";
 	s3c_device_nand.name = "s3c6400-nand";
 }
 
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index d552c65..641649f 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -185,6 +185,11 @@ config S3C_DEV_NAND
 	help
 	  Compile in platform device definition for NAND controller
 
+config SAMSUNG_DEV_ADC
+	bool
+	help
+	  Compile in platform device definition for ADC controller
+
 config S3C64XX_DEV_SPI
 	bool
 	help
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 22c89d0..3cf30a4 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -40,6 +40,7 @@ obj-y				+= dev-uart.o
 obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
 obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
 obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
+obj-$(CONFIG_SAMSUNG_DEV_ADC)	+= dev-adc.o
 
 # DMA support
 
diff --git a/arch/arm/plat-samsung/dev-adc.c b/arch/arm/plat-samsung/dev-adc.c
new file mode 100644
index 0000000..9d903d4
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-adc.c
@@ -0,0 +1,46 @@
+/* linux/arch/arm/plat-samsung/dev-adc.c
+ *
+ * Copyright 2010 Maurus Cuelenaere
+ *
+ * S3C64xx series device definition for ADC device
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+#include <plat/adc.h>
+#include <plat/devs.h>
+#include <plat/cpu.h>
+
+static struct resource s3c_adc_resource[] = {
+	[0] = {
+		.start = SAMSUNG_PA_ADC,
+		.end   = SAMSUNG_PA_ADC + SZ_256 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_TC,
+		.end   = IRQ_TC,
+		.flags = IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start = IRQ_ADC,
+		.end   = IRQ_ADC,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_adc = {
+	.name		= "samsung-adc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_adc_resource),
+	.resource	= s3c_adc_resource,
+};
-- 
1.6.2.5
