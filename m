From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 25 May 2018 10:49:16 +0100
Subject: [PATCH v4 10/26] arm64: Delay daif masking for user return
In-Reply-To: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
References: <1527241772-48007-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1527241772-48007-11-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Masking daif flags is done very early before returning to EL0.

Only toggle the interrupt masking while in the vector entry and mask daif
once in kernel_exit.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/entry.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ec2ee72..20252d5 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -240,9 +240,9 @@ alternative_else_nop_endif
 	.endm
 
 	.macro	kernel_exit, el
-	.if	\el != 0
 	disable_daif
 
+	.if	\el != 0
 	/* Restore the task's original addr_limit. */
 	ldr	x20, [sp, #S_ORIG_ADDR_LIMIT]
 	str	x20, [tsk, #TSK_TI_ADDR_LIMIT]
@@ -872,7 +872,7 @@ ENDPROC(el0_error)
  * and this includes saving x0 back into the kernel stack.
  */
 ret_fast_syscall:
-	disable_daif
+	disable_irq				// disable interrupts
 	str	x0, [sp, #S_X0]			// returned x0
 	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for syscall tracing
 	and	x2, x1, #_TIF_SYSCALL_WORK
@@ -882,7 +882,7 @@ ret_fast_syscall:
 	enable_step_tsk x1, x2
 	kernel_exit 0
 ret_fast_syscall_trace:
-	enable_daif
+	enable_irq				// enable interrupts
 	b	__sys_trace_return_skipped	// we already saved x0
 
 /*
@@ -900,7 +900,7 @@ work_pending:
  * "slow" syscall return path.
  */
 ret_to_user:
-	disable_daif
+	disable_irq				// disable interrupts
 	ldr	x1, [tsk, #TSK_TI_FLAGS]
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
-- 
1.9.1
