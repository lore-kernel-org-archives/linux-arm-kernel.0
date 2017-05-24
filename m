From: james.morse@arm.com (James Morse)
Date: Wed, 24 May 2017 17:58:02 +0100
Subject: [PATCH 5/9] arm64: entry.S: move enable_step_tsk into kernel_exit
In-Reply-To: <20170524165806.29866-1-james.morse@arm.com>
References: <20170524165806.29866-1-james.morse@arm.com>
Message-ID: <20170524165806.29866-6-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable_step_tsk may enable single-step, so needs to mask debug
exceptions to prevent us from single-stepping kernel_exit.  This
should be the callers problem.

Earlier cleanup (2a2830703a23) moved disable_step_tsk into kernel_entry.
enable_step_tsk has two callers, both immediatly before kernel_exit 0.
Move the macro call into kernel_exit after local_mask_daif.

enable_step_tsk is now only called with debug exceptions masked.
This was the last user of disable_dbg, remove it.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/assembler.h | 9 +--------
 arch/arm64/kernel/entry.S          | 7 ++++---
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 896ddd9b21a6..c6a0d956db8a 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -70,13 +70,6 @@
 	msr	daif, \flags
 	.endm
 
-/*
- * Enable and disable debug exceptions.
- */
-	.macro	disable_dbg
-	msr	daifset, #8
-	.endm
-
 	.macro	enable_dbg
 	msr	daifclr, #8
 	.endm
@@ -90,9 +83,9 @@
 9990:
 	.endm
 
+	/* call with daif masked */
 	.macro	enable_step_tsk, flgs, tmp
 	tbz	\flgs, #TIF_SINGLESTEP, 9990f
-	disable_dbg
 	mrs	\tmp, mdscr_el1
 	orr	\tmp, \tmp, #1
 	msr	mdscr_el1, \tmp
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index fd429d3ba29b..5fd3d494916d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -212,6 +212,10 @@ alternative_else_nop_endif
 	.if	\el == 0
 	ldr	x23, [sp, #S_SP]		// load return stack pointer
 	msr	sp_el0, x23
+
+	ldr	x1, [tsk, #TSK_TI_FLAGS]
+	enable_step_tsk flgs=x1, tmp=x2
+
 #ifdef CONFIG_ARM64_ERRATUM_845719
 alternative_if ARM64_WORKAROUND_845719
 	tbz	x22, #4, 1f
@@ -752,7 +756,6 @@ ret_fast_syscall:
 	cbnz	x2, ret_fast_syscall_trace
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
-	enable_step_tsk x1, x2
 	kernel_exit 0
 ret_fast_syscall_trace:
 	enable_irq				// enable interrupts
@@ -767,7 +770,6 @@ work_pending:
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_on		// enabled while in userspace
 #endif
-	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for single-step
 	b	finish_ret_to_user
 /*
  * "slow" syscall return path.
@@ -778,7 +780,6 @@ ret_to_user:
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
 finish_ret_to_user:
-	enable_step_tsk x1, x2
 	kernel_exit 0
 ENDPROC(ret_to_user)
 
-- 
2.11.0
