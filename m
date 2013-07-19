From: hsweeten@visionengravers.com (H Hartley Sweeten)
Date: Thu, 18 Jul 2013 17:49:16 -0700
Subject: [PATCH] arm: ep93xx: remove memory configuration options
Message-ID: <201307181749.17093.hsweeten@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM_PATCH_PHYS_VIRT option makes the ep93xx memory configuration
options obsolete.

With this option enabled the physical address is detected according
to the position of the kernel in system memory at boot. If its disabled,
the user can enter the physical address manually in the config.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
---
I have tested this on ep93xx systems with the SDRAM at 0xc0000000.
If anyone has a system with a different SDRAM address please respond
with a Tested-by.

 arch/arm/Kconfig                           |  1 -
 arch/arm/mach-ep93xx/Kconfig               | 54 ------------------------------
 arch/arm/mach-ep93xx/include/mach/memory.h | 22 ------------
 3 files changed, 77 deletions(-)
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba412e0..29c039c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -413,7 +413,6 @@ config ARCH_EP93XX
 	select ARM_VIC
 	select CLKDEV_LOOKUP
 	select CPU_ARM920T
-	select NEED_MACH_MEMORY_H
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 91eee1d..a1107f4 100644
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
diff --git a/arch/arm/mach-ep93xx/include/mach/memory.h b/arch/arm/mach-ep93xx/include/mach/memory.h
deleted file mode 100644
index c9400cf..0000000
--- a/arch/arm/mach-ep93xx/include/mach/memory.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * arch/arm/mach-ep93xx/include/mach/memory.h
- */
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#if defined(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)
-#define PLAT_PHYS_OFFSET		UL(0x00000000)
-#elif defined(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)
-#define PLAT_PHYS_OFFSET		UL(0xc0000000)
-#elif defined(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)
-#define PLAT_PHYS_OFFSET		UL(0xd0000000)
-#elif defined(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)
-#define PLAT_PHYS_OFFSET		UL(0xe0000000)
-#elif defined(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)
-#define PLAT_PHYS_OFFSET		UL(0xf0000000)
-#else
-#error "Kconfig bug: No EP93xx PHYS_OFFSET set"
-#endif
-
-#endif
-- 
1.8.3.2
