From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 24 Jul 2015 16:37:49 +0100
Subject: [PATCH v3 9/9] arm64/BUG: Show explicit backtrace for WARNs
In-Reply-To: <1437752284-14847-1-git-send-email-Dave.Martin@arm.com>
References: <1437752284-14847-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1437752284-14847-10-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic slowpath WARN implementation prints a backtrace, but
the report_bug() based implementation does not, opting to print the
registers instead which is generally not as useful.

Ideally, report_bug() should be fixed to make the behaviour more
consistent, but in the meantime this patch generates a backtrace
directly from the arm64 backend instead so that this functionality
is not lost with the migration to report_bug().

As a side-effect, the backtrace will be outside the oops end
marker, but that's hard to avoid without modifying generic code.

This patch can go away if report_bug() grows the ability in the
future to generate a backtrace directly or call an arch hook at the
appropriate time.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/traps.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index b10f4bf..bc3dfc5 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -487,6 +487,8 @@ static int bug_handler(struct pt_regs *regs, unsigned int esr)
 		break;
 
 	case BUG_TRAP_TYPE_WARN:
+		/* Ideally, report_bug() should backtrace for us... but no. */
+		dump_backtrace(regs, NULL);
 		break;
 
 	default:
-- 
1.7.10.4
