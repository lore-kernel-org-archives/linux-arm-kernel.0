From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 23 Sep 2017 20:05:29 +0100
Subject: On NTP, RTCs and accurately setting their time
In-Reply-To: <20170923182324.GK20805@n2100.armlinux.org.uk>
References: <20170921075907.GR20805@n2100.armlinux.org.uk>
 <20170921093218.GS20805@n2100.armlinux.org.uk>
 <20170921220510.GA11395@obsidianresearch.com>
 <20170921224541.GC20805@n2100.armlinux.org.uk>
 <20170921232040.GA15130@obsidianresearch.com>
 <20170922095713.GD20805@n2100.armlinux.org.uk>
 <20170922164850.GA13235@obsidianresearch.com>
 <20170922172022.GJ20805@n2100.armlinux.org.uk>
 <20170922182424.GA21945@obsidianresearch.com>
 <20170923182324.GK20805@n2100.armlinux.org.uk>
Message-ID: <20170923190529.GL20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 23, 2017 at 07:23:24PM +0100, Russell King - ARM Linux wrote:
> So we're getting it almost right - except for the sloppyness of the
> workqueue being run (which is mostly dependent on the sloppiness of
> the timer.)
> 
> [ 2954.059895] sched_sync_hw_clock: adjust=1506188253.808470501 now=1506188253.808475661 next=0.191524339 target=0 fail=1
> [ 2954.255898] sched_sync_hw_clock: adjust=1506188254.004471056 now=1506188254.004490017 next=659.995509983 target=0 fail=0
> [ 3625.769764] sched_sync_hw_clock: adjust=1506188925.552468680 now=1506188925.552473640 next=0.447526360 target=0 fail=1
> [ 3626.249738] sched_sync_hw_clock: adjust=1506188926.032470718 now=1506188926.032474358 next=0.967525642 target=0 fail=1
> [ 3627.241688] sched_sync_hw_clock: adjust=1506188927.024472221 now=1506188927.024475501 next=0.975524499 target=0 fail=1
> [ 3628.233656] sched_sync_hw_clock: adjust=1506188928.016475925 now=1506188928.016493206 next=659.983506794 target=0 fail=0
> [ 4297.479450] sched_sync_hw_clock: adjust=1506189597.296468095 now=1506189597.296473256 next=0.703526744 target=0 fail=1
> [ 4298.215411] sched_sync_hw_clock: adjust=1506189598.032469007 now=1506189598.032472527 next=0.967527473 target=0 fail=1
> [ 4299.207366] sched_sync_hw_clock: adjust=1506189599.024475501 now=1506189599.024478982 next=0.975521018 target=0 fail=1
> [ 4300.199324] sched_sync_hw_clock: adjust=1506189600.016469555 now=1506189600.016487676 next=659.983512324 target=0 fail=0
> [ 4969.189207] sched_sync_hw_clock: adjust=1506190269.040474937 now=1506190269.040479897 next=0.959520103 target=0 fail=1
> [ 4970.181150] sched_sync_hw_clock: adjust=1506190270.032471016 now=1506190270.032474976 next=0.967525024 target=0 fail=1
> [ 4971.173104] sched_sync_hw_clock: adjust=1506190271.024476656 now=1506190271.024480136 next=0.975519864 target=0 fail=1
> [ 4972.165063] sched_sync_hw_clock: adjust=1506190272.016471455 now=1506190272.016489416 next=659.983510584 target=0 fail=0
> 
> It looks like we struggle to hit that window, even though it's +/-
> 5 ticks (@250Hz, that's still 20ms, and we can see from the above
> we're twice that.)
> 
> So, I think the old timers are just too sloppy in modern kernels.
> If we want to do this, we need to use a hrtimer to trigger a
> workqueue - in other words, open-coding a hrtimer-delayed workqueue.
> That's something I've already tried, and it seems to work a lot
> better.  I'll adapt it to your current patch.

Same system, but using hrtimer instead:

[    6.256727] sched_sync_hw_clock: adjust=1506191994.278198320 now=1506191994.278210760 next=0.721789240 target=0 fail=1
[    6.978658] sched_sync_hw_clock: adjust=1506191995.000428349 now=1506191995.000635599 next=659.999364401 target=0 fail=0
[  666.863114] sched_sync_hw_clock: adjust=1506192655.001876494 now=1506192655.001897657 next=659.998102343 target=0 fail=0
[ 1326.830734] sched_sync_hw_clock: adjust=1506193315.001819282 now=1506193315.001840282 next=659.998159718 target=0 fail=0

# ./test-rtc
Takes average of 64608ns to read RTC
Took 63920ns to read RTC on second change
RTC Time: 23-09-2017 19:01:59
System Time was:     19:01:59.002

which looks way better.  Here's the hrtimer conversion I tested there:

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 32268e338015..7ab4f1628967 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -492,10 +492,58 @@ int second_overflow(time64_t secs)
 	return leap;
 }
 
