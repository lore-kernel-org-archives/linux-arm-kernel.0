From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 29 Nov 2011 16:32:25 +0000
Subject: [PATCH] ARM: pl2x0/pl310: Refactor Kconfig to be more maintainable
Message-ID: <1322584345-19193-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Making CACHE_L2X0 depends on (huge list of MACH_ and ARCH_ configs)
is bothersome to maintain and likely to lead to merge conflicts.

This patch moves the knowledge of which platforms have a L2x0 or
PL310 cache controller to the individual machines.  To enable this,
a new HAVE_L2X0_L2CC config option is introduced to allow machines
to indicate that they have such a cache controller independently of
each other.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/Kconfig               |    8 ++++++++
 arch/arm/mach-exynos/Kconfig   |    1 +
 arch/arm/mach-omap2/Kconfig    |    1 +
 arch/arm/mach-realview/Kconfig |    5 +++++
 arch/arm/mach-vexpress/Kconfig |    1 +
 arch/arm/mm/Kconfig            |   13 ++++++++-----
 arch/arm/plat-mxc/Kconfig      |    1 +
 7 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 44789ef..4068fe5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -339,6 +339,7 @@ config ARCH_HIGHBANK
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
 	select ARM_GIC
+	select HAVE_L2X0_L2CC
 	select ARM_TIMER_SP804
 	select CLKDEV_LOOKUP
 	select CPU_V7
@@ -359,6 +360,7 @@ config ARCH_CLPS711X
 config ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family"
 	select CPU_V6K
+	select HAVE_L2X0_L2CC
 	select GENERIC_CLOCKEVENTS
 	select ARM_GIC
 	select MIGHT_HAVE_PCI
@@ -377,6 +379,7 @@ config ARCH_GEMINI
 config ARCH_PRIMA2
 	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
 	select CPU_V7
+	select HAVE_L2X0_L2CC
 	select NO_IOPORT
 	select GENERIC_CLOCKEVENTS
 	select CLKDEV_LOOKUP
@@ -627,6 +630,7 @@ config ARCH_W90X900
 
 config ARCH_TEGRA
 	bool "NVIDIA Tegra"
+	select HAVE_L2X0_L2CC
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
@@ -699,6 +703,7 @@ config ARCH_MSM
 
 config ARCH_SHMOBILE
 	bool "Renesas SH-Mobile / R-Mobile"
+	select HAVE_L2X0_L2CC
 	select HAVE_CLK
 	select CLKDEV_LOOKUP
 	select HAVE_MACH_CLKDEV
@@ -900,6 +905,7 @@ config ARCH_U8500
 	bool "ST-Ericsson U8500 Series"
 	select CPU_V7
 	select ARM_AMBA
+	select HAVE_L2X0_L2CC
 	select GENERIC_CLOCKEVENTS
 	select CLKDEV_LOOKUP
 	select ARCH_REQUIRE_GPIOLIB
@@ -912,6 +918,7 @@ config ARCH_NOMADIK
 	select ARM_AMBA
 	select ARM_VIC
 	select CPU_ARM926T
+	select HAVE_L2X0_L2CC
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
@@ -968,6 +975,7 @@ config ARCH_VT8500
 config ARCH_ZYNQ
 	bool "Xilinx Zynq ARM Cortex A9 Platform"
 	select CPU_V7
+	select HAVE_L2X0_L2CC
 	select GENERIC_CLOCKEVENTS
 	select CLKDEV_LOOKUP
 	select ARM_GIC
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 724ec0f..b3eb318 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -17,6 +17,7 @@ choice
 
 config ARCH_EXYNOS4
 	bool "SAMSUNG EXYNOS4"
+	select HAVE_L2X0_L2CC
 	help
 	  Samsung EXYNOS4 SoCs based systems
 
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 5034147..f4e7e6a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -44,6 +44,7 @@ config ARCH_OMAP4
 	select CPU_V7
 	select ARM_GIC
 	select LOCAL_TIMERS if SMP
