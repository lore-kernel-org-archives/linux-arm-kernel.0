From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Jul 2012 14:25:54 +0100
Subject: [PATCH 1/2] ARM: vexpress: add debug UARTs to DEBUG_LL kconfig
 choice
In-Reply-To: <20120705094218.GB3399@mudshark.cambridge.arm.com>
References: <1341414076-20895-1-git-send-email-will.deacon@arm.com>
 <1341480232.1173.22.camel@hornet>
 <20120705093348.GA3399@mudshark.cambridge.arm.com>
 <1341481080.1173.28.camel@hornet>
 <20120705094218.GB3399@mudshark.cambridge.arm.com>
Message-ID: <20120706132554.GE31970@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 10:42:18AM +0100, Will Deacon wrote:
> On Thu, Jul 05, 2012 at 10:38:00AM +0100, Pawel Moll wrote:
> > This was the reason my Kconfig options weren't in DEBUG_LL but in
> > ARCH_VEXPRESS - to serve both decompressor and early console. But as it
> > was NAKed I'm considering several options, one (the simplest) of them is
> > printing nothing in the decompressor unless DEBUG_LL is selected.
> 
> Indeed, that's the option I'd favour but I thought I'd check whether you
> were alright with that before updating the patch.

For what it's worth, here's the additional diff:


diff --git a/arch/arm/mach-vexpress/include/mach/uncompress.h b/arch/arm/mach-vexpress/include/mach/uncompress.h
index 7dab559..4dbb3ac 100644
--- a/arch/arm/mach-vexpress/include/mach/uncompress.h
+++ b/arch/arm/mach-vexpress/include/mach/uncompress.h
@@ -22,36 +22,19 @@
 #define AMBA_UART_CR(base)     (*(volatile unsigned char *)((base) + 0x30))
 #define AMBA_UART_FR(base)     (*(volatile unsigned char *)((base) + 0x18))
 
+#ifdef CONFIG_DEBUG_VEXPRESS_CA9X4_UART
 #define UART_BASE      0x10009000
-#define UART_BASE_RS1  0x1c090000
-
-static unsigned long get_uart_base(void)
-{
-       unsigned long mpcore_periph;
-
-       /*
-        * Make an educated guess regarding the memory map:
-        * - the original A9 core tile, which has MPCore peripherals
-        *   located at 0x1e000000, should use UART at 0x10009000
-        * - all other (RS1 complaint) tiles use UART mapped
-        *   at 0x1c090000
-        */
-       asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (mpcore_periph));
-
-       if (mpcore_periph == 0x1e000000)
-               return UART_BASE;
-       else
-               return UART_BASE_RS1;
-}
+#elif CONFIG_DEBUG_VEXPRESS_RS1_UART
+#define UART_BASE      0x1c090000
+#endif
 
+#ifdef UART_BASE
 /*
  * This does not append a newline
  */
 static inline void putc(int c)
 {
-       unsigned long base = get_uart_base();
-
-       while (AMBA_UART_FR(base) & (1 << 5))
+       while (AMBA_UART_FR(UART_BASE) & (1 << 5))
                barrier();
 
        AMBA_UART_DR(base) = c;
@@ -59,11 +42,13 @@ static inline void putc(int c)
 
 static inline void flush(void)
 {
-       unsigned long base = get_uart_base();
-
-       while (AMBA_UART_FR(base) & (1 << 3))
+       while (AMBA_UART_FR(UART_BASE) & (1 << 3))
                barrier();
 }
+#else
+static inline void putc(int c) {}
+static inline void flush(void) {}
+#endif
 
 /*
  * nothing to do


Will
