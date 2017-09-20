From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 20 Sep 2017 16:45:22 -0600
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170920165141.GP20805@n2100.armlinux.org.uk>
References: <20170920112152.GL20805@n2100.armlinux.org.uk>
 <20170920162208.GB536@obsidianresearch.com>
 <20170920165141.GP20805@n2100.armlinux.org.uk>
Message-ID: <20170920224522.GB20974@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 05:51:41PM +0100, Russell King - ARM Linux wrote:
> I sort-of agree as far as the time offset information goes, but there's
> a complication that we only open the RTC to set the time at the
> point in

Hi Russell,

What do you think of this untested approach in the below patch?

Upon more careful inspection I think I found a way to make the
rounding in rtc_set_ntp_time compatible with a wide range of rtc
devices, so the subsecond capable ops I suggested do not seem
necessary.

>From 3455f4d225b01b6d3e85df372c9724a45d065b22 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Wed, 20 Sep 2017 16:43:10 -0600
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for ntp

ntp is currently hardwired to try and call the rtc set when wall clock
tv_nsec is 0.5 seconds. This historical behaviour works well with certain
PC RTCs, but is not universal to all rtc hardware.

Change ntp to take a value from struct rtc_device that specifies what the
target tv_nsec value should be. This allows each driver to fine tune
the tv_nsec based on its own requirements.

This changes how rtc_set_ntp_time computes the rounding, instead of using
0.5s as a hard line, we compute a +-1ms band around the target tv_nsec
value and 'snap' the incoming timespec to the tv_nsec inside the
band (or defer this update).

The calculation of the sleep time for ntp is also revised to use modern
helper functions, and to more directly and safely compute a relative
jiffies delay that will result in the correct tv_nsec. If this fails it
does a short sleep and tries again rather than trying to program the RTC
with a poor tv_nsec value.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/rtc/class.c   |  6 +++++
 drivers/rtc/systohc.c | 67 +++++++++++++++++++++++++++++++++++++++++----------
 include/linux/rtc.h   |  4 ++-
 kernel/time/ntp.c     | 62 ++++++++++++++++++++++++++++++-----------------
 4 files changed, 103 insertions(+), 36 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 2ed970d61da140..ed1a4e0f8742ba 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -161,6 +161,12 @@ static struct rtc_device *rtc_allocate_device(void)
 
 	device_initialize(&rtc->dev);
 
+	/* Drivers can revise this default after allocating the device. It
+	 * should be the value of wallclock tv_nsec that the driver needs in
+	 * order to synchronize the second tick over during set.
+	 */
+	rtc->time_set_nsec =  NSEC_PER_SEC / 2;
+
 	rtc->irq_freq = 1;
 	rtc->max_user_freq = 64;
 	rtc->dev.class = rtc_class;
diff --git a/drivers/rtc/systohc.c b/drivers/rtc/systohc.c
index b4a68ffcd06bb8..f756dc1804829b 100644
--- a/drivers/rtc/systohc.c
+++ b/drivers/rtc/systohc.c
@@ -7,9 +7,43 @@
 #include <linux/rtc.h>
 #include <linux/time.h>
 
+/* True if now.tv_nsec is close enough to time_sec_nsec that we can call the
+ * drivers's set_time_ns(). Arbitrarily choose 1ms as the allowable error
+ * margin.
+ *
+ * This also rounds tv_sec to the second that covers the tv_nsec tick we are
+ * targeting.
+ */
+#define TIME_SET_NSEC_FUZZ (1000*1000)
+static inline bool rtc_tv_nsec_ok(struct rtc_device *rtc,
+				  struct timespec64 *now)
+{
+	long diff;
+
+	diff = (now->tv_nsec - rtc->time_set_nsec) % NSEC_PER_SEC;
+	if (diff < TIME_SET_NSEC_FUZZ) {
+		if (rtc->time_set_nsec + diff >= NSEC_PER_SEC) {
+			now->tv_sec -= 1;
+			now->tv_nsec = NSEC_PER_SEC-1;
+		}
+		return true;
+	}
+
+	diff = (rtc->time_set_nsec - now->tv_nsec) % NSEC_PER_SEC;
+	if (diff < TIME_SET_NSEC_FUZZ) {
+		if (now->tv_nsec + diff >= NSEC_PER_SEC) {
+			now->tv_sec += 1;
+			now->tv_nsec = 0;
+		}
+		return true;
+	}
+	return false;
+}
+
 /**
  * rtc_set_ntp_time - Save NTP synchronized time to the RTC
  * @now: Current time of day
+ * @target_nsec: Output value indicating what now->tv_nsec
  *
  * Replacement for the NTP platform function update_persistent_clock64
  * that stores time for later retrieval by rtc_hctosys.
@@ -20,28 +54,35 @@
  *
  * If temporary failure is indicated the caller should try again 'soon'
  */
