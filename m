From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 9 Jul 2013 16:05:28 -0700
Subject: CPU hotplug issue w/ 0647065 clocksource: Add generic dummy
 timer driver
In-Reply-To: <51DC3FD2.9070308@wwwdotorg.org>
References: <51DAF895.1020700@wwwdotorg.org>
 <20130709005837.GC830@codeaurora.org>
 <51DC34AD.30009@wwwdotorg.org>
 <20130709163518.GD830@codeaurora.org>
 <51DC3FD2.9070308@wwwdotorg.org>
Message-ID: <20130709230528.GE830@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09, Stephen Warren wrote:
> On 07/09/2013 10:35 AM, Stephen Boyd wrote:
> > On 07/09, Stephen Warren wrote:
> >> On 07/08/2013 06:58 PM, Stephen Boyd wrote:
> >>> On 07/08, Stephen Warren wrote:
> >>>> CPU hotplug (replug) on Tegra HW seems to be occasionally broken due to
> >>>> commit 0647065 "clocksource: Add generic dummy timer driver" in
> >>>> linux-next. Reverting that commit solves the issue.
> >>>
> >>> We found some breakage during boot that has been fixed by two
> >>> commits in linus' tree already. Do you know if you have these two
> >>> patches
> >>>
> >>> 1f73a9806bdd07a5106409bbcab3884078bd34fe
> >>> 07bd1172902e782f288e4d44b1fde7dec0f08b6f
> >>
> >> I didn't before since I was using next-20130705, but I just tried
> >> next-20130709 which does have those two commits, and I still see the issue.
> >>
> > 
> > Ok can you get the output of /proc/timer_list and send it back
> 
> Sure, it's below. I took another snapshot after unplugging then
> re-plugging CPU1, and there was no difference except in the actual time
> values and list of queued events (at ~line 12). The set of timers,
> modes, etc. were all the same.

Ok I think I understand the problem now. The dummy timer is
registered with the cpu hotplug notifier first. Then the TWD is
registered, so what we get is a clockevent_register(dummy)
followed by a clockevent_register(twd) on every hotplug (probably
something we should optimize later). Regardless, when we hotplug
out the CPU, the broadcast device is in oneshot mode. When we
hotplug back in the CPU, the dummy event gets added first and
fills in the per-cpu tickdevice slot for CPU1.

When this happens we have to start the broadcast timer and the
code there just forces the broadcast device to use the periodic
broadcast handler (see tick_device_uses_broadcast()) without
checking to see if the mode is periodic. Once that event handler
is assigned to periodic broadcast we're in danger of getting an
interrupt and trying to emulate oneshot mode when we shouldn't
be.

Can you try this patch?


diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 6d3f916..218bcb5 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -157,7 +157,10 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
 		dev->event_handler = tick_handle_periodic;
 		tick_device_setup_broadcast_func(dev);
 		cpumask_set_cpu(cpu, tick_broadcast_mask);
-		tick_broadcast_start_periodic(bc);
+		if (tick_broadcast_device.mode == TICKDEV_MODE_PERIODIC)
+			tick_broadcast_start_periodic(bc);
+		else
+			tick_broadcast_setup_oneshot(bc);
 		ret = 1;
 	} else {
 		/*

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
