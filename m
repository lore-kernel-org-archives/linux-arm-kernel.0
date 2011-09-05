From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Sep 2011 08:07:59 -0700
Subject: [PATCH 4.5/6] ARM: omap: pass phys, virt and lsr from uncompress.h
	to debug-macro.S
In-Reply-To: <1314932353-24813-5-git-send-email-nico@fluxnic.net>
References: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
	<1314932353-24813-5-git-send-email-nico@fluxnic.net>
Message-ID: <20110905150758.GG1903@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Earlier code passed the serial port configuration number as the
code originally used the scratchpad register in the serial port
to pass it from uncompress.h to debug-macro.S. This is no longer
the case as some omaps don't have a serial port. A memory address
is used instead.

Change the code to pass phys, virt and lsr from uncompress.h
to debug-macro.S. Note that the virt value is only used on zoom
boards that have an external 8250 hardware.

This will make it possible to combine omap1 and omap2+ debug-macro.S.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index 2b36a28..18b72b9 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -18,6 +18,7 @@
 		.pushsection .data
 omap_uart_phys:	.word	0x0
 omap_uart_virt:	.word	0x0
+omap_uart_lsr:	.word   0x0
 		.popsection
 
 		/*
@@ -43,34 +44,13 @@ omap_uart_virt:	.word	0x0
 		/* Check the debug UART configuration set in uncompress.h */
 		and	\rp, pc, #0xff000000
 		ldr	\rv, =OMAP_UART_INFO_OFS
