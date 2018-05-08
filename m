From: Dave.Martin@arm.com (Dave Martin)
Date: Tue,  8 May 2018 17:44:47 +0100
Subject: [PATCH v6 02/15] arm64: Use update{,_tsk}_thread_flag()
In-Reply-To: <1525797900-5548-1-git-send-email-Dave.Martin@arm.com>
References: <1525797900-5548-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1525797900-5548-3-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the new update_thread_flag() helpers to simplify a
couple of if () set; else clear; constructs.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 87a3536..0c4e7e0 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -618,10 +618,8 @@ int sve_set_vector_length(struct task_struct *task,
 	task->thread.sve_vl = vl;
 
 out:
-	if (flags & PR_SVE_VL_INHERIT)
-		set_tsk_thread_flag(task, TIF_SVE_VL_INHERIT);
-	else
-		clear_tsk_thread_flag(task, TIF_SVE_VL_INHERIT);
+	update_tsk_thread_flag(task, TIF_SVE_VL_INHERIT,
+			       flags & PR_SVE_VL_INHERIT);
 
 	return 0;
 }
@@ -902,7 +900,7 @@ void fpsimd_thread_switch(struct task_struct *next)
 	if (current->mm)
 		task_fpsimd_save();
 
-	if (next->mm) {
+	if (next->mm)
 		/*
 		 * If we are switching to a task whose most recent userland
 		 * FPSIMD state is already in the registers of *this* cpu,
@@ -910,13 +908,10 @@ void fpsimd_thread_switch(struct task_struct *next)
 		 * the TIF_FOREIGN_FPSTATE flag so the state will be loaded
 		 * upon the next return to userland.
 		 */
-		if (__this_cpu_read(fpsimd_last_state.st) ==
-			&next->thread.uw.fpsimd_state
-		    && next->thread.fpsimd_cpu == smp_processor_id())
-			clear_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
-		else
-			set_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
-	}
+		update_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE,
+			__this_cpu_read(fpsimd_last_state.st) !=
+				&next->thread.uw.fpsimd_state ||
+			next->thread.fpsimd_cpu != smp_processor_id());
 }
 
 void fpsimd_flush_thread(void)
-- 
2.1.4
