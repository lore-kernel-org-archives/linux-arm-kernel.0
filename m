From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Apr 2010 17:39:19 -0700
Subject: [PATCH] omap: Use a memory address for storing the debug port info instead of UART1
Message-ID: <mailman.348.1272677882.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the dependency to the UART1 being
available for storing the debug configuration in
uncompress.h.

As suggested by Cyril Chemparathy <cyril@ti.com>,
Vikram Pandita <vikram.pandita@ti.com> and
Kevin Hilman <khilman@deeprootsystems.com>.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index b6d9584..e8a8cf3 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -13,6 +13,8 @@
 
 #include <linux/serial_reg.h>
 
+#include <asm/memory.h>
+
 #include <plat/serial.h>
 
 		.pushsection .data
@@ -37,23 +39,12 @@ omap_uart_virt:	.word	0x0
 		cmp	\rx, #0			@ is port configured?
 		bne	99f			@ already configured
 
-		/* Check 7XX UART1 scratchpad register for uart to use */
+		/* Check the debug UART configuration set in uncompress.h */
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0xff000000	@ physical base address
-		movne	\rx, #0xfe000000	@ virtual base
-		orr	\rx, \rx, #0x00fb0000	@ OMAP1UART1
-		ldrb	\rx, [\rx, #(UART_SCR << OMAP7XX_PORT_SHIFT)]
-		cmp	\rx, #0			@ anything in 7XX scratchpad?
-		bne	10f			@ found 7XX uart
-
-		/* Check 15xx/16xx UART1 scratchpad register for uart to use */
-		mrc	p15, 0, \rx, c1, c0
-		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0xff000000	@ physical base address
-		movne	\rx, #0xfe000000	@ virtual base
-		orr	\rx, \rx, #0x00fb0000	@ OMAP1UART1
-		ldrb	\rx, [\rx, #(UART_SCR << OMAP_PORT_SHIFT)]
+		ldreq	\rx, =OMAP_UART_INFO
+		ldrne	\rx, =__phys_to_virt(OMAP_UART_INFO)
+		ldr	\rx, [\rx, #0]
 
 		/* Select the UART to use based on the UART1 scratchpad value */
 10:		cmp	\rx, #0			@ no port configured?
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index 4a63a2e..4976169 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -13,6 +13,8 @@
 
 #include <linux/serial_reg.h>
 
+#include <asm/memory.h>
+
 #include <plat/serial.h>
 
 #define UART_OFFSET(addr)	((addr) & 0x00ffffff)
@@ -40,13 +42,12 @@ omap_uart_lsr:	.word	0
 		cmp	\rx, #0			@ is port configured?
 		bne	99f			@ already configured
 
-		/* Check UART1 scratchpad register for uart to use */
+		/* Check the debug UART configuration set in uncompress.h */
 		mrc	p15, 0, \rx, c1, c0
 		tst	\rx, #1			@ MMU enabled?
-		moveq	\rx, #0x48000000	@ physical base address
-		movne	\rx, #0xfa000000	@ virtual base
-		orr	\rx, \rx, #0x0006a000	@ uart1 on omap2/3/4
-		ldrb	\rx, [\rx, #(UART_SCR << OMAP_PORT_SHIFT)] @ scratchpad
+		ldreq	\rx, =OMAP_UART_INFO
+		ldrne	\rx, =__phys_to_virt(OMAP_UART_INFO)
+		ldr	\rx, [\rx, #0]
 
 		/* Select the UART to use based on the UART1 scratchpad value */
 		cmp	\rx, #0			@ no port configured?
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 83dce4c..20c27b9 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -15,6 +15,8 @@
 
 #include <linux/init.h>
 
+#define OMAP_UART_INFO		(PHYS_OFFSET + 0x3ff8)
+
 /* OMAP1 serial ports */
 #define OMAP1_UART1_BASE	0xfffb0000
 #define OMAP1_UART2_BASE	0xfffb0800
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 81d9ec5..44478f7 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -20,27 +20,22 @@
 #include <linux/types.h>
 #include <linux/serial_reg.h>
 
+#include <asm/memory.h>
+#include <asm/io.h>
 #include <asm/mach-types.h>
 
 #include <plat/serial.h>
 
-static volatile u8 *uart1_base;
-static int uart1_shift;
-
 static volatile u8 *uart_base;
 static int uart_shift;
 
 /*
- * Store the DEBUG_LL uart number into UART1 scratchpad register.
+ * Store the DEBUG_LL uart number into memory.
  * See also debug-macro.S, and serial.c for related code.
- *
- * Please note that we currently assume that:
- * - UART1 clocks are enabled for register access
- * - UART1 scratchpad register can be used
  */
-static void set_uart1_scratchpad(unsigned char port)
+static void set_omap_uart_info(unsigned char port)
 {
-	uart1_base[UART_SCR << uart1_shift] = port;
+	*(volatile u32 *)OMAP_UART_INFO = port;
 }
 
 static void putc(int c)
@@ -60,42 +55,38 @@ static inline void flush(void)
 /*
  * Macros to configure UART1 and debug UART
  */
-#define _DEBUG_LL_ENTRY(mach, uart1_phys, uart1_shft,			\
-			dbg_uart, dbg_shft, dbg_id)			\
+#define _DEBUG_LL_ENTRY(mach, dbg_uart, dbg_shft, dbg_id)		\
 	if (machine_is_##mach()) {					\
-		uart1_base = (volatile u8 *)(uart1_phys);		\
-		uart1_shift = (uart1_shft);				\
 		uart_base = (volatile u8 *)(dbg_uart);			\
 		uart_shift = (dbg_shft);				\
 		port = (dbg_id);					\
-		set_uart1_scratchpad(port);				\
+		set_omap_uart_info(port);				\
 		break;							\
 	}
 
 #define DEBUG_LL_OMAP7XX(p, mach)					\
-	_DEBUG_LL_ENTRY(mach, OMAP1_UART1_BASE, OMAP7XX_PORT_SHIFT,	\
-		OMAP1_UART##p##_BASE, OMAP7XX_PORT_SHIFT, OMAP1UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP1_UART##p##_BASE, OMAP7XX_PORT_SHIFT,	\
+		OMAP1UART##p)
 
 #define DEBUG_LL_OMAP1(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP1_UART1_BASE, OMAP_PORT_SHIFT,	\
-		OMAP1_UART##p##_BASE, OMAP_PORT_SHIFT, OMAP1UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP1_UART##p##_BASE, OMAP_PORT_SHIFT,	\
+		OMAP1UART##p)
 
 #define DEBUG_LL_OMAP2(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP2_UART1_BASE, OMAP_PORT_SHIFT,	\
-		OMAP2_UART##p##_BASE, OMAP_PORT_SHIFT, OMAP2UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP2_UART##p##_BASE, OMAP_PORT_SHIFT,	\
+		OMAP2UART##p)
 
 #define DEBUG_LL_OMAP3(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP3_UART1_BASE, OMAP_PORT_SHIFT,	\
-		OMAP3_UART##p##_BASE, OMAP_PORT_SHIFT, OMAP3UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP3_UART##p##_BASE, OMAP_PORT_SHIFT,	\
+		OMAP3UART##p)
 
 #define DEBUG_LL_OMAP4(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP4_UART1_BASE, OMAP_PORT_SHIFT,	\
-		OMAP4_UART##p##_BASE, OMAP_PORT_SHIFT, OMAP4UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP4_UART##p##_BASE, OMAP_PORT_SHIFT,	\
+		OMAP4UART##p)
 
 /* Zoom2/3 shift is different for UART1 and external port */
 #define DEBUG_LL_ZOOM(mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP2_UART1_BASE, OMAP_PORT_SHIFT,	\
-		ZOOM_UART_BASE, ZOOM_PORT_SHIFT, ZOOM_UART)
+	_DEBUG_LL_ENTRY(mach, ZOOM_UART_BASE, ZOOM_PORT_SHIFT, ZOOM_UART)
 
 static inline void __arch_decomp_setup(unsigned long arch_id)
 {

--H8ygTp4AXg6deix2--
