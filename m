From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 14 Feb 2011 17:23:03 +0900
Subject: [PATCH 07/11] ARM: EXYNOS4: Update Kconfig and Makefile for the new
	ARCH_EXYNOS4
In-Reply-To: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
References: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1297671787-10571-8-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the Kconfig and Makefile for the new ARCH_EXYNOS4.
It also updates arch/arm/Kconfig, Makeifile and arch/arm/mm/Kconfig
to include support for the new ARCH_EXYNOS4.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/Kconfig                                   |   12 +-
 arch/arm/Makefile                                  |    2 +-
 arch/arm/{mach-s5pv310 => mach-exynos4}/Kconfig    |  105 +++++++++----------
 arch/arm/mach-exynos4/Makefile                     |   43 ++++++++
 .../{mach-s5pv310 => mach-exynos4}/Makefile.boot   |    0
 arch/arm/mach-s5pv310/Makefile                     |   43 --------
 arch/arm/mm/Kconfig                                |    2 +-
 arch/arm/plat-s5p/Kconfig                          |    8 +-
 8 files changed, 105 insertions(+), 110 deletions(-)
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/Kconfig (58%)
 create mode 100644 arch/arm/mach-exynos4/Makefile
 rename arch/arm/{mach-s5pv310 => mach-exynos4}/Makefile.boot (100%)
 delete mode 100644 arch/arm/mach-s5pv310/Makefile

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5cff165..4163502 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -760,8 +760,8 @@ config ARCH_S5PV210
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
-config ARCH_S5PV310
-	bool "Samsung S5PV310/S5PC210"
+config ARCH_EXYNOS4
+	bool "Samsung EXYNOS4"
 	select CPU_V7
 	select ARCH_SPARSEMEM_ENABLE
 	select GENERIC_GPIO
@@ -772,7 +772,7 @@ config ARCH_S5PV310
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	help
-	  Samsung S5PV310 series based systems
+	  Samsung EXYNOS4 series based systems
 
 config ARCH_SHARK
 	bool "Shark"
@@ -991,7 +991,7 @@ source "arch/arm/mach-s5pc100/Kconfig"
 
 source "arch/arm/mach-s5pv210/Kconfig"
 
-source "arch/arm/mach-s5pv310/Kconfig"
+source "arch/arm/mach-exynos4/Kconfig"
 
 source "arch/arm/mach-shmobile/Kconfig"
 
@@ -1253,7 +1253,7 @@ config SMP
 	depends on GENERIC_CLOCKEVENTS
 	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
 		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
-		 ARCH_S5PV310 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
+		 ARCH_EXYNOS4 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
 		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
@@ -1353,7 +1353,7 @@ source kernel/Kconfig.preempt
 config HZ
 	int
 	default 200 if ARCH_EBSA110 || ARCH_S3C2410 || ARCH_S5P64X0 || \
-		ARCH_S5P6442 || ARCH_S5PV210 || ARCH_S5PV310
+		ARCH_S5P6442 || ARCH_S5PV210 || ARCH_EXYNOS4
 	default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
 	default AT91_TIMER_HZ if ARCH_AT91
 	default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c22c1ad..0ff5ddb 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -178,7 +178,7 @@ machine-$(CONFIG_ARCH_S5P64X0)		:= s5p64x0
 machine-$(CONFIG_ARCH_S5P6442)		:= s5p6442
 machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
 machine-$(CONFIG_ARCH_S5PV210)		:= s5pv210
-machine-$(CONFIG_ARCH_S5PV310)		:= s5pv310
+machine-$(CONFIG_ARCH_EXYNOS4)		:= exynos4
 machine-$(CONFIG_ARCH_SA1100)		:= sa1100
 machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_SHMOBILE) 	:= shmobile
diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-exynos4/Kconfig
similarity index 58%
rename from arch/arm/mach-s5pv310/Kconfig
rename to arch/arm/mach-exynos4/Kconfig
index b2a9acc..ad03840 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -1,83 +1,83 @@
-# arch/arm/mach-s5pv310/Kconfig
+# arch/arm/mach-exynos4/Kconfig
 #
