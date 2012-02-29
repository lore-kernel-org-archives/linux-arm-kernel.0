From: wade_farnsworth@mentor.com (Wade Farnsworth)
Date: Wed, 29 Feb 2012 07:36:51 -0700
Subject: [PATCH v2 3/3] ARM: support syscall tracing
In-Reply-To: <4F4E3780.4060904@mentor.com>
References: <4F44FF58.3060907@mentor.com> <4F4E3780.4060904@mentor.com>
Message-ID: <4F4E3803.9030502@mentor.com>
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
 arch/arm/Kconfig                   |    1 +
 arch/arm/include/asm/syscall.h     |    4 ++++
 arch/arm/include/asm/thread_info.h |    2 ++
 arch/arm/include/asm/unistd.h      |    8 ++++++++
 arch/arm/kernel/entry-common.S     |   16 ++++++++++++++--
 arch/arm/kernel/ptrace.c           |   23 ++++++++++++++++++-----
 6 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0faad0c..b1d9396 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -11,6 +11,7 @@ config ARM
 	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
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
index d4c24d4..f2ff2de 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -146,6 +146,7 @@ extern void vfp_flush_hwstate(struct thread_info *);
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	20
 #define TIF_SECCOMP		21
+#define TIF_SYSCALL_TRACEPOINT	22
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -156,6 +157,7 @@ extern void vfp_flush_hwstate(struct thread_info *);
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
 #define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
+#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 
 /* Checks for any syscall work in entry-common.S */
 #define _TIF_SYSCALL_WORK (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT)
diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 512cd14..d27d7d7 100644
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
index 9fd0ba9..01686b2 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -79,6 +79,11 @@ no_work_pending:
 ENDPROC(ret_to_user_from_irq)
 ENDPROC(ret_to_user)
 
+.macro test_syscall_tracing reg
+       tst     \reg, #_TIF_SYSCALL_WORK
+       tsteq   \reg, #_TIF_SYSCALL_TRACEPOINT
+.endm
+
 /*
  * This is how we return from a fork.
  */
@@ -87,7 +92,7 @@ ENTRY(ret_from_fork)
 	get_thread_info tsk
 	ldr	r1, [tsk, #TI_FLAGS]		@ check for syscall tracing
 	mov	why, #1
-	tst	r1, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
+	test_syscall_tracing r1
 	beq	ret_slow_syscall
 	mov	r1, sp
 	mov	r0, #1				@ trace exit [IP = 1]
@@ -98,6 +103,13 @@ ENDPROC(ret_from_fork)
 	.equ NR_syscalls,0
 #define CALL(x) .equ NR_syscalls,NR_syscalls+1
 #include "calls.S"
+
+/* Ensure that the system call table is not larger than __NR_syscalls,
+ * which is the value the rest of the system sees */
+.ifne NR_syscalls - __NR_syscalls
+.error "__NR_syscalls is less than the size of the syscall table"
+.endif
+
 #undef CALL
 #define CALL(x) .long x
 
@@ -446,7 +458,7 @@ ENTRY(vector_swi)
 1:
 #endif
 
-	tst	r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
+	test_syscall_tracing r10
 	bne	__sys_trace
 
 	cmp	scno, #NR_syscalls		@ check upper syscall limit
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 46f4b41..dbbf4ce 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -30,6 +30,9 @@
 #include <asm/system.h>
 #include <asm/traps.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
 #define REG_PC	15
 #define REG_PSR	16
 /*
@@ -929,15 +932,25 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 		audit_syscall_entry(AUDIT_ARCH_NR, scno, regs->ARM_r0,
 				    regs->ARM_r1, regs->ARM_r2, regs->ARM_r3);
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE))
+	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
+	    !test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		return scno;
 
 	current_thread_info()->syscall = scno;
 
-	if (why)
-		tracehook_report_syscall_exit(regs, 0);
-	else if (tracehook_report_syscall_entry(regs))
-		current_thread_info()->syscall = -1;
+	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
+		if (why)
+			tracehook_report_syscall_exit(regs, 0);
+		else if (tracehook_report_syscall_entry(regs))
+			current_thread_info()->syscall = -1;
+	}
+
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT)) {
+		if (why)
+			trace_sys_exit(regs, scno);
+		else
+			trace_sys_enter(regs, scno);
+	}
 
 	regs->ARM_ip = ip;
 
-- 
1.7.0.4
