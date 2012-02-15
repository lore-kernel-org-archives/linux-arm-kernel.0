From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 16 Feb 2012 07:55:44 +0900
Subject: [PATCH 10/12] ARM: S3C2440: move mach-s3c2440/* into mach-s3c24xx/
In-Reply-To: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
References: <1329346545-16373-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1329346545-16373-11-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves S3C2440 stuff into mach-s3c24xx/ directory
so that we can merge the s3c24 series' directories to the
just one mach-s3c24xx/ directory.

And this patch is including following.
- re-ordered alphabetically by option text at Kconfig and Makefile

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2440/Kconfig                      |  165 -------------------
 arch/arm/mach-s3c2440/Makefile                     |   26 +---
 arch/arm/mach-s3c2440/common.h                     |   17 --
 arch/arm/mach-s3c24xx/Kconfig                      |  169 +++++++++++++++++++-
 arch/arm/mach-s3c24xx/Makefile                     |   17 ++
 .../clock.c => mach-s3c24xx/clock-s3c2440.c}       |    0
 .../clock-s3c244x.c}                               |    0
 arch/arm/mach-s3c24xx/common.h                     |    6 +
 .../dma.c => mach-s3c24xx/dma-s3c2440.c}           |    0
 .../include/mach/gta02.h                           |    0
 .../irq.c => mach-s3c24xx/irq-s3c2440.c}           |    0
 .../s3c244x-irq.c => mach-s3c24xx/irq-s3c244x.c}   |    0
 .../{mach-s3c2440 => mach-s3c24xx}/mach-anubis.c   |    0
 .../mach-at2440evb.c                               |    0
 .../{mach-s3c2440 => mach-s3c24xx}/mach-gta02.c    |    0
 .../{mach-s3c2440 => mach-s3c24xx}/mach-mini2440.c |    0
 .../{mach-s3c2440 => mach-s3c24xx}/mach-nexcoder.c |    0
 .../mach-osiris-dvs.c                              |    0
 .../{mach-s3c2440 => mach-s3c24xx}/mach-osiris.c   |    0
 .../{mach-s3c2440 => mach-s3c24xx}/mach-rx1950.c   |    0
 .../{mach-s3c2440 => mach-s3c24xx}/mach-rx3715.c   |    0
 .../{mach-s3c2440 => mach-s3c24xx}/mach-smdk2440.c |    0
 arch/arm/{mach-s3c2440 => mach-s3c24xx}/s3c2440.c  |    0
 arch/arm/{mach-s3c2440 => mach-s3c24xx}/s3c2442.c  |    0
 arch/arm/{mach-s3c2440 => mach-s3c24xx}/s3c244x.c  |    0
 25 files changed, 191 insertions(+), 209 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2440/common.h
 rename arch/arm/{mach-s3c2440/clock.c => mach-s3c24xx/clock-s3c2440.c} (100%)
 rename arch/arm/{mach-s3c2440/s3c244x-clock.c => mach-s3c24xx/clock-s3c244x.c} (100%)
 rename arch/arm/{mach-s3c2440/dma.c => mach-s3c24xx/dma-s3c2440.c} (100%)
 rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/include/mach/gta02.h (100%)
 rename arch/arm/{mach-s3c2440/irq.c => mach-s3c24xx/irq-s3c2440.c} (100%)
 rename arch/arm/{mach-s3c2440/s3c244x-irq.c => mach-s3c24xx/irq-s3c244x.c} (100%)
 rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-anubis.c (100%)
 rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-at2440evb.c (100%)
 rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-gta02.c (100%)
 rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-mini2440.c (100%)
 rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-nexcoder.c (100%)
 rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-osiris-dvs.c (100%)
 rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-osiris.c (100%)
 rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-rx1950.c (100%)
 rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-rx3715.c (100%)
 rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/mach-smdk2440.c (100%)
 rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/s3c2440.c (100%)
 rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/s3c2442.c (100%)
 rename arch/arm/{mach-s3c2440 => mach-s3c24xx}/s3c244x.c (100%)

diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
index 914e620..ece7a10 100644
--- a/arch/arm/mach-s3c2440/Kconfig
+++ b/arch/arm/mach-s3c2440/Kconfig
@@ -2,35 +2,6 @@
 #
 # Licensed under GPLv2
 
-config CPU_S3C2440
-	bool
-	select CPU_ARM920T
-	select S3C2410_CLOCK
-	select S3C2410_PM if PM
-	select S3C2440_DMA if S3C2410_DMA
-	select CPU_S3C244X
-	select CPU_LLSERIAL_S3C2440
-	help
-	  Support for S3C2440 Samsung Mobile CPU based systems.
-
-config CPU_S3C2442
-	bool
-	select CPU_ARM920T
-	select S3C2410_CLOCK
-	select S3C2410_PM if PM
-	select CPU_S3C244X
-	select CPU_LLSERIAL_S3C2440
-	help
-	  Support for S3C2442 Samsung Mobile CPU based systems.
-
-config CPU_S3C244X
-	bool
-	depends on CPU_S3C2440 || CPU_S3C2442
-	help
-	  Support for S3C2440 and S3C2442 Samsung Mobile CPU based systems.
-
-
-
 config S3C2440_CPUFREQ
 	bool "S3C2440/S3C2442 CPU Frequency scaling support"
 	depends on CPU_FREQ_S3C24XX && (CPU_S3C2440 || CPU_S3C2442)
@@ -64,139 +35,3 @@ config S3C2440_PLL_16934400
 	default y if CPU_FREQ_S3C24XX_PLL
 	help
 	  PLL tables for S3C2440 or S3C2442 CPUs with 16.934MHz crystals.
-
-config S3C2440_DMA
-	bool
-	depends on CPU_S3C2440
-	help
-	  Support for S3C2440 specific DMA code5A
-
-menu "S3C2440 and S3C2442 Machines"
-
-config MACH_ANUBIS
-	bool "Simtec Electronics ANUBIS"
-	select CPU_S3C2440
-	select S3C24XX_DCLK
-	select PM_SIMTEC if PM
-	select HAVE_PATA_PLATFORM
-	select S3C24XX_GPIO_EXTRA64
-	select S3C2440_XTAL_12000000
-	select S3C_DEV_USB_HOST
-	help
-	  Say Y here if you are using the Simtec Electronics ANUBIS
-	  development system
-
-config MACH_NEO1973_GTA02
-	bool "Openmoko GTA02 / Freerunner phone"
-	select CPU_S3C2442
-	select MFD_PCF50633
-	select PCF50633_GPIO
-	select I2C
-	select POWER_SUPPLY
-	select MACH_NEO1973
-	select S3C2410_PWM
-	select S3C_DEV_USB_HOST
-	help
-	   Say Y here if you are using the Openmoko GTA02 / Freerunner GSM Phone
-
-config MACH_OSIRIS
-	bool "Simtec IM2440D20 (OSIRIS) module"
-	select CPU_S3C2440
-	select S3C24XX_DCLK
-	select PM_SIMTEC if PM
-	select S3C24XX_GPIO_EXTRA128
-	select S3C2440_XTAL_12000000
-	select S3C2410_IOTIMING if S3C2440_CPUFREQ
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_NAND
-	help
-	  Say Y here if you are using the Simtec IM2440D20 module, also
-	  known as the Osiris.
-
-config MACH_OSIRIS_DVS
-	tristate "Simtec IM2440D20 (OSIRIS) Dynamic Voltage Scaling driver"
-	depends on MACH_OSIRIS
-	select TPS65010
-	help
-	  Say Y/M here if you want to have dynamic voltage scaling support
-	  on the Simtec IM2440D20 (OSIRIS) module via the TPS65011.
-
-	  The DVS driver alters the voltage supplied to the ARM core
-	  depending on the frequency it is running at. The driver itself
-	  does not do any of the frequency alteration, which is left up
-	  to the cpufreq driver.
-
-config MACH_RX3715
-	bool "HP iPAQ rx3715"
-	select CPU_S3C2440
-	select S3C2440_XTAL_16934400
-	select PM_H1940 if PM
-	select S3C_DEV_NAND
-	help
-	  Say Y here if you are using the HP iPAQ rx3715.
-
-config ARCH_S3C2440
-	bool "SMDK2440"
-	select CPU_S3C2440
-	select S3C2440_XTAL_16934400
-	select MACH_SMDK
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_NAND
-	help
-	  Say Y here if you are using the SMDK2440.
-
-config MACH_NEXCODER_2440
- 	bool "NexVision NEXCODER 2440 Light Board"
- 	select CPU_S3C2440
-	select S3C2440_XTAL_12000000
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_NAND
-	help
- 	  Say Y here if you are using the Nex Vision NEXCODER 2440 Light Board
-
-config SMDK2440_CPU2440
-	bool "SMDK2440 with S3C2440 CPU module"
-	default y if ARCH_S3C2440
-	select S3C2440_XTAL_16934400
-	select CPU_S3C2440
-
-config SMDK2440_CPU2442
-	bool "SMDM2440 with S3C2442 CPU module"
-	select CPU_S3C2442
-
-config MACH_AT2440EVB
-	bool "Avantech AT2440EVB development board"
-	select CPU_S3C2440
-	select S3C_DEV_USB_HOST
-	select S3C_DEV_NAND
-	help
-	  Say Y here if you are using the AT2440EVB development board
-
-config MACH_MINI2440
-	bool "MINI2440 development board"
-	select CPU_S3C2440
-	select EEPROM_AT24
-	select NEW_LEDS
-	select LEDS_CLASS
-	select LEDS_TRIGGER
-	select LEDS_TRIGGER_BACKLIGHT
-	select S3C_DEV_NAND
-	select S3C_DEV_USB_HOST
-	help
-	  Say Y here to select support for the MINI2440. Is a 10cm x 10cm board
-	  available via various sources. It can come with a 3.5" or 7" touch LCD.
-
-config MACH_RX1950
-	bool "HP iPAQ rx1950"
-	select CPU_S3C2442
-	select S3C24XX_DCLK
-	select PM_H1940 if PM
-	select I2C
-	select S3C2410_PWM
-	select S3C_DEV_NAND
-	select S3C2410_IOTIMING if S3C2440_CPUFREQ
-	select S3C2440_XTAL_16934400
-	help
-	   Say Y here if you're using HP iPAQ rx1950
-
-endmenu
diff --git a/arch/arm/mach-s3c2440/Makefile b/arch/arm/mach-s3c2440/Makefile
index d5440fa..c460924 100644
--- a/arch/arm/mach-s3c2440/Makefile
+++ b/arch/arm/mach-s3c2440/Makefile
@@ -9,33 +9,9 @@ obj-m				:=
 obj-n				:=
 obj-				:=
 
-obj-$(CONFIG_CPU_S3C2440)	+= s3c2440.o dsc.o
-obj-$(CONFIG_CPU_S3C2442)	+= s3c2442.o
+obj-$(CONFIG_CPU_S3C2440)	+= dsc.o
 
-obj-$(CONFIG_CPU_S3C2440)	+= irq.o
-obj-$(CONFIG_CPU_S3C2440)	+= clock.o
-obj-$(CONFIG_S3C2440_DMA)	+= dma.o
-
-obj-$(CONFIG_CPU_S3C244X)	+= s3c244x.o
-obj-$(CONFIG_CPU_S3C244X)	+= s3c244x-irq.o
-obj-$(CONFIG_CPU_S3C244X)	+= s3c244x-clock.o
 obj-$(CONFIG_S3C2440_CPUFREQ)	+= s3c2440-cpufreq.o
 
 obj-$(CONFIG_S3C2440_PLL_12000000) += s3c2440-pll-12000000.o
 obj-$(CONFIG_S3C2440_PLL_16934400) += s3c2440-pll-16934400.o
-
-# Machine support
-
-obj-$(CONFIG_MACH_ANUBIS)	+= mach-anubis.o
-obj-$(CONFIG_MACH_OSIRIS)	+= mach-osiris.o
-obj-$(CONFIG_MACH_RX3715)	+= mach-rx3715.o
-obj-$(CONFIG_ARCH_S3C2440)	+= mach-smdk2440.o
-obj-$(CONFIG_MACH_NEXCODER_2440) += mach-nexcoder.o
-obj-$(CONFIG_MACH_AT2440EVB) += mach-at2440evb.o
-obj-$(CONFIG_MACH_MINI2440) += mach-mini2440.o
-obj-$(CONFIG_MACH_NEO1973_GTA02) += mach-gta02.o
-obj-$(CONFIG_MACH_RX1950) += mach-rx1950.o
-
-# extra machine support
-
-obj-$(CONFIG_MACH_OSIRIS_DVS)	+= mach-osiris-dvs.o
diff --git a/arch/arm/mach-s3c2440/common.h b/arch/arm/mach-s3c2440/common.h
deleted file mode 100644
index db8a98a..0000000
--- a/arch/arm/mach-s3c2440/common.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/*
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Common Header for S3C2440 machines
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ARCH_ARM_MACH_S3C2440_COMMON_H
-#define __ARCH_ARM_MACH_S3C2440_COMMON_H
-
-void s3c2440_restart(char mode, const char *cmd);
-
-#endif /* __ARCH_ARM_MACH_S3C2440_COMMON_H */
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 69529dd..aa295f8 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -47,12 +47,35 @@ config CPU_S3C2416
 	help
 	  Support for the S3C2416 SoC from the S3C24XX line
 
