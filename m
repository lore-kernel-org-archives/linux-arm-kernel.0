From: robherring2@gmail.com (Rob Herring)
Date: Thu,  6 Sep 2012 15:12:55 -0500
Subject: [PATCH 12/12] ARM: vexpress: convert to multi-platform
In-Reply-To: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346962375-26163-13-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert vexpress to multi-platform. This always enables vexpress DT and
makes it the default v7 platform.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/Kconfig                     |   19 +---------
 arch/arm/mach-vexpress/Kconfig       |   64 +++++++++++++++++-----------------
 arch/arm/mach-vexpress/Makefile      |    2 ++
 arch/arm/mach-vexpress/Makefile.boot |    5 ---
 arch/arm/mach-vexpress/v2m.c         |    4 ---
 arch/arm/plat-versatile/Makefile     |    2 ++
 6 files changed, 37 insertions(+), 59 deletions(-)
 delete mode 100644 arch/arm/mach-vexpress/Makefile.boot

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ebaf088..16773aa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -319,24 +319,6 @@ config ARCH_VERSATILE
 	help
 	  This enables support for ARM Ltd Versatile board.
 
-config ARCH_VEXPRESS
-	bool "ARM Ltd. Versatile Express family"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_AMBA
-	select ARM_TIMER_SP804
-	select CLKDEV_LOOKUP
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK
-	select HAVE_PATA_PLATFORM
-	select ICST
-	select NO_IOPORT
-	select PLAT_VERSATILE
-	select PLAT_VERSATILE_CLCD
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	help
-	  This enables support for the ARM Ltd Versatile Express boards.
-
 config ARCH_AT91
 	bool "Atmel AT91"
 	select ARCH_REQUIRE_GPIOLIB
@@ -1016,6 +998,7 @@ config ARCH_MULTI_V6
 config ARCH_MULTI_V7
 	bool "ARMv7 based platforms (Cortex-A, PJ4, Krait)"
 	select CPU_V7
+	select ARCH_VEXPRESS
 	default y
 	select ARCH_MULTI_V6_V7
 
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index fc3730f..c952960 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -1,38 +1,23 @@
-menu "Versatile Express platform type"
-	depends on ARCH_VEXPRESS
-
-config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
-	bool "Enable A5 and A9 only errata work-arounds"
-	default y
-	select ARM_ERRATA_720789
-	select ARM_ERRATA_751472
-	select PL310_ERRATA_753970 if CACHE_PL310
-	help
-	  Provides common dependencies for Versatile Express platforms
-	  based on Cortex-A5 and Cortex-A9 processors. In order to
-	  build a working kernel, you must also enable relevant core
-	  tile support or Flattened Device Tree based support options.
-
-config ARCH_VEXPRESS_CA9X4
-	bool "Versatile Express Cortex-A9x4 tile"
-	select ARM_GIC
-	select CPU_V7
-	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
-
-config ARCH_VEXPRESS_DT
-	bool "Device Tree support for Versatile Express platforms"
+config ARCH_VEXPRESS
+	bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_AMBA
 	select ARM_GIC
-	select ARM_PATCH_PHYS_VIRT
-	select AUTO_ZRELADDR
+	select ARM_TIMER_SP804
+	select CLKDEV_LOOKUP
+	select COMMON_CLK
 	select CPU_V7
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK
+	select HAVE_PATA_PLATFORM
 	select HAVE_SMP
+	select ICST
 	select MIGHT_HAVE_CACHE_L2X0
-	select USE_OF
+	select NO_IOPORT
+	select PLAT_VERSATILE
+	select PLAT_VERSATILE_CLCD
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
-	  New Versatile Express platforms require Flattened Device Tree to
-	  be passed to the kernel.
-
 	  This option enables support for systems using Cortex processor based
 	  ARM core and logic (FPGA) tiles on the Versatile Express motherboard,
 	  for example:
@@ -48,7 +33,22 @@ config ARCH_VEXPRESS_DT
 	  platforms. The traditional (ATAGs) boot method is not usable on
 	  these boards with this option.
 
-	  If your bootloader supports Flattened Device Tree based booting,
-	  say Y here.
+menu "Versatile Express platform type"
+	depends on ARCH_VEXPRESS
+
+config ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA
+	bool "Enable A5 and A9 only errata work-arounds"
+	default y
+	select ARM_ERRATA_720789
+	select ARM_ERRATA_751472
+	select PL310_ERRATA_753970 if CACHE_PL310
+	help
+	  Provides common dependencies for Versatile Express platforms
+	  based on Cortex-A5 and Cortex-A9 processors. In order to
+	  build a working kernel, you must also enable relevant core
+	  tile support or Flattened Device Tree based support options.
+
+config ARCH_VEXPRESS_CA9X4
+	bool "Versatile Express Cortex-A9x4 tile"
 
 endmenu
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 90551b9..42703e8 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -1,6 +1,8 @@
 #
 # Makefile for the linux kernel.
 #
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
+	-I$(srctree)/arch/arm/plat-versatile/include
 
 obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
deleted file mode 100644
index c6dd891..0000000
--- a/arch/arm/mach-vexpress/Makefile.boot
+++ /dev/null
@@ -1,5 +0,0 @@
-# Those numbers are used only by the non-DT V2P-CA9 platform
-# The DT-enabled ones require CONFIG_AUTO_ZRELADDR=y
-   zreladdr-y	+= 0x60008000
-params_phys-y	:= 0x60000100
-initrd_phys-y	:= 0x60800000
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 37608f2..2ca86c5 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -539,8 +539,6 @@ MACHINE_START(VEXPRESS, "ARM-Versatile Express")
 	.restart	= v2m_restart,
 MACHINE_END
 
-#if defined(CONFIG_ARCH_VEXPRESS_DT)
-
 static struct map_desc v2m_rs1_io_desc __initdata = {
 	.virtual	= V2M_PERIPH,
 	.pfn		= __phys_to_pfn(0x1c000000),
@@ -671,5 +669,3 @@ DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
 	.handle_irq	= gic_handle_irq,
 	.restart	= v2m_restart,
 MACHINE_END
-
-#endif
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 272769a8..74cfd94 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,3 +1,5 @@
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
+
 obj-$(CONFIG_PLAT_VERSATILE_CLOCK) += clock.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
 obj-$(CONFIG_PLAT_VERSATILE_FPGA_IRQ) += fpga-irq.o
-- 
1.7.9.5
