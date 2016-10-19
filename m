From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Oct 2016 20:10:28 +0100
Subject: [PATCH 04/10] arm64: traps: simplify die() and __die()
In-Reply-To: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
References: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1476904234-9511-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In arm64's die and __die routines we pass around a thread_info, and
subsequently use this to determine the relevant task_struct, and the end
of the thread's stack. Subsequent patches will decouple thread_info from
the stack, and this approach will no longer work.

To figure out the end of the stack, we can use the new generic
end_of_stack() helper. As we only call __die() from die(), and die()
always deals with the current task, we can remove the parameter and have
both acquire current directly, which also makes it clear that __die
can't be called for arbitrary tasks.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/traps.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 32d4bdb..1cfbe10 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -228,10 +228,9 @@ void show_stack(struct task_struct *tsk, unsigned long *sp)
 #endif
 #define S_SMP " SMP"
 
-static int __die(const char *str, int err, struct thread_info *thread,
-		 struct pt_regs *regs)
+static int __die(const char *str, int err, struct pt_regs *regs)
 {
-	struct task_struct *tsk = thread->task;
+	struct task_struct *tsk = current;
 	static int die_counter;
 	int ret;
 
@@ -246,7 +245,8 @@ static int __die(const char *str, int err, struct thread_info *thread,
 	print_modules();
 	__show_regs(regs);
 	pr_emerg("Process %.*s (pid: %d, stack limit = 0x%p)\n",
-		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk), thread + 1);
+		 TASK_COMM_LEN, tsk->comm, task_pid_nr(tsk),
+		 end_of_stack(tsk));
 
 	if (!user_mode(regs)) {
 		dump_mem(KERN_EMERG, "Stack: ", regs->sp,
@@ -265,7 +265,6 @@ static int __die(const char *str, int err, struct thread_info *thread,
  */
 void die(const char *str, struct pt_regs *regs, int err)
 {
-	struct thread_info *thread = current_thread_info();
 	int ret;
 
 	oops_enter();
@@ -273,9 +272,9 @@ void die(const char *str, struct pt_regs *regs, int err)
 	raw_spin_lock_irq(&die_lock);
 	console_verbose();
 	bust_spinlocks(1);
-	ret = __die(str, err, thread, regs);
+	ret = __die(str, err, regs);
 
-	if (regs && kexec_should_crash(thread->task))
+	if (regs && kexec_should_crash(current))
 		crash_kexec(regs);
 
 	bust_spinlocks(0);
-- 
1.9.1
