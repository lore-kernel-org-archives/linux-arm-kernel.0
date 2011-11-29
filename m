From: stevenrwalter@gmail.com (Steven Walter)
Date: Tue, 29 Nov 2011 11:28:15 -0500
Subject: [PATCH 3/3] ARM: support syscall tracing
In-Reply-To: <1322584095-30439-1-git-send-email-stevenrwalter@gmail.com>
References: <1322584095-30439-1-git-send-email-stevenrwalter@gmail.com>
Message-ID: <1322584095-30439-4-git-send-email-stevenrwalter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As specified by ftrace-design.txt, TIF_SYSCALL_TRACEPOINT was added, as
well as NR_syscalls in asm/unistd.h.  Additionally, __sys_trace was
modified to call trace_sys_enter and trace_sys_exit when appropriate.

There was previously an assembler variable named NR_syscalls in
entry-common.S.  This was renamed NR_syscalls_asm so as not to collide
with NR_syscalls from asm/unistd.h.

Tests #2 - #4 of "perf test" now complete successfully.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 arch/arm/Kconfig                   |    1 +
 arch/arm/include/asm/thread_info.h |    2 ++
 arch/arm/include/asm/unistd.h      |    2 ++
 arch/arm/kernel/entry-common.S     |   14 ++++++++------
 arch/arm/kernel/ptrace.c           |   24 ++++++++++++++++++------
 5 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0a93d76..7f0c53b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -11,6 +11,7 @@ config ARM
 	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES if (!XIP_KERNEL && !THUMB2_KERNEL)
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 7b5cc8d..17a84b6 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -145,6 +145,7 @@ extern void vfp_flush_hwstate(struct thread_info *);
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
 #define TIF_SECCOMP		21
+#define TIF_SYSCALL_TRACEPOINT	22
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -155,6 +156,7 @@ extern void vfp_flush_hwstate(struct thread_info *);
 #define _TIF_FREEZE		(1 << TIF_FREEZE)
 #define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
+#define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 
 /*
  * Change these and you break ASM code in entry-common.S
diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 2c04ed5..1f23923 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -403,6 +403,8 @@
 #define __NR_sendmmsg			(__NR_SYSCALL_BASE+374)
 #define __NR_setns			(__NR_SYSCALL_BASE+375)
 
+#define NR_syscalls (__NR_setns+1)
+
 /*
  * The following SWIs are ARM private.
  */
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index b2a27b6..314280d 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -88,6 +88,7 @@ ENTRY(ret_from_fork)
 	ldr	r1, [tsk, #TI_FLAGS]		@ check for syscall tracing
 	mov	why, #1
 	tst	r1, #_TIF_SYSCALL_TRACE		@ are we tracing syscalls?
+	tsteq	r1, #_TIF_SYSCALL_TRACEPOINT
 	beq	ret_slow_syscall
 	mov	r1, sp
 	mov	r0, #1				@ trace exit [IP = 1]
@@ -95,8 +96,8 @@ ENTRY(ret_from_fork)
 	b	ret_slow_syscall
 ENDPROC(ret_from_fork)
 
-	.equ NR_syscalls,0
-#define CALL(x) .equ NR_syscalls,NR_syscalls+1
+	.equ NR_syscalls_asm,0
+#define CALL(x) .equ NR_syscalls_asm,NR_syscalls_asm+1
 #include "calls.S"
 #undef CALL
 #define CALL(x) .long x
@@ -443,10 +444,11 @@ ENTRY(vector_swi)
 1:
 #endif
 
-	tst	r10, #_TIF_SYSCALL_TRACE		@ are we tracing syscalls?
+	tst	r10, #_TIF_SYSCALL_TRACE	@ are we tracing syscalls?
+	tsteq	r10, #_TIF_SYSCALL_TRACEPOINT
 	bne	__sys_trace
 
-	cmp	scno, #NR_syscalls		@ check upper syscall limit
+	cmp	scno, #NR_syscalls_asm		@ check upper syscall limit
 	adr	lr, BSYM(ret_fast_syscall)	@ return address
 	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
 
@@ -471,7 +473,7 @@ __sys_trace:
 	adr	lr, BSYM(__sys_trace_return)	@ return address
 	mov	scno, r0			@ syscall number (possibly new)
 	add	r1, sp, #S_R0 + S_OFF		@ pointer to regs
-	cmp	scno, #NR_syscalls		@ check upper syscall limit
+	cmp	scno, #NR_syscalls_asm		@ check upper syscall limit
 	ldmccia	r1, {r0 - r3}			@ have to reload r0 - r3
 	ldrcc	pc, [tbl, scno, lsl #2]		@ call sys_* routine
 	b	2b
@@ -517,7 +519,7 @@ ENTRY(sys_call_table)
 sys_syscall:
 		bic	scno, r0, #__NR_OABI_SYSCALL_BASE
 		cmp	scno, #__NR_syscall - __NR_SYSCALL_BASE
-		cmpne	scno, #NR_syscalls	@ check range
+		cmpne	scno, #NR_syscalls_asm	@ check range
 		stmloia	sp, {r5, r6}		@ shuffle args
 		movlo	r0, r1
 		movlo	r1, r2
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 1411848..0e2699a 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -28,6 +28,9 @@
 #include <asm/system.h>
 #include <asm/traps.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
 #define REG_PC	15
 #define REG_PSR	16
 /*
@@ -927,7 +930,7 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 {
 	unsigned long ip;
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE))
+	if (!test_thread_flag(TIF_SYSCALL_TRACE) && !test_thread_flag(TIF_SYSCALL_TRACEPOINT))
 		return scno;
 
 	/*
@@ -939,11 +942,20 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 
 	current_thread_info()->syscall = scno;
 
-	if (why == 0) {
-		if (tracehook_report_syscall_entry(regs))
-			current_thread_info()->syscall = -1;
-	} else {
-		tracehook_report_syscall_exit(regs, 0);
+	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
+		if (why == 0) {
+			if (tracehook_report_syscall_entry(regs))
+				current_thread_info()->syscall = -1;
+		} else {
+			tracehook_report_syscall_exit(regs, 0);
+		}
+	}
+
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT)) {
+		if (why == 0)
+			trace_sys_enter(regs, scno);
+		else
+			trace_sys_exit(regs, scno);
 	}
 
 	regs->ARM_ip = ip;
-- 
1.7.5.4.2.g81f75
