From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 May 2013 14:55:48 +0800
Subject: [PATCH] thermal: step_wise: cdev only needs update on a new target
 state
Message-ID: <1369724148-15087-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cooling device only needs update on a new target state.  Since we
already check old target in thermal_zone_trip_update(), we can do one
more check to see if it's a new target state.  If not, we can reasonably
save some uncecesary code execution.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/thermal/step_wise.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
index 4d4ddae..0afbd86 100644
--- a/drivers/thermal/step_wise.c
+++ b/drivers/thermal/step_wise.c
@@ -133,6 +133,9 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
 		old_target = instance->target;
 		instance->target = get_target_state(instance, trend, throttle);
 
+		if (old_target == instance->target)
+			continue;
+
 		/* Activate a passive thermal instance */
 		if (old_target == THERMAL_NO_TARGET &&
 			instance->target != THERMAL_NO_TARGET)
-- 
1.7.9.5
