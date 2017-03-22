From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:42 +0000
Subject: [RFC PATCH v2 12/41] arm64/sve: Save/restore SVE state on context
 switch paths
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-13-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements basic handling of the Scalable Vector
Extension state on the primary context switch paths.

This does *not* (correctly) handle the signal path, and doesn't do
save/restore for SVE-only accesses that don't affect the FPSIMD
state (i.e., FFR).

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index bc7a2d5..f8acce2 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -180,7 +180,7 @@ void fpsimd_thread_switch(struct task_struct *next)
 	 * 'current'.
 	 */
 	if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE))
-		fpsimd_save_state(&current->thread.fpsimd_state);
+		task_fpsimd_save(current);
 
 	if (next->mm) {
 		/*
@@ -234,7 +234,7 @@ void fpsimd_preserve_current_state(void)
 		return;
 	preempt_disable();
 	if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
-		fpsimd_save_state(&current->thread.fpsimd_state);
+		task_fpsimd_save(current);
 	preempt_enable();
 }
 
@@ -251,7 +251,7 @@ void fpsimd_restore_current_state(void)
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		struct fpsimd_state *st = &current->thread.fpsimd_state;
 
-		fpsimd_load_state(st);
+		task_fpsimd_load(current);
 		this_cpu_write(fpsimd_last_state, st);
 		st->cpu = smp_processor_id();
 	}
@@ -343,7 +343,7 @@ static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
 	switch (cmd) {
 	case CPU_PM_ENTER:
 		if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE))
-			fpsimd_save_state(&current->thread.fpsimd_state);
+			task_fpsimd_save(current);
 		this_cpu_write(fpsimd_last_state, NULL);
 		break;
 	case CPU_PM_EXIT:
-- 
2.1.4