+config CPU_S3C2440
+	bool "SAMSUNG S3C2440"
+	select CPU_ARM920T
+	select CPU_LLSERIAL_S3C2440
+	select S3C2410_CLOCK
+	select S3C2410_PM if PM
+	select S3C2440_DMA if S3C24XX_DMA
+	help
+	  Support for S3C2440 Samsung Mobile CPU based systems.
+
+config CPU_S3C2442
+	bool "SAMSUNG S3C2442"
+	select CPU_ARM920T
+	select CPU_LLSERIAL_S3C2440
+	select S3C2410_CLOCK
+	select S3C2410_PM if PM
+	help
+	  Support for S3C2442 Samsung Mobile CPU based systems.
+
+config CPU_S3C244X
+	def_bool y
+	depends on CPU_S3C2440 || CPU_S3C2442
+
 if CPU_S3C2410
 
 config S3C2410_DMA
 	bool
-	depends on S3C24XX_DMA && CPU_S3C2410
-	default y if CPU_S3C2410
+	depends on S3C24XX_DMA && (CPU_S3C2410 || CPU_S3C2442)
+	default y if CPU_S3C2410 || CPU_S3C2442
 	help
 	  DMA device selection for S3C2410 and compatible CPUs
 
@@ -294,6 +317,148 @@ config MACH_SMDK2416
 
 endif	# CPU_S3C2416
 
