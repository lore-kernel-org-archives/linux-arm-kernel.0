From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Sep 2017 12:21:52 +0100
Subject: On NTP, RTCs and accurately setting their time
Message-ID: <20170920112152.GL20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It's common for systems to be time synchronised using programs such as
chrony or ntpd.  In such situations, when we are properly synchronised,
the kernel writes the current time to the RTC every 11 seconds.

However, assumptions are made about the RTC:

1. kernel/time/ntp.c assumes that all RTCs want to be told to set the
   time at around 500ms into the second.

2. drivers/rtc/systohc.c assumes that if the time being set is >= 500ms,
   then we want to set the _next_ second.

This leads to RTCs being set with an offset time, where the offset
depends on the RTC.  For example, the PCF8523 ends up reliably set
around 970ms in the future:

RTC Time: 19-09-2017 14:27:51
System Time was:     14:27:50.031

What this means is that when the RTC ticked from 50 to 51 seconds,
system time was at 50.031s.  Hence, the RTC in this case is 969ms
in the future.

For Armada 388, the situation is different:

RTC Time: 19-09-2017 14:48:17
System Time was:     14:48:16.521

Here, the RTC is being set 479ms in the future.

The SNVS RTC in imx6 is different again, although I have no definitive
figures yet.

Why does this matter - if you introduce a 1s offset in system time
(eg, you reboot a machine running NTP) then it takes at least four hours
after the reboot for ntpd to settle down, with the PPM swinging faster
and slower than normal as it compensates for the offset.  This means if
you are using a Linux system for time measurement purposes, it is
useless for those four hours.

Being able to accurately save and restore system time helps to reduce
the disruptive effect of a reboot.

Currently, there are no controls in the kernel over this mechanism - if
you're running a multi-platform kernel which has support for writing the
RTC if ntp-sync'd, then you're stuck with the kernel writing the RTC
every 11 seconds.  Not only is this detrimental due to the enforced RTC
dependent offset, but it also means that if you want to trim your RTC
to a synchronised source of time (for which the kernel must not write
the RTC, but you do want it to ntp sync), the only way to do it is to
either modify the kernel, or disable CONFIG_RTC_SYSTOHC in the multi-
platform kernel.


The kernel can do better - elimination of the rounding-up in systohc.c
gives a better result for PCF8523:

RTC Time: 19-09-2017 16:30:38
System Time was:     16:30:38.034

and the remaining offset can be reduced by adjusting the 500ms offset
in ntp.c to 470ms.  This is specific to the offset that PCF8523 wants.
We know that MC146818 RTCs found in PCs want a 500ms offset (without
the addition of one second that systohc.c does.)  The Armada 388 RTC
wants to be set on the exact second.

We need some way to cater for these differing requirements (eg, RTC
drivers provide some properties to rtclib and the ntp code to describe
how long it takes for a written time to "take"), or we decide (as I
think was decided in the past) that the kernel should not be setting
the RTC, but userspace should be responsible for performing that
function.  Either way, we need to know about these RTC specific
properties in order to set their time accurately.

One of the issues here, however, is that RTC datasheets do not give this
information - this can only be found out by experimentation and
measurement.

Currently I'm using the hacky patch below to be able to (a) disable the
regular RTC write during runtime, so I can measure the RTC drift and
trim it, and (b) provide a knob to adjust how far past the second the
RTC will receive its write.  For a properly trimmed PCF8523 (measured
over about 12 hours to have 0.1ppm drift - which is better than its
associated crystal is rated for), setting this knob to 470ms results
in the following (from two samples this morning):

RTC Time: 20-09-2017 10:41:30
System Time was:     10:41:30.000
RTC Time: 20-09-2017 11:17:38
System Time was:     11:17:38.000

There's probably some noise in the setting of this due to the workqueue,
but getting it within 10ms is definitely an improvement over being
almost a second out.

