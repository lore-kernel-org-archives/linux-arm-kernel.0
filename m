From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 19 Jun 2017 18:49:52 +0300
Subject: [PATCH 09/20] arm64: introduce is_a32_task and is_a32_thread (for
 AArch32 compat)
In-Reply-To: <20170619155003.13218-1-ynorov@caviumnetworks.com>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
Message-ID: <20170619155003.13218-10-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on patch of Andrew Pinski.

This patch introduces is_a32_compat_task and is_a32_thread so it is
easier to say this is a a32 specific thread or a generic compat thread/task.
Corresponding functions are located in <asm/is_compat.h> to avoid mess in
headers.

Some files include both <linux/compat.h> and <asm/compat.h>,
and this is wrong because <linux/compat.h> has <asm/compat.h> already
included. It was fixed too.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
---
 arch/arm64/include/asm/compat.h      | 19 ++---------
 arch/arm64/include/asm/elf.h         | 10 +++---
 arch/arm64/include/asm/ftrace.h      |  2 +-
 arch/arm64/include/asm/is_compat.h   | 64 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/memory.h      |  5 +--
 arch/arm64/include/asm/processor.h   |  5 +--
 arch/arm64/include/asm/syscall.h     |  2 +-
 arch/arm64/include/asm/thread_info.h |  2 +-
 arch/arm64/kernel/hw_breakpoint.c    |  8 ++---
 arch/arm64/kernel/perf_regs.c        |  2 +-
 arch/arm64/kernel/process.c          |  7 ++--
 arch/arm64/kernel/ptrace.c           | 11 +++----
 arch/arm64/kernel/signal.c           |  4 +--
 arch/arm64/kernel/traps.c            |  3 +-
 arch/arm64/mm/mmap.c                 |  2 +-
 15 files changed, 98 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm64/include/asm/is_compat.h

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index e39d487bf724..463533b1ae32 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -25,6 +25,8 @@
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 
+#include <asm/is_compat.h>
+
 #define COMPAT_USER_HZ		100
 #ifdef __AARCH64EB__
 #define COMPAT_UTS_MACHINE	"armv8b\0\0"
@@ -299,23 +301,6 @@ struct compat_shmid64_ds {
 	compat_ulong_t __unused5;
 };
 
-static inline int is_compat_task(void)
-{
-	return test_thread_flag(TIF_32BIT);
-}
-
-static inline int is_compat_thread(struct thread_info *thread)
-{
-	return test_ti_thread_flag(thread, TIF_32BIT);
-}
-
-#else /* !CONFIG_COMPAT */
-
-static inline int is_compat_thread(struct thread_info *thread)
-{
-	return 0;
-}
-
 #endif /* CONFIG_COMPAT */
 #endif /* __KERNEL__ */
 #endif /* __ASM_COMPAT_H */
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index ac3fb7441510..6a37b6facc69 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -16,6 +16,10 @@
 #ifndef __ASM_ELF_H
 #define __ASM_ELF_H
 
+#ifndef __ASSEMBLY__
+#include <linux/compat.h>
+#endif
+
 #include <asm/hwcap.h>
 
 /*
@@ -158,13 +162,9 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
 
 /* 1GB of VA */
-#ifdef CONFIG_COMPAT
-#define STACK_RND_MASK			(test_thread_flag(TIF_32BIT) ? \
+#define STACK_RND_MASK			(is_compat_task() ? \
 						0x7ff >> (PAGE_SHIFT - 12) : \
 						0x3ffff >> (PAGE_SHIFT - 12))
-#else
-#define STACK_RND_MASK			(0x3ffff >> (PAGE_SHIFT - 12))
-#endif
 
 #ifdef __AARCH64EB__
 #define COMPAT_ELF_PLATFORM		("v8b")
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index caa955f10e19..0feb28ad10dd 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -54,7 +54,7 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 #define ARCH_TRACE_IGNORE_COMPAT_SYSCALLS
 static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
 {
-	return is_compat_task();
+	return is_a32_compat_task();
 }
 #endif /* ifndef __ASSEMBLY__ */
 
