From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Wed, 8 Dec 2010 11:07:53 +0530
Subject: [PATCH 1/9] ux500: fix uncompressor UART address for U5500
Message-ID: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carl-Johan Irekvist <carl-johan.irekvist@stericsson.com>

The uncompress code for zImage uses the UART to print status messages,
this was hard coded to use UART2 for the U8500 platform. This patch
checks at run time which platform it is run on. U5500 uses UART0 as
console UART.

Signed-off-by: Carl-Johan Irekvist <carl-johan.irekvist@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/include/mach/uncompress.h |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index 0271ca0..9a6614c 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -19,38 +19,43 @@
 #define __ASM_ARCH_UNCOMPRESS_H
 
 #include <asm/setup.h>
+#include <asm/mach-types.h>
 #include <linux/io.h>
+#include <linux/amba/serial.h>
 #include <mach/hardware.h>
 
-#define U8500_UART_DR		0x80007000
-#define U8500_UART_LCRH		0x8000702c
-#define U8500_UART_CR		0x80007030
-#define U8500_UART_FR		0x80007018
+static u32 ux500_uart_base;
 
 static void putc(const char c)
 {
 	/* Do nothing if the UART is not enabled. */
-	if (!(__raw_readb(U8500_UART_CR) & 0x1))
+	if (!(__raw_readb(ux500_uart_base + UART011_CR) & 0x1))
 		return;
 
 	if (c == '\n')
 		putc('\r');
 
-	while (__raw_readb(U8500_UART_FR) & (1 << 5))
+	while (__raw_readb(ux500_uart_base + UART01x_FR) & (1 << 5))
 		barrier();
-	__raw_writeb(c, U8500_UART_DR);
+	__raw_writeb(c, ux500_uart_base + UART01x_DR);
 }
 
 static void flush(void)
 {
-	if (!(__raw_readb(U8500_UART_CR) & 0x1))
+	if (!(__raw_readb(ux500_uart_base + UART011_CR) & 0x1))
 		return;
-	while (__raw_readb(U8500_UART_FR) & (1 << 3))
+	while (__raw_readb(ux500_uart_base + UART01x_FR) & (1 << 3))
 		barrier();
 }
 
 static inline void arch_decomp_setup(void)
 {
+	if (machine_is_u8500())
+		ux500_uart_base = U8500_UART2_BASE;
+	else if (machine_is_u5500())
+		ux500_uart_base = U5500_UART0_BASE;
+	else /* not much can be done to help here */
+		ux500_uart_base = U8500_UART2_BASE;
 }
 
 #define arch_decomp_wdog() /* nothing to do here */
-- 
1.7.2.dirty
