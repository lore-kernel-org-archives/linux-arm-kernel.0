From: will.deacon@arm.com (Will Deacon)
Date: Wed, 19 Aug 2015 16:09:49 +0100
Subject: [PATCH] arm64: entry: always restore x0 from the stack on syscall
 return
Message-ID: <1439996989-5772-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a micro-optimisation on the fast syscall return path where we
take care to keep x0 live with the return value from the syscall so that
we can avoid restoring it from the stack. The benefit of doing this is
fairly suspect, since we will be restoring x1 from the stack anyway
(which lives adjacent in the pt_regs structure) and the only additional
cost is saving x0 back to pt_regs after the syscall handler, which could
be seen as a poor man's prefetch.

More importantly, this causes issues with the context tracking code.

The ct_user_enter macro ends up branching into C code, which is free to
use x0 as a scratch register and consequently leads to us returning junk
back to userspace as the syscall return value. Rather than special case
the context-tracking code, this patch removes the questionable
optimisation entirely.

Cc: <stable@vger.kernel.org>
Cc: Larry Bassel <larry.bassel@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 301c37207c64..2a5e64ccc991 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -116,7 +116,7 @@
 	*/
 	.endm
 
-	.macro	kernel_exit, el, ret = 0
+	.macro	kernel_exit, el
 	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
 	.if	\el == 0
 	ct_user_enter
@@ -146,11 +146,7 @@
 	.endif
 	msr	elr_el1, x21			// set up the return data
 	msr	spsr_el1, x22
-	.if	\ret
-	ldr	x1, [sp, #S_X1]			// preserve x0 (syscall return)
-	.else
 	ldp	x0, x1, [sp, #16 * 0]
-	.endif
 	ldp	x2, x3, [sp, #16 * 1]
 	ldp	x4, x5, [sp, #16 * 2]
 	ldp	x6, x7, [sp, #16 * 3]
@@ -613,13 +609,14 @@ ENDPROC(cpu_switch_to)
  */
 ret_fast_syscall:
 	disable_irq				// disable interrupts
+	str	x0, [sp, #S_X0]			// returned x0
 	ldr	x1, [tsk, #TI_FLAGS]		// re-check for syscall tracing
 	and	x2, x1, #_TIF_SYSCALL_WORK
 	cbnz	x2, ret_fast_syscall_trace
 	and	x2, x1, #_TIF_WORK_MASK
-	cbnz	x2, fast_work_pending
+	cbnz	x2, work_pending
 	enable_step_tsk x1, x2
-	kernel_exit 0, ret = 1
+	kernel_exit 0
 ret_fast_syscall_trace:
 	enable_irq				// enable interrupts
 	b	__sys_trace_return
@@ -627,8 +624,6 @@ ret_fast_syscall_trace:
 /*
  * Ok, we need to do extra processing, enter the slow path.
  */
-fast_work_pending:
-	str	x0, [sp, #S_X0]			// returned x0
 work_pending:
 	tbnz	x1, #TIF_NEED_RESCHED, work_resched
 	/* TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_FOREIGN_FPSTATE case */
@@ -652,7 +647,7 @@ ret_to_user:
 	cbnz	x2, work_pending
 	enable_step_tsk x1, x2
 no_work_pending:
-	kernel_exit 0, ret = 0
+	kernel_exit 0
 ENDPROC(ret_to_user)
 
 /*
-- 
2.1.4
