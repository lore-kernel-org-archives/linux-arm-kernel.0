From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 02 Apr 2010 12:36:36 -0700
Subject: [RFC PATCH] arm: kconfig: push down CACHE_L2X0
Message-ID: <1270236996.26326.7.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Does it make sense to push down this value? It looks like it's just
adding more and more sub-architectures .. Is the method below
acceptable?

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 3872af1..565d176 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -3,12 +3,14 @@ if ARCH_MX3
 config ARCH_MX31
 	select ARCH_HAS_RNGA
 	select ARCH_MXC_AUDMUX_V2
+	select HAS_CACHE_L2X0
 	bool
 
 config ARCH_MX35
 	bool
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
+	select HAS_CACHE_L2X0
 
 comment "MX3 platforms:"
 
diff --git a/arch/arm/mach-nomadik/Kconfig b/arch/arm/mach-nomadik/Kconfig
index 3c5e0f5..2445be4 100644
--- a/arch/arm/mach-nomadik/Kconfig
+++ b/arch/arm/mach-nomadik/Kconfig
@@ -6,7 +6,7 @@ config MACH_NOMADIK_8815NHK
 	bool "ST 8815 Nomadik Hardware Kit (evaluation board)"
 	select NOMADIK_8815
 	select HAS_MTU
-
+	select HAS_CACHE_L2X0
 endmenu
 
 config NOMADIK_8815
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index ee5e392..8557db7 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -11,6 +11,7 @@ config REALVIEW_EB_A9MP
 	bool "Support Multicore Cortex-A9"
 	depends on MACH_REALVIEW_EB
 	select CPU_V7
+	select HAS_CACHE_L2X0
 	help
 	  Enable support for the Cortex-A9MPCore tile on the Realview platform.
 
@@ -18,6 +19,7 @@ config REALVIEW_EB_ARM11MP
 	bool "Support ARM11MPCore tile"
 	depends on MACH_REALVIEW_EB
 	select CPU_V6
+	select HAS_CACHE_L2X0
 	help
 	  Enable support for the ARM11MPCore tile on the Realview platform.
 
@@ -35,6 +37,7 @@ config MACH_REALVIEW_PB11MP
 	select CPU_V6
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
+	select HAS_CACHE_L2X0
 	help
 	  Include support for the ARM(R) RealView MPCore Platform Baseboard.
 	  PB11MPCore is a platform with an on-board ARM11MPCore and has
@@ -44,6 +47,7 @@ config MACH_REALVIEW_PB1176
 	bool "Support RealView/PB1176 platform"
 	select CPU_V6
 	select ARM_GIC
+	select HAS_CACHE_L2X0
 	help
 	  Include support for the ARM(R) RealView ARM1176 Platform Baseboard.
 
@@ -70,6 +74,7 @@ config MACH_REALVIEW_PBX
 	bool "Support RealView/PBX platform"
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
+	select HAS_CACHE_L2X0
 	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
 	select ZONE_DMA if SPARSEMEM
 	help
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c4ed9f9..cf96f7f 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -751,10 +751,12 @@ config CACHE_FEROCEON_L2_WRITETHROUGH
 	  Say Y here to use the Feroceon L2 cache in writethrough mode.
 	  Unless you specifically require this, say N for writeback mode.
 
+config HAS_CACHE_L2X0
+	bool
+
 config CACHE_L2X0
 	bool "Enable the L2x0 outer cache controller"
-	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
-		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || ARCH_NOMADIK || ARCH_OMAP4
+	depends on HAS_CACHE_L2X0
 	default y
 	select OUTER_CACHE
 	help
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 6da796e..cd19856 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -38,6 +38,7 @@ config ARCH_OMAP4
 	depends on ARCH_OMAP2PLUS
 	select CPU_V7
 	select ARM_GIC
+	select HAS_CACHE_L2X0
 
 endchoice
 
