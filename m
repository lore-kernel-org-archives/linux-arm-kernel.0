From: hsweeten@visionengravers.com (H Hartley Sweeten)
Date: Mon, 15 Jun 2015 10:35:06 -0700
Subject: [PATCH] ARM: ep93xx: remove memory configuration options
Message-ID: <1434389706-58739-1-git-send-email-hsweeten@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM_PATCH_PHYS_VIRT option makes the ep93xx memory configuration
options obsolete.

This allows support for all the ep93xx variations to be built into a
single kernel.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
---
 arch/arm/Kconfig                   |  8 +++---
 arch/arm/mach-ep93xx/Kconfig       | 54 --------------------------------------
 arch/arm/mach-ep93xx/Makefile.boot | 15 +----------
 3 files changed, 4 insertions(+), 73 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 00623a2..d504acc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -268,7 +268,6 @@ config PHYS_OFFSET
 	depends on !ARM_PATCH_PHYS_VIRT
 	default DRAM_BASE if !MMU
 	default 0x00000000 if ARCH_EBSA110 || \
-			EP93XX_SDCE3_SYNC_PHYS_OFFSET || \
 			ARCH_FOOTBRIDGE || \
 			ARCH_INTEGRATOR || \
 			ARCH_IOP13XX || \
@@ -277,10 +276,7 @@ config PHYS_OFFSET
 	default 0x10000000 if ARCH_OMAP1 || ARCH_RPC
 	default 0x20000000 if ARCH_S5PV210
 	default 0x70000000 if REALVIEW_HIGH_PHYS_OFFSET
-	default 0xc0000000 if EP93XX_SDCE0_PHYS_OFFSET || ARCH_SA1100
-	default 0xd0000000 if EP93XX_SDCE1_PHYS_OFFSET
-	default 0xe0000000 if EP93XX_SDCE2_PHYS_OFFSET
-	default 0xf0000000 if EP93XX_SDCE3_ASYNC_PHYS_OFFSET
+	default 0xc0000000 if ARCH_SA1100
 	help
 	  Please provide the physical address corresponding to the
 	  location of main memory in your system.
@@ -419,7 +415,9 @@ config ARCH_EP93XX
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
+	select ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
+	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select CPU_ARM920T
diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index bec570a..61a75ca 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -15,45 +15,8 @@ config CRUNCH
 
 comment "EP93xx Platforms"
 
-choice
-	prompt "EP93xx first SDRAM bank selection"
-	default EP93XX_SDCE3_SYNC_PHYS_OFFSET
-
-config EP93XX_SDCE3_SYNC_PHYS_OFFSET
-	bool "0x00000000 - SDCE3/SyncBoot"
-	help
-	  Select this option if you want support for EP93xx boards with the
-	  first SDRAM bank at 0x00000000.
-
-config EP93XX_SDCE0_PHYS_OFFSET
-	bool "0xc0000000 - SDCEO"
-	help
-	  Select this option if you want support for EP93xx boards with the
-	  first SDRAM bank at 0xc0000000.
-
-config EP93XX_SDCE1_PHYS_OFFSET
-	bool "0xd0000000 - SDCE1"
-	help
-	  Select this option if you want support for EP93xx boards with the
-	  first SDRAM bank at 0xd0000000.
-
-config EP93XX_SDCE2_PHYS_OFFSET
-	bool "0xe0000000 - SDCE2"
-	help
-	  Select this option if you want support for EP93xx boards with the
-	  first SDRAM bank at 0xe0000000.
-
-config EP93XX_SDCE3_ASYNC_PHYS_OFFSET
-	bool "0xf0000000 - SDCE3/AsyncBoot"
-	help
-	  Select this option if you want support for EP93xx boards with the
-	  first SDRAM bank at 0xf0000000.
-
-endchoice
-
 config MACH_ADSSPHERE
 	bool "Support ADS Sphere"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	help
 	  Say 'Y' here if you want your kernel to support the ADS
 	  Sphere board.
@@ -63,7 +26,6 @@ config MACH_EDB93XX
 
 config MACH_EDB9301
 	bool "Support Cirrus Logic EDB9301"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
@@ -71,7 +33,6 @@ config MACH_EDB9301
 
 config MACH_EDB9302
 	bool "Support Cirrus Logic EDB9302"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
@@ -79,7 +40,6 @@ config MACH_EDB9302
 
 config MACH_EDB9302A
 	bool "Support Cirrus Logic EDB9302A"
