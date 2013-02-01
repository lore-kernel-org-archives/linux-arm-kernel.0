From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 31 Jan 2013 17:02:58 -0800
Subject: [PATCH] ARM: S3C24XX: Remove plat-s3c24xx directory in arch/arm/
Message-ID: <1359680578-6914-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is for just moving plat-s3c24xx/*.c into mach-s3c24xx/, so
that we could remove plat-s3c24xx directory. But since the PLAT_S3C24XX
is used in drivers, the statement is not deleted and it will be sorted
out next time.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig                                   |    1 -
 arch/arm/Makefile                                  |    2 +-
 arch/arm/mach-s3c24xx/Kconfig                      |  104 +++++++++++++++++
 arch/arm/mach-s3c24xx/Makefile                     |   14 ++-
 .../{plat-s3c24xx => mach-s3c24xx}/clock-dclk.c    |    3 +-
 .../clock-s3c2410.c}                               |    3 +-
 .../cpufreq-debugfs.c}                             |    3 +-
 .../cpufreq-utils.c}                               |    3 +-
 .../cpu-freq.c => mach-s3c24xx/cpufreq.c}          |    3 +-
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/dma.c      |    3 +-
 .../iotiming-s3c2410.c}                            |    3 +-
 .../iotiming-s3c2412.c}                            |    3 +-
 arch/arm/{plat-s3c24xx => mach-s3c24xx}/irq.c      |    0
 arch/arm/plat-s3c24xx/Kconfig                      |  117 --------------------
 arch/arm/plat-s3c24xx/Makefile                     |   27 -----
 15 files changed, 126 insertions(+), 163 deletions(-)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/clock-dclk.c (98%)
 rename arch/arm/{plat-s3c24xx/s3c2410-clock.c => mach-s3c24xx/clock-s3c2410.c} (99%)
 rename arch/arm/{plat-s3c24xx/cpu-freq-debugfs.c => mach-s3c24xx/cpufreq-debugfs.c} (98%)
 rename arch/arm/{plat-s3c24xx/s3c2410-cpufreq-utils.c => mach-s3c24xx/cpufreq-utils.c} (96%)
 rename arch/arm/{plat-s3c24xx/cpu-freq.c => mach-s3c24xx/cpufreq.c} (99%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/dma.c (99%)
 rename arch/arm/{plat-s3c24xx/s3c2410-iotiming.c => mach-s3c24xx/iotiming-s3c2410.c} (99%)
 rename arch/arm/{plat-s3c24xx/s3c2412-iotiming.c => mach-s3c24xx/iotiming-s3c2412.c} (99%)
 rename arch/arm/{plat-s3c24xx => mach-s3c24xx}/irq.c (100%)
 delete mode 100644 arch/arm/plat-s3c24xx/Kconfig
 delete mode 100644 arch/arm/plat-s3c24xx/Makefile

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4350235..8b72d23 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1089,7 +1089,6 @@ source "arch/arm/mach-realview/Kconfig"
 source "arch/arm/mach-sa1100/Kconfig"
 
 source "arch/arm/plat-samsung/Kconfig"
-source "arch/arm/plat-s3c24xx/Kconfig"
 
 source "arch/arm/mach-socfpga/Kconfig"
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 0935dac..a554f75 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -204,7 +204,7 @@ plat-$(CONFIG_ARCH_S3C64XX)	+= samsung
 plat-$(CONFIG_PLAT_IOP)		+= iop
 plat-$(CONFIG_PLAT_ORION)	+= orion
 plat-$(CONFIG_PLAT_PXA)		+= pxa
-plat-$(CONFIG_PLAT_S3C24XX)	+= s3c24xx samsung
+plat-$(CONFIG_PLAT_S3C24XX)	+= samsung
 plat-$(CONFIG_PLAT_S5P)		+= samsung
 plat-$(CONFIG_PLAT_SPEAR)	+= spear
 plat-$(CONFIG_PLAT_VERSATILE)	+= versatile
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 5e17e1d..d4f1fea 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -9,6 +9,15 @@
 
 if ARCH_S3C24XX
 
+config PLAT_S3C24XX
+	def_bool y
+	select ARCH_REQUIRE_GPIOLIB
+	select NO_IOPORT
+	select S3C_DEV_NAND
+	select IRQ_DOMAIN
+	help
+	  Base platform code for any Samsung S3C24XX device
+
 menu "SAMSUNG S3C24XX SoCs Support"
 
 comment "S3C24XX SoCs"
@@ -89,6 +98,17 @@ config CPU_S3C2443
 
 # common code
 
+config S3C2410_CLOCK
+	bool
+	help
+	  Clock code for the S3C2410, and similar processors which
+	  is currently includes the S3C2410, S3C2440, S3C2442.
+
+config S3C24XX_DCLK
+	bool
+	help
+	  Clock code for supporting DCLK/CLKOUT on S3C24XX architectures
+
 config S3C24XX_SMDK
 	bool
 	help
@@ -117,6 +137,22 @@ config S3C24XX_SETUP_TS
 	help
 	  Compile in platform device definition for Samsung TouchScreen.
 
+config S3C24XX_DMA
+	bool "S3C2410 DMA support"
+	depends on ARCH_S3C24XX
+	select S3C_DMA
+	help
+	  S3C2410 DMA support. This is needed for drivers like sound which
+	  use the S3C2410's DMA system to move data to and from the
+	  peripheral blocks.
+
+config S3C2410_DMA_DEBUG
+	bool "S3C2410 DMA support debug"
+	depends on ARCH_S3C24XX && S3C2410_DMA
+	help
+	  Enable debugging output for the DMA code. This option sends info
+	  to the kernel log, at priority KERN_DEBUG.
+
 config S3C2410_DMA
 	bool
 	depends on S3C24XX_DMA && (CPU_S3C2410 || CPU_S3C2442)
@@ -129,6 +165,74 @@ config S3C2410_PM
 	help
 	  Power Management code common to S3C2410 and better
 
+# low-level serial option nodes
+
+config CPU_LLSERIAL_S3C2410_ONLY
+	bool
+	default y if CPU_LLSERIAL_S3C2410 && !CPU_LLSERIAL_S3C2440
+
+config CPU_LLSERIAL_S3C2440_ONLY
+	bool
+	default y if CPU_LLSERIAL_S3C2440 && !CPU_LLSERIAL_S3C2410
+
+config CPU_LLSERIAL_S3C2410
+	bool
+	help
+	  Selected if there is an S3C2410 (or register compatible) serial
+	  low-level implementation needed
+
+config CPU_LLSERIAL_S3C2440
+	bool
+	help
+	  Selected if there is an S3C2440 (or register compatible) serial
+	  low-level implementation needed
+
+# gpio configurations
+
+config S3C24XX_GPIO_EXTRA
+	int
+	default 128 if S3C24XX_GPIO_EXTRA128
+	default 64 if S3C24XX_GPIO_EXTRA64
+	default 16 if ARCH_H1940
+	default 0
+
+config S3C24XX_GPIO_EXTRA64
+	bool
+	help
+	  Add an extra 64 gpio numbers to the available GPIO pool. This is
+	  available for boards that need extra gpios for external devices.
+
+config S3C24XX_GPIO_EXTRA128
+	bool
+	help
+	  Add an extra 128 gpio numbers to the available GPIO pool. This is
+	  available for boards that need extra gpios for external devices.
+
+# cpu frequency items common between s3c2410 and s3c2440/s3c2442
+
+config S3C2410_IOTIMING
+	bool
+	depends on CPU_FREQ_S3C24XX
+	help
+	  Internal node to select io timing code that is common to the s3c2410
+	  and s3c2440/s3c2442 cpu frequency support.
+
+config S3C2410_CPUFREQ_UTILS
+	bool
+	depends on CPU_FREQ_S3C24XX
+	help
+	  Internal node to select timing code that is common to the s3c2410
+	  and s3c2440/s3c244 cpu frequency support.
+
+# cpu frequency support common to s3c2412, s3c2413 and s3c2442
+
+config S3C2412_IOTIMING
+	bool
+	depends on CPU_FREQ_S3C24XX && (CPU_S3C2412 || CPU_S3C2443)
+	help
+	  Intel node to select io timing code that is common to the s3c2412
+	  and the s3c2443.
+
 # cpu-specific sections
 
 if CPU_S3C2410
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 1d67582..af53d27 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -14,7 +14,7 @@ obj-				:=
 
 # core
 
-obj-y				+= common.o
+obj-y				+= common.o irq.o
 
 obj-$(CONFIG_CPU_S3C2410)	+= s3c2410.o
 obj-$(CONFIG_S3C2410_CPUFREQ)	+= cpufreq-s3c2410.o
@@ -47,9 +47,21 @@ obj-$(CONFIG_PM)		+= pm.o irq-pm.o sleep.o
 
 # common code
 
+obj-$(CONFIG_S3C24XX_DCLK)	+= clock-dclk.o
+obj-$(CONFIG_S3C24XX_DMA)	+= dma.o
+
+obj-$(CONFIG_S3C2410_CLOCK)	+= clock-s3c2410.o
+obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += cpufreq-utils.o
+
+obj-$(CONFIG_S3C2410_IOTIMING)	+= iotiming-s3c2410.o
+obj-$(CONFIG_S3C2412_IOTIMING)	+= iotiming-s3c2412.o
+
 obj-$(CONFIG_S3C2443_COMMON)	+= common-s3c2443.o
 obj-$(CONFIG_S3C2443_DMA)	+= dma-s3c2443.o
 
+obj-$(CONFIG_CPU_FREQ_S3C24XX)	+= cpufreq.o
+obj-$(CONFIG_CPU_FREQ_S3C24XX_DEBUGFS) += cpufreq-debugfs.o
+
 #
 # machine support
 # following is ordered alphabetically by option text.
diff --git a/arch/arm/plat-s3c24xx/clock-dclk.c b/arch/arm/mach-s3c24xx/clock-dclk.c
similarity index 98%
rename from arch/arm/plat-s3c24xx/clock-dclk.c
rename to arch/arm/mach-s3c24xx/clock-dclk.c
index f95d326..1edd9b2 100644
--- a/arch/arm/plat-s3c24xx/clock-dclk.c
+++ b/arch/arm/mach-s3c24xx/clock-dclk.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s3c24xx/clock-dclk.c
- *
+/*
  * Copyright (c) 2004-2008 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *	http://armlinux.simtec.co.uk/
diff --git a/arch/arm/plat-s3c24xx/s3c2410-clock.c b/arch/arm/mach-s3c24xx/clock-s3c2410.c
similarity index 99%
rename from arch/arm/plat-s3c24xx/s3c2410-clock.c
rename to arch/arm/mach-s3c24xx/clock-s3c2410.c
index 25dc4d4..641266f3 100644
--- a/arch/arm/plat-s3c24xx/s3c2410-clock.c
+++ b/arch/arm/mach-s3c24xx/clock-s3c2410.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/mach-s3c2410/clock.c
- *
+/*
  * Copyright (c) 2006 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
diff --git a/arch/arm/plat-s3c24xx/cpu-freq-debugfs.c b/arch/arm/mach-s3c24xx/cpufreq-debugfs.c
similarity index 98%
rename from arch/arm/plat-s3c24xx/cpu-freq-debugfs.c
rename to arch/arm/mach-s3c24xx/cpufreq-debugfs.c
index c7adad0..9b7b428 100644
--- a/arch/arm/plat-s3c24xx/cpu-freq-debugfs.c
+++ b/arch/arm/mach-s3c24xx/cpufreq-debugfs.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s3c24xx/cpu-freq-debugfs.c
- *
+/*
  * Copyright (c) 2009 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/plat-s3c24xx/s3c2410-cpufreq-utils.c b/arch/arm/mach-s3c24xx/cpufreq-utils.c
similarity index 96%
rename from arch/arm/plat-s3c24xx/s3c2410-cpufreq-utils.c
rename to arch/arm/mach-s3c24xx/cpufreq-utils.c
index 43ea801..89e4e2b 100644
--- a/arch/arm/plat-s3c24xx/s3c2410-cpufreq-utils.c
+++ b/arch/arm/mach-s3c24xx/cpufreq-utils.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s3c24xx/s3c2410-cpufreq-utils.c
- *
+/*
  * Copyright (c) 2009 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/plat-s3c24xx/cpu-freq.c b/arch/arm/mach-s3c24xx/cpufreq.c
similarity index 99%
rename from arch/arm/plat-s3c24xx/cpu-freq.c
rename to arch/arm/mach-s3c24xx/cpufreq.c
index 4680799..5f181e7 100644
--- a/arch/arm/plat-s3c24xx/cpu-freq.c
+++ b/arch/arm/mach-s3c24xx/cpufreq.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s3c24xx/cpu-freq.c
- *
+/*
  * Copyright (c) 2006-2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/mach-s3c24xx/dma.c
similarity index 99%
rename from arch/arm/plat-s3c24xx/dma.c
rename to arch/arm/mach-s3c24xx/dma.c
index ba3e76c..aab6490 100644
--- a/arch/arm/plat-s3c24xx/dma.c
+++ b/arch/arm/mach-s3c24xx/dma.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s3c24xx/dma.c
- *
+/*
  * Copyright 2003-2006 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
  *
diff --git a/arch/arm/plat-s3c24xx/s3c2410-iotiming.c b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
similarity index 99%
rename from arch/arm/plat-s3c24xx/s3c2410-iotiming.c
rename to arch/arm/mach-s3c24xx/iotiming-s3c2410.c
index b1908e5..48ccfcf 100644
--- a/arch/arm/plat-s3c24xx/s3c2410-iotiming.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s3c24xx/s3c2410-iotiming.c
- *
+/*
  * Copyright (c) 2006-2009 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/plat-s3c24xx/s3c2412-iotiming.c b/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
similarity index 99%
rename from arch/arm/plat-s3c24xx/s3c2412-iotiming.c
rename to arch/arm/mach-s3c24xx/iotiming-s3c2412.c
index 48eee39..9527342 100644
--- a/arch/arm/plat-s3c24xx/s3c2412-iotiming.c
+++ b/arch/arm/mach-s3c24xx/iotiming-s3c2412.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/plat-s3c24xx/s3c2412-iotiming.c
- *
+/*
  * Copyright (c) 2006-2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
similarity index 100%
rename from arch/arm/plat-s3c24xx/irq.c
rename to arch/arm/mach-s3c24xx/irq.c
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
deleted file mode 100644
index 3bb5c8f..0000000
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ /dev/null
@@ -1,117 +0,0 @@
-# Copyright 2007 Simtec Electronics
-#
-# Licensed under GPLv2
-
-config PLAT_S3C24XX
-	bool
-	depends on ARCH_S3C24XX
-	default y
-	select ARCH_REQUIRE_GPIOLIB
-	select NO_IOPORT
-	select S3C_DEV_NAND
-	select IRQ_DOMAIN
-	help
-	  Base platform code for any Samsung S3C24XX device
-
-if PLAT_S3C24XX
-
-# low-level serial option nodes
-
-config CPU_LLSERIAL_S3C2410_ONLY
-	bool
-	default y if CPU_LLSERIAL_S3C2410 && !CPU_LLSERIAL_S3C2440
-
-config CPU_LLSERIAL_S3C2440_ONLY
-	bool
-	default y if CPU_LLSERIAL_S3C2440 && !CPU_LLSERIAL_S3C2410
-
-config CPU_LLSERIAL_S3C2410
-	bool
-	help
-	  Selected if there is an S3C2410 (or register compatible) serial
-	  low-level implementation needed
-
-config CPU_LLSERIAL_S3C2440
-	bool
-	help
-	  Selected if there is an S3C2440 (or register compatible) serial
-	  low-level implementation needed
-
-# code that is shared between a number of the s3c24xx implementations
-
-config S3C2410_CLOCK
-	bool
-	help
-	  Clock code for the S3C2410, and similar processors which
-	  is currently includes the S3C2410, S3C2440, S3C2442.
-
-config S3C24XX_DCLK
-	bool
-	help
-	  Clock code for supporting DCLK/CLKOUT on S3C24XX architectures
-
-# gpio configurations
-
-config S3C24XX_GPIO_EXTRA
-	int
-	default 128 if S3C24XX_GPIO_EXTRA128
-	default 64 if S3C24XX_GPIO_EXTRA64
-	default 16 if ARCH_H1940
-	default 0
-
-config S3C24XX_GPIO_EXTRA64
-	bool
-	help
-	  Add an extra 64 gpio numbers to the available GPIO pool. This is
-	  available for boards that need extra gpios for external devices.
-
-config S3C24XX_GPIO_EXTRA128
-	bool
-	help
-	  Add an extra 128 gpio numbers to the available GPIO pool. This is
-	  available for boards that need extra gpios for external devices.
-
-config S3C24XX_DMA
-	bool "S3C2410 DMA support"
-	depends on ARCH_S3C24XX
-	select S3C_DMA
-	help
-	  S3C2410 DMA support. This is needed for drivers like sound which
-	  use the S3C2410's DMA system to move data to and from the
-	  peripheral blocks.
-
-config S3C2410_DMA_DEBUG
-	bool "S3C2410 DMA support debug"
-	depends on ARCH_S3C24XX && S3C2410_DMA
-	help
-	  Enable debugging output for the DMA code. This option sends info
-	  to the kernel log, at priority KERN_DEBUG.
-
-# common code for s3c24xx based machines, such as the SMDKs.
-
-# cpu frequency items common between s3c2410 and s3c2440/s3c2442
-
-config S3C2410_IOTIMING
-	bool
-	depends on CPU_FREQ_S3C24XX
-	help
-	  Internal node to select io timing code that is common to the s3c2410
-	  and s3c2440/s3c2442 cpu frequency support.
-
-config S3C2410_CPUFREQ_UTILS
-	bool
-	depends on CPU_FREQ_S3C24XX
-	help
-	  Internal node to select timing code that is common to the s3c2410
-	  and s3c2440/s3c244 cpu frequency support.
-
-# cpu frequency support common to s3c2412, s3c2413 and s3c2442
-
-config S3C2412_IOTIMING
-	bool
-	depends on CPU_FREQ_S3C24XX && (CPU_S3C2412 || CPU_S3C2443)
-	help
-	  Intel node to select io timing code that is common to the s3c2412
-	  and the s3c2443.
-
-endif
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
deleted file mode 100644
index 9f60549c..0000000
--- a/arch/arm/plat-s3c24xx/Makefile
+++ /dev/null
@@ -1,27 +0,0 @@
-# arch/arm/plat-s3c24xx/Makefile
-#
-# Copyright 2007 Simtec Electronics
-#
-# Licensed under GPLv2
-
-obj-y				:=
-obj-m				:=
-obj-n				:=
-obj-				:=
-
-
-# Core files
-
-obj-y				+= irq.o
-obj-$(CONFIG_S3C24XX_DCLK)	+= clock-dclk.o
-
-obj-$(CONFIG_CPU_FREQ_S3C24XX)	+= cpu-freq.o
-obj-$(CONFIG_CPU_FREQ_S3C24XX_DEBUGFS) += cpu-freq-debugfs.o
-
-# Architecture dependent builds
-
-obj-$(CONFIG_S3C2410_CLOCK)	+= s3c2410-clock.o
-obj-$(CONFIG_S3C24XX_DMA)	+= dma.o
-obj-$(CONFIG_S3C2410_IOTIMING)	+= s3c2410-iotiming.o
-obj-$(CONFIG_S3C2412_IOTIMING)	+= s3c2412-iotiming.o
-obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += s3c2410-cpufreq-utils.o
-- 
1.7.10.4