+if CPU_S3C2440
+
+config S3C2440_DMA
+	bool
+	help
+	  Support for S3C2440 specific DMA code5A
+
+comment "S3C2440 Boards"
+
+#
+# The "S3C2440 Boards" list is ordered alphabetically by option text.
+# (without ARCH_ or MACH_)
+#
+
+config MACH_ANUBIS
+	bool "Simtec Electronics ANUBIS"
+	select S3C24XX_DCLK
+	select PM_SIMTEC if PM
+	select HAVE_PATA_PLATFORM
+	select S3C24XX_GPIO_EXTRA64
+	select S3C2440_XTAL_12000000
+	select S3C_DEV_USB_HOST
+	help
+	  Say Y here if you are using the Simtec Electronics ANUBIS
+	  development system
+
+config MACH_AT2440EVB
+	bool "Avantech AT2440EVB development board"
+	select S3C_DEV_USB_HOST
+	select S3C_DEV_NAND
+	help
+	  Say Y here if you are using the AT2440EVB development board
+
+config MACH_MINI2440
+	bool "MINI2440 development board"
+	select EEPROM_AT24
+	select NEW_LEDS
+	select LEDS_CLASS
+	select LEDS_TRIGGER
+	select LEDS_TRIGGER_BACKLIGHT
+	select S3C_DEV_NAND
+	select S3C_DEV_USB_HOST
+	help
+	  Say Y here to select support for the MINI2440. Is a 10cm x 10cm board
+	  available via various sources. It can come with a 3.5" or 7" touch LCD.
+
+config MACH_NEXCODER_2440
+	bool "NexVision NEXCODER 2440 Light Board"
+	select S3C2440_XTAL_12000000
+	select S3C_DEV_USB_HOST
+	select S3C_DEV_NAND
+	help
+	  Say Y here if you are using the Nex Vision NEXCODER 2440 Light Board
+
+config MACH_OSIRIS
+	bool "Simtec IM2440D20 (OSIRIS) module"
+	select S3C24XX_DCLK
+	select PM_SIMTEC if PM
+	select S3C24XX_GPIO_EXTRA128
+	select S3C2440_XTAL_12000000
+	select S3C2410_IOTIMING if S3C2440_CPUFREQ
+	select S3C_DEV_USB_HOST
+	select S3C_DEV_NAND
+	help
+	  Say Y here if you are using the Simtec IM2440D20 module, also
+	  known as the Osiris.
+
+config MACH_OSIRIS_DVS
+	tristate "Simtec IM2440D20 (OSIRIS) Dynamic Voltage Scaling driver"
+	depends on MACH_OSIRIS
+	select TPS65010
+	help
+	  Say Y/M here if you want to have dynamic voltage scaling support
+	  on the Simtec IM2440D20 (OSIRIS) module via the TPS65011.
+
+	  The DVS driver alters the voltage supplied to the ARM core
+	  depending on the frequency it is running at. The driver itself
+	  does not do any of the frequency alteration, which is left up
+	  to the cpufreq driver.
+
+config MACH_RX3715
+	bool "HP iPAQ rx3715"
+	select S3C2440_XTAL_16934400
+	select PM_H1940 if PM
+	select S3C_DEV_NAND
+	help
+	  Say Y here if you are using the HP iPAQ rx3715.
+
+config ARCH_S3C2440
+	bool "SMDK2440"
+	select S3C2440_XTAL_16934400
+	select MACH_SMDK
+	select S3C_DEV_USB_HOST
+	select S3C_DEV_NAND
+	help
+	  Say Y here if you are using the SMDK2440.
+
+config SMDK2440_CPU2440
+	bool "SMDK2440 with S3C2440 CPU module"
+	default y if ARCH_S3C2440
+	select S3C2440_XTAL_16934400
+
+endif	# CPU_S3C2440
+
+if CPU_S3C2442
+
+comment "S3C2442 Boards"
+
+#
+# The "S3C2442 Boards" list is ordered alphabetically by option text.
+# (without ARCH_ or MACH_)
+#
+
+config MACH_NEO1973_GTA02
+	bool "Openmoko GTA02 / Freerunner phone"
+	select MFD_PCF50633
+	select PCF50633_GPIO
+	select I2C
+	select POWER_SUPPLY
+	select MACH_NEO1973
+	select S3C2410_PWM
+	select S3C_DEV_USB_HOST
+	help
+	   Say Y here if you are using the Openmoko GTA02 / Freerunner GSM Phone
+
+config MACH_RX1950
+	bool "HP iPAQ rx1950"
+	select S3C24XX_DCLK
+	select PM_H1940 if PM
+	select I2C
+	select S3C2410_PWM
+	select S3C_DEV_NAND
+	select S3C2410_IOTIMING if S3C2440_CPUFREQ
+	select S3C2440_XTAL_16934400
+	help
+	   Say Y here if you're using HP iPAQ rx1950
+
+config SMDK2440_CPU2442
+	bool "SMDM2440 with S3C2442 CPU module"
+
+endif	# CPU_S3C2440
+
 endmenu	# SAMSUNG S3C24XX SoCs Support
 
 endif	# ARCH_S3C24XX
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 789aa5c..f458cf2 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -26,6 +26,11 @@ obj-$(CONFIG_S3C2412_PM_SLEEP)	+= sleep-s3c2412.o
 obj-$(CONFIG_CPU_S3C2416)	+= s3c2416.o irq-s3c2416.o clock-s3c2416.o
 obj-$(CONFIG_S3C2416_PM)	+= pm-s3c2416.o
 
