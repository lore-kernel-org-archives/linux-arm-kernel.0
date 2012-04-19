From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Apr 2012 19:20:35 -0700
Subject: [PATCH 6/7] ARM: SAMSUNG: move setup code for s5p mfc and mipiphy
 into plat-samsung
In-Reply-To: <1334802036-16768-1-git-send-email-kgene.kim@samsung.com>
References: <1334802036-16768-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1334802036-16768-7-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s5p/Kconfig                          |   10 ----------
 arch/arm/plat-s5p/Makefile                         |    5 -----
 arch/arm/plat-samsung/Kconfig                      |   10 ++++++++++
 arch/arm/plat-samsung/Makefile                     |    3 +++
 .../dev-mfc.c => plat-samsung/s5p-dev-mfc.c}       |    4 +---
 .../arm/{plat-s5p => plat-samsung}/setup-mipiphy.c |    0
 6 files changed, 14 insertions(+), 18 deletions(-)
 rename arch/arm/{plat-s5p/dev-mfc.c => plat-samsung/s5p-dev-mfc.c} (97%)
 rename arch/arm/{plat-s5p => plat-samsung}/setup-mipiphy.c (100%)

diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 33d9bc8..4ff6d7e 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -63,11 +63,6 @@ config S5P_DEV_I2C_HDMIPHY
 	help
 	  Compile in platform device definitions for I2C HDMIPHY controller
 
-config S5P_DEV_MFC
-	bool
-	help
-	  Compile in platform device definitions for MFC
-
 config S5P_DEV_ONENAND
 	bool
 	help
@@ -92,8 +87,3 @@ config S5P_DEV_USB_EHCI
 	bool
 	help
 	  Compile in platform device definition for USB EHCI
-
-config S5P_SETUP_MIPIPHY
-	bool
-	help
-	  Compile in common setup code for MIPI-CSIS and MIPI-DSIM devices
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 1dc6b1c..884b9a1 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -9,8 +9,3 @@ obj-y				:=
 obj-m				:=
 obj-n				:= dummy.o
 obj-				:=
-
-# devices
-
-obj-$(CONFIG_S5P_DEV_MFC)	+= dev-mfc.o
-obj-$(CONFIG_S5P_SETUP_MIPIPHY)	+= setup-mipiphy.o
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 0f112a7..cfa62e8 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -309,6 +309,11 @@ config SAMSUNG_DEV_BACKLIGHT
 	help
 	  Compile in platform device definition LCD backlight with PWM Timer
 
+config S5P_DEV_MFC
+	bool
+	help
+	  Compile in setup memory (init) code for MFC
+
 config S3C24XX_PWM
 	bool "PWM device support"
 	select HAVE_PWM
@@ -316,6 +321,11 @@ config S3C24XX_PWM
 	  Support for exporting the PWM timer blocks via the pwm device
 	  system
 
+config S5P_SETUP_MIPIPHY
+	bool
+	help
+	  Compile in common setup code for MIPI-CSIS and MIPI-DSIM devices
+
 # DMA
 
 config S3C_DMA
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index b20047b..860b2db 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -36,10 +36,13 @@ obj-y				+= platformdata.o
 
 obj-y				+= devs.o
 obj-y				+= dev-uart.o
+obj-$(CONFIG_S5P_DEV_MFC)	+= s5p-dev-mfc.o
 obj-$(CONFIG_S5P_DEV_UART)	+= s5p-dev-uart.o
 
 obj-$(CONFIG_SAMSUNG_DEV_BACKLIGHT)	+= dev-backlight.o
 
+obj-$(CONFIG_S5P_SETUP_MIPIPHY)	+= setup-mipiphy.o
+
 # DMA support
 
 obj-$(CONFIG_S3C_DMA)		+= dma.o s3c-dma-ops.o
diff --git a/arch/arm/plat-s5p/dev-mfc.c b/arch/arm/plat-samsung/s5p-dev-mfc.c
similarity index 97%
rename from arch/arm/plat-s5p/dev-mfc.c
rename to arch/arm/plat-samsung/s5p-dev-mfc.c
index a30d36b..ad60894 100644
--- a/arch/arm/plat-s5p/dev-mfc.c
+++ b/arch/arm/plat-samsung/s5p-dev-mfc.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s5p/dev-mfc.c
- *
+/*
  * Copyright (C) 2010-2011 Samsung Electronics Co.Ltd
  *
  * Base S5P MFC resource and device definitions
@@ -9,7 +8,6 @@
  * published by the Free Software Foundation.
  */
 
-
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/plat-s5p/setup-mipiphy.c b/arch/arm/plat-samsung/setup-mipiphy.c
similarity index 100%
rename from arch/arm/plat-s5p/setup-mipiphy.c
rename to arch/arm/plat-samsung/setup-mipiphy.c
-- 
1.7.2.3