-# Copyright (c) 2010 Samsung Electronics Co., Ltd.
+# Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
 #		http://www.samsung.com/
 #
 # Licensed under GPLv2
 
-# Configuration options for the S5PV310
+# Configuration options for the EXYNOS4
 
-if ARCH_S5PV310
+if ARCH_EXYNOS4
 
-config CPU_S5PV310
+config CPU_EXYNOS4210
 	bool
 	select S3C_PL330_DMA
 	help
-	  Enable S5PV310 CPU support
+	  Enable EXYNOS4210 CPU support
 
-config S5PV310_DEV_PD
+config EXYNOS4_DEV_PD
 	bool
 	help
 	  Compile in platform device definitions for Power Domain
 
-config S5PV310_SETUP_I2C1
+config EXYNOS4_DEV_SYSMMU
+	bool
+	help
+	  Common setup code for SYSTEM MMU in EXYNOS4
+
+config EXYNOS4_SETUP_I2C1
 	bool
 	help
 	  Common setup code for i2c bus 1.
 
-config S5PV310_SETUP_I2C2
+config EXYNOS4_SETUP_I2C2
 	bool
 	help
 	  Common setup code for i2c bus 2.
 
-config S5PV310_SETUP_I2C3
+config EXYNOS4_SETUP_I2C3
 	bool
 	help
 	  Common setup code for i2c bus 3.
 
-config S5PV310_SETUP_I2C4
+config EXYNOS4_SETUP_I2C4
 	bool
 	help
 	  Common setup code for i2c bus 4.
 
-config S5PV310_SETUP_I2C5
+config EXYNOS4_SETUP_I2C5
 	bool
 	help
 	  Common setup code for i2c bus 5.
 
-config S5PV310_SETUP_I2C6
+config EXYNOS4_SETUP_I2C6
 	bool
 	help
 	  Common setup code for i2c bus 6.
 
-config S5PV310_SETUP_I2C7
+config EXYNOS4_SETUP_I2C7
 	bool
 	help
 	  Common setup code for i2c bus 7.
 
-config S5PV310_SETUP_SDHCI
+config EXYNOS4_SETUP_SDHCI
 	bool
-	select S5PV310_SETUP_SDHCI_GPIO
+	select EXYNOS4_SETUP_SDHCI_GPIO
 	help
-	  Internal helper functions for S5PV310 based SDHCI systems.
+	  Internal helper functions for EXYNOS4 based SDHCI systems.
 
-config S5PV310_SETUP_SDHCI_GPIO
+config EXYNOS4_SETUP_SDHCI_GPIO
 	bool
 	help
 	  Common setup code for SDHCI gpio.
 
-config S5PV310_DEV_SYSMMU
-	bool
-	help
-	  Common setup code for SYSTEM MMU in S5PV310
-
 # machine support
 
-menu "S5PC210 Machines"
+menu "EXYNOS4 Machines"
 
 config MACH_SMDKC210
 	bool "SMDKC210"
-	select CPU_S5PV310
+	select CPU_EXYNOS4210
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
 	select S3C_DEV_I2C1
@@ -85,35 +85,16 @@ config MACH_SMDKC210
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
-	select S5PV310_DEV_PD
-	select S5PV310_SETUP_I2C1
-	select S5PV310_SETUP_SDHCI
-	select S5PV310_DEV_SYSMMU
+	select EXYNOS4_DEV_PD
+	select EXYNOS4_DEV_SYSMMU
+	select EXYNOS4_SETUP_I2C1
+	select EXYNOS4_SETUP_SDHCI
 	help
 	  Machine support for Samsung SMDKC210
-	  S5PC210(MCP) is one of package option of S5PV310
-
-config MACH_UNIVERSAL_C210
-	bool "Mobile UNIVERSAL_C210 Board"
-	select CPU_S5PV310
-	select S5P_DEV_ONENAND
-	select S3C_DEV_HSMMC
-	select S3C_DEV_HSMMC2
-	select S3C_DEV_HSMMC3
-	select S5PV310_SETUP_SDHCI
-	select S3C_DEV_I2C1
-	select S5PV310_SETUP_I2C1
-	help
-	  Machine support for Samsung Mobile Universal S5PC210 Reference
-	  Board. S5PC210(MCP) is one of package option of S5PV310
-
-endmenu
-
-menu "S5PV310 Machines"
 
 config MACH_SMDKV310
 	bool "SMDKV310"
