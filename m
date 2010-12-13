From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 13 Dec 2010 21:21:31 +0900
Subject: [PATCH] ARM: Subarch IRQ handler macros V2
Message-ID: <20101213122131.17831.79005.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Per subarch interrupt handler macros V2.

This patch breaks out code from the irq_handler macro
into arch_irq_handler and arch_irq_handler_default.

The macros are put in the header file "entry-macro-multi.S"

The arch_irq_handler_default macro is designed to be
used by irq_handler in entry-armv.S while arch_irq_handler
is suitable for per-subarch use.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - Dropped the RFC tag and the example code
 - Rebased on top of latest
   "[PATCH] ARM: Allow machine to specify it's own IRQ handlers at run-time"
 - Moved the "#include <asm/entry-macro-multi.S>" to fix SMP compile
 - Tested the code on SH-Mobile ARM
 - Added return address saving to arch_irq_handler, r4 seems ok

 Have a look at the V1 posted as RFC for example code:
 "[PATCH 00/02][RFC] ARM: Subarch IRQ handler macro support"

 Please test and let me know if keeping the return address in r4 is wrong.

 arch/arm/include/asm/entry-macro-multi.S |   44 ++++++++++++++++++++++++++++++
 arch/arm/kernel/entry-armv.S             |   31 +--------------------
 2 files changed, 46 insertions(+), 29 deletions(-)

--- /dev/null
+++ work/arch/arm/include/asm/entry-macro-multi.S	2010-12-13 21:09:39.000000000 +0900
@@ -0,0 +1,44 @@
+/*
+ * Interrupt handling.  Preserves r7, r8, r9
+ */
+	.macro	arch_irq_handler_default
+	get_irqnr_preamble r5, lr
+1:	get_irqnr_and_base r0, r6, r5, lr
+	movne	r1, sp
+	@
+	@ routine called with r0 = irq number, r1 = struct pt_regs *
+	@
+	adrne	lr, BSYM(1b)
+	bne	asm_do_IRQ
+
+#ifdef CONFIG_SMP
+	/*
+	 * XXX
+	 *
+	 * this macro assumes that irqstat (r6) and base (r5) are
+	 * preserved from get_irqnr_and_base above
+	 */
+	ALT_SMP(test_for_ipi r0, r6, r5, lr)
+	ALT_UP_B(9998f)
+	movne	r1, sp
+	adrne	lr, BSYM(1b)
+	bne	do_IPI
+
+#ifdef CONFIG_LOCAL_TIMERS
+	test_for_ltirq r0, r6, r5, lr
+	movne	r0, sp
+	adrne	lr, BSYM(1b)
+	bne	do_local_timer
+#endif
+9998:
+#endif
+	.endm
+
+	.macro	arch_irq_handler, symbol_name
+	.align	5
+	.global \symbol_name
+\symbol_name:
+	mov	r4, lr
+	arch_irq_handler_default
+	mov     pc, r4
+	.endm
--- 0020/arch/arm/kernel/entry-armv.S
+++ work/arch/arm/kernel/entry-armv.S	2010-12-13 19:39:26.000000000 +0900
@@ -26,6 +26,7 @@
 
 #include "entry-header.S"
 
+#include <asm/entry-macro-multi.S>
 /*
  * Interrupt handling.  Preserves r7, r8, r9
  */
@@ -38,35 +39,7 @@
 	teq	r5, #0
 	movne	pc, r5
 #endif
-	get_irqnr_preamble r5, lr
-1:	get_irqnr_and_base r0, r6, r5, lr
-	movne	r1, sp
-	@
-	@ routine called with r0 = irq number, r1 = struct pt_regs *
-	@
-	adrne	lr, BSYM(1b)
-	bne	asm_do_IRQ
-
-#ifdef CONFIG_SMP
-	/*
-	 * XXX
-	 *
-	 * this macro assumes that irqstat (r6) and base (r5) are
-	 * preserved from get_irqnr_and_base above
-	 */
-	ALT_SMP(test_for_ipi r0, r6, r5, lr)
-	ALT_UP_B(9997f)
-	movne	r1, sp
-	adrne	lr, BSYM(1b)
-	bne	do_IPI
-
-#ifdef CONFIG_LOCAL_TIMERS
-	test_for_ltirq r0, r6, r5, lr
-	movne	r0, sp
-	adrne	lr, BSYM(1b)
-	bne	do_local_timer
-#endif
-#endif
+	arch_irq_handler_default
 9997:
 	.endm
 
