From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  4 Dec 2015 23:30:33 +0100
Subject: [PATCH 01/10] ARM: debug-ll: fix UART configuration with ARCH_KEYSTONE
In-Reply-To: <1449268242-808553-1-git-send-email-arnd@arndb.de>
References: <1449268242-808553-1-git-send-email-arnd@arndb.de>
Message-ID: <1449268242-808553-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We may have multiple platforms enabled and also DEBUG_LL
configured for one of them. However if we enable ARCH_KEYSTONE,
we default to using 32-bit UART access independent of which
platform we are actually using, which can be confusing.

This changes the logic so the 32-bit default gets only
used by default if we actually configure the keystone
UART, as opposed to picking some other 8250 setting on
a kernel that has keystone support enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig.debug | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 543934ef7bf5..50ae573e6cba 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1599,8 +1599,9 @@ config DEBUG_UART_8250_WORD
 	bool "Use 32-bit accesses for 8250 UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	depends on DEBUG_UART_8250_SHIFT >= 2
-	default y if DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART0 || \
-		DEBUG_SOCFPGA_UART1 || ARCH_KEYSTONE || \
+	default y if DEBUG_PICOXCELL_UART || \
+		DEBUG_SOCFPGA_UART0 || DEBUG_SOCFPGA_UART1 || \
+		DEBUG_KEYSTONE_UART0 || DEBUG_KEYSTONE_UART1 || \
 		DEBUG_ALPINE_UART0 || \
 		DEBUG_DAVINCI_DMx_UART0 || DEBUG_DAVINCI_DA8XX_UART1 || \
 		DEBUG_DAVINCI_DA8XX_UART2 || \
-- 
2.1.0.rc2
