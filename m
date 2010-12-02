From: will.deacon@arm.com (Will Deacon)
Date: Thu,  2 Dec 2010 13:45:59 +0000
Subject: [PATCH 08/11] ARM: hw_breakpoint: disallow per-cpu breakpoints
	without overflow handler
In-Reply-To: <1291297562-8052-1-git-send-email-will.deacon@arm.com>
References: <1291297562-8052-1-git-send-email-will.deacon@arm.com>
Message-ID: <1291297562-8052-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Single-stepping a breakpoint requires us to disable it temporarily so that
we don't get stuck in a recursive debug trap. With per-cpu breakpoints this
presents a problem where an interrupt can be taken before the single-step has
completed and a new task is eventually scheduled. This new task will not
hit the breakpoint because it will have been disabled during the previous
handling code.

This patch disallows per-cpu breakpoints on ARM when an overflow handler
is not present. A similar effect can be created by placing breakpoints on
a shell and then running applications there.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 36cd768..eef1b1e 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -622,10 +622,12 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * Currently we rely on an overflow handler to take
 	 * care of single-stepping the breakpoint when it fires.
 	 * In the case of userspace breakpoints on a core with V7 debug,
-	 * we can use the mismatch feature as a poor-man's hardware single-step.
+	 * we can use the mismatch feature as a poor-man's hardware
+	 * single-step, but this only works for per-task breakpoints.
 	 */
 	if (WARN_ONCE(!bp->overflow_handler &&
-		(arch_check_bp_in_kernelspace(bp) || !core_has_mismatch_brps()),
+		(arch_check_bp_in_kernelspace(bp) || !core_has_mismatch_brps()
+		 || !bp->hw.bp_target),
 			"overflow handler required but none found")) {
 		ret = -EINVAL;
 	}
-- 
1.7.0.4
