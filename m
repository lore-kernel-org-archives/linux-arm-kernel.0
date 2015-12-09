From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Dec 2015 17:25:41 +0100
Subject: [PATCH] ARM: uncompress: mark putc as inline
Message-ID: <1962264.KJrrNzEWG9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_DEBUG_ICEDCC is set, we don't use the platform
specific putc() function, but use icedcc_putc() instead, so
putc is unused and causes a compile time warning:

In file included from ../arch/arm/boot/compressed/misc.c:28:0:
arch/arm/mach-rpc/include/mach/uncompress.h:79:13: warning: 'putc' defined but not used [-Wunused-function]
arch/arm/mach-w90x900/include/mach/uncompress.h:30:13: warning: 'putc' defined but not used [-Wunused-function]

On most platforms, this does not happen, because putc is defined
as 'static inline' so the compiler will automatically drop it
when it's unused.

This changes the remaining seven platforms to behave the same way.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
index 8fb97b93b6bb..53b456a5bbe0 100644
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ b/arch/arm/mach-davinci/include/mach/uncompress.h
@@ -30,7 +30,7 @@
 u32 *uart;
 
 /* PORT_16C550A, in polled non-fifo mode */
-static void putc(char c)
+static inline void putc(char c)
 {
 	if (!uart)
 		return;
diff --git a/arch/arm/mach-ks8695/include/mach/uncompress.h b/arch/arm/mach-ks8695/include/mach/uncompress.h
index c089a1aea674..a001c7c34df2 100644
--- a/arch/arm/mach-ks8695/include/mach/uncompress.h
+++ b/arch/arm/mach-ks8695/include/mach/uncompress.h
@@ -17,7 +17,7 @@
 #include <linux/io.h>
 #include <mach/regs-uart.h>
 
-static void putc(char c)
+static inline void putc(char c)
 {
 	while (!(__raw_readl((void __iomem*)KS8695_UART_PA + KS8695_URLS) & URLS_URTHRE))
 		barrier();
diff --git a/arch/arm/mach-netx/include/mach/uncompress.h b/arch/arm/mach-netx/include/mach/uncompress.h
index 5cb1051b5831..033875dbc32b 100644
--- a/arch/arm/mach-netx/include/mach/uncompress.h
+++ b/arch/arm/mach-netx/include/mach/uncompress.h
@@ -40,7 +40,7 @@
 #define FR_BUSY (1<<3)
 #define FR_TXFF (1<<5)
 
-static void putc(char c)
+static inline void putc(char c)
 {
 	unsigned long base;
 
diff --git a/arch/arm/mach-omap1/include/mach/uncompress.h b/arch/arm/mach-omap1/include/mach/uncompress.h
index 4869633de8cd..9cca6a56788f 100644
--- a/arch/arm/mach-omap1/include/mach/uncompress.h
+++ b/arch/arm/mach-omap1/include/mach/uncompress.h
@@ -45,7 +45,7 @@ static void set_omap_uart_info(unsigned char port)
 	*uart_info = port;
 }
 
-static void putc(int c)
+static inline void putc(int c)
 {
 	if (!uart_base)
 		return;
diff --git a/arch/arm/mach-rpc/include/mach/uncompress.h b/arch/arm/mach-rpc/include/mach/uncompress.h
index 0fd4b0b8ef22..654a6f3f2547 100644
--- a/arch/arm/mach-rpc/include/mach/uncompress.h
+++ b/arch/arm/mach-rpc/include/mach/uncompress.h
@@ -76,7 +76,7 @@ int white;
 /*
  * This does not append a newline
  */
-static void putc(int c)
+static inline void putc(int c)
 {
 	extern void ll_write_char(char *, char c, char white);
 	int x,y;
diff --git a/arch/arm/mach-sa1100/include/mach/uncompress.h b/arch/arm/mach-sa1100/include/mach/uncompress.h
index 73093dc89829..a1a041b9740b 100644
--- a/arch/arm/mach-sa1100/include/mach/uncompress.h
+++ b/arch/arm/mach-sa1100/include/mach/uncompress.h
@@ -19,7 +19,7 @@
 
 #define UART(x)		(*(volatile unsigned long *)(serial_port + (x)))
 
-static void putc(int c)
+static inline void putc(int c)
 {
 	unsigned long serial_port;
 
diff --git a/arch/arm/mach-w90x900/include/mach/uncompress.h b/arch/arm/mach-w90x900/include/mach/uncompress.h
index 4b7c324ff664..3855ecebda6e 100644
--- a/arch/arm/mach-w90x900/include/mach/uncompress.h
+++ b/arch/arm/mach-w90x900/include/mach/uncompress.h
@@ -27,7 +27,7 @@
 #define TX_DONE	(UART_LSR_TEMT | UART_LSR_THRE)
 static volatile u32 * const uart_base = (u32 *)UART0_PA;
 
-static void putc(int ch)
+static inline void putc(int ch)
 {
 	/* Check THRE and TEMT bits before we transmit the character.
 	 */
