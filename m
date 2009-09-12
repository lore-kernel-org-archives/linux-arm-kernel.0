From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Sep 2009 22:36:48 +0100
Subject: calls to notify_die missing -> ftrace_dump_on_oops non-functional
In-Reply-To: <20090912195454.GA32429@pengutronix.de>
References: <20090912195454.GA32429@pengutronix.de>
Message-ID: <20090912213648.GA18424@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 12, 2009 at 09:54:54PM +0200, Uwe Kleine-K?nig wrote:
> Dying on ARM looks quite different to dying on x86.  Russell, what's
> your position here?  Would you accept a patch that makes them more
> similar?

The position is that I got tired of chasing x86 in this area, and
we've got what was the most correct implementation that I could come
up with.  We do quite a number of things differently from x86,
including providing as complete as possible siginfo stuff everywhere
possible.

So, here's a patch which does an overall update to the ARM die()
implementation, including adding the notify support, kexec support
and loglevel stuff to printks.

I'm not entirely happy with this at present because it now means
that die() can now return - this requires all callers to die() to
be audited to ensure that they do something sane when die() does
return.

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index d65b2f5..5b66e51 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -73,8 +73,7 @@ extern unsigned int mem_fclk_21285;
 
 struct pt_regs;
 
-void die(const char *msg, struct pt_regs *regs, int err)
-		__attribute__((noreturn));
+void die(const char *msg, struct pt_regs *regs, int err);
 
 struct siginfo;
 void arm_notify_die(const char *str, struct pt_regs *regs, struct siginfo *info,
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 57eb0f6..1160bba 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -12,15 +12,17 @@
  *  'linux/arch/arm/lib/traps.S'.  Mostly a debugging aid, but will probably
  *  kill the offending process.
  */
-#include <linux/module.h>
 #include <linux/signal.h>
-#include <linux/spinlock.h>
 #include <linux/personality.h>
 #include <linux/kallsyms.h>
-#include <linux/delay.h>
+#include <linux/spinlock.h>
+#include <linux/uaccess.h>
 #include <linux/hardirq.h>
+#include <linux/kdebug.h>
+#include <linux/module.h>
+#include <linux/kexec.h>
+#include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/uaccess.h>
 
 #include <asm/atomic.h>
 #include <asm/cacheflush.h>
@@ -45,7 +47,7 @@ static int __init user_debug_setup(char *str)
 __setup("user_debug=", user_debug_setup);
 #endif
 
-static void dump_mem(const char *str, unsigned long bottom, unsigned long top);
+static void dump_mem(const char *, const char *, unsigned long, unsigned long);
 
 void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame)
 {
@@ -59,7 +61,7 @@ void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long
 #endif
 
 	if (in_exception_text(where))
-		dump_mem("Exception stack", frame + 4, frame + 4 + sizeof(struct pt_regs));
+		dump_mem("", "Exception stack", frame + 4, frame + 4 + sizeof(struct pt_regs));
 }
 
 #ifndef CONFIG_ARM_UNWIND
@@ -81,7 +83,8 @@ static int verify_stack(unsigned long sp)
 /*
  * Dump out the contents of some memory nicely...
  */
-static void dump_mem(const char *str, unsigned long bottom, unsigned long top)
+static void dump_mem(const char *lvl, const char *str, unsigned long bottom,
+		     unsigned long top)
 {
 	unsigned long p = bottom & ~31;
 	mm_segment_t fs;
@@ -95,10 +98,10 @@ static void dump_mem(const char *str, unsigned long bottom, unsigned long top)
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 
-	printk("%s(0x%08lx to 0x%08lx)\n", str, bottom, top);
+	printk("%s%s(0x%08lx to 0x%08lx)\n", lvl, str, bottom, top);
 
 	for (p = bottom & ~31; p < top;) {
-		printk("%04lx: ", p & 0xffff);
+		printk("%s%04lx: ", lvl, p & 0xffff);
 
 		for (i = 0; i < 8; i++, p += 4) {
 			unsigned int val;
@@ -110,13 +113,13 @@ static void dump_mem(const char *str, unsigned long bottom, unsigned long top)
 				printk("%08x ", val);
 			}
 		}
-		printk ("\n");
+		printk("\n");
 	}
 
 	set_fs(fs);
 }
 
