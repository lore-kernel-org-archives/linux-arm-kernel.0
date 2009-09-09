From: laforge@gnumonks.org (laforge at gnumonks.org)
Date: Wed,  9 Sep 2009 20:04:44 +0900
Subject: [PATCH 1/3] [ARM] s3c: move watchdog dev from plat-24xx into plat-s3c
Message-ID: <1252494284-6459-1-git-send-email-laforge@gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Harald Welte <laforge@gnumonks.org>

This change ensures that machines based on s3c64xx SoC's can
also use the watchdog device.

Signed-off-by: Harald Welte <laforge@gnumonks.org>
---
 arch/arm/mach-s3c2410/include/mach/map.h |    1 +
 arch/arm/mach-s3c6400/include/mach/map.h |    1 +
 arch/arm/plat-s3c/Makefile               |    1 +
 arch/arm/plat-s3c/dev-wdt.c              |   46 ++++++++++++++++++++++++++++++
 arch/arm/plat-s3c24xx/devs.c             |   25 ----------------
 5 files changed, 49 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/plat-s3c/dev-wdt.c

diff --git a/arch/arm/mach-s3c2410/include/mach/map.h b/arch/arm/mach-s3c2410/include/mach/map.h
index e99b212..6f0b73e 100644
--- a/arch/arm/mach-s3c2410/include/mach/map.h
+++ b/arch/arm/mach-s3c2410/include/mach/map.h
@@ -103,5 +103,6 @@
 #define S3C_PA_UART	    S3C24XX_PA_UART
 #define S3C_PA_USBHOST	S3C2410_PA_USBHOST
 #define S3C_PA_HSMMC0	    S3C2443_PA_HSMMC
+#define S3C_PA_WATCHDOG	    S3C24XX_PA_WATCHDOG
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s3c6400/include/mach/map.h b/arch/arm/mach-s3c6400/include/mach/map.h
index 5057d99..7e2c88d 100644
--- a/arch/arm/mach-s3c6400/include/mach/map.h
+++ b/arch/arm/mach-s3c6400/include/mach/map.h
@@ -75,5 +75,6 @@
 #define S3C_PA_FB		S3C64XX_PA_FB
 #define S3C_PA_USBHOST		S3C64XX_PA_USBHOST
 #define S3C_PA_USB_HSOTG	S3C64XX_PA_USB_HSOTG
+#define S3C_PA_WATCHDOG		S3C64XX_PA_WATCHDOG
 
 #endif /* __ASM_ARCH_6400_MAP_H */
diff --git a/arch/arm/plat-s3c/Makefile b/arch/arm/plat-s3c/Makefile
index 0761766..8505a17 100644
--- a/arch/arm/plat-s3c/Makefile
+++ b/arch/arm/plat-s3c/Makefile
@@ -38,3 +38,4 @@ obj-$(CONFIG_SND_S3C64XX_SOC_I2S)	+= dev-audio.o
 obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
 obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
 obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
+obj-y				+= dev-wdt.o
diff --git a/arch/arm/plat-s3c/dev-wdt.c b/arch/arm/plat-s3c/dev-wdt.c
new file mode 100644
index 0000000..9aa36aa
--- /dev/null
+++ b/arch/arm/plat-s3c/dev-wdt.c
@@ -0,0 +1,45 @@
+/* linux/arch/arm/plat-s3c/dev-wdt.c
+ *
+ * Copyright 2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * S3C series device definition for the watchdog timer
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
+#include <plat/devs.h>
+
+/* Watchdog */
+
+static struct resource s3c_wdt_resource[] = {
+	[0] = {
+		.start = S3C_PA_WATCHDOG,
+		.end   = S3C_PA_WATCHDOG + SZ_1M - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_WDT,
+		.end   = IRQ_WDT,
+		.flags = IORESOURCE_IRQ,
+	}
+
+};
+
+struct platform_device s3c_device_wdt = {
+	.name		  = "s3c2410-wdt",
+	.id		  = -1,
+	.num_resources	  = ARRAY_SIZE(s3c_wdt_resource),
+	.resource	  = s3c_wdt_resource,
+};
+EXPORT_SYMBOL(s3c_device_wdt);
diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 4eb378c..068e9ce 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -238,31 +238,6 @@ void __init s3c24xx_udc_set_platdata(struct s3c2410_udc_mach_info *pd)
 }
 
 
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
-- 
1.5.3.4
