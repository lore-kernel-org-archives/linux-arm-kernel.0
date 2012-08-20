From: wade_farnsworth@mentor.com (Wade Farnsworth)
Date: Mon, 20 Aug 2012 07:38:37 -0700
Subject: [PATCH v3] ARM: support syscall tracing
Message-ID: <50324BED.9000500@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As specified by ftrace-design.txt, TIF_SYSCALL_TRACEPOINT was
added, as well as NR_syscalls in asm/unistd.h.  Additionally,
syscall_trace_{enter,exit} were modified to call trace_sys_{enter,exit}
as appropriate.

Tests #2 - #4 of "perf test" now complete successfully.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
Signed-off-by: Wade Farnsworth <wade_farnsworth@mentor.com>
---
This patch is an update of one I posted some months ago.  It has been
rebased to Linus's current master branch.
- v2: Implemented changes suggested by Will:
  - Folded _TIF_SYSCALL_TRACEPOINT into _TIF_SYSCALL_WORK to save an
    instruction in entry-common.S.
  - Moved calls to trace_sys_{enter,exit} to syscall_trace_{enter,exit}
- v3:
  - Set current_thread_info()->syscall before checking TIF_SYSCALL_TRACE.
  - Pass the original syscall number into trace_sys_{enter,exit}, not
    the return value from ptrace_syscall_trace().
 arch/arm/Kconfig                   |    1 +
 arch/arm/include/asm/syscall.h     |    4 ++++
 arch/arm/include/asm/thread_info.h |    4 +++-
 arch/arm/include/asm/unistd.h      |    8 ++++++++
 arch/arm/kernel/entry-common.S     |   11 ++++++++++-
 arch/arm/kernel/ptrace.c           |   11 +++++++++--
 6 files changed, 35 insertions(+), 4 deletions(-)

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
index af7b0bd..5ded667 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -148,6 +148,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_SYSCALL_TRACE	8
 #define TIF_SYSCALL_AUDIT	9
+#define TIF_SYSCALL_TRACEPOINT	10
 #define TIF_POLLING_NRFLAG	16
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
@@ -160,12 +161,13 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
+#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 
 /* Checks for any syscall work in entry-common.S */
-#define _TIF_SYSCALL_WORK (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT)
+#define _TIF_SYSCALL_WORK (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SYSCALL_TRACEPOINT)
 
 /*
  * Change these and you break ASM code in entry-common.S
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
index 978eac5..b032c94 100644
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
 
@@ -415,7 +424,7 @@ local_restart:
 1:
 #endif
 
-	tst	r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
+	tst     r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
 	bne	__sys_trace
 
 	cmp	scno, #NR_syscalls		@ check upper syscall limit
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 3e0fc5f..4974cdf 100644
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
@@ -918,11 +921,11 @@ static int ptrace_syscall_trace(struct pt_regs *regs, int scno,
 {
 	unsigned long ip;
 
+	current_thread_info()->syscall = scno;
+
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return scno;
 
-	current_thread_info()->syscall = scno;
-
 	/*
 	 * IP is used to denote syscall entry/exit:
 	 * IP = 0 -> entry, =1 -> exit
@@ -942,6 +945,8 @@ static int ptrace_syscall_trace(struct pt_regs *regs, int scno,
 asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
 {
 	int ret = ptrace_syscall_trace(regs, scno, PTRACE_SYSCALL_ENTER);
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
+		trace_sys_enter(regs, scno);
 	audit_syscall_entry(AUDIT_ARCH_ARM, scno, regs->ARM_r0, regs->ARM_r1,
 			    regs->ARM_r2, regs->ARM_r3);
 	return ret;
@@ -950,6 +955,8 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
 asmlinkage int syscall_trace_exit(struct pt_regs *regs, int scno)
 {
 	int ret = ptrace_syscall_trace(regs, scno, PTRACE_SYSCALL_EXIT);
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
+		trace_sys_exit(regs, scno);
 	audit_syscall_exit(regs);
 	return ret;
 }
-- 
1.7.0.4
