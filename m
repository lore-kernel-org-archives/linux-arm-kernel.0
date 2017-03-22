From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:51:10 +0000
Subject: [RFC PATCH v2 40/41] arm64/sve: Allocate task SVE context storage
 dynamically
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-41-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, space is allocated at the end of task_struct to store a
task's SVE registers.

Because the size of task_struct is common to all tasks and must be
fixed early during boot, it is necessary to reserve space for the
maximum possible SVE state size for every task, irrespective of
which tasks use SVE or what vector length they are using.

The need to commit to a particular size for the SVE state early
during boot also makes it more difficult to deal sensibly with
systems where the maximum SVE vector length supported by the
hardware may differ between CPUs.

In order to address these issues, this patch allocates each task's
SVE register storage on demand from the kernel heap instead of
reserving space up-front in task_struct.  This means that there is
no need to allocate this storage for tasks that do not use SVE, and
no need to allocate more storage than a task needs for its
configured SVE vector length.

This has particular implications for:

fork/clone:

Immediately after task_struct is copied, the two tasks have the
same sve_state pointer, which would causes the tasks' SVE state to
alias, which would be bad.

To reslove this, the child task's sve_state is NULLed: this is not
a leak, because the parent still has its pointer.  The child's SVE
state will be allocated on first use, with zeroed contents.  This
is consistent with the effect of discarding SVE state (which is
already done for all syscalls).

exec:

Since exec starts the execution of a new binary, there's a fair
chance that SVE won't be used by the task subsequently.  Even if
the new task does use SVE, we want to ensure that its SVE register
contents start off zeroed.

These are achieved by freeing the task's sve_state (if any) at
exec.  If subsequently reused, the state will get reallocated,
filled with zeros.  Freeing the state at exec ensures that programs
that never use SVE will not have sve_state allocated for any of
their threads.

vector length change:

Whenever a task changes its vector length, sve_state is freed.  On
next use (by any mechanism) the state will then reallocated to the
appropriate new size.  This ensures correct sizing.  Enforcing this
here ensures that when sve_state is non-NULL then it is always the
correct size for the task's vector length.  This is widely assumed
elsewhere.

Strictly speaking, this behaviour is more destructive than the SVE
architecture specifies for the analogous situation of EL1 changing
its vector length by writing ZCR_EL1.LEN.  However, the task is
either making a prctl syscall here (in which case it is legitimate
to discard and/or zero the SVE state) or is being manipulated by a
debugger through ptrace.  In the latter case the debugger is
unlikely to benefit much from "architecturally authentic"
behaviour: the debugger can get the that effect by constructing the
new SVE register explicitly if needed.

This design avoids the kernel needing to contain code to convert
SVE registers from one vector length to another -- something for
which we have no other use at present.

ptrace, rt_sigreturn etc.:

Other interfaces that allow userspace to update or replace the SVE
registers, such as ptrace and rt_sigreturn, now allocate sve_state
for the task as needed, if it is not allocated beforehand.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/Kconfig                 |   1 -
 arch/arm64/include/asm/fpsimd.h    |  12 ++++
 arch/arm64/include/asm/processor.h |   1 +
 arch/arm64/kernel/fpsimd.c         | 112 ++++++++++++++++++++-----------------
 arch/arm64/kernel/process.c        |   4 ++
 arch/arm64/kernel/ptrace.c         |  15 ++---
 arch/arm64/kernel/setup.c          |   2 -
 arch/arm64/kernel/signal.c         |  12 ++--
 8 files changed, 88 insertions(+), 71 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 593d2db..10295b6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -23,7 +23,6 @@ config ARM64
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
-	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 4a50139..24c4109 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -21,6 +21,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/stddef.h>
+
 /*
  * FP/SIMD storage area has:
  *  - FPSR and FPCR
@@ -107,6 +109,12 @@ extern void *__sve_state(struct task_struct *task);
 
 extern int sve_max_vl;
 
+extern size_t sve_state_size(struct task_struct const *task);
+
+extern void sve_alloc(struct task_struct *task);
+extern void fpsimd_release_thread(struct task_struct *task);
+extern void fpsimd_dup_sve(struct task_struct *dst,
+			   struct task_struct const *src);
 extern void fpsimd_sync_to_sve(struct task_struct *task);
 extern void sve_sync_to_fpsimd(struct task_struct *task);
 extern void sve_sync_from_fpsimd_zeropad(struct task_struct *task);
@@ -122,6 +130,10 @@ extern void __init sve_setup(void);
 
 #else /* ! CONFIG_ARM64_SVE */
 
