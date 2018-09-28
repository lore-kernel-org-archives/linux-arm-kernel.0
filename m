From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 28 Sep 2018 14:39:05 +0100
Subject: [RFC PATCH v2 01/23] arm64: fpsimd: Always set TIF_FOREIGN_FPSTATE on
 task state flush
In-Reply-To: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1538141967-15375-2-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates fpsimd_flush_task_state() to mirror the new
semantics of fpsimd_flush_cpu_state(): both functions now
implicitly set TIF_FOREIGN_FPSTATE to indicate that the task's
FPSIMD state is not loaded into the cpu.

As a side-effect, fpsimd_flush_task_state() now sets
TIF_FOREIGN_FPSTATE even for non-running tasks.  In the case of
non-running tasks this is not useful but also harmless, because the
flag is live only while the corresponding task is running.  This
function is not called from fast paths, so special-casing this for
the task == current case is not really worth it.

Compiler barriers previously present in restore_sve_fpsimd_context()
are pulled into fpsimd_flush_task_state() so that it can be safely
called with preemption enabled if necessary.

Explicit calls to set TIF_FOREIGN_FPSTATE that accompany
fpsimd_flush_task_state() calls and are now redundant are removed
as appropriate.

fpsimd_flush_task_state() is used to get exclusive access to the
representation of the task's state via task_struct, for the purpose
of replacing the state.  Thus, the call to this function should
happen before manipulating fpsimd_state or sve_state etc. in
task_struct.  Anomalous cases are reordered appropriately in order
to make the code more consistent, although there should be no
functional difference since these cases are protected by
local_bh_disable() anyway.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
---
 arch/arm64/kernel/fpsimd.c | 25 +++++++++++++++++++------
 arch/arm64/kernel/signal.c |  5 -----
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 58c53bc..42aa154 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -550,7 +550,6 @@ int sve_set_vector_length(struct task_struct *task,
 		local_bh_disable();
 
 		fpsimd_save();
-		set_thread_flag(TIF_FOREIGN_FPSTATE);
 	}
 
 	fpsimd_flush_task_state(task);
@@ -816,12 +815,11 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 	local_bh_disable();
 
 	fpsimd_save();
-	fpsimd_to_sve(current);
 
 	/* Force ret_to_user to reload the registers: */
 	fpsimd_flush_task_state(current);
-	set_thread_flag(TIF_FOREIGN_FPSTATE);
 
+	fpsimd_to_sve(current);
 	if (test_and_set_thread_flag(TIF_SVE))
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 
@@ -898,9 +896,9 @@ void fpsimd_flush_thread(void)
 
 	local_bh_disable();
 
+	fpsimd_flush_task_state(current);
 	memset(&current->thread.uw.fpsimd_state, 0,
 	       sizeof(current->thread.uw.fpsimd_state));
-	fpsimd_flush_task_state(current);
 
 	if (system_supports_sve()) {
 		clear_thread_flag(TIF_SVE);
@@ -937,8 +935,6 @@ void fpsimd_flush_thread(void)
 			current->thread.sve_vl_onexec = 0;
 	}
 
-	set_thread_flag(TIF_FOREIGN_FPSTATE);
-
 	local_bh_enable();
 }
 
@@ -1047,12 +1043,29 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 
 /*
  * Invalidate live CPU copies of task t's FPSIMD state
+ *
+ * This function may be called with preemption enabled.  The barrier()
+ * ensures that the assignment to fpsimd_cpu is visible to any
+ * preemption/softirq that could race with set_tsk_thread_flag(), so
+ * that TIF_FOREIGN_FPSTATE cannot be spuriously re-cleared.
+ *
+ * The final barrier ensures that TIF_FOREIGN_FPSTATE is seen set by any
+ * subsequent code.
  */
 void fpsimd_flush_task_state(struct task_struct *t)
 {
 	t->thread.fpsimd_cpu = NR_CPUS;
+
+	barrier();
+	set_tsk_thread_flag(t, TIF_FOREIGN_FPSTATE);
+
+	barrier();
 }
 
+/*
+ * Invalidate any task's FPSIMD state that is present on this cpu.
+ * This function must be called with softirqs disabled.
+ */
 void fpsimd_flush_cpu_state(void)
 {
 	__this_cpu_write(fpsimd_last_state.st, NULL);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 5dcc942..7dcf0f1 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -296,11 +296,6 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	 */
 
 	fpsimd_flush_task_state(current);
-	barrier();
-	/* From now, fpsimd_thread_switch() won't clear TIF_FOREIGN_FPSTATE */
-
-	set_thread_flag(TIF_FOREIGN_FPSTATE);
-	barrier();
 	/* From now, fpsimd_thread_switch() won't touch thread.sve_state */
 
 	sve_alloc(current);
-- 
2.1.4
