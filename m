From: stefan@agner.ch (Stefan Agner)
Date: Fri, 13 Mar 2015 00:36:16 +0100
Subject: [PATCH v3 08/12] ARM: allow MULTIPLATFORM with !MMU
In-Reply-To: <1426203380-7155-1-git-send-email-stefan@agner.ch>
References: <1426203380-7155-1-git-send-email-stefan@agner.ch>
Message-ID: <1426203380-7155-9-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support SoC with heterogenous CPU architectures (such
as Freescale Vybrid/i.MXSX) it is preferable to use the same
architecture (ARCH_MXC in this case) for the MMU enabled and !MMU
CPU. Hence allow to select MULTIPLATFORM even without MMU.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Kconfig | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9f1f09a..636cb3f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -230,7 +230,7 @@ config VECTORS_BASE
 	  in size.
 
 config ARM_PATCH_PHYS_VIRT
-	bool "Patch physical to virtual translations at runtime" if EMBEDDED
+	bool "Patch physical to virtual translations at runtime" if EMBEDDED || (ARCH_MULTIPLATFORM && MMU)
 	default y
 	depends on !XIP_KERNEL && MMU
 	depends on !ARCH_REALVIEW || !SPARSEMEM
@@ -305,15 +305,12 @@ config MMU
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
 	select CLKSRC_OF
 	select COMMON_CLK
@@ -785,13 +782,13 @@ comment "CPU Core family selection"
 
 config ARCH_MULTI_V4
 	bool "ARMv4 based platforms (FA526)"
-	depends on !ARCH_MULTI_V6_V7
+	depends on !ARCH_MULTI_V6_V7 && MMU
 	select ARCH_MULTI_V4_V5
 	select CPU_FA526
 
 config ARCH_MULTI_V4T
 	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
-	depends on !ARCH_MULTI_V6_V7
+	depends on !ARCH_MULTI_V6_V7 && MMU
 	select ARCH_MULTI_V4_V5
 	select CPU_ARM920T if !(CPU_ARM7TDMI || CPU_ARM720T || \
 		CPU_ARM740T || CPU_ARM9TDMI || CPU_ARM922T || \
@@ -799,7 +796,7 @@ config ARCH_MULTI_V4T
 
 config ARCH_MULTI_V5
 	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
-	depends on !ARCH_MULTI_V6_V7
+	depends on !ARCH_MULTI_V6_V7 && MMU
 	select ARCH_MULTI_V4_V5
 	select CPU_ARM926T if !(CPU_ARM946E || CPU_ARM1020 || \
 		CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
@@ -810,11 +807,13 @@ config ARCH_MULTI_V4_V5
 
 config ARCH_MULTI_V6
 	bool "ARMv6 based platforms (ARM11)"
+	depends on MMU
 	select ARCH_MULTI_V6_V7
 	select CPU_V6K
 
 config ARCH_MULTI_V7
-	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
+	bool "ARMv7-A based platforms (Cortex-A, PJ4, Scorpion, Krait)"
+	depends on MMU
 	default y
 	select ARCH_MULTI_V6_V7
 	select CPU_V7
@@ -825,7 +824,7 @@ config ARCH_MULTI_V6_V7
 	select MIGHT_HAVE_CACHE_L2X0
 
 config ARCH_MULTI_CPU_AUTO
-	def_bool !(ARCH_MULTI_V4 || ARCH_MULTI_V4T || ARCH_MULTI_V6_V7)
+	def_bool !(ARCH_MULTI_V4 || ARCH_MULTI_V4T || ARCH_MULTI_V6_V7) && MMU
 	select ARCH_MULTI_V5
 
 endmenu
@@ -1967,7 +1966,7 @@ endchoice
 
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
-	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
+	depends on !ARM_LPAE && (!ARCH_MULTIPLATFORM || ARCH_MULTI_V7M)
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
 	  directly addressable by the CPU, such as NOR flash. This saves RAM
-- 
2.3.1
