From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Fri,  3 Nov 2017 13:04:49 -0400
Subject: [PATCH v16 10/13] arch/arm: enable task isolation functionality
In-Reply-To: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
References: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
Message-ID: <1509728692-10460-11-git-send-email-cmetcalf@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Francis Giraldeau <francis.giraldeau@gmail.com>

This patch is a port of the task isolation functionality to the arm 32-bit
architecture. The task isolation needs an additional thread flag that
requires to change the entry assembly code to accept a bitfield larger than
one byte.  The constants _TIF_SYSCALL_WORK and _TIF_WORK_MASK are now
defined in the literal pool. The rest of the patch is straightforward and
reflects what is done on other architectures.

To avoid problems with the tst instruction in the v7m build, we renumber
TIF_SECCOMP to bit 8 and let TIF_TASK_ISOLATION use bit 7.

Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com> [with modifications]
---
 arch/arm/Kconfig                   |  1 +
 arch/arm/include/asm/thread_info.h | 10 +++++++---
 arch/arm/kernel/entry-common.S     | 12 ++++++++----
 arch/arm/kernel/ptrace.c           | 10 ++++++++++
 arch/arm/kernel/signal.c           | 10 +++++++++-
 arch/arm/kernel/smp.c              |  4 ++++
 arch/arm/mm/fault.c                |  8 +++++++-
 7 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7888c9803eb0..3423c655a32b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -48,6 +48,7 @@ config ARM
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
+	select HAVE_ARCH_TASK_ISOLATION
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARM_SMCCC if CPU_V7
 	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 776757d1604a..a7b76ac9543d 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -142,7 +142,8 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
 #define TIF_SYSCALL_TRACE	4	/* syscall trace active */
 #define TIF_SYSCALL_AUDIT	5	/* syscall auditing active */
 #define TIF_SYSCALL_TRACEPOINT	6	/* syscall tracepoint instrumentation */
-#define TIF_SECCOMP		7	/* seccomp syscall filtering active */
+#define TIF_TASK_ISOLATION	7	/* task isolation active */
+#define TIF_SECCOMP		8	/* seccomp syscall filtering active */
 
 #define TIF_NOHZ		12	/* in adaptive nohz mode */
 #define TIF_USING_IWMMXT	17
@@ -156,18 +157,21 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
+#define _TIF_TASK_ISOLATION	(1 << TIF_TASK_ISOLATION)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
 
 /* Checks for any syscall work in entry-common.S */
 #define _TIF_SYSCALL_WORK (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
-			   _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP)
+			   _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
+			   _TIF_TASK_ISOLATION)
 
 /*
  * Change these and you break ASM code in entry-common.S
  */
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
-				 _TIF_NOTIFY_RESUME | _TIF_UPROBE)
+				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
+				 _TIF_TASK_ISOLATION)
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_ARM_THREAD_INFO_H */
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 99c908226065..9ae3ef2dbc1e 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -53,7 +53,8 @@ ret_fast_syscall:
 	cmp	r2, #TASK_SIZE
 	blne	addr_limit_check_failed
 	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
-	tst	r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
+	ldr	r2, =_TIF_SYSCALL_WORK | _TIF_WORK_MASK
+	tst	r1, r2
 	bne	fast_work_pending
 
 
