From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 8 May 2012 14:17:49 +0200
Subject: [PATCH 1/2] clockevents: add an optional frequency update function
Message-ID: <1336479469-9246-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

For some clockevents, especially for periodic ones, we get a
problem when the frequency of the clock driving the event
changes. We previously have a solution for one-shot events
that will simply reprogram the next event. This introduces
an optional callback so that drivers can update constant
timer latch values derived from HZ.

Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/clockchips.h |    3 +++
 kernel/time/clockevents.c  |    8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 81e803e..c83d008 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -70,6 +70,7 @@ enum clock_event_nofitiers {
  * @features:		features
  * @retries:		number of forced programming retries
  * @set_mode:		set mode function
+ * @update_freq:	function called to update timer clock frequency
  * @broadcast:		function to broadcast events
  * @min_delta_ticks:	minimum delta value in ticks stored for reconfiguration
  * @max_delta_ticks:	maximum delta value in ticks stored for reconfiguration
@@ -97,6 +98,8 @@ struct clock_event_device {
 	void			(*broadcast)(const struct cpumask *mask);
 	void			(*set_mode)(enum clock_event_mode mode,
 					    struct clock_event_device *);
+	void			(*update_freq)(enum clock_event_mode mode,
+					    struct clock_event_device *);
 	unsigned long		min_delta_ticks;
 	unsigned long		max_delta_ticks;
 
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 9cd928f..0444bad 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -346,13 +346,17 @@ void clockevents_config_and_register(struct clock_event_device *dev,
  * @dev:	device to modify
  * @freq:	new device frequency
  *
- * Reconfigure and reprogram a clock event device in oneshot
- * mode. Must be called on the cpu for which the device delivers per
+ * Reconfigure and reprogram a clock event device.
+ * Must be called on the cpu for which the device delivers per
  * cpu timer events with interrupts disabled!  Returns 0 on success,
  * -ETIME when the event is in the past.
  */
 int clockevents_update_freq(struct clock_event_device *dev, u32 freq)
 {
+	/* Call down to the driver to reconfigure for new frequency */
+	if (dev->update_freq)
+		dev->update_freq(dev->mode, dev);
+
 	clockevents_config(dev, freq);
 
 	if (dev->mode != CLOCK_EVT_MODE_ONESHOT)
-- 
1.7.9.2
