From: stefan@agner.ch (Stefan Agner)
Date: Thu, 21 May 2015 00:35:44 +0200
Subject: [PATCH soc] ARM: use ARM_SINGLE_ARMV7M for ARMv7-M platforms
Message-ID: <1432161344-1930-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new config symbol ARM_SINGLE_ARMV7M which groups config
symbols used by modern ARMv7-M platforms. This allows supporting
multiple ARMv7-M platforms in one kernel image. However, a common
kernel image requires the combined platforms to share the same
main memory layout to be bootable.

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Since this is essentially only a shift of config symbols, it
should not change runtime behavior, at least when selecting
only one platform.

Uwe, this is essentially the same I had in my patchset, just
converting the other platforms too. I was bold and added your
Ack anyway...

Joachim, Maxime, I test compiled with your defconfigs, compiled
fine on my machine.

 arch/arm/Kconfig       | 86 ++++++++++++++++++--------------------------------
 arch/arm/Kconfig.debug |  5 ++-
 2 files changed, 32 insertions(+), 59 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 75920ed..9b777e3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -334,6 +334,7 @@ config ARM_SINGLE_ARMV7M
 	depends on !MMU
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_NVIC
+	select AUTO_ZRELADDR
 	select CLKSRC_OF
 	select COMMON_CLK
 	select CPU_V7M
@@ -411,24 +412,6 @@ config ARCH_EBSA110
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
@@ -599,26 +582,6 @@ config ARCH_W90X900
 	  <http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/
 		ConsumerElectronicsIC/ARMMicrocontroller/ARMMicrocontroller>
 
-config ARCH_LPC18XX
-	bool "NXP LPC18xx/LPC43xx"
-	depends on !MMU
-	select ARCH_HAS_RESET_CONTROLLER
-	select ARCH_REQUIRE_GPIOLIB
-	select ARM_AMBA
-	select ARM_NVIC
-	select AUTO_ZRELADDR
-	select CLKSRC_LPC32XX
-	select COMMON_CLK
-	select CPU_V7M
-	select GENERIC_CLOCKEVENTS
-	select NO_IOPORT_MAP
-	select PINCTRL
-	select SPARSE_IRQ
-	select USE_OF
-	help
-	  Support for NXP's LPC18xx Cortex-M3 and LPC43xx Cortex-M4
-	  high performance microcontrollers.
-
 config ARCH_LPC32XX
 	bool "NXP LPC32XX"
 	select ARCH_REQUIRE_GPIOLIB
@@ -791,24 +754,6 @@ config ARCH_OMAP1
 	help
 	  Support for older TI OMAP1 (omap7xx, omap15xx or omap16xx)
 
-config ARCH_STM32
-	bool "STMicrolectronics STM32"
-	depends on !MMU
-	select ARCH_HAS_RESET_CONTROLLER
-	select ARM_NVIC
-	select ARMV7M_SYSTICK
-	select AUTO_ZRELADDR
-	select CLKSRC_OF
-	select COMMON_CLK
-	select CPU_V7M
-	select GENERIC_CLOCKEVENTS
-	select NO_IOPORT_MAP
-	select RESET_CONTROLLER
-	select SPARSE_IRQ
-	select USE_OF
-	help
-	  Support for STMicroelectronics STM32 processors.
-
 endchoice
 
 menu "Multiple platform selection"
@@ -1006,6 +951,35 @@ source "arch/arm/mach-zx/Kconfig"
 
 source "arch/arm/mach-zynq/Kconfig"
 
+# ARMv7-M architecture
+config ARCH_EFM32
+	bool "Energy Micro efm32"
+	depends on ARM_SINGLE_ARMV7M
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Support for Energy Micro's (now Silicon Labs) efm32 Giant Gecko
+	  processors.
+
+config ARCH_LPC18XX
+	bool "NXP LPC18xx/LPC43xx"
+	depends on ARM_SINGLE_ARMV7M
+	select ARCH_HAS_RESET_CONTROLLER
+	select ARM_AMBA
+	select CLKSRC_LPC32XX
+	select PINCTRL
+	help
+	  Support for NXP's LPC18xx Cortex-M3 and LPC43xx Cortex-M4
+	  high performance microcontrollers.
+
+config ARCH_STM32
+	bool "STMicrolectronics STM32"
+	depends on ARM_SINGLE_ARMV7M
+	select ARCH_HAS_RESET_CONTROLLER
+	select ARMV7M_SYSTICK
+	select RESET_CONTROLLER
+	help
+	  Support for STMicroelectronics STM32 processors.
+
 # Definitions to make life easier
 config ARCH_ACORN
 	bool
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 9553759..e27fd3f 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1596,9 +1596,8 @@ config DEBUG_UNCOMPRESS
 config UNCOMPRESS_INCLUDE
 	string
 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
-					PLAT_SAMSUNG || ARCH_EFM32 || \
-					ARCH_SHMOBILE_LEGACY || \
-					ARCH_LPC18XX || ARM_SINGLE_ARMV7M
+					PLAT_SAMSUNG || ARM_SINGLE_ARMV7M || \
+					ARCH_SHMOBILE_LEGACY
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
-- 
2.4.1
