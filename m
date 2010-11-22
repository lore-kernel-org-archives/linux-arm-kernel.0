From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 22 Nov 2010 14:51:42 +0000
Subject: [PATCH] debug-8250: add a 32 bit mode
Message-ID: <1290437502-2717-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms such as picoChip picoXCell devices can only do 32 bit
accesses to APB peripherals. If the platform defines
DEBUG_8250_ACCESS_32 before including debug-8250.S in debug-macros.S
then use 32-bit accesses for senduart, busyuart and waituart. If not
defined, use 8-bit accesses.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---

Note: for the TTY support we also need
[8250: add a UPIO_DWAPB32 for 32 bit accesses (v2)] at
http://marc.info/?l=linux-serial&m=129043658715199&w=2

 arch/arm/include/asm/hardware/debug-8250.S |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/hardware/debug-8250.S b/arch/arm/include/asm/hardware/debug-8250.S
index 22c6892..71f0839 100644
--- a/arch/arm/include/asm/hardware/debug-8250.S
+++ b/arch/arm/include/asm/hardware/debug-8250.S
@@ -9,12 +9,26 @@
  */
 #include <linux/serial_reg.h>
 
+/*
+ * Some platforms may only be able to perform 32-bit accesses to peripherals
+ * on an APB bus. If this is the case, define DEBUG_8250_ACCESS_32 before
+ * including this file.
+ */
+#ifdef DEBUG_8250_ACCESS_32
+# define ldr_uart    ldr
+# define str_uart    str
+#else /* DEBUG_8250_ACCESS_32 */
+# define ldr_uart    ldrb
+# define str_uart    strb
+#endif /* DEBUG_8250_ACCESS_32 */
+
 		.macro	senduart,rd,rx
-		strb	\rd, [\rx, #UART_TX << UART_SHIFT]
+                and     \rd, \rd, #0xff
+		str_uart    \rd, [\rx, #UART_TX << UART_SHIFT]
 		.endm
 
 		.macro	busyuart,rd,rx
-1002:		ldrb	\rd, [\rx, #UART_LSR << UART_SHIFT]
+1002:		ldr_uart    \rd, [\rx, #UART_LSR << UART_SHIFT]
 		and	\rd, \rd, #UART_LSR_TEMT | UART_LSR_THRE
 		teq	\rd, #UART_LSR_TEMT | UART_LSR_THRE
 		bne	1002b
@@ -22,7 +36,8 @@
 
 		.macro	waituart,rd,rx
 #ifdef FLOW_CONTROL
-1001:		ldrb	\rd, [\rx, #UART_MSR << UART_SHIFT]
+1001:		ldr_uart    \rd, [\rx, #UART_MSR << UART_SHIFT]
+                and     \rd, \rd, 0xff
 		tst	\rd, #UART_MSR_CTS
 		beq	1001b
 #endif
-- 
1.7.2.3
