From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 10 Dec 2010 14:58:44 +0900
Subject: [PATCH 01/02][RFC] ARM: Introduce Subarch IRQ handler macros
In-Reply-To: <20101210055835.8635.98614.sendpatchset@t400s>
References: <20101210055835.8635.98614.sendpatchset@t400s>
Message-ID: <20101210055844.8635.36194.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Break out code from the irq_handler macro into the two
macros arch_irq_handler and arch_irq_handler_default.

Put the macros in the header file "entry-macro-multi.S"

The macro arch_irq_handler_default is designed to be
used by the irq_handler macro in entry-armv.S while
arch_irq_handler is suitable for per-subarch use.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/include/asm/entry-macro-multi.S |   43 ++++++++++++++++++++++++++++++
 arch/arm/kernel/entry-armv.S             |   31 +--------------------
 2 files changed, 45 insertions(+), 29 deletions(-)

--- /dev/null
+++ work/arch/arm/include/asm/entry-macro-multi.S	2010-12-09 23:07:01.000000000 +0900
@@ -0,0 +1,43 @@
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
+	arch_irq_handler_default
+	mov     pc, lr
+	.endm
--- 0002/arch/arm/kernel/entry-armv.S
+++ work/arch/arm/kernel/entry-armv.S	2010-12-09 23:07:13.000000000 +0900
@@ -19,6 +19,7 @@
 #include <asm/glue.h>
 #include <asm/vfpmacros.h>
 #include <mach/entry-macro.S>
+#include <asm/entry-macro-multi.S>
 #include <asm/thread_notify.h>
 #include <asm/unwind.h>
 #include <asm/unistd.h>
@@ -38,35 +39,7 @@
 	adrne	lr, BSYM(9997f)
 	ldrne	pc, [r1]
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
 
