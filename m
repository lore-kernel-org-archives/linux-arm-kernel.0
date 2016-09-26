From: gerg@uclinux.org (Greg Ungerer)
Date: Mon, 26 Sep 2016 10:52:30 +1000
Subject: [PATCH 4/4] arm/versatile: support configuring versatile machine for
 no-MMU
In-Reply-To: <1474851150-12532-1-git-send-email-gerg@uclinux.org>
References: <1474851150-12532-1-git-send-email-gerg@uclinux.org>
Message-ID: <1474851150-12532-5-git-send-email-gerg@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow the arm versatile machine to be configured for no-MMU operation.
The approach taken is similar to the support for no-MMU arm v7 machines.

A new define, CONFIG_ARM_SINGLE_ARMV5, is used to enable a class of v5
core based machines that are supported for building with !CONFIG_MMU.
Currently only the versatile machine is configured to support this.

Older kernels had the ability to build the versatile machine with the MMU
disabled (!CONFIG_MMU). Recent changes to convert the versatile machine
to device tree lost this ability. (Although older kernels could be built
they did not run due to a bug in the IO_ADDRESS() mapping on this machine).

The motivation for this is that the versatile machine is well supported
in qemu. And this provides an excellent platform for development and
testing no-MMU support on ARM in general.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/Kconfig                | 10 ++++++++++
 arch/arm/Kconfig.debug          |  3 ++-
 arch/arm/mach-versatile/Kconfig |  3 ++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a9c4e48..f44fe7b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -353,6 +353,16 @@ config ARM_SINGLE_ARMV7M
 	select SPARSE_IRQ
 	select USE_OF
 
+config ARM_SINGLE_ARMV5
+	bool "ARMv5 based platforms (ARM926T)"
+	depends on !MMU
+	select AUTO_ZRELADDR
+	select CLKSRC_OF
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select SPARSE_IRQ
+	select USE_OF
+
 config ARCH_GEMINI
 	bool "Cortina Systems Gemini"
 	select CLKSRC_MMIO
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index a9693b6..9897348 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1712,7 +1712,8 @@ config DEBUG_UNCOMPRESS
 config UNCOMPRESS_INCLUDE
 	string
 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
-					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
+					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M || \
+					ARM_SINGLE_ARMV5
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index b0cc262..904a012 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -1,6 +1,6 @@
 config ARCH_VERSATILE
 	bool "ARM Ltd. Versatile family"
-	depends on ARCH_MULTI_V5
+	depends on ARCH_MULTI_V5 || ARM_SINGLE_ARMV5
 	select ARM_AMBA
 	select ARM_TIMER_SP804
 	select ARM_VIC
@@ -14,6 +14,7 @@ config ARCH_VERSATILE
 	select POWER_RESET
 	select POWER_RESET_VERSATILE
 	select VERSATILE_FPGA_IRQ
+	select GPIOLIB
 	help
 	  This enables support for ARM Ltd Versatile board.
 
-- 
1.9.1
