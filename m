From: jason@lakedaemon.net (Jason Cooper)
Date: Fri,  2 Aug 2013 15:51:13 +0000
Subject: [RFC PATCH V2 6/9] serial: split out 8250 code, configurable reg addr
In-Reply-To: <cover.1375457714.git.jason@lakedaemon.net>
References: <cover.1375457714.git.jason@lakedaemon.net>
Message-ID: <30c8a8fcb81ea8ed3854e1b8af879a4ebb3f7e5e.1375457714.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 Makefile      |  9 +++++++--
 matcher.lds   |  2 +-
 print.c       |  8 +-------
 serial-8250.c | 21 +++++++++++++++++++++
 serial.h      | 10 ++++++++++
 5 files changed, 40 insertions(+), 10 deletions(-)
 create mode 100644 serial-8250.c
 create mode 100644 serial.h

diff --git a/Makefile b/Makefile
index bb3a154..c799012 100644
--- a/Makefile
+++ b/Makefile
@@ -3,12 +3,17 @@ LDFLAGS=-static -nostdlib
 GCC=$(CROSS_COMPILE)gcc
 OBJCOPY=$(CROSS_COMPILE)objcopy
 LD=$(CROSS_COMPILE)ld
-LOADADDR=0xa0008000
+LOADADDR=0x10008000
 BINFMT=elf32-littlearm
 
 MFG=raumfeld
+UART=8250
+UART_BASE=0xf1012000
+
+CFLAGS+=-DUART_BASE=$(UART_BASE)
 
 BOARD_OBJ = board-$(MFG).o
+UART_OBJ = serial-$(UART).o
 
 COMMON_OBJS = \
 	main.o \
@@ -38,7 +43,7 @@ zimage.o: input/zImage
 %.o: %.c
 	$(GCC) $(CFLAGS) -c $^
 
-matcher: $(COMMON_OBJS) $(BOARD_OBJ) $(INPUT_OBJS)
+matcher: $(COMMON_OBJS) $(BOARD_OBJ) $(UART_OBJ) $(INPUT_OBJS)
 	$(LD) $(LDFLAGS) -T matcher.lds -o $@ $^
 
 matcher.bin: matcher
diff --git a/matcher.lds b/matcher.lds
index f73ed1d..96eb16a 100644
--- a/matcher.lds
+++ b/matcher.lds
@@ -1,5 +1,5 @@
 SECTIONS {
-	. = 0xa0008000;
+	. = 0x10008000;
 	.text : { * (.text); }
 	.data : { * (.data); }
 	.rodata : { * (.rodata); }
diff --git a/print.c b/print.c
index c799380..9dbc7b6 100644
--- a/print.c
+++ b/print.c
@@ -1,5 +1,6 @@
 #include "types.h"
 #include "print.h"
+#include "serial.h"
 
 static inline void nop(int n)
 {
@@ -7,12 +8,6 @@ static inline void nop(int n)
 		asm("nop");
 }
 
-static void __putch(char c)
-{
-	*(volatile __u32 *) 0x40100000 = c;
-	nop(100);
-}
-
 void putch(char c)
 {
 	__putch(c);
@@ -39,4 +34,3 @@ void putstr(const char *s)
 	while (*s)
 		putch(*s++);
 }
-
diff --git a/serial-8250.c b/serial-8250.c
new file mode 100644
index 0000000..0d5d35e
--- /dev/null
+++ b/serial-8250.c
@@ -0,0 +1,21 @@
+#include "types.h"
+#include "register.h"
+#include "serial.h"
+
+/*
+ * Whole heartedly copied from barebox's mach-mvebu debug code.  Thanks to
+ * Thomas Petazzoni for the original code.
+ */
+void __putch(char c)
+{
+	/* Wait until there is space in the FIFO */
+	while (!(readl(UART_BASE + UART_LSR) & LSR_THRE))
+		;
+
+	/* Send the character */
+	writel(c, UART_BASE + UART_THR);
+
+	/* Wait to make sure it hits the line */
+	while (!(readl(UART_BASE + UART_LSR) & LSR_THRE))
+		;
+}
diff --git a/serial.h b/serial.h
new file mode 100644
index 0000000..c5e4581
--- /dev/null
+++ b/serial.h
@@ -0,0 +1,10 @@
+#ifndef _SERIAL_H
+#define _SERIAL_H
+
+#define BIT(nr)         (1UL << (nr))
+#define UART_THR	0x00
+#define UART_LSR	0x14
+#define   LSR_THRE	BIT(5)
+
+void __putch(char);
+#endif
-- 
1.8.3.2