@@ -83,7 +84,8 @@ ret_fast_syscall:
 	cmp	r2, #TASK_SIZE
 	blne	addr_limit_check_failed
 	ldr	r1, [tsk, #TI_FLAGS]		@ re-check for syscall tracing
-	tst	r1, #_TIF_SYSCALL_WORK | _TIF_WORK_MASK
+	ldr	r2, =_TIF_SYSCALL_WORK | _TIF_WORK_MASK
+	tst	r1, r2
 	beq	no_work_pending
  UNWIND(.fnend		)
 ENDPROC(ret_fast_syscall)
@@ -91,7 +93,8 @@ ENDPROC(ret_fast_syscall)
 	/* Slower path - fall through to work_pending */
 #endif
 
-	tst	r1, #_TIF_SYSCALL_WORK
+	ldr	r2, =_TIF_SYSCALL_WORK
+	tst	r1, r2
 	bne	__sys_trace_return_nosave
 slow_work_pending:
 	mov	r0, sp				@ 'regs'
@@ -238,7 +241,8 @@ local_restart:
 	ldr	r10, [tsk, #TI_FLAGS]		@ check for syscall tracing
 	stmdb	sp!, {r4, r5}			@ push fifth and sixth args
 
-	tst	r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
+	ldr	r11, =_TIF_SYSCALL_WORK		@ are we tracing syscalls?
+	tst	r10, r11
 	bne	__sys_trace
 
 	cmp	scno, #NR_syscalls		@ check upper syscall limit
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 58e3771e4c5b..0cfcba5a93df 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -27,6 +27,7 @@
 #include <linux/audit.h>
 #include <linux/tracehook.h>
 #include <linux/unistd.h>
+#include <linux/isolation.h>
 
 #include <asm/pgtable.h>
 #include <asm/traps.h>
@@ -936,6 +937,15 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
 
+	/*
+	 * In task isolation mode, we may prevent the syscall from
+	 * running, and if so we also deliver a signal to the process.
+	 */
+	if (test_thread_flag(TIF_TASK_ISOLATION)) {
+		if (task_isolation_syscall(scno) == -1)
+			return -1;
+	}
+
 	/* Do seccomp after ptrace; syscall may have changed. */
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
 	if (secure_computing(NULL) == -1)
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index b67ae12503f3..7c526efb301a 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -15,6 +15,7 @@
 #include <linux/tracehook.h>
 #include <linux/uprobes.h>
 #include <linux/syscalls.h>
+#include <linux/isolation.h>
 
 #include <asm/elf.h>
 #include <asm/cacheflush.h>
@@ -605,6 +606,9 @@ static int do_signal(struct pt_regs *regs, int syscall)
 	return 0;
 }
 
+#define WORK_PENDING_LOOP_FLAGS \
+	(_TIF_NEED_RESCHED | _TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE)
+
 asmlinkage int
 do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 {
@@ -641,7 +645,11 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 		}
 		local_irq_disable();
 		thread_flags = current_thread_info()->flags;
-	} while (thread_flags & _TIF_WORK_MASK);
+	} while (thread_flags & WORK_PENDING_LOOP_FLAGS);
+
+	if (thread_flags & _TIF_TASK_ISOLATION)
+		task_isolation_start();
+
 	return 0;
 }
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index c9a0a5299827..76f8b2010ddf 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/cpufreq.h>
 #include <linux/irq_work.h>
+#include <linux/isolation.h>
 
 #include <linux/atomic.h>
 #include <asm/smp.h>
@@ -525,6 +526,7 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 
 void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
 {
+	task_isolation_remote_cpumask(mask, "wakeup IPI");
 	smp_cross_call(mask, IPI_WAKEUP);
 }
 
@@ -544,6 +546,7 @@ void arch_irq_work_raise(void)
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 void tick_broadcast(const struct cpumask *mask)
 {
+	task_isolation_remote_cpumask(mask, "timer IPI");
 	smp_cross_call(mask, IPI_TIMER);
 }
 #endif
@@ -665,6 +668,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 void smp_send_reschedule(int cpu)
 {
+	task_isolation_remote(cpu, "reschedule IPI");
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 42f585379e19..052860948771 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -20,6 +20,7 @@
 #include <linux/sched/debug.h>
 #include <linux/highmem.h>
 #include <linux/perf_event.h>
+#include <linux/isolation.h>
 
 #include <asm/exception.h>
 #include <asm/pgtable.h>
@@ -352,8 +353,13 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	/*
 	 * Handle the "normal" case first - VM_FAULT_MAJOR
 	 */
-	if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP | VM_FAULT_BADACCESS))))
+	if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP |
+			      VM_FAULT_BADACCESS)))) {
+		/* No signal was generated, but notify task-isolation tasks. */
+		if (user_mode(regs))
+			task_isolation_interrupt("page fault at %#lx", addr);
 		return 0;
+	}
 
 	/*
 	 * If we are in kernel mode at this point, we
-- 
2.1.2
