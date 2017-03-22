From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:54 +0000
Subject: [RFC PATCH v2 24/41] arm64/sve: Discard SVE state on system call
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-25-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The base procedure call standard for the Scalable Vector Extension
defines all of the SVE programmer's model state (Z0-31, P0-15, FFR)
as caller-save, except for that subset of the state that aliases
FPSIMD state.

System calls from userspace will almost always be made through C
library wrappers -- as a consequence of the PCS there will thus
rarely if ever be any live SVE state at syscall entry in practice.

This gives us an opportinity to make SVE explicitly caller-save
around SVC and so stop carrying around the SVE state for tasks that
use SVE only occasionally (say, by calling a library).

Note that FPSIMD state will still be preserved around SVC.

As a crude heuristic to avoid pathological cases where a thread
that uses SVE frequently has to fault back into the kernel again to
re-enable SVE after a syscall, we switch the thread back to
FPSIMD-only context tracking only if the context is actually
switched out before returning to userspace.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 5fb5585..8c18384 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -250,6 +250,23 @@ static void task_fpsimd_save(struct task_struct *task)
 	BUG_ON(task != current);
 
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
+	    task_pt_regs(task)->syscallno != ~0UL &&
+	    test_tsk_thread_flag(task, TIF_SVE)) {
+		unsigned long tmp;
+
+		clear_tsk_thread_flag(task, TIF_SVE);
+
+		/* Trap if the task tries to use SVE again: */
+		asm volatile (
+			"mrs	%[tmp], cpacr_el1\n\t"
+			"bic	%[tmp], %[tmp], %[mask]\n\t"
+			"msr	cpacr_el1, %[tmp]"
+			: [tmp] "=r" (tmp)
+			: [mask] "i" (CPACR_EL1_ZEN_EL0EN)
+		);
+	}
+
+	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    test_tsk_thread_flag(task, TIF_SVE))
 		sve_save_state(sve_pffr(task),
 			       &task->thread.fpsimd_state.fpsr);
-- 
2.1.4
