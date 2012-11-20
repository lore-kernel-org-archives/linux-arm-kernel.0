From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 20 Nov 2012 15:18:38 -0200
Subject: [PATCH v2] ARM: Kconfig: Do not force selection of ARCH_VEXPRESS by
 ARCH_MULTI_V7
Message-ID: <1353431918-9326-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

When building a kernel using imx_v6_v7_defconfig, it is not possible to unselect
ARCH_VEXPRESS due to the fact that it is automatically selected by ARCH_MULTI_V7.

This is not good when someone wants to create a minimal kernel build, so let 
multi_v7_defconfig select ARCH_VEXPRESS instead.

Also avoid build breakage when randconfig selects no platform.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Avoid build breakage on randconfig for the case that no platform is selected.
 arch/arm/Kconfig                    |    2 +-
 arch/arm/configs/multi_v7_defconfig |    1 +
 arch/arm/kernel/vmlinux.lds.S       |    2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 14f8160..372cb4e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -267,6 +267,7 @@ choice
 config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
 	depends on MMU
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_PATCH_PHYS_VIRT
 	select AUTO_ZRELADDR
 	select COMMON_CLK
@@ -1000,7 +1001,6 @@ config ARCH_MULTI_V7
 	bool "ARMv7 based platforms (Cortex-A, PJ4, Krait)"
 	default y
 	select ARCH_MULTI_V6_V7
-	select ARCH_VEXPRESS
 	select CPU_V7
 
 config ARCH_MULTI_V6_V7
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 159f75f..531c538 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -6,6 +6,7 @@ CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_SOCFPGA=y
+CONFIG_ARCH_VEXPRESS=y
 # CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set
 CONFIG_ARM_ERRATA_754322=y
 CONFIG_SMP=y
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b9f38e3..aa46be8 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -310,4 +310,6 @@ SECTIONS
  * binutils is too old (for other reasons as well)
  */
 ASSERT((__proc_info_end - __proc_info_begin), "missing CPU support")
+#ifndef CONFIG_ARCH_MULTIPLATFORM
 ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
+#endif
-- 
1.7.9.5
