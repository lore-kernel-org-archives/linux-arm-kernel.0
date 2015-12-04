From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  4 Dec 2015 23:30:38 +0100
Subject: [PATCH 06/10] ARM: debug-ll: rework gemini handling
In-Reply-To: <1449268242-808553-1-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
Message-ID: <1449268242-808553-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gemini can not yet be configured in a multiplatform kernel, but
if we ever get there, enabling one of the gemini platforms
while trying to use DEBUG_LL for another platform can default to
the wrong UART address, as the options are purely based on the
architecture being enabled or not.

This changes the logic to use the gemini default addresses and
the flow control settings only if we have also picked the respective
Kconfig symbols introduced here.

While we're at it, this also reorders the virtual address as
it should be.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index aa27e58e210a..b35392417378 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -278,6 +278,14 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the 8250 at PCI COM1.
 
+	config DEBUG_GEMINI
+		bool "Kernel low-level debugging messages via Cortina Systems Gemini UART"
+		depends on ARCH_GEMINI
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Cortina Gemini based platforms.
+
 	config DEBUG_HI3620_UART
 		bool "Hisilicon HI3620 Debug UART"
 		depends on ARCH_HI3xxx
@@ -1416,8 +1424,8 @@ config DEBUG_UART_PL01X
 # Compatibility options for 8250
 config DEBUG_UART_8250
 	def_bool ARCH_EBSA110 || (FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
-		ARCH_GEMINI || ARCH_IOP13XX || ARCH_IOP32X || \
-		ARCH_IOP33X || ARCH_IXP4XX || ARCH_LPC32XX || ARCH_RPC
+		ARCH_IOP13XX || ARCH_IOP32X || ARCH_IOP33X || ARCH_IXP4XX || \
+		ARCH_LPC32XX || ARCH_RPC
 
 # Compatibility options for BCM63xx
 config DEBUG_UART_BCM63XX
@@ -1462,7 +1470,7 @@ config DEBUG_UART_PHYS
 	default 0x40081000 if DEBUG_LPC18XX_UART0
 	default 0x40090000 if ARCH_LPC32XX
 	default 0x40100000 if DEBUG_PXA_UART1
-	default 0x42000000 if ARCH_GEMINI
+	default 0x42000000 if DEBUG_GEMINI
 	default 0x50000000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART0 || \
 				DEBUG_S3C2410_UART0)
 	default 0x50004000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART1 || \
@@ -1554,9 +1562,9 @@ config DEBUG_UART_VIRT
 	default 0xf1c28000 if DEBUG_SUNXI_UART0
 	default 0xf1c28400 if DEBUG_SUNXI_UART1
 	default 0xf1f02800 if DEBUG_SUNXI_R_UART
+	default 0xf4200000 if DEBUG_GEMINI
 	default 0xf6200000 if DEBUG_PXA_UART1
 	default 0xf4090000 if ARCH_LPC32XX
-	default 0xf4200000 if ARCH_GEMINI
 	default 0xf7000000 if DEBUG_SUN9I_UART0
 	default 0xf7000000 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART0
 	default 0xf7000000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART0 || \
@@ -1656,7 +1664,7 @@ config DEBUG_UART_8250_WORD
 config DEBUG_UART_8250_FLOW_CONTROL
 	bool "Enable flow control for 8250 UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
-	default y if ARCH_EBSA110 || FOOTBRIDGE || ARCH_GEMINI || ARCH_RPC
+	default y if ARCH_EBSA110 || FOOTBRIDGE || DEBUG_GEMINI || ARCH_RPC
 
 config DEBUG_UNCOMPRESS
 	bool
-- 
2.1.0.rc2