diff --git a/arch/arm64/include/asm/is_compat.h b/arch/arm64/include/asm/is_compat.h
new file mode 100644
index 000000000000..8dba5caaf5d1
--- /dev/null
+++ b/arch/arm64/include/asm/is_compat.h
@@ -0,0 +1,64 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ASM_IS_COMPAT_H
+#define __ASM_IS_COMPAT_H
+#ifndef __ASSEMBLY__
+
+#include <linux/thread_bits.h>
+
+#ifdef CONFIG_AARCH32_EL0
+
+static inline int is_a32_compat_task(void)
+{
+	return test_thread_flag(TIF_32BIT);
+}
+
+static inline int is_a32_compat_thread(struct thread_info *thread)
+{
+	return test_ti_thread_flag(thread, TIF_32BIT);
+}
+
+#else
+
+static inline int is_a32_compat_task(void)
+
+{
+	return 0;
+}
+
+static inline int is_a32_compat_thread(struct thread_info *thread)
+{
+	return 0;
+}
+
+#endif /* CONFIG_AARCH32_EL0 */
+
+#ifdef CONFIG_COMPAT
+
+static inline int is_compat_task(void)
+{
+	return is_a32_compat_task();
+}
+
+#endif /* CONFIG_COMPAT */
+
+static inline int is_compat_thread(struct thread_info *thread)
+{
+	return is_a32_compat_thread(thread);
+}
+
+
+#endif /* !__ASSEMBLY__ */
+#endif /* __ASM_IS_COMPAT_H */
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 32f82723338a..9b1835ca808f 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -26,6 +26,7 @@
 #include <linux/types.h>
 #include <asm/bug.h>
 #include <asm/sizes.h>
