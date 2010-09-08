From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  8 Sep 2010 20:06:21 +0900
Subject: [PATCH v3 02/13] ARM: S5P64X0: Update Kconfig and Makefile
Message-ID: <1283943981-6778-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the Kconfig and Makefile for the S5P6440 and S5P6450
machines. It also updates arch/arm/ Kconfig and Makefile to include for
support ARCH_S5P64X0 with one kernel image.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v2:
- Added selection S3C64XX_DEV_SPI on SMDK6440 and SMDK6450

Changes since v1:
- Added missing selections HAVE_S3C2410_WATCHDOG, _I2C, and _RTC

 arch/arm/Kconfig                                   |   13 +++--
 arch/arm/Makefile                                  |    2 +-
 arch/arm/mach-s5p6440/Kconfig                      |   33 -----------
 arch/arm/mach-s5p6440/Makefile                     |   25 ---------
 arch/arm/mach-s5p64x0/Kconfig                      |   57 ++++++++++++++++++++
 arch/arm/mach-s5p64x0/Makefile                     |   30 ++++++++++
 .../{mach-s5p6440 => mach-s5p64x0}/Makefile.boot   |    0
 arch/arm/plat-s5p/Kconfig                          |    4 +-
 8 files changed, 97 insertions(+), 67 deletions(-)
 delete mode 100644 arch/arm/mach-s5p6440/Kconfig
 delete mode 100644 arch/arm/mach-s5p6440/Makefile
 create mode 100644 arch/arm/mach-s5p64x0/Kconfig
 create mode 100644 arch/arm/mach-s5p64x0/Makefile
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/Makefile.boot (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7ed21f..626489b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -679,8 +679,8 @@ config ARCH_S3C64XX
 	help
 	  Samsung S3C64XX series based systems
 
-config ARCH_S5P6440
-	bool "Samsung S5P6440"
+config ARCH_S5P64X0
+	bool "Samsung S5P6440 S5P6450"
 	select CPU_V6
 	select GENERIC_GPIO
 	select HAVE_CLK
@@ -689,7 +689,8 @@ config ARCH_S5P6440
 	select HAVE_S3C2410_I2C
 	select HAVE_S3C_RTC
 	help
-	  Samsung S5P6440 CPU based systems
+	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
+	  SMDK6450.
 
 config ARCH_S5P6442
 	bool "Samsung S5P6442"
@@ -929,7 +930,7 @@ if ARCH_S3C64XX
 source "arch/arm/mach-s3c64xx/Kconfig"
 endif
 
-source "arch/arm/mach-s5p6440/Kconfig"
+source "arch/arm/mach-s5p64x0/Kconfig"
 
 source "arch/arm/mach-s5p6442/Kconfig"
 
@@ -1232,7 +1233,7 @@ source kernel/Kconfig.preempt
 
 config HZ
 	int
-	default 200 if ARCH_EBSA110 || ARCH_S3C2410 || ARCH_S5P6440 || \
+	default 200 if ARCH_EBSA110 || ARCH_S3C2410 || ARCH_S5P64X0 || \
 		ARCH_S5P6442 || ARCH_S5PV210 || ARCH_S5PV310
 	default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
 	default AT91_TIMER_HZ if ARCH_AT91
@@ -1609,7 +1610,7 @@ config ZRELADDR
 	default 0x10008000 if ARCH_MSM ||\
 		ARCH_OMAP1 ||\
 		ARCH_RPC
-	default 0x20008000 if ARCH_S5P6440 ||\
+	default 0x20008000 if ARCH_S5P64X0 ||\
 		ARCH_S5P6442 ||\
 		ARCH_S5PC100 ||\
 		ARCH_S5PV210
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 59c1ce8..8420f21 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -173,7 +173,7 @@ machine-$(CONFIG_ARCH_RPC)		:= rpc
 machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2400 s3c2412 s3c2416 s3c2440 s3c2443
 machine-$(CONFIG_ARCH_S3C24A0)		:= s3c24a0
 machine-$(CONFIG_ARCH_S3C64XX)		:= s3c64xx
-machine-$(CONFIG_ARCH_S5P6440)		:= s5p6440
+machine-$(CONFIG_ARCH_S5P64X0)		:= s5p64x0
 machine-$(CONFIG_ARCH_S5P6442)		:= s5p6442
 machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
 machine-$(CONFIG_ARCH_S5PV210)		:= s5pv210
diff --git a/arch/arm/mach-s5p6440/Kconfig b/arch/arm/mach-s5p6440/Kconfig
deleted file mode 100644
index 6a4af7f..0000000
--- a/arch/arm/mach-s5p6440/Kconfig
+++ /dev/null
@@ -1,33 +0,0 @@
-# arch/arm/mach-s5p6440/Kconfig
-#
-# Copyright (c) 2009 Samsung Electronics Co., Ltd.
-#		http://www.samsung.com/
-#
-# Licensed under GPLv2
-
-if ARCH_S5P6440
-
-config CPU_S5P6440
-	bool
-	select S3C_PL330_DMA
-	help
-	  Enable S5P6440 CPU support
-
-config S5P6440_SETUP_I2C1
-	bool
-	help
-	  Common setup code for i2c bus 1.
-
-config MACH_SMDK6440
-	bool "SMDK6440"
-	select CPU_S5P6440
-	select S3C_DEV_I2C1
-	select S3C_DEV_RTC
-	select S3C_DEV_WDT
-	select SAMSUNG_DEV_ADC
-	select SAMSUNG_DEV_TS
-	select S5P6440_SETUP_I2C1
-	help
-	  Machine support for the Samsung SMDK6440
-
-endif
diff --git a/arch/arm/mach-s5p6440/Makefile b/arch/arm/mach-s5p6440/Makefile
deleted file mode 100644
index c3fe4d3..0000000
--- a/arch/arm/mach-s5p6440/Makefile
+++ /dev/null
@@ -1,25 +0,0 @@
-# arch/arm/mach-s5p6440/Makefile
-#
-# Copyright (c) 2009 Samsung Electronics Co., Ltd.
-# 		http://www.samsung.com/
-#
-# Licensed under GPLv2
-
-obj-y				:=
-obj-m				:=
-obj-n				:=
-obj-				:=
-
-# Core support for S5P6440 system
-
-obj-$(CONFIG_CPU_S5P6440)	+= cpu.o init.o clock.o gpio.o dma.o
-obj-$(CONFIG_CPU_S5P6440)	+= setup-i2c0.o
-
-# machine support
-
-obj-$(CONFIG_MACH_SMDK6440)	+= mach-smdk6440.o
-
-# device support
-obj-y				+= dev-audio.o
-obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
-obj-$(CONFIG_S5P6440_SETUP_I2C1)	+= setup-i2c1.o
diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
new file mode 100644
index 0000000..fbcae93
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -0,0 +1,57 @@
+# arch/arm/mach-s5p64x0/Kconfig
+#
+# Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+#		http://www.samsung.com/
+#
+# Licensed under GPLv2
+
+if ARCH_S5P64X0
+
+config CPU_S5P6440
+	bool
+	select PLAT_S5P
+	select S3C_PL330_DMA
+	help
+	  Enable S5P6440 CPU support
+
+config CPU_S5P6450
+	bool
+	select PLAT_S5P
+	select S3C_PL330_DMA
+	help
+	  Enable S5P6450 CPU support
+
+config S5P64X0_SETUP_I2C1
+	bool
+	help
+	  Common setup code for i2c bus 1.
+
+# machine support
+
+config MACH_SMDK6440
+	bool "SMDK6440"
+	select CPU_S5P6440
+	select S3C_DEV_I2C1
+	select S3C_DEV_RTC
+	select S3C_DEV_WDT
+	select S3C64XX_DEV_SPI
+	select SAMSUNG_DEV_ADC
+	select SAMSUNG_DEV_TS
+	select S5P64X0_SETUP_I2C1
+	help
+	  Machine support for the Samsung SMDK6440
+
+config MACH_SMDK6450
+	bool "SMDK6450"
+	select CPU_S5P6450
+	select S3C_DEV_I2C1
+	select S3C_DEV_RTC
+	select S3C_DEV_WDT
+	select S3C64XX_DEV_SPI
+	select SAMSUNG_DEV_ADC
+	select SAMSUNG_DEV_TS
+	select S5P64X0_SETUP_I2C1
+	help
+	  Machine support for the Samsung SMDK6450
+
+endif
diff --git a/arch/arm/mach-s5p64x0/Makefile b/arch/arm/mach-s5p64x0/Makefile
new file mode 100644
index 0000000..2655829
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/Makefile
@@ -0,0 +1,30 @@
+# arch/arm/mach-s5p64x0/Makefile
+#
+# Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+# 		http://www.samsung.com
+#
+# Licensed under GPLv2
+
+obj-y				:=
+obj-m				:=
+obj-n				:=
+obj-				:=
+
+# Core support for S5P64X0 system
+
+obj-$(CONFIG_ARCH_S5P64X0)	+= cpu.o init.o clock.o dma.o
+obj-$(CONFIG_ARCH_S5P64X0)	+= setup-i2c0.o
+obj-$(CONFIG_CPU_S5P6440)	+= clock-s5p6440.o gpio.o
+obj-$(CONFIG_CPU_S5P6450)	+= clock-s5p6450.o
+
+# machine support
+
+obj-$(CONFIG_MACH_SMDK6440)	+= mach-smdk6440.o
+obj-$(CONFIG_MACH_SMDK6450)	+= mach-smdk6450.o
+
+# device support
+
+obj-y				+= dev-audio.o
+obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
+
+obj-$(CONFIG_S5P64X0_SETUP_I2C1)	+= setup-i2c1.o
diff --git a/arch/arm/mach-s5p6440/Makefile.boot b/arch/arm/mach-s5p64x0/Makefile.boot
similarity index 100%
rename from arch/arm/mach-s5p6440/Makefile.boot
rename to arch/arm/mach-s5p64x0/Makefile.boot
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index c6a855d..90f97d6 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -7,7 +7,7 @@
 
 config PLAT_S5P
 	bool
-	depends on (ARCH_S5P6440 || ARCH_S5P6442 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5PV310)
+	depends on (ARCH_S5P64X0 || ARCH_S5P6442 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5PV310)
 	default y
 	select ARM_VIC if !ARCH_S5PV310
 	select ARM_GIC if ARCH_S5PV310
@@ -30,7 +30,7 @@ config S5P_EXT_INT
 	bool
 	help
 	  Use the external interrupts (other than GPIO interrupts.)
-	  Note: Do not choose this for S5P6440.
+	  Note: Do not choose this for S5P6440 and S5P6450.
 
 config S5P_DEV_FIMC0
 	bool
-- 
1.6.2.5
