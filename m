From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue,  3 Oct 2017 14:10:19 +0900
Subject: [PATCH v4 3/3] kgdb: select a correct cpu while in a single stepping
In-Reply-To: <20171003051019.29714-1-takahiro.akashi@linaro.org>
References: <20171003051019.29714-1-takahiro.akashi@linaro.org>
Message-ID: <20171003051019.29714-4-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a breakpoint is set somewhere in an irq handler and it is hit
almost at the same time on multiple cpus, we may see the following
error from gdb in trying to do a single stepping:

  (gdb) si
  /home/tcwg-buildslave/workspace/tcwg-make-release/label/docker-trusty
  -amd64-tcwg-build/target/aarch64-linux-gnu/snapshots/binutils-gdb.git
  ~gdb-7.12-branch/gdb/infrun.c:5565: internal-error: int finish_step_o
  ver(execution_control_state*): Assertion `ecs->event_thread->control.
  trap_expected' failed.
  A problem internal to GDB has been detected,
  further debugging may prove unreliable.
  Quit this debugging session? (y or n)

This message indicates that, before and after a single stepping,
different cpus/tasks are selected as a kgdb master in kgdb_cpu_enter
(DCPU_WANT_MASTER).

This issue was seen on arm64 when a breakpoint was set, for example,
to gic_handle_irq.

How can this happen?
With the following commit, kgdb_cpu_enter() tries to "only enter on
the processor that was single stepping."

  commit 028e7b175970
  Author: Jason Wessel <jason.wessel@windriver.com>
  Date:   Fri Dec 11 08:43:17 2009 -0600

      kgdb: allow for cpu switch when single stepping

If idle task is running when a breakpoint is hit, kgdb_info[cpu].task
is set to current, pid of which is 0 (zero).
(Actually 'current' has nothing to do with this breakpoint though.)
Then if a few cpus are competing for becoming a kgdb master while in
idle state,

        if (atomic_read(&kgdb_cpu_doing_single_step) != -1 &&
            (kgdb_info[cpu].task &&
             kgdb_info[cpu].task->pid != kgdb_sstep_pid) && --sstep_tries)

this check will mistakenly pass and select a wrong cpu just because
kgdb_info[cpu].task->pid can be equal to 0 for all of the cpus at this
point.

So the issue is fixed in this patch by using 'task_struct *' instead of
process id to identify a targeted single-stepping cpu.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jason Wessel <jason.wessel@windriver.com>
---
 kernel/debug/debug_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 65c0f1363788..4dd2a41c8309 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -135,7 +135,7 @@ struct task_struct		*kgdb_usethread;
 struct task_struct		*kgdb_contthread;
 
 int				kgdb_single_step;
-static pid_t			kgdb_sstep_pid;
+static struct task_struct	*kgdb_sstep_thread;
 
 /* to keep track of the CPU which is doing the single stepping*/
 atomic_t			kgdb_cpu_doing_single_step = ATOMIC_INIT(-1);
@@ -555,7 +555,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 	 */
 	if (atomic_read(&kgdb_cpu_doing_single_step) != -1 &&
 	    (kgdb_info[cpu].task &&
-	     kgdb_info[cpu].task->pid != kgdb_sstep_pid) && --sstep_tries) {
+	     kgdb_info[cpu].task != kgdb_sstep_thread) && --sstep_tries) {
 		atomic_set(&kgdb_active, -1);
 		raw_spin_unlock(&dbg_master_lock);
 		dbg_touch_watchdogs();
@@ -658,9 +658,9 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 	if (atomic_read(&kgdb_cpu_doing_single_step) != -1) {
 		int sstep_cpu = atomic_read(&kgdb_cpu_doing_single_step);
 		if (kgdb_info[sstep_cpu].task)
-			kgdb_sstep_pid = kgdb_info[sstep_cpu].task->pid;
+			kgdb_sstep_thread = kgdb_info[sstep_cpu].task;
 		else
-			kgdb_sstep_pid = 0;
+			kgdb_sstep_thread = NULL;
 	}
 	if (arch_kgdb_ops.correct_hw_break)
 		arch_kgdb_ops.correct_hw_break();
-- 
2.14.1