-	select CPU_S5PV310
+	select CPU_EXYNOS4210
 	select S3C_DEV_RTC
 	select S3C_DEV_WDT
 	select S3C_DEV_I2C1
@@ -121,26 +102,40 @@ config MACH_SMDKV310
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
-	select S5PV310_DEV_PD
-	select S5PV310_DEV_SYSMMU
-	select S5PV310_SETUP_I2C1
-	select S5PV310_SETUP_SDHCI
+	select EXYNOS4_DEV_PD
+	select EXYNOS4_DEV_SYSMMU
+	select EXYNOS4_SETUP_I2C1
+	select EXYNOS4_SETUP_SDHCI
 	help
 	  Machine support for Samsung SMDKV310
 
+config MACH_UNIVERSAL_C210
+	bool "Mobile UNIVERSAL_C210 Board"
+	select CPU_EXYNOS4210
+	select S3C_DEV_HSMMC
+	select S3C_DEV_HSMMC2
+	select S3C_DEV_HSMMC3
+	select S3C_DEV_I2C1
+	select S5P_DEV_ONENAND
+	select EXYNOS4_SETUP_I2C1
+	select EXYNOS4_SETUP_SDHCI
+	help
+	  Machine support for Samsung Mobile Universal S5PC210 Reference
+	  Board.
+
 endmenu
 
 comment "Configuration for HSMMC bus width"
 
 menu "Use 8-bit bus width"
 
-config S5PV310_SDHCI_CH0_8BIT
+config EXYNOS4_SDHCI_CH0_8BIT
 	bool "Channel 0 with 8-bit bus"
 	help
 	  Support HSMMC Channel 0 8-bit bus.
 	  If selected, Channel 1 is disabled.
 
