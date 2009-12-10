From: maz@misterjones.org (Marc Zyngier)
Date: Thu, 10 Dec 2009 07:39:22 +0100
Subject: [PATCH] pxa/zeus: Allow use of 8250-compatible UART in uncompress
Message-ID: <20091210073922.79f6e841@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zeus console port is wired to a 8250-compatible device
(pxa UARTs are reserved to other uses). This patch
allows such a configuration in the uncompress sequence.

Signed-off-by: Marc Zyngier <maz@misterjones.org>
---
 arch/arm/mach-pxa/include/mach/uncompress.h |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h b/arch/arm/mach-pxa/include/mach/uncompress.h
index 237734b..dc94a34 100644
--- a/arch/arm/mach-pxa/include/mach/uncompress.h
+++ b/arch/arm/mach-pxa/include/mach/uncompress.h
@@ -13,17 +13,21 @@
 #include <mach/regs-uart.h>
 #include <asm/mach-types.h>
 
-#define __REG(x)       ((volatile unsigned long *)x)
+#define __REG(x)       ((volatile char *)x)
 
-static volatile unsigned long *UART = FFUART;
+static volatile char *UART = FFUART;
+static int shift = 2;
+static int is_pxa_uart = 1;
+
+#define UART_REG(x)	UART[(x) << shift]
 
 static inline void putc(char c)
 {
-	if (!(UART[UART_IER] & IER_UUE))
+	if (is_pxa_uart && !(UART_REG(UART_IER) & IER_UUE))
 		return;
-	while (!(UART[UART_LSR] & LSR_TDRQ))
+	while (!(UART_REG(UART_LSR) & LSR_TDRQ))
 		barrier();
-	UART[UART_TX] = c;
+	UART_REG(UART_TX) = c;
 }
 
 /*
@@ -39,6 +43,12 @@ static inline void arch_decomp_setup(void)
 	    || machine_is_csb726() || machine_is_stargate2()
 	    || machine_is_cm_x300() || machine_is_balloon3())
 		UART = STUART;
+
+	if (machine_is_arcom_zeus()) {
+		UART = __REG(0x10000000);
+		is_pxa_uart = 0;
+		shift = 1;
+	}
 }
 
 /*
-- 
1.6.0.4



-- 
I'm the slime oozin' out from your TV set...
