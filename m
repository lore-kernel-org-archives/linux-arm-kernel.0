From: pavel@denx.de (Pavel Machek)
Date: Wed, 17 Oct 2012 20:16:48 +0200
Subject: [PATCH] Fix socfpga compilation with early_printk() enabled
In-Reply-To: <20120701184110.GA30680@elf.ucw.cz>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <20120627180516.GA17393@elf.ucw.cz> <20120627204018.0bfef362@skate>
 <201206302104.37937.arnd@arndb.de>
 <20120701184110.GA30680@elf.ucw.cz>
Message-ID: <20121017181648.GA12120@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This fixes early_printk() compilation for
socfpga. (senduart/busyuart/waituart were missing). It does that by
making Picochip code generic.

Signed-off-by: Pavel Machek <pavel@denx.de>
Acked-by: Dinh Nguyen <dinguyen@altera.com>
Acked-by: Jamie Iles <jamie@jamieiles.com 

diff --git a/arch/arm/include/debug/8250_32.S b/arch/arm/include/debug/8250_32.S
new file mode 100644
index 0000000..8db01ee
--- /dev/null
+++ b/arch/arm/include/debug/8250_32.S
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Derived from arch/arm/mach-davinci/include/mach/debug-macro.S to use 32-bit
+ * accesses to the 8250.
+ */
+
+#include <linux/serial_reg.h>
+
+		.macro	senduart,rd,rx
+		str	\rd, [\rx, #UART_TX << UART_SHIFT]
+		.endm
+
+		.macro	busyuart,rd,rx
+1002:		ldr	\rd, [\rx, #UART_LSR << UART_SHIFT]
+		and	\rd, \rd, #UART_LSR_TEMT | UART_LSR_THRE
+		teq	\rd, #UART_LSR_TEMT | UART_LSR_THRE
+		bne	1002b
+		.endm
+
+		/* The UART's don't have any flow control IO's wired up. */
+		.macro	waituart,rd,rx
+		.endm
diff --git a/arch/arm/include/debug/picoxcell.S b/arch/arm/include/debug/picoxcell.S
index 7419deb..bc1f07c 100644
--- a/arch/arm/include/debug/picoxcell.S
+++ b/arch/arm/include/debug/picoxcell.S
@@ -5,10 +5,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * Derived from arch/arm/mach-davinci/include/mach/debug-macro.S to use 32-bit
- * accesses to the 8250.
  */
-#include <linux/serial_reg.h>
 
 #define UART_SHIFT 2
 #define PICOXCELL_UART1_BASE		0x80230000
@@ -19,17 +16,4 @@
 		ldr	\rp, =PICOXCELL_UART1_BASE
 		.endm
 
-		.macro	senduart,rd,rx
-		str	\rd, [\rx, #UART_TX << UART_SHIFT]
-		.endm
-
-		.macro	busyuart,rd,rx
-1002:		ldr	\rd, [\rx, #UART_LSR << UART_SHIFT]
-		and	\rd, \rd, #UART_LSR_TEMT | UART_LSR_THRE
-		teq	\rd, #UART_LSR_TEMT | UART_LSR_THRE
-		bne	1002b
-		.endm
-
-		/* The UART's don't have any flow control IO's wired up. */
-		.macro	waituart,rd,rx
-		.endm
+#include "8250_32.S"
diff --git a/arch/arm/include/debug/socfpga.S b/arch/arm/include/debug/socfpga.S
index d6f26d2..966b2f9 100644
--- a/arch/arm/include/debug/socfpga.S
+++ b/arch/arm/include/debug/socfpga.S
@@ -7,6 +7,9 @@
  * published by the Free Software Foundation.
  */
 
+#define UART_SHIFT 2
+#define DEBUG_LL_UART_OFFSET	0x00002000
+
 		.macro	addruart, rp, rv, tmp
 		mov	\rp, #DEBUG_LL_UART_OFFSET
 		orr	\rp, \rp, #0x00c00000
@@ -14,3 +17,5 @@
 		orr	\rp, \rp, #0xff000000	@ physical base
 		.endm
 
+#include "8250_32.S"
+

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
