From: test.tberghammer@gmail.com (Pavel Labath)
Date: Fri, 23 Sep 2016 16:18:59 +0100
Subject: [PATCH 1/3] arm64: hw_breakpoint: Add get_hwbkt_alignment_mask
Message-ID: <1474643941-109020-1-git-send-email-labath@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds a utility function for computing the alignment mask of a
hardware breakpoint and fixes arch_validate_hwbkpt_settings to use that
instead.

Signed-off-by: Pavel Labath <labath@google.com>
---
 arch/arm64/kernel/hw_breakpoint.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 26a6bf7..14562ae 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -473,6 +473,16 @@ static int arch_build_bp_info(struct perf_event *bp)
 	return 0;
 }
 
+static unsigned int get_hwbkpt_alignment_mask(struct perf_event *bp)
+{
+	const struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+
+	if (is_compat_bp(bp))
+		return info->ctrl.len == ARM_BREAKPOINT_LEN_8 ? 0x7 : 0x3;
+	else
+		return info->ctrl.type == ARM_BREAKPOINT_EXECUTE ? 0x3 : 0x7;
+}
+
 /*
  * Validate the arch-specific HW Breakpoint register settings.
  */
@@ -496,11 +506,8 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * AArch32 tasks expect some simple alignment fixups, so emulate
 	 * that here.
 	 */
+	alignment_mask = get_hwbkpt_alignment_mask(bp);
 	if (is_compat_bp(bp)) {
-		if (info->ctrl.len == ARM_BREAKPOINT_LEN_8)
-			alignment_mask = 0x7;
-		else
-			alignment_mask = 0x3;
 		offset = info->address & alignment_mask;
 		switch (offset) {
 		case 0:
@@ -521,10 +528,6 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 		info->address &= ~alignment_mask;
 		info->ctrl.len <<= offset;
 	} else {
-		if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE)
-			alignment_mask = 0x3;
-		else
-			alignment_mask = 0x7;
 		if (info->address & alignment_mask)
 			return -EINVAL;
 	}
-- 
2.8.0.rc3.226.g39d4020
