From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Sat,  1 Apr 2017 01:50:57 +0800
Subject: [PATCH v23 03/11] clocksource: arm_arch_timer: refactor
 arch_timer_needs_probing
In-Reply-To: <20170331175105.8370-1-fu.wei@linaro.org>
References: <20170331175105.8370-1-fu.wei@linaro.org>
Message-ID: <20170331175105.8370-4-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

When booting with DT, it's possible for timer nodes to be probed in any
order. Some common initialisation needs to occur after all nodes have
been probed, and arch_timer_common_init() has code to detect when this
has happened.

This logic is DT-specific, and it would be best to factor it out of the
common code that will be shared with ACPI.

This patch folds this into the existing arch_timer_needs_probing(),
which is renamed to arch_timer_needs_of_probing(), and no longer takes
any arguments. This is only called when using DT, and not when using
ACPI, which will have a deterministic probe order.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
[Mark: reword commit message]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 1b6a7e6..ed215d9 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -839,15 +839,28 @@ static const struct of_device_id arch_timer_mem_of_match[] __initconst = {
 	{},
 };
 
-static bool __init
-arch_timer_needs_probing(int type, const struct of_device_id *matches)
+static bool __init arch_timer_needs_of_probing(void)
 {
 	struct device_node *dn;
 	bool needs_probing = false;
+	unsigned int mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
 
-	dn = of_find_matching_node(NULL, matches);
-	if (dn && of_device_is_available(dn) && !(arch_timers_present & type))
+	/* We have two timers, and both device-tree nodes are probed. */
+	if ((arch_timers_present & mask) == mask)
+		return false;
+
+	/*
+	 * Only one type of timer is probed,
+	 * check if we have another type of timer node in device-tree.
+	 */
+	if (arch_timers_present & ARCH_TIMER_TYPE_CP15)
+		dn = of_find_matching_node(NULL, arch_timer_mem_of_match);
+	else
+		dn = of_find_matching_node(NULL, arch_timer_of_match);
+
+	if (dn && of_device_is_available(dn))
 		needs_probing = true;
+
 	of_node_put(dn);
 
 	return needs_probing;
@@ -855,17 +868,8 @@ arch_timer_needs_probing(int type, const struct of_device_id *matches)
 
 static int __init arch_timer_common_init(void)
 {
-	unsigned mask = ARCH_TIMER_TYPE_CP15 | ARCH_TIMER_TYPE_MEM;
-
-	/* Wait until both nodes are probed if we have two timers */
-	if ((arch_timers_present & mask) != mask) {
-		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_MEM,
-					     arch_timer_mem_of_match))
-			return 0;
-		if (arch_timer_needs_probing(ARCH_TIMER_TYPE_CP15,
-					     arch_timer_of_match))
-			return 0;
-	}
+	if (acpi_disabled && arch_timer_needs_of_probing())
+		return 0;
 
 	arch_timer_banner(arch_timers_present);
 	arch_counter_register(arch_timers_present);
-- 
2.9.3
