From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Apr 2014 20:32:10 +0200
Subject: [Qemu-devel] Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <20140422175325.GD23955@obsidianresearch.com>
References: <534D0D91.8020406@linaro.org>
 <20140422171141.GW24070@n2100.arm.linux.org.uk>
 <20140422175325.GD23955@obsidianresearch.com>
Message-ID: <15350123.PBHzyiOlX4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 April 2014 11:53:25 Jason Gunthorpe wrote:
> On Tue, Apr 22, 2014 at 06:11:42PM +0100, Russell King - ARM Linux wrote:
> 
> > Put another way, if your platform is part of the multi-platform kernel
> > then you are *excluded* from being able to use this... unless you hack
> > the Kconfig, and then also provide a constant value for PHYS_OFFSET,
> > thereby _tying_ the kernel you built to a _single_ platform.
> 
> That is exactly right. To get a fixed LMA you must commit to a
> non-relocatable kernel image.
> 
> Realistically this patch would need to be accompanied by something
> that makes ARM_PATCH_PHYS_VIRT optional for multiplatform based on
> EXPERT or similar.

Incidentally, I have this experimental patch in my endless 'randconfig'
queue of things to do properly at a later point.
The idea is to let a person building a kernel intentionally do a
number of things that result in a not-quite-multiplatform configuration
when CONFIG_BROKEN_MULTIPLATFORM is disabled.

The main intention is allow NOMMU builds on platforms that are already
converted to multiplatform, and to prevent people from accidentally
turning on DEBUG_LL, as that breaks all other machines. A couple of
other things are in the same category.

	Arnd

>From c9917a4a1b3f326e84932d7e860597413a98643b Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 24 Feb 2014 16:38:34 +0100
Subject: [PATCH] ARM: add CONFIG_BROKEN_MULTIPLATFORM

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 65ea715..9ae3c0b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -233,7 +233,7 @@ config VECTORS_BASE
 	  in size.
 
 config ARM_PATCH_PHYS_VIRT
-	bool "Patch physical to virtual translations at runtime" if EMBEDDED
+	bool "Patch physical to virtual translations at runtime" if BROKEN_MULTIPLATFORM
 	default y
 	depends on !XIP_KERNEL && MMU
 	depends on !ARCH_REALVIEW || !SPARSEMEM
@@ -302,16 +302,14 @@ config MMU
 #
 choice
 	prompt "ARM system type"
-	default ARCH_VERSATILE if !MMU
-	default ARCH_MULTIPLATFORM if MMU
+	default ARCH_MULTIPLATFORM
 
 config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
-	depends on MMU
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_HAS_SG_CHAIN
-	select ARM_PATCH_PHYS_VIRT
 	select AUTO_ZRELADDR
+	select BROKEN_MULTIPLATFORM if !MMU
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
 	select MULTI_IRQ_HANDLER
@@ -865,6 +863,18 @@ config ARCH_OMAP1
 
 endchoice
 
+config BROKEN_MULTIPLATFORM
+	bool "Allow multiplatform builds that may be broken" if ARCH_MULTIPLATFORM && EXPERT
+	def_bool !ARCH_MULTIPLATFORM
+	help
+	  This is a meta option that makes other options visible that
+	  are normally hidden when building a kernel with ARCH_MULTIPLATFORM
+	  support.
+	  You have to enable this option in order to select any option
+	  that can cause your kernel to only work on a subset of the
+	  platforms that are enabled. This includes disabling MMU
+	  or ARM_PATCH_PHYS_VIRT, or enabling ZBOOT_ROM.
+
 menu "Multiple platform selection"
 	depends on ARCH_MULTIPLATFORM
 
@@ -1943,6 +1953,7 @@ config DEPRECATED_PARAM_STRUCT
 # TEXT and BSS so we preserve their values in the config files.
 config ZBOOT_ROM_TEXT
 	hex "Compressed ROM boot loader base address"
+	depends on BROKEN_MULTIPLATFORM
 	default "0"
 	help
 	  The physical address at which the ROM-able zImage is to be
@@ -1954,6 +1965,7 @@ config ZBOOT_ROM_TEXT
 
 config ZBOOT_ROM_BSS
 	hex "Compressed ROM boot loader BSS address"
+	depends on BROKEN_MULTIPLATFORM
 	default "0"
 	help
 	  The base address of an area of read/write memory in the target
@@ -1967,6 +1979,7 @@ config ZBOOT_ROM_BSS
 
 config ZBOOT_ROM
 	bool "Compressed boot loader in ROM/flash"
+	depends on BROKEN_MULTIPLATFORM
 	depends on ZBOOT_ROM_TEXT != ZBOOT_ROM_BSS
 	depends on !ARM_APPENDED_DTB && !XIP_KERNEL && !AUTO_ZRELADDR
 	help
@@ -2092,7 +2105,7 @@ endchoice
 
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
-	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
+	depends on !ARM_LPAE && BROKEN_MULTIPLATFORM
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
 	  directly addressable by the CPU, such as NOR flash. This saves RAM
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6175b50..e193881 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -80,6 +80,7 @@ config DEBUG_USER
 config DEBUG_LL
 	bool "Kernel low-level debugging functions (read help!)"
 	depends on DEBUG_KERNEL
+	depends on BROKEN_MULTIPLATFORM
 	help
 	  Say Y here to include definitions of printascii, printch, printhex
 	  in the kernel.  This is helpful if you are debugging code that
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index cddfd2e..df61015 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -111,7 +111,7 @@ config SOC_IMX31
 	select CPU_V6
 	select IMX_HAVE_PLATFORM_MXC_RNGA
 	select MXC_AVIC
-	select SMP_ON_UP if SMP
+	select SMP_ON_UP if SMP && !BROKEN_MULTIPLATFORM
 
 config SOC_IMX35
 	bool
@@ -119,7 +119,7 @@ config SOC_IMX35
 	select HAVE_EPIT
 	select MXC_AVIC
 	select PINCTRL_IMX35
-	select SMP_ON_UP if SMP
+	select SMP_ON_UP if SMP && !BROKEN_MULTIPLATFORM
 
 config SOC_IMX5
 	bool
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index e4e505f..05be41c 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -33,7 +33,6 @@ config ARCH_MARCO
 	default y
 	select ARM_GIC
 	select HAVE_ARM_SCU if SMP
-	select SMP_ON_UP if SMP
 	help
           Support for CSR SiRFSoC ARM Cortex A9 Platform
 
