From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Fri,  3 Nov 2017 13:04:48 -0400
Subject: [PATCH v16 09/13] arch/arm64: enable task isolation functionality
In-Reply-To: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
References: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
Message-ID: <1509728692-10460-10-git-send-email-cmetcalf@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In do_notify_resume(), call task_isolation_start() for
TIF_TASK_ISOLATION tasks.  Add _TIF_TASK_ISOLATION to _TIF_WORK_MASK,
and define a local NOTIFY_RESUME_LOOP_FLAGS to check in the loop,
since we don't clear _TIF_TASK_ISOLATION in the loop.

We tweak syscall_trace_enter() slightly to carry the "flags"
value from current_thread_info()->flags for each of the tests,
rather than doing a volatile read from memory for each one.  This
avoids a small overhead for each test, and in particular avoids
that overhead for TIF_NOHZ when TASK_ISOLATION is not enabled.

We instrument the smp_send_reschedule() routine so that it checks for
isolated tasks and generates a suitable warning if needed.

Finally, report on page faults in task-isolation processes in
do_page_faults().

Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/thread_info.h |  5 ++++-
 arch/arm64/kernel/ptrace.c           | 18 +++++++++++++++---
 arch/arm64/kernel/signal.c           | 10 +++++++++-
 arch/arm64/kernel/smp.c              |  7 +++++++
 arch/arm64/mm/fault.c                |  5 +++++
 6 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6a56d4..d77ecdb29765 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -73,6 +73,7 @@ config ARM64
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ARCH_TASK_ISOLATION
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_VMAP_STACK
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index ddded6497a8a..9c749eca7384 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -82,6 +82,7 @@ void arch_setup_new_exec(void);
 #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
 #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
 #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
+#define TIF_TASK_ISOLATION	6
 #define TIF_NOHZ		7
 #define TIF_SYSCALL_TRACE	8
 #define TIF_SYSCALL_AUDIT	9
@@ -97,6 +98,7 @@ void arch_setup_new_exec(void);
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
+#define _TIF_TASK_ISOLATION	(1 << TIF_TASK_ISOLATION)
 #define _TIF_NOHZ		(1 << TIF_NOHZ)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
@@ -108,7 +110,8 @@ void arch_setup_new_exec(void);
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
-				 _TIF_UPROBE | _TIF_FSCHECK)
+				 _TIF_UPROBE | _TIF_FSCHECK | \
+				 _TIF_TASK_ISOLATION)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 9cbb6123208f..e5c0d7cdaf4e 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -38,6 +38,7 @@
 #include <linux/regset.h>
 #include <linux/tracehook.h>
 #include <linux/elf.h>
+#include <linux/isolation.h>
 
 #include <asm/compat.h>
 #include <asm/debug-monitors.h>
@@ -1371,14 +1372,25 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 
 asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
-	if (test_thread_flag(TIF_SYSCALL_TRACE))
+	unsigned long work = READ_ONCE(current_thread_info()->flags);
+
+	if (work & _TIF_SYSCALL_TRACE)
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
 
-	/* Do the secure computing after ptrace; failures should be fast. */
+	/*
+	 * In task isolation mode, we may prevent the syscall from
+	 * running, and if so we also deliver a signal to the process.
+	 */
+	if (work & _TIF_TASK_ISOLATION) {
+		if (task_isolation_syscall(regs->syscallno) == -1)
+			return -1;
+	}
+
+	/* Do the secure computing check early; failures should be fast. */
 	if (secure_computing(NULL) == -1)
 		return -1;
 
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
+	if (work & _TIF_SYSCALL_TRACEPOINT)
 		trace_sys_enter(regs, regs->syscallno);
 
 	audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1],
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 0bdc96c61bc0..d8f4904e992f 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -30,6 +30,7 @@
 #include <linux/tracehook.h>
 #include <linux/ratelimit.h>
 #include <linux/syscalls.h>
+#include <linux/isolation.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/elf.h>
@@ -741,6 +742,10 @@ static void do_signal(struct pt_regs *regs)
 	restore_saved_sigmask();
 }
 
+#define NOTIFY_RESUME_LOOP_FLAGS				     \
+	(_TIF_NEED_RESCHED | _TIF_SIGPENDING |  _TIF_NOTIFY_RESUME | \
+	 _TIF_FOREIGN_FPSTATE | _TIF_UPROBE | _TIF_FSCHECK)
+
 asmlinkage void do_notify_resume(struct pt_regs *regs,
 				 unsigned int thread_flags)
 {
@@ -777,5 +782,8 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 
 		local_irq_disable();
 		thread_flags = READ_ONCE(current_thread_info()->flags);
-	} while (thread_flags & _TIF_WORK_MASK);
+	} while (thread_flags & NOTIFY_RESUME_LOOP_FLAGS);
+
+	if (thread_flags & _TIF_TASK_ISOLATION)
+		task_isolation_start();
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 9f7195a5773e..4159c40de3b4 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -40,6 +40,7 @@
 #include <linux/of.h>
 #include <linux/irq_work.h>
 #include <linux/kexec.h>
+#include <linux/isolation.h>
 
 #include <asm/alternative.h>
 #include <asm/atomic.h>
@@ -818,6 +819,7 @@ void arch_send_call_function_single_ipi(int cpu)
 #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
 void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
 {
+	task_isolation_remote_cpumask(mask, "wakeup IPI");
 	smp_cross_call(mask, IPI_WAKEUP);
 }
 #endif
@@ -879,6 +881,9 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		__inc_irq_stat(cpu, ipi_irqs[ipinr]);
 	}
 
+	task_isolation_interrupt("IPI type %d (%s)", ipinr,
+				 ipinr < NR_IPI ? ipi_types[ipinr] : "unknown");
+
 	switch (ipinr) {
 	case IPI_RESCHEDULE:
 		scheduler_ipi();
@@ -941,12 +946,14 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 void smp_send_reschedule(int cpu)
 {
+	task_isolation_remote(cpu, "reschedule IPI");
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 void tick_broadcast(const struct cpumask *mask)
 {
+	task_isolation_remote_cpumask(mask, "timer IPI");
 	smp_cross_call(mask, IPI_TIMER);
 }
 #endif
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b64958b23a7f..bff2f84d5f4e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -32,6 +32,7 @@
 #include <linux/perf_event.h>
 #include <linux/preempt.h>
 #include <linux/hugetlb.h>
+#include <linux/isolation.h>
 
 #include <asm/bug.h>
 #include <asm/cmpxchg.h>
@@ -495,6 +496,10 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	 */
 	if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP |
 			      VM_FAULT_BADACCESS)))) {
+		/* No signal was generated, but notify task-isolation tasks. */
+		if (user_mode(regs))
+			task_isolation_interrupt("page fault at %#lx", addr);
+
 		/*
 		 * Major/minor page fault accounting is only done
 		 * once. If we go through a retry, it is extremely
-- 
2.1.2
