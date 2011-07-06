From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 23:29:54 -0400
Subject: [PATCH 10/37] ARM: mach-ep93xx: remove mach/memory.h and Kconfig
	selection of SDRAM bank
In-Reply-To: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309923021-23487-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309923021-23487-10-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This all can be selected automatically by default at run time.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/Kconfig                           |    2 +
 arch/arm/mach-ep93xx/Kconfig               |   53 ----------------------------
 arch/arm/mach-ep93xx/Makefile.boot         |   14 -------
 arch/arm/mach-ep93xx/include/mach/memory.h |   22 -----------
 4 files changed, 2 insertions(+), 89 deletions(-)
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c4b6e4a..48b2e88 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -371,6 +371,8 @@ config ARCH_EP93XX
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_USES_GETTIMEOFFSET
+	select NO_MACH_MEMORY_H
+	select AUTO_ZRELADDR if !ZBOOT_ROM
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 3a08b18..d09da10 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -9,45 +9,8 @@ config CRUNCH
 
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
@@ -57,7 +20,6 @@ config MACH_EDB93XX
 
 config MACH_EDB9301
 	bool "Support Cirrus Logic EDB9301"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
@@ -65,7 +27,6 @@ config MACH_EDB9301
 
 config MACH_EDB9302
 	bool "Support Cirrus Logic EDB9302"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
@@ -73,7 +34,6 @@ config MACH_EDB9302
 
 config MACH_EDB9302A
 	bool "Support Cirrus Logic EDB9302A"
-	depends on EP93XX_SDCE0_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
@@ -81,7 +41,6 @@ config MACH_EDB9302A
 
 config MACH_EDB9307
 	bool "Support Cirrus Logic EDB9307"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
@@ -89,7 +48,6 @@ config MACH_EDB9307
 
 config MACH_EDB9307A
 	bool "Support Cirrus Logic EDB9307A"
-	depends on EP93XX_SDCE0_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
@@ -97,7 +55,6 @@ config MACH_EDB9307A
 
 config MACH_EDB9312
 	bool "Support Cirrus Logic EDB9312"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
@@ -105,7 +62,6 @@ config MACH_EDB9312
 
 config MACH_EDB9315
 	bool "Support Cirrus Logic EDB9315"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_EDB93XX
 	help
 	  Say 'Y' here if you want your kernel to support the Cirrus
@@ -113,14 +69,12 @@ config MACH_EDB9315
 
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
@@ -131,7 +85,6 @@ config MACH_MICRO9
 
 config MACH_MICRO9H
 	bool "Support Contec Micro9-High"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_MICRO9
 	help
 	  Say 'Y' here if you want your kernel to support the
@@ -139,7 +92,6 @@ config MACH_MICRO9H
 
 config MACH_MICRO9M
 	bool "Support Contec Micro9-Mid"
-	depends on EP93XX_SDCE3_ASYNC_PHYS_OFFSET
 	select MACH_MICRO9
 	help
 	  Say 'Y' here if you want your kernel to support the
@@ -147,7 +99,6 @@ config MACH_MICRO9M
 
 config MACH_MICRO9L
 	bool "Support Contec Micro9-Lite"
-	depends on EP93XX_SDCE3_SYNC_PHYS_OFFSET
 	select MACH_MICRO9
 	help
 	  Say 'Y' here if you want your kernel to support the
@@ -155,7 +106,6 @@ config MACH_MICRO9L
 
 config MACH_MICRO9S
 	bool "Support Contec Micro9-Slim"
-	depends on EP93XX_SDCE3_ASYNC_PHYS_OFFSET
 	select MACH_MICRO9
 	help
 	  Say 'Y' here if you want your kernel to support the
@@ -163,21 +113,18 @@ config MACH_MICRO9S
 
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
diff --git a/arch/arm/mach-ep93xx/Makefile.boot b/arch/arm/mach-ep93xx/Makefile.boot
index 0ad33f1..e69de29 100644
--- a/arch/arm/mach-ep93xx/Makefile.boot
+++ b/arch/arm/mach-ep93xx/Makefile.boot
@@ -1,14 +0,0 @@
-   zreladdr-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	:= 0x00008000
-params_phys-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	:= 0x00000100
-
-   zreladdr-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		:= 0xc0008000
-params_phys-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		:= 0xc0000100
-
-   zreladdr-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		:= 0xd0008000
-params_phys-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		:= 0xd0000100
-
-   zreladdr-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		:= 0xe0008000
-params_phys-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		:= 0xe0000100
-
-   zreladdr-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	:= 0xf0008000
-params_phys-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	:= 0xf0000100
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
1.7.4
