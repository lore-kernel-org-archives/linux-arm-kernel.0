From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Thu, 23 Feb 2012 15:35:59 +0100
Subject: [PATCH v2] ARM: S3C24XX: Move s3c2443-clock.c to mach-s3c24xx
In-Reply-To: <201202221828.53363.heiko@sntech.de>
References: <201202212221.41744.heiko@sntech.de>
 <201202221718.01137.arnd@arndb.de> <201202221828.53363.heiko@sntech.de>
Message-ID: <201202231536.00015.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S3C-SoCs starting with the S3C2443 can share a lot of functionality.
The file can collect more common code of these SocS later on and
therefore gets a new name to reflect this future purpose.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
for completenes sake, the patch with -M format

 arch/arm/mach-s3c24xx/Kconfig                      |   14 ++++++++++++--
 arch/arm/mach-s3c24xx/Makefile                     |    4 ++++
 .../common-s3c2443.c}                              |   17 +++++++++++++----
 arch/arm/plat-s3c24xx/Kconfig                      |    6 ------
 arch/arm/plat-s3c24xx/Makefile                     |    1 -
 5 files changed, 29 insertions(+), 13 deletions(-)
 rename arch/arm/{plat-s3c24xx/s3c2443-clock.c => mach-s3c24xx/common-s3c2443.c} (95%)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index e537577..506d55b 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -41,7 +41,7 @@ config CPU_S3C2416
 	select CPU_ARM926T
 	select CPU_LLSERIAL_S3C2440
 	select SAMSUNG_CLKSRC
-	select S3C2443_CLOCK
+	select S3C2443_COMMON
 	select S3C2416_DMA if S3C24XX_DMA
 	select S3C2416_PM if PM
 	help
@@ -76,7 +76,7 @@ config CPU_S3C2443
 	select CPU_ARM920T
 	select CPU_LLSERIAL_S3C2440
 	select SAMSUNG_CLKSRC
-	select S3C2443_CLOCK
+	select S3C2443_COMMON
 	select S3C2443_DMA if S3C24XX_DMA
 	help
 	  Support for the S3C2443 SoC from the S3C24XX line
@@ -470,6 +470,16 @@ config SMDK2440_CPU2442
 
 endif	# CPU_S3C2440
 
+if CPU_S3C2443 || CPU_S3C2416
+
+config S3C2443_COMMON
+	bool
+	help
+	  Common code for the S3C2443 and similar processors, which includes
+	  the S3C2416 and S3C2450.
+
+endif	# CPU_S3C2443 || CPU_S3C2416
+
 if CPU_S3C2443
 
 config S3C2443_DMA
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 08b44a3..876e5e5 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -34,6 +34,10 @@ obj-$(CONFIG_S3C2440_DMA)	+= dma-s3c2440.o
 obj-$(CONFIG_CPU_S3C2443)	+= s3c2443.o irq-s3c2443.o clock-s3c2443.o
 obj-$(CONFIG_S3C2443_DMA)	+= dma-s3c2443.o
 
+# common code
+
+obj-$(CONFIG_S3C2443_COMMON)	+= common-s3c2443.o
+
 #
 # machine support
 # following is ordered alphabetically by option text.
diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/mach-s3c24xx/common-s3c2443.c
similarity index 95%
rename from arch/arm/plat-s3c24xx/s3c2443-clock.c
rename to arch/arm/mach-s3c24xx/common-s3c2443.c
index 3633060..2745616 100644
--- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
+++ b/arch/arm/mach-s3c24xx/common-s3c2443.c
@@ -1,9 +1,18 @@
-/* linux/arch/arm/plat-s3c24xx/s3c2443-clock.c
+/*
+ * Common code for SoCs starting with the S3C2443
  *
  * Copyright (c) 2007, 2010 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
- * S3C2443 Clock control suport - common code
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  */
 
 #include <linux/init.h>
@@ -552,7 +561,7 @@ void __init_or_cpufreq s3c2443_common_setup_clocks(pll_fn get_mpll)
 	s3c24xx_setup_clocks(fclk, hclk, pclk);
 
 	printk("CPU: MPLL %s %ld.%03ld MHz, cpu %ld.%03ld MHz, mem %ld.%03ld MHz, pclk %ld.%03ld MHz\n",
-	       (mpllcon & S3C2443_PLLCON_OFF) ? "off":"on",
+	       (mpllcon & S3C2443_PLLCON_OFF) ? "off" : "on",
 	       print_mhz(pll), print_mhz(fclk),
 	       print_mhz(hclk), print_mhz(pclk));
 
@@ -567,7 +576,7 @@ void __init_or_cpufreq s3c2443_common_setup_clocks(pll_fn get_mpll)
 	}
 
 	printk("CPU: EPLL %s %ld.%03ld MHz, usb-bus %ld.%03ld MHz\n",
-	       (epllcon & S3C2443_PLLCON_OFF) ? "off":"on",
+	       (epllcon & S3C2443_PLLCON_OFF) ? "off" : "on",
 	       print_mhz(clk_get_rate(&clk_epll)),
 	       print_mhz(clk_get_rate(&clk_usb_bus)));
 }
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index 0c183fd..74f76e0 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -44,12 +44,6 @@ config S3C2410_CLOCK
 	  Clock code for the S3C2410, and similar processors which
 	  is currently includes the S3C2410, S3C2440, S3C2442.
 
-config S3C2443_CLOCK
-	bool
-	help
-	  Clock code for the S3C2443 and similar processors, which includes
-	  the S3C2416 and S3C2450.
-
 config S3C24XX_DCLK
 	bool
 	help
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index bce27ca..a7e8843 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -28,7 +28,6 @@ obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_PM)		+= irq-pm.o
 obj-$(CONFIG_PM)		+= sleep.o
 obj-$(CONFIG_S3C2410_CLOCK)	+= s3c2410-clock.o
-obj-$(CONFIG_S3C2443_CLOCK)	+= s3c2443-clock.o
 obj-$(CONFIG_S3C24XX_DMA)	+= dma.o
 obj-$(CONFIG_S3C2410_IOTIMING)	+= s3c2410-iotiming.o
 obj-$(CONFIG_S3C2412_IOTIMING)	+= s3c2412-iotiming.o
-- 
1.7.5.4
