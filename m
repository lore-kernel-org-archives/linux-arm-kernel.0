From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Jan 2013 14:46:07 +0000
Subject: [PATCHv2 1/4] clockevents: Add generic timer broadcast receiver
In-Reply-To: <1357742770-15028-1-git-send-email-mark.rutland@arm.com>
References: <1357742770-15028-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1357742770-15028-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the broadcast mechanism used for timers is abstracted by a
function pointer on struct clock_event_device. As the fundamental
mechanism for broadcast is architecture-specific, this ties each
clock_event_device driver to a single architecture, even where the
driver is otherwise generic.

This patch adds a standard path for the receipt of timer broadcasts, so
drivers and/or architecture backends need not manage redundant lists of
timers for the purpose of routing broadcast timer ticks.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 include/linux/clockchips.h   |    9 +++++++++
 kernel/time/tick-broadcast.c |   12 ++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 8a7096f..6537114 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -161,6 +161,15 @@ clockevents_calc_mult_shift(struct clock_event_device *ce, u32 freq, u32 minsec)
 extern void clockevents_suspend(void);
 extern void clockevents_resume(void);
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+extern int tick_receive_broadcast(void);
+#else
+static inline int tick_receive_broadcast(void)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern void clockevents_notify(unsigned long reason, void *arg);
 #else
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index f113755..5079bb7 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -125,6 +125,18 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
 	return ret;
 }
 
+int tick_receive_broadcast(void)
+{
+	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
+	struct clock_event_device *evt = td->evtdev;
+
+	if (!evt)
+		return -ENODEV;
+
+	evt->event_handler(evt);
+	return 0;
+}
+
 /*
  * Broadcast the event to the cpus, which are set in the mask (mangled).
  */
-- 
1.7.0.4
