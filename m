From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 24 Mar 2017 15:55:33 +0000
Subject: [PATCH] arm64: ptrace: Crystallise the pt_regs->syscallno = ~0UL idiom
Message-ID: <1490370933-24057-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assigning ~0UL to pt_regs->syscallno to indicate that a task is not
executing a syscall is a little obscure.

This patch defines a helper zap_syscall() to make users of this
idiom and its intent a bit more readable.  This concept allows
relaxations to the system call ABI whereby not all userspace state
need be preserved by the kernel around an explicit syscall.  The
Scalable Vector Extension ABI will make use of this with regard
to the extra register state added by SVE.

No relaxation of the _existing_ system call ABI is implied here.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/processor.h | 7 ++++++-
 arch/arm64/kernel/ptrace.c         | 3 ++-
 arch/arm64/kernel/signal.c         | 4 ++--
 arch/arm64/kernel/signal32.c       | 3 ++-
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index c97b8bd..0502007 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -104,10 +104,15 @@ struct thread_struct {
 
 #define INIT_THREAD  {	}
 
+static inline void zap_syscall(struct pt_regs *regs)
+{
+	regs->syscallno = ~0UL;
+}
+
 static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
 {
 	memset(regs, 0, sizeof(*regs));
-	regs->syscallno = ~0UL;
+	zap_syscall(regs);
 	regs->pc = pc;
 }
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index c142459..d92b422 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -42,6 +42,7 @@
 #include <asm/compat.h>
 #include <asm/debug-monitors.h>
 #include <asm/pgtable.h>
+#include <asm/processor.h>
 #include <asm/syscall.h>
 #include <asm/traps.h>
 #include <asm/system_misc.h>
@@ -1348,7 +1349,7 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 	if (dir == PTRACE_SYSCALL_EXIT)
 		tracehook_report_syscall_exit(regs, 0);
 	else if (tracehook_report_syscall_entry(regs))
-		regs->syscallno = ~0UL;
+		zap_syscall(regs);
 
 	regs->regs[regno] = saved_reg;
 }
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 49c30df..1aef3d7 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -351,7 +351,7 @@ static int restore_sigframe(struct pt_regs *regs,
 	/*
 	 * Avoid sys_rt_sigreturn() restarting.
 	 */
-	regs->syscallno = ~0UL;
+	zap_syscall(regs);
 
 	err |= !valid_user_regs(&regs->user_regs, current);
 	if (err == 0)
@@ -634,7 +634,7 @@ static void do_signal(struct pt_regs *regs)
 		/*
 		 * Avoid additional syscall restarting via ret_to_user.
 		 */
-		regs->syscallno = ~0UL;
+		zap_syscall(regs);
 
 		/*
 		 * Prepare for system call restart. We do this here so that a
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index c747a0f..53f1cc0 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -27,6 +27,7 @@
 #include <asm/fpsimd.h>
 #include <asm/signal32.h>
 #include <linux/uaccess.h>
+#include <asm/processor.h>
 #include <asm/unistd.h>
 
 struct compat_sigcontext {
@@ -354,7 +355,7 @@ static int compat_restore_sigframe(struct pt_regs *regs,
 	/*
 	 * Avoid compat_sys_sigreturn() restarting.
 	 */
-	regs->syscallno = ~0UL;
+	zap_syscall(regs);
 
 	err |= !valid_user_regs(&regs->user_regs, current);
 
-- 
2.1.4
