From: philipp.tomsich@theobroma-systems.com (Philipp Tomsich)
Date: Mon, 13 Apr 2015 21:44:20 +0200
Subject: [PATCH v4 10/24] arm64: introduce is_a32_task and is_a32_thread (for
 AArch32 compat)
In-Reply-To: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
Message-ID: <4e28d88b2ce1dc46b82fe8961df933ae8ec9447b.1428953303.git.philipp.tomsich@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

This patch introduces is_a32_compat_task and is_a32_thread so it is easier
to say this is a a32 specific thread or a generic compat thread/task.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 arch/arm64/include/asm/compat.h      | 31 ++++++++++++++++++++++++++++---
 arch/arm64/include/asm/elf.h         |  2 +-
 arch/arm64/include/asm/memory.h      |  2 +-
 arch/arm64/include/asm/processor.h   |  2 +-
 arch/arm64/include/asm/thread_info.h |  2 +-
 arch/arm64/kernel/hw_breakpoint.c    |  6 +++---
 arch/arm64/kernel/process.c          |  6 +++---
 arch/arm64/kernel/ptrace.c           |  8 ++++----
 arch/arm64/kernel/signal.c           |  4 ++--
 arch/arm64/kernel/traps.c            |  2 +-
 10 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 7fbed69..3a2976d 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -299,15 +299,25 @@ struct compat_shmid64_ds {
 	compat_ulong_t __unused5;
 };
 
-static inline int is_compat_task(void)
+#ifdef CONFIG_AARCH32_EL0
+static inline int is_a32_compat_task(void)
 {
 	return test_thread_flag(TIF_32BIT);
 }
-
-static inline int is_compat_thread(struct thread_info *thread)
+static inline int is_a32_compat_thread(struct thread_info *thread)
 {
 	return test_ti_thread_flag(thread, TIF_32BIT);
 }
+#else
+static inline int is_a32_compat_task(void)
+{
+	return 0;
+}
+static inline int is_a32_compat_thread(struct thread_info *thread)
+{
+	return 0;
+}
+#endif
 
 #else /* !CONFIG_COMPAT */
 
@@ -316,6 +326,21 @@ static inline int is_compat_thread(struct thread_info *thread)
 	return 0;
 }
 
+static inline int is_a32_compat_task(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_COMPAT */
+
+static inline int is_compat_task(void)
+{
+	return is_a32_compat_task();
+}
+
+static inline int is_compat_thread(struct thread_info *thread)
+{
+	return is_a32_compat_thread(thread);
+}
 #endif /* __KERNEL__ */
 #endif /* __ASM_COMPAT_H */
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index b73c2e2..4e565dd 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -150,7 +150,7 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 /* 1GB of VA */
 #ifdef CONFIG_COMPAT
-#define STACK_RND_MASK			(test_thread_flag(TIF_32BIT) ? \
+#define STACK_RND_MASK			(is_compat_task() ? \
 						0x7ff >> (PAGE_SHIFT - 12) : \
 						0x3ffff >> (PAGE_SHIFT - 12))
 #else
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index f800d45..960d059 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -58,7 +58,7 @@
 
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32		UL(0x100000000)
-#define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
+#define TASK_SIZE		(is_compat_task() ?		\
 				TASK_SIZE_32 : TASK_SIZE_64)
 #define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 20e9591..ea80e86 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -39,7 +39,7 @@
 #define STACK_TOP_MAX		TASK_SIZE_64
 #ifdef CONFIG_COMPAT
 #define AARCH32_VECTORS_BASE	0xffff0000
-#define STACK_TOP		(test_thread_flag(TIF_32BIT) ? \
+#define STACK_TOP		(is_compat_task() ? \
 				AARCH32_VECTORS_BASE : STACK_TOP_MAX)
 #else
 #define STACK_TOP		STACK_TOP_MAX
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 702e1e6..75f8d56 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -113,7 +113,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
 #define TIF_SINGLESTEP		21
