From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Nov 2010 16:42:12 -0800
Subject: [PATCH] ARM: Common GIC entry macro code V2
In-Reply-To: <20101111074955.29633.80160.sendpatchset@t400s>
References: <20101111074955.29633.80160.sendpatchset@t400s>
Message-ID: <20101112004212.GZ9264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

* Magnus Damm <magnus.damm@gmail.com> [101110 23:37]:
> 
> The omap code is excluded due to complexity and lack of
> hardware - the CONFIG_SMP macros are used for multi-omap
> and the omap4 case - this makes is difficult to share code.

Hmm test_for_ipi and test_for_ltirq are needed for the
SMP_ON_UP case, so I've moved those in to the MULTI_OMAP2
section.

Maybe merge the following into your original patch?

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Thu, 11 Nov 2010 16:19:44 -0800
Subject: [PATCH] ARM: Common GIC entry macro for omap

Common GIC entry macro for omap

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index 06e64e1..2e358df 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -105,6 +105,35 @@ omap_irq_base:	.word	0
 9999:
 		.endm
 
+#ifdef CONFIG_SMP
+		/* We assume that irqstat (the raw value of the IRQ acknowledge
+		 * register) is preserved from the macro above.
+		 * If there is an IPI, we immediately signal end of interrupt
+		 * on the controller, since this requires the original irqstat
+		 * value which we won't easily be able to recreate later.
+		 */
+
+		.macro test_for_ipi, irqnr, irqstat, base, tmp
+		bic	\irqnr, \irqstat, #0x1c00
+		cmp	\irqnr, #16
+		it	cc
+		strcc	\irqstat, [\base, #GIC_CPU_EOI]
+		it	cs
+		cmpcs	\irqnr, \irqnr
+		.endm
+
+		/* As above, this assumes that irqstat and base are preserved */
+
+		.macro test_for_ltirq, irqnr, irqstat, base, tmp
+		bic	\irqnr, \irqstat, #0x1c00
+		mov 	\tmp, #0
+		cmp	\irqnr, #29
+		itt	eq
+		moveq	\tmp, #1
+		streq	\irqstat, [\base, #GIC_CPU_EOI]
+		cmp	\tmp, #0
+		.endm
+#endif	/* CONFIG_SMP */
 
 #else	/* MULTI_OMAP2 */
 
@@ -141,74 +170,15 @@ omap_irq_base:	.word	0
 
 
 #ifdef CONFIG_ARCH_OMAP4
+#include <asm/hardware/entry-macro-gic.S>
 
 		.macro  get_irqnr_preamble, base, tmp
 		ldr     \base, =OMAP4_IRQ_BASE
 		.endm
 
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
-		 * interrupt if it's between 30 and 1020.  The test_for_ipi
-		 * routine below will pick up on IPIs.
-		 * A simple read from the controller will tell us the number
-		 * of the highest priority enabled interrupt.
-		 * We then just need to check whether it is in the
-		 * valid range for an IRQ (30-1020 inclusive).
-		 */
-		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr     \irqstat, [\base, #GIC_CPU_INTACK]
-
-		ldr     \tmp, =1021
-
-		bic     \irqnr, \irqstat, #0x1c00
-
-		cmp     \irqnr, #29
-		cmpcc   \irqnr, \irqnr
-		cmpne   \irqnr, \tmp
-		cmpcs   \irqnr, \irqnr
-		.endm
 #endif
-#endif	/* MULTI_OMAP2 */
-
-#ifdef CONFIG_SMP
-		/* We assume that irqstat (the raw value of the IRQ acknowledge
-		 * register) is preserved from the macro above.
-		 * If there is an IPI, we immediately signal end of interrupt
-		 * on the controller, since this requires the original irqstat
-		 * value which we won't easily be able to recreate later.
-		 */
 
-		.macro test_for_ipi, irqnr, irqstat, base, tmp
-		bic	\irqnr, \irqstat, #0x1c00
-		cmp	\irqnr, #16
-		it	cc
-		strcc	\irqstat, [\base, #GIC_CPU_EOI]
-		it	cs
-		cmpcs	\irqnr, \irqnr
-		.endm
-
-		/* As above, this assumes that irqstat and base are preserved */
-
-		.macro test_for_ltirq, irqnr, irqstat, base, tmp
-		bic	\irqnr, \irqstat, #0x1c00
-		mov 	\tmp, #0
-		cmp	\irqnr, #29
-		itt	eq
-		moveq	\tmp, #1
-		streq	\irqstat, [\base, #GIC_CPU_EOI]
-		cmp	\tmp, #0
-		.endm
-#endif	/* CONFIG_SMP */
+#endif	/* MULTI_OMAP2 */
 
 		.macro	irq_prio_table
 		.endm