+static void __maybe_unused sve_alloc(struct task_struct *task) { }
+static void __maybe_unused fpsimd_release_thread(struct task_struct *task) { }
+static void __maybe_unused fpsimd_dup_sve(struct task_struct *dst,
+					  struct task_struct const *src) { }
 static void __maybe_unused sve_sync_to_fpsimd(struct task_struct *task) { }
 static void __maybe_unused sve_sync_from_fpsimd_zeropad(
 	struct task_struct *task) { }
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 424fa5d..9371680 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -84,6 +84,7 @@ struct thread_struct {
 	unsigned long		tp2_value;
 #endif
 	struct fpsimd_state	fpsimd_state;
+	void			*sve_state;	/* SVE registers, if any */
 	u16			sve_vl;		/* SVE vector length */
 	u16			sve_vl_onexec;	/* SVE vl after next exec */
 	u16			sve_flags;	/* SVE related flags */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 2b9def0..c2f4d59 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -107,36 +107,48 @@ int sve_max_vl = -1;
 /* Default VL for tasks that don't set it explicitly: */
 int sve_default_vl = -1;
 
-void *__sve_state(struct task_struct *task)
+size_t sve_state_size(struct task_struct const *task)
 {
-	return (char *)task + ALIGN(sizeof(*task), 16);
+	unsigned int vl = task->thread.sve_vl;
+
+	BUG_ON(!sve_vl_valid(vl));
+	return SVE_SIG_REGS_SIZE(sve_vq_from_vl(vl));
 }
 
-static void clear_sve_regs(struct task_struct *task)
+static void sve_free(struct task_struct *task)
 {
-	BUG_ON(task == current && preemptible());
+	kfree(task->thread.sve_state);
+	task->thread.sve_state = NULL;
+}
 
-	BUG_ON((char *)__sve_state(task) < (char *)task);
-	BUG_ON(arch_task_struct_size <
-	       ((char *)__sve_state(task) - (char *)task));
+void sve_alloc(struct task_struct *task)
+{
+	if (task->thread.sve_state)
+		return;
+
+	/* This is a small allocation (maximum ~8KB) and Should Not Fail. */
+	task->thread.sve_state =
+		kzalloc(sve_state_size(task), GFP_KERNEL);
 
-	memset(__sve_state(task), 0,
-	       arch_task_struct_size -
-			((char *)__sve_state(task) - (char *)task));
+	/*
+	 * If future SVE revisions can have larger vectors though,
+	 * this may cease to be true:
+	 */
+	BUG_ON(!task->thread.sve_state);
 }
 
 static void *sve_pffr(struct task_struct *task)
 {
 	unsigned int vl = task->thread.sve_vl;
 
-	BUG_ON(!sve_vl_valid(vl));
-	return (char *)__sve_state(task) +
+	BUG_ON(!sve_vl_valid(vl) || !task->thread.sve_state);
+	return (char *)task->thread.sve_state +
 		(SVE_SIG_FFR_OFFSET(sve_vq_from_vl(vl)) - SVE_SIG_REGS_OFFSET);
 }
 
 static void __fpsimd_to_sve(struct task_struct *task, unsigned int vq)
 {
-	struct sve_struct fpsimd_sve_state(vq) *sst = __sve_state(task);
+	struct sve_struct fpsimd_sve_state(vq) *sst = task->thread.sve_state;
 	struct fpsimd_state *fst = &task->thread.fpsimd_state;
 	unsigned int i;
 
@@ -157,7 +169,7 @@ static void fpsimd_to_sve(struct task_struct *task)
 
 static void __sve_to_fpsimd(struct task_struct *task, unsigned int vq)
 {
-	struct sve_struct fpsimd_sve_state(vq) *sst = __sve_state(task);
+	struct sve_struct fpsimd_sve_state(vq) *sst = task->thread.sve_state;
 	struct fpsimd_state *fst = &task->thread.fpsimd_state;
 	unsigned int i;
 
@@ -191,7 +203,7 @@ void sve_sync_to_fpsimd(struct task_struct *task)
 static void __sve_sync_from_fpsimd_zeropad(struct task_struct *task,
 					   unsigned int vq)
 {
-	struct sve_struct fpsimd_sve_state(vq) *sst = __sve_state(task);
+	struct sve_struct fpsimd_sve_state(vq) *sst = task->thread.sve_state;
 	struct fpsimd_state *fst = &task->thread.fpsimd_state;
 	unsigned int i;
 
@@ -221,6 +233,7 @@ void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 
 	task_fpsimd_save(current);
 
+	sve_alloc(current);
 	fpsimd_to_sve(current);
 	if (test_and_set_thread_flag(TIF_SVE))
 		BUG(); /* We shouldn't trap if SVE was already enabled! */
@@ -228,6 +241,28 @@ void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 	task_fpsimd_load(current);
 }
 
+/*
+ * Handle SVE state across fork():
+ *
+ * dst and src must not end up with aliases of the same sve_state.
+ * Because a task cannot fork except in a syscall, we can discard SVE
+ * state for dst here: reallocation will be deferred until dst tries
+ * to use SVE.
+ */
+void fpsimd_dup_sve(struct task_struct *dst, struct task_struct const *src)
+{
+	BUG_ON(task_pt_regs(dst)->syscallno == ~0UL);
+
+	preempt_disable(); /* unnecessary? */
+
+	if (test_and_clear_tsk_thread_flag(dst, TIF_SVE)) {
+		sve_to_fpsimd(dst);
+		dst->thread.sve_state = NULL;
+	}
+
+	preempt_enable();
+}
+
 int sve_set_vector_length(struct task_struct *task,
 			  unsigned long vl, unsigned long flags)
 {
@@ -279,11 +314,10 @@ int sve_set_vector_length(struct task_struct *task,
 			sve_to_fpsimd(task);
 
 		/*
-		 * To avoid surprises, also zero out the SVE regs storage.
-		 * This means that the P-regs, FFR and high bits of Z-regs
-		 * will read as zero on next access:
+		 * Force reallocation of task SVE state to the correct size
+		 * on next use:
 		 */
-		clear_sve_regs(task);
+		sve_free(task);
 	}
 
 	task->thread.sve_vl = vl;
@@ -499,12 +533,17 @@ static int __init sve_procfs_init(void)
 static int __init sve_procfs_init(void) { return 0; }
 #endif /* ! CONFIG_PROC_FS && CONFIG_ARM64_SVE */
 
+void fpsimd_release_thread(struct task_struct *dead_task)
+{
+	sve_free(dead_task);
+}
+
 #else /* ! CONFIG_ARM64_SVE */
 
 /* Dummy declarations for usage protected with IS_ENABLED(CONFIG_ARM64_SVE): */
 extern int sve_max_vl;
 extern int sve_default_vl;
-extern void clear_sve_regs(struct task_struct *task);
+extern void sve_free(struct task_struct *task);
 extern void *sve_pffr(struct task_struct *task);
 extern void fpsimd_to_sve(struct task_struct *task);
 extern int __init sve_procfs_init(void);
@@ -651,7 +690,8 @@ void fpsimd_flush_thread(void)
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
 
 	if (system_supports_sve()) {
-		clear_sve_regs(current);
+		clear_thread_flag(TIF_SVE);
+		sve_free(current);
 
 		current->thread.sve_vl = current->thread.sve_vl_onexec ?
 			current->thread.sve_vl_onexec : sve_default_vl;
@@ -871,36 +911,6 @@ static inline void fpsimd_hotplug_init(void)
 static inline void fpsimd_hotplug_init(void) { }
 #endif
 
-void __init fpsimd_init_task_struct_size(void)
-{
-	unsigned int vq;
-
-	arch_task_struct_size = sizeof(struct task_struct);
-
-	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
-	    ((read_cpuid(ID_AA64PFR0_EL1) >> ID_AA64PFR0_SVE_SHIFT)
-	     & 0xf) == 1) {
-		/* FIXME: This should be the minimum across all CPUs */
-		sve_max_vl = sve_get_vl();
-		sve_default_vl = sve_max_vl;
-
-		/*
-		 * To avoid enlarging the signal frame by default, clamp to
-		 * 512 bits until/unless overridden by userspace:
-		 */
-		if (sve_default_vl > 512 / 8)
-			sve_default_vl = 512 / 8;
-
-		BUG_ON(!sve_vl_valid(sve_max_vl));
-		vq = sve_vq_from_vl(sve_max_vl);
-
-		arch_task_struct_size = ALIGN(sizeof(struct task_struct), 16) +
-			ALIGN(SVE_SIG_REGS_SIZE(vq), 16);
-		pr_info("SVE: enabled with maximum %u bits per vector\n",
-			sve_max_vl * 8);
-	}
-}
-
 /*
  * FP/SIMD support code initialisation.
  */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 717dd0f..01c51fd 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -240,6 +240,7 @@ void flush_thread(void)
 
 void release_thread(struct task_struct *dead_task)
 {
+	fpsimd_release_thread(dead_task);
 }
 
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
@@ -247,6 +248,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 	if (current->mm)
 		fpsimd_preserve_current_state();
 	memcpy(dst, src, arch_task_struct_size);
+
+	fpsimd_dup_sve(dst, src);
+
 	return 0;
 }
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index bbb8e38..a290352 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -782,13 +782,10 @@ static int sve_get(struct task_struct *target,
 	start = SVE_PT_SVE_OFFSET;
 	end = SVE_PT_SVE_FFR_OFFSET(vq) + SVE_PT_SVE_FFR_SIZE(vq);
 
-	BUG_ON((char *)__sve_state(target) < (char *)target);
 	BUG_ON(end < start);
-	BUG_ON(arch_task_struct_size < end - start);
-	BUG_ON((char *)__sve_state(target) - (char *)target >
-	       arch_task_struct_size - (end - start));
+	BUG_ON(end - start > sve_state_size(target));
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  __sve_state(target),
+				  target->thread.sve_state,
 				  start, end);
 	if (ret)
 		return ret;
@@ -875,6 +872,7 @@ static int sve_set(struct task_struct *target,
 
 	/* Otherwise: full SVE case */
 
+	sve_alloc(target);
 	fpsimd_sync_to_sve(target);
 	set_tsk_thread_flag(target, TIF_SVE);
 
@@ -883,13 +881,10 @@ static int sve_set(struct task_struct *target,
 	start = SVE_PT_SVE_OFFSET;
 	end = SVE_PT_SVE_FFR_OFFSET(vq) + SVE_PT_SVE_FFR_SIZE(vq);
 
-	BUG_ON((char *)__sve_state(target) < (char *)target);
 	BUG_ON(end < start);
-	BUG_ON(arch_task_struct_size < end - start);
-	BUG_ON((char *)__sve_state(target) - (char *)target >
-	       arch_task_struct_size - (end - start));
+	BUG_ON(end - start > sve_state_size(target));
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 __sve_state(target),
+				 target->thread.sve_state,
 				 start, end);
 	if (ret)
 		goto out;
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 1412a35..a9e052e 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -237,8 +237,6 @@ void __init setup_arch(char **cmdline_p)
 
 	sprintf(init_utsname()->machine, UTS_MACHINE);
 
-	fpsimd_init_task_struct_size();
-
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
 	init_mm.end_data   = (unsigned long) _edata;
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e3810e2..1c94b3e 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -241,8 +241,9 @@ static int preserve_sve_context(struct sve_context __user *ctx)
 	 * This assumes that the SVE state has already been saved to
 	 * the task struct by calling preserve_fpsimd_context().
 	 */
+	BUG_ON(SVE_SIG_REGS_SIZE(vq) != sve_state_size(current));
 	err |= copy_to_user((char __user *)ctx + SVE_SIG_REGS_OFFSET,
-			    __sve_state(current),
+			    current->thread.sve_state,
 			    SVE_SIG_REGS_SIZE(vq));
 
 	return err ? -EFAULT : 0;
@@ -252,8 +253,7 @@ static int __restore_sve_fpsimd_context(struct user_ctxs *user,
 					unsigned int vl, unsigned int vq)
 {
 	int err;
-	struct fpsimd_sve_state(vq) *task_sve_regs =
-		__sve_state(current);
+	struct fpsimd_sve_state(vq) *task_sve_regs = current->thread.sve_state;
 	struct fpsimd_state fpsimd;
 
 	if (vl != current->thread.sve_vl)
@@ -264,10 +264,8 @@ static int __restore_sve_fpsimd_context(struct user_ctxs *user,
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 	barrier();
 
-	BUG_ON(SVE_SIG_REGS_SIZE(vq) > sizeof(*task_sve_regs));
-	BUG_ON(round_up(SVE_SIG_REGS_SIZE(vq), 16) < sizeof(*task_sve_regs));
-	BUG_ON(SVE_SIG_FFR_OFFSET(vq) - SVE_SIG_REGS_OFFSET !=
-	       (char *)&task_sve_regs->ffr - (char *)task_sve_regs);
+	sve_alloc(current);
+	BUG_ON(SVE_SIG_REGS_SIZE(vq) != sve_state_size(current));
 	err = __copy_from_user(task_sve_regs,
 			       (char __user const *)user->sve +
 					SVE_SIG_REGS_OFFSET,
-- 
2.1.4
