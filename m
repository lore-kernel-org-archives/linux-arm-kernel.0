From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 14 Jun 2015 13:19:46 -0700
Subject: [PATCH v2 2/2] ARM: debug: Fix unsupported operand in Kconfig.debug
In-Reply-To: <1434313186-22150-1-git-send-email-linux@roeck-us.net>
References: <1434313186-22150-1-git-send-email-linux@roeck-us.net>
Message-ID: <1434313186-22150-2-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm builds show the following warning.

arch/arm/Kconfig.debug:1576:warning: ignoring unsupported character '>'

This is due to
config DEBUG_UART_8250_WORD
	bool "Use 32-bit accesses for 8250 UART"
	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
	depends on DEBUG_UART_8250_SHIFT >= 2

The unsupported operand causes DEBUG_UART_8250_WORD to be disabled
if DEBUG_UART_8250_SHIFT is larger than 2, which is not what is
intended.

Fixes: 0b4cccbec606 ("ARM: debug: add support for word accesses to
	debug/8250.S")
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Instead of configuring DEBUG_UART_8250_WORD only if
    DEBUG_UART_8250_SHIFT == 2, set it if DEBUG_UART_8250_SHIFT
    is neither 0 nor 1.

 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6608121c6ea5..23a8b4901cb9 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1574,7 +1574,7 @@ config DEBUG_UART_8250_SHIFT
 config DEBUG_UART_8250_WORD
 	bool "Use 32-bit accesses for 8250 UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
-	depends on DEBUG_UART_8250_SHIFT >= 2
+	depends on DEBUG_UART_8250_SHIFT != 0 && DEBUG_UART_8250_SHIFT != 1
 	default y if DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART0 || \
 		DEBUG_SOCFPGA_UART1 || ARCH_KEYSTONE || \
 		DEBUG_ALPINE_UART0 || \
-- 
2.1.0
