From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 6 Mar 2012 10:59:44 +0100
Subject: [PATCH 3/4] ARM: S3C24XX: Consolidate Simtec extensions
In-Reply-To: <201203061057.15815.heiko@sntech.de>
References: <201203061057.15815.heiko@sntech.de>
Message-ID: <201203061059.44955.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Simtec extension didn't follow a specific naming scheme for files
and config options until now. This distributed the files throughout
the whole mach-s3c24xx directory.

This patch fixes the naming of files and option names and also creates
a simtec.h header instead of using many one-liners.

As the plat/audio-simtec.h only contains the platform-data struct now,
it can also move to include/sound in a later patch.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Kconfig                      |   13 ++++++++++---
 arch/arm/mach-s3c24xx/Makefile                     |    7 ++++---
 arch/arm/mach-s3c24xx/mach-anubis.c                |    1 +
 arch/arm/mach-s3c24xx/mach-bast.c                  |    3 +--
 arch/arm/mach-s3c24xx/mach-vr1000.c                |    3 +--
 arch/arm/mach-s3c24xx/simtec-audio.c               |    2 ++
 .../mach-s3c24xx/{nor-simtec.c => simtec-nor.c}    |    2 +-
 .../mach-s3c24xx/{usb-simtec.c => simtec-usb.c}    |    2 +-
 arch/arm/mach-s3c24xx/{nor-simtec.h => simtec.h}   |    9 ++++++++-
 arch/arm/mach-s3c24xx/usb-simtec.h                 |   16 ----------------
 arch/arm/plat-samsung/include/plat/audio-simtec.h  |    3 ---
 11 files changed, 29 insertions(+), 32 deletions(-)
 rename arch/arm/mach-s3c24xx/{nor-simtec.c => simtec-nor.c} (98%)
 rename arch/arm/mach-s3c24xx/{usb-simtec.c => simtec-usb.c} (99%)
 rename arch/arm/mach-s3c24xx/{nor-simtec.h => simtec.h} (63%)
 delete mode 100644 arch/arm/mach-s3c24xx/usb-simtec.h

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 115cc50..df6f419 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -101,6 +101,11 @@ config S3C24XX_SIMTEC_PM
 	  Common power management code for systems that are
 	  compatible with the Simtec style of power management
 
+config S3C24XX_SIMTEC_USB
+	bool
+	help
+	  USB management code for common Simtec S3C24XX boards
+
 # cpu-specific sections
 
 if CPU_S3C2410
@@ -117,7 +122,7 @@ config S3C2410_PM
 	help
 	  Power Management code common to S3C2410 and better
 
-config SIMTEC_NOR
+config S3C24XX_SIMTEC_NOR
 	bool
 	help
 	  Internal node to specify machine has simtec NOR mapping
@@ -148,7 +153,8 @@ config ARCH_BAST
 	bool "Simtec Electronics BAST (EB2410ITX)"
 	select S3C2410_IOTIMING if S3C2410_CPUFREQ
 	select S3C24XX_SIMTEC_PM if PM
-	select SIMTEC_NOR
+	select S3C24XX_SIMTEC_NOR
+	select S3C24XX_SIMTEC_USB
 	select MACH_BAST_IDE
 	select S3C24XX_DCLK
 	select ISA
@@ -230,9 +236,10 @@ config MACH_VR1000
 	bool "Thorcom VR1000"
 	select S3C24XX_SIMTEC_PM if PM
 	select S3C24XX_DCLK
-	select SIMTEC_NOR
+	select S3C24XX_SIMTEC_NOR
 	select MACH_BAST_IDE
 	select S3C_DEV_USB_HOST
+	select S3C24XX_SIMTEC_USB
 	help
 	  Say Y here if you are using the Thorcom VR1000 board.
 
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index fedbdb8..2843c81 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -44,7 +44,7 @@ obj-$(CONFIG_S3C2443_COMMON)	+= common-s3c2443.o
 #
 
 obj-$(CONFIG_MACH_AML_M5900)		+= mach-amlm5900.o
-obj-$(CONFIG_ARCH_BAST)			+= mach-bast.o usb-simtec.o
+obj-$(CONFIG_ARCH_BAST)			+= mach-bast.o
 obj-$(CONFIG_BAST_PC104_IRQ)		+= bast-irq.o
 obj-$(CONFIG_ARCH_H1940)		+= mach-h1940.o
 obj-$(CONFIG_H1940BT)			+= h1940-bluetooth.o
@@ -54,7 +54,7 @@ obj-$(CONFIG_MACH_OTOM)			+= mach-otom.o
 obj-$(CONFIG_MACH_QT2410)		+= mach-qt2410.o
 obj-$(CONFIG_ARCH_SMDK2410)		+= mach-smdk2410.o
 obj-$(CONFIG_MACH_TCT_HAMMER)		+= mach-tct_hammer.o
-obj-$(CONFIG_MACH_VR1000)		+= mach-vr1000.o usb-simtec.o
+obj-$(CONFIG_MACH_VR1000)		+= mach-vr1000.o
 
 obj-$(CONFIG_MACH_JIVE)			+= mach-jive.o
 obj-$(CONFIG_MACH_SMDK2413)		+= mach-smdk2413.o
@@ -78,9 +78,10 @@ obj-$(CONFIG_MACH_SMDK2443)		+= mach-smdk2443.o
 # common bits of machine support
 
 obj-$(CONFIG_S3C24XX_SMDK)		+= common-smdk.o
-obj-$(CONFIG_SIMTEC_NOR)		+= nor-simtec.o
 obj-$(CONFIG_S3C24XX_SIMTEC_AUDIO)	+= simtec-audio.o