+	select HAVE_L2X0_L2CC
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
 	select ARM_ERRATA_720789
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index dba6d0c..3dfd6b8 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -12,6 +12,7 @@ config REALVIEW_EB_A9MP
 	bool "Support Multicore Cortex-A9 Tile"
 	depends on MACH_REALVIEW_EB
 	select CPU_V7
+	select HAVE_L2X0_L2CC
 	help
 	  Enable support for the Cortex-A9MPCore tile fitted to the
 	  Realview(R) Emulation Baseboard platform.
@@ -20,6 +21,7 @@ config REALVIEW_EB_ARM11MP
 	bool "Support ARM11MPCore Tile"
 	depends on MACH_REALVIEW_EB
 	select CPU_V6K
+	select HAVE_L2X0_L2CC
 	select ARCH_HAS_BARRIERS if SMP
 	help
 	  Enable support for the ARM11MPCore tile fitted to the Realview(R)
@@ -38,6 +40,7 @@ config MACH_REALVIEW_PB11MP
 	bool "Support RealView(R) Platform Baseboard for ARM11MPCore"
 	select CPU_V6K
 	select ARM_GIC
+	select HAVE_L2X0_L2CC
 	select HAVE_PATA_PLATFORM
 	select ARCH_HAS_BARRIERS if SMP
 	help
@@ -50,6 +53,7 @@ config MACH_REALVIEW_PB1176
 	bool "Support RealView(R) Platform Baseboard for ARM1176JZF-S"
 	select CPU_V6
 	select ARM_GIC
+	select HAVE_L2X0_L2CC
 	select HAVE_TCM
 	help
 	  Include support for the ARM(R) RealView(R) Platform Baseboard for
@@ -77,6 +81,7 @@ config MACH_REALVIEW_PBA8
 config MACH_REALVIEW_PBX
 	bool "Support RealView(R) Platform Baseboard Explore"
 	select ARM_GIC
+	select HAVE_L2X0_L2CC
 	select HAVE_PATA_PLATFORM
 	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
 	select ZONE_DMA if SPARSEMEM
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 9311484..78d4f28 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -5,6 +5,7 @@ config ARCH_VEXPRESS_CA9X4
 	bool "Versatile Express Cortex-A9x4 tile"
 	select CPU_V7
 	select ARM_GIC
+	select HAVE_L2X0_L2CC
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_751472
 	select ARM_ERRATA_753970
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 67f75a0..bb743df 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -816,13 +816,16 @@ config CACHE_FEROCEON_L2_WRITETHROUGH
 	  Say Y here to use the Feroceon L2 cache in writethrough mode.
 	  Unless you specifically require this, say N for writeback mode.
 
+config HAVE_L2X0_L2CC
+	bool
+	default n
+	help
+	  This option should be selected by machines which have a L2x0
+	  or PL310 cache controller.
+
 config CACHE_L2X0
 	bool "Enable the L2x0 outer cache controller"
-	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
-		   REALVIEW_EB_A9MP || ARCH_IMX_V6_V7 || MACH_REALVIEW_PBX || \
-		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_EXYNOS4 || ARCH_TEGRA || \
-		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE || \
-		   ARCH_PRIMA2 || ARCH_ZYNQ || ARCH_CNS3XXX || ARCH_HIGHBANK
+	depends on HAVE_L2X0_L2CC
 	default y
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index b3a1f2b..6871ed7 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -20,6 +20,7 @@ config ARCH_IMX_V6_V7
 	bool "i.MX3, i.MX6"
 	select AUTO_ZRELADDR if !ZBOOT_ROM
 	select ARM_PATCH_PHYS_VIRT
+	select HAVE_L2X0_L2CC
 	help
 	  This enables support for systems based on the Freescale i.MX3 and i.MX6
 	  family.
-- 
1.7.4.1
