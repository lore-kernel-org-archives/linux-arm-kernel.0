From: panand@redhat.com (Pratyush Anand)
Date: Fri,  7 Jul 2017 17:33:58 +0530
Subject: [PATCH V2 2/4] arm64: use hw_breakpoint_needs_single_step() to decide
 if step is needed
In-Reply-To: <cover.1499416107.git.panand@redhat.com>
References: <cover.1499416107.git.panand@redhat.com>
Message-ID: <53c57967c400d44bb0b3b3622d8dbe0108642247.1499416107.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we use is_default_overflow_handler() to decide whether a
"step" will be needed or not. However, is_default_overflow_handler() is
true only for perf implementation. There can be some custom kernel
module tests like samples/hw_breakpoint/data_breakpoint.c which can
rely on default step handler.

hw_breakpoint_needs_single_step() will be true if any hw_breakpoint user
wants to use default step handler and sets step_needed in attribute.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/hw_breakpoint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 749f81779420..9a73f85ab9ad 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -661,7 +661,7 @@ static int breakpoint_handler(unsigned long unused, unsigned int esr,
 		perf_bp_event(bp, regs);
 
 		/* Do we need to handle the stepping? */
-		if (is_default_overflow_handler(bp))
+		if (hw_breakpoint_needs_single_step(bp))
 			step = 1;
 unlock:
 		rcu_read_unlock();
@@ -789,7 +789,7 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
 		perf_bp_event(wp, regs);
 
 		/* Do we need to handle the stepping? */
-		if (is_default_overflow_handler(wp))
+		if (hw_breakpoint_needs_single_step(wp))
 			step = 1;
 	}
 	if (min_dist > 0 && min_dist != -1) {
@@ -800,7 +800,7 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
 		perf_bp_event(wp, regs);
 
 		/* Do we need to handle the stepping? */
-		if (is_default_overflow_handler(wp))
+		if (hw_breakpoint_needs_single_step(wp))
 			step = 1;
 	}
 	rcu_read_unlock();
-- 
2.9.3