-static void dump_instr(struct pt_regs *regs)
+static void dump_instr(const char *lvl, struct pt_regs *regs)
 {
 	unsigned long addr = instruction_pointer(regs);
 	const int thumb = thumb_mode(regs);
@@ -132,7 +135,7 @@ static void dump_instr(struct pt_regs *regs)
 	fs = get_fs();
 	set_fs(KERNEL_DS);
 
-	printk("Code: ");
+	printk("%sCode: ", lvl);
 	for (i = -4; i < 1; i++) {
 		unsigned int val, bad;
 
@@ -219,24 +222,34 @@ void show_stack(struct task_struct *tsk, unsigned long *sp)
 #define S_SMP ""
 #endif
 
-static void __die(const char *str, int err, struct thread_info *thread, struct pt_regs *regs)
+static int __die(const char *str, int err, struct thread_info *thread, struct pt_regs *regs)
 {
 	struct task_struct *tsk = thread->task;
 	static int die_counter;
+	int ret;
 
-	printk("Internal error: %s: %x [#%d]" S_PREEMPT S_SMP "\n",
+	printk(KERN_EMERG "Internal error: %s: %x [#%d]" S_PREEMPT S_SMP "\n",
 	       str, err, ++die_counter);
+	sysfs_printk_last_file();
+
+	/* trap and error numbers are mostly meaningless on ARM */
+	ret = notify_die(DIE_OOPS, str, regs, err, tsk->thread.trap_no, SIGSEGV);
+	if (ret == NOTIFY_STOP)
+		return ret;
+
 	print_modules();
 	__show_regs(regs);
-	printk("Process %s (pid: %d, stack limit = 0x%p)\n",
-		tsk->comm, task_pid_nr(tsk), thread + 1);
+	printk(KERN_EMERG "Process %.*s (pid: %d, stack limit = 0x%p)\n",
+		TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), thread + 1);
 
 	if (!user_mode(regs) || in_interrupt()) {
-		dump_mem("Stack: ", regs->ARM_sp,
+		dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
 			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
 		dump_backtrace(regs, tsk);
-		dump_instr(regs);
+		dump_instr(KERN_EMERG, regs);
 	}
+
+	return ret;
 }
 
 DEFINE_SPINLOCK(die_lock);
@@ -244,28 +257,32 @@ DEFINE_SPINLOCK(die_lock);
 /*
  * This function is protected against re-entrancy.
  */
-NORET_TYPE void die(const char *str, struct pt_regs *regs, int err)
+void die(const char *str, struct pt_regs *regs, int err)
 {
 	struct thread_info *thread = current_thread_info();
+	int ret;
 
 	oops_enter();
 
-	console_verbose();
 	spin_lock_irq(&die_lock);
+	console_verbose();
 	bust_spinlocks(1);
-	__die(str, err, thread, regs);
+	ret = __die(str, err, thread, regs);
+
+	if (regs && kexec_should_crash(thread->task))
+		crash_kexec(regs);
+
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE);
 	spin_unlock_irq(&die_lock);
+	oops_exit();
 
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
-
 	if (panic_on_oops)
 		panic("Fatal exception");
-
-	oops_exit();
-	do_exit(SIGSEGV);
+	if (ret != NOTIFY_STOP)
+		do_exit(SIGSEGV);
 }
 
 void arm_notify_die(const char *str, struct pt_regs *regs,
@@ -349,7 +366,7 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	if (user_debug & UDBG_UNDEFINED) {
 		printk(KERN_INFO "%s (%d): undefined instruction: pc=%p\n",
 			current->comm, task_pid_nr(current), pc);
-		dump_instr(regs);
+		dump_instr(KERN_INFO, regs);
 	}
 #endif
 
@@ -400,7 +417,7 @@ static int bad_syscall(int n, struct pt_regs *regs)
 	if (user_debug & UDBG_SYSCALL) {
 		printk(KERN_ERR "[%d] %s: obsolete system call %08x.\n",
 			task_pid_nr(current), current->comm, n);
-		dump_instr(regs);
+		dump_instr(KERN_ERR, regs);
 	}
 #endif
 
@@ -576,7 +593,7 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 	if (user_debug & UDBG_SYSCALL) {
 		printk("[%d] %s: arm syscall %d\n",
 		       task_pid_nr(current), current->comm, no);
-		dump_instr(regs);
+		dump_instr("", regs);
 		if (user_mode(regs)) {
 			__show_regs(regs);
 			c_backtrace(regs->ARM_fp, processor_mode(regs));
@@ -653,7 +670,7 @@ baddataabort(int code, unsigned long instr, struct pt_regs *regs)
 	if (user_debug & UDBG_BADABORT) {
 		printk(KERN_ERR "[%d] %s: bad data abort: code %d instr 0x%08lx\n",
 			task_pid_nr(current), current->comm, code, instr);
-		dump_instr(regs);
+		dump_instr(KERN_ERR, regs);
 		show_pte(current->mm, addr);
 	}
 #endif
