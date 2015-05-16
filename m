From: stefan@agner.ch (Stefan Agner)
Date: Sat, 16 May 2015 11:44:22 +0200
Subject: [PATCH v7 10/13] ARM: efm32: use ARM_SINGLE_ARMV7M
In-Reply-To: <1431769465-26867-1-git-send-email-stefan@agner.ch>
References: <1431769465-26867-1-git-send-email-stefan@agner.ch>
Message-ID: <1431769465-26867-11-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new config symbol ARM_SINGLE_ARMV7M which groups config
symbols used by modern ARMv7-M platforms. It also support multiple
ARMv7-M platforms in one kernel image. However, this only works if
the combined platforms share the same (main) memory layout.

Also use generic debug/uncompress.h for all ARMv7-M platforms.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/Kconfig                 | 28 ++++++++++------------------
 arch/arm/Kconfig.debug           |  2 +-
 arch/arm/configs/efm32_defconfig |  1 +
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2361efc..d1c035d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -411,24 +411,6 @@ config ARCH_EBSA110
 	  Ethernet interface, two PCMCIA sockets, two serial ports and a
 	  parallel port.
 
-config ARCH_EFM32
-	bool "Energy Micro efm32"
-	depends on !MMU
-	select ARCH_REQUIRE_GPIOLIB
-	select ARM_NVIC
-	select AUTO_ZRELADDR
-	select CLKSRC_OF
-	select COMMON_CLK
-	select CPU_V7M
-	select GENERIC_CLOCKEVENTS
-	select NO_DMA
-	select NO_IOPORT_MAP
-	select SPARSE_IRQ
-	select USE_OF
-	help
-	  Support for Energy Micro's (now Silicon Labs) efm32 Giant Gecko
-	  processors.
-
 config ARCH_EP93XX
 	bool "EP93xx-based"
 	select ARCH_HAS_HOLES_MEMORYMODEL
@@ -963,6 +945,16 @@ source "arch/arm/mach-w90x900/Kconfig"
 
 source "arch/arm/mach-zynq/Kconfig"
 
+# ARMv7-M architecture
+config ARCH_EFM32
+	bool "Energy Micro efm32"
+	depends on ARM_SINGLE_ARMV7M
+	select ARCH_REQUIRE_GPIOLIB
+	select AUTO_ZRELADDR
+	help
+	  Support for Energy Micro's (now Silicon Labs) efm32 Giant Gecko
+	  processors.
+
 # Definitions to make life easier
 config ARCH_ACORN
 	bool
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e4441de..5d63c56 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1561,7 +1561,7 @@ config DEBUG_UNCOMPRESS
 config UNCOMPRESS_INCLUDE
 	string
 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
-					PLAT_SAMSUNG || ARCH_EFM32 || \
+					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M || \
 					ARCH_SHMOBILE_LEGACY
 	default "mach/uncompress.h"
 
diff --git a/arch/arm/configs/efm32_defconfig b/arch/arm/configs/efm32_defconfig
index c4c17e3..e969f78 100644
--- a/arch/arm/configs/efm32_defconfig
+++ b/arch/arm/configs/efm32_defconfig
@@ -16,6 +16,7 @@ CONFIG_EMBEDDED=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 # CONFIG_MMU is not set
+CONFIG_ARM_SINGLE_ARMV7M=y
 CONFIG_ARCH_EFM32=y
 CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x88000000
-- 
2.4.1
