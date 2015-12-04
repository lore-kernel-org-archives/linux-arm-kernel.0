From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  4 Dec 2015 23:30:34 +0100
Subject: [PATCH 02/10] ARM: debug-ll: reorganize mvebu debug uart config
In-Reply-To: <1449268242-808553-1-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
Message-ID: <1449268242-808553-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we are moving dove/mv78xx0/orion into multiplatform, the debug-ll
configuration options for these platforms are conflicting with the
multiplatform configuration: enabling one of those platforms sometimes
changes the default addresses to the ones used on one of them, rather
than the one that was selected in Kconfig.

This changes the configuration so we share the physical address
configuration with mach-mvebu.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 50ae573e6cba..8258f9dd1f77 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -499,6 +499,7 @@ choice
 	config DEBUG_MVEBU_UART0
 		bool "Kernel low-level debugging messages via MVEBU UART0 (old bootloaders)"
 		depends on ARCH_MVEBU
+		depends on ARCH_MVEBU && CPU_V7
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
@@ -511,17 +512,23 @@ choice
 		  Plathome OpenBlocks AX3, when using the original
 		  bootloader.
 
+		  This option will not work on older Marvell platforms
+		  (Kirkwood, Dove, MV78xx0, Orion5x), which should  piock
+		  the "new bootloader" variant.
+
 		  If the wrong DEBUG_MVEBU_UART* option is selected,
 		  when u-boot hands over to the kernel, the system
 		  silently crashes, with no serial output at all.
 
 	config DEBUG_MVEBU_UART0_ALTERNATE
 		bool "Kernel low-level debugging messages via MVEBU UART0 (new bootloaders)"
-		depends on ARCH_MVEBU
+		depends on ARCH_MVEBU || ARCH_DOVE || ARCH_MV78XX0 || ARCH_ORION5X
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  on MVEBU based platforms on UART0.
+		  on MVEBU based platforms on UART0. (Armada XP, Armada 3xx,
+		  Kirkwood, Dove, MV78xx0, Orion5x).
+
 
 		  This option should be used with the new bootloaders
 		  that remap the internal registers at 0xf1000000.
@@ -536,10 +543,13 @@ choice
 		select DEBUG_UART_8250
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  on MVEBU based platforms on UART1.
+		  on MVEBU based platforms on UART1. (Armada XP, Armada 3xx,
+		  Kirkwood, Dove, MV78xx0, Orion5x).
 
 		  This option should be used with the new bootloaders
 		  that remap the internal registers at 0xf1000000.
+		  All of the older (pre Armada XP/370) platforms also use
+		  this address, regardless of the boot loader version.
 
 		  If the wrong DEBUG_MVEBU_UART* option is selected,
 		  when u-boot hands over to the kernel, the system
@@ -1365,11 +1375,9 @@ config DEBUG_UART_PL01X
 
 # Compatibility options for 8250
 config DEBUG_UART_8250
-	def_bool ARCH_DOVE || ARCH_EBSA110 || \
-		(FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
+	def_bool ARCH_EBSA110 || (FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
 		ARCH_GEMINI || ARCH_IOP13XX || ARCH_IOP32X || \
-		ARCH_IOP33X || ARCH_IXP4XX || \
-		ARCH_LPC32XX || ARCH_MV78XX0 || ARCH_ORION5X || ARCH_RPC
+		ARCH_IOP33X || ARCH_IXP4XX || ARCH_LPC32XX || ARCH_RPC
 
 # Compatibility options for BCM63xx
 config DEBUG_UART_BCM63XX
@@ -1455,8 +1463,6 @@ config DEBUG_UART_PHYS
 	default 0xf040ab00 if DEBUG_BRCMSTB_UART
 	default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
 	default 0xf1012100 if DEBUG_MVEBU_UART1_ALTERNATE
-	default 0xf1012000 if ARCH_DOVE || ARCH_MV78XX0 || \
-				ARCH_ORION5X
 	default 0xf7fc9000 if DEBUG_BERLIN_UART
 	default 0xf8b00000 if DEBUG_HIX5HD2_UART
 	default 0xf991e000 if DEBUG_QCOM_UARTDM
@@ -1535,10 +1541,10 @@ config DEBUG_UART_VIRT
 	default 0xfcfe8600 if DEBUG_UART_BCM63XX
 	default 0xfd000000 if ARCH_SPEAR3XX || ARCH_SPEAR6XX
 	default 0xfd000000 if ARCH_SPEAR13XX
-	default 0xfd012000 if ARCH_MV78XX0
+	default 0xfd012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_MV78XX0
 	default 0xfd883000 if DEBUG_ALPINE_UART0
-	default 0xfde12000 if ARCH_DOVE
-	default 0xfe012000 if ARCH_ORION5X
+	default 0xfde12000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_DOVE
+	default 0xfe012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_ORION5X
 	default 0xf31004c0 if DEBUG_MESON_UARTAO
 	default 0xfe017000 if DEBUG_MMP_UART2
 	default 0xfe018000 if DEBUG_MMP_UART3
@@ -1553,7 +1559,7 @@ config DEBUG_UART_VIRT
 	default 0xfeb31000 if DEBUG_KEYSTONE_UART1
 	default 0xfec02000 if DEBUG_SOCFPGA_UART0
 	default 0xfec02100 if DEBUG_SOCFPGA_UART1
-	default 0xfec12000 if DEBUG_MVEBU_UART0 || DEBUG_MVEBU_UART0_ALTERNATE
+	default 0xfec12000 if (DEBUG_MVEBU_UART0 || DEBUG_MVEBU_UART0_ALTERNATE) && ARCH_MVEBU
 	default 0xfec12100 if DEBUG_MVEBU_UART1_ALTERNATE
 	default 0xfec10000 if DEBUG_SIRFATLAS7_UART0
 	default 0xfec20000 if DEBUG_DAVINCI_DMx_UART0
-- 
2.1.0.rc2
