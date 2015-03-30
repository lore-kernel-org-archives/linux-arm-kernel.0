From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Mar 2015 22:17:03 +0200
Subject: [PATCH 01/11] clocksource: arm_arch_timer: Rename arch_timer_probed
 to reflect behaviour
In-Reply-To: <5519AEB2.8050306@linaro.org>
References: <5519AEB2.8050306@linaro.org>
Message-ID: <1427746633-9137-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The arch_timer_probed function returns whether the given time doesn't
need to be probed. This can be the case when the timer has been probed
already, but also when it has no corresponding enabled node in DT.

Rename the function to arch_timer_need_probe and invert its return value
to better reflect the function's purpose and behaviour.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index a3025e7..50bb7f2 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -661,17 +661,17 @@ static const struct of_device_id arch_timer_mem_of_match[] __initconst = {
 };
 
 static bool __init
-arch_timer_probed(int type, const struct of_device_id *matches)
+arch_timer_need_probe(int type, const struct of_device_id *matches)
 {
 	struct device_node *dn;
-	bool probed = true;
+	bool need_probe = false;
 
 	dn = of_find_matching_node(NULL, matches);
 	if (dn && of_device_is_available(dn) && !(arch_timers_present & type))
-		probed = false;
+		need_probe = true;
 	of_node_put(dn);
 
-	return probed;
+	return need_probe;
 }
 
 static void __init arch_timer_common_init(void)
@@ -680,9 +680,10 @@ static void __init arch_timer_common_init(void)
 
 	/* Wait until both nodes are probed if we have two timers */
 	if ((arch_timers_present & mask) != mask) {
-		if (!arch_timer_probed(ARCH_MEM_TIMER, arch_timer_mem_of_match))
+		if (arch_timer_need_probe(ARCH_MEM_TIMER,
+					  arch_timer_mem_of_match))
 			return;
-		if (!arch_timer_probed(ARCH_CP15_TIMER, arch_timer_of_match))
+		if (arch_timer_need_probe(ARCH_CP15_TIMER, arch_timer_of_match))
 			return;
 	}
 
-- 
1.9.1
