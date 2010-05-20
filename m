From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 May 2010 19:28:30 +0900
Subject: [PATCH v2 2/3] ARM: SAMSUNG: Move WDT device definitions in
	plat-samsung
In-Reply-To: <1274351311-6879-1-git-send-email-kgene.kim@samsung.com>
References: <1274351311-6879-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1274351311-6879-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Banajit Goswami <banajit.g@samsung.com>

This patch moves the definitions of watchdog timer device from
plat-s3c24xx to plat-samsung. This will enable all Samsung S3C
and S5P series SoC's to use common WDT device definition.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/include/mach/map.h |    1 +
 arch/arm/plat-s3c24xx/devs.c             |   26 -------------------
 arch/arm/plat-samsung/Kconfig            |    6 ++++
 arch/arm/plat-samsung/Makefile           |    1 +
 arch/arm/plat-samsung/dev-wdt.c          |   40 ++++++++++++++++++++++++++++++
 5 files changed, 48 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm/plat-samsung/dev-wdt.c

diff --git a/arch/arm/mach-s3c2410/include/mach/map.h b/arch/arm/mach-s3c2410/include/mach/map.h
index f07d680..16fbc3c 100644
--- a/arch/arm/mach-s3c2410/include/mach/map.h
+++ b/arch/arm/mach-s3c2410/include/mach/map.h
@@ -111,6 +111,7 @@
 #define S3C_PA_USBHOST	S3C2410_PA_USBHOST
 #define S3C_PA_HSMMC0	    S3C2443_PA_HSMMC
 #define S3C_PA_HSMMC1	    S3C2416_PA_HSMMC0
+#define S3C_PA_WDT	    S3C2410_PA_WATCHDOG
 #define S3C_PA_NAND	    S3C24XX_PA_NAND
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 5858373..452e184 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -234,32 +234,6 @@ void __init s3c24xx_udc_set_platdata(struct s3c2410_udc_mach_info *pd)
 	}
 }
 
-
-/* Watchdog */
-
-static struct resource s3c_wdt_resource[] = {
-	[0] = {
-		.start = S3C24XX_PA_WATCHDOG,
-		.end   = S3C24XX_PA_WATCHDOG + S3C24XX_SZ_WATCHDOG - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_WDT,
-		.end   = IRQ_WDT,
-		.flags = IORESOURCE_IRQ,
-	}
-
-};
-
-struct platform_device s3c_device_wdt = {
-	.name		  = "s3c2410-wdt",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c_wdt_resource),
-	.resource	  = s3c_wdt_resource,
-};
-
-EXPORT_SYMBOL(s3c_device_wdt);
-
 /* IIS */
 
 static struct resource s3c_iis_resource[] = {
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 287e6f7..72dae49 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -185,6 +185,12 @@ config S3C_DEV_USB_HSOTG
 	help
 	  Compile in platform device definition for USB high-speed OtG
 
+config S3C_DEV_WDT
+	bool
+	default y if ARCH_S3C2410
+	help
+	  Complie in platform device definition for Watchdog Timer
+
 config S3C_DEV_NAND
 	bool
 	help
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 0ad820a..0a92369 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
 obj-y				+= dev-uart.o
 obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
 obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
+obj-$(CONFIG_S3C_DEV_WDT)	+= dev-wdt.o
 obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
 
 # DMA support
diff --git a/arch/arm/plat-samsung/dev-wdt.c b/arch/arm/plat-samsung/dev-wdt.c
new file mode 100644
index 0000000..5efca87
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-wdt.c
@@ -0,0 +1,40 @@
+/* linux/arch/arm/plat-samsung/dev-wdt.c
+ *
+ * Copyright (c) 2004 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C series device definition for the watchdog timer
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+#include <plat/devs.h>
+
+static struct resource s3c_wdt_resource[] = {
+	[0] = {
+		.start	= S3C_PA_WDT,
+		.end	= S3C_PA_WDT + SZ_1M - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_WDT,
+		.end	= IRQ_WDT,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+struct platform_device s3c_device_wdt = {
+	.name		= "s3c2410-wdt",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_wdt_resource),
+	.resource	= s3c_wdt_resource,
+};
+EXPORT_SYMBOL(s3c_device_wdt);
-- 
1.6.5.2
