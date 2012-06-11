From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 11 Jun 2012 11:13:04 +0530
Subject: [PATCH] ARM: update die handler from x86
Message-ID: <1339393384-28877-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robustify ARM's die() handling with improvements from x86:

 - Fix for a deadlock (before panic in the case of panic_on_oops) if we
   oops under a spinlock which is also used from interrupt handler,
   since the old code was unconditionally enabling interrupts.

 - Usage of arch spinlock so lockdep etc doesn't get involved while
   we're trying to dump out oopses.

 - Deadlock prevention in the unlikely event that die() recurses.

The changes all touch the same few lines of code, so they're done
together in one patch.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/kernel/traps.c |   78 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 23 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 4928d89..2df8715 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -233,9 +233,9 @@ void show_stack(struct task_struct *tsk, unsigned long *sp)
 #define S_ISA " ARM"
 #endif
 
-static int __die(const char *str, int err, struct thread_info *thread, struct pt_regs *regs)
+static int __die(const char *str, int err, struct pt_regs *regs)
 {
-	struct task_struct *tsk = thread->task;
+	struct task_struct *tsk = current;
 	static int die_counter;
 	int ret;
 
@@ -245,12 +245,12 @@ static int __die(const char *str, int err, struct thread_info *thread, struct pt
 	/* trap and error numbers are mostly meaningless on ARM */
 	ret = notify_die(DIE_OOPS, str, regs, err, tsk->thread.trap_no, SIGSEGV);
 	if (ret == NOTIFY_STOP)
-		return ret;
+		return 1;
 
 	print_modules();
 	__show_regs(regs);
 	printk(KERN_EMERG "Process %.*s (pid: %d, stack limit = 0x%p)\n",
-		TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), thread + 1);
+		TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), end_of_stack(tsk));
 
 	if (!user_mode(regs) || in_interrupt()) {
 		dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
@@ -259,45 +259,77 @@ static int __die(const char *str, int err, struct thread_info *thread, struct pt
 		dump_instr(KERN_EMERG, regs);
 	}
 
-	return ret;
+	return 0;
 }
 
-static DEFINE_RAW_SPINLOCK(die_lock);
+static arch_spinlock_t die_lock = __ARCH_SPIN_LOCK_UNLOCKED;
+static int die_owner = -1;
+static unsigned int die_nest_count;
 
-/*
- * This function is protected against re-entrancy.
- */
-void die(const char *str, struct pt_regs *regs, int err)
+static unsigned long oops_begin(void)
 {
-	struct thread_info *thread = current_thread_info();
-	int ret;
-	enum bug_trap_type bug_type = BUG_TRAP_TYPE_NONE;
+	int cpu;
+	unsigned long flags;
 
 	oops_enter();
 
-	raw_spin_lock_irq(&die_lock);
+	/* racy, but better than risking deadlock. */
+	raw_local_irq_save(flags);
+	cpu = smp_processor_id();
+	if (!arch_spin_trylock(&die_lock)) {
+		if (cpu == die_owner)
+			/* nested oops. should stop eventually */;
+		else
+			arch_spin_lock(&die_lock);
+	}
+	die_nest_count++;
+	die_owner = cpu;
 	console_verbose();
 	bust_spinlocks(1);
-	if (!user_mode(regs))
-		bug_type = report_bug(regs->ARM_pc, regs);
-	if (bug_type != BUG_TRAP_TYPE_NONE)
-		str = "Oops - BUG";
-	ret = __die(str, err, thread, regs);
+	return flags;
+}
 
-	if (regs && kexec_should_crash(thread->task))
+static void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
+{
+	if (regs && kexec_should_crash(current))
 		crash_kexec(regs);
 
 	bust_spinlocks(0);
+	die_owner = -1;
 	add_taint(TAINT_DIE);
-	raw_spin_unlock_irq(&die_lock);
+	die_nest_count--;
+	if (!die_nest_count)
+		/* Nest count reaches zero, release the lock. */
+		arch_spin_unlock(&die_lock);
+	raw_local_irq_restore(flags);
 	oops_exit();
 
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 	if (panic_on_oops)
 		panic("Fatal exception");
-	if (ret != NOTIFY_STOP)
-		do_exit(SIGSEGV);
+	if (signr)
+		do_exit(signr);
+}
+
+/*
+ * This function is protected against re-entrancy.
+ */
+void die(const char *str, struct pt_regs *regs, int err)
+{
+	enum bug_trap_type bug_type = BUG_TRAP_TYPE_NONE;
+	unsigned long flags = oops_begin();
+	int sig = SIGSEGV;
+
+	if (!user_mode(regs))
+		bug_type = report_bug(regs->ARM_pc, regs);
+	if (bug_type != BUG_TRAP_TYPE_NONE)
+		str = "Oops - BUG";
+
+	if (__die(str, err, regs))
+		sig = 0;
+
+	oops_end(flags, regs, sig);
 }
 
 void arm_notify_die(const char *str, struct pt_regs *regs,
-- 
1.7.9.5
