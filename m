From: will.deacon@arm.com (Will Deacon)
Date: Mon,  9 Jul 2018 15:19:43 +0100
Subject: [PATCH v2 1/3] arm64: rseq: Implement backend rseq calls and select
 HAVE_RSEQ
In-Reply-To: <1531145985-3747-1-git-send-email-will.deacon@arm.com>
References: <1531145985-3747-1-git-send-email-will.deacon@arm.com>
Message-ID: <1531145985-3747-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement calls to rseq_signal_deliver, rseq_handle_notify_resume
and rseq_syscall so that we can select HAVE_RSEQ on arm64.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig                | 1 +
 arch/arm64/include/asm/unistd.h   | 2 +-
 arch/arm64/include/asm/unistd32.h | 2 ++
 arch/arm64/kernel/entry.S         | 2 ++
 arch/arm64/kernel/ptrace.c        | 2 ++
 arch/arm64/kernel/signal.c        | 3 +++
 6 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090cf0292..26cb550673b2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -127,6 +127,7 @@ config ARM64
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RCU_TABLE_FREE
+	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index a0baa9af5487..e0d0f5b856e7 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -43,7 +43,7 @@
 #define __ARM_NR_compat_cacheflush	(__ARM_NR_COMPAT_BASE+2)
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE+5)
 
-#define __NR_compat_syscalls		398
+#define __NR_compat_syscalls		399
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index ef292160748c..0fdc7ef8a776 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -817,6 +817,8 @@ __SYSCALL(__NR_pkey_alloc, sys_pkey_alloc)
 __SYSCALL(__NR_pkey_free, sys_pkey_free)
 #define __NR_statx 397
 __SYSCALL(__NR_statx, sys_statx)
+#define __NR_rseq 398
+__SYSCALL(__NR_rseq, sys_rseq)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 28ad8799406f..1eda9e1a1f4a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -904,6 +904,7 @@ ENDPROC(el0_error)
 ret_fast_syscall:
 	disable_daif
 	str	x0, [sp, #S_X0]			// returned x0
+#ifndef CONFIG_DEBUG_RSEQ
 	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for syscall tracing
 	and	x2, x1, #_TIF_SYSCALL_WORK
 	cbnz	x2, ret_fast_syscall_trace
@@ -911,6 +912,7 @@ ret_fast_syscall:
 	cbnz	x2, work_pending
 	enable_step_tsk x1, x2
 	kernel_exit 0
+#endif
 ret_fast_syscall_trace:
 	enable_daif
 	b	__sys_trace_return_skipped	// we already saved x0
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 5c338ce5a7fa..9f479c111675 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1656,6 +1656,8 @@ asmlinkage void syscall_trace_exit(struct pt_regs *regs)
 
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_EXIT);
+
+	rseq_syscall(regs);
 }
 
 /*
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 511af13e8d8f..e3b1d1b0aee8 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -802,6 +802,8 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	int usig = ksig->sig;
 	int ret;
 
+	rseq_signal_deliver(ksig, regs);
+
 	/*
 	 * Set up the stack frame
 	 */
@@ -940,6 +942,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 			if (thread_flags & _TIF_NOTIFY_RESUME) {
 				clear_thread_flag(TIF_NOTIFY_RESUME);
 				tracehook_notify_resume(regs);
+				rseq_handle_notify_resume(NULL, regs);
 			}
 
 			if (thread_flags & _TIF_FOREIGN_FPSTATE)
-- 
2.1.4