+obj-$(CONFIG_CPU_S3C2440)	+= s3c2440.o irq-s3c2440.o clock-s3c2440.o
+obj-$(CONFIG_CPU_S3C2442)	+= s3c2442.o
+obj-$(CONFIG_CPU_S3C244X)	+= s3c244x.o irq-s3c244x.o clock-s3c244x.o
+obj-$(CONFIG_S3C2440_DMA)	+= dma-s3c2440.o
+
 #
 # machine support
 # following is ordered alphabetically by option text.
@@ -50,6 +55,17 @@ obj-$(CONFIG_MACH_VSTMS)		+= mach-vstms.o
 
 obj-$(CONFIG_MACH_SMDK2416)		+= mach-smdk2416.o
 
+obj-$(CONFIG_MACH_ANUBIS)		+= mach-anubis.o
+obj-$(CONFIG_MACH_AT2440EVB)		+= mach-at2440evb.o
+obj-$(CONFIG_MACH_MINI2440)		+= mach-mini2440.o
+obj-$(CONFIG_MACH_NEXCODER_2440)	+= mach-nexcoder.o
+obj-$(CONFIG_MACH_OSIRIS)		+= mach-osiris.o
+obj-$(CONFIG_MACH_RX3715)		+= mach-rx3715.o
+obj-$(CONFIG_ARCH_S3C2440)		+= mach-smdk2440.o
+
+obj-$(CONFIG_MACH_NEO1973_GTA02)	+= mach-gta02.o
+obj-$(CONFIG_MACH_RX1950)		+= mach-rx1950.o
+
 # common bits of machine support
 
 obj-$(CONFIG_SIMTEC_NOR)		+= nor-simtec.o
