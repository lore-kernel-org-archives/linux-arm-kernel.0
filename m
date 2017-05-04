From: pmladek@suse.com (Petr Mladek)
Date: Thu,  4 May 2017 17:46:03 +0200
Subject: [PATCH v2] printk: Use the main logbuf in NMI when logbuf_lock is
 available
Message-ID: <1493912763-24873-1-git-send-email-pmladek@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit 42a0bb3f71383b457a7d ("printk/nmi: generic solution for safe
printk in NMI") caused that printk stores messages into a temporary
buffer in NMI context.

The buffer is per-CPU and therefore the size is rather limited.
It works quite well for NMI backtraces. But there are longer logs
that might get printed in NMI context, for example, lockdep
warnings, ftrace_dump_on_oops.

The temporary buffer is used to avoid deadlocks caused by
logbuf_lock. Also it is needed to avoid races with the other
temporary buffer that is used when PRINTK_SAFE_CONTEXT is entered.
But the main buffer can be used in NMI if the lock is available
and we did not interrupt PRINTK_SAFE_CONTEXT.

The lock is checked using raw_spin_is_locked(). It might cause
false negatives when the lock is taken on another CPU and
this CPU is in the safe context from other reasons. Note that
the safe context is used also to get console semaphore or when
calling console drivers. For this reason, we do the check in
printk_nmi_enter(). It makes the handling consistent for
the entire NMI handler and avoids reshuffling of the messages.

The patch also defines special printk context that allows
to use printk_deferred() in NMI. Note that we could not flush
the messages to the consoles because console drivers might use
many other internal locks.

The newly created vprintk_deferred() disables the preemption
only around the irq work handling. It is needed there to keep
the consistency between the two per-CPU variables. But there
is no reason to disable preemption around vprintk_emit().

Finally, the patch puts back explicit serialization of the NMI
backtraces from different CPUs. It was removed by the
commit a9edc88093287183ac934b ("x86/nmi: Perform a safe
NMI stack trace on all CPUs"). It was not needed because
the flushing of the temporary per-CPU buffers was serialized.

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---

Changes against v1:

  + improved the check of logbuf_lock state to reduce false
    negatives; updated the related comment and the commit
    message accordingly

The discussion about the previous version started at
https://lkml.kernel.org/r/20170420131154.GL3452 at pathway.suse.cz


 kernel/printk/internal.h    |  6 ++++--
 kernel/printk/printk.c      | 19 ++++++++++++++-----
 kernel/printk/printk_safe.c | 26 ++++++++++++++++++++++++--
 lib/nmi_backtrace.c         |  3 +++
 4 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 1db044f808b7..2a7d04049af4 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -18,12 +18,14 @@
 
 #ifdef CONFIG_PRINTK
 
-#define PRINTK_SAFE_CONTEXT_MASK	0x7fffffff
-#define PRINTK_NMI_CONTEXT_MASK	0x80000000
+#define PRINTK_SAFE_CONTEXT_MASK	 0x3fffffff
+#define PRINTK_NMI_DEFERRED_CONTEXT_MASK 0x40000000
+#define PRINTK_NMI_CONTEXT_MASK		 0x80000000
 
 extern raw_spinlock_t logbuf_lock;
 
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
+__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args);
 void __printk_safe_enter(void);
 void __printk_safe_exit(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2984fb0f0257..16b519927d35 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2691,16 +2691,13 @@ void wake_up_klogd(void)
 	preempt_enable();
 }
 
-int printk_deferred(const char *fmt, ...)
+int vprintk_deferred(const char *fmt, va_list args)
 {
-	va_list args;
 	int r;
 
-	preempt_disable();
-	va_start(args, fmt);
 	r = vprintk_emit(0, LOGLEVEL_SCHED, NULL, 0, fmt, args);
-	va_end(args);
 
+	preempt_disable();
 	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
 	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
 	preempt_enable();
@@ -2708,6 +2705,18 @@ int printk_deferred(const char *fmt, ...)
 	return r;
 }
 
+int printk_deferred(const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	va_start(args, fmt);
+	r = vprintk_deferred(fmt, args);
+	va_end(args);
+
+	return r;
+}
+
 /*
  * printk rate limiting, lifted from the networking subsystem.
  *
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 033e50a7d706..6b43dda2b71b 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -308,12 +308,24 @@ static int vprintk_nmi(const char *fmt, va_list args)
 
 void printk_nmi_enter(void)
 {
-	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
+	/*
+	 * The size of the extra per-CPU buffer is limited. Use it only when
+	 * the main one is locked. If this CPU is not in the safe context,
+	 * the lock must be taken on another CPU and we could wait for it.
+	 */
+	if (raw_spin_is_locked(&logbuf_lock) &&
+	    this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK) {
+		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
+	} else {
+		this_cpu_or(printk_context, PRINTK_NMI_DEFERRED_CONTEXT_MASK);
+	}
 }
 
 void printk_nmi_exit(void)
 {
-	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
+	this_cpu_and(printk_context,
+		     ~(PRINTK_NMI_CONTEXT_MASK ||
+		       PRINTK_NMI_DEFERRED_CONTEXT_MASK));
 }
 
 #else
@@ -351,12 +363,22 @@ void __printk_safe_exit(void)
 
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 {
+	/* Use extra buffer in NMI when logbuf_lock is taken or in safe mode. */
 	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
 		return vprintk_nmi(fmt, args);
 
+	/* Use extra buffer to prevent a recursion deadlock in safe mode. */
 	if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK)
 		return vprintk_safe(fmt, args);
 
+	/*
+	 * Use the main logbuf when logbuf_lock is available in NMI.
+	 * But avoid calling console drivers that might have their own locks.
+	 */
+	if (this_cpu_read(printk_context) & PRINTK_NMI_DEFERRED_CONTEXT_MASK)
+		return vprintk_deferred(fmt, args);
+
+	/* No obstacles. */
 	return vprintk_default(fmt, args);
 }
 
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 4e8a30d1c22f..0bc0a3535a8a 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -86,9 +86,11 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 
 bool nmi_cpu_backtrace(struct pt_regs *regs)
 {
+	static arch_spinlock_t lock = __ARCH_SPIN_LOCK_UNLOCKED;
 	int cpu = smp_processor_id();
 
 	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
+		arch_spin_lock(&lock);
 		if (regs && cpu_in_idle(instruction_pointer(regs))) {
 			pr_warn("NMI backtrace for cpu %d skipped: idling at pc %#lx\n",
 				cpu, instruction_pointer(regs));
@@ -99,6 +101,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 			else
 				dump_stack();
 		}
+		arch_spin_unlock(&lock);
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
 	}
-- 
1.8.5.6
