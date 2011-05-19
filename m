From: tglx@linutronix.de (tip-bot for Thomas Gleixner)
Date: Thu, 19 May 2011 12:30:04 GMT
Subject: [tip:timers/clockevents] clockevents: Provide interface to
	reconfigure an active clock event device
Message-ID: <tip-80b816b736cfa5b9582279127099b20a479ab7d9@git.kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit-ID:  80b816b736cfa5b9582279127099b20a479ab7d9
Gitweb:     http://git.kernel.org/tip/80b816b736cfa5b9582279127099b20a479ab7d9
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Wed, 18 May 2011 21:33:42 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 19 May 2011 14:24:16 +0200

clockevents: Provide interface to reconfigure an active clock event device

Some ARM SoCs have clock event devices which have their frequency
modified due to frequency scaling. Provide an interface which allows
to reconfigure an active device. After reconfiguration reprogram the
current pending event.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: LAK <linux-arm-kernel@lists.infradead.org>
Cc: John Stultz <john.stultz@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Ingo Molnar <mingo@elte.hu>
Link: http://lkml.kernel.org/r/%3C20110518210136.437459958%40linutronix.de%3E
---
 include/linux/clockchips.h |    2 ++
 kernel/time/clockevents.c  |   20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 80acc79e..d6733e2 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -132,6 +132,8 @@ extern void clockevents_config_and_register(struct clock_event_device *dev,
 					    u32 freq, unsigned long min_delta,
 					    unsigned long max_delta);
 
+extern int clockevents_update_freq(struct clock_event_device *ce, u32 freq);
+
 extern void clockevents_exchange_device(struct clock_event_device *old,
 					struct clock_event_device *new);
 extern void clockevents_set_mode(struct clock_event_device *dev,
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index c69e88c..22a9da9 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -238,6 +238,26 @@ void clockevents_config_and_register(struct clock_event_device *dev,
 	clockevents_register_device(dev);
 }
 
+/**
+ * clockevents_update_freq - Update frequency and reprogram a clock event device.
+ * @dev:	device to modify
+ * @freq:	new device frequency
+ *
+ * Reconfigure and reprogram a clock event device in oneshot
+ * mode. Must be called on the cpu for which the device delivers per
+ * cpu timer events with interrupts disabled!  Returns 0 on success,
+ * -ETIME when the event is in the past.
+ */
+int clockevents_update_freq(struct clock_event_device *dev, u32 freq)
+{
+	clockevents_config(dev, freq);
+
+	if (dev->mode != CLOCK_EVT_MODE_ONESHOT)
+		return 0;
+
+	return clockevents_program_event(dev, dev->next_event, ktime_get());
+}
+
 /*
  * Noop handler when we shut down an event device
  */
