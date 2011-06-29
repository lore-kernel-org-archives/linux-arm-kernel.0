From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Jun 2011 10:21:54 +0100
Subject: [PATCH 09/23] ARM: entry: rejig register allocation in exception
	entry handlers
In-Reply-To: <20110629091853.GK21898@n2100.arm.linux.org.uk>
References: <20110629091853.GK21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qbqy2-0002FI-Nf@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows us to avoid moving registers twice to work around the
clobbered registers when we add calls to trace_hardirqs_{on,off}.

Ensure that all SVC handlers return with SPSR in r5 for consistency.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/entry-armv.S |   75 ++++++++++++++++++++++-------------------
 1 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index fd42e66..353b639 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -45,7 +45,7 @@
 	.endm
 
 	.macro	pabt_helper
-	mov	r0, r2			@ pass address of aborted instruction.
+	mov	r0, r4			@ pass address of aborted instruction.
 #ifdef MULTI_PABORT
 	ldr	ip, .LCprocfns
 	mov	lr, pc
@@ -56,6 +56,8 @@
 	.endm
 
 	.macro	dabt_helper
+	mov	r2, r4
+	mov	r3, r5
 
 	@
 	@ Call the processor-specific abort handler:
@@ -157,26 +159,26 @@ ENDPROC(__und_invalid)
  SPFIX(	subeq	sp, sp, #4	)
 	stmia	sp, {r1 - r12}
 
-	ldmia	r0, {r1 - r3}
-	add	r5, sp, #S_SP - 4	@ here for interlock avoidance
-	mov	r4, #-1			@  ""  ""      ""       ""
-	add	r0, sp, #(S_FRAME_SIZE + \stack_hole - 4)
- SPFIX(	addeq	r0, r0, #4	)
-	str	r1, [sp, #-4]!		@ save the "real" r0 copied
+	ldmia	r0, {r3 - r5}
+	add	r7, sp, #S_SP - 4	@ here for interlock avoidance
+	mov	r6, #-1			@  ""  ""      ""       ""
+	add	r2, sp, #(S_FRAME_SIZE + \stack_hole - 4)
+ SPFIX(	addeq	r2, r2, #4	)
+	str	r3, [sp, #-4]!		@ save the "real" r0 copied
 					@ from the exception stack
 
-	mov	r1, lr
+	mov	r3, lr
 
 	@
 	@ We are now ready to fill in the remaining blanks on the stack:
 	@
-	@  r0 - sp_svc
-	@  r1 - lr_svc
-	@  r2 - lr_<exception>, already fixed up for correct return/restart
-	@  r3 - spsr_<exception>
-	@  r4 - orig_r0 (see pt_regs definition in ptrace.h)
+	@  r2 - sp_svc
+	@  r3 - lr_svc
+	@  r4 - lr_<exception>, already fixed up for correct return/restart
+	@  r5 - spsr_<exception>
+	@  r6 - orig_r0 (see pt_regs definition in ptrace.h)
 	@
-	stmia	r5, {r0 - r4}
+	stmia	r7, {r2 - r6}
 	.endm
 
 	.align	5
@@ -187,7 +189,7 @@ __dabt_svc:
 	@ get ready to re-enable interrupts if appropriate
 	@
 	mrs	r9, cpsr
-	tst	r3, #PSR_I_BIT
+	tst	r5, #PSR_I_BIT
 	biceq	r9, r9, #PSR_I_BIT
 
 	dabt_helper
@@ -208,8 +210,8 @@ __dabt_svc:
 	@
 	@ restore SPSR and restart the instruction
 	@
-	ldr	r2, [sp, #S_PSR]
-	svc_exit r2				@ return from exception
+	ldr	r5, [sp, #S_PSR]
+	svc_exit r5				@ return from exception
  UNWIND(.fnend		)
 ENDPROC(__dabt_svc)
 
@@ -232,13 +234,13 @@ __irq_svc:
 	tst	r0, #_TIF_NEED_RESCHED
 	blne	svc_preempt
 #endif
-	ldr	r4, [sp, #S_PSR]		@ irqs are already disabled
+	ldr	r5, [sp, #S_PSR]
 #ifdef CONFIG_TRACE_IRQFLAGS
 	@ The parent context IRQs must have been enabled to get here in
 	@ the first place, so there's no point checking the PSR I bit.
 	bl	trace_hardirqs_on
 #endif
-	svc_exit r4				@ return from exception
+	svc_exit r5				@ return from exception
  UNWIND(.fnend		)
 ENDPROC(__irq_svc)
 
@@ -273,15 +275,16 @@ __und_svc:
 	@  r0 - instruction
 	@
 #ifndef	CONFIG_THUMB2_KERNEL
-	ldr	r0, [r2, #-4]
+	ldr	r0, [r4, #-4]
 #else
-	ldrh	r0, [r2, #-2]			@ Thumb instruction at LR - 2
+	ldrh	r0, [r4, #-2]			@ Thumb instruction at LR - 2
 	and	r9, r0, #0xf800
 	cmp	r9, #0xe800			@ 32-bit instruction if xx >= 0
-	ldrhhs	r9, [r2]			@ bottom 16 bits
+	ldrhhs	r9, [r4]			@ bottom 16 bits
 	orrhs	r0, r9, r0, lsl #16
 #endif
 	adr	r9, BSYM(1f)
+	mov	r2, r4
 	bl	call_fpe
 
 	mov	r0, sp				@ struct pt_regs *regs
@@ -295,8 +298,8 @@ __und_svc:
 	@
 	@ restore SPSR and restart the instruction
 	@
-	ldr	r2, [sp, #S_PSR]		@ Get SVC cpsr
-	svc_exit r2				@ return from exception
+	ldr	r5, [sp, #S_PSR]		@ Get SVC cpsr
+	svc_exit r5				@ return from exception
  UNWIND(.fnend		)
 ENDPROC(__und_svc)
 
@@ -308,7 +311,7 @@ __pabt_svc:
 	@ re-enable interrupts if appropriate
 	@
 	mrs	r9, cpsr
-	tst	r3, #PSR_I_BIT
+	tst	r5, #PSR_I_BIT
 	biceq	r9, r9, #PSR_I_BIT
 
 	pabt_helper
@@ -325,8 +328,8 @@ __pabt_svc:
 	@
 	@ restore SPSR and restart the instruction
 	@
-	ldr	r2, [sp, #S_PSR]
-	svc_exit r2				@ return from exception
+	ldr	r5, [sp, #S_PSR]
+	svc_exit r5				@ return from exception
  UNWIND(.fnend		)
 ENDPROC(__pabt_svc)
 
@@ -357,23 +360,23 @@ ENDPROC(__pabt_svc)
  ARM(	stmib	sp, {r1 - r12}	)
  THUMB(	stmia	sp, {r0 - r12}	)
 
-	ldmia	r0, {r1 - r3}
+	ldmia	r0, {r3 - r5}
 	add	r0, sp, #S_PC		@ here for interlock avoidance
-	mov	r4, #-1			@  ""  ""     ""        ""
+	mov	r6, #-1			@  ""  ""     ""        ""
 
-	str	r1, [sp]		@ save the "real" r0 copied
+	str	r3, [sp]		@ save the "real" r0 copied
 					@ from the exception stack
 
 	@
 	@ We are now ready to fill in the remaining blanks on the stack:
 	@
-	@  r2 - lr_<exception>, already fixed up for correct return/restart
-	@  r3 - spsr_<exception>
-	@  r4 - orig_r0 (see pt_regs definition in ptrace.h)
+	@  r4 - lr_<exception>, already fixed up for correct return/restart
+	@  r5 - spsr_<exception>
+	@  r6 - orig_r0 (see pt_regs definition in ptrace.h)
 	@
 	@ Also, separately save sp_usr and lr_usr
 	@
-	stmia	r0, {r2 - r4}
+	stmia	r0, {r4 - r6}
  ARM(	stmdb	r0, {sp, lr}^			)
  THUMB(	store_user_sp_lr r0, r1, S_SP - S_PC	)
 
@@ -397,7 +400,7 @@ ENDPROC(__pabt_svc)
 	@ if it was interrupted in a critical region.  Here we
 	@ perform a quick test inline since it should be false
 	@ 99.9999% of the time.  The rest is done out of line.
-	cmp	r2, #TASK_SIZE
+	cmp	r4, #TASK_SIZE
 	blhs	kuser_cmpxchg_fixup
 #endif
 #endif
@@ -441,6 +444,8 @@ ENDPROC(__irq_usr)
 	.align	5
 __und_usr:
 	usr_entry
+	mov	r2, r4
+	mov	r3, r5
 
 	@
 	@ fall through to the emulation code, which returns using r9 if
-- 
1.7.4.4