So, the question is... how should these differences in rtc requirements
be handled?

 drivers/rtc/systohc.c |  6 +++---
 kernel/sysctl.c       | 21 +++++++++++++++++++++
 kernel/time/ntp.c     |  9 ++++++---
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/systohc.c b/drivers/rtc/systohc.c
index b4a68ffcd06b..df804597de71 100644
--- a/drivers/rtc/systohc.c
+++ b/drivers/rtc/systohc.c
@@ -26,10 +26,7 @@ int rtc_set_ntp_time(struct timespec64 now)
 	struct rtc_time tm;
 	int err = -ENODEV;
 
-	if (now.tv_nsec < (NSEC_PER_SEC >> 1))
-		rtc_time64_to_tm(now.tv_sec, &tm);
-	else
-		rtc_time64_to_tm(now.tv_sec + 1, &tm);
+	rtc_time64_to_tm(now.tv_sec, &tm);
 
 	rtc = rtc_class_open(CONFIG_RTC_SYSTOHC_DEVICE);
 	if (rtc) {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6648fbbb8157..c2ce802f7ab9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -98,6 +98,9 @@
 
 #if defined(CONFIG_SYSCTL)
 
+extern unsigned int sysctl_ntp_rtc_offset;
+extern unsigned int sysctl_ntp_rtc_sync;
+
 /* External variables not in a header file. */
 extern int suid_dumpable;
 #ifdef CONFIG_COREDUMP
@@ -303,6 +306,24 @@ static int max_extfrag_threshold = 1000;
 #endif
 
 static struct ctl_table kern_table[] = {
+#if defined(CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC)
+	{
+		.procname	= "ntp_rtc_offset",
+		.data		= &sysctl_ntp_rtc_offset,
+		.maxlen		= sizeof(sysctl_ntp_rtc_offset),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec,
+	},
+	{
+		.procname	= "ntp_rtc_sync",
+		.data		= &sysctl_ntp_rtc_sync,
+		.maxlen		= sizeof(sysctl_ntp_rtc_sync),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
+#endif
 	{
 		.procname	= "sched_child_runs_first",
 		.data		= &sysctl_sched_child_runs_first,
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index edf19cc53140..674c45d30561 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -508,6 +508,9 @@ int __weak update_persistent_clock64(struct timespec64 now64)
 #endif
 
 #if defined(CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC)
+unsigned long sysctl_ntp_rtc_offset = NSEC_PER_SEC / 2;
+unsigned int sysctl_ntp_rtc_sync = true;
+
 static void sync_cmos_clock(struct work_struct *work);
 
 static DECLARE_DELAYED_WORK(sync_cmos_work, sync_cmos_clock);
@@ -526,7 +529,7 @@ static void sync_cmos_clock(struct work_struct *work)
 	 * may not expire at the correct time.  Thus, we adjust...
 	 * We want the clock to be within a couple of ticks from the target.
 	 */
-	if (!ntp_synced()) {
+	if (!ntp_synced() || !sysctl_ntp_rtc_sync) {
 		/*
 		 * Not synced, exit, do not restart a timer (if one is
 		 * running, let it run out).
@@ -535,7 +538,7 @@ static void sync_cmos_clock(struct work_struct *work)
 	}
 
 	getnstimeofday64(&now);
-	if (abs(now.tv_nsec - (NSEC_PER_SEC / 2)) <= tick_nsec * 5) {
+	if (abs(now.tv_nsec - sysctl_ntp_rtc_offset) <= tick_nsec * 5) {
 		struct timespec64 adjust = now;
 
 		fail = -ENODEV;
@@ -551,7 +554,7 @@ static void sync_cmos_clock(struct work_struct *work)
 #endif
 	}
 
-	next.tv_nsec = (NSEC_PER_SEC / 2) - now.tv_nsec - (TICK_NSEC / 2);
+	next.tv_nsec = sysctl_ntp_rtc_offset - now.tv_nsec - (TICK_NSEC / 2);
 	if (next.tv_nsec <= 0)
 		next.tv_nsec += NSEC_PER_SEC;
 


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync@8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
