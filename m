From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Fri, 11 Mar 2016 17:10:23 -0500
Subject: [PATCH v11 13/13] arch/arm64: enable task isolation functionality
In-Reply-To: <1457734223-26209-1-git-send-email-cmetcalf@mellanox.com>
References: <1457734223-26209-1-git-send-email-cmetcalf@mellanox.com>
Message-ID: <1457734223-26209-14-git-send-email-cmetcalf@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In do_notify_resume(), call task_isolation_ready() for
TIF_TASK_ISOLATION tasks when we are checking the thread-info flags;
and after we've handled the other work, call task_isolation_enter()
for such tasks.  To ensure we always call task_isolation_enter() when
returning to userspace, add _TIF_TASK_ISOLATION to _TIF_WORK_MASK,
while leaving the old bitmask value as _TIF_WORK_LOOP_MASK to
check while looping.

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

Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
---
 arch/arm64/include/asm/thread_info.h |  5 ++++-
 arch/arm64/kernel/ptrace.c           | 15 ++++++++++++---
 arch/arm64/kernel/signal.c           | 10 ++++++++++
 arch/arm64/kernel/smp.c              |  2 ++
 arch/arm64/mm/fault.c                |  4 ++++
 5 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index abd64bd1f6d9..bdc6426b9968 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -109,6 +109,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_NEED_RESCHED	1
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
+#define TIF_TASK_ISOLATION	4
 #define TIF_NOHZ		7
 #define TIF_SYSCALL_TRACE	8
 #define TIF_SYSCALL_AUDIT	9
@@ -124,6 +125,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
+#define _TIF_TASK_ISOLATION	(1 << TIF_TASK_ISOLATION)
 #define _TIF_NOHZ		(1 << TIF_NOHZ)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
@@ -132,7 +134,8 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_32BIT		(1 << TIF_32BIT)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
-				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE)
+				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
+				 _TIF_TASK_ISOLATION)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index ff7f13239515..6fbb70112e11 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -37,6 +37,7 @@
 #include <linux/regset.h>
 #include <linux/tracehook.h>
 #include <linux/elf.h>
+#include <linux/isolation.h>
 
 #include <asm/compat.h>
 #include <asm/debug-monitors.h>
@@ -1246,14 +1247,22 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 
 asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
-	/* Do the secure computing check first; failures should be fast. */
+	unsigned long work = ACCESS_ONCE(current_thread_info()->flags);
+
+	/* In isolation mode, we may prevent the syscall from running. */
+	if (work & _TIF_TASK_ISOLATION) {
+		if (task_isolation_syscall(regs->syscallno) == -1)
+			return -1;
+	}
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
index 1f172f8afe47..1e6ee84bd6ca 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -25,6 +25,7 @@
 #include <linux/uaccess.h>
 #include <linux/tracehook.h>
 #include <linux/ratelimit.h>
+#include <linux/isolation.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/elf.h>
@@ -424,9 +425,18 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 
 			if (thread_flags & _TIF_FOREIGN_FPSTATE)
 				fpsimd_restore_current_state();
+
+			if (thread_flags & _TIF_TASK_ISOLATION)
+				task_isolation_enter();
 		}
 
 		local_irq_disable();
 		thread_flags = READ_ONCE(current_thread_info()->flags);
+
+		/* Clear task isolation from cached_flags manually. */
+		if ((thread_flags & _TIF_TASK_ISOLATION) &&
+		    task_isolation_ready())
+			thread_flags &= ~_TIF_TASK_ISOLATION;
+
 	} while (thread_flags & _TIF_WORK_MASK);
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
index abe2a9542b3a..d9b5119328eb 100644
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
+		task_isolation_exception("%s at %#lx", inf->name, addr);
+
 	if (!inf->fn(addr, esr, regs))
 		return;
 
-- 
2.7.2
