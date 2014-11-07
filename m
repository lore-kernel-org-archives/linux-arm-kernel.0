From: will.deacon@arm.com (Will Deacon)
Date: Fri,  7 Nov 2014 13:32:21 +0000
Subject: [PATCH 1/2] arm64: entry: avoid writing lr explicitly for
 constructing return paths
Message-ID: <1415367142-5005-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using an explicit adr instruction to set the link register to point at
ret_fast_syscall/ret_to_user can defeat branch and return stack predictors.

Instead, use the standard calling instructions (bl, blr) and have an
unconditional branch as the following instruction.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 726b910fe6ec..2cebe56d650c 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -455,8 +455,8 @@ el0_da:
 	bic	x0, x26, #(0xff << 56)
 	mov	x1, x25
 	mov	x2, sp
-	adr	lr, ret_to_user
-	b	do_mem_abort
+	bl	do_mem_abort
+	b	ret_to_user
 el0_ia:
 	/*
 	 * Instruction abort handling
@@ -468,8 +468,8 @@ el0_ia:
 	mov	x0, x26
 	orr	x1, x25, #1 << 24		// use reserved ISS bit for instruction aborts
 	mov	x2, sp
-	adr	lr, ret_to_user
-	b	do_mem_abort
+	bl	do_mem_abort
+	b	ret_to_user
 el0_fpsimd_acc:
 	/*
 	 * Floating Point or Advanced SIMD access
@@ -478,8 +478,8 @@ el0_fpsimd_acc:
 	ct_user_exit
 	mov	x0, x25
 	mov	x1, sp
-	adr	lr, ret_to_user
-	b	do_fpsimd_acc
+	bl	do_fpsimd_acc
+	b	ret_to_user
 el0_fpsimd_exc:
 	/*
 	 * Floating Point or Advanced SIMD exception
@@ -488,8 +488,8 @@ el0_fpsimd_exc:
 	ct_user_exit
 	mov	x0, x25
 	mov	x1, sp
-	adr	lr, ret_to_user
-	b	do_fpsimd_exc
+	bl	do_fpsimd_exc
+	b	ret_to_user
 el0_sp_pc:
 	/*
 	 * Stack or PC alignment exception handling
@@ -500,8 +500,8 @@ el0_sp_pc:
 	mov	x0, x26
 	mov	x1, x25
 	mov	x2, sp
-	adr	lr, ret_to_user
-	b	do_sp_pc_abort
+	bl	do_sp_pc_abort
+	b	ret_to_user
 el0_undef:
 	/*
 	 * Undefined instruction
@@ -510,8 +510,8 @@ el0_undef:
 	enable_dbg_and_irq
 	ct_user_exit
 	mov	x0, sp
-	adr	lr, ret_to_user
-	b	do_undefinstr
+	bl	do_undefinstr
+	b	ret_to_user
 el0_dbg:
 	/*
 	 * Debug exception handling
@@ -530,8 +530,8 @@ el0_inv:
 	mov	x0, sp
 	mov	x1, #BAD_SYNC
 	mrs	x2, esr_el1
-	adr	lr, ret_to_user
-	b	bad_mode
+	bl	bad_mode
+	b	ret_to_user
 ENDPROC(el0_sync)
 
 	.align	6
@@ -653,14 +653,15 @@ el0_svc_naked:					// compat entry point
 	ldr	x16, [tsk, #TI_FLAGS]		// check for syscall hooks
 	tst	x16, #_TIF_SYSCALL_WORK
 	b.ne	__sys_trace
-	adr	lr, ret_fast_syscall		// return address
 	cmp     scno, sc_nr                     // check upper syscall limit
 	b.hs	ni_sys
 	ldr	x16, [stbl, scno, lsl #3]	// address in the syscall table
-	br	x16				// call sys_* routine
+	blr	x16				// call sys_* routine
+	b	ret_fast_syscall
 ni_sys:
 	mov	x0, sp
-	b	do_ni_syscall
+	bl	do_ni_syscall
+	b	ret_fast_syscall
 ENDPROC(el0_svc)
 
 	/*
@@ -670,17 +671,16 @@ ENDPROC(el0_svc)
 __sys_trace:
 	mov	x0, sp
 	bl	syscall_trace_enter
-	adr	lr, __sys_trace_return		// return address
 	uxtw	scno, w0			// syscall number (possibly new)
 	mov	x1, sp				// pointer to regs
 	cmp	scno, sc_nr			// check upper syscall limit
-	b.hs	ni_sys
+	b.hs	__ni_sys_trace
 	ldp	x0, x1, [sp]			// restore the syscall args
 	ldp	x2, x3, [sp, #S_X2]
 	ldp	x4, x5, [sp, #S_X4]
 	ldp	x6, x7, [sp, #S_X6]
 	ldr	x16, [stbl, scno, lsl #3]	// address in the syscall table
-	br	x16				// call sys_* routine
+	blr	x16				// call sys_* routine
 
 __sys_trace_return:
 	str	x0, [sp]			// save returned x0
@@ -688,6 +688,11 @@ __sys_trace_return:
 	bl	syscall_trace_exit
 	b	ret_to_user
 
+__ni_sys_trace:
+	mov	x0, sp
+	bl	do_ni_syscall
+	b	__sys_trace_return
+
 /*
  * Special system call wrappers.
  */
-- 
2.1.1
