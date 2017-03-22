From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:51:00 +0000
Subject: [RFC PATCH v2 30/41] arm64/sve: Track vector length for each task
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-31-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for allowing each task to have its own independent
vector length, this patch adds a sve_vl field to thread_struct to
track it, and interrogates this instead of interrogating the
hardware when knowledge of the task's vector length is needed.

The hardware supported vector length is not known straight out of
boot, so init_task and other kernel tasks forked early may lack
this knowledge.

We only need this knowledge when in the context of a user task that
has SVE state (or that has just trapped while attempting to have
SVE state).  So, we can hook into exec() to set task vector length
if it wasn't known at boot/fork time, before the task enters
userspace.

There is no way to change sve_vl for a task yet, so all tasks still
execute with the hardware vector length.  Subsequent patches will
enable changing the vector length for tasks.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/processor.h |  1 +
 arch/arm64/kernel/fpsimd.c         | 39 +++++++++++++++++++++++++++++---------
 arch/arm64/kernel/ptrace.c         |  4 ++--
 arch/arm64/kernel/signal.c         | 15 +++++++++++----
 4 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 865c279..896e972 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -83,6 +83,7 @@ struct thread_struct {
 	unsigned long		tp2_value;
 #endif
 	struct fpsimd_state	fpsimd_state;
+	u16			sve_vl;		/* SVE vector length */
 	unsigned long		fault_address;	/* fault info */
 	unsigned long		fault_code;	/* ESR_EL1 value */
 	struct debug_info	debug;		/* debugging */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 4102d13..d3f89ac6 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -97,6 +97,9 @@ static DEFINE_PER_CPU(struct fpsimd_state *, fpsimd_last_state);
 
 #ifdef CONFIG_ARM64_SVE
 
+/* Maximum supported vector length across all CPUs (initially poisoned) */
+int sve_max_vl = -1;
+
 void *__sve_state(struct task_struct *task)
 {
 	return (char *)task + ALIGN(sizeof(*task), 16);
@@ -104,7 +107,7 @@ void *__sve_state(struct task_struct *task)
 
 static void *sve_pffr(struct task_struct *task)
 {
-	unsigned int vl = sve_get_vl();
+	unsigned int vl = task->thread.sve_vl;
 
 	BUG_ON(!sve_vl_valid(vl));
 	return (char *)__sve_state(task) +
@@ -123,7 +126,7 @@ static void __fpsimd_to_sve(struct task_struct *task, unsigned int vq)
 
 static void fpsimd_to_sve(struct task_struct *task)
 {
-	unsigned int vl = sve_get_vl();
+	unsigned int vl = task->thread.sve_vl;
 
 	if (!(elf_hwcap & HWCAP_SVE))
 		return;
@@ -144,7 +147,7 @@ static void __sve_to_fpsimd(struct task_struct *task, unsigned int vq)
 
 static void sve_to_fpsimd(struct task_struct *task)
 {
-	unsigned int vl = sve_get_vl();
+	unsigned int vl = task->thread.sve_vl;
 
 	if (!(elf_hwcap & HWCAP_SVE))
 		return;
@@ -187,7 +190,8 @@ void sve_sync_from_fpsimd_zeropad(struct task_struct *task)
 	if (!test_tsk_thread_flag(task, TIF_SVE))
 		return;
 
-	vl = sve_get_vl();
+	vl = task->thread.sve_vl;
+	BUG_ON(!sve_vl_valid(vl));
 	__sve_sync_from_fpsimd_zeropad(task, sve_vq_from_vl(vl));
 }
 
@@ -220,6 +224,7 @@ int sve_get_task_vl(struct task_struct *task)
 #else /* ! CONFIG_ARM64_SVE */
 
 /* Dummy declarations for usage protected with IS_ENABLED(CONFIG_ARM64_SVE): */
+extern int sve_max_vl;
 extern void *sve_pffr(struct task_struct *task);
 extern void fpsimd_to_sve(struct task_struct *task);
 
@@ -370,6 +375,18 @@ void fpsimd_flush_thread(void)
 		memset(__sve_state(current), 0,
 		       arch_task_struct_size -
 		       ((char *)__sve_state(current) - (char *)current));
+
+		/*
+		 * User tasks must have a valid vector length set, but tasks
+		 * forked early (e.g., init) may not have one yet.
+		 * By now, we will know what the hardware supports, so set the
+		 * task vector length if it doesn't have one:
+		 */
+		if (!current->thread.sve_vl) {
+			BUG_ON(!sve_vl_valid(sve_max_vl));
+
+			current->thread.sve_vl = sve_max_vl;
+		}
 	}
 
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
@@ -571,19 +588,23 @@ static inline void fpsimd_hotplug_init(void) { }
 
 void __init fpsimd_init_task_struct_size(void)
 {
+	unsigned int vq;
+
 	arch_task_struct_size = sizeof(struct task_struct);
 
 	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
 	    ((read_cpuid(ID_AA64PFR0_EL1) >> ID_AA64PFR0_SVE_SHIFT)
 	     & 0xf) == 1) {
-		unsigned int vl = sve_get_vl();
+		/* FIXME: This should be the minimum across all CPUs */
+		sve_max_vl = sve_get_vl();
 
-		BUG_ON(!sve_vl_valid(vl));
-		arch_task_struct_size = ALIGN(sizeof(struct task_struct), 16) +
-			ALIGN(SVE_SIG_REGS_SIZE(sve_vq_from_vl(vl)), 16);
+		BUG_ON(!sve_vl_valid(sve_max_vl));
+		vq = sve_vq_from_vl(sve_max_vl);
 
+		arch_task_struct_size = ALIGN(sizeof(struct task_struct), 16) +
+			ALIGN(SVE_SIG_REGS_SIZE(vq), 16);
 		pr_info("SVE: enabled with maximum %u bits per vector\n",
-			vl * 8);
+			sve_max_vl * 8);
 	}
 }
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 3e97e16..72b922a 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -746,7 +746,7 @@ static int sve_get(struct task_struct *target,
 	/* Header */
 	memset(&header, 0, sizeof(header));
 
-	header.vl = sve_get_vl();
+	header.vl = target->thread.sve_vl;
 
 	BUG_ON(!sve_vl_valid(header.vl));
 	vq = sve_vq_from_vl(header.vl);
@@ -845,7 +845,7 @@ static int sve_set(struct task_struct *target,
 	if (ret)
 		goto out;
 
-	if (header.vl != sve_get_vl())
+	if (header.vl != target->thread.sve_vl)
 		return -EINVAL;
 
 	BUG_ON(!sve_vl_valid(header.vl));
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 20bc312..45f0c2c 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -222,8 +222,11 @@ static int preserve_sve_context(struct sve_context __user *ctx)
 {
 	int err = 0;
 	u16 reserved[ARRAY_SIZE(ctx->__reserved)];
-	unsigned int vl = sve_get_vl();
-	unsigned int vq = sve_vq_from_vl(vl);
+	unsigned int vl = current->thread.sve_vl;
+	unsigned int vq;
+
+	BUG_ON(!sve_vl_valid(vl));
+	vq = sve_vq_from_vl(vl);
 
 	memset(reserved, 0, sizeof(reserved));
 
@@ -253,7 +256,7 @@ static int __restore_sve_fpsimd_context(struct user_ctxs *user,
 		__sve_state(current);
 	struct fpsimd_state fpsimd;
 
-	if (vl != sve_get_vl())
+	if (vl != current->thread.sve_vl)
 		return -EINVAL;
 
 	fpsimd_flush_task_state(current);
@@ -545,7 +548,11 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
 	}
 
 	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE)) {
-		unsigned int vq = sve_vq_from_vl(sve_get_vl());
+		unsigned int vl = current->thread.sve_vl;
+		unsigned int vq;
+
+		BUG_ON(!sve_vl_valid(vl));
+		vq = sve_vq_from_vl(vl);
 
 		BUG_ON(!(elf_hwcap & HWCAP_SVE));
 
-- 
2.1.4