+#include <asm/is_compat.h>
 
 /*
  * Allow for constants defined here to be used from assembly code
@@ -78,9 +79,9 @@
 
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32		UL(0x100000000)
-#define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
+#define TASK_SIZE		(is_compat_task() ?		\
 				TASK_SIZE_32 : TASK_SIZE_64)
-#define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
+#define TASK_SIZE_OF(tsk)	(is_compat_thread(tsk) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
 #else
 #define TASK_SIZE		TASK_SIZE_64
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 2bbbd33549c0..0136a1af677d 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -30,6 +30,7 @@
 #include <linux/string.h>
 
 #include <asm/alternative.h>
+#include <asm/is_compat.h>
 #include <asm/fpsimd.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/lse.h>
@@ -40,7 +41,7 @@
 #define STACK_TOP_MAX		TASK_SIZE_64
 #ifdef CONFIG_COMPAT
 #define AARCH32_VECTORS_BASE	0xffff0000
-#define STACK_TOP		(test_thread_flag(TIF_32BIT) ? \
+#define STACK_TOP		(is_compat_task() ? \
 				AARCH32_VECTORS_BASE : STACK_TOP_MAX)
 #else
 #define STACK_TOP		STACK_TOP_MAX
@@ -94,7 +95,7 @@ struct thread_struct {
 #define task_user_tls(t)						\
 ({									\
 	unsigned long *__tls;						\
-	if (is_compat_thread(task_thread_info(t)))			\
+	if (is_a32_compat_thread(task_thread_info(t)))			\
 		__tls = &(t)->thread.tp2_value;				\
 	else								\
 		__tls = &(t)->thread.tp_value;				\
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 709a574468f0..ce09641f888d 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -113,7 +113,7 @@ static inline void syscall_set_arguments(struct task_struct *task,
  */
 static inline int syscall_get_arch(void)
 {
-	if (is_compat_task())
+	if (is_a32_compat_task())
 		return AUDIT_ARCH_ARM;
 
 	return AUDIT_ARCH_AARCH64;
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 46c3b93cf865..a7ffea24d94d 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -95,7 +95,7 @@ struct thread_info {
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
 #define TIF_SINGLESTEP		21
-#define TIF_32BIT		22	/* 32bit process */
+#define TIF_32BIT		22	/* AARCH32 process */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 749f81779420..49b9a29915c0 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -169,7 +169,7 @@ enum hw_breakpoint_ops {
 	HW_BREAKPOINT_RESTORE
 };
 
-static int is_compat_bp(struct perf_event *bp)
+static int is_a32_compat_bp(struct perf_event *bp)
 {
 	struct task_struct *tsk = bp->hw.target;
 
@@ -180,7 +180,7 @@ static int is_compat_bp(struct perf_event *bp)
 	 * deprecated behaviour if we use unaligned watchpoints in
 	 * AArch64 state.
 	 */
-	return tsk && is_compat_thread(task_thread_info(tsk));
+	return tsk && is_a32_compat_thread(task_thread_info(tsk));
 }
 
 /**
@@ -480,7 +480,7 @@ static int arch_build_bp_info(struct perf_event *bp)
 	 * Watchpoints can be of length 1, 2, 4 or 8 bytes.
 	 */
 	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
-		if (is_compat_bp(bp)) {
+		if (is_a32_compat_bp(bp)) {
 			if (info->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
 			    info->ctrl.len != ARM_BREAKPOINT_LEN_4)
 				return -EINVAL;
@@ -537,7 +537,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * AArch32 tasks expect some simple alignment fixups, so emulate
 	 * that here.
 	 */
-	if (is_compat_bp(bp)) {
+	if (is_a32_compat_bp(bp)) {
 		if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
 			alignment_mask = 0x7;
 		else
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index bd1b74c2436f..443e42001108 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -46,7 +46,7 @@ int perf_reg_validate(u64 mask)
 
 u64 perf_reg_abi(struct task_struct *task)
 {
-	if (is_compat_thread(task_thread_info(task)))
+	if (is_a32_compat_thread(task_thread_info(task)))
 		return PERF_SAMPLE_REGS_ABI_32;
 	else
 		return PERF_SAMPLE_REGS_ABI_64;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index af1ea258c212..0fbbe7c96f69 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -51,7 +51,6 @@
 #include <linux/percpu.h>
 
 #include <asm/alternative.h>
-#include <asm/compat.h>
 #include <asm/cacheflush.h>
 #include <asm/exec.h>
 #include <asm/fpsimd.h>
@@ -217,7 +216,7 @@ static void tls_thread_flush(void)
 {
 	write_sysreg(0, tpidr_el0);
 
-	if (is_compat_task()) {
+	if (is_a32_compat_task()) {
 		current->thread.tp_value = 0;
 
 		/*
@@ -269,7 +268,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		*task_user_tls(p) = read_sysreg(tpidr_el0);
 
 		if (stack_start) {
-			if (is_compat_thread(task_thread_info(p)))
+			if (is_a32_compat_thread(task_thread_info(p)))
 				childregs->compat_sp = stack_start;
 			else
 				childregs->sp = stack_start;
@@ -306,7 +305,7 @@ static void tls_thread_switch(struct task_struct *next)
 	*task_user_tls(current) = tpidr;
 
 	tpidr = *task_user_tls(next);
-	tpidrro = is_compat_thread(task_thread_info(next)) ?
+	tpidrro = is_a32_compat_thread(task_thread_info(next)) ?
 		  next->thread.tp_value : 0;
 
 	write_sysreg(tpidr, tpidr_el0);
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index da908f9a1e05..e2b7c040bf84 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -39,7 +39,6 @@
 #include <linux/tracehook.h>
 #include <linux/elf.h>
 
-#include <asm/compat.h>
 #include <asm/debug-monitors.h>
 #include <asm/pgtable.h>
 #include <asm/syscall.h>
@@ -187,7 +186,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 #ifdef CONFIG_AARCH32_EL0
 	int i;
 
-	if (!is_compat_task())
+	if (!is_a32_compat_task())
 		goto send_sig;
 
 	for (i = 0; i < ARM_MAX_BRP; ++i) {
@@ -1312,9 +1311,9 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 	 * 32-bit children use an extended user_aarch32_ptrace_view to allow
 	 * access to the TLS register.
 	 */
-	if (is_compat_task())
+	if (is_a32_compat_task())
 		return &user_aarch32_view;
-	else if (is_compat_thread(task_thread_info(task)))
+	else if (is_a32_compat_thread(task_thread_info(task)))
 		return &user_aarch32_ptrace_view;
 #endif
 	return &user_aarch64_view;
@@ -1341,7 +1340,7 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 	 * A scratch register (ip(r12) on AArch32, x7 on AArch64) is
 	 * used to denote syscall entry/exit:
 	 */
-	regno = (is_compat_task() ? 12 : 7);
+	regno = (is_a32_compat_task() ? 12 : 7);
 	saved_reg = regs->regs[regno];
 	regs->regs[regno] = dir;
 
@@ -1452,7 +1451,7 @@ int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task)
 	if (!test_tsk_thread_flag(task, TIF_SINGLESTEP))
 		regs->pstate &= ~DBG_SPSR_SS;
 
-	if (is_compat_thread(task_thread_info(task)))
+	if (is_a32_compat_thread(task_thread_info(task)))
 		return valid_compat_regs(regs);
 	else
 		return valid_native_regs(regs);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index c7b6de62f9d3..5fa1b401c5d6 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -276,7 +276,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 
 static void setup_restart_syscall(struct pt_regs *regs)
 {
-	if (is_compat_task())
+	if (is_a32_compat_task())
 		compat_setup_restart_syscall(regs);
 	else
 		regs->regs[8] = __NR_restart_syscall;
@@ -295,7 +295,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	/*
 	 * Set up the stack frame
 	 */
-	if (is_compat_task()) {
+	if (is_a32_compat_task()) {
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
 			ret = compat_setup_rt_frame(usig, ksig, oldset, regs);
 		else
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 287a21ee39b3..d1e40129afe0 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/bug.h>
+#include <linux/compat.h>
 #include <linux/signal.h>
 #include <linux/personality.h>
 #include <linux/kallsyms.h>
@@ -578,7 +579,7 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
 {
 #ifdef CONFIG_AARCH32_EL0
 	long ret;
-	if (is_compat_task()) {
+	if (is_a32_compat_task()) {
 		ret = compat_arm_syscall(regs);
 		if (ret != -ENOSYS)
 			return ret;
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index adc208c2ae9c..57b25e7770dc 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -54,7 +54,7 @@ unsigned long arch_mmap_rnd(void)
 	unsigned long rnd;
 
 #ifdef CONFIG_COMPAT
-	if (test_thread_flag(TIF_32BIT))
+	if (is_compat_task())
 		rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
 	else
 #endif
-- 
2.11.0
