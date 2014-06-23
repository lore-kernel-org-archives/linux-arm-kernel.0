From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Sun, 22 Jun 2014 22:11:50 -0500
Subject: [PATCH v7 1/9] clocksource: arm_arch_timer: change clocksource name
 if CP15 unavailable
In-Reply-To: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <1403493118-7597-2-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm and arm64 VDSOs need CP15 access to the architected counter.
If this is unavailable (which is allowed by ARM v7), indicate this by
changing the clocksource name to "arch_mem_counter" before registering
the clocksource.

Suggested by Stephen Boyd.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 drivers/clocksource/arm_arch_timer.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5163ec13429d..c99afdf12e98 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -429,11 +429,19 @@ static void __init arch_counter_register(unsigned type)
 	u64 start_count;
 
 	/* Register the CP15 based counter if we have one */
-	if (type & ARCH_CP15_TIMER)
+	if (type & ARCH_CP15_TIMER) {
 		arch_timer_read_counter = arch_counter_get_cntvct;
-	else
+	} else {
 		arch_timer_read_counter = arch_counter_get_cntvct_mem;
 
+		/* If the clocksource name is "arch_sys_counter" the
+		 * VDSO will attempt to read the CP15-based counter.
+		 * Ensure this does not happen when CP15-based
+		 * counter is not available.
+		 */
+		clocksource_counter.name = "arch_mem_counter";
+	}
+
 	start_count = arch_timer_read_counter();
 	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
 	cyclecounter.mult = clocksource_counter.mult;
-- 
1.9.3
