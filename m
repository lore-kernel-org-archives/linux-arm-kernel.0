From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 Jun 2010 11:03:31 -0500
Subject: [PATCH] ARM: Add ARCH_HAS_L2X0 and make CACHE_L2X0 config depend on
	that
In-Reply-To: <6fqujhaev78923q90va>
References: <6fqujhaev78923q90va>
Message-ID: <1276272211-13065-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It normally scales better if each platform that has <foo> selects the
ARCH_HAS_<foo> option, instead of having to add every single one to the
depends line.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/Kconfig               |    2 ++
 arch/arm/mach-mx3/Kconfig      |    2 ++
 arch/arm/mach-realview/Kconfig |    5 +++++
 arch/arm/mach-vexpress/Kconfig |    1 +
 arch/arm/mm/Kconfig            |    8 +++++---
 arch/arm/plat-omap/Kconfig     |    1 +
 6 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1f254bd..6800b4b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -748,6 +748,7 @@ config ARCH_U8500
 	select GENERIC_CLOCKEVENTS
 	select COMMON_CLKDEV
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_L2X0
 	help
 	  Support for ST-Ericsson's Ux500 architecture
 
@@ -759,6 +760,7 @@ config ARCH_NOMADIK
 	select COMMON_CLKDEV
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_L2X0
 	help
 	  Support for the Nomadik platform by ST-Ericsson
 
diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 344753f..a4cd462 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -3,12 +3,14 @@ if ARCH_MX3
 config ARCH_MX31
 	select ARCH_HAS_RNGA
 	select ARCH_MXC_AUDMUX_V2
+	select ARCH_HAS_L2X0
 	bool
 
 config ARCH_MX35
 	bool
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
+	select ARCH_HAS_L2X0
 
 comment "MX3 platforms:"
 
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index ee5e392..24077e8 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -11,6 +11,7 @@ config REALVIEW_EB_A9MP
 	bool "Support Multicore Cortex-A9"
 	depends on MACH_REALVIEW_EB
 	select CPU_V7
+	select ARCH_HAS_L2X0
 	help
 	  Enable support for the Cortex-A9MPCore tile on the Realview platform.
 
@@ -18,6 +19,7 @@ config REALVIEW_EB_ARM11MP
 	bool "Support ARM11MPCore tile"
 	depends on MACH_REALVIEW_EB
 	select CPU_V6
+	select ARCH_HAS_L2X0
 	help
 	  Enable support for the ARM11MPCore tile on the Realview platform.
 
@@ -35,6 +37,7 @@ config MACH_REALVIEW_PB11MP
 	select CPU_V6
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
+	select ARCH_HAS_L2X0
 	help
 	  Include support for the ARM(R) RealView MPCore Platform Baseboard.
 	  PB11MPCore is a platform with an on-board ARM11MPCore and has
@@ -44,6 +47,7 @@ config MACH_REALVIEW_PB1176
 	bool "Support RealView/PB1176 platform"
 	select CPU_V6
 	select ARM_GIC
+	select ARCH_HAS_L2X0
 	help
 	  Include support for the ARM(R) RealView ARM1176 Platform Baseboard.
 
@@ -72,6 +76,7 @@ config MACH_REALVIEW_PBX
 	select HAVE_PATA_PLATFORM
 	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
 	select ZONE_DMA if SPARSEMEM
+	select ARCH_HAS_L2X0
 	help
 	  Include support for the ARM(R) RealView PBX platform.
 
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 3f19b66..8cc4281 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -5,5 +5,6 @@ config ARCH_VEXPRESS_CA9X4
 	bool "Versatile Express Cortex-A9x4 tile"
 	select CPU_V7
 	select ARM_GIC
+	select ARCH_HAS_L2X0
 
 endmenu
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 346ae14..419b957 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -759,11 +759,13 @@ config CACHE_FEROCEON_L2_WRITETHROUGH
 	  Say Y here to use the Feroceon L2 cache in writethrough mode.
 	  Unless you specifically require this, say N for writeback mode.
 
+config ARCH_HAS_L2X0
+	bool
+	default n
+
 config CACHE_L2X0
 	bool "Enable the L2x0 outer cache controller"
-	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
-		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || \
-		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_U8500 || ARCH_VEXPRESS_CA9X4
+	depends on ARCH_HAS_L2X0
 	default y
 	select OUTER_CACHE
 	select OUTER_CACHE_SYNC
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 78b49a6..2e42717 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -38,6 +38,7 @@ config ARCH_OMAP4
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
 	select ARM_GIC
+	select ARCH_HAS_L2X0
 
 endchoice
 
-- 
1.5.6.5
