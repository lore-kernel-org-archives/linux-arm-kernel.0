From: srinidhi.kasagar@stericsson.com (srinidhi)
Date: Thu, 29 Jul 2010 18:26:04 +0530
Subject: [PATCH 1/2] ARM: make a common low level IRQ helper macros for GIC
	based platforms
Message-ID: <1280408164.14531.13.camel@bnru03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ helper macros for GIC based platforms are similar.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/include/asm/entry-macro-gic.S            |   74 ++++++++++++++++++++
 arch/arm/mach-cns3xxx/include/mach/entry-macro.S  |   73 +-------------------
 arch/arm/mach-omap2/include/mach/entry-macro.S    |   67 +-----------------
 arch/arm/mach-realview/include/mach/entry-macro.S |   72 +-------------------
 arch/arm/mach-ux500/include/mach/entry-macro.S    |   77 +--------------------
 arch/arm/mach-vexpress/include/mach/entry-macro.S |   68 +------------------
 6 files changed, 81 insertions(+), 350 deletions(-)
 create mode 100644 arch/arm/include/asm/entry-macro-gic.S

diff --git a/arch/arm/include/asm/entry-macro-gic.S b/arch/arm/include/asm/entry-macro-gic.S
new file mode 100644
index 0000000..85269ca
--- /dev/null
+++ b/arch/arm/include/asm/entry-macro-gic.S
@@ -0,0 +1,74 @@
+/*
+ * Low-level IRQ helper macros for GIC based platforms
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <asm/hardware/gic.h>
+
+	.macro	disable_fiq
+	.endm
+
+	.macro  get_irqnr_preamble, base, tmp
+	ldr	\base, =gic_cpu_base_addr
+	ldr	\base, [\base]
+	.endm
+
+	.macro  arch_ret_to_user, tmp1, tmp2
+	.endm
+
+	/*
+	 * The interrupt numbering scheme is defined in the
+	 * interrupt controller spec.  To wit:
+	 *
+	 * Interrupts 0-15 are IPI
+	 * 16-28 are reserved
+	 * 29-31 are local.  We allow 30 to be used for the watchdog.
+	 * 32-1020 are global
+	 * 1021-1022 are reserved
+	 * 1023 is "spurious" (no interrupt)
+	 *
+	 * For now, we ignore all local interrupts so only return an interrupt if it's
+	 * between 30 and 1020.  The test_for_ipi routine below will pick up on IPIs.
+	 *
+	 * A simple read from the controller will tell us the number of the highest
+	 * priority enabled interrupt.  We then just need to check whether it is in the
+	 * valid range for an IRQ (30-1020 inclusive).
+	 */
+
+	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
+	ldr     \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 = src CPU, 9-0 = int # */
+	ldr	\tmp, =1021
+	bic     \irqnr, \irqstat, #0x1c00
+	cmp     \irqnr, #29
+	cmpcc	\irqnr, \irqnr
+	cmpne	\irqnr, \tmp
+	cmpcs	\irqnr, \irqnr
+	.endm
+
+	/*
+	 * We assume that irqstat (the raw value of the IRQ acknowledge
+	 * register) is preserved from the macro above.
+	 * If there is an IPI, we immediately signal end of interrupt on the
+	 * controller, since this requires the original irqstat value which
+	 * we won't easily be able to recreate later.
+	 */
+
+	.macro test_for_ipi, irqnr, irqstat, base, tmp
+	bic	\irqnr, \irqstat, #0x1c00
+	cmp	\irqnr, #16
+	strcc	\irqstat, [\base, #GIC_CPU_EOI]
+	cmpcs	\irqnr, \irqnr
+	.endm
+
+	/* As above, this assumes that irqstat and base are preserved.. */
+
+	.macro test_for_ltirq, irqnr, irqstat, base, tmp
+	bic	\irqnr, \irqstat, #0x1c00
+	mov 	\tmp, #0
+	cmp	\irqnr, #29
+	moveq	\tmp, #1
+	streq	\irqstat, [\base, #GIC_CPU_EOI]
+	cmp	\tmp, #0
+	.endm
diff --git a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S b/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
index 5e1c554..18f8cf8 100644
--- a/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
+++ b/arch/arm/mach-cns3xxx/include/mach/entry-macro.S
@@ -8,75 +8,4 @@
  * published by the Free Software Foundation.
  */
 
-#include <mach/hardware.h>
-#include <asm/hardware/gic.h>
-
-		.macro	disable_fiq
-		.endm
-
-		.macro  get_irqnr_preamble, base, tmp
-		ldr	\base, =gic_cpu_base_addr
-		ldr	\base, [\base]
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
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
-		 * For now, we ignore all local interrupts so only return an interrupt if it's
-		 * between 30 and 1020.  The test_for_ipi routine below will pick up on IPIs.
-		 *
-		 * A simple read from the controller will tell us the number of the highest
-                 * priority enabled interrupt.  We then just need to check whether it is in the
-		 * valid range for an IRQ (30-1020 inclusive).
-		 */
-
-		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-		ldr     \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 = src CPU, 9-0 = int # */
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
-		/* We assume that irqstat (the raw value of the IRQ acknowledge
-		 * register) is preserved from the macro above.
-		 * If there is an IPI, we immediately signal end of interrupt on the
-		 * controller, since this requires the original irqstat value which
-		 * we won't easily be able to recreate later.
-		 */
-
-		.macro test_for_ipi, irqnr, irqstat, base, tmp
-		bic	\irqnr, \irqstat, #0x1c00
-		cmp	\irqnr, #16
-		strcc	\irqstat, [\base, #GIC_CPU_EOI]
-		cmpcs	\irqnr, \irqnr
-		.endm
-
-		/* As above, this assumes that irqstat and base are preserved.. */
-
-		.macro test_for_ltirq, irqnr, irqstat, base, tmp
-		bic	\irqnr, \irqstat, #0x1c00
-		mov 	\tmp, #0
-		cmp	\irqnr, #29
-		moveq	\tmp, #1
-		streq	\irqstat, [\base, #GIC_CPU_EOI]
-		cmp	\tmp, #0
-		.endm
+#include <asm/entry-macro-gic.S>
diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index 50fd749..62f2d1a 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -27,11 +27,13 @@
 #define INTCPS_SIR_IRQ_OFFSET	0x0040	/* omap2/3 active interrupt offset */
 #define	ACTIVEIRQ_MASK		0x7f	/* omap2/3 active interrupt bits */
 
+#if defined(CONFIG_ARCH_OMAP4) && !defined(CONFIG_SMP)
 		.macro	disable_fiq
 		.endm
 
 		.macro  arch_ret_to_user, tmp1, tmp2
 		.endm
+#endif
 
 /*
  * Unoptimized irq functions for multi-omap2, 3 and 4
@@ -141,70 +143,7 @@ omap_irq_base:	.word	0
 
 
 #ifdef CONFIG_ARCH_OMAP4
-
-		.macro  get_irqnr_preamble, base, tmp
-		ldr     \base, =OMAP4_IRQ_BASE
-		.endm
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
-
-		/* We assume that irqstat (the raw value of the IRQ acknowledge
-		 * register) is preserved from the macro above.
-		 * If there is an IPI, we immediately signal end of interrupt
-		 * on the controller, since this requires the original irqstat
-		 * value which we won't easily be able to recreate later.
-		 */
-
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
+#include <asm/entry-macro-gic.S>
 #endif
 #endif	/* MULTI_OMAP2 */
 
diff --git a/arch/arm/mach-realview/include/mach/entry-macro.S b/arch/arm/mach-realview/include/mach/entry-macro.S
index 340a5c2..e6cc5d5 100644
--- a/arch/arm/mach-realview/include/mach/entry-macro.S
+++ b/arch/arm/mach-realview/include/mach/entry-macro.S
@@ -7,75 +7,5 @@
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-#include <mach/hardware.h>
-#include <asm/hardware/gic.h>
 
-		.macro	disable_fiq
-		.endm
-
-		.macro  get_irqnr_preamble, base, tmp
-		ldr	\base, =gic_cpu_base_addr
-		ldr	\base, [\base]
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
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
-		 * For now, we ignore all local interrupts so only return an interrupt if it's
-		 * between 30 and 1020.  The test_for_ipi routine below will pick up on IPIs.
-		 *
-		 * A simple read from the controller will tell us the number of the highest
-                 * priority enabled interrupt.  We then just need to check whether it is in the
-		 * valid range for an IRQ (30-1020 inclusive).
-		 */
-
-		.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-		ldr     \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 = src CPU, 9-0 = int # */
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
-		/* We assume that irqstat (the raw value of the IRQ acknowledge
-		 * register) is preserved from the macro above.
-		 * If there is an IPI, we immediately signal end of interrupt on the
-		 * controller, since this requires the original irqstat value which
-		 * we won't easily be able to recreate later.
-		 */
-
-		.macro test_for_ipi, irqnr, irqstat, base, tmp
-		bic	\irqnr, \irqstat, #0x1c00
-		cmp	\irqnr, #16
-		strcc	\irqstat, [\base, #GIC_CPU_EOI]
-		cmpcs	\irqnr, \irqnr
-		.endm
-
-		/* As above, this assumes that irqstat and base are preserved.. */
-
-		.macro test_for_ltirq, irqnr, irqstat, base, tmp
-		bic	\irqnr, \irqstat, #0x1c00
-		mov 	\tmp, #0
-		cmp	\irqnr, #29
-		moveq	\tmp, #1
-		streq	\irqstat, [\base, #GIC_CPU_EOI]
-		cmp	\tmp, #0
-		.endm
+#include <asm/entry-macro-gic.S>
diff --git a/arch/arm/mach-ux500/include/mach/entry-macro.S b/arch/arm/mach-ux500/include/mach/entry-macro.S
index 60ea88d..b778124 100644
--- a/arch/arm/mach-ux500/include/mach/entry-macro.S
+++ b/arch/arm/mach-ux500/include/mach/entry-macro.S
@@ -10,80 +10,5 @@
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
  */
-#include <mach/hardware.h>
-#include <asm/hardware/gic.h>
 
-		.macro	disable_fiq
-		.endm
-
-		.macro  get_irqnr_preamble, base, tmp
-		ldr     \base, =IO_ADDRESS(UX500_GIC_CPU_BASE)
-		.endm
-
-		.macro  arch_ret_to_user, tmp1, tmp2
-		.endm
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
+#include <asm/entry-macro-gic.S>
diff --git a/arch/arm/mach-vexpress/include/mach/entry-macro.S b/arch/arm/mach-vexpress/include/mach/entry-macro.S
index 20e9fb5..789895e 100644
--- a/arch/arm/mach-vexpress/include/mach/entry-macro.S
+++ b/arch/arm/mach-vexpress/include/mach/entry-macro.S
@@ -1,67 +1 @@
-#include <asm/hardware/gic.h>
-
-	.macro	disable_fiq
-	.endm
-
-	.macro	get_irqnr_preamble, base, tmp
-	ldr	\base, =gic_cpu_base_addr
-	ldr	\base, [\base]
-	.endm
-
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
-	/*
-	 * The interrupt numbering scheme is defined in the
-	 * interrupt controller spec.  To wit:
-	 *
-	 * Interrupts 0-15 are IPI
-	 * 16-28 are reserved
-	 * 29-31 are local.  We allow 30 to be used for the watchdog.
-	 * 32-1020 are global
-	 * 1021-1022 are reserved
-	 * 1023 is "spurious" (no interrupt)
-	 *
-	 * For now, we ignore all local interrupts so only return an interrupt if it's
-	 * between 30 and 1020.  The test_for_ipi routine below will pick up on IPIs.
-	 *
-	 * A simple read from the controller will tell us the number of the highest
-	 * priority enabled interrupt.  We then just need to check whether it is in the
-	 * valid range for an IRQ (30-1020 inclusive).
-	 */
-
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-	ldr     \irqstat, [\base, #GIC_CPU_INTACK] /* bits 12-10 = src CPU, 9-0 = int # */
-	ldr	\tmp, =1021
-	bic     \irqnr, \irqstat, #0x1c00
-	cmp     \irqnr, #29
-	cmpcc	\irqnr, \irqnr
-	cmpne	\irqnr, \tmp
-	cmpcs	\irqnr, \irqnr
-	.endm
-
-	/* We assume that irqstat (the raw value of the IRQ acknowledge
-	 * register) is preserved from the macro above.
-	 * If there is an IPI, we immediately signal end of interrupt on the
-	 * controller, since this requires the original irqstat value which
-	 * we won't easily be able to recreate later.
-	 */
-
-	.macro test_for_ipi, irqnr, irqstat, base, tmp
-	bic	\irqnr, \irqstat, #0x1c00
-	cmp	\irqnr, #16
-	strcc	\irqstat, [\base, #GIC_CPU_EOI]
-	cmpcs	\irqnr, \irqnr
-	.endm
-
-	/* As above, this assumes that irqstat and base are preserved.. */
-
-	.macro test_for_ltirq, irqnr, irqstat, base, tmp
-	bic	\irqnr, \irqstat, #0x1c00
-	mov 	\tmp, #0
-	cmp	\irqnr, #29
-	moveq	\tmp, #1
-	streq	\irqstat, [\base, #GIC_CPU_EOI]
-	cmp	\tmp, #0
-	.endm
-
+#include <asm/entry-macro-gic.S>
-- 
1.6.3.3
