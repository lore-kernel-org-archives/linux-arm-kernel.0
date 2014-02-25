From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 25 Feb 2014 18:23:14 +0900
Subject: [PATCH v4 5/7] arm64: ftrace: Add system call tracepoint
In-Reply-To: <1393320196-2942-1-git-send-email-takahiro.akashi@linaro.org>
References: <1391768336-5642-1-git-send-email-takahiro.akashi@linaro.org>
 <1393320196-2942-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <1393320196-2942-6-git-send-email-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows system call entry or exit to be traced as ftrace events,
ie. sys_enter_*/sys_exit_*, if CONFIG_FTRACE_SYSCALLS is enabled.
Those events appear and can be controlled under
    ${sysfs}/tracing/events/syscalls/

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 arch/arm64/Kconfig               |    1 +
 arch/arm64/include/asm/syscall.h |    1 +
 arch/arm64/include/asm/unistd.h  |    2 ++
 arch/arm64/kernel/ptrace.c       |    9 +++++++++
 4 files changed, 13 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6954959..b1dcdb4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -43,6 +43,7 @@ config ARM64
 	select HAVE_MEMBLOCK
 	select HAVE_PATA_PLATFORM
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
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index c70133e..dc90f9f 100644
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
@@ -1062,6 +1065,9 @@ asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
 {
 	unsigned long saved_reg;
 
+	if (dir && unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
+		trace_sys_exit(regs, regs_return_value(regs));
+
 	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
 		if (is_compat_task()) {
 			/* AArch32 uses ip (r12) for scratch */
@@ -1087,5 +1093,8 @@ asmlinkage int syscall_trace(int dir, struct pt_regs *regs)
 			regs->regs[7] = saved_reg;
 	}
 
+	if (!dir && unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
+		trace_sys_enter(regs, regs->syscallno);
+
 	return regs->syscallno;
 }
-- 
1.7.9.5
