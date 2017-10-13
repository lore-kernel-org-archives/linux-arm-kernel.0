From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 13 Oct 2017 11:54:33 -0600
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for ntp
Message-ID: <20171013175433.GA22062@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ntp is currently hardwired to try and call the rtc set when wall clock
tv_nsec is 0.5 seconds. This historical behaviour works well with certain
PC RTCs, but is not universal to all rtc hardware.

Change how this works by introducing the driver specific concept of
set_offset_nsec, the delay between current wall clock time and the target
time to set (with a 0 tv_nsecs).

For x86-style CMOS set_offset_nsec should be -0.5 s which causes the last
second to be written 0.5 s after it has started.

For compat with the old rtc_set_ntp_time, the value is defaulted to
+ 0.5 s, which causes the next second to be written 0.5s before it starts,
as things were before this patch.

Testing shows many non-x86 RTCs would like set_offset_nsec ~= 0,
so ultimately each RTC driver should set the set_offset_nsec according
to its needs, and non x86 architectures should stop using
update_persistent_clock64 in order to access this feature.
Future patches will revise the drivers as needed.

Since CMOS and RTC now have very different handling they are split
into two dedicated code paths, sharing the support code, and ifdefs
are replaced with IS_ENABLED.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/rtc/class.c   |   3 +
 drivers/rtc/systohc.c |  53 +++++++++++-----
 include/linux/rtc.h   |  43 ++++++++++++-
 kernel/time/ntp.c     | 166 ++++++++++++++++++++++++++++++++++----------------
 4 files changed, 196 insertions(+), 69 deletions(-)

Hello All,

Here is the latest version of this patch that was circulating between
RMK and myself. I have done a few more minor changed and been able to
test it myself on x86 KVM and on the ARM system that motivated the
original CONFIG_RTC_SYSTOHC patch.

>From all my testing, this patch does not change the existing behavior
at all, but provides the base infrastructure to fix individual RTCs
one at a time.

There are a few followup patches that will set the set_offset_nsec
value for various RTC drivers, and I still have to look at RMK's
hrtimer patch, but those are all incremental on top of this.

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 2ed970d61da140..722d683e0b0f5f 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -161,6 +161,9 @@ static struct rtc_device *rtc_allocate_device(void)
 
 	device_initialize(&rtc->dev);
 
+	/* Drivers can revise this default after allocating the device. */
+	rtc->set_offset_nsec =  NSEC_PER_SEC / 2;
+
 	rtc->irq_freq = 1;
 	rtc->max_user_freq = 64;
 	rtc->dev.class = rtc_class;
diff --git a/drivers/rtc/systohc.c b/drivers/rtc/systohc.c
index b4a68ffcd06bb8..0c177647ea6c71 100644
--- a/drivers/rtc/systohc.c
+++ b/drivers/rtc/systohc.c
@@ -10,6 +10,7 @@
 /**
  * rtc_set_ntp_time - Save NTP synchronized time to the RTC
  * @now: Current time of day
+ * @target_nsec: pointer for desired now->tv_nsec value
  *
  * Replacement for the NTP platform function update_persistent_clock64
  * that stores time for later retrieval by rtc_hctosys.
@@ -18,30 +19,52 @@
  * possible at all, and various other -errno for specific temporary failure
  * cases.
  *
+ * -EPROTO is returned if now.tv_nsec is not close enough to *target_nsec.
+ (
  * If temporary failure is indicated the caller should try again 'soon'
  */
-int rtc_set_ntp_time(struct timespec64 now)
+int rtc_set_ntp_time(struct timespec64 now, unsigned long *target_nsec)
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
+	ok = rtc_tv_nsec_ok(rtc->set_offset_nsec, &to_set, &now);
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
index e6d0f9c1cafd81..5b13fa029fd6ae 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -135,6 +135,14 @@ struct rtc_device {
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
@@ -172,7 +180,7 @@ extern void devm_rtc_device_unregister(struct device *dev,
 
 extern int rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm);
 extern int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm);
-extern int rtc_set_ntp_time(struct timespec64 now);
+extern int rtc_set_ntp_time(struct timespec64 now, unsigned long *target_nsec);
 int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm);
 extern int rtc_read_alarm(struct rtc_device *rtc,
 			struct rtc_wkalrm *alrm);