@@ -57,6 +73,7 @@ obj-$(CONFIG_SIMTEC_NOR)		+= nor-simtec.o
 # machine additions
 
 obj-$(CONFIG_MACH_BAST_IDE)		+= bast-ide.o
+obj-$(CONFIG_MACH_OSIRIS_DVS)		+= mach-osiris-dvs.o
 
 # device setup
 
diff --git a/arch/arm/mach-s3c2440/clock.c b/arch/arm/mach-s3c24xx/clock-s3c2440.c
similarity index 100%
rename from arch/arm/mach-s3c2440/clock.c
rename to arch/arm/mach-s3c24xx/clock-s3c2440.c
diff --git a/arch/arm/mach-s3c2440/s3c244x-clock.c b/arch/arm/mach-s3c24xx/clock-s3c244x.c
similarity index 100%
rename from arch/arm/mach-s3c2440/s3c244x-clock.c
rename to arch/arm/mach-s3c24xx/clock-s3c244x.c
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index f65dc80..62a2e19 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -12,6 +12,12 @@
 #ifndef __ARCH_ARM_MACH_S3C2410_COMMON_H
 #define __ARCH_ARM_MACH_S3C2410_COMMON_H
 
+#ifdef CONFIG_CPU_S3C2410
 void s3c2410_restart(char mode, const char *cmd);
