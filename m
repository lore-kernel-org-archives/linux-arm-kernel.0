From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 14 Jun 2015 11:23:21 -0700
Subject: [PATCH] ARM: debug: Remove unsupported operand from Kconfig.debug
Message-ID: <1434306201-21840-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm builds show the following warning.

arch/arm/Kconfig.debug:1576:warning: ignoring unsupported character '>'

This is due to

config DEBUG_UART_8250_WORD
	bool "Use 32-bit accesses for 8250 UART"
	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
	depends on DEBUG_UART_8250_SHIFT >= 2

This may create the false expectation that DEBUG_UART_8250_WORD
is enabled if DEBUG_UART_8250_SHIFT is larger than 2, so drop the '>'.

Fixes: 0b4cccbec606 ("ARM: debug: add support for word accesses to
	debug/8250.S")
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index f1b157971366..f0655c9350bf 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1573,7 +1573,7 @@ config DEBUG_UART_8250_SHIFT
 config DEBUG_UART_8250_WORD
 	bool "Use 32-bit accesses for 8250 UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
-	depends on DEBUG_UART_8250_SHIFT >= 2
+	depends on DEBUG_UART_8250_SHIFT = 2
 	default y if DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART0 || \
 		DEBUG_SOCFPGA_UART1 || ARCH_KEYSTONE || \
 		DEBUG_ALPINE_UART0 || \
-- 
2.1.0
