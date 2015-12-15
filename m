From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 16 Dec 2015 00:42:33 +0300
Subject: [PATCH v6 07/20] arm64: introduce is_a32_task and is_a32_thread (for
 AArch32 compat)
In-Reply-To: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1450215766-14765-8-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on patch of Andrew Pinski.

This patch introduces is_a32_compat_task and is_a32_thread so it is
easier to say this is a a32 specific thread or a generic compat thread/task.
Corresponding functions are located in <asm/is_compat.h> to avoid mess in
headers.

Some files invlude both <linux/compat.h> and <asm/compat.h>,
and this is wrong because <linux/compat.h> has <asm/compat.h> already
included. It was fixed too.

Reviewed-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
---
 arch/arm64/include/asm/compat.h      | 19 ++---------
 arch/arm64/include/asm/elf.h         |  3 +-
 arch/arm64/include/asm/is_compat.h   | 62 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/memory.h      |  3 +-
 arch/arm64/include/asm/processor.h   |  5 +--
 arch/arm64/include/asm/thread_info.h |  2 +-
 arch/arm64/kernel/hw_breakpoint.c    |  6 ++--
 arch/arm64/kernel/perf_regs.c        |  2 +-
 arch/arm64/kernel/process.c          |  5 ++-
 arch/arm64/kernel/ptrace.c           | 11 +++----
 arch/arm64/kernel/signal.c           |  4 +--
 arch/arm64/kernel/traps.c            |  3 +-
 12 files changed, 87 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm64/include/asm/is_compat.h

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 7fbed69..8e40dec 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -25,6 +25,8 @@
 #include <linux/sched.h>
 #include <linux/ptrace.h>
 
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
index d255764..8786ca5 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -16,6 +16,7 @@
 #ifndef __ASM_ELF_H
 #define __ASM_ELF_H
 
+#include <asm/is_compat.h>
 #include <asm/hwcap.h>
 
 /*
@@ -149,7 +150,7 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 /* 1GB of VA */
 #ifdef CONFIG_COMPAT
-#define STACK_RND_MASK			(test_thread_flag(TIF_32BIT) ? \
+#define STACK_RND_MASK			(is_compat_task() ? \
 						0x7ff >> (PAGE_SHIFT - 12) : \
 						0x3ffff >> (PAGE_SHIFT - 12))
 #else
diff --git a/arch/arm64/include/asm/is_compat.h b/arch/arm64/include/asm/is_compat.h
new file mode 100644
index 0000000..476db90
--- /dev/null
+++ b/arch/arm64/include/asm/is_compat.h
@@ -0,0 +1,62 @@
+/*
+ * Copyright (C) 2015 Cavium Inc.
+ *
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
+#ifdef __KERNEL__
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
+#endif /* !__ASSEMBLY__ */
+#endif /* __KERNEL__ */
+#endif /* __ASM_IS_COMPAT_H */
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 6b4c3ad..ea4b10d 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -25,6 +25,7 @@
 #include <linux/const.h>
 #include <linux/types.h>
 #include <asm/sizes.h>
