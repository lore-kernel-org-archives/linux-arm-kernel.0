From: stefan@agner.ch (Stefan Agner)
Date: Wed, 20 May 2015 00:03:51 +0200
Subject: [PATCH soc v8 2/3] ARM: introduce ARM_SINGLE_ARMV7M for ARMv7-M
 platforms
In-Reply-To: <1432073032-26561-1-git-send-email-stefan@agner.ch>
References: <1432073032-26561-1-git-send-email-stefan@agner.ch>
Message-ID: <1432073032-26561-3-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces a new top level config symbol ARM_SINGLE_ARMV7M
for non-MMU, ARMv7-M platforms. It also support multiple ARMv7-M
platforms in one kernel image since the cores share the same
basic memory layout and interrupt controller. However, this works
only if the combined platforms also have a similar (main) memory
layout.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Kconfig       | 13 +++++++++++++
 arch/arm/Kconfig.debug |  5 +++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 80a2a14..75920ed 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -329,6 +329,19 @@ config ARCH_MULTIPLATFORM
 	select SPARSE_IRQ
 	select USE_OF
 
+config ARM_SINGLE_ARMV7M
+	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
+	depends on !MMU
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_NVIC
+	select CLKSRC_OF
+	select COMMON_CLK
+	select CPU_V7M
+	select GENERIC_CLOCKEVENTS
+	select NO_IOPORT_MAP
+	select SPARSE_IRQ
+	select USE_OF
+
 config ARCH_REALVIEW
 	bool "ARM Ltd. RealView family"
 	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 1515cb6..8478be2 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1571,7 +1571,7 @@ config DEBUG_UART_8250_FLOW_CONTROL
 
 config DEBUG_UNCOMPRESS
 	bool
-	depends on ARCH_MULTIPLATFORM || PLAT_SAMSUNG
+	depends on ARCH_MULTIPLATFORM || PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
 	default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
 		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM)
 	help
@@ -1589,7 +1589,8 @@ config UNCOMPRESS_INCLUDE
 	string
 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
 					PLAT_SAMSUNG || ARCH_EFM32 || \
-					ARCH_SHMOBILE_LEGACY || ARCH_LPC18XX
+					ARCH_SHMOBILE_LEGACY || \
+					ARCH_LPC18XX || ARM_SINGLE_ARMV7M
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
-- 
2.4.1