+obj-$(CONFIG_S3C24XX_SIMTEC_NOR)	+= simtec-nor.o
 obj-$(CONFIG_S3C24XX_SIMTEC_PM)		+= simtec-pm.o
+obj-$(CONFIG_S3C24XX_SIMTEC_USB)	+= simtec-usb.o
 
 # machine additions
 
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index 2456955..9e0f745 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -55,6 +55,7 @@
 #include <plat/cpu.h>
 #include <plat/audio-simtec.h>
 
+#include "simtec.h"
 #include "common.h"
 
 #define COPYRIGHT ", Copyright 2005-2009 Simtec Electronics"
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index feeaf73..53219c0 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -64,8 +64,7 @@
 #include <plat/gpio-cfg.h>
 #include <plat/audio-simtec.h>
 
-#include "usb-simtec.h"
-#include "nor-simtec.h"
+#include "simtec.h"
 #include "common.h"
 
 #define COPYRIGHT ", Copyright 2004-2008 Simtec Electronics"
diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
index dbe668a..87608d4 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c24xx/mach-vr1000.c
@@ -51,8 +51,7 @@
 #include <plat/iic.h>
 #include <plat/audio-simtec.h>
 
-#include "usb-simtec.h"
-#include "nor-simtec.h"
+#include "simtec.h"
 #include "common.h"
 
 /* macros for virtual address mods for the io space entries */
diff --git a/arch/arm/mach-s3c24xx/simtec-audio.c b/arch/arm/mach-s3c24xx/simtec-audio.c
index 6bc832e..11881c9 100644
--- a/arch/arm/mach-s3c24xx/simtec-audio.c
+++ b/arch/arm/mach-s3c24xx/simtec-audio.c
@@ -27,6 +27,8 @@
 #include <plat/audio-simtec.h>
 #include <plat/devs.h>
 
+#include "simtec.h"
+
 /* platform ops for audio */
 
 static void simtec_audio_startup_lrroute(void)
diff --git a/arch/arm/mach-s3c24xx/nor-simtec.c b/arch/arm/mach-s3c24xx/simtec-nor.c
similarity index 98%
rename from arch/arm/mach-s3c24xx/nor-simtec.c
rename to arch/arm/mach-s3c24xx/simtec-nor.c
index ad9f750..2119ca6 100644
--- a/arch/arm/mach-s3c24xx/nor-simtec.c
+++ b/arch/arm/mach-s3c24xx/simtec-nor.c
@@ -30,7 +30,7 @@
 #include <mach/bast-map.h>
 #include <mach/bast-cpld.h>
 
-#include "nor-simtec.h"
+#include "simtec.h"
 
 static void simtec_nor_vpp(struct platform_device *pdev, int vpp)
 {
diff --git a/arch/arm/mach-s3c24xx/usb-simtec.c b/arch/arm/mach-s3c24xx/simtec-usb.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/usb-simtec.c
rename to arch/arm/mach-s3c24xx/simtec-usb.c
index 29bd3d9..d91c1a7 100644
--- a/arch/arm/mach-s3c24xx/usb-simtec.c
+++ b/arch/arm/mach-s3c24xx/simtec-usb.c
@@ -37,7 +37,7 @@
 #include <plat/usb-control.h>
 #include <plat/devs.h>
 
-#include "usb-simtec.h"
+#include "simtec.h"
 
 /* control power and monitor over-current events on various Simtec
  * designed boards.
diff --git a/arch/arm/mach-s3c24xx/nor-simtec.h b/arch/arm/mach-s3c24xx/simtec.h
similarity index 63%
rename from arch/arm/mach-s3c24xx/nor-simtec.h
rename to arch/arm/mach-s3c24xx/simtec.h
index f619c1e..ae8f4f9 100644
--- a/arch/arm/mach-s3c24xx/nor-simtec.h
+++ b/arch/arm/mach-s3c24xx/simtec.h
@@ -4,11 +4,18 @@
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
  *
- * Simtec NOR mapping
+ * Simtec common functions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
 
+struct s3c24xx_audio_simtec_pdata;
+
 extern void nor_simtec_init(void);
+
+extern int usb_simtec_init(void);
+
+extern int simtec_audio_add(const char *codec_name, bool has_lr_routing,
+			    struct s3c24xx_audio_simtec_pdata *pdata);
diff --git a/arch/arm/mach-s3c24xx/usb-simtec.h b/arch/arm/mach-s3c24xx/usb-simtec.h
deleted file mode 100644
index 03842ed..0000000
--- a/arch/arm/mach-s3c24xx/usb-simtec.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* linux/arch/arm/mach-s3c2410/usb-simtec.h
- *
- * Copyright (c) 2004 Simtec Electronics
- *   Ben Dooks <ben@simtec.co.uk>
- *
- * http://www.simtec.co.uk/products/EB2410ITX/
- *
- * Simtec BAST and Thorcom VR1000 USB port support functions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-extern int usb_simtec_init(void);
-
diff --git a/arch/arm/plat-samsung/include/plat/audio-simtec.h b/arch/arm/plat-samsung/include/plat/audio-simtec.h
index 5345364..376af52 100644
--- a/arch/arm/plat-samsung/include/plat/audio-simtec.h
+++ b/arch/arm/plat-samsung/include/plat/audio-simtec.h
@@ -32,6 +32,3 @@ struct s3c24xx_audio_simtec_pdata {
 
 	void	(*startup)(void);
 };
-
-extern int simtec_audio_add(const char *codec_name, bool has_lr_routing,
-			    struct s3c24xx_audio_simtec_pdata *pdata);
-- 
1.7.5.4
