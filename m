From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 30 Sep 2015 01:14:07 +0300
Subject: [PATCH v5 10/23] arm64: introduce is_a32_task and is_a32_thread (for
 AArch32 compat)
In-Reply-To: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1443564860-31208-11-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

This patch introduces is_a32_compat_task and is_a32_thread so it is
easier
to say this is a a32 specific thread or a generic compat thread/task.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

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
index f40c51b..9ecbaf2 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -149,7 +149,7 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 /* 1GB of VA */
 #ifdef CONFIG_COMPAT
-#define STACK_RND_MASK			(test_thread_flag(TIF_32BIT) ? \
+#define STACK_RND_MASK			(is_compat_task() ? \
 						0x7ff >> (PAGE_SHIFT - 12) : \
 						0x3ffff >> (PAGE_SHIFT - 12))
 #else
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 6b4c3ad..337f8e1 100644
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
index 98f3235..f1bba0c 100644
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
index dcd06d1..7d03565 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -110,7 +110,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
 #define TIF_SINGLESTEP		21
-#define TIF_32BIT		22	/* 32bit process */
+#define TIF_32BIT		22	/* AARCH32 process */
 #define TIF_SWITCH_MM		23	/* deferred switch_mm */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index bba85c8..917f6e1 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -420,7 +420,7 @@ static int arch_build_bp_info(struct perf_event *bp)
 	 * Watchpoints can be of length 1, 2, 4 or 8 bytes.
 	 */
 	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
-		if (is_compat_task()) {
+		if (is_a32_compat_task()) {
 			if (info->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
 			    info->ctrl.len != ARM_BREAKPOINT_LEN_4)
 				return -EINVAL;
@@ -477,7 +477,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * AArch32 tasks expect some simple alignment fixups, so emulate
 	 * that here.
 	 */
-	if (is_compat_task()) {
+	if (is_a32_compat_task()) {
 		if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
 			alignment_mask = 0x7;
 		else
@@ -664,7 +664,7 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
 
 		info = counter_arch_bp(wp);
 		/* AArch32 watchpoints are either 4 or 8 bytes aligned. */
-		if (is_compat_task()) {
+		if (is_a32_compat_task()) {
 			if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
 				alignment_mask = 0x7;
 			else
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 223b093..a6b0251 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -259,7 +259,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		asm("mrs %0, tpidr_el0" : "=r" (*task_user_tls(p)));
 
 		if (stack_start) {
-			if (is_compat_thread(task_thread_info(p)))
+			if (is_a32_compat_thread(task_thread_info(p)))
 				childregs->compat_sp = stack_start;
 			/* 16-byte aligned stack mandatory on AArch64 */
 			else if (stack_start & 15)
@@ -296,7 +296,7 @@ static void tls_thread_switch(struct task_struct *next)
 	*task_user_tls(current) = tpidr;
 
 	tpidr = *task_user_tls(next);
-	tpidrro = is_compat_thread(task_thread_info(next)) ?
+	tpidrro = is_a32_compat_thread(task_thread_info(next)) ?
 		  next->thread.tp_value : 0;
 
 	asm(
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 04b4972..8cd1eb7 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -79,7 +79,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 #ifdef CONFIG_AARCH32_EL0
 	int i;
 
-	if (!is_compat_task())
+	if (!is_a32_compat_task())
 		goto send_sig;
 
 	for (i = 0; i < ARM_MAX_BRP; ++i) {
@@ -1198,7 +1198,7 @@ long compat_a32_arch_ptrace(struct task_struct *child, compat_long_t request,
 long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
-	if (is_compat_task())
+	if (is_a32_compat_task())
 		return compat_a32_arch_ptrace(child, request, caddr, cdata);
 	return compat_ptrace_request(child, request, caddr, cdata);
 }
@@ -1214,9 +1214,9 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
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
@@ -1243,7 +1243,7 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 	 * A scratch register (ip(r12) on AArch32, x7 on AArch64) is
 	 * used to denote syscall entry/exit:
 	 */
-	regno = (is_compat_task() ? 12 : 7);
+	regno = (is_a32_compat_task() ? 12 : 7);
 	saved_reg = regs->regs[regno];
 	regs->regs[regno] = dir;
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 964a2a4..2e00531 100644
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
index 9ce9894..bc973d0 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -365,7 +365,7 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
 {
 #ifdef CONFIG_AARCH32_EL0
 	long ret;
-	if (is_compat_task()) {
+	if (is_a32_compat_task()) {
 		ret = compat_arm_syscall(regs);
 		if (ret != -ENOSYS)
 			return ret;
-- 
2.1.4