-	depends on EP93XX_SDCE0_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
@@ -87,7 +47,6 @@ config MACH_EDB9302A
 
 config MACH_EDB9307
 	bool "Support Cirrus Logic EDB9307"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
@@ -95,7 +54,6 @@ config MACH_EDB9307
 
 config MACH_EDB9307A
 	bool "Support Cirrus Logic EDB9307A"
-	depends on EP93XX_SDCE0_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
@@ -103,7 +61,6 @@ config MACH_EDB9307A
 
 config MACH_EDB9312
 	bool "Support Cirrus Logic EDB9312"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
@@ -111,7 +68,6 @@ config MACH_EDB9312
 
 config MACH_EDB9315
 	bool "Support Cirrus Logic EDB9315"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
@@ -119,14 +75,12 @@ config MACH_EDB9315
 
 config MACH_EDB9315A
 	bool "Support Cirrus Logic EDB9315A"
-	depends on EP93XX_SDCE0_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
 	  Logic EDB9315A Evaluation Board.
 
 config MACH_GESBC9312
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	bool "Support Glomation GESBC-9312-sx"
 	help
 	  Say 'Y' here if you want your kernel to support the Glomation
@@ -137,7 +91,6 @@ config MACH_MICRO9
 
 config MACH_MICRO9H
 	bool "Support Contec Micro9-High"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_MICRO9
 	help
 	  Say 'Y' here if you want your kernel to support the
@@ -145,7 +98,6 @@ config MACH_MICRO9H
 
 config MACH_MICRO9M
 	bool "Support Contec Micro9-Mid"
-	depends on EP93XX_SDCE3_ASYNC_PHYS_OFFSET
 	select MACH_MICRO9
 	help
 	  Say 'Y' here if you want your kernel to support the
@@ -153,7 +105,6 @@ config MACH_MICRO9M
 
 config MACH_MICRO9L
 	bool "Support Contec Micro9-Lite"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_MICRO9
 	help
 	  Say 'Y' here if you want your kernel to support the
@@ -161,7 +112,6 @@ config MACH_MICRO9L
 
 config MACH_MICRO9S
 	bool "Support Contec Micro9-Slim"
-	depends on EP93XX_SDCE3_ASYNC_PHYS_OFFSET
 	select MACH_MICRO9
 	help
 	  Say 'Y' here if you want your kernel to support the
@@ -169,28 +119,24 @@ config MACH_MICRO9S
 
 config MACH_SIM_ONE
         bool "Support Simplemachines Sim.One board"
-        depends on EP93XX_SDCE0_PHYS_OFFSET
         help
           Say 'Y' here if you want your kernel to support the
           Simplemachines Sim.One board.
 
 config MACH_SNAPPER_CL15
 	bool "Support Bluewater Systems Snapper CL15 Module"
-	depends on EP93XX_SDCE0_PHYS_OFFSET
 	help
 	  Say 'Y' here if you want your kernel to support the Bluewater
 	  Systems Snapper CL15 Module.
 
 config MACH_TS72XX
 	bool "Support Technologic Systems TS-72xx SBC"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Technologic Systems TS-72xx board.
 
 config MACH_VISION_EP9307
 	bool "Support Vision Engraving Systems EP9307 SoM"
-	depends on EP93XX_SDCE0_PHYS_OFFSET
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Vision Engraving Systems EP9307 SoM.
diff --git a/arch/arm/mach-ep93xx/Makefile.boot b/arch/arm/mach-ep93xx/Makefile.boot
index d3113a7..ed82ed7 100644
--- a/arch/arm/mach-ep93xx/Makefile.boot
+++ b/arch/arm/mach-ep93xx/Makefile.boot
@@ -1,14 +1 @@
-   zreladdr-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	+= 0x00008000
-params_phys-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	:= 0x00000100
-
-   zreladdr-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		+= 0xc0008000
-params_phys-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		:= 0xc0000100
-
-   zreladdr-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		+= 0xd0008000
-params_phys-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		:= 0xd0000100
-
-   zreladdr-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		+= 0xe0008000
-params_phys-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		:= 0xe0000100
-
-   zreladdr-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	+= 0xf0008000
-params_phys-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	:= 0xf0000100
+# Empty file waiting for deletion once Makefile.boot isn't needed any more.
-- 
2.3.0
