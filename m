From: chris.brandt@renesas.com (Chris Brandt)
Date: Tue, 23 Feb 2016 14:15:36 -0500
Subject: [PATCH v2] ARM: Allow MULTIPLATFORM to select XIP
In-Reply-To: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
References: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
Message-ID: <1456254936-28875-1-git-send-email-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As devices move to multiplatform only, you should not be restricted from
selecting XIP. Whether it makes sense or not depends on how you configure
the rest of the kernel (as in, removing individual platforms).
While there is no easy way to guarantee success when XIP is selected,
the MULTIPLATFORM_XIP_CAPABLE attribute at least provides a means to
show what devices have been known to boot (when configured correctly).

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
v2:
* Added MULTIPLATFORM_XIP_CAPABLE because there is no good way to
restrict that only 1 device can be selected at one time, so this at
least narrows down the the exposure of XIP in multiplatform.
---
 arch/arm/Kconfig               | 7 +++++--
 arch/arm/mach-shmobile/Kconfig | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d67f1aa..0d838ed 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -226,6 +226,9 @@ config NEED_RET_TO_USER
 config ARCH_MTD_XIP
 	bool
 
+config MULTIPLATFORM_XIP_CAPABLE
+	bool
+
 config VECTORS_BASE
 	hex
 	default 0xffff0000 if MMU || CPU_HIGH_VECTOR
@@ -327,7 +330,7 @@ config ARCH_MULTIPLATFORM
 	depends on MMU
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_HAS_SG_CHAIN
-	select ARM_PATCH_PHYS_VIRT
+	select ARM_PATCH_PHYS_VIRT if !XIP_KERNEL
 	select AUTO_ZRELADDR
 	select CLKSRC_OF
 	select COMMON_CLK
@@ -1918,7 +1921,7 @@ endchoice
 
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
-	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
+	depends on (!ARM_LPAE && !ARCH_MULTIPLATFORM) || (!ARM_LPAE && MULTIPLATFORM_XIP_CAPABLE)
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
 	  directly addressable by the CPU, such as NOR flash. This saves RAM
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index cd5f171..b27661e 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -57,6 +57,7 @@ config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
 	select PM_GENERIC_DOMAINS if PM
 	select SYS_SUPPORTS_SH_MTU2
+	select MULTIPLATFORM_XIP_CAPABLE
 
 config ARCH_R8A73A4
 	bool "R-Mobile APE6 (R8A73A40)"
-- 
1.9.1