-		ldr	\rp, [\rp, \rv]
-
-		/* Select the UART to use based on the UART1 scratchpad value */
-10:		cmp	\rp, #0			@ no port configured?
-		beq	11f			@ if none, try to use UART1
-		cmp	\rp, #OMAP1UART1
-		beq	11f			@ configure OMAP1UART1
-		cmp	\rp, #OMAP1UART2
-		beq	12f			@ configure OMAP1UART2
-		cmp	\rp, #OMAP1UART3
-		beq	13f			@ configure OMAP2UART3
-
-		/* Configure the UART offset from the phys/virt base */
-11:		mov	\rp, #0x00fb0000	@ OMAP1UART1
-		b	98f
-12:		mov	\rp, #0x00fb0000	@ OMAP1UART1
-		orr	\rp, \rp, #0x00000800	@ OMAP1UART2
-		b	98f
-13:		mov	\rp, #0x00fb0000	@ OMAP1UART1
-		orr	\rp, \rp, #0x00000800	@ OMAP1UART2
-		orr	\rp, \rp, #0x00009000	@ OMAP1UART3
-
-		/* Store both phys and virt address for the uart */
-98:		add	\rp, \rp, #0xff000000	@ phys base
-		str	\rp, [\tmp, #0]		@ omap_uart_phys
-		sub	\rp, \rp, #0xff000000	@ phys base
-		add	\rp, \rp, #0xfe000000	@ virt base
-		str	\rp, [\tmp, #4]		@ omap_uart_virt
+		add	\rp, \rp, \rv		@ uart_info
+		ldr	\rv, [\rp, #0]		@ get configured pa
+		str	\rv, [\tmp, #0]		@ omap_uart_phys
+		ldr	\rv, [\rp, #4]		@ get configured va
+		str	\rv, [\tmp, #4]		@ set omap_uart_virt
+		ldr	\rv, [\rp, #8]		@ get configured lsr
+		str	\rv, [\tmp, #8]		@ set omap_uart_lsr
 		b	9b
 
 		.align
diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index d86f6ba..f692140 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -15,8 +15,6 @@
 
 #include <plat/serial.h>
 
-#define UART_OFFSET(addr)	((addr) & 0x00ffffff)
-
 		.pushsection .data
 omap_uart_phys:	.word	0
 omap_uart_virt:	.word	0
@@ -46,77 +44,13 @@ omap_uart_lsr:	.word	0
 		/* Check the debug UART configuration set in uncompress.h */
 		and	\rp, pc, #0xff000000
 		ldr	\rv, =OMAP_UART_INFO_OFS
-		ldr	\rp, [\rp, \rv]
-
-		/* Select the UART to use based on the UART1 scratchpad value */
-		cmp	\rp, #0			@ no port configured?
-		beq	21f			@ if none, try to use UART1
-		cmp	\rp, #OMAP2UART1	@ OMAP2/3/4UART1
-		beq	21f			@ configure OMAP2/3/4UART1
-		cmp	\rp, #OMAP2UART2	@ OMAP2/3/4UART2
-		beq	22f			@ configure OMAP2/3/4UART2
-		cmp	\rp, #OMAP2UART3	@ only on 24xx
-		beq	23f			@ configure OMAP2UART3
-		cmp	\rp, #OMAP3UART3	@ only on 34xx
-		beq	33f			@ configure OMAP3UART3
-		cmp	\rp, #OMAP4UART3	@ only on 44xx
-		beq	43f			@ configure OMAP4UART3
-		cmp	\rp, #OMAP3UART4	@ only on 36xx
-		beq	34f			@ configure OMAP3UART4
-		cmp	\rp, #OMAP4UART4	@ only on 44xx
-		beq	44f			@ configure OMAP4UART4
-		cmp	\rp, #TI816XUART1	@ ti816x UART offsets different
-		beq	81f			@ configure UART1
-		cmp	\rp, #TI816XUART2	@ ti816x UART offsets different
-		beq	82f			@ configure UART2
-		cmp	\rp, #TI816XUART3	@ ti816x UART offsets different
-		beq	83f			@ configure UART3
-		cmp	\rp, #ZOOM_UART		@ only on zoom2/3
-		beq	95f			@ configure ZOOM_UART
-
-		/* Configure the UART offset from the phys/virt base */
-21:		mov	\rp, #UART_OFFSET(OMAP2_UART1_BASE)	@ omap2/3/4
-		b	98f
-22:		mov	\rp, #UART_OFFSET(OMAP2_UART2_BASE)	@ omap2/3/4
-		b	98f
-23:		mov	\rp, #UART_OFFSET(OMAP2_UART3_BASE)
-		b	98f
-33:		mov	\rp, #UART_OFFSET(OMAP3_UART1_BASE)
-		add	\rp, \rp, #0x00fb0000
-		add	\rp, \rp, #0x00006000		@ OMAP3_UART3_BASE
-		b	98f
-34:		mov	\rp, #UART_OFFSET(OMAP3_UART1_BASE)
-		add	\rp, \rp, #0x00fb0000
-		add	\rp, \rp, #0x00028000		@ OMAP3_UART4_BASE
-		b	98f
-43:		mov	\rp, #UART_OFFSET(OMAP4_UART3_BASE)
-		b	98f
-44:		mov	\rp, #UART_OFFSET(OMAP4_UART4_BASE)
-		b	98f
-81:		mov	\rp, #UART_OFFSET(TI816X_UART1_BASE)
-		b	98f
-82:		mov	\rp, #UART_OFFSET(TI816X_UART2_BASE)
-		b	98f
-83:		mov	\rp, #UART_OFFSET(TI816X_UART3_BASE)
-		b	98f
-
-95:		ldr	\rp, =ZOOM_UART_BASE
-		str	\rp, [\tmp, #0]		@ omap_uart_phys
-		ldr	\rp, =ZOOM_UART_VIRT
-		str	\rp, [\tmp, #4]		@ omap_uart_virt
-		mov	\rp, #(UART_LSR << ZOOM_PORT_SHIFT)
-		str	\rp, [\tmp, #8]		@ omap_uart_lsr
-		b	10b
-
-		/* Store both phys and virt address for the uart */
-98:		add	\rp, \rp, #0x48000000	@ phys base
-		str	\rp, [\tmp, #0]		@ omap_uart_phys
-		sub	\rp, \rp, #0x48000000	@ phys base
-		add	\rp, \rp, #0xfa000000	@ virt base
-		str	\rp, [\tmp, #4]		@ omap_uart_virt
-		mov	\rp, #(UART_LSR << OMAP_PORT_SHIFT)
-		str	\rp, [\tmp, #8]		@ omap_uart_lsr
-
+		add	\rp, \rp, \rv		@ uart_info
+		ldr	\rv, [\rp, #0]		@ get configured pa
+		str	\rv, [\tmp, #0]		@ omap_uart_phys
+		ldr	\rv, [\rp, #4]		@ get configured va
+		str	\rv, [\tmp, #4]		@ set omap_uart_virt
+		ldr	\rv, [\rp, #8]		@ get configured lsr
+		str	\rv, [\tmp, #8]		@ set omap_uart_lsr
 		b	10b
 
 		.align
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 1ab9fd6..20f43aa 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -27,7 +27,7 @@
  * 2. We assume printascii is called@least once before paging_init,
  *    and addruart has a chance to read OMAP_UART_INFO
  */
-#define OMAP_UART_INFO_OFS	0x3ffc
+#define OMAP_UART_INFO_OFS	0x3ff4
 
 /* OMAP1 serial ports */
 #define OMAP1_UART1_BASE	0xfffb0000
@@ -71,29 +71,6 @@
 #define OMAP16XX_BASE_BAUD	(48000000/16)
 #define OMAP24XX_BASE_BAUD	(48000000/16)
 
-/*
- * DEBUG_LL port encoding stored into the UART1 scratchpad register by
- * decomp_setup in uncompress.h
- */
-#define OMAP1UART1		11
-#define OMAP1UART2		12
-#define OMAP1UART3		13
-#define OMAP2UART1		21
-#define OMAP2UART2		22
-#define OMAP2UART3		23
-#define OMAP3UART1		OMAP2UART1
-#define OMAP3UART2		OMAP2UART2
-#define OMAP3UART3		33
-#define OMAP3UART4		34		/* Only on 36xx */
-#define OMAP4UART1		OMAP2UART1
-#define OMAP4UART2		OMAP2UART2
-#define OMAP4UART3		43
-#define OMAP4UART4		44
-#define TI816XUART1		81
-#define TI816XUART2		82
-#define TI816XUART3		83
-#define ZOOM_UART		95		/* Only on zoom2/3 */
-
 /* This is only used by 8250.c for omap1510 */
 #define is_omap_port(pt)	({int __ret = 0;			\
 			if ((pt)->port.mapbase == OMAP1_UART1_BASE ||	\
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 71763db..172cd98 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -19,6 +19,7 @@
 
 #include <linux/types.h>
 #include <linux/serial_reg.h>
+#include <linux/io.h>
 
 #include <asm/memory.h>
 #include <asm/mach-types.h>
@@ -28,21 +29,26 @@
 #define MDR1_MODE_MASK			0x07
 
 volatile u8 *uart_base;
+void __iomem *uart_virt;
 int uart_shift;
 
 /*
  * Store the DEBUG_LL uart number into memory.
  * See also debug-macro.S, and serial.c for related code.
  */
-static void set_omap_uart_info(unsigned char port)
+static void set_omap_uart_info(void)
 {
-	/* 
-	 * Get address of some.bss variable and round it down 
+	/*
+	 * Get address of some.bss variable and round it down
 	 * a la CONFIG_AUTO_ZRELADDR.
 	 */
 	u32 ram_start = (u32)&uart_shift & 0xf8000000;
 	u32 *uart_info = (u32 *)(ram_start + OMAP_UART_INFO_OFS);
-	*uart_info = port;
+	*uart_info = (u32)uart_base;
+	uart_info++;
+	*uart_info = (u32)uart_virt;
+	uart_info++;
+	*uart_info = UART_LSR << uart_shift;
 }
 
 static void putc(int c)
@@ -66,47 +72,46 @@ static inline void flush(void)
 /*
  * Macros to configure UART1 and debug UART
  */
-#define _DEBUG_LL_ENTRY(mach, dbg_uart, dbg_shft, dbg_id)		\
+#define _DEBUG_LL_ENTRY(mach, dbg_uart, dbg_virt, dbg_shft)		\
 	if (machine_is_##mach()) {					\
 		uart_base = (volatile u8 *)(dbg_uart);			\
+		uart_virt = (dbg_virt);					\
 		uart_shift = (dbg_shft);				\
-		port = (dbg_id);					\
-		set_omap_uart_info(port);				\
+		set_omap_uart_info();					\
 		break;							\
 	}
 
 #define DEBUG_LL_OMAP7XX(p, mach)					\
-	_DEBUG_LL_ENTRY(mach, OMAP1_UART##p##_BASE, OMAP7XX_PORT_SHIFT,	\
-		OMAP1UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP1_UART##p##_BASE,			\
+	OMAP1_IO_ADDRESS(OMAP1_UART##p##_BASE), OMAP7XX_PORT_SHIFT)
 
 #define DEBUG_LL_OMAP1(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP1_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		OMAP1UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP1_UART##p##_BASE,			\
+	OMAP1_IO_ADDRESS(OMAP1_UART##p##_BASE), OMAP_PORT_SHIFT)
 
 #define DEBUG_LL_OMAP2(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP2_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		OMAP2UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP2_UART##p##_BASE,			\
+	OMAP2_L4_IO_ADDRESS(OMAP2_UART##p##_BASE), OMAP_PORT_SHIFT)
 
 #define DEBUG_LL_OMAP3(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP3_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		OMAP3UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP3_UART##p##_BASE,			\
+	OMAP2_L4_IO_ADDRESS(OMAP3_UART##p##_BASE), OMAP_PORT_SHIFT)
 
 #define DEBUG_LL_OMAP4(p, mach)						\
-	_DEBUG_LL_ENTRY(mach, OMAP4_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		OMAP4UART##p)
+	_DEBUG_LL_ENTRY(mach, OMAP4_UART##p##_BASE,			\
+	OMAP2_L4_IO_ADDRESS(OMAP4_UART##p##_BASE), OMAP_PORT_SHIFT)
 
 /* Zoom2/3 shift is different for UART1 and external port */
 #define DEBUG_LL_ZOOM(mach)						\
-	_DEBUG_LL_ENTRY(mach, ZOOM_UART_BASE, ZOOM_PORT_SHIFT, ZOOM_UART)
+	_DEBUG_LL_ENTRY(mach, ZOOM_UART_BASE, IOMEM(ZOOM_UART_VIRT),	\
+				ZOOM_PORT_SHIFT)
 
 #define DEBUG_LL_TI816X(p, mach)					\
-	_DEBUG_LL_ENTRY(mach, TI816X_UART##p##_BASE, OMAP_PORT_SHIFT,	\
-		TI816XUART##p)
+	_DEBUG_LL_ENTRY(mach, TI816X_UART##p##_BASE,			\
+	OMAP2_L4_IO_ADDRESS(TI816X_UART##p##_BASE), OMAP_PORT_SHIFT)
 
 static inline void __arch_decomp_setup(unsigned long arch_id)
 {
-	int port = 0;
-
 	/*
 	 * Initialize the port based on the machine ID from the bootloader.
 	 * Note that we're using macros here instead of switch statement
