From: cmetcalf@ezchip.com (Chris Metcalf)
Date: Mon, 4 Jan 2016 14:34:47 -0500
Subject: [PATCH v9 09/13] arch/arm64: enable task isolation functionality
In-Reply-To: <1451936091-29247-1-git-send-email-cmetcalf@ezchip.com>
References: <1451936091-29247-1-git-send-email-cmetcalf@ezchip.com>
Message-ID: <1451936091-29247-10-git-send-email-cmetcalf@ezchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to call task_isolation_enter() from prepare_exit_to_usermode(),
so that we can both ensure we do it last before returning to
userspace, and we also are able to re-run signal handling, etc.,
if something occurs while task_isolation_enter() has interrupts
enabled.  To do this we add _TIF_NOHZ to the _TIF_WORK_MASK if
we have CONFIG_TASK_ISOLATION enabled, which brings us into
prepare_exit_to_usermode() on all return to userspace.  But we
don't put _TIF_NOHZ in the flags that we use to loop back and
recheck, since we don't need to loop back only because the flag
is set.  Instead we unconditionally call task_isolation_enter()
at the end of the loop if any other work is done.

To make the assembly code continue to be as optimized as before,
we renumber the _TIF flags so that both _TIF_WORK_MASK and
_TIF_SYSCALL_WORK still have contiguous runs of bits in the
immediate operand for the "and" instruction, as required by the
ARM64 ISA.  Since TIF_NOHZ is in both masks, it must be the
middle bit in the contiguous run that starts with the
_TIF_WORK_MASK bits and ends with the _TIF_SYSCALL_WORK bits.

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
 arch/arm64/include/asm/thread_info.h | 18 ++++++++++++------
 arch/arm64/kernel/ptrace.c           | 12 +++++++++---
 arch/arm64/kernel/signal.c           |  7 +++++--
 arch/arm64/kernel/smp.c              |  2 ++
 arch/arm64/mm/fault.c                |  4 ++++
 5 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 90c7ff233735..94a98e9e29ef 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -103,11 +103,11 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_NEED_RESCHED	1
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
-#define TIF_NOHZ		7
-#define TIF_SYSCALL_TRACE	8
-#define TIF_SYSCALL_AUDIT	9
-#define TIF_SYSCALL_TRACEPOINT	10
-#define TIF_SECCOMP		11
+#define TIF_NOHZ		4
+#define TIF_SYSCALL_TRACE	5
+#define TIF_SYSCALL_AUDIT	6
+#define TIF_SYSCALL_TRACEPOINT	7
+#define TIF_SECCOMP		8
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
@@ -125,9 +125,15 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_32BIT		(1 << TIF_32BIT)
 
-#define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
+#define _TIF_WORK_LOOP_MASK	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE)
 
+#ifdef CONFIG_TASK_ISOLATION
+# define _TIF_WORK_MASK		(_TIF_WORK_LOOP_MASK | _TIF_NOHZ)
+#else
+# define _TIF_WORK_MASK		_TIF_WORK_LOOP_MASK
+#endif
+
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
 				 _TIF_NOHZ)
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 1971f491bb90..69ed3ba81650 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -37,6 +37,7 @@
 #include <linux/regset.h>
 #include <linux/tracehook.h>
 #include <linux/elf.h>
+#include <linux/isolation.h>
 
 #include <asm/compat.h>
 #include <asm/debug-monitors.h>
@@ -1240,14 +1241,19 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 
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
index fde59c1139a9..641c828653c7 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -25,6 +25,7 @@
 #include <linux/uaccess.h>
 #include <linux/tracehook.h>
 #include <linux/ratelimit.h>
+#include <linux/isolation.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/elf.h>
@@ -419,10 +420,12 @@ asmlinkage void prepare_exit_to_usermode(struct pt_regs *regs,
 		if (thread_flags & _TIF_FOREIGN_FPSTATE)
 			fpsimd_restore_current_state();
 
+		task_isolation_enter();
+
 		local_irq_disable();
 
 		thread_flags = READ_ONCE(current_thread_info()->flags) &
-			_TIF_WORK_MASK;
+			_TIF_WORK_LOOP_MASK;
 
-	} while (thread_flags);
+	} while (thread_flags || !task_isolation_ready());
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
index 92ddac1e8ca2..fbc78035b2af 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -29,6 +29,7 @@
 #include <linux/sched.h>
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
+#include <linux/isolation.h>
 
 #include <asm/cpufeature.h>
 #include <asm/exception.h>
@@ -466,6 +467,9 @@ asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 	const struct fault_info *inf = fault_info + (esr & 63);
 	struct siginfo info;
 
+	if (user_mode(regs))
+		task_isolation_check_exception("%s at %#lx", inf->name, addr);
+
 	if (!inf->fn(addr, esr, regs))
 		return;
 
-- 
2.1.2
