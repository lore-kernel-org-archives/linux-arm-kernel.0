From: tony@atomide.com (Tony Lindgren)
Date: Tue, 12 Jan 2010 18:19:40 -0800
Subject: [PATCH] ARM: Fix uncompress code compile for different defines of
	static(void)
Message-ID: <20100113021939.GE2986@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because of the include of the decompress_inflate.c file from
boot/compress/misc.c, there are different flush() defines:

In file included from arch/arm/boot/compressed/misc.c:249:
arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:138:29: error: macro "flush" passed 2 arguments, but takes just 0

Fix this by removing the define of flush() in misc.c for
CONFIG_DEBUG_ICEDCC as it's already defined in mach/uncompress.h,
and that is being included unconditionally.

Also use a static inline function instead of define
for mach-mxc and mach-gemini to avoid similar bug
for those platforms.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -100,7 +100,6 @@ static void icedcc_putc(int ch)
 #endif
 
 #define putc(ch)	icedcc_putc(ch)
-#define flush()	do { } while (0)
 #endif
 
 static void putstr(const char *ptr)
--- a/arch/arm/mach-gemini/include/mach/uncompress.h
+++ b/arch/arm/mach-gemini/include/mach/uncompress.h
@@ -30,7 +30,9 @@ static inline void putc(char c)
 	UART[UART_TX] = c;
 }
 
-#define flush() do { } while (0)
+static inline void flush(void)
+{
+}
 
 /*
  * nothing to do
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -60,7 +60,9 @@ static void putc(int ch)
 	UART(TXR) = ch;
 }
 
-#define flush() do { } while (0)
+static inline void flush(void)
+{
+}
 
 #define MX1_UART1_BASE_ADDR	0x00206000
 #define MX25_UART1_BASE_ADDR	0x43f90000
