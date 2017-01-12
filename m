From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 12 Jan 2017 11:26:04 +0000
Subject: [RFC PATCH 05/10] arm64/sve: Wire up vector length control prctl()
 calls
In-Reply-To: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1484220369-23970-6-git-send-email-Dave.Martin@arm.com>
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
 arch/arm64/include/asm/fpsimd.h |  2 ++
 arch/arm64/kernel/fpsimd.c      | 65 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 22d09c0..1ec2363 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -103,6 +103,8 @@ extern void sve_save_state(void *state, u32 *pfpsr);
 extern void sve_load_state(void const *state, u32 const *pfpsr,
 			   unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
+extern int sve_set_vector_length(struct task_struct *task,
+				 unsigned long vl, unsigned long flags);
 
 /*
  * FPSIMD/SVE synchronisation helpers for ptrace:
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 54d7ed0..5f2c24a 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -493,17 +493,78 @@ void fpsimd_sync_from_fpsimd_zeropad(struct task_struct *task)
 	__fpsimd_sync_from_fpsimd_zeropad(task, sve_vq_from_vl(vl));
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
+			task_sve_to_fpsimd(task);
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
 
 #endif /* CONFIG_ARM64_SVE */
-- 
2.1.4
