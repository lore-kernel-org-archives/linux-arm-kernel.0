From: gerg@linux-m68k.org (Greg Ungerer)
Date: Tue, 19 Jun 2018 00:19:05 +1000
Subject: [PATCHv4 4/4] ARM: versatile: support configuring versatile machine
 for no-MMU
In-Reply-To: <20180618141905.7789-1-gerg@linux-m68k.org>
References: <20180618141905.7789-1-gerg@linux-m68k.org>
Message-ID: <20180618141905.7789-5-gerg@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the arm versatile machine to be configured for no-MMU operation.

Older kernels had the ability to build the versatile machine with the MMU
disabled (!CONFIG_MMU). Recent changes to convert the versatile machine
to device tree lost this ability. (Although older kernels could be built
they did not run due to a bug in the IO_ADDRESS() mapping on this machine).

The motivation for this is that the versatile machine is well supported
in qemu. And this provides an excellent platform for development and
testing no-MMU support on ARM in general.

This patch adds a versatile platform selection in the upper level arm
system type menu - where it appeared in older kernel versions - when
configuring for the no-MMU case. There is no visible change to the way
versatile is selected for the MMU enabled case.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/arm/Kconfig                | 11 +++++++++++
 arch/arm/Kconfig.debug          |  3 ++-
 arch/arm/mach-versatile/Kconfig |  5 +++--
 3 files changed, 16 insertions(+), 3 deletions(-)

v2: don't use a multiplatform setup, move versatile choice to top level menu
v3: rebase on top of linux-4.10
v3: rebase on top of linux-4.17

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 54eeb8d00bc6..0608a6a32fac 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -356,6 +356,17 @@ config ARM_SINGLE_ARMV7M
 	select SPARSE_IRQ
 	select USE_OF
 
+config ARM_SINGLE_ARCH_VERSATILE
+	bool "ARM Ltd. Versatile family"
+	depends on !MMU
+	select AUTO_ZRELADDR
+	select CLKSRC_OF
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select GPIOLIB
+	select SPARSE_IRQ
+	select USE_OF
+
 config ARCH_EBSA110
 	bool "EBSA-110"
 	select ARCH_USES_GETTIMEOFFSET
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 693f84392f1b..242a0f744c8a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1836,7 +1836,8 @@ config DEBUG_UNCOMPRESS
 config UNCOMPRESS_INCLUDE
 	string
 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
-					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
+					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M || \
+					ARM_SINGLE_ARCH_VERSATILE
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index f5c275434d6c..06ad999d5978 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 config ARCH_VERSATILE
-	bool "ARM Ltd. Versatile family"
-	depends on ARCH_MULTI_V5
+	bool "ARM Ltd. Versatile family" if ARCH_MULTI_V5
+	depends on ARCH_MULTI_V5 || ARM_SINGLE_ARCH_VERSATILE
+	default y if ARM_SINGLE_ARCH_VERSATILE
 	select ARM_AMBA
 	select ARM_TIMER_SP804
 	select ARM_VIC
-- 
2.17.1
