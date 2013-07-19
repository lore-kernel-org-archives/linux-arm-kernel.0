From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 19 Jul 2013 17:29:12 +0800
Subject: [PATCH] ARM: tegra: cpuidle: use CPUIDLE_FLAG_TIMER_STOP flag
In-Reply-To: <51E7E27B.9090605@linaro.org>
References: <1372152228-16199-1-git-send-email-josephl@nvidia.com>
 <51E439BC.9030608@wwwdotorg.org>
 <1373973447.8538.80.camel@jlo-ubuntu-64.nvidia.com>
 <51E5A438.10004@wwwdotorg.org>
 <1374056130.10997.16.camel@jlo-ubuntu-64.nvidia.com>
 <51E6FF0B.5000708@wwwdotorg.org>
 <1374145726.5610.73.camel@jlo-ubuntu-64.nvidia.com>
 <51E7E27B.9090605@linaro.org>
Message-ID: <1374226153.24607.3.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-07-18 at 20:41 +0800, Daniel Lezcano wrote:
> On 07/18/2013 01:08 PM, Joseph Lo wrote:
> > On Thu, 2013-07-18 at 04:31 +0800, Stephen Warren wrote:
> >> On 07/17/2013 04:15 AM, Joseph Lo wrote:
> >>> On Wed, 2013-07-17 at 03:51 +0800, Stephen Warren wrote:
> >>>> On 07/16/2013 05:17 AM, Joseph Lo wrote:
> >>>>> On Tue, 2013-07-16 at 02:04 +0800, Stephen Warren wrote:
> >>>>>> On 06/25/2013 03:23 AM, Joseph Lo wrote:
> >>>>>>> Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
> >>>>>>> to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
> >>>>>>> this state.
> >> ... [ discussion of issues with Joesph's patches applied]
> >>>
> >> 2) If I run the hotplug test script, leaving CPU 0 always present, I
> >> sometimes see:
> >>
> >>> root at localhost:~# for i in `seq 1 50`; do echo ITERATION $i; ./cpuonline.py; done
> >>> ITERATION 1
> >>> echo 0 > /sys/devices/system/cpu/cpu2/online
> >>> [  458.910054] CPU2: shutdown
> >>> echo 0 > /sys/devices/system/cpu/cpu1/online
> >>> [  461.004371] CPU1: shutdown
> >>> echo 0 > /sys/devices/system/cpu/cpu3/online
> >>> [  463.027341] CPU3: shutdown
> >>> echo 1 > /sys/devices/system/cpu/cpu1/online
> >>> [  465.061412] CPU1: Booted secondary processor
> >>> echo 1 > /sys/devices/system/cpu/cpu2/online
> >>> [  467.095313] CPU2: Booted secondary processor
> >>> [  467.113243] ------------[ cut here ]------------
> >>> [  467.117948] WARNING: CPU: 2 PID: 0 at kernel/time/tick-broadcast.c:667 tick_broadcast_oneshot_control+0x19c/0x1c4()
> >>> [  467.128352] Modules linked in:
> >>> [  467.131455] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 3.11.0-rc1-00022-g7487363-dirty #49
> >>> [  467.139678] [<c0015620>] (unwind_backtrace+0x0/0xf8) from [<c001154c>] (show_stack+0x10/0x14)
> >>> [  467.148228] [<c001154c>] (show_stack+0x10/0x14) from [<c05135a8>] (dump_stack+0x80/0xc4)
> >>> [  467.156336] [<c05135a8>] (dump_stack+0x80/0xc4) from [<c0024590>] (warn_slowpath_common+0x64/0x88)
> >>> [  467.165300] [<c0024590>] (warn_slowpath_common+0x64/0x88) from [<c00245d0>] (warn_slowpath_null+0x1c/0x24)
> >>> [  467.174959] [<c00245d0>] (warn_slowpath_null+0x1c/0x24) from [<c00695e4>] (tick_broadcast_oneshot_control+0x19c/0x1c4)
> >>> [  467.185659] [<c00695e4>] (tick_broadcast_oneshot_control+0x19c/0x1c4) from [<c0067cdc>] (clockevents_notify+0x1b0/0x1dc)
> >>> [  467.196538] [<c0067cdc>] (clockevents_notify+0x1b0/0x1dc) from [<c034f348>] (cpuidle_idle_call+0x11c/0x168)
> >>> [  467.206292] [<c034f348>] (cpuidle_idle_call+0x11c/0x168) from [<c000f134>] (arch_cpu_idle+0x8/0x38)
> >>> [  467.215359] [<c000f134>] (arch_cpu_idle+0x8/0x38) from [<c0061038>] (cpu_startup_entry+0x60/0x134)
> >>> [  467.224325] [<c0061038>] (cpu_startup_entry+0x60/0x134) from [<800083d8>] (0x800083d8)
> >>> [  467.232227] ---[ end trace ea579be22a00e7fb ]---
> >>> echo 0 > /sys/devices/system/cpu/cpu1/online
> >>> [  469.126682] CPU1: shutdown
> >
> > Hmm. It's hard to reproduce. But finally, I also can repro with CPU
> > hotplug stress test. And some strange issues after apply
> > CPUIDLE_FLAG_TIMER_STOP on Tegra20, can we postpone to apply this?
> > I need more time to investigate how does this flag impact system.
> >
> 
Daniel,

How do you think about this fix?

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index d75040d..0b8878b 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -81,8 +81,16 @@ int cpuidle_enter_state(struct cpuidle_device *dev,
struct cpuidle_driver *drv,
 
        time_start = ktime_get();
 
+       if (drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP)
+               clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
+                                  &dev->cpu);
+
        entered_state = target_state->enter(dev, drv, index);
 
+       if (drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP)
+               clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
+                                  &dev->cpu);
+
        time_end = ktime_get();
 
        local_irq_enable();
@@ -144,20 +152,12 @@ int cpuidle_idle_call(void)
 
        trace_cpu_idle_rcuidle(next_state, dev->cpu);
 
-       if (drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP)
-               clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
-                                  &dev->cpu);
-
        if (cpuidle_state_is_coupled(dev, drv, next_state))
                entered_state = cpuidle_enter_state_coupled(dev, drv,
                                                            next_state);
        else
                entered_state = cpuidle_enter_state(dev, drv,
next_state);
 
-       if (drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP)
-               clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
-                                  &dev->cpu);
-
        trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
 
        /* give the governor an opportunity to reflect on the outcome */
