From: wade_farnsworth@mentor.com (Wade Farnsworth)
Date: Mon, 13 Aug 2012 10:03:39 -0700
Subject: [PATCH] ARM: support syscall tracing
Message-ID: <5029336B.2050305@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As specified by ftrace-design.txt, TIF_SYSCALL_TRACEPOINT was
added, as well as NR_syscalls in asm/unistd.h.  Additionally,
__sys_trace was modified to call trace_sys_enter and
trace_sys_exit when appropriate.

Tests #2 - #4 of "perf test" now complete successfully.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
Signed-off-by: Wade Farnsworth <wade_farnsworth@mentor.com>
---

This patch is an update of one I posted some months ago.  It has been
rebased to Linus's current HEAD.

 arch/arm/Kconfig                   |    1 +
 arch/arm/include/asm/syscall.h     |    4 ++++
 arch/arm/include/asm/thread_info.h |    2 ++
 arch/arm/include/asm/unistd.h      |    8 ++++++++
 arch/arm/kernel/entry-common.S     |   12 +++++++++++-
 arch/arm/kernel/ptrace.c           |   23 ++++++++++++++++++-----
 6 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e91c7cd..983e9eb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -16,6 +16,7 @@ config ARM
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
diff --git a/arch/arm/include/asm/syscall.h b/arch/arm/include/asm/syscall.h
index c334a23..47486a4 100644
--- a/arch/arm/include/asm/syscall.h
+++ b/arch/arm/include/asm/syscall.h
@@ -9,6 +9,10 @@
 
 #include <linux/err.h>
 
+#include <asm/unistd.h>
+
+#define NR_syscalls (__NR_syscalls)
+
 extern const unsigned long sys_call_table[];
 
 static inline int syscall_get_nr(struct task_struct *task,
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index af7b0bd..d3e4410 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -154,6 +154,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
 #define TIF_RESTORE_SIGMASK	20
 #define TIF_SECCOMP		21
 #define TIF_SWITCH_MM		22	/* deferred switch_mm */
+#define TIF_SYSCALL_TRACEPOINT	23
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -163,6 +164,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
+#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 
 /* Checks for any syscall work in entry-common.S */
 #define _TIF_SYSCALL_WORK (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT)
diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 0cab47d..a566ec2 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -406,6 +406,14 @@
 #define __NR_process_vm_writev		(__NR_SYSCALL_BASE+377)
 
 /*
+ * This may need to be greater than __NR_last_syscall+1 in order to
+ * account for the padding in the syscall table
+ */
+#ifdef __KERNEL__
+#define __NR_syscalls  (380)
+#endif /* __KERNEL__ */
+
+/*
  * The following SWIs are ARM private.
  */
 #define __ARM_NR_BASE			(__NR_SYSCALL_BASE+0x0f0000)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 978eac5..51b64c1 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -94,6 +94,15 @@ ENDPROC(ret_from_fork)
 	.equ NR_syscalls,0
 #define CALL(x) .equ NR_syscalls,NR_syscalls+1
 #include "calls.S"
+
+/*
+ * Ensure that the system call table is equal to __NR_syscalls,
+ * which is the value the rest of the system sees
+ */
+.ifne NR_syscalls - __NR_syscalls
+.error "__NR_syscalls is not equal to the size of the syscall table"
+.endif
+
 #undef CALL
 #define CALL(x) .long x
 
@@ -415,7 +424,8 @@ local_restart:
 1:
 #endif
 
-	tst	r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
+	tst     r10, #_TIF_SYSCALL_WORK
+	tsteq   r10, #_TIF_SYSCALL_TRACEPOINT
 	bne	__sys_trace
 
 	cmp	scno, #NR_syscalls		@ check upper syscall limit
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 3e0fc5f..a2d46ed 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -30,6 +30,9 @@
 #include <asm/pgtable.h>
 #include <asm/traps.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
 #define REG_PC	15
 #define REG_PSR	16
 /*
@@ -918,7 +921,8 @@ static int ptrace_syscall_trace(struct pt_regs *regs, int scno,
 {
 	unsigned long ip;
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE))
+	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
+	    !test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		return scno;
 
 	current_thread_info()->syscall = scno;
@@ -930,10 +934,19 @@ static int ptrace_syscall_trace(struct pt_regs *regs, int scno,
 	ip = regs->ARM_ip;
 	regs->ARM_ip = dir;
 
-	if (dir == PTRACE_SYSCALL_EXIT)
-		tracehook_report_syscall_exit(regs, 0);
-	else if (tracehook_report_syscall_entry(regs))
-		current_thread_info()->syscall = -1;
+	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
+		if (dir == PTRACE_SYSCALL_EXIT)
+			tracehook_report_syscall_exit(regs, 0);
+		else if (tracehook_report_syscall_entry(regs))
+			current_thread_info()->syscall = -1;
+	}
+
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT)) {
+		if (dir == PTRACE_SYSCALL_EXIT)
+			trace_sys_exit(regs, scno);
+		else
+			trace_sys_enter(regs, scno);
+	}
 
 	regs->ARM_ip = ip;
 	return current_thread_info()->syscall;
-- 
1.7.0.4
