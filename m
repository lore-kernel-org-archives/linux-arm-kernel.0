From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Sun, 25 Jan 2015 20:30:52 +0200
Subject: [PATCH 2/4] ARM: Alpine: early-debug print support
Message-ID: <54c5365c.v0Ob21sdO6QYSZZM%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alpine platform includes UART8250 that can be used for early prints.

Signed-off-by: Saeed Bishara <saeed@annapurnalabs.com>
Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 arch/arm/Kconfig.debug | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 5ddd490..db6c389 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1031,6 +1031,14 @@ choice
 		  This option selects UART0 on VIA/Wondermedia System-on-a-chip
 		  devices, including VT8500, WM8505, WM8650 and WM8850.
 
+	config DEBUG_ALPINE_UART0
+		bool "Kernel low-level debugging messages via Alpine UART0"
+		depends on ARCH_ALPINE
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Alpine based platforms.
+
 	config DEBUG_LL_UART_NONE
 		bool "No low-level debugging UART"
 		depends on !ARCH_MULTIPLATFORM
@@ -1312,6 +1320,7 @@ config DEBUG_UART_PHYS
 	default 0xfff36000 if DEBUG_HIGHBANK_UART
 	default 0xfffe8600 if DEBUG_UART_BCM63XX
 	default 0xfffff700 if ARCH_IOP33X
+	default 0xfd883000 if DEBUG_ALPINE_UART0
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_LL_UART_EFM32 || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
@@ -1394,6 +1403,7 @@ config DEBUG_UART_VIRT
 	default 0xfef36000 if DEBUG_HIGHBANK_UART
 	default 0xfefff700 if ARCH_IOP33X
 	default 0xff003000 if DEBUG_U300_UART
+	default 0xfd883000 if DEBUG_ALPINE_UART0
 	default DEBUG_UART_PHYS if !MMU
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
@@ -1411,7 +1421,7 @@ config DEBUG_UART_8250_WORD
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	depends on DEBUG_UART_8250_SHIFT >= 2
 	default y if DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART || \
-		ARCH_KEYSTONE || \
+		ARCH_KEYSTONE || DEBUG_ALPINE_UART0 || \
 		DEBUG_DAVINCI_DMx_UART0 || DEBUG_DAVINCI_DA8XX_UART1 || \
 		DEBUG_DAVINCI_DA8XX_UART2 || \
 		DEBUG_BCM_KONA_UART || DEBUG_RK32_UART2 || \
-- 
1.9.1
