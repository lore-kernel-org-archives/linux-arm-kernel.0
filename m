From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 06 Oct 2010 16:17:48 +0900
Subject: [PATCH 02/08] ARM: Move macros from entry-armv.S
In-Reply-To: <20101006071731.28048.89938.sendpatchset@t400s>
References: <20101006071731.28048.89938.sendpatchset@t400s>
Message-ID: <20101006071748.28048.15067.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Move macros from entry-armv.S to entry-header.S.
Preparation work for converting the __irq_svc
and __irq_usr to macros. No code is changed,
but a few comments are modified.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/include/asm/entry-header.S |  151 +++++++++++++++++++++++++++++++++++
 arch/arm/kernel/entry-armv.S        |  141 --------------------------------
 2 files changed, 151 insertions(+), 141 deletions(-)

--- 0005/arch/arm/include/asm/entry-header.S
+++ work/arch/arm/include/asm/entry-header.S	2010-10-05 20:09:54.000000000 +0900
@@ -179,3 +179,154 @@ scno	.req	r7		@ syscall number
 tbl	.req	r8		@ syscall table pointer
 why	.req	r8		@ Linux syscall (!= 0)
 tsk	.req	r9		@ current thread_info
+
+/*
+ * Interrupt handling.  Preserves r7, r8, r9
+ */
+	.macro	irq_handler
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
+	test_for_ipi r0, r6, r5, lr
+	movne	r0, sp
+	adrne	lr, BSYM(1b)
+	bne	do_IPI
+
+#ifdef CONFIG_LOCAL_TIMERS
+	test_for_ltirq r0, r6, r5, lr
+	movne	r0, sp
+	adrne	lr, BSYM(1b)
+	bne	do_local_timer
+#endif
+#endif
+
+	.endm
+
+#ifdef CONFIG_KPROBES
+	.section	.kprobes.text,"ax",%progbits
+#else
+	.text
+#endif
+
+/*
+ * SVC mode macros
+ */
+
+#if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5)
+#define SPFIX(code...) code
+#else
+#define SPFIX(code...)
+#endif
+
+	.macro	svc_entry, stack_hole=0
+ UNWIND(.fnstart		)
+ UNWIND(.save {r0 - pc}		)
+	sub	sp, sp, #(S_FRAME_SIZE + \stack_hole - 4)
+#ifdef CONFIG_THUMB2_KERNEL
+ SPFIX(	str	r0, [sp]	)	@ temporarily saved
+ SPFIX(	mov	r0, sp		)
+ SPFIX(	tst	r0, #4		)	@ test original stack alignment
+ SPFIX(	ldr	r0, [sp]	)	@ restored
+#else
+ SPFIX(	tst	sp, #4		)
+#endif
+ SPFIX(	subeq	sp, sp, #4	)
+	stmia	sp, {r1 - r12}
+
+	ldmia	r0, {r1 - r3}
+	add	r5, sp, #S_SP - 4	@ here for interlock avoidance
+	mov	r4, #-1			@  ""  ""      ""       ""
+	add	r0, sp, #(S_FRAME_SIZE + \stack_hole - 4)
+ SPFIX(	addeq	r0, r0, #4	)
+	str	r1, [sp, #-4]!		@ save the "real" r0 copied
+					@ from the exception stack
+
+	mov	r1, lr
+
+	@
+	@ We are now ready to fill in the remaining blanks on the stack:
+	@
+	@  r0 - sp_svc
+	@  r1 - lr_svc
+	@  r2 - lr_<exception>, already fixed up for correct return/restart
+	@  r3 - spsr_<exception>
+	@  r4 - orig_r0 (see pt_regs definition in ptrace.h)
+	@
+	stmia	r5, {r0 - r4}
+	.endm
+
+/*
+ * User mode macros
+ *
+ * EABI note: sp_svc is always 64-bit aligned here, so should S_FRAME_SIZE
+ */
+
+#if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5) && (S_FRAME_SIZE & 7)
+#error "sizeof(struct pt_regs) must be a multiple of 8"
+#endif
+
+	.macro	usr_entry
+ UNWIND(.fnstart	)
+ UNWIND(.cantunwind	)	@ don't unwind the user space
+	sub	sp, sp, #S_FRAME_SIZE
+ ARM(	stmib	sp, {r1 - r12}	)
+ THUMB(	stmia	sp, {r0 - r12}	)
+
+	ldmia	r0, {r1 - r3}
+	add	r0, sp, #S_PC		@ here for interlock avoidance
+	mov	r4, #-1			@  ""  ""     ""        ""
+
+	str	r1, [sp]		@ save the "real" r0 copied
+					@ from the exception stack
+
+	@
+	@ We are now ready to fill in the remaining blanks on the stack:
+	@
+	@  r2 - lr_<exception>, already fixed up for correct return/restart
+	@  r3 - spsr_<exception>
+	@  r4 - orig_r0 (see pt_regs definition in ptrace.h)
+	@
+	@ Also, separately save sp_usr and lr_usr
+	@
+	stmia	r0, {r2 - r4}
+ ARM(	stmdb	r0, {sp, lr}^			)
+ THUMB(	store_user_sp_lr r0, r1, S_SP - S_PC	)
+
+	@
+	@ Enable the alignment trap while in kernel mode
+	@
+	alignment_trap r0
+
+	@
+	@ Clear FP to mark the first stack frame
+	@
+	zero_fp
+	.endm
+
+	.macro	kuser_cmpxchg_check
+#if __LINUX_ARM_ARCH__ < 6 && !defined(CONFIG_NEEDS_SYSCALL_FOR_CMPXCHG)
+#ifndef CONFIG_MMU
+#warning "NPTL on non MMU needs fixing"
+#else
+	@ Make sure our user space atomic helper is restarted
+	@ if it was interrupted in a critical region.  Here we
+	@ perform a quick test inline since it should be false
+	@ 99.9999% of the time.  The rest is done out of line.
+	cmp	r2, #TASK_SIZE
+	blhs	kuser_cmpxchg_fixup
+#endif
+#endif
+	.endm
--- 0005/arch/arm/kernel/entry-armv.S
+++ work/arch/arm/kernel/entry-armv.S	2010-10-05 20:10:56.000000000 +0900
@@ -26,47 +26,6 @@
 #include <asm/entry-header.S>
 
 /*
- * Interrupt handling.  Preserves r7, r8, r9
- */
-	.macro	irq_handler
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
-	test_for_ipi r0, r6, r5, lr
-	movne	r0, sp
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
-
-	.endm
-
-#ifdef CONFIG_KPROBES
-	.section	.kprobes.text,"ax",%progbits
-#else
-	.text
-#endif
-
-/*
  * Invalid mode handlers
  */
 	.macro	inv_entry, reason
@@ -121,49 +80,6 @@ ENDPROC(__und_invalid)
  * SVC mode handlers
  */
 
-#if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5)
-#define SPFIX(code...) code
-#else
-#define SPFIX(code...)
-#endif
-
-	.macro	svc_entry, stack_hole=0
- UNWIND(.fnstart		)
- UNWIND(.save {r0 - pc}		)
-	sub	sp, sp, #(S_FRAME_SIZE + \stack_hole - 4)
-#ifdef CONFIG_THUMB2_KERNEL
- SPFIX(	str	r0, [sp]	)	@ temporarily saved
- SPFIX(	mov	r0, sp		)
- SPFIX(	tst	r0, #4		)	@ test original stack alignment
- SPFIX(	ldr	r0, [sp]	)	@ restored
-#else
- SPFIX(	tst	sp, #4		)
-#endif
- SPFIX(	subeq	sp, sp, #4	)
-	stmia	sp, {r1 - r12}
-
-	ldmia	r0, {r1 - r3}
-	add	r5, sp, #S_SP - 4	@ here for interlock avoidance
-	mov	r4, #-1			@  ""  ""      ""       ""
-	add	r0, sp, #(S_FRAME_SIZE + \stack_hole - 4)
- SPFIX(	addeq	r0, r0, #4	)
-	str	r1, [sp, #-4]!		@ save the "real" r0 copied
-					@ from the exception stack
-
-	mov	r1, lr
-
-	@
-	@ We are now ready to fill in the remaining blanks on the stack:
-	@
-	@  r0 - sp_svc
-	@  r1 - lr_svc
-	@  r2 - lr_<exception>, already fixed up for correct return/restart
-	@  r3 - spsr_<exception>
-	@  r4 - orig_r0 (see pt_regs definition in ptrace.h)
-	@
-	stmia	r5, {r0 - r4}
-	.endm
-
 	.align	5
 __dabt_svc:
 	svc_entry
@@ -354,63 +270,6 @@ ENDPROC(__pabt_svc)
  * EABI note: sp_svc is always 64-bit aligned here, so should S_FRAME_SIZE
  */
 
-#if defined(CONFIG_AEABI) && (__LINUX_ARM_ARCH__ >= 5) && (S_FRAME_SIZE & 7)
-#error "sizeof(struct pt_regs) must be a multiple of 8"
-#endif
-
-	.macro	usr_entry
- UNWIND(.fnstart	)
- UNWIND(.cantunwind	)	@ don't unwind the user space
-	sub	sp, sp, #S_FRAME_SIZE
- ARM(	stmib	sp, {r1 - r12}	)
- THUMB(	stmia	sp, {r0 - r12}	)
-
-	ldmia	r0, {r1 - r3}
-	add	r0, sp, #S_PC		@ here for interlock avoidance
-	mov	r4, #-1			@  ""  ""     ""        ""
-
-	str	r1, [sp]		@ save the "real" r0 copied
-					@ from the exception stack
-
-	@
-	@ We are now ready to fill in the remaining blanks on the stack:
-	@
-	@  r2 - lr_<exception>, already fixed up for correct return/restart
-	@  r3 - spsr_<exception>
-	@  r4 - orig_r0 (see pt_regs definition in ptrace.h)
-	@
-	@ Also, separately save sp_usr and lr_usr
-	@
-	stmia	r0, {r2 - r4}
- ARM(	stmdb	r0, {sp, lr}^			)
- THUMB(	store_user_sp_lr r0, r1, S_SP - S_PC	)
-
-	@
-	@ Enable the alignment trap while in kernel mode
-	@
-	alignment_trap r0
-
-	@
-	@ Clear FP to mark the first stack frame
-	@
-	zero_fp
-	.endm
-
-	.macro	kuser_cmpxchg_check
-#if __LINUX_ARM_ARCH__ < 6 && !defined(CONFIG_NEEDS_SYSCALL_FOR_CMPXCHG)
-#ifndef CONFIG_MMU
-#warning "NPTL on non MMU needs fixing"
-#else
-	@ Make sure our user space atomic helper is restarted
-	@ if it was interrupted in a critical region.  Here we
-	@ perform a quick test inline since it should be false
-	@ 99.9999% of the time.  The rest is done out of line.
-	cmp	r2, #TASK_SIZE
-	blhs	kuser_cmpxchg_fixup
-#endif
-#endif
-	.endm
-
 	.align	5
 __dabt_usr:
 	usr_entry