-#define TIF_32BIT		22	/* 32bit process */
+#define TIF_32BIT		22	/* AARCH32 process */
 #define TIF_SWITCH_MM		23	/* deferred switch_mm */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 98bbe06..3fcfaa5 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -433,7 +433,7 @@ static int arch_build_bp_info(struct perf_event *bp)
 	 * Watchpoints can be of length 1, 2, 4 or 8 bytes.
 	 */
 	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
-		if (is_compat_task()) {
+		if (is_a32_compat_task()) {
 			if (info->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
 			    info->ctrl.len != ARM_BREAKPOINT_LEN_4)
 				return -EINVAL;
@@ -490,7 +490,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * AArch32 tasks expect some simple alignment fixups, so emulate
 	 * that here.
 	 */
-	if (is_compat_task()) {
+	if (is_a32_compat_task()) {
 		if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
 			alignment_mask = 0x7;
 		else
@@ -677,7 +677,7 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
 
 		info = counter_arch_bp(wp);
 		/* AArch32 watchpoints are either 4 or 8 bytes aligned. */
-		if (is_compat_task()) {
+		if (is_a32_compat_task()) {
 			if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
 				alignment_mask = 0x7;
 			else
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index c6b1f3b..84e62ef 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -261,7 +261,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	if (likely(!(p->flags & PF_KTHREAD))) {
 		*childregs = *current_pt_regs();
 		childregs->regs[0] = 0;
-		if (is_compat_thread(task_thread_info(p))) {
+		if (is_a32_compat_thread(task_thread_info(p))) {
 			if (stack_start)
 				childregs->compat_sp = stack_start;
 		} else {
@@ -302,12 +302,12 @@ static void tls_thread_switch(struct task_struct *next)
 {
 	unsigned long tpidr, tpidrro;
 
-	if (!is_compat_task()) {
+	if (!is_a32_compat_task()) {
 		asm("mrs %0, tpidr_el0" : "=r" (tpidr));
 		current->thread.tp_value = tpidr;
 	}
 
-	if (is_compat_thread(task_thread_info(next))) {
+	if (is_a32_compat_thread(task_thread_info(next))) {
 		tpidr = 0;
 		tpidrro = next->thread.tp_value;
 	} else {
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index cac913e..75f313a 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -79,7 +79,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 #ifdef CONFIG_AARCH32_EL0
 	int i;
 
-	if (!is_compat_task())
+	if (!is_a32_compat_task())
 		goto send_sig;
 
 	for (i = 0; i < ARM_MAX_BRP; ++i) {
@@ -1116,7 +1116,7 @@ long compat_a32_arch_ptrace(struct task_struct *child, compat_long_t request,
 long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
-	if (is_compat_task())
+	if (is_a32_compat_task())
 		return compat_a32_arch_ptrace(child, request, caddr, cdata);
 	return compat_ptrace_request(child, request, caddr, cdata);
 }
@@ -1126,7 +1126,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
 #ifdef CONFIG_AARCH32_EL0
-	if (is_compat_thread(task_thread_info(task)))
+	if (is_a32_compat_thread(task_thread_info(task)))
 		return &user_aarch32_view;
 #endif
 	return &user_aarch64_view;
@@ -1153,7 +1153,7 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 	 * A scratch register (ip(r12) on AArch32, x7 on AArch64) is
 	 * used to denote syscall entry/exit:
 	 */
-	regno = (is_compat_task() ? 12 : 7);
+	regno = (is_a32_compat_task() ? 12 : 7);
 	saved_reg = regs->regs[regno];
 	regs->regs[regno] = dir;
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index eed18b6..b91e6e1 100644
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
@@ -302,7 +302,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	/*
 	 * Set up the stack frame
 	 */
-	if (is_compat_task()) {
+	if (is_a32_compat_task()) {
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
 			ret = compat_setup_rt_frame(usig, ksig, oldset, regs);
 		else
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 848126d..4396d5c 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -356,7 +356,7 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
 {
 #ifdef CONFIG_AARCH32_EL0
 	long ret;
-	if (is_compat_task()) {
+	if (is_a32_compat_task()) {
 		ret = compat_arm_syscall(regs);
 		if (ret != -ENOSYS)
 			return ret;
-- 
1.9.1
