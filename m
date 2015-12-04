From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  4 Dec 2015 23:30:40 +0100
Subject: [PATCH 08/10] ARM: debug-ll: rework footbridge handling
In-Reply-To: <1449268242-808553-1-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
Message-ID: <1449268242-808553-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Footbridge has two debug ports that are handled a bit differently:

The 8250 port uses the normal debug/8250.S implementation that is shared
with a lot of other platforms, but it relies on the DEBUG_UART_8250
option to be turned on automatically instead of being selected by
DEBUG_FOOTBRIDGE_COM1 as we do for most other platforms. I'm changing
this to use a 'select' and change the dependency to the debug symbol
rather than the platform symbol for consistency.

The DC21285 UART has a separate top-level option, and relies on
the traditional include/mach/debug-macro.S method. With the s3c64xx
multiplatform series queued up for 4.5, it is now the last one that does
this, so by moving this file to include/debug/dc21285.S, we can get
all platforms to do things the same way.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug                                       | 12 +++++++-----
 .../include/mach/debug-macro.S => include/debug/dc21285.S}   |  0
 2 files changed, 7 insertions(+), 5 deletions(-)
 rename arch/arm/{mach-footbridge/include/mach/debug-macro.S => include/debug/dc21285.S} (100%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 9836d428a65d..1d0f5e24ad51 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -274,6 +274,7 @@ choice
 	config DEBUG_FOOTBRIDGE_COM1
 		bool "Kernel low-level debugging messages via footbridge 8250 at PCI COM1"
 		depends on FOOTBRIDGE
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to the 8250 at PCI COM1.
@@ -1381,6 +1382,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/at91.S" if DEBUG_AT91_UART
 	default "debug/asm9260.S" if DEBUG_ASM9260_UART
 	default "debug/clps711x.S" if DEBUG_CLPS711X_UART1 || DEBUG_CLPS711X_UART2
+	default "debug/dc21285.S" if DEBUG_DC21285_PORT
 	default "debug/meson.S" if DEBUG_MESON_UARTAO
 	default "debug/pl01x.S" if DEBUG_LL_UART_PL01X || DEBUG_UART_PL01X
 	default "debug/exynos.S" if DEBUG_EXYNOS_UART
@@ -1431,7 +1433,7 @@ config DEBUG_UART_PL01X
 
 # Compatibility options for 8250
 config DEBUG_UART_8250
-	def_bool ARCH_EBSA110 || (FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
+	def_bool ARCH_EBSA110 || \
 		ARCH_IOP13XX || ARCH_IOP32X || ARCH_IOP33X || ARCH_IXP4XX || \
 		ARCH_RPC
 
@@ -1486,7 +1488,7 @@ config DEBUG_UART_PHYS
 	default 0x50008000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART2 || \
 				DEBUG_S3C2410_UART2)
 	default 0x78000000 if DEBUG_CNS3XXX
-	default 0x7c0003f8 if FOOTBRIDGE
+	default 0x7c0003f8 if DEBUG_FOOTBRIDGE_COM1
 	default 0x7f005000 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART0
 	default 0x7f005400 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART1
 	default 0x7f005800 if DEBUG_S3C64XX_UART && DEBUG_S3C_UART2
@@ -1627,7 +1629,7 @@ config DEBUG_UART_VIRT
 	default 0xfed64000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
 	default 0xfed68000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
 	default 0xfedc0000 if DEBUG_EP93XX
-	default 0xfee003f8 if FOOTBRIDGE
+	default 0xfee003f8 if DEBUG_FOOTBRIDGE_COM1
 	default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
 	default 0xfee82340 if ARCH_IOP13XX
 	default 0xfef00000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
@@ -1652,7 +1654,7 @@ config DEBUG_UART_VIRT
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
-	default 0 if FOOTBRIDGE || ARCH_IOP32X || DEBUG_BCM_5301X || \
+	default 0 if DEBUG_FOOTBRIDGE_COM1 || ARCH_IOP32X || DEBUG_BCM_5301X || \
 		DEBUG_OMAP7XXUART1 || DEBUG_OMAP7XXUART2 || DEBUG_OMAP7XXUART3
 	default 2
 
@@ -1672,7 +1674,7 @@ config DEBUG_UART_8250_WORD
 config DEBUG_UART_8250_FLOW_CONTROL
 	bool "Enable flow control for 8250 UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
-	default y if ARCH_EBSA110 || FOOTBRIDGE || DEBUG_GEMINI || ARCH_RPC
+	default y if ARCH_EBSA110 || DEBUG_FOOTBRIDGE_COM1 || DEBUG_GEMINI || ARCH_RPC
 
 config DEBUG_UNCOMPRESS
 	bool
diff --git a/arch/arm/mach-footbridge/include/mach/debug-macro.S b/arch/arm/include/debug/dc21285.S
similarity index 100%
rename from arch/arm/mach-footbridge/include/mach/debug-macro.S
rename to arch/arm/include/debug/dc21285.S
-- 
2.1.0.rc2
