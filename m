From: dianders@chromium.org (Douglas Anderson)
Date: Wed, 26 Aug 2015 09:20:38 -0700
Subject: [PATCH v2] arm: kgdb: Fix registers on sleeping tasks
Message-ID: <1440606038-14816-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Doug Anderson <dianders@chromium.org>

Dumping registers from other sleeping tasks in KGDB was totally
failing for me.  All registers were reported as 0 in many cases.

The code was using task_pt_regs(task) to try to get other thread
registers.  This doesn't appear to be the right place to look.  From
my tests, I saw non-zero values in this structure when we were looking
at a kernel thread that had a userspace task associated with it, but
it contained the register values from the userspace task.  So even in
the cases where registers weren't reported as 0 we were still not
showing the right thing.

Instead of using task_pt_regs(task) let's use task_thread_info(task).
This is the same place that is referred to when doing a dump of all
sleeping task stacks (kdb_show_stack() -> show_stack() ->
dump_backtrace() -> unwind_backtrace() -> thread_saved_sp()).

As further evidence that this is the right thing to do, you can find
the following comment in "gdbstub.c" right before it calls
sleeping_thread_to_gdb_regs():
  Pull stuff saved during switch_to; nothing else is accessible (or
  even particularly relevant).  This should be enough for a stack
  trace.
...and if you look at switch_to() it only saves r4-r11, sp and lr.
Those are the same registers that I'm getting out of the
task_thread_info().

With this change you can use "info thread" to see all tasks in the
kernel and you can switch to other tasks and examine them in gdb.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2:
- Don't use task_pt_regs(task) at all.

 arch/arm/kernel/kgdb.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
index a6ad93c..abb17b0 100644
--- a/arch/arm/kernel/kgdb.c
+++ b/arch/arm/kernel/kgdb.c
@@ -74,7 +74,7 @@ int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
 void
 sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
 {
-	struct pt_regs *thread_regs;
+	struct thread_info *ti;
 	int regno;
 
 	/* Just making sure... */
@@ -86,24 +86,17 @@ sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
 		gdb_regs[regno] = 0;
 
 	/* Otherwise, we have only some registers from switch_to() */
-	thread_regs		= task_pt_regs(task);
-	gdb_regs[_R0]		= thread_regs->ARM_r0;
-	gdb_regs[_R1]		= thread_regs->ARM_r1;
-	gdb_regs[_R2]		= thread_regs->ARM_r2;
-	gdb_regs[_R3]		= thread_regs->ARM_r3;
-	gdb_regs[_R4]		= thread_regs->ARM_r4;
-	gdb_regs[_R5]		= thread_regs->ARM_r5;
-	gdb_regs[_R6]		= thread_regs->ARM_r6;
-	gdb_regs[_R7]		= thread_regs->ARM_r7;
-	gdb_regs[_R8]		= thread_regs->ARM_r8;
-	gdb_regs[_R9]		= thread_regs->ARM_r9;
-	gdb_regs[_R10]		= thread_regs->ARM_r10;
-	gdb_regs[_FP]		= thread_regs->ARM_fp;
-	gdb_regs[_IP]		= thread_regs->ARM_ip;
-	gdb_regs[_SPT]		= thread_regs->ARM_sp;
-	gdb_regs[_LR]		= thread_regs->ARM_lr;
-	gdb_regs[_PC]		= thread_regs->ARM_pc;
-	gdb_regs[_CPSR]		= thread_regs->ARM_cpsr;
+	ti			= task_thread_info(task);
+	gdb_regs[_R4]		= ti->cpu_context.r4;
+	gdb_regs[_R5]		= ti->cpu_context.r5;
+	gdb_regs[_R6]		= ti->cpu_context.r6;
+	gdb_regs[_R7]		= ti->cpu_context.r7;
+	gdb_regs[_R8]		= ti->cpu_context.r8;
+	gdb_regs[_R9]		= ti->cpu_context.r9;
+	gdb_regs[_R10]		= ti->cpu_context.sl;
+	gdb_regs[_FP]		= ti->cpu_context.fp;
+	gdb_regs[_SPT]		= ti->cpu_context.sp;
+	gdb_regs[_PC]		= ti->cpu_context.pc;
 }
 
 void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
-- 
2.5.0.457.gab17608
