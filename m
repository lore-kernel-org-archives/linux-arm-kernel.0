From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 14 Jun 2013 21:32:39 +0200
Subject: [PATCH 03/28] ARM: SAMSUNG: Introduce SAMSUNG_ATAGS Kconfig entry
In-Reply-To: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
References: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371238384-1504-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a Kconfig entry that enables compilation of legacy
support code required for Samsung platforms that require ATAGS based
boot.

This allows to bypass compilation of this code when platforms without
ATAGS support are selected.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/Kconfig               |  6 ++++++
 arch/arm/plat-samsung/Kconfig  | 26 +++++++++++++++++++++-----
 arch/arm/plat-samsung/Makefile |  6 +++---
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a29fc7e..ae7247d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -702,6 +702,7 @@ config ARCH_S3C24XX
 	select MULTI_IRQ_HANDLER
 	select NEED_MACH_GPIO_H
 	select NEED_MACH_IO_H
+	select SAMSUNG_ATAGS
 	help
 	  Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443
 	  and S3C2450 SoCs based systems, such as the Simtec Electronics BAST
@@ -726,6 +727,7 @@ config ARCH_S3C64XX
 	select PLAT_SAMSUNG
 	select S3C_DEV_NAND
 	select S3C_GPIO_TRACK
+	select SAMSUNG_ATAGS
 	select SAMSUNG_CLKSRC
 	select SAMSUNG_GPIOLIB_4BIT
 	select SAMSUNG_IRQ_VIC_TIMER
@@ -744,6 +746,7 @@ config ARCH_S5P64X0
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
+	select SAMSUNG_ATAGS
 	help
 	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
 	  SMDK6450.
@@ -760,6 +763,7 @@ config ARCH_S5PC100
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
+	select SAMSUNG_ATAGS
 	help
 	  Samsung S5PC100 series based systems
 
@@ -778,6 +782,7 @@ config ARCH_S5PV210
 	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
+	select SAMSUNG_ATAGS
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
@@ -796,6 +801,7 @@ config ARCH_EXYNOS
 	select HAVE_S3C_RTC if RTC_CLASS
 	select NEED_MACH_GPIO_H
 	select NEED_MACH_MEMORY_H
+	select SAMSUNG_ATAGS
 	select USE_OF
 	help
 	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index f8ed2de..c0f0542 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -60,6 +60,20 @@ config S3C_LOWLEVEL_UART_PORT
 	  this configuration should be between zero and two. The port
 	  must have been initialised by the boot-loader before use.
 
+config SAMSUNG_ATAGS
+	def_bool n
+	depends on !ARCH_MULTIPLATFORM
+	depends on ATAGS
+	help
+	   This option enables ATAGS based boot support code for
+	   Samsung platforms, including static platform devices, legacy
+	   clock, timer and interrupt initialization, etc.
+
+	   Platforms that support only DT based boot need not to select
+	   this option.
+
+if SAMSUNG_ATAGS
+
 # timer options
 
 config SAMSUNG_HRT
@@ -367,11 +381,6 @@ config S5P_DEV_JPEG
 	help
 	  Compile in platform device definitions for JPEG codec
 
-config S5P_DEV_MFC
-	bool
-	help
-	  Compile in setup memory (init) code for MFC
-
 config S5P_DEV_ONENAND
 	bool
 	help
@@ -412,6 +421,8 @@ config S3C_DMA
 	help
 	  Internal configuration for S3C DMA core
 
+endif
+
 config SAMSUNG_DMADEV
 	bool
 	select ARM_AMBA
@@ -421,6 +432,11 @@ config SAMSUNG_DMADEV
 	help
 	  Use DMA device engine for PL330 DMAC.
 
+config S5P_DEV_MFC
+	bool
+	help
+	  Compile in setup memory (init) code for MFC
+
 comment "Power management"
 
 config SAMSUNG_PM_DEBUG
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index a23c460..b549ea9 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -31,10 +31,10 @@ obj-$(CONFIG_S3C_ADC)	+= adc.o
 
 # devices
 
-obj-y				+= platformdata.o
+obj-$(CONFIG_SAMSUNG_ATAGS)	+= platformdata.o
 
-obj-y				+= devs.o
-obj-y				+= dev-uart.o
+obj-$(CONFIG_SAMSUNG_ATAGS)	+= devs.o
+obj-$(CONFIG_SAMSUNG_ATAGS)	+= dev-uart.o
 obj-$(CONFIG_S5P_DEV_MFC)	+= s5p-dev-mfc.o
 obj-$(CONFIG_S5P_DEV_UART)	+= s5p-dev-uart.o
 
-- 
1.8.2.1
