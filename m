From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  8 Apr 2012 17:39:57 +0200
Subject: [PATCH 01/10] ARM: at91: uncompress Store UART address in a variable
In-Reply-To: <20120408151236.GH16641@game.jcrosoft.org>
References: <20120408151236.GH16641@game.jcrosoft.org>
Message-ID: <1333899606-30518-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow a future change to auto-detect which UART to use.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/include/mach/uncompress.h |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/uncompress.h b/arch/arm/mach-at91/include/mach/uncompress.h
index 4218647..d985af7 100644
--- a/arch/arm/mach-at91/include/mach/uncompress.h
+++ b/arch/arm/mach-at91/include/mach/uncompress.h
@@ -43,6 +43,14 @@
 #define UART_OFFSET AT91_USART5
 #endif
 
+void __iomem *at91_uart;
+
+static inline void arch_decomp_setup(void)
+{
+#ifdef UART_OFFSET
+	at91_uart = (void __iomem *) UART_OFFSET;	/* physical address */
+#endif
+}
 /*
  * The following code assumes the serial port has already been
  * initialized by the bootloader.  If you didn't setup a port in
@@ -53,27 +61,21 @@
 static void putc(int c)
 {
 #ifdef UART_OFFSET
-	void __iomem *sys = (void __iomem *) UART_OFFSET;	/* physical address */
-
-	while (!(__raw_readl(sys + ATMEL_US_CSR) & ATMEL_US_TXRDY))
+	while (!(__raw_readl(at91_uart + ATMEL_US_CSR) & ATMEL_US_TXRDY))
 		barrier();
-	__raw_writel(c, sys + ATMEL_US_THR);
+	__raw_writel(c, at91_uart + ATMEL_US_THR);
 #endif
 }
 
 static inline void flush(void)
 {
 #ifdef UART_OFFSET
-	void __iomem *sys = (void __iomem *) UART_OFFSET;	/* physical address */
-
 	/* wait for transmission to complete */
-	while (!(__raw_readl(sys + ATMEL_US_CSR) & ATMEL_US_TXEMPTY))
+	while (!(__raw_readl(at91_uart + ATMEL_US_CSR) & ATMEL_US_TXEMPTY))
 		barrier();
 #endif
 }
 
-#define arch_decomp_setup()
-
 #define arch_decomp_wdog()
 
 #endif
-- 
1.7.9.1
