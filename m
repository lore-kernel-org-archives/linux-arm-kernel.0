From: wade_farnsworth@mentor.com (Wade Farnsworth)
Date: Wed, 29 Feb 2012 07:36:21 -0700
Subject: [PATCH v2 2/3] ARM: add TRACEHOOK support
In-Reply-To: <4F4E3780.4060904@mentor.com>
References: <4F44FF58.3060907@mentor.com> <4F4E3780.4060904@mentor.com>
Message-ID: <4F4E37E5.4050901@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add calls to tracehook_report_syscall_{entry,exit} and tracehook_signal_handler

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
Signed-off-by: Wade Farnsworth <wade_farnsworth@mentor.com>
---
 arch/arm/Kconfig              |    1 +
 arch/arm/include/asm/ptrace.h |    5 +++++
 arch/arm/kernel/ptrace.c      |   21 ++++++---------------
 arch/arm/kernel/signal.c      |    2 ++
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a48aecc..0faad0c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -10,6 +10,7 @@ config ARM
 	select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
 	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
 	select HAVE_ARCH_KGDB
+	select HAVE_ARCH_TRACEHOOK
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 451808b..355ece5 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -249,6 +249,11 @@ static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 	return regs->ARM_sp;
 }
 
+static inline unsigned long user_stack_pointer(struct pt_regs *regs)
+{
+	return regs->ARM_sp;
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index ede6443..46f4b41 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -24,6 +24,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/regset.h>
 #include <linux/audit.h>
+#include <linux/tracehook.h>
 
 #include <asm/pgtable.h>
 #include <asm/system.h>
@@ -930,24 +931,14 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return scno;
-	if (!(current->ptrace & PT_PTRACED))
-		return scno;
 
 	current_thread_info()->syscall = scno;
 
-	/* the 0x80 provides a way for the tracing parent to distinguish
-	   between a syscall stop and SIGTRAP delivery */
-	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-				 ? 0x80 : 0));
-	/*
-	 * this isn't the same as continuing with a signal, but it will do
-	 * for normal use.  strace only continues with a signal if the
-	 * stopping signal is not SIGTRAP.  -brl
-	 */
-	if (current->exit_code) {
-		send_sig(current->exit_code, current, 1);
-		current->exit_code = 0;
-	}
+	if (why)
+		tracehook_report_syscall_exit(regs, 0);
+	else if (tracehook_report_syscall_entry(regs))
+		current_thread_info()->syscall = -1;
+
 	regs->ARM_ip = ip;
 
 	return current_thread_info()->syscall;
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 9e617bd..6f084c1 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -644,6 +644,8 @@ handle_signal(unsigned long sig, struct k_sigaction *ka,
 	recalc_sigpending();
 	spin_unlock_irq(&tsk->sighand->siglock);
 
+	tracehook_signal_handler(sig, info, ka, regs, 0);
+
 	return 0;
 }
 
-- 
1.7.0.4
