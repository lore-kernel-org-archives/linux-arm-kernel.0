From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:51:09 +0000
Subject: [RFC PATCH v2 39/41] arm64/sve: Migrate to cpucap based detection for
 runtime SVE code
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-40-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Checking elf_hwcap multiple times on the context switch path is an
unnecessary cost.

Because the cpufeature framework allows for more efficient
decisions by branch patching, it will be more efficient to test for
the ARM64_SVE CPU capability using cpus_have_const_cap() instead.

The test is guarded with IS_ENABLED() so that SVE-dependent code
can still be optimised out if CONFIG_ARM64_SVE is not set.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  3 ++-
 arch/arm64/kernel/fpsimd.c          | 26 ++++++++++++--------------
 arch/arm64/kernel/ptrace.c          |  5 +++--
 arch/arm64/kernel/signal.c          | 14 +++++---------
 4 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 90e4b79..e8d4857 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -263,7 +263,8 @@ static inline bool system_uses_ttbr0_pan(void)
 
 static inline bool system_supports_sve(void)
 {
-	return cpus_have_const_cap(ARM64_SVE);
+	return IS_ENABLED(CONFIG_ARM64_SVE) &&
+		cpus_have_const_cap(ARM64_SVE);
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 34ec75e..2b9def0 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -148,7 +148,7 @@ static void fpsimd_to_sve(struct task_struct *task)
 {
 	unsigned int vl = task->thread.sve_vl;
 
-	if (!(elf_hwcap & HWCAP_SVE))
+	if (!system_supports_sve())
 		return;
 
 	BUG_ON(!sve_vl_valid(vl));
@@ -169,7 +169,7 @@ static void sve_to_fpsimd(struct task_struct *task)
 {
 	unsigned int vl = task->thread.sve_vl;
 
-	if (!(elf_hwcap & HWCAP_SVE))
+	if (!system_supports_sve())
 		return;
 
 	BUG_ON(!sve_vl_valid(vl));
@@ -316,7 +316,7 @@ int sve_set_task_vl(struct task_struct *task,
 {
 	int ret;
 
-	if (!(elf_hwcap & HWCAP_SVE))
+	if (!system_supports_sve())
 		return -EINVAL;
 
 	BUG_ON(task != current);
@@ -334,7 +334,7 @@ int sve_set_task_vl(struct task_struct *task,
 /* PR_SVE_GET_VL */
 int sve_get_task_vl(struct task_struct *task)
 {
-	if (!(elf_hwcap & HWCAP_SVE))
+	if (!system_supports_sve())
 		return -EINVAL;
 
 	return sve_prctl_status(task);
@@ -552,8 +552,7 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 
 static void task_fpsimd_load(struct task_struct *task)
 {
-	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
-	    test_tsk_thread_flag(task, TIF_SVE)) {
+	if (system_supports_sve() && test_tsk_thread_flag(task, TIF_SVE)) {
 		unsigned int vl = task->thread.sve_vl;
 
 		BUG_ON(!sve_vl_valid(vl));
@@ -567,7 +566,7 @@ static void task_fpsimd_load(struct task_struct *task)
 	 * Flip SVE enable for userspace if it doesn't match the
 	 * current_task.
 	 */
-	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE)) {
+	if (system_supports_sve()) {
 		unsigned int tmp, flags;
 
 		asm ("mrs %0, cpacr_el1" : "=r" (tmp));
@@ -586,7 +585,7 @@ static void task_fpsimd_save(struct task_struct *task)
 	/* FIXME: remove task argument? */
 	BUG_ON(task != current);
 
-	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
+	if (system_supports_sve() &&
 	    task_pt_regs(task)->syscallno != ~0UL &&
 	    test_tsk_thread_flag(task, TIF_SVE)) {
 		unsigned long tmp;
@@ -603,8 +602,7 @@ static void task_fpsimd_save(struct task_struct *task)
 		);
 	}
 
-	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
-	    test_tsk_thread_flag(task, TIF_SVE))
+	if (system_supports_sve() && test_tsk_thread_flag(task, TIF_SVE))
 		sve_save_state(sve_pffr(task),
 			       &task->thread.fpsimd_state.fpsr);
 	else
@@ -652,7 +650,7 @@ void fpsimd_flush_thread(void)
 
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
 
-	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE)) {
+	if (system_supports_sve()) {
 		clear_sve_regs(current);
 
 		current->thread.sve_vl = current->thread.sve_vl_onexec ?
@@ -733,7 +731,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
 		return;
 	preempt_disable();
 
-	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE)) {
+	if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
 		current->thread.fpsimd_state = *state;
 		fpsimd_to_sve(current);
 	}
@@ -777,7 +775,7 @@ void kernel_neon_begin_partial(u32 num_regs)
 	 * interrupt context, so always save the userland SVE state
 	 * if there is any, even for interrupts.
 	 */
-	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
+	if (system_supports_sve() &&
 	    test_thread_flag(TIF_SVE) && current->mm &&
 	    !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		fpsimd_save_state(&current->thread.fpsimd_state);
@@ -918,7 +916,7 @@ static int __init fpsimd_init(void)
 	if (!(elf_hwcap & HWCAP_ASIMD))
 		pr_notice("Advanced SIMD is not implemented\n");
 
-	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE))
+	if (system_supports_sve())
 		return sve_procfs_init();
 
 	return 0;
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 02d3265..bbb8e38 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -42,6 +42,7 @@
 #include <linux/elf.h>
 
 #include <asm/compat.h>
+#include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
 #include <asm/pgtable.h>
 #include <asm/syscall.h>
@@ -740,7 +741,7 @@ static int sve_get(struct task_struct *target,
 	unsigned int vq;
 	unsigned long start, end;
 
-	if (!(elf_hwcap & HWCAP_SVE))
+	if (!system_supports_sve())
 		return -EINVAL;
 
 	/* Header */
@@ -835,7 +836,7 @@ static int sve_set(struct task_struct *target,
 	unsigned int vq;
 	unsigned long start, end;
 
-	if (!(elf_hwcap & HWCAP_SVE))
+	if (!system_supports_sve())
 		return -EINVAL;
 
 	/* Header */
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 45f0c2c..e3810e2 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -378,10 +378,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			break;
 
 		case SVE_MAGIC:
-			if (!IS_ENABLED(CONFIG_ARM64_SVE))
-				goto invalid;
-
-			if (!(elf_hwcap & HWCAP_SVE))
+			if (!system_supports_sve())
 				goto invalid;
 
 			if (user->sve)
@@ -481,8 +478,7 @@ static int restore_sigframe(struct pt_regs *regs,
 			return -EINVAL;
 
 		if (user.sve) {
-			if (!IS_ENABLED(CONFIG_ARM64_SVE) ||
-			    !(elf_hwcap & HWCAP_SVE))
+			if (!system_supports_sve())
 				return -EINVAL;
 
 			err = restore_sve_fpsimd_context(&user);
@@ -547,14 +543,14 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
 			return err;
 	}
 
-	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE)) {
+	if (system_supports_sve() && test_thread_flag(TIF_SVE)) {
 		unsigned int vl = current->thread.sve_vl;
 		unsigned int vq;
 
 		BUG_ON(!sve_vl_valid(vl));
 		vq = sve_vq_from_vl(vl);
 
-		BUG_ON(!(elf_hwcap & HWCAP_SVE));
+		BUG_ON(!system_supports_sve());
 
 		err = sigframe_alloc(user, &user->sve_offset,
 				     SVE_SIG_CONTEXT_SIZE(vq));
@@ -604,7 +600,7 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 	}
 
 	/* Scalable Vector Extension state, if present */
-	if (IS_ENABLED(CONFIG_ARM64_SVE) && err == 0 && user->sve_offset) {
+	if (system_supports_sve() && err == 0 && user->sve_offset) {
 		struct sve_context __user *sve_ctx =
 			apply_user_offset(user, user->sve_offset);
 		err |= preserve_sve_context(sve_ctx);
-- 
2.1.4
