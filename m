From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  1 Jun 2018 16:27:24 +0100
Subject: [PATCH 10/33] arm64/sve: Refactor user SVE trap maintenance for
 external use
In-Reply-To: <20180601152747.23613-1-marc.zyngier@arm.com>
References: <20180601152747.23613-1-marc.zyngier@arm.com>
Message-ID: <20180601152747.23613-11-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <Dave.Martin@arm.com>

In preparation for optimising the way KVM manages switching the
guest and host FPSIMD state, it is necessary to provide a means for
code outside arch/arm64/kernel/fpsimd.c to restore the user trap
configuration for SVE correctly for the current task.

Rather than requiring external code to duplicate the maintenance
explicitly, this patch moves the trap maintenenace to
fpsimd_bind_to_cpu(), since it is logically part of the work of
associating the current task with the cpu.

Because fpsimd_bind_to_cpu() is rather a cryptic name to publish
alongside fpsimd_bind_state_to_cpu(), the former function is
renamed to fpsimd_bind_task_to_cpu() to make its purpose more
explicit.

This patch makes appropriate changes to ensure that
fpsimd_bind_task_to_cpu() is always called alongside
task_fpsimd_load(), so that the trap maintenance continues to be
done in every situation where it was done prior to this patch.

As a side-effect, the metadata updates done by
fpsimd_bind_task_to_cpu() now change from conditional to
unconditional in the "already bound" case of sigreturn.  This is
harmless, and a couple of extra stores on this slow path will not
impact performance.  I consider this a reasonable price to pay for
a slightly cleaner interface.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index d736b6c412ef..d5f659f476a8 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -257,16 +257,6 @@ static void task_fpsimd_load(void)
 			       sve_vq_from_vl(current->thread.sve_vl) - 1);
 	else
 		fpsimd_load_state(&current->thread.uw.fpsimd_state);
-
-	if (system_supports_sve()) {
-		/* Toggle SVE trapping for userspace if needed */
-		if (test_thread_flag(TIF_SVE))
-			sve_user_enable();
-		else
-			sve_user_disable();
-
-		/* Serialised by exception return to user */
-	}
 }
 
 /*
@@ -278,7 +268,7 @@ static void task_fpsimd_load(void)
 static void fpsimd_save(void)
 {
 	struct user_fpsimd_state *st = __this_cpu_read(fpsimd_last_state.st);
-	/* set by fpsimd_bind_to_cpu() */
+	/* set by fpsimd_bind_task_to_cpu() */
 
 	WARN_ON(!in_softirq() && !irqs_disabled());
 
@@ -996,7 +986,7 @@ void fpsimd_signal_preserve_current_state(void)
  * Associate current's FPSIMD context with this cpu
  * Preemption must be disabled when calling this function.
  */
-static void fpsimd_bind_to_cpu(void)
+static void fpsimd_bind_task_to_cpu(void)
 {
 	struct fpsimd_last_state_struct *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1004,6 +994,16 @@ static void fpsimd_bind_to_cpu(void)
 	last->st = &current->thread.uw.fpsimd_state;
 	last->sve_in_use = test_thread_flag(TIF_SVE);
 	current->thread.fpsimd_cpu = smp_processor_id();
+
+	if (system_supports_sve()) {
+		/* Toggle SVE trapping for userspace if needed */
+		if (test_thread_flag(TIF_SVE))
+			sve_user_enable();
+		else
+			sve_user_disable();
+
+		/* Serialised by exception return to user */
+	}
 }
 
 /*
@@ -1020,7 +1020,7 @@ void fpsimd_restore_current_state(void)
 
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		task_fpsimd_load();
-		fpsimd_bind_to_cpu();
+		fpsimd_bind_task_to_cpu();
 	}
 
 	local_bh_enable();
@@ -1043,9 +1043,9 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 		fpsimd_to_sve(current);
 
 	task_fpsimd_load();
+	fpsimd_bind_task_to_cpu();
 
-	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE))
-		fpsimd_bind_to_cpu();
+	clear_thread_flag(TIF_FOREIGN_FPSTATE);
 
 	local_bh_enable();
 }
-- 
2.17.1
