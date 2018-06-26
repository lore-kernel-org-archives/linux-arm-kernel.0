From: eugene.loh@oracle.com (eugene.loh at oracle.com)
Date: Tue, 26 Jun 2018 10:47:41 -0700
Subject: [PATCH] arm64: entry: add END/ENDPROC markers to *.S files
Message-ID: <1530035261-17786-1-git-send-email-eugene.loh@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eugene Loh <eugene.loh@oracle.com>

Add END/ENDPROC markers to *.S files so that assembly instructions
can be mapped to symbols.

Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
Reviewed-by: Rob Gardner <rob.gardner@oracle.com>

Orabug: 28143715
---
 arch/arm64/kernel/entry.S      | 6 +++++-
 arch/arm64/kvm/hyp/hyp-entry.S | 6 ++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 5f4e54a..3ad0e1a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -456,6 +456,7 @@ __bad_stack:
 	/* Time to die */
 	bl	handle_bad_stack
 	ASM_BUG()
+END(__bad_stack)
 #endif /* CONFIG_VMAP_STACK */
 
 /*
@@ -622,6 +623,7 @@ el1_preempt:
 	ldr	x0, [tsk, #TSK_TI_FLAGS]	// get new tasks TI_FLAGS
 	tbnz	x0, #TIF_NEED_RESCHED, 1b	// needs rescheduling?
 	ret	x24
+END(el1_preempt)
 #endif
 
 /*
@@ -886,6 +888,7 @@ ret_fast_syscall:
 ret_fast_syscall_trace:
 	enable_irq				// enable interrupts
 	b	__sys_trace_return_skipped	// we already saved x0
+END(ret_fast_syscall)
 
 /*
  * Ok, we need to do extra processing, enter the slow path.
@@ -898,6 +901,7 @@ work_pending:
 #endif
 	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for single-step
 	b	finish_ret_to_user
+END(work_pending)
 /*
  * "slow" syscall return path.
  */
@@ -958,7 +962,6 @@ ni_sys:
 	mov	x0, sp
 	bl	do_ni_syscall
 	b	ret_fast_syscall
-ENDPROC(el0_svc)
 
 	/*
 	 * This is the really slow path.  We're going to be doing context
@@ -995,6 +998,7 @@ __ni_sys_trace:
 	mov	x0, sp
 	bl	do_ni_syscall
 	b	__sys_trace_return
+ENDPROC(el0_svc)
 
 	.popsection				// .entry.text
 
diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
index f36464b..7383722 100644
--- a/arch/arm64/kvm/hyp/hyp-entry.S
+++ b/arch/arm64/kvm/hyp/hyp-entry.S
@@ -101,6 +101,7 @@ alternative_endif
 	do_el2_call
 
 	eret
+ENDPROC(el1_sync)
 
 el1_hvc_guest:
 	/*
@@ -115,6 +116,7 @@ el1_hvc_guest:
 	mov	x0, x1
 	add	sp, sp, #16
 	eret
+ENDPROC(el1_hvc_guest)
 
 el1_trap:
 	/*
@@ -135,18 +137,21 @@ alternative_else_nop_endif
 
 	mov	x0, #ARM_EXCEPTION_TRAP
 	b	__guest_exit
+ENDPROC(el1_trap)
 
 el1_irq:
 	stp     x0, x1, [sp, #-16]!
 	ldr	x1, [sp, #16 + 8]
 	mov	x0, #ARM_EXCEPTION_IRQ
 	b	__guest_exit
+ENDPROC(el1_irq)
 
 el1_error:
 	stp     x0, x1, [sp, #-16]!
 	ldr	x1, [sp, #16 + 8]
 	mov	x0, #ARM_EXCEPTION_EL1_SERROR
 	b	__guest_exit
+ENDPROC(el1_error)
 
 el2_error:
 	/*
@@ -169,6 +174,7 @@ el2_error:
 	b.ne	__hyp_panic
 	mov	x0, #(1 << ARM_EXIT_WITH_SERROR_BIT)
 	eret
+ENDPROC(el2_error)
 
 ENTRY(__hyp_do_panic)
 	mov	lr, #(PSR_F_BIT | PSR_I_BIT | PSR_A_BIT | PSR_D_BIT |\
-- 
1.8.3.1
