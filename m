From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 01 Sep 2011 22:59:13 -0400
Subject: [PATCH 6/6] ARM: mach-davinci: clean up debug-macro.S
In-Reply-To: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
References: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
Message-ID: <1314932353-24813-7-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This achieves two goals:

1) Get rid of davinci_uart_v2p() and davinci_uart_p2v() which were the
   last users of PLAT_PHYS_OFFSET.

2) Remove the probing of the M bit in the CP15 control reg and make
   the access to the .data variables completely position independent.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-davinci/include/mach/debug-macro.S |   39 +++++++++------------
 1 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/debug-macro.S b/arch/arm/mach-davinci/include/mach/debug-macro.S
index 45fff2c..2055bcb 100644
--- a/arch/arm/mach-davinci/include/mach/debug-macro.S
+++ b/arch/arm/mach-davinci/include/mach/debug-macro.S
@@ -18,15 +18,10 @@
 
 #include <linux/serial_reg.h>
 
-#include <asm/memory.h>
-
 #include <mach/serial.h>
 
 #define UART_SHIFT	2
 
-#define davinci_uart_v2p(x)	((x) - PAGE_OFFSET + PLAT_PHYS_OFFSET)
-#define davinci_uart_p2v(x)	((x) - PLAT_PHYS_OFFSET + PAGE_OFFSET)
-
 		.pushsection .data
 davinci_uart_phys:	.word	0
 davinci_uart_virt:	.word	0
@@ -35,37 +30,37 @@ davinci_uart_virt:	.word	0
 		.macro addruart, rp, rv, tmp
 
 		/* Use davinci_uart_phys/virt if already configured */
-10:		mrc	p15, 0, \rp, c1, c0
-		tst	\rp, #1			@ MMU enabled?
-		ldreq	\rp, =davinci_uart_v2p(davinci_uart_phys)
-		ldrne	\rp, =davinci_uart_phys
-		add	\rv, \rp, #4		@ davinci_uart_virt
-		ldr	\rp, [\rp, #0]
-		ldr	\rv, [\rv, #0]
+10:		adr	\rp, 11f		@ get effective addr of 11f
+		ldr	\rv, [\rp]		@ get absolute addr of 11f
+		sub	\rv, \rv, \rp		@ offset between the two
+		ldr	\rp, [\rp, #4]		@ abs addr of omap_uart_phys
+		sub	\tmp, \rp, \rv		@ make it effective
+		ldr	\rp, [\tmp, #0]		@ davinci_uart_phys
+		ldr	\rv, [\tmp, #4]		@ davinci_uart_virt
 		cmp	\rp, #0			@ is port configured?
 		cmpne	\rv, #0
 		bne	99f			@ already configured
 
 		/* Check the debug UART address set in uncompress.h */
-		mrc	p15, 0, \rp, c1, c0
-		tst	\rp, #1			@ MMU enabled?
-
 		and	\rp, pc, #0xff000000
 		ldr	\rv, =DAVINCI_UART_INFO_OFS
 		add	\rp, \rp, \rv
 
-		ldreq	\rv, =davinci_uart_v2p(davinci_uart_phys)
-		ldrne	\rv, =davinci_uart_phys
-
 		/* Copy uart phys address from decompressor uart info */
-		ldr	\tmp, [\rp, #0]
-		str	\tmp, [\rv, #0]
+		ldr	\rv, [\rp, #0]
+		str	\rv, [\tmp, #0]
 
 		/* Copy uart virt address from decompressor uart info */
-		ldr	\tmp, [\rp, #4]
-		str	\tmp, [\rv, #4]
+		ldr	\rv, [\rp, #4]
+		str	\rv, [\tmp, #4]
 
 		b	10b
+
+		.align
+11:		.word	.
+		.word	davinci_uart_phys
+		.ltorg
+
 99:
 		.endm
 
-- 
1.7.4
