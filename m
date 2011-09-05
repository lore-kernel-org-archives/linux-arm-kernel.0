From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Sep 2011 02:51:06 -0700
Subject: [PATCH 4/6] ARM: mach-omap2: clean up debug-macro.S
In-Reply-To: <1314932353-24813-5-git-send-email-nico@fluxnic.net>
References: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
	<1314932353-24813-5-git-send-email-nico@fluxnic.net>
Message-ID: <20110905095106.GD1903@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's this one too updated to use 99f. Other than that:

Tested-by: Tony Lindgren <tony@atomide.com>


From: Nicolas Pitre <nico@fluxnic.net>
Date: Thu, 1 Sep 2011 22:59:11 -0400
Subject: [PATCH] ARM: mach-omap2: clean up debug-macro.S

This achieves two goals:

1) Get rid of omap_uart_v2p() and omap_uart_p2v() which were the last users
   of PLAT_PHYS_OFFSET.

2) Remove the probing of the M bit in the CP15 control reg and make
   the access to the .data variables completely position independent.

There is a catch though: the busyuart macro needs to know where the LSR
register is which might be at a different offset depending on the hardware.
Given that this macro is given only two registers and that one of them
must be preserved, the trick is to always pass the LSR register address
around, and deduce the base address for the THR register by masking out
the LSR offset in senduart instead.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

diff --git a/arch/arm/mach-omap2/include/mach/debug-macro.S b/arch/arm/mach-omap2/include/mach/debug-macro.S
index d48e485..13f98e5 100644
--- a/arch/arm/mach-omap2/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
@@ -13,15 +13,10 @@
 
 #include <linux/serial_reg.h>
 
-#include <asm/memory.h>
-
 #include <plat/serial.h>
 
 #define UART_OFFSET(addr)	((addr) & 0x00ffffff)
 
-#define omap_uart_v2p(x)	((x) - PAGE_OFFSET + PLAT_PHYS_OFFSET)
-#define omap_uart_p2v(x)	((x) - PLAT_PHYS_OFFSET + PAGE_OFFSET)
-
 		.pushsection .data
 omap_uart_phys:	.word	0
 omap_uart_virt:	.word	0
@@ -37,13 +32,13 @@ omap_uart_lsr:	.word	0
 		.macro	addruart, rp, rv, tmp
 
 		/* Use omap_uart_phys/virt if already configured */
-10:		mrc	p15, 0, \rp, c1, c0
-		tst	\rp, #1			@ MMU enabled?
-		ldreq	\rp, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
-		ldrne	\rp, =omap_uart_phys	@ MMU enabled
-		add	\rv, \rp, #4		@ omap_uart_virt
-		ldr	\rp, [\rp, #0]
-		ldr	\rv, [\rv, #0]
+10:		adr	\rp, 99f		@ get effective addr of 99f
+		ldr	\rv, [\rp]		@ get absolute addr of 99f
+		sub	\rv, \rv, \rp		@ offset between the two
+		ldr	\rp, [\rp, #4]		@ abs addr of omap_uart_phys
+		sub	\tmp, \rp, \rv		@ make it effective
+		ldr	\rp, [\tmp, #0]		@ omap_uart_phys
+		ldr	\rv, [\tmp, #4]		@ omap_uart_virt
 		cmp	\rp, #0			@ is port configured?
 		cmpne	\rv, #0
 		bne	100f			@ already configured
@@ -105,50 +100,47 @@ omap_uart_lsr:	.word	0
 		b	98f
 83:		mov	\rp, #UART_OFFSET(TI816X_UART3_BASE)
 		b	98f
+
 95:		ldr	\rp, =ZOOM_UART_BASE
-		mrc	p15, 0, \rv, c1, c0
-		tst	\rv, #1			@ MMU enabled?
-		ldreq	\rv, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
-		ldrne	\rv, =omap_uart_phys	@ MMU enabled
-		str	\rp, [\rv, #0]
+		str	\rp, [\tmp, #0]		@ omap_uart_phys
 		ldr	\rp, =ZOOM_UART_VIRT
-		add	\rv, \rv, #4		@ omap_uart_virt
-		str	\rp, [\rv, #0]
+		str	\rp, [\tmp, #4]		@ omap_uart_virt
 		mov	\rp, #(UART_LSR << ZOOM_PORT_SHIFT)
-		add	\rv, \rv, #4		@ omap_uart_lsr
-		str	\rp, [\rv, #0]
+		str	\rp, [\tmp, #8]		@ omap_uart_lsr
 		b	10b
 
 		/* Store both phys and virt address for the uart */
 98:		add	\rp, \rp, #0x48000000	@ phys base
-		mrc	p15, 0, \rv, c1, c0
-		tst	\rv, #1			@ MMU enabled?
-		ldreq	\rv, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
-		ldrne	\rv, =omap_uart_phys	@ MMU enabled
-		str	\rp, [\rv, #0]
+		str	\rp, [\tmp, #0]		@ omap_uart_phys
 		sub	\rp, \rp, #0x48000000	@ phys base
 		add	\rp, \rp, #0xfa000000	@ virt base
-		add	\rv, \rv, #4		@ omap_uart_virt
-		str	\rp, [\rv, #0]
+		str	\rp, [\tmp, #4]		@ omap_uart_virt
 		mov	\rp, #(UART_LSR << OMAP_PORT_SHIFT)
-		add	\rv, \rv, #4		@ omap_uart_lsr
-		str	\rp, [\rv, #0]
+		str	\rp, [\tmp, #8]		@ omap_uart_lsr
 
 		b	10b
-100:
+
+		.align
+99:		.word	.
+		.word	omap_uart_phys
+		.ltorg
+
+100:		/* Pass the UART_LSR reg address */
+		ldr	\tmp, [\tmp, #8]	@ omap_uart_lsr
+		add	\rp, \rp, \tmp
+		add	\rv, \rv, \tmp
 		.endm
 
 		.macro	senduart,rd,rx
-		strb	\rd, [\rx]
+		orr	\rd, \rd, \rx, lsl #24	@ preserve LSR reg offset
+		bic	\rx, \rx, #0xff		@ get base (THR) reg address
+		strb	\rd, [\rx]		@ send lower byte of rd
+		orr	\rx, \rx, \rd, lsr #24	@ restore original rx (LSR)
+		bic	\rd, \rd, #(0xff << 24)	@ restore original rd
 		.endm
 
 		.macro	busyuart,rd,rx
-1001:		mrc	p15, 0, \rd, c1, c0
-		tst	\rd, #1			@ MMU enabled?
-		ldreq	\rd, =omap_uart_v2p(omap_uart_lsr)	@ MMU disabled
-		ldrne	\rd, =omap_uart_lsr	@ MMU enabled
-		ldr	\rd, [\rd, #0]
-		ldrb	\rd, [\rx, \rd]
+1001:		ldrb	\rd, [\rx]		@ rx contains UART_LSR address
 		and	\rd, \rd, #(UART_LSR_TEMT | UART_LSR_THRE)
 		teq	\rd, #(UART_LSR_TEMT | UART_LSR_THRE)
 		bne	1001b
