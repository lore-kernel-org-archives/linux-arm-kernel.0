From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  5 Jan 2016 17:33:34 +0000
Subject: [PATCH 1/2] arm64: entry: remove pointless SPSR mode check
In-Reply-To: <20160105172106.GA7088@leverpostej>
References: <20160105172106.GA7088@leverpostej>
Message-ID: <1452015215-29506-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In work_pending  we may skip work if the stacked SPSR value represents
anything other than an EL0 context. We then immediately invoke the
kernel_exit 0 macro as part of ret_to_user, assuming a return to EL0.
This is somewhat confusing.

We use work_pending as part of the ret_to_user/ret_fast_syscall state
machine. We only use ret_fast_syscall in the return from an SVC issued
from EL0. We use ret_to_user for return from EL0 exception handlers and
also for return from ret_from_fork in the case the task was not a kernel
thread (i.e. it is a user task).

Thus in all cases the stacked SPSR value must represent an EL0 context,
and the check is redundant. This patch removes it, along with the now
unused no_work_pending label.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/entry.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 7ed3d75..6b30ab1 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -626,10 +626,7 @@ ret_fast_syscall_trace:
 work_pending:
 	tbnz	x1, #TIF_NEED_RESCHED, work_resched
 	/* TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_FOREIGN_FPSTATE case */
-	ldr	x2, [sp, #S_PSTATE]
 	mov	x0, sp				// 'regs'
-	tst	x2, #PSR_MODE_MASK		// user mode regs?
-	b.ne	no_work_pending			// returning to kernel
 	enable_irq				// enable interrupts for do_notify_resume()
 	bl	do_notify_resume
 	b	ret_to_user
@@ -645,7 +642,6 @@ ret_to_user:
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
 	enable_step_tsk x1, x2
-no_work_pending:
 	kernel_exit 0
 ENDPROC(ret_to_user)
 
-- 
1.9.1