@@ -221,6 +229,39 @@ static inline bool is_leap_year(unsigned int year)
 	return (!(year % 4) && (year % 100)) || !(year % 400);
 }
 
+/* Determine if we can call to driver to set the time. Drivers can only be
+ * called to set a second aligned time value, and the field set_offset_nsec
+ * specifies how far away from the second aligned time to call the driver.
+ *
+ * This also computes 'to_set' which is the time we are trying to set, and has
+ * a zero in tv_nsecs, such that:
+ *    to_set - set_delay_nsec == now +/- FUZZ
+ *
+ */
+static inline bool rtc_tv_nsec_ok(s64 set_offset_nsec,
+				  struct timespec64 *to_set,
+				  const struct timespec64 *now)
+{
+	/* Allowed error in tv_nsec, arbitarily set to 5 jiffies in ns. */
+	const unsigned long TIME_SET_NSEC_FUZZ = TICK_NSEC * 5;
+	struct timespec64 delay = {.tv_sec = 0,
+				   .tv_nsec = set_offset_nsec};
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
 #define rtc_register_device(device) \
 	__rtc_register_device(THIS_MODULE, device)
 
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index edf19cc5314043..bc19de1a06835e 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -492,6 +492,67 @@ int second_overflow(time64_t secs)
 	return leap;
 }
 
+static void sync_hw_clock(struct work_struct *work);
+static DECLARE_DELAYED_WORK(sync_work, sync_hw_clock);
+
+static void sched_sync_hw_clock(struct timespec64 now,
+				unsigned long target_nsec, bool fail)
+
+{
+	struct timespec64 next;
+
+	getnstimeofday64(&next);
+	if (!fail)
+		next.tv_sec = 659;
+	else {
+		/*
+		 * Try again as soon as possible. Delaying long periods
+		 * decreases the accuracy of the work queue timer. Due to this
+		 * the algorithm is very likely to require a short-sleep retry
+		 * after the above long sleep to synchronize ts_nsec.
+		 */
+		next.tv_sec = 0;
+	}
+
+	/* Compute the needed delay that will get to tv_nsec == target_nsec */
+	next.tv_nsec = target_nsec - next.tv_nsec;
+	if (next.tv_nsec <= 0)
+		next.tv_nsec += NSEC_PER_SEC;
+	if (next.tv_nsec >= NSEC_PER_SEC) {
+		next.tv_sec++;
+		next.tv_nsec -= NSEC_PER_SEC;
+	}
+
+	queue_delayed_work(system_power_efficient_wq, &sync_work,
+			   timespec64_to_jiffies(&next));
+}
+
+static void sync_rtc_clock(void)
+{
+	unsigned long target_nsec;
+	struct timespec64 adjust, now;
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_RTC_SYSTOHC))
+		return;
+
+	getnstimeofday64(&now);
+
+	adjust = now;
+	if (persistent_clock_is_local)
+		adjust.tv_sec -= (sys_tz.tz_minuteswest * 60);
+
+	/*
+	 * The current RTC in use will provide the target_nsec it wants to be
+	 * called at, and does rtc_tv_nsec_ok internally.
+	 */
+	rc = rtc_set_ntp_time(adjust, &target_nsec);
+	if (rc == -ENODEV)
+		return;
+
+	sched_sync_hw_clock(now, target_nsec, rc);
+}
+
 #ifdef CONFIG_GENERIC_CMOS_UPDATE
 int __weak update_persistent_clock(struct timespec now)
 {
@@ -507,76 +568,75 @@ int __weak update_persistent_clock64(struct timespec64 now64)
 }
 #endif
 
