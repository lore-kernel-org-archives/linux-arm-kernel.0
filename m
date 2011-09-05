From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Sep 2011 02:49:28 -0700
Subject: [PATCH 3/6] ARM: mach-omap1: clean up debug-macro.S
In-Reply-To: <1314932353-24813-4-git-send-email-nico@fluxnic.net>
References: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
	<1314932353-24813-4-git-send-email-nico@fluxnic.net>
Message-ID: <20110905094928.GC1903@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110901 19:26]:
> --- a/arch/arm/mach-omap1/include/mach/debug-macro.S
> +++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
> @@ -34,13 +29,13 @@ omap_uart_virt:	.word	0x0
>  		.macro	addruart, rp, rv, tmp
>  
>  		/* Use omap_uart_phys/virt if already configured */
> -9:		mrc	p15, 0, \rp, c1, c0
> -		tst	\rp, #1			@ MMU enabled?
> -		ldreq	\rp, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
> -		ldrne	\rp, =omap_uart_phys	@ MMU enabled
> -		add	\rv, \rp, #4		@ omap_uart_virt
> -		ldr	\rp, [\rp, #0]
> -		ldr	\rv, [\rv, #0]
> +9:		adr	\rp, 11f		@ get effective addr of 11f
> +		ldr	\rv, [\rp]		@ get absolute addr of 11f
> +		sub	\rv, \rv, \rp		@ offset between the two
> +		ldr	\rp, [\rp, #4]		@ abs addr of omap_uart_phys
> +		sub	\tmp, \rp, \rv		@ make it effective
> +		ldr	\rp, [\tmp, #0]		@ omap_uart_phys
> +		ldr	\rv, [\tmp, #4]		@ omap_uart_virt
>  		cmp	\rp, #0			@ is port configured?
>  		cmpne	\rv, #0
>  		bne	99f			@ already configured

The 11f above will fail for omap1 as we already have 11 defined there
for omap1 uart1. The prepare patch I posted as 2.5/6 fixes that issue.
This will also allow further clean-up to combine omap1 and omap2+
debug-macro.S.

Below is updated version of your patch to use 99f instead of 11f.

Tony


From: Nicolas Pitre <nico@fluxnic.net>
Date: Thu, 1 Sep 2011 22:59:10 -0400
Subject: [PATCH] ARM: mach-omap1: clean up debug-macro.S

This achieves two goals:

1) Get rid of omap_uart_v2p() and omap_uart_p2v() which were the last users
   of PLAT_PHYS_OFFSET.

2) Remove the probing of the M bit in the CP15 control reg and make
   the access to the .data variables completely position independent.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S b/arch/arm/mach-omap1/include/mach/debug-macro.S
index 77a7202..2b36a28 100644
--- a/arch/arm/mach-omap1/include/mach/debug-macro.S
+++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
@@ -13,13 +13,8 @@
 
 #include <linux/serial_reg.h>
 
-#include <asm/memory.h>
-
 #include <plat/serial.h>
 
-#define omap_uart_v2p(x)	((x) - PAGE_OFFSET + PLAT_PHYS_OFFSET)
-#define omap_uart_p2v(x)	((x) - PLAT_PHYS_OFFSET + PAGE_OFFSET)
-
 		.pushsection .data
 omap_uart_phys:	.word	0x0
 omap_uart_virt:	.word	0x0
@@ -34,13 +29,13 @@ omap_uart_virt:	.word	0x0
 		.macro	addruart, rp, rv, tmp
 
 		/* Use omap_uart_phys/virt if already configured */
-9:		mrc	p15, 0, \rp, c1, c0
-		tst	\rp, #1			@ MMU enabled?
-		ldreq	\rp, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
-		ldrne	\rp, =omap_uart_phys	@ MMU enabled
-		add	\rv, \rp, #4		@ omap_uart_virt
-		ldr	\rp, [\rp, #0]
-		ldr	\rv, [\rv, #0]
+9:		adr	\rp, 99f		@ get effective addr of 99f
+		ldr	\rv, [\rp]		@ get absolute addr of 99f
+		sub	\rv, \rv, \rp		@ offset between the two
+		ldr	\rp, [\rp, #4]		@ abs addr of omap_uart_phys
+		sub	\tmp, \rp, \rv		@ make it effective
+		ldr	\rp, [\tmp, #0]		@ omap_uart_phys
+		ldr	\rv, [\tmp, #4]		@ omap_uart_virt
 		cmp	\rp, #0			@ is port configured?
 		cmpne	\rv, #0
 		bne	100f			@ already configured
@@ -72,16 +67,17 @@ omap_uart_virt:	.word	0x0
 
 		/* Store both phys and virt address for the uart */
 98:		add	\rp, \rp, #0xff000000	@ phys base
-		mrc	p15, 0, \rv, c1, c0
-		tst	\rv, #1			@ MMU enabled?
-		ldreq	\rv, =omap_uart_v2p(omap_uart_phys)	@ MMU disabled
-		ldrne	\rv, =omap_uart_phys	@ MMU enabled
-		str	\rp, [\rv, #0]
+		str	\rp, [\tmp, #0]		@ omap_uart_phys
 		sub	\rp, \rp, #0xff000000	@ phys base
 		add	\rp, \rp, #0xfe000000	@ virt base
-		add	\rv, \rv, #4		@ omap_uart_lsr
-		str	\rp, [\rv, #0]
+		str	\rp, [\tmp, #4]		@ omap_uart_virt
 		b	9b
+
+		.align
+99:		.word	.
+		.word	omap_uart_phys
+		.ltorg
+
 100:
 		.endm
 