-config S5PV310_SDHCI_CH2_8BIT
+config EXYNOS4_SDHCI_CH2_8BIT
 	bool "Channel 2 with 8-bit bus"
 	help
 	  Support HSMMC Channel 2 8-bit bus.
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
new file mode 100644
index 0000000..0558235
--- /dev/null
+++ b/arch/arm/mach-exynos4/Makefile
@@ -0,0 +1,43 @@
+# arch/arm/mach-exynos4/Makefile
+#
+# Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
+#		http://www.samsung.com/
+#
+# Licensed under GPLv2
+
+obj-y				:=
+obj-m				:=
+obj-n				:=
+obj-				:=
+
+# Core support for EXYNOS4 system
+
+obj-$(CONFIG_CPU_EXYNOS4210)	+= cpu.o init.o clock.o irq-combiner.o
+obj-$(CONFIG_CPU_EXYNOS4210)	+= setup-i2c0.o time.o gpiolib.o irq-eint.o dma.o
+obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
+
+obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
+obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
+
+# machine support
+
+obj-$(CONFIG_MACH_SMDKC210)		+= mach-smdkc210.o
+obj-$(CONFIG_MACH_SMDKV310)		+= mach-smdkv310.o
+obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
+
+# device support
+
+obj-y					+= dev-audio.o
+obj-$(CONFIG_EXYNOS4_DEV_PD)		+= dev-pd.o
+obj-$(CONFIG_EXYNOS4_DEV_SYSMMU)	+= dev-sysmmu.o
+
+obj-$(CONFIG_EXYNOS4_SETUP_I2C1)	+= setup-i2c1.o
+obj-$(CONFIG_EXYNOS4_SETUP_I2C2)	+= setup-i2c2.o
+obj-$(CONFIG_EXYNOS4_SETUP_I2C3)	+= setup-i2c3.o
+obj-$(CONFIG_EXYNOS4_SETUP_I2C4)	+= setup-i2c4.o
+obj-$(CONFIG_EXYNOS4_SETUP_I2C5)	+= setup-i2c5.o
+obj-$(CONFIG_EXYNOS4_SETUP_I2C6)	+= setup-i2c6.o
+obj-$(CONFIG_EXYNOS4_SETUP_I2C7)	+= setup-i2c7.o
+obj-$(CONFIG_EXYNOS4_SETUP_SDHCI)	+= setup-sdhci.o
+obj-$(CONFIG_EXYNOS4_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
diff --git a/arch/arm/mach-s5pv310/Makefile.boot b/arch/arm/mach-exynos4/Makefile.boot
similarity index 100%
rename from arch/arm/mach-s5pv310/Makefile.boot
rename to arch/arm/mach-exynos4/Makefile.boot
diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
deleted file mode 100644
index 036fb38..0000000
--- a/arch/arm/mach-s5pv310/Makefile
+++ /dev/null
@@ -1,43 +0,0 @@
-# arch/arm/mach-s5pv310/Makefile
-#
-# Copyright (c) 2010 Samsung Electronics Co., Ltd.
-#		http://www.samsung.com/
-#
-# Licensed under GPLv2
-
-obj-y				:=
-obj-m				:=
-obj-n				:=
-obj-				:=
-
-# Core support for S5PV310 system
-
-obj-$(CONFIG_CPU_S5PV310)	+= cpu.o init.o clock.o irq-combiner.o
-obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o time.o gpiolib.o irq-eint.o dma.o
-obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
-
-obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
-obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
-obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-
-# machine support
-
-obj-$(CONFIG_MACH_SMDKC210)	+= mach-smdkc210.o
-obj-$(CONFIG_MACH_SMDKV310)	+= mach-smdkv310.o
-obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
-
-# device support
-
-obj-y					+= dev-audio.o
-obj-$(CONFIG_S5PV310_DEV_PD)		+= dev-pd.o
-obj-$(CONFIG_S5PV310_DEV_SYSMMU)	+= dev-sysmmu.o
-
-obj-$(CONFIG_S5PV310_SETUP_I2C1)	+= setup-i2c1.o
-obj-$(CONFIG_S5PV310_SETUP_I2C2)	+= setup-i2c2.o
-obj-$(CONFIG_S5PV310_SETUP_I2C3)	+= setup-i2c3.o
-obj-$(CONFIG_S5PV310_SETUP_I2C4)	+= setup-i2c4.o
-obj-$(CONFIG_S5PV310_SETUP_I2C5)	+= setup-i2c5.o
-obj-$(CONFIG_S5PV310_SETUP_I2C6)	+= setup-i2c6.o
-obj-$(CONFIG_S5PV310_SETUP_I2C7)	+= setup-i2c7.o
-obj-$(CONFIG_S5PV310_SETUP_SDHCI)	+= setup-sdhci.o
-obj-$(CONFIG_S5PV310_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9d30c6f..f93f675 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -812,7 +812,7 @@ config CACHE_L2X0
 	bool "Enable the L2x0 outer cache controller"
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
 		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || \
-		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_S5PV310 || ARCH_TEGRA || \
+		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_EXYNOS4 || ARCH_TEGRA || \
 		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE
 	default y
 	select OUTER_CACHE
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 557f8c5..6390ac7 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -7,10 +7,10 @@
 
 config PLAT_S5P
 	bool
-	depends on (ARCH_S5P64X0 || ARCH_S5P6442 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5PV310)
+	depends on (ARCH_S5P64X0 || ARCH_S5P6442 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS4)
 	default y
-	select ARM_VIC if !ARCH_S5PV310
-	select ARM_GIC if ARCH_S5PV310
+	select ARM_VIC if !ARCH_EXYNOS4
+	select ARM_GIC if ARCH_EXYNOS4
 	select NO_IOPORT
 	select ARCH_REQUIRE_GPIOLIB
 	select S3C_GPIO_TRACK
@@ -41,7 +41,7 @@ comment "System MMU"
 
 config S5P_SYSTEM_MMU
 	bool "S5P SYSTEM MMU"
-	depends on ARCH_S5PV310
+	depends on ARCH_EXYNOS4
 	help
 	  Say Y here if you want to enable System MMU
 
-- 
1.7.1
