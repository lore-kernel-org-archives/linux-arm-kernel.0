From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:23:55 +0100
Subject: [PATCH 15/23] ARM: entry: re-allocate registers in irq entry
	assembly macros
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbqzz-0002Fz-Is@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This avoids the irq entry assembly corrupting r5, thereby allowing it
to be preserved through to the svc exit code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/entry-macro-multi.S |   14 +++++++-------
 arch/arm/kernel/entry-armv.S             |   10 +++++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/entry-macro-multi.S b/arch/arm/include/asm/entry-macro-multi.S
index 2da8547..2f1e209 100644
--- a/arch/arm/include/asm/entry-macro-multi.S
+++ b/arch/arm/include/asm/entry-macro-multi.S
@@ -4,8 +4,8 @@
  * Interrupt handling.  Preserves r7, r8, r9
  */
 	.macro	arch_irq_handler_default
-	get_irqnr_preamble r5, lr
-1:	get_irqnr_and_base r0, r6, r5, lr
+	get_irqnr_preamble r6, lr
+1:	get_irqnr_and_base r0, r2, r6, lr
 	movne	r1, sp
 	@
 	@ routine called with r0 = irq number, r1 = struct pt_regs *
@@ -17,17 +17,17 @@
 	/*
 	 * XXX
 	 *
-	 * this macro assumes that irqstat (r6) and base (r5) are
+	 * this macro assumes that irqstat (r2) and base (r6) are
 	 * preserved from get_irqnr_and_base above
 	 */
-	ALT_SMP(test_for_ipi r0, r6, r5, lr)
+	ALT_SMP(test_for_ipi r0, r2, r6, lr)
 	ALT_UP_B(9997f)
 	movne	r1, sp
 	adrne	lr, BSYM(1b)
 	bne	do_IPI
 
 #ifdef CONFIG_LOCAL_TIMERS
-	test_for_ltirq r0, r6, r5, lr
+	test_for_ltirq r0, r2, r6, lr
 	movne	r0, sp
 	adrne	lr, BSYM(1b)
 	bne	do_local_timer
@@ -40,7 +40,7 @@
 	.align	5
 	.global \symbol_name
 \symbol_name:
-	mov	r4, lr
+	mov	r8, lr
 	arch_irq_handler_default
-	mov     pc, r4
+	mov     pc, r8
 	.endm
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 1da985f..b7c4792 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -29,16 +29,16 @@
 #include <asm/entry-macro-multi.S>
 
 /*
- * Interrupt handling.  Preserves r7, r8, r9
+ * Interrupt handling.
  */
 	.macro	irq_handler
 #ifdef CONFIG_MULTI_IRQ_HANDLER
-	ldr	r5, =handle_arch_irq
+	ldr	r1, =handle_arch_irq
 	mov	r0, sp
-	ldr	r5, [r5]
+	ldr	r1, [r1]
 	adr	lr, BSYM(9997f)
-	teq	r5, #0
-	movne	pc, r5
+	teq	r1, #0
+	movne	pc, r1
 #endif
 	arch_irq_handler_default
 9997:
-- 
1.7.4.4
