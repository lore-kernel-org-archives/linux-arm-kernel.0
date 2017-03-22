From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:51:03 +0000
Subject: [RFC PATCH v2 33/41] arm64/sve: Wire up vector length control prctl()
 calls
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-34-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides implementation for the PR_SVE_SET_VL and
PR_SVE_GET_VL prctls, which allow a task to set and query its
vector length and associated control flags (although no flags are
defined in this patch).

Currently any thread can set its VL, allowing a mix of VLs within
a single process -- this behaviour will be refined in susequent
patches.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/fpsimd.h |  3 ++
 arch/arm64/kernel/fpsimd.c      | 65 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 557e755..764da0f 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -109,6 +109,9 @@ extern void fpsimd_sync_to_sve(struct task_struct *task);
 extern void sve_sync_to_fpsimd(struct task_struct *task);
 extern void sve_sync_from_fpsimd_zeropad(struct task_struct *task);
 
+extern int sve_set_vector_length(struct task_struct *task,
+				 unsigned long vl, unsigned long flags);
+
 extern int sve_set_task_vl(struct task_struct *task,
 			   unsigned long vector_length, unsigned long flags);
 extern int sve_get_task_vl(struct task_struct *task);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index daceeae..c9934bb 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -221,17 +221,78 @@ void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 	task_fpsimd_load(current);
 }
 
+int sve_set_vector_length(struct task_struct *task,
+			  unsigned long vl, unsigned long flags)
+{
+	BUG_ON(task == current && preemptible());
+
+	if (flags)
+		return -EINVAL; /* No flags defined yet */
+
+	if (!sve_vl_valid(vl))
+		return -EINVAL;
+
+	if (vl > sve_max_vl) {
+		BUG_ON(!sve_vl_valid(sve_max_vl));
+		vl = sve_max_vl;
+	}
+
+	/*
+	 * To ensure the FPSIMD bits of the SVE vector registers are preserved,
+	 * write any live register state back to task_struct, and convert to a
+	 * non-SVE thread.
+	 */
+	if (vl != task->thread.sve_vl) {
+		if (task == current &&
+		    !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
+			task_fpsimd_save(current);
+
+		if (test_and_clear_tsk_thread_flag(task, TIF_SVE))
+			sve_to_fpsimd(task);
+
+		/*
+		 * To avoid surprises, also zero out the SVE regs storage.
+		 * This means that the P-regs, FFR and high bits of Z-regs
+		 * will read as zero on next access:
+		 */
+		clear_sve_regs(task);
+	}
+
+	task->thread.sve_vl = vl;
+
+	fpsimd_flush_task_state(task);
+
+	return 0;
+}
+
 /* PR_SVE_SET_VL */
 int sve_set_task_vl(struct task_struct *task,
 		    unsigned long vector_length, unsigned long flags)
 {
-	return -EINVAL;
+	int ret;
+
+	if (!(elf_hwcap & HWCAP_SVE))
+		return -EINVAL;
+
+	BUG_ON(task != current);
+
+	preempt_disable();
+	ret = sve_set_vector_length(current, vector_length, flags);
+	preempt_enable();
+
+	if (ret)
+		return ret;
+
+	return task->thread.sve_vl;
 }
 
 /* PR_SVE_GET_VL */
 int sve_get_task_vl(struct task_struct *task)
 {
-	return -EINVAL;
+	if (!(elf_hwcap & HWCAP_SVE))
+		return -EINVAL;
+
+	return task->thread.sve_vl;
 }
 
 #else /* ! CONFIG_ARM64_SVE */
-- 
2.1.4
