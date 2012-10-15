From: pavel@denx.de (Pavel Machek)
Date: Mon, 15 Oct 2012 12:49:02 -0000
Subject: [RFC] Get early_printk() to work on socfpga board
In-Reply-To: <1342637233-13965-1-git-send-email-dinguyen@altera.com>
References: <1342637233-13965-1-git-send-email-dinguyen@altera.com>
Message-ID: <20121015124852.GA26559@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ioremap, so that early_printk() works. Add common 8250.S so that
code is not duplicated with picoxcell.
    
Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/arch/arm/include/debug/8250.S b/arch/arm/include/debug/8250.S
new file mode 100644
index 0000000..8db01ee
--- /dev/null
+++ b/arch/arm/include/debug/8250.S
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
index 7419deb..86d05e9 100644
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
+#include "8250.S"
diff --git a/arch/arm/include/debug/socfpga.S b/arch/arm/include/debug/socfpga.S
index d6f26d2..2e1dec8 100644
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
 
+#include "8250.S"
+
diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 17d0ec9..962e01e 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -36,6 +36,13 @@ static struct map_desc scu_io_desc __initdata = {
 	.type		= MT_DEVICE,
 };
 
+static struct map_desc uart_io_desc __initdata = {
+	.virtual	= 0xfec02000,
+	.pfn		= __phys_to_pfn(0xffc02000),
+	.length		= SZ_8K,
+	.type		= MT_DEVICE,
+};
+
 static void __init socfpga_map_io(void)
 {
 	unsigned long base;
@@ -45,6 +52,8 @@ static void __init socfpga_map_io(void)
 
 	scu_io_desc.pfn = __phys_to_pfn(base);
 	iotable_init(&scu_io_desc, 1);
+	iotable_init(&uart_io_desc, 1);
+	early_printk("Early printk initialized\n");
 }
 
 const static struct of_device_id irq_match[] = {


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
