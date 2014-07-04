From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 04 Jul 2014 19:48:16 +0200
Subject: [PATCH 16/19] ARM: s5pv210: Enable multi-platform build support
In-Reply-To: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
Message-ID: <1404496099-26708-17-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes it possible to enable the s5pv210 platform as part of a
multiplatform kernel. Also redundant Kconfig options are removed.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/Kconfig                    | 23 ++---------------------
 arch/arm/Makefile                   |  4 ++--
 arch/arm/mach-s5pv210/Kconfig       | 36 ++++++++++++++++--------------------
 arch/arm/mach-s5pv210/Makefile      |  7 +++----
 arch/arm/mach-s5pv210/Makefile.boot |  2 --
 arch/arm/plat-samsung/Makefile      |  1 -
 arch/arm/plat-samsung/cpu.c         |  2 +-
 7 files changed, 24 insertions(+), 51 deletions(-)
 delete mode 100644 arch/arm/mach-s5pv210/Makefile.boot

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c0c1c3f..756711f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -758,26 +758,6 @@ config ARCH_S3C64XX
 	help
 	  Samsung S3C64XX series based systems
 
-config ARCH_S5PV210
-	bool "Samsung S5PV210/S5PC110"
-	select ARCH_HAS_HOLES_MEMORYMODEL
-	select ARCH_SPARSEMEM_ENABLE
-	select ATAGS
-	select CLKDEV_LOOKUP
-	select CLKSRC_SAMSUNG_PWM
-	select COMMON_CLK_SAMSUNG
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
-	select GPIO_SAMSUNG
-	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select HAVE_S3C_RTC if RTC_CLASS
-	select NEED_MACH_GPIO_H
-	select NEED_MACH_MEMORY_H
-	select SAMSUNG_ATAGS
-	help
-	  Samsung S5PV210/S5PC110 series based systems
-
 config ARCH_DAVINCI
 	bool "TI DaVinci"
 	select ARCH_HAS_HOLES_MEMORYMODEL
@@ -1515,7 +1495,8 @@ config ARM_PSCI
 config ARCH_NR_GPIO
 	int
 	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
-	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || SOC_DRA7XX || ARCH_S3C24XX || ARCH_S3C64XX
+	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || \
+		SOC_DRA7XX || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
 	default 416 if ARCH_SUNXI
 	default 392 if ARCH_U8500
 	default 352 if ARCH_VT8500
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d3f470c..c133061 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -210,11 +210,11 @@ machine-$(CONFIG_PLAT_SPEAR)		+= spear
 plat-$(CONFIG_ARCH_EXYNOS)	+= samsung
 plat-$(CONFIG_ARCH_OMAP)	+= omap
 plat-$(CONFIG_ARCH_S3C64XX)	+= samsung
+plat-$(CONFIG_ARCH_S5PV210)	+= samsung
 plat-$(CONFIG_PLAT_IOP)		+= iop
 plat-$(CONFIG_PLAT_ORION)	+= orion
 plat-$(CONFIG_PLAT_PXA)		+= pxa
 plat-$(CONFIG_PLAT_S3C24XX)	+= samsung
-plat-$(CONFIG_PLAT_S5P)		+= samsung
 plat-$(CONFIG_PLAT_VERSATILE)	+= versatile
 
 ifeq ($(CONFIG_ARCH_EBSA110),y)
@@ -238,7 +238,7 @@ MACHINE  :=
 endif
 
 machdirs := $(patsubst %,arch/arm/mach-%/,$(machine-y))
-platdirs := $(patsubst %,arch/arm/plat-%/,$(plat-y))
+platdirs := $(patsubst %,arch/arm/plat-%/,$(sort $(plat-y)))
 
 ifneq ($(CONFIG_ARCH_MULTIPLATFORM),y)
 ifeq ($(KBUILD_SRC),)
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index ffc777d..330bfc8 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -7,32 +7,28 @@
 
 # Configuration options for the S5PV210/S5PC110
 
+config ARCH_S5PV210
+	bool "Samsung S5PV210/S5PC110" if ARCH_MULTI_V7
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_VIC
+	select CLKSRC_SAMSUNG_PWM
+	select COMMON_CLK_SAMSUNG
+	select HAVE_S3C2410_I2C if I2C
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select HAVE_S3C_RTC if RTC_CLASS
+	select PINCTRL
+	select PINCTRL_EXYNOS
+	help
+	  Samsung S5PV210/S5PC110 series based systems
+
 if ARCH_S5PV210
 
 config CPU_S5PV210
-	bool
+	def_bool y
 	select ARM_AMBA
 	select PL330_DMA if DMADEVICES
-	select S5P_EXT_INT
 	help
 	  Enable S5PV210 CPU support
 
-menu "S5PV210 Machines"
-
-config MACH_S5PV210_DT
-	bool "Samsung S5PV210/S5PC110 machine using Device Tree"
-	select CLKSRC_OF
-	select CPU_S5PV210
-	select PINCTRL
-	select PINCTRL_EXYNOS
-	select USE_OF
-	help
-	  Machine support for Samsung S5PV210/S5PC110 machines with Device Tree
-	  enabled.
-	  Select this if a fdt blob is available for your S5PV210 SoC based
-	  board.
-	  Note: This is under development and not all peripherals can be
-	  supported with this machine file.
-endmenu
-
 endif
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 5308225..7dc2d0e 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -5,6 +5,8 @@
 #
 # Licensed under GPLv2
 
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-samsung/include
+
 obj-y				:=
 obj-m				:=
 obj-n				:=
@@ -16,7 +18,4 @@ obj-$(CONFIG_PM_SLEEP)		+= pm.o sleep.o
 
 # machine support
 
-obj-$(CONFIG_MACH_S5PV210_DT)	+= s5pv210.o
-# device support
-
-obj-y					+= setup-i2c0.o
+obj-y				+= s5pv210.o
diff --git a/arch/arm/mach-s5pv210/Makefile.boot b/arch/arm/mach-s5pv210/Makefile.boot
deleted file mode 100644
index 79ece40..0000000
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 906f54b..97fc15e 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -5,7 +5,6 @@
 # Licensed under GPLv2
 
 ccflags-$(CONFIG_ARCH_MULTI_V7) += -I$(srctree)/$(src)/include
-ccflags-$(CONFIG_ARCH_EXYNOS)	+= -I$(srctree)/arch/arm/mach-exynos/include
 
 obj-y				:=
 obj-m				:=
diff --git a/arch/arm/plat-samsung/cpu.c b/arch/arm/plat-samsung/cpu.c
index 364963a..945fc3f 100644
--- a/arch/arm/plat-samsung/cpu.c
+++ b/arch/arm/plat-samsung/cpu.c
@@ -16,7 +16,7 @@
 #include <linux/io.h>
 
 
-#include <mach/map.h>
+#include <plat/map-base.h>
 #include <plat/cpu.h>
 
 unsigned long samsung_cpu_id;
-- 
1.9.3
