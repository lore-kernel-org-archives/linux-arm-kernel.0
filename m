From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Sep 2015 17:16:13 +0100
Subject: [PATCH] arm64: hw_breakpoint: use target state to determine ABI
 behaviour
Message-ID: <1442333773-16446-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 hw_breakpoint interface is slightly less flexible than its
32-bit counterpart, thanks to some changes in the architecture rendering
unaligned watchpoint addresses obselete for AArch64.

However, in a multi-arch environment (i.e. debugging a 32-bit target
with a 64-bit GDB under a 64-bit kernel), we need to provide a feature
compatible interface to GDB in order for debugging to function correctly.

This patch adds a new helper, is_compat_bp,  to our hw_breakpoint
implementation which changes the interface behaviour based on the
architecture of the debug target as opposed to the debugger itself.
This allows debugged to function as expected for multi-arch
configurations without relying on deprecated architectural behaviours
when debugging native applications.

Cc: Yao Qi <yao.qi@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/hw_breakpoint.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index bba85c8f8037..2926c3dd6479 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -163,6 +163,12 @@ enum hw_breakpoint_ops {
 	HW_BREAKPOINT_RESTORE
 };
 
+static int is_compat_bp(struct perf_event *bp)
+{
+	struct task_struct *tsk = bp->hw.target;
+	return tsk && is_compat_thread(task_thread_info(tsk));
+}
+
 /**
  * hw_breakpoint_slot_setup - Find and setup a perf slot according to
  *			      operations
@@ -420,7 +426,7 @@ static int arch_build_bp_info(struct perf_event *bp)
 	 * Watchpoints can be of length 1, 2, 4 or 8 bytes.
 	 */
 	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
-		if (is_compat_task()) {
+		if (is_compat_bp(bp)) {
 			if (info->ctrl.len != ARM_BREAKPOINT_LEN_2 &&
 			    info->ctrl.len != ARM_BREAKPOINT_LEN_4)
 				return -EINVAL;
@@ -477,7 +483,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * AArch32 tasks expect some simple alignment fixups, so emulate
 	 * that here.
 	 */
-	if (is_compat_task()) {
+	if (is_compat_bp(bp)) {
 		if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
 			alignment_mask = 0x7;
 		else
-- 
2.1.4