-int rtc_set_ntp_time(struct timespec64 now)
+int rtc_set_ntp_time(struct timespec64 now, long *target_nsec)
 {
 	struct rtc_device *rtc;
 	struct rtc_time tm;
 	int err = -ENODEV;
 
-	if (now.tv_nsec < (NSEC_PER_SEC >> 1))
-		rtc_time64_to_tm(now.tv_sec, &tm);
-	else
-		rtc_time64_to_tm(now.tv_sec + 1, &tm);
-
 	rtc = rtc_class_open(CONFIG_RTC_SYSTOHC_DEVICE);
-	if (rtc) {
+	if (!rtc)
+		goto out_err;
+
+	/* The ntp code must call this with the correct value in tv_nsec, if
+	 * it does not we update target_nsec and return EPROTO to make the ntp
+	 * code try again later.
+	 */
+	*target_nsec = rtc->time_set_nsec;
+	if (!rtc_tv_nsec_ok(rtc, &now)) {
+		err = -EPROTO;
+		goto out_close;
+	}
+
+	if (rtc->ops && (rtc->ops->set_time || rtc->ops->set_mmss64 ||
+			 rtc->ops->set_mmss)) {
 		/* rtc_hctosys exclusively uses UTC, so we call set_time here,
 		 * not set_mmss. */
-		if (rtc->ops &&
-		    (rtc->ops->set_time ||
-		     rtc->ops->set_mmss64 ||
-		     rtc->ops->set_mmss))
-			err = rtc_set_time(rtc, &tm);
-		rtc_class_close(rtc);
+		err = rtc_set_time(rtc, &tm);
 	}
 
+out_close:
+	rtc_class_close(rtc);
+out_err:
 	return err;
 }
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 0a0f0d14a5fba5..7f9858ef03111a 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -137,6 +137,8 @@ struct rtc_device {
 	/* Some hardware can't support UIE mode */
 	int uie_unsupported;
 
+	long time_set_nsec;
+
 	bool registered;
 
 	struct nvmem_config *nvmem_config;
@@ -174,7 +176,7 @@ extern void devm_rtc_device_unregister(struct device *dev,
 
 extern int rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm);
 extern int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm);
-extern int rtc_set_ntp_time(struct timespec64 now);
+extern int rtc_set_ntp_time(struct timespec64 now, long *target_nsec);
 int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm);
 extern int rtc_read_alarm(struct rtc_device *rtc,
 			struct rtc_wkalrm *alrm);
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index edf19cc5314043..61fdf758dcb754 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -514,17 +514,19 @@ static DECLARE_DELAYED_WORK(sync_cmos_work, sync_cmos_clock);
 
 static void sync_cmos_clock(struct work_struct *work)
 {
-	struct timespec64 now;
-	struct timespec64 next;
+	struct timespec64 now, next, delta;
 	int fail = 1;
+	long target_nsec = NSEC_PER_SEC / 2;
 
 	/*
-	 * If we have an externally synchronized Linux clock, then update
-	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
-	 * called as close as possible to 500 ms before the new second starts.
-	 * This code is run on a timer.  If the clock is set, that timer
-	 * may not expire at the correct time.  Thus, we adjust...
-	 * We want the clock to be within a couple of ticks from the target.
+	 * If we have an externally synchronized Linux clock, then update CMOS
+	 * clock accordingly every ~11 minutes.  Histiocally Set_rtc_mmss()
+	 * has to be called as close as possible to 500 ms (target_nsec)
+	 * before the new second starts, but new RTC drivers can select a
+	 * different value.  This code is run on a timer.  If the clock is
+	 * set, that timer may not expire at the correct time.  Thus, we
+	 * adjust...  We want the clock to be within a couple of ticks from
+	 * the target.
 	 */
 	if (!ntp_synced()) {
 		/*
@@ -547,25 +549,41 @@ static void sync_cmos_clock(struct work_struct *work)
 
 #ifdef CONFIG_RTC_SYSTOHC
 		if (fail == -ENODEV)
-			fail = rtc_set_ntp_time(adjust);
+			fail = rtc_set_ntp_time(adjust, &target_nsec);
 #endif
 	}
 
-	next.tv_nsec = (NSEC_PER_SEC / 2) - now.tv_nsec - (TICK_NSEC / 2);
-	if (next.tv_nsec <= 0)
-		next.tv_nsec += NSEC_PER_SEC;
+	do {
+		/*
+		 * Compute the next wall clock time to try and set the
+		 * clock
+		 */
+		next = now;
+		if (!fail || fail == -ENODEV)
+			timespec64_add_ns(&next, 659 * NSEC_PER_SEC);
+		else
+			/* Update failed, try again in about 10 seconds */
+			timespec64_add_ns(&next, 10 * NSEC_PER_SEC);
 
-	if (!fail || fail == -ENODEV)
-		next.tv_sec = 659;
-	else
-		next.tv_sec = 0;
+		/*
+		 * The next call to sync_cmos_clock needs to have have a wall
+		 * clock tv_nsec value equal to target_nsec.
+		 */
+		if (next.tv_nsec > target_nsec)
+			next.tv_sec++;
+		next.tv_nsec = target_nsec;
 
-	if (next.tv_nsec >= NSEC_PER_SEC) {
-		next.tv_sec++;
-		next.tv_nsec -= NSEC_PER_SEC;
-	}
-	queue_delayed_work(system_power_efficient_wq,
-			   &sync_cmos_work, timespec64_to_jiffies(&next));
+		/*
+		 * Convert to a relative delay. If time set took a really long
+		 * time, or the wall clock was changed, this might become
+		 * negative, so try again.
+		 */
+		getnstimeofday64(&now);
+		delta = timespec64_sub(next, now);
+	} while (delta.tv_sec <= 0);
+
+	queue_delayed_work(system_power_efficient_wq, &sync_cmos_work,
+			   timespec64_to_jiffies(&delta));
 }
 
 void ntp_notify_cmos_timer(void)
-- 
2.7.4