+/*
+ * We need to use a hrtimer to queue our work - normal delayed works use
+ * the timer_list timers, which are too inaccurate: for a 10s delay,
+ * they can be delayed between 1 and 63 jiffies.
+ */
+struct hrtimer_delayed_work {
+	struct work_struct work;
+	struct hrtimer timer;
+};
+
+static enum hrtimer_restart hdw_queue_work(struct hrtimer *hr)
+{
+	struct hrtimer_delayed_work *w;
+
+	w = container_of(hr, struct hrtimer_delayed_work, timer);
+	queue_work(system_power_efficient_wq, &w->work);
+
+	return HRTIMER_NORESTART;
+}
+
+static bool hdw_queued(struct hrtimer_delayed_work *hdw)
+{
+	return hrtimer_is_queued(&hdw->timer) != 0;
+}
+
+static void hdw_queue(struct hrtimer_delayed_work *hdw,
+		      const struct timespec64 *t)
+{
+	ktime_t ns = t ? timespec64_to_ktime(*t) : 0;
+
+	hrtimer_start(&hdw->timer, ns, HRTIMER_MODE_REL);
+}
+
+static bool hdw_initialised(struct hrtimer_delayed_work *hdw)
+{
+	return hdw->timer.function != NULL;
+}
+
+static void hdw_init(struct hrtimer_delayed_work *hdw)
+{
+	hrtimer_init(&hdw->timer, CLOCK_REALTIME, HRTIMER_MODE_REL);
+	hdw->timer.function = hdw_queue_work;
+}
+
+
 unsigned int sysctl_ntp_rtc_sync = true;
 
 static void sync_hw_clock(struct work_struct *work);
-static DECLARE_DELAYED_WORK(sync_work, sync_hw_clock);
+
+static struct hrtimer_delayed_work sync_work = {
+	.work = __WORK_INITIALIZER(sync_work.work, sync_hw_clock),
+};
 
 static void sched_sync_hw_clock(struct timespec64 now,
 				unsigned long target_nsec, bool fail)
@@ -526,8 +574,7 @@ static void sched_sync_hw_clock(struct timespec64 now,
 		next.tv_nsec -= NSEC_PER_SEC;
 	}
 
-	queue_delayed_work(system_power_efficient_wq, &sync_work,
-			   timespec64_to_jiffies(&next));
+	hdw_queue(&sync_work, &next);
 
 	printk(KERN_DEBUG "%s: adjust=%lld.%09ld now=%lld.%09ld next=%lld.%09ld target=%ld fail=%d\n",
 		__func__,
@@ -635,9 +682,12 @@ void ntp_notify_cmos_timer(void)
 	if (!ntp_synced() || !sysctl_ntp_rtc_sync)
 		return;
 
-	if (IS_ENABLED(CONFIG_GENERIC_CMOS_UPDATE) ||
-	    IS_ENABLED(CONFIG_RTC_SYSTOHC))
-		queue_delayed_work(system_power_efficient_wq, &sync_work, 0);
+	if (!hdw_initialised(&sync_work))
+		hdw_init(&sync_work);
+
+	if ((IS_ENABLED(CONFIG_GENERIC_CMOS_UPDATE) ||
+	     IS_ENABLED(CONFIG_RTC_SYSTOHC)) && !hdw_queued(&sync_work))
+		hdw_queue(&sync_work, NULL);
 }
 
 /*


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
