From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 24 Oct 2013 16:08:07 +0900
Subject: [PATCH v2 5/6] arm64: ftrace: Add system call tracepoint
In-Reply-To: <1382598488-13511-1-git-send-email-takahiro.akashi@linaro.org>
References: <1382598488-13511-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1382598488-13511-6-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables FTRACE_SYSCALLS configuration.
Entry and/or exit to any system call can be traced as a ftrace event.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/Kconfig                   |    1 +
 arch/arm64/include/asm/syscall.h     |    1 +
 arch/arm64/include/asm/thread_info.h |    1 +
 arch/arm64/include/asm/unistd.h      |    2 ++
 arch/arm64/kernel/entry.S            |    1 +
 arch/arm64/kernel/ptrace.c           |   10 ++++++++++
 6 files changed, 16 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4f4a0dc..f01d84e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -32,6 +32,7 @@ config ARM64
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_MEMBLOCK
 	select HAVE_PERF_EVENTS
+	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select NO_BOOTMEM
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 70ba9d4..383771e 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -18,6 +18,7 @@
 
 #include <linux/err.h>
 
+extern const void *sys_call_table[];
 
 static inline int syscall_get_nr(struct task_struct *task,
 				 struct pt_regs *regs)
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 23a3c47..6f5d977 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -107,6 +107,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_NEED_RESCHED	1
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_SYSCALL_TRACE	8
+#define TIF_SYSCALL_TRACEPOINT	10
 #define TIF_POLLING_NRFLAG	16
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 82ce217..c335479 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -28,3 +28,5 @@
 #endif
 #define __ARCH_WANT_SYS_CLONE
 #include <uapi/asm/unistd.h>
+
+#define NR_syscalls (__NR_syscalls)
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 3881fd1..7f81bfe 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -646,6 +646,7 @@ el0_svc_naked:					// compat entry point
 	get_thread_info tsk
 	ldr	x16, [tsk, #TI_FLAGS]		// check for syscall tracing
 	tbnz	x16, #TIF_SYSCALL_TRACE, __sys_trace // are we tracing syscalls?
+	tbnz	x16, #TIF_SYSCALL_TRACEPOINT, __sys_trace
 	adr	lr, ret_fast_syscall		// return address
 	cmp     scno, sc_nr                     // check upper syscall limit
 	b.hs	ni_sys
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index fecdbf7..548baa3 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -41,6 +41,9 @@
 #include <asm/traps.h>
 #include <asm/system_misc.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
 /*
  * TODO: does not yet catch signals sent when the child dies.
  * in exit.c or in signal.c.
@@ -1066,6 +1069,13 @@ asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
 {
 	unsigned long saved_reg;
 
+	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT)) {
+		if (dir)
+			trace_sys_exit(regs, regs->syscallno);
+		else
+			trace_sys_enter(regs, regs->syscallno);
+	}
+
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return regs->syscallno;
 
-- 
1.7.9.5
