From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Fri, 7 Nov 2014 16:43:19 +0000
Subject: Q: PHYS_OFFSET of 0xf0000000
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D882602B0E2@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

I have an ep93xx user with a board that uses physical address
0xf0000000 as the base address for the SDRAM on their board.
Currently they are using an old 2.6.20 kernel with no problems.
They are trying to use a 3.x kernel and the system does not
boot.

I sent them a patch to use ARM_PATCH_PHYS_VIRT and
AUTO_ZRELADDR instead of the hardcoded PHYS_OFFSET
on the ARCH_EP93XX platform but the 0xf0000000 physical
address still does not work.

The patched kernel (3.17.2) does boot on boards with the SDRAM
located at physical address 0x00000000 and 0xc0000000. These
boards boot with the following information in the boot log:

Memory: 60056K/65536K available (3432K kernel code, 185K rwdata, 976K rodata, 133K init, 107K bss, 5480K reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
    vmalloc : 0xc6800000 - 0xff000000   ( 904 MB)
    lowmem  : 0xc0000000 - 0xc6000000   (  96 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc0456274   (4409 kB)
      .init : 0xc0457000 - 0xc04785cc   ( 134 kB)
      .data : 0xc047a000 - 0xc04a8700   ( 186 kB)
       .bss : 0xc04a8700 - 0xc04c365c   ( 108 kB)

Would the 0xf0000000 physical address be a problem
since it's located in the vmalloc range?

Any ideas on what to do?

Following is a copy of the patch I sent them to test.

Regards,
Hartley

---

>From 4d11e5103003f3e6caa5660c216df2da1aa8f6fd Mon Sep 17 00:00:00 2001
From: H Hartley Sweeten <hsweeten@visionengravers.com>
Date: Mon, 20 Oct 2014 11:34:09 -0700
Subject: [PATCH] arm: ep93xx: remove memory configuration options

The ARM_PATCH_PHYS_VIRT option makes the ep93xx memory configuration
options obsolete.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
---
 arch/arm/Kconfig                   |  8 +++---
 arch/arm/mach-ep93xx/Kconfig       | 54 --------------------------------------
 arch/arm/mach-ep93xx/Makefile.boot | 15 +----------
 3 files changed, 4 insertions(+), 73 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9d580d0..fbccf49 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -263,7 +263,6 @@ config PHYS_OFFSET
 	depends on !ARM_PATCH_PHYS_VIRT
 	default DRAM_BASE if !MMU
 	default 0x00000000 if ARCH_EBSA110 || \
-			EP93XX_SDCE3_SYNC_PHYS_OFFSET || \
 			ARCH_FOOTBRIDGE || \
 			ARCH_INTEGRATOR || \
 			ARCH_IOP13XX || \
@@ -272,10 +271,7 @@ config PHYS_OFFSET
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
@@ -424,7 +420,9 @@ config ARCH_EP93XX
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_USES_GETTIMEOFFSET
 	select ARM_AMBA
+	select ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
+	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
 	select CPU_ARM920T
 	help
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
2.0.3
