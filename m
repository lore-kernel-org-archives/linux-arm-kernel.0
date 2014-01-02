From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 02 Jan 2014 16:23:28 +0000
Subject: [PATCH] Fix select-induced Kconfig warning for ZBOOT_ROM
Message-ID: <E1Vyl3Q-0005Lt-Lo@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

warning: (ARCH_MULTIPLATFORM && ARCH_CLPS711X && ARCH_PXA &&
 SOC_EXYNOS5440 && ARCH_EMEV2) selects AUTO_ZRELADDR which
 has unmet direct dependencies (!ZBOOT_ROM)

This is because it's possible to have ZBOOT_ROM enabled, but at the
same time have another option enabled which selects AUTO_ZRELADDR
overriding the !ZBOOT_ROM dependency.  Fix this by reversing the
dependencies between ZBOOT_ROM and the options which depend on
!ZBOOT_ROM.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
The autobuilder spotted this on one of its randconfig builds - yet again,
it's another illustration of the problems that throwing a "select"
statement at a problem is generally a bad idea.  Let's make a new year's
resolution that we're going to stop throwing "select" at a problem
without first thinking about the consequences.

 arch/arm/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c1f1a7eee953..2ec6bfdf03fd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1946,6 +1946,7 @@ config ZBOOT_ROM_BSS
 config ZBOOT_ROM
 	bool "Compressed boot loader in ROM/flash"
 	depends on ZBOOT_ROM_TEXT != ZBOOT_ROM_BSS
+	depends on !ARM_APPENDED_DTB && !XIP_KERNEL && !AUTO_ZRELADDR
 	help
 	  Say Y here if you intend to execute your compressed kernel image
 	  (zImage) directly from ROM or flash.  If unsure, say N.
@@ -1981,7 +1982,7 @@ endchoice
 
 config ARM_APPENDED_DTB
 	bool "Use appended device tree blob to zImage (EXPERIMENTAL)"
-	depends on OF && !ZBOOT_ROM
+	depends on OF
 	help
 	  With this option, the boot code will look for a device tree binary
 	  (DTB) appended to zImage
@@ -2069,7 +2070,7 @@ endchoice
 
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
-	depends on !ZBOOT_ROM && !ARM_LPAE && !ARCH_MULTIPLATFORM
+	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
 	  directly addressable by the CPU, such as NOR flash. This saves RAM
@@ -2132,7 +2133,6 @@ config CRASH_DUMP
 
 config AUTO_ZRELADDR
 	bool "Auto calculation of the decompressed kernel image address"
-	depends on !ZBOOT_ROM
 	help
 	  ZRELADDR is the physical address where the decompressed kernel
 	  image will be placed. If AUTO_ZRELADDR is selected, the address
-- 
1.7.4.4
