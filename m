From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 12 Nov 2010 17:21:51 +0900
Subject: [PATCH 05/07] ARM: Use shared GIC entry macros on UX500
In-Reply-To: <20101112082059.27221.52879.sendpatchset@t400s>
References: <20101112082059.27221.52879.sendpatchset@t400s>
Message-ID: <20101112082151.27221.45383.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Use the GIC demux code in asm/hardware/entry-macro-gic.S
on the UX500 subarchitecture.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-ux500/include/mach/entry-macro.S |   67 ------------------------
 1 file changed, 1 insertion(+), 66 deletions(-)

--- 0001/arch/arm/mach-ux500/include/mach/entry-macro.S
+++ work/arch/arm/mach-ux500/include/mach/entry-macro.S	2010-11-12 16:02:32.000000000 +0900
@@ -11,7 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 #include <mach/hardware.h>
-#include <asm/hardware/gic.h>
+#include <asm/hardware/entry-macro-gic.S>
 
 		.macro	disable_fiq
 		.endm
@@ -22,68 +22,3 @@
 
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
-
-		/*
-		 * The interrupt numbering scheme is defined in the
-		 * interrupt controller spec.  To wit:
-		 *
-		 * Interrupts 0-15 are IPI
-		 * 16-28 are reserved
-		 * 29-31 are local.  We allow 30 to be used for the watchdog.
-		 * 32-1020 are global
-		 * 1021-1022 are reserved
-		 * 1023 is "spurious" (no interrupt)
-		 *
-		 * For now, we ignore all local interrupts so only return an
-		 * interrupt if it's between 30 and 1020. The test_for_ipi
-		 * routine below will pick up on IPIs.
-		 *
-		 * A simple read from the controller will tell us the number
-		 * of the highest priority enabled interrupt. We then just
-		 * need to check whether it is in the valid range for an
-		 * IRQ (30-1020 inclusive).
-		 */
-
-		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-		/* bits 12-10 = src CPU, 9-0 = int # */
-		ldr     \irqstat, [\base, #GIC_CPU_INTACK]
-
-		ldr	\tmp, =1021
-
-		bic     \irqnr, \irqstat, #0x1c00
-
-		cmp     \irqnr, #29
-		cmpcc	\irqnr, \irqnr
-		cmpne	\irqnr, \tmp
-		cmpcs	\irqnr, \irqnr
-
-		.endm
-
-		/* We assume that irqstat (the raw value of the IRQ
-		 * acknowledge register) is preserved from the macro above.
-		 * If there is an IPI, we immediately signal end of
-		 * interrupt on the controller, since this requires the
-		 * original irqstat value which we won't easily be able
-		 * to recreate later.
-		 */
-
-		.macro test_for_ipi, irqnr, irqstat, base, tmp
-		bic	\irqnr, \irqstat, #0x1c00
-		cmp	\irqnr, #16
-		strcc	\irqstat, [\base, #GIC_CPU_EOI]
-		cmpcs	\irqnr, \irqnr
-		.endm
-
-		/* As above, this assumes that irqstat and base
-		 * are preserved..
-		 */
-
-		.macro test_for_ltirq, irqnr, irqstat, base, tmp
-		bic	\irqnr, \irqstat, #0x1c00
-		mov 	\tmp, #0
-		cmp	\irqnr, #29
-		moveq	\tmp, #1
-		streq	\irqstat, [\base, #GIC_CPU_EOI]
-		cmp	\tmp, #0
-		.endm
