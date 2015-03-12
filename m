From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Thu, 12 Mar 2015 13:53:04 +0200
Subject: [PATCH v6 2/6] ARM: Alpine: early-debug print support
Message-ID: <55017e20.cQfjmLVJ2LRqZ3eD%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alpine platform includes UART8250 that can be used for early prints.

Signed-off-by: Saeed Bishara <saeed@annapurnalabs.com>
Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6e55ed9..0fcecbc 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -93,6 +93,14 @@ choice
 	prompt "Kernel low-level debugging port"
 	depends on DEBUG_LL
 
+	config DEBUG_ALPINE_UART0
+		bool "Kernel low-level debugging messages via Alpine UART0"
+		depends on ARCH_ALPINE
+		select DEBUG_UART_8250
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Alpine based platforms.
+
 	config DEBUG_ASM9260_UART
 		bool "Kernel low-level debugging via asm9260 UART"
 		depends on MACH_ASM9260
@@ -1416,6 +1424,7 @@ config DEBUG_UART_PHYS
 	default 0xf8b00000 if DEBUG_HIX5HD2_UART
 	default 0xf991e000 if DEBUG_QCOM_UARTDM
 	default 0xfcb00000 if DEBUG_HI3620_UART
+	default 0xfd883000 if DEBUG_ALPINE_UART0
 	default 0xfe800000 if ARCH_IOP32X
 	default 0xff690000 if DEBUG_RK32_UART2
 	default 0xffc02000 if DEBUG_SOCFPGA_UART
@@ -1482,6 +1491,7 @@ config DEBUG_UART_VIRT
 	default 0xfd000000 if ARCH_SPEAR3XX || ARCH_SPEAR6XX
 	default 0xfd000000 if ARCH_SPEAR13XX
 	default 0xfd012000 if ARCH_MV78XX0
+	default 0xfd883000 if DEBUG_ALPINE_UART0
 	default 0xfde12000 if ARCH_DOVE
 	default 0xfe012000 if ARCH_ORION5X
 	default 0xf31004c0 if DEBUG_MESON_UARTAO
@@ -1542,7 +1552,7 @@ config DEBUG_UART_8250_WORD
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
