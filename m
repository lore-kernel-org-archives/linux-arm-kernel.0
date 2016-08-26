From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Aug 2016 11:57:11 +0100
Subject: [PATCH] arm64: debug: avoid resetting stepping state machine when
 TIF_SINGLESTEP
Message-ID: <1472209031-25681-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When TIF_SINGLESTEP is set for a task, the single-step state machine is
enabled and we must take care not to reset it to the active-not-pending
state if it is already in the active-pending state.

Unfortunately, that's exactly what user_enable_single_step does, by
unconditionally setting the SS bit in the SPSR for the current task.
This causes failures in the GDB testsuite, where GDB ends up missing
expected step traps if the instruction being stepped generates another
trap, e.g. PTRACE_EVENT_FORK from an SVC instruction.

This patch fixes the problem by preserving the current state of the
stepping state machine when TIF_SINGLESTEP is set on the current thread.

Cc: <stable@vger.kernel.org>
Reported-by: Yao Qi <yao.qi@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/debug-monitors.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 3f9023654dac..30821928106f 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -417,8 +417,10 @@ NOKPROBE_SYMBOL(kernel_active_single_step);
 /* ptrace API */
 void user_enable_single_step(struct task_struct *task)
 {
-	set_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP);
-	set_regs_spsr_ss(task_pt_regs(task));
+	struct thread_info *ti = task_thread_info(task);
+
+	if (!test_and_set_ti_thread_flag(ti, TIF_SINGLESTEP))
+		set_regs_spsr_ss(task_pt_regs(task));
 }
 NOKPROBE_SYMBOL(user_enable_single_step);
 
-- 
2.1.4