+#endif
+
+#ifdef CONFIG_CPU_S3C2440
+void s3c2440_restart(char mode, const char *cmd);
+#endif
 
 #endif /* __ARCH_ARM_MACH_S3C2410_COMMON_H */
diff --git a/arch/arm/mach-s3c2440/dma.c b/arch/arm/mach-s3c24xx/dma-s3c2440.c
similarity index 100%
rename from arch/arm/mach-s3c2440/dma.c
rename to arch/arm/mach-s3c24xx/dma-s3c2440.c
diff --git a/arch/arm/mach-s3c2440/include/mach/gta02.h b/arch/arm/mach-s3c24xx/include/mach/gta02.h
similarity index 100%
rename from arch/arm/mach-s3c2440/include/mach/gta02.h
rename to arch/arm/mach-s3c24xx/include/mach/gta02.h
diff --git a/arch/arm/mach-s3c2440/irq.c b/arch/arm/mach-s3c24xx/irq-s3c2440.c
similarity index 100%
rename from arch/arm/mach-s3c2440/irq.c
rename to arch/arm/mach-s3c24xx/irq-s3c2440.c
diff --git a/arch/arm/mach-s3c2440/s3c244x-irq.c b/arch/arm/mach-s3c24xx/irq-s3c244x.c
similarity index 100%
rename from arch/arm/mach-s3c2440/s3c244x-irq.c
rename to arch/arm/mach-s3c24xx/irq-s3c244x.c
diff --git a/arch/arm/mach-s3c2440/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
similarity index 100%
rename from arch/arm/mach-s3c2440/mach-anubis.c
rename to arch/arm/mach-s3c24xx/mach-anubis.c
diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
similarity index 100%
rename from arch/arm/mach-s3c2440/mach-at2440evb.c
rename to arch/arm/mach-s3c24xx/mach-at2440evb.c
diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
similarity index 100%
rename from arch/arm/mach-s3c2440/mach-gta02.c
rename to arch/arm/mach-s3c24xx/mach-gta02.c
diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
similarity index 100%
rename from arch/arm/mach-s3c2440/mach-mini2440.c
rename to arch/arm/mach-s3c24xx/mach-mini2440.c
diff --git a/arch/arm/mach-s3c2440/mach-nexcoder.c b/arch/arm/mach-s3c24xx/mach-nexcoder.c
similarity index 100%
rename from arch/arm/mach-s3c2440/mach-nexcoder.c
rename to arch/arm/mach-s3c24xx/mach-nexcoder.c
diff --git a/arch/arm/mach-s3c2440/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
similarity index 100%
rename from arch/arm/mach-s3c2440/mach-osiris-dvs.c
rename to arch/arm/mach-s3c24xx/mach-osiris-dvs.c
diff --git a/arch/arm/mach-s3c2440/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
similarity index 100%
rename from arch/arm/mach-s3c2440/mach-osiris.c
rename to arch/arm/mach-s3c24xx/mach-osiris.c
diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
similarity index 100%
rename from arch/arm/mach-s3c2440/mach-rx1950.c
rename to arch/arm/mach-s3c24xx/mach-rx1950.c
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
similarity index 100%
rename from arch/arm/mach-s3c2440/mach-rx3715.c
rename to arch/arm/mach-s3c24xx/mach-rx3715.c
diff --git a/arch/arm/mach-s3c2440/mach-smdk2440.c b/arch/arm/mach-s3c24xx/mach-smdk2440.c
similarity index 100%
rename from arch/arm/mach-s3c2440/mach-smdk2440.c
rename to arch/arm/mach-s3c24xx/mach-smdk2440.c
diff --git a/arch/arm/mach-s3c2440/s3c2440.c b/arch/arm/mach-s3c24xx/s3c2440.c
similarity index 100%
rename from arch/arm/mach-s3c2440/s3c2440.c
rename to arch/arm/mach-s3c24xx/s3c2440.c
diff --git a/arch/arm/mach-s3c2440/s3c2442.c b/arch/arm/mach-s3c24xx/s3c2442.c
similarity index 100%
rename from arch/arm/mach-s3c2440/s3c2442.c
rename to arch/arm/mach-s3c24xx/s3c2442.c
diff --git a/arch/arm/mach-s3c2440/s3c244x.c b/arch/arm/mach-s3c24xx/s3c244x.c
similarity index 100%
rename from arch/arm/mach-s3c2440/s3c244x.c
rename to arch/arm/mach-s3c24xx/s3c244x.c
-- 
1.7.4.4
