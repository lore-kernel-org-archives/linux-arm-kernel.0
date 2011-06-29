From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:19:54 +0100
Subject: [PATCH 03/23] ARM: entry: prefetch/data abort helpers: convert to
	macros
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbqw6-0002Es-3W@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S |   85 +++++++++++++++++------------------------
 1 files changed, 35 insertions(+), 50 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 90c62cd..dbe9eb8 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -44,6 +44,37 @@
 9997:
 	.endm
 
+	.macro	pabt_helper
+	mov	r0, r2			@ pass address of aborted instruction.
+#ifdef MULTI_PABORT
+	ldr	r4, .LCprocfns
+	mov	lr, pc
+	ldr	pc, [r4, #PROCESSOR_PABT_FUNC]
+#else
+	bl	CPU_PABORT_HANDLER
+#endif
+	.endm
+
+	.macro	dabt_helper
+
+	@
+	@ Call the processor-specific abort handler:
+	@
+	@  r2 - aborted context pc
+	@  r3 - aborted context cpsr
+	@
+	@ The abort handler must return the aborted address in r0, and
+	@ the fault status register in r1.  r9 must be preserved.
+	@
+#ifdef MULTI_DABORT
+	ldr	r4, .LCprocfns
+	mov	lr, pc
+	ldr	pc, [r4, #PROCESSOR_DABT_FUNC]
+#else
+	bl	CPU_DABORT_HANDLER
+#endif
+	.endm
+
 #ifdef CONFIG_KPROBES
 	.section	.kprobes.text,"ax",%progbits
 #else
@@ -159,22 +190,7 @@ __dabt_svc:
 	tst	r3, #PSR_I_BIT
 	biceq	r9, r9, #PSR_I_BIT
 
-	@
-	@ Call the processor-specific abort handler:
-	@
-	@  r2 - aborted context pc
-	@  r3 - aborted context cpsr
-	@
-	@ The abort handler must return the aborted address in r0, and
-	@ the fault status register in r1.  r9 must be preserved.
-	@
-#ifdef MULTI_DABORT
-	ldr	r4, .LCprocfns
-	mov	lr, pc
-	ldr	pc, [r4, #PROCESSOR_DABT_FUNC]
-#else
-	bl	CPU_DABORT_HANDLER
-#endif
+	dabt_helper
 
 	@
 	@ set desired IRQ state, then call main handler
@@ -298,14 +314,7 @@ __pabt_svc:
 	tst	r3, #PSR_I_BIT
 	biceq	r9, r9, #PSR_I_BIT
 
-	mov	r0, r2			@ pass address of aborted instruction.
-#ifdef MULTI_PABORT
-	ldr	r4, .LCprocfns
-	mov	lr, pc
-	ldr	pc, [r4, #PROCESSOR_PABT_FUNC]
-#else
-	bl	CPU_PABORT_HANDLER
-#endif
+	pabt_helper
 	debug_entry r1
 	msr	cpsr_c, r9			@ Maybe enable interrupts
 	mov	r2, sp				@ regs
@@ -401,23 +410,7 @@ ENDPROC(__pabt_svc)
 __dabt_usr:
 	usr_entry
 	kuser_cmpxchg_check
-
-	@
-	@ Call the processor-specific abort handler:
-	@
-	@  r2 - aborted context pc
-	@  r3 - aborted context cpsr
-	@
-	@ The abort handler must return the aborted address in r0, and
-	@ the fault status register in r1.
-	@
-#ifdef MULTI_DABORT
-	ldr	r4, .LCprocfns
-	mov	lr, pc
-	ldr	pc, [r4, #PROCESSOR_DABT_FUNC]
-#else
-	bl	CPU_DABORT_HANDLER
-#endif
+	dabt_helper
 
 	@
 	@ IRQs on, then call the main handler
@@ -682,15 +675,7 @@ ENDPROC(__und_usr_unknown)
 	.align	5
 __pabt_usr:
 	usr_entry
-
-	mov	r0, r2			@ pass address of aborted instruction.
-#ifdef MULTI_PABORT
-	ldr	r4, .LCprocfns
-	mov	lr, pc
-	ldr	pc, [r4, #PROCESSOR_PABT_FUNC]
-#else
-	bl	CPU_PABORT_HANDLER
-#endif
+	pabt_helper
 	debug_entry r1
 	enable_irq				@ Enable interrupts
 	mov	r2, sp				@ regs
-- 
1.7.4.4