+#include <asm/is_compat.h>
 
 /*
  * Allow for constants defined here to be used from assembly code
@@ -58,7 +59,7 @@
 
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32		UL(0x100000000)
-#define TASK_SIZE		(test_thread_flag(TIF_32BIT) ? \
+#define TASK_SIZE		(is_compat_task() ?		\
 				TASK_SIZE_32 : TASK_SIZE_64)
 #define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk, TIF_32BIT) ? \
 				TASK_SIZE_32 : TASK_SIZE_64)
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index ff4abec..f1ba514 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -29,6 +29,7 @@
 
 #include <linux/string.h>
 
+#include <asm/is_compat.h>
 #include <asm/fpsimd.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/pgtable-hwdef.h>
@@ -39,7 +40,7 @@
 #define STACK_TOP_MAX		TASK_SIZE_64
 #ifdef CONFIG_COMPAT
 #define AARCH32_VECTORS_BASE	0xffff0000
-#define STACK_TOP		(test_thread_flag(TIF_32BIT) ? \
+#define STACK_TOP		(is_compat_task() ? \
 				AARCH32_VECTORS_BASE : STACK_TOP_MAX)
 #else
 #define STACK_TOP		STACK_TOP_MAX
@@ -92,7 +93,7 @@ struct thread_struct {
 #define task_user_tls(t)						\
 ({									\
 	unsigned long *__tls;						\
-	if (is_compat_thread(task_thread_info(t)))			\
+	if (is_a32_compat_thread(task_thread_info(t)))			\
 		__tls = &(t)->thread.tp2_value;				\
 	else								\
 		__tls = &(t)->thread.tp_value;				\
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
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 3f62b35..a79058f 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -45,7 +45,7 @@ int perf_reg_validate(u64 mask)
 
 u64 perf_reg_abi(struct task_struct *task)
 {
-	if (is_compat_thread(task_thread_info(task)))
+	if (is_a32_compat_thread(task_thread_info(task)))
 		return PERF_SAMPLE_REGS_ABI_32;
 	else
 		return PERF_SAMPLE_REGS_ABI_64;
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 223b093..e109f49 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -45,7 +45,6 @@
 #include <linux/personality.h>
 #include <linux/notifier.h>
 
-#include <asm/compat.h>
 #include <asm/cacheflush.h>
 #include <asm/fpsimd.h>
 #include <asm/mmu_context.h>
@@ -259,7 +258,7 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 		asm("mrs %0, tpidr_el0" : "=r" (*task_user_tls(p)));
 
 		if (stack_start) {
-			if (is_compat_thread(task_thread_info(p)))
+			if (is_a32_compat_thread(task_thread_info(p)))
 				childregs->compat_sp = stack_start;
 			/* 16-byte aligned stack mandatory on AArch64 */
 			else if (stack_start & 15)
@@ -296,7 +295,7 @@ static void tls_thread_switch(struct task_struct *next)
 	*task_user_tls(current) = tpidr;
 
 	tpidr = *task_user_tls(next);
-	tpidrro = is_compat_thread(task_thread_info(next)) ?
+	tpidrro = is_a32_compat_thread(task_thread_info(next)) ?
 		  next->thread.tp_value : 0;
 
 	asm(
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 2a39b5d..816b432 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -38,7 +38,6 @@
 #include <linux/tracehook.h>
 #include <linux/elf.h>
 
-#include <asm/compat.h>
 #include <asm/debug-monitors.h>
 #include <asm/pgtable.h>
 #include <asm/syscall.h>
@@ -79,7 +78,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 #ifdef CONFIG_AARCH32_EL0
 	int i;
 
-	if (!is_compat_task())
+	if (!is_a32_compat_task())
 		goto send_sig;
 
 	for (i = 0; i < ARM_MAX_BRP; ++i) {
@@ -1194,7 +1193,7 @@ long compat_a32_arch_ptrace(struct task_struct *child, compat_long_t request,
 long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
-	if (is_compat_task())
+	if (is_a32_compat_task())
 		return compat_a32_arch_ptrace(child, request, caddr, cdata);
 	return compat_ptrace_request(child, request, caddr, cdata);
 }
@@ -1210,9 +1209,9 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
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
@@ -1239,7 +1238,7 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 	 * A scratch register (ip(r12) on AArch32, x7 on AArch64) is
 	 * used to denote syscall entry/exit:
 	 */
-	regno = (is_compat_task() ? 12 : 7);
+	regno = (is_a32_compat_task() ? 12 : 7);
 	saved_reg = regs->regs[regno];
 	regs->regs[regno] = dir;
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e18c48c..65baaef 100644
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
index 9ce9894..0afab39 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/bug.h>
+#include <linux/compat.h>
 #include <linux/signal.h>
 #include <linux/personality.h>
 #include <linux/kallsyms.h>
@@ -365,7 +366,7 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
 {
 #ifdef CONFIG_AARCH32_EL0
 	long ret;
-	if (is_compat_task()) {
+	if (is_a32_compat_task()) {
 		ret = compat_arm_syscall(regs);
 		if (ret != -ENOSYS)
 			return ret;
-- 
2.5.0
