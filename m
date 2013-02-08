From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  8 Feb 2013 15:24:07 +0000
Subject: [PATCH] clockevents: fix generic broadcast for FEAT_C3STOP
Message-ID: <1360337047-860-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 12ad100046: "clockevents: Add generic timer broadcast function"
made tick_device_uses_broadcast set up the generic broadcast function
for dummy devices (where !tick_device_is_functional(dev)), but neglected
to set up the broadcast function for devices that stop in low power
states (with the CLOCK_EVT_FEAT_C3STOP flag).

When these devices enter low power states they will not have the generic
broadcast function assigned, and will bring down the system when an
attempt is made to broadcast to them.

This patch ensures that the broadcast function is also assigned for
devices which require broadcast in low power states.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Stephen Warren <swarren@nvidia.com>
Tested-by: Stephen Warren <swarren@nvidia.com>
---
 kernel/time/tick-broadcast.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index f726537..2fb8cb8 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -92,6 +92,17 @@ static void err_broadcast(const struct cpumask *mask)
 	pr_crit_once("Failed to broadcast timer tick. Some CPUs may be unresponsive.\n");
 }
 
+static void tick_device_setup_broadcast_func(struct clock_event_device *dev)
+{
+	if (!dev->broadcast)
+		dev->broadcast = tick_broadcast;
+	if (!dev->broadcast) {
+		pr_warn_once("%s depends on broadcast, but no broadcast function available\n",
+			     dev->name);
+		dev->broadcast = err_broadcast;
+	}
+}
+
 /*
  * Check, if the device is disfunctional and a place holder, which
  * needs to be handled by the broadcast device.
@@ -111,13 +122,7 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
 	 */
 	if (!tick_device_is_functional(dev)) {
 		dev->event_handler = tick_handle_periodic;
-		if (!dev->broadcast)
-			dev->broadcast = tick_broadcast;
-		if (!dev->broadcast) {
-			pr_warn_once("%s depends on broadcast, but no broadcast function available\n",
-				     dev->name);
-			dev->broadcast = err_broadcast;
-		}
+		tick_device_setup_broadcast_func(dev);
 		cpumask_set_cpu(cpu, tick_get_broadcast_mask());
 		tick_broadcast_start_periodic(tick_broadcast_device.evtdev);
 		ret = 1;
@@ -129,9 +134,10 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
 		 */
 		if (!(dev->features & CLOCK_EVT_FEAT_C3STOP)) {
 			int cpu = smp_processor_id();
-
 			cpumask_clear_cpu(cpu, tick_get_broadcast_mask());
 			tick_broadcast_clear_oneshot(cpu);
+		} else {
+			tick_device_setup_broadcast_func(dev);
 		}
 	}
 	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
-- 
1.8.1.1