-#if defined(CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC)
-static void sync_cmos_clock(struct work_struct *work);
-
-static DECLARE_DELAYED_WORK(sync_cmos_work, sync_cmos_clock);
-
-static void sync_cmos_clock(struct work_struct *work)
+static bool sync_cmos_clock(void)
 {
+	static bool no_cmos;
 	struct timespec64 now;
-	struct timespec64 next;
-	int fail = 1;
+	struct timespec64 adjust;
+	int rc = -EPROTO;
+	long target_nsec = NSEC_PER_SEC / 2;
+
+	if (!IS_ENABLED(CONFIG_GENERIC_CMOS_UPDATE))
+		return false;
+
+	if (no_cmos)
+		return false;
 
 	/*
-	 * If we have an externally synchronized Linux clock, then update
-	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be
-	 * called as close as possible to 500 ms before the new second starts.
-	 * This code is run on a timer.  If the clock is set, that timer
-	 * may not expire at the correct time.  Thus, we adjust...
-	 * We want the clock to be within a couple of ticks from the target.
+	 * Historically update_persistent_clock64() has followed x86
+	 * semantics, which match the MC146818A/etc RTC. This RTC will store
+	 * 'adjust' and then in .5s it will advance once second.
+	 *
+	 * Architectures are strongly encouraged to use rtclib and not
+	 * implement this legacy API.
 	 */
-	if (!ntp_synced()) {
-		/*
-		 * Not synced, exit, do not restart a timer (if one is
-		 * running, let it run out).
-		 */
-		return;
-	}
-
 	getnstimeofday64(&now);
-	if (abs(now.tv_nsec - (NSEC_PER_SEC / 2)) <= tick_nsec * 5) {
-		struct timespec64 adjust = now;
-
-		fail = -ENODEV;
+	if (rtc_tv_nsec_ok(-1 * target_nsec, &adjust, &now)) {
 		if (persistent_clock_is_local)
 			adjust.tv_sec -= (sys_tz.tz_minuteswest * 60);
-#ifdef CONFIG_GENERIC_CMOS_UPDATE
-		fail = update_persistent_clock64(adjust);
-#endif
-
-#ifdef CONFIG_RTC_SYSTOHC
-		if (fail == -ENODEV)
-			fail = rtc_set_ntp_time(adjust);
-#endif
+		rc = update_persistent_clock64(adjust);
+		/*
+		 * The machine does not support update_persistent_clock64 even
+		 * though it defines CONFIG_GENERIC_CMOS_UPDATE.
+		 */
+		if (rc == -ENODEV) {
+			no_cmos = true;
+			return false;
+		}
 	}
 
-	next.tv_nsec = (NSEC_PER_SEC / 2) - now.tv_nsec - (TICK_NSEC / 2);
-	if (next.tv_nsec <= 0)
-		next.tv_nsec += NSEC_PER_SEC;
+	sched_sync_hw_clock(now, target_nsec, rc);
+	return true;
+}
 
-	if (!fail || fail == -ENODEV)
-		next.tv_sec = 659;
-	else
-		next.tv_sec = 0;
+/*
+ * If we have an externally synchronized Linux clock, then update RTC clock
+ * accordingly every ~11 minutes. Generally RTCs can only store second
+ * precision, but many RTCs will adjust the phase of their second tick to
+ * match the moment of update. This infrastructure arranges to call to the RTC
+ * set@the correct moment to phase synchronize the RTC second tick over
+ * with the kernel clock.
+ */
+static void sync_hw_clock(struct work_struct *work)
+{
+	if (!ntp_synced())
+		return;
 
-	if (next.tv_nsec >= NSEC_PER_SEC) {
-		next.tv_sec++;
-		next.tv_nsec -= NSEC_PER_SEC;
-	}
-	queue_delayed_work(system_power_efficient_wq,
-			   &sync_cmos_work, timespec64_to_jiffies(&next));
+	if (sync_cmos_clock())
+		return;
+
+	sync_rtc_clock();
 }
 
 void ntp_notify_cmos_timer(void)
 {
-	queue_delayed_work(system_power_efficient_wq, &sync_cmos_work, 0);
-}
-
-#else
-void ntp_notify_cmos_timer(void) { }
-#endif
+	if (!ntp_synced())
+		return;
 
+	if (IS_ENABLED(CONFIG_GENERIC_CMOS_UPDATE) ||
+	    IS_ENABLED(CONFIG_RTC_SYSTOHC))
+		queue_delayed_work(system_power_efficient_wq, &sync_work, 0);
+}
 
 /*
  * Propagate a new txc->status value into the NTP state:
-- 
2.7.4
