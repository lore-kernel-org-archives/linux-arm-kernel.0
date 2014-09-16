From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 17 Sep 2014 00:50:45 +0100
Subject: [PATCH] clocksource: arm_arch_timer: discard unavailable timers
 correctly
Message-ID: <1410911445-19067-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we wait until both nodes are probed if we have two timers
without checking if the device is actually available. This might
result in non-functional system as no timer gets registered.

This patch adds the check for the availablity of the timer device
so that unavailable timers are discarded correctly.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 5163ec1..4d025ad 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -622,11 +622,15 @@ static void __init arch_timer_common_init(void)
 
 	/* Wait until both nodes are probed if we have two timers */
 	if ((arch_timers_present & mask) != mask) {
-		if (of_find_matching_node(NULL, arch_timer_mem_of_match) &&
-				!(arch_timers_present & ARCH_MEM_TIMER))
+		struct device_node *dn;
+
+		dn = of_find_matching_node(NULL, arch_timer_mem_of_match);
+		if (dn && of_device_is_available(dn) &&
+		    !(arch_timers_present & ARCH_MEM_TIMER))
 			return;
-		if (of_find_matching_node(NULL, arch_timer_of_match) &&
-				!(arch_timers_present & ARCH_CP15_TIMER))
+		dn = of_find_matching_node(NULL, arch_timer_of_match);
+		if (dn && of_device_is_available(dn) &&
+		    !(arch_timers_present & ARCH_CP15_TIMER))
 			return;
 	}
 
-- 
1.9.1
