From: cmetcalf@ezchip.com (Chris Metcalf)
Date: Wed, 2 Mar 2016 15:09:36 -0500
Subject: [PATCH v10 12/12] arch/arm64: enable task isolation functionality
In-Reply-To: <1456949376-4910-1-git-send-email-cmetcalf@ezchip.com>
References: <1456949376-4910-1-git-send-email-cmetcalf@ezchip.com>
Message-ID: <1456949376-4910-13-git-send-email-cmetcalf@ezchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In do_notify_resume(), call task_isolation_ready() when we are
checking the thread-info flags; and after we've handled the other
work, call task_isolation_enter() unconditionally.  To ensure we
always call task_isolation_enter() when returning to userspace,
modify _TIF_WORK_MASK to be _TIF_NOHZ, which is set in every task,
when we build with TASK_ISOLATION configured.

We tweak syscall_trace_enter() slightly to carry the "flags"
value from current_thread_info()->flags for each of the tests,
rather than doing a volatile read from memory for each one.  This
avoids a small overhead for each test, and in particular avoids
that overhead for TIF_NOHZ when TASK_ISOLATION is not enabled.

We instrument the smp_cross_call() routine so that it checks for
isolated tasks and generates a suitable warning if we are about
to disturb one of them in strict or debug mode.

Finally, add an explicit check for STRICT mode in do_mem_abort()
to handle the case of page faults.

Signed-off-by: Chris Metcalf <cmetcalf@ezchip.com>
---
 arch/arm64/include/asm/thread_info.h |  8 +++++++-
 arch/arm64/kernel/ptrace.c           | 12 +++++++++---
 arch/arm64/kernel/signal.c           |  6 +++++-
 arch/arm64/kernel/smp.c              |  2 ++
 arch/arm64/mm/fault.c                |  4 ++++
 5 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index abd64bd1f6d9..89c72888cb54 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -131,9 +131,15 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_32BIT		(1 << TIF_32BIT)
 
-#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
+#define _TIF_WORK_LOOP_MASK	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE)
 
+#ifdef CONFIG_TASK_ISOLATION
+# define _TIF_WORK_MASK		_TIF_NOHZ  /* always set */
+#else
+# define _TIF_WORK_MASK		_TIF_WORK_LOOP_MASK
+#endif
+
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
 				 _TIF_NOHZ)
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index ff7f13239515..43aa6d016f46 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -37,6 +37,7 @@
 #include <linux/regset.h>
 #include <linux/tracehook.h>
 #include <linux/elf.h>
+#include <linux/isolation.h>
 
 #include <asm/compat.h>
 #include <asm/debug-monitors.h>
@@ -1246,14 +1247,19 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 
 asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
-	/* Do the secure computing check first; failures should be fast. */
+	unsigned long work = ACCESS_ONCE(current_thread_info()->flags);
+
+	if ((work & _TIF_NOHZ) && task_isolation_check_syscall(regs->syscallno))
+		return -1;
+
+	/* Do the secure computing check early; failures should be fast. */
 	if (secure_computing() == -1)
 		return -1;
 
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
+	if (work & _TIF_SYSCALL_TRACE)
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
 
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
+	if (work & _TIF_SYSCALL_TRACEPOINT)
 		trace_sys_enter(regs, regs->syscallno);
 
 	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 3432e14b7d6e..53fcd6c305d6 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -25,6 +25,7 @@
 #include <linux/uaccess.h>
 #include <linux/tracehook.h>
 #include <linux/ratelimit.h>
+#include <linux/isolation.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/elf.h>
@@ -419,12 +420,15 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 
 			if (thread_flags & _TIF_FOREIGN_FPSTATE)
 				fpsimd_restore_current_state();
+
+			task_isolation_enter();
 		}
 
 		local_irq_disable();
 
 		thread_flags = READ_ONCE(current_thread_info()->flags);
-		if (!(thread_flags & _TIF_WORK_MASK))
+		if (!(thread_flags & _TIF_WORK_LOOP_MASK) &&
+		    task_isolation_ready())
 			break;
 	}
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b1adc51b2c2e..dcb3282d04a2 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -37,6 +37,7 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/irq_work.h>
+#include <linux/isolation.h>
 
 #include <asm/alternative.h>
 #include <asm/atomic.h>
@@ -632,6 +633,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
 	trace_ipi_raise(target, ipi_types[ipinr]);
+	task_isolation_debug_cpumask(target);
 	__smp_cross_call(target, ipinr);
 }
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index abe2a9542b3a..644cd634dd1d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -29,6 +29,7 @@
 #include <linux/sched.h>
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
+#include <linux/isolation.h>
 
 #include <asm/cpufeature.h>
 #include <asm/exception.h>
@@ -473,6 +474,9 @@ asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 	const struct fault_info *inf = fault_info + (esr & 63);
 	struct siginfo info;
 
+	if (user_mode(regs))
+		task_isolation_check_exception("%s at %#lx", inf->name, addr);
+
 	if (!inf->fn(addr, esr, regs))
 		return;
 
-- 
2.1.2
