From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 27 Feb 2015 17:21:32 +0530
Subject: [PATCH 1/3] clockevents: Handle tick device's resume separately
In-Reply-To: <cover.1425037853.git.viresh.kumar@linaro.org>
References: <cover.1425037853.git.viresh.kumar@linaro.org>
Message-ID: <c1b0112410870f49e7bf06958e1483eac6c15e20.1425037853.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Next commit will redefine possible states of a clockevent device. The RESUME
mode is a special case only for tick's clockevent devices. In future it can be
replaced by ->resume() callback already available for clockevent devices.

Lets handle it separately so that clockevents_set_mode() only handles states
valid across all devices. This also renames set_mode_resume() to tick_resume()
to make it more explicit.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/clockchips.h   |  4 ++--
 kernel/time/clockevents.c    | 30 +++++++++++++++++++++---------
 kernel/time/tick-broadcast.c |  2 +-
 kernel/time/tick-common.c    |  2 +-
 kernel/time/tick-internal.h  |  1 +
 kernel/time/timer_list.c     |  4 ++--
 6 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 59af26b54d15..a41749543d48 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -87,7 +87,7 @@ enum clock_event_mode {
  * @set_mode_periodic:	switch mode to periodic, if !set_mode
  * @set_mode_oneshot:	switch mode to oneshot, if !set_mode
  * @set_mode_shutdown:	switch mode to shutdown, if !set_mode
- * @set_mode_resume:	resume clkevt device, if !set_mode
+ * @tick_resume:	resume clkevt device, if !set_mode
  * @broadcast:		function to broadcast events
  * @min_delta_ticks:	minimum delta value in ticks stored for reconfiguration
  * @max_delta_ticks:	maximum delta value in ticks stored for reconfiguration
@@ -125,7 +125,7 @@ struct clock_event_device {
 	int			(*set_mode_periodic)(struct clock_event_device *);
 	int			(*set_mode_oneshot)(struct clock_event_device *);
 	int			(*set_mode_shutdown)(struct clock_event_device *);
-	int			(*set_mode_resume)(struct clock_event_device *);
+	int			(*tick_resume)(struct clock_event_device *);
 
 	void			(*broadcast)(const struct cpumask *mask);
 	void			(*suspend)(struct clock_event_device *);
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 489642b08d64..1b0ea63de69c 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -100,7 +100,7 @@ static int __clockevents_set_mode(struct clock_event_device *dev,
 	/* Transition with legacy set_mode() callback */
 	if (dev->set_mode) {
 		/* Legacy callback doesn't support new modes */
-		if (mode > CLOCK_EVT_MODE_RESUME)
+		if (mode > CLOCK_EVT_MODE_ONESHOT)
 			return -ENOSYS;
 		dev->set_mode(mode, dev);
 		return 0;
@@ -133,13 +133,6 @@ static int __clockevents_set_mode(struct clock_event_device *dev,
 			return -ENOSYS;
 		return dev->set_mode_oneshot(dev);
 
-	case CLOCK_EVT_MODE_RESUME:
-		/* Optional callback */
-		if (dev->set_mode_resume)
-			return dev->set_mode_resume(dev);
-		else
-			return 0;
-
 	default:
 		return -ENOSYS;
 	}
@@ -184,6 +177,25 @@ void clockevents_shutdown(struct clock_event_device *dev)
 	dev->next_event.tv64 = KTIME_MAX;
 }
 
+/**
+ * clockevents_tick_resume -	Resume the tick device before using it again
+ * @dev:			device to resume
+ */
+int clockevents_tick_resume(struct clock_event_device *dev)
+{
+	int ret = 0;
+
+	if (dev->set_mode)
+		dev->set_mode(CLOCK_EVT_MODE_RESUME, dev);
+	else if (dev->tick_resume)
+		ret = dev->tick_resume(dev);
+
+	if (likely(!ret))
+		dev->mode = CLOCK_EVT_MODE_RESUME;
+
+	return ret;
+}
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST
 
 /* Limit min_delta to a jiffie */
@@ -433,7 +445,7 @@ static int clockevents_sanity_check(struct clock_event_device *dev)
 	if (dev->set_mode) {
 		/* We shouldn't be supporting new modes now */
 		WARN_ON(dev->set_mode_periodic || dev->set_mode_oneshot ||
-			dev->set_mode_shutdown || dev->set_mode_resume);
+			dev->set_mode_shutdown || dev->tick_resume);
 		return 0;
 	}
 
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 066f0ec05e48..542d5bb5c13d 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -464,7 +464,7 @@ int tick_resume_broadcast(void)
 	bc = tick_broadcast_device.evtdev;
 
 	if (bc) {
-		clockevents_set_mode(bc, CLOCK_EVT_MODE_RESUME);
+		clockevents_tick_resume(bc);
 
 		switch (tick_broadcast_device.mode) {
 		case TICKDEV_MODE_PERIODIC:
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index f7c515595b42..5c50664c21d7 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -384,7 +384,7 @@ void tick_resume(void)
 	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 	int broadcast = tick_resume_broadcast();
 
-	clockevents_set_mode(td->evtdev, CLOCK_EVT_MODE_RESUME);
+	clockevents_tick_resume(td->evtdev);
 
 	if (!broadcast) {
 		if (td->mode == TICKDEV_MODE_PERIODIC)
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 366aeb4f2c66..98700e4a2000 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -32,6 +32,7 @@ extern bool tick_check_replacement(struct clock_event_device *curdev,
 extern void tick_install_replacement(struct clock_event_device *dev);
 
 extern void clockevents_shutdown(struct clock_event_device *dev);
+extern int clockevents_tick_resume(struct clock_event_device *dev);
 
 extern ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt);
 
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 2cfd19485824..2b3e9393034d 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -251,9 +251,9 @@ print_tickdevice(struct seq_file *m, struct tick_device *td, int cpu)
 			SEQ_printf(m, "\n");
 		}
 
-		if (dev->set_mode_resume) {
+		if (dev->tick_resume) {
 			SEQ_printf(m, " resume:   ");
-			print_name_offset(m, dev->set_mode_resume);
+			print_name_offset(m, dev->tick_resume);
 			SEQ_printf(m, "\n");
 		}
 	}
-- 
2.3.0.rc0.44.ga94655d
