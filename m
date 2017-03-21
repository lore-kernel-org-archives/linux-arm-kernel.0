From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Wed, 22 Mar 2017 00:31:14 +0800
Subject: [PATCH v22 03/11] clocksource: arm_arch_timer: refactor
 arch_timer_needs_probing
In-Reply-To: <20170321163122.9183-1-fu.wei@linaro.org>
References: <20170321163122.9183-1-fu.wei@linaro.org>
Message-ID: <20170321163122.9183-4-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

When system init with device-tree, we don't know which node will be
initialized first. And the code in arch_timer_common_init should wait
until per-cpu timer and MMIO timer are both initialized. So we need
arch_timer_needs_probing to detect the init status of system.

But currently the code is dispersed in arch_timer_needs_probing and
arch_timer_common_init. And the function name doesn't specify that
it's only for device-tree. This is somewhat confusing.

This patch move all related code from arch_timer_common_init to
arch_timer_needs_probing, refactor it, and rename it to
arch_timer_needs_of_probing. And make sure that it will be called
only if acpi is disabled.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 29ca7d6..d1a05d9 100644
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
