From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  1 Jun 2018 16:27:21 +0100
Subject: [PATCH 07/33] arm64: fpsimd: Generalise context saving for non-task
 contexts
In-Reply-To: <20180601152747.23613-1-marc.zyngier@arm.com>
References: <20180601152747.23613-1-marc.zyngier@arm.com>
Message-ID: <20180601152747.23613-8-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <Dave.Martin@arm.com>

In preparation for allowing non-task (i.e., KVM vcpu) FPSIMD
contexts to be handled by the fpsimd common code, this patch adapts
task_fpsimd_save() to save back the currently loaded context,
removing the explicit dependency on current.

The relevant storage to write back to in memory is now found by
examining the fpsimd_last_state percpu struct.

fpsimd_save() does nothing unless TIF_FOREIGN_FPSTATE is clear, and
fpsimd_last_state is updated under local_bh_disable() or
local_irq_disable() everywhere that TIF_FOREIGN_FPSTATE is cleared:
thus, fpsimd_save() will write back to the correct storage for the
loaded context.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 9d853732f9f4..2d9a9e8ed826 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -270,13 +270,16 @@ static void task_fpsimd_load(void)
 }
 
 /*
- * Ensure current's FPSIMD/SVE storage in thread_struct is up to date
- * with respect to the CPU registers.
+ * Ensure FPSIMD/SVE storage in memory for the loaded context is up to
+ * date with respect to the CPU registers.
  *
  * Softirqs (and preemption) must be disabled.
  */
-static void task_fpsimd_save(void)
+static void fpsimd_save(void)
 {
+	struct user_fpsimd_state *st = __this_cpu_read(fpsimd_last_state.st);
+	/* set by fpsimd_bind_to_cpu() */
+
 	WARN_ON(!in_softirq() && !irqs_disabled());
 
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE)) {
@@ -291,10 +294,9 @@ static void task_fpsimd_save(void)
 				return;
 			}
 
-			sve_save_state(sve_pffr(current),
-				       &current->thread.uw.fpsimd_state.fpsr);
+			sve_save_state(sve_pffr(current), &st->fpsr);
 		} else
-			fpsimd_save_state(&current->thread.uw.fpsimd_state);
+			fpsimd_save_state(st);
 	}
 }
 
@@ -598,7 +600,7 @@ int sve_set_vector_length(struct task_struct *task,
 	if (task == current) {
 		local_bh_disable();
 
-		task_fpsimd_save();
+		fpsimd_save();
 		set_thread_flag(TIF_FOREIGN_FPSTATE);
 	}
 
@@ -837,7 +839,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 
 	local_bh_disable();
 
-	task_fpsimd_save();
+	fpsimd_save();
 	fpsimd_to_sve(current);
 
 	/* Force ret_to_user to reload the registers: */
@@ -898,7 +900,7 @@ void fpsimd_thread_switch(struct task_struct *next)
 	 * 'current'.
 	 */
 	if (current->mm)
-		task_fpsimd_save();
+		fpsimd_save();
 
 	if (next->mm) {
 		/*
@@ -980,7 +982,7 @@ void fpsimd_preserve_current_state(void)
 		return;
 
 	local_bh_disable();
-	task_fpsimd_save();
+	fpsimd_save();
 	local_bh_enable();
 }
 
@@ -1121,7 +1123,7 @@ void kernel_neon_begin(void)
 
 	/* Save unsaved task fpsimd state, if any: */
 	if (current->mm)
-		task_fpsimd_save();
+		fpsimd_save();
 
 	/* Invalidate any task state remaining in the fpsimd regs: */
 	fpsimd_flush_cpu_state();
@@ -1244,7 +1246,7 @@ static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
 	switch (cmd) {
 	case CPU_PM_ENTER:
 		if (current->mm)
-			task_fpsimd_save();
+			fpsimd_save();
 		fpsimd_flush_cpu_state();
 		break;
 	case CPU_PM_EXIT:
-- 
2.17.1
