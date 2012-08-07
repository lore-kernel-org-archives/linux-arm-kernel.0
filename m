From: will.deacon@arm.com (Will Deacon)
Date: Tue,  7 Aug 2012 16:49:48 +0100
Subject: [PATCH 2/2] ARM: hw_breakpoints: allow single-byte watchpoints on all
 addresses
In-Reply-To: <1344354588-28153-1-git-send-email-will.deacon@arm.com>
References: <1344354588-28153-1-git-send-email-will.deacon@arm.com>
Message-ID: <1344354588-28153-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Breakpoint validation currently fails for single-byte watchpoints on
addresses ending in 11b. There is no reason to forbid such a watchpoint,
so extend the validation code to allow it.

Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 418d980..4eedfde 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -610,13 +610,14 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 		/* Aligned */
 		break;
 	case 1:
-		/* Allow single byte watchpoint. */
-		if (info->ctrl.len == ARM_BREAKPOINT_LEN_1)
-			break;
 	case 2:
 		/* Allow halfword watchpoints and breakpoints. */
 		if (info->ctrl.len == ARM_BREAKPOINT_LEN_2)
 			break;
+	case 3:
+		/* Allow single byte watchpoint. */
+		if (info->ctrl.len == ARM_BREAKPOINT_LEN_1)
+			break;
 	default:
 		ret = -EINVAL;
 		goto out;
-- 
1.7.4.1
