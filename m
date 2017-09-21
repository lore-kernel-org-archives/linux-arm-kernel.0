From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 21 Sep 2017 16:05:10 -0600
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170921093218.GS20805@n2100.armlinux.org.uk>
References: <20170920112152.GL20805@n2100.armlinux.org.uk>
 <20170920162208.GB536@obsidianresearch.com>
 <20170920165141.GP20805@n2100.armlinux.org.uk>
 <20170920224522.GB20974@obsidianresearch.com>
 <20170921075907.GR20805@n2100.armlinux.org.uk>
 <20170921093218.GS20805@n2100.armlinux.org.uk>
Message-ID: <20170921220510.GA11395@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 10:32:19AM +0100, Russell King - ARM Linux
wrote:

I've combined several of your messages together into this reply...

> static inline bool rtc_tv_nsec_ok(struct rtc_device *rtc,
> 				  struct timespec64 *now)
> {
> 	long diff;
> 
> 	diff = (now->tv_nsec - rtc->time_set_nsec) % NSEC_PER_SEC;
> 	/* diff must be within [-NSEC_PER_SEC/2..NSEC_PER_SEC/2) */
> 	if (diff >= NSEC_PER_SEC / 2)
> 		diff -= NSEC_PER_SEC;
> 	else if (diff < -NSEC_PER_SEC / 2)
> 		diff += NSEC_PER_SEC;

I like your concept of allowing a negative time_set_nsec, I was
focused on a positive value and botched the first draft by not casting
to unsigned for the maths.. It seems much better because it
incorporates the rounding calculation into the common code instead of
shifting it to the driver.

I revised this idea a few times and came up with something a bit
simpler to understand by changing from a time_set_nsec to its inverse
the set_offset_nsec, that makes the maths simpler and we can avoid
troublesome signed modulos by using time maths functions instead of
open coding them.

See full revised patch below, this time I did test the
rtc_tv_nsec_ok() using your test vectors and it seems OK. Still have
not tested the whole patch...

So with v2 of this patch, the driver would specify positive 1s, and
then the set will be called when tv_nsec == 0, but the tv_sec will
be +1.

Similarly the existing case of 0.5s offset will work more like
before, where it will be called with tv_nsec == .5s and the tv_sec
will be +1 - before I think this happened reliably 'by accident' due
to the rounding.

> Most drivers use rtc_device_register() or devm_rtc_device_register()
> rather than rtc_allocate_device() (which is static.)  This does not
> give RTC drivers a chance to set rtc->time_set_nsec before the RTC
> is registered with the kernel.

You are correct about the race, of course. I left it like that
deliberately, I'm not sure it is worth solving since I felt nothing
should be setting the RTC within a few CPU instructions of registering
it.

As you say, adding a pre-registration init op will solve the issue if
you think it is worth solving.

Jason

>From 566712cb27596836469637b0e50e7fd973368df8 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Thu, 21 Sep 2017 15:55:33 -0600
Subject: [PATCH v2] rtc: Allow rtc drivers to specify the tv_nsec value for ntp

ntp is currently hardwired to try and call the rtc set when wall clock
tv_nsec is 0.5 seconds. This historical behaviour works well with certain
PC RTCs, but is not universal to all rtc hardware.

Change how this works by introducing the driver specific concept of
a required delay between current wall clock time and the target time
to set (with a 0 tv_nsecs). When this delay is set to 0.5 seconds then
the behaviour will be the same as today, at wall clock time 0.5 sec the
RTC set will be called to set 1.0 sec.

Each RTC driver should set the set_offset_nsec according to its needs.

This also polices the incoming set time ts_nsec from NTP, if it is not
within +-1ms of the required time then the set is deferred. The target
time to set is 'snapped' to the nearest value.

The calculation of the sleep time for ntp is also revised to use modern
helper functions, and to more directly and safely compute a relative
jiffies delay that will result in the correct tv_nsec. If for some reason
the timer does not meet the requirement then it does a short sleep
and tries again.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/rtc/class.c   |  6 ++++
 drivers/rtc/systohc.c | 85 ++++++++++++++++++++++++++++++++++++++++++---------
 include/linux/rtc.h   | 10 +++++-
 kernel/time/ntp.c     | 62 ++++++++++++++++++++++++-------------
 4 files changed, 125 insertions(+), 38 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 2ed970d61da140..eef4123a573504 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -161,6 +161,12 @@ static struct rtc_device *rtc_allocate_device(void)
 
 	device_initialize(&rtc->dev);
 
+	/* Drivers can revise this default after allocating the device. It
+	 * should be the value of wallclock tv_nsec that the driver needs in
+	 * order to synchronize the second tick over during set.
+	 */
+	rtc->set_offset_nsec =  NSEC_PER_SEC / 2;
+
 	rtc->irq_freq = 1;
 	rtc->max_user_freq = 64;
 	rtc->dev.class = rtc_class;
diff --git a/drivers/rtc/systohc.c b/drivers/rtc/systohc.c
index b4a68ffcd06bb8..a7d0bbe2577110 100644
--- a/drivers/rtc/systohc.c
+++ b/drivers/rtc/systohc.c
@@ -7,9 +7,42 @@
 #include <linux/rtc.h>
 #include <linux/time.h>
 
+/* Determine if we can call to driver to set the time. Drivers can only be
+ * called to set a second aligned time value, and the field set_offset_nsec
+ * specifies how far away from the second aligned time to call the driver.
+ *
+ * This also compute 'to_set' which is the time we are trying to set, and has
+ * a zero in tv_nsecs, such that:
+ *    to_set - set_delay_nsec == now +/- FUZZ
+ *
+ */
+#define TIME_SET_NSEC_FUZZ (1000 * 1000)
+static inline bool rtc_tv_nsec_ok(struct rtc_device *rtc,
+				  struct timespec64 *to_set,
+				  const struct timespec64 *now)
+{
+	struct timespec64 delay = {.tv_sec = 0,
+				   .tv_nsec = rtc->set_offset_nsec};
+
+	*to_set = timespec64_add(*now, delay);
+
+	if (to_set->tv_nsec < TIME_SET_NSEC_FUZZ) {
+		to_set->tv_nsec = 0;
+		return true;
+	}
+
+	if (to_set->tv_nsec > NSEC_PER_SEC - TIME_SET_NSEC_FUZZ) {
+		to_set->tv_sec++;
+		to_set->tv_nsec = 0;
+		return true;
+	}
+	return false;
+}
+
 /**
  * rtc_set_ntp_time - Save NTP synchronized time to the RTC
  * @now: Current time of day
+ * @target_nsec: pointer for desired now->tv_nsec value
  *
  * Replacement for the NTP platform function update_persistent_clock64
  * that stores time for later retrieval by rtc_hctosys.
@@ -18,30 +51,52 @@
  * possible at all, and various other -errno for specific temporary failure
  * cases.
  *
+ * -EPROTO is returned if now.tv_nsec is not close enough to *target_nsec.
+ (
  * If temporary failure is indicated the caller should try again 'soon'
  */
-int rtc_set_ntp_time(struct timespec64 now)
+int rtc_set_ntp_time(struct timespec64 now, long *target_nsec)
 {
 	struct rtc_device *rtc;
 	struct rtc_time tm;
+	struct timespec64 to_set;
 	int err = -ENODEV;
-
-	if (now.tv_nsec < (NSEC_PER_SEC >> 1))
-		rtc_time64_to_tm(now.tv_sec, &tm);
-	else
-		rtc_time64_to_tm(now.tv_sec + 1, &tm);
+	bool ok;
 
 	rtc = rtc_class_open(CONFIG_RTC_SYSTOHC_DEVICE);
-	if (rtc) {
-		/* rtc_hctosys exclusively uses UTC, so we call set_time here,
-		 * not set_mmss. */
-		if (rtc->ops &&
-		    (rtc->ops->set_time ||
-		     rtc->ops->set_mmss64 ||
-		     rtc->ops->set_mmss))
-			err = rtc_set_time(rtc, &tm);
-		rtc_class_close(rtc);
+	if (!rtc)
+		goto out_err;
+
+	if (!rtc->ops || (!rtc->ops->set_time && !rtc->ops->set_mmss64 &&
+			  !rtc->ops->set_mmss))
+		goto out_close;
+
+	/* Compute the value of tv_nsec we require the caller to supply in
+	 * now.tv_nsec.  This is the value such that (now +
+	 * set_offset_nsec).tv_nsec == 0.
+	 */
+	set_normalized_timespec64(&to_set, 0, -rtc->set_offset_nsec);
+	*target_nsec = to_set.tv_nsec;
+
+	/* The ntp code must call this with the correct value in tv_nsec, if
+	 * it does not we update target_nsec and return EPROTO to make the ntp
+	 * code try again later.
+	 */
+	ok = rtc_tv_nsec_ok(rtc, &to_set, &now);
+	if (!ok) {
+		err = -EPROTO;
+		goto out_close;
 	}
 
+	rtc_time64_to_tm(to_set.tv_sec, &tm);
+
+	/* rtc_hctosys exclusively uses UTC, so we call set_time here, not
+	 * set_mmss.
+	 */
+	err = rtc_set_time(rtc, &tm);
+
+out_close:
+	rtc_class_close(rtc);
+out_err:
 	return err;
 }
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 0a0f0d14a5fba5..7d526550a700f8 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -137,6 +137,14 @@ struct rtc_device {
 	/* Some hardware can't support UIE mode */
 	int uie_unsupported;
 
+	/* Number of nsec it takes to set the RTC clock. This influences when
+	 * the set ops are called. An offset:
+	 *   - of 0.5 s will call RTC set for wall clock time 10.0 s at 9.5 s
+	 *   - of 1.5 s will call RTC set for wall clock time 10.0 s at 8.5 s
+	 *   - of -0.5 s will call RTC set for wall clock time 10.0 s at 10.5 s
+	 */
+	long set_offset_nsec;
+
 	bool registered;
 
 	struct nvmem_config *nvmem_config;
@@ -174,7 +182,7 @@ extern void devm_rtc_device_unregister(struct device *dev,
 
 extern int rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm);
 extern int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm);
-extern int rtc_set_ntp_time(struct timespec64 now);
+extern int rtc_set_ntp_time(struct timespec64 now, long *target_nsec);
 int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm);
 extern int rtc_read_alarm(struct rtc_device *rtc,
 			struct rtc_wkalrm *alrm);
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index edf19cc5314043..6d2f521dd97748 100644
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
+			timespec64_add_ns(&next, 659ULL * NSEC_PER_SEC);
+		else
+			/* Update failed, try again in about 10 seconds */
+			timespec64_add_ns(&next, 10ULL * NSEC_PER_SEC);
 
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
