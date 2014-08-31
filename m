From: leoy@marvell.com (Leo Yan)
Date: Sun, 31 Aug 2014 13:39:51 +0800
Subject: [PATCH v1] arm64: fix bug for reloading FPSIMD state after cpu power
 off
Message-ID: <1409463591-661-1-git-send-email-leoy@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now arm64 defers reloading FPSIMD state, but this optimization also
introduces the bug after cpu resume back from low power mode.

The reason is after the cpu has been powered off, s/w need set the
cpu's fpsimd_last_state to NULL so that it will force to reload
FPSIMD state for the thread, otherwise there has the chance to meet
the condition for both the task's fpsimd_state.cpu field contains the
id of the current cpu, and the cpu's fpsimd_last_state per-cpu variable
points to the task's fpsimd_state, so finally kernel will skip to reload
the context during it return back to userland.

Furthermore, this patch also removes the redundant operation for saving
the state for idle thread; this operation is needless due kernel's idle
thread will not use any VFP/NEON instruction. so that this also can
benefit a bit for the latency during cpu's power off.

Signed-off-by: Leo Yan <leoy@marvell.com>
---
 arch/arm64/kernel/fpsimd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index ad8aebb..4caef93 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -268,13 +268,9 @@ static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
 {
 	switch (cmd) {
 	case CPU_PM_ENTER:
-		if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE))
-			fpsimd_save_state(&current->thread.fpsimd_state);
+		this_cpu_write(fpsimd_last_state, NULL);
 		break;
 	case CPU_PM_EXIT:
-		if (current->mm)
-			set_thread_flag(TIF_FOREIGN_FPSTATE);
-		break;
 	case CPU_PM_ENTER_FAILED:
 	default:
 		return NOTIFY_DONE;
-- 
1.9.1
