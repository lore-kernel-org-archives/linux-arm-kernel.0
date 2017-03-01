From: gerg@uclinux.org (Greg Ungerer)
Date: Wed,  1 Mar 2017 11:50:40 +1000
Subject: [PATCHv3 4/4] ARM: versatile: support configuring versatile machine
 for no-MMU
In-Reply-To: <1488333040-3599-1-git-send-email-gerg@uclinux.org>
References: <1488332385-3367-1-git-send-email-gerg@uclinux.org>
 <1488333040-3599-1-git-send-email-gerg@uclinux.org>
Message-ID: <1488333040-3599-2-git-send-email-gerg@uclinux.org>
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

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/Kconfig                | 11 +++++++++++
 arch/arm/Kconfig.debug          |  3 ++-
 arch/arm/mach-versatile/Kconfig |  5 +++--
 3 files changed, 16 insertions(+), 3 deletions(-)

v2: don't use a multiplatform setup, move versatile choice to top level menu
v3: rebase on top of linux-4.10

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 186c4c2..1d9ac7c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -353,6 +353,17 @@ config ARM_SINGLE_ARMV7M
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
 config ARCH_GEMINI
 	bool "Cortina Systems Gemini"
 	select CLKSRC_MMIO
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index d83f7c3..3f393e4 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1712,7 +1712,8 @@ config DEBUG_UNCOMPRESS
 config UNCOMPRESS_INCLUDE
 	string
 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
-					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
+					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M || \
+					ARM_SINGLE_ARCH_VERSATILE
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index c257d40..c03a8c8 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -1,6 +1,7 @@
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
1.9.1
