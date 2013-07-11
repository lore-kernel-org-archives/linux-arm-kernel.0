From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 11 Jul 2013 07:00:59 -0700
Subject: CPU hotplug issue w/ 0647065 clocksource: Add generic dummy
 timer driver
In-Reply-To: <51DD872D.7020101@wwwdotorg.org>
References: <51DAF895.1020700@wwwdotorg.org>
 <20130709005837.GC830@codeaurora.org>
 <51DC34AD.30009@wwwdotorg.org>
 <20130709163518.GD830@codeaurora.org>
 <51DC3FD2.9070308@wwwdotorg.org>
 <20130709230528.GE830@codeaurora.org>
 <51DD872D.7020101@wwwdotorg.org>
Message-ID: <20130711140059.GA27430@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10, Stephen Warren wrote:
> On 07/09/2013 05:05 PM, Stephen Boyd wrote:
> > On 07/09, Stephen Warren wrote:
> >> On 07/09/2013 10:35 AM, Stephen Boyd wrote:
> >>> On 07/09, Stephen Warren wrote:
> >>>> On 07/08/2013 06:58 PM, Stephen Boyd wrote:
> >>>>> On 07/08, Stephen Warren wrote:
> >>>>>> CPU hotplug (replug) on Tegra HW seems to be occasionally broken due to
> >>>>>> commit 0647065 "clocksource: Add generic dummy timer driver" in
> >>>>>> linux-next. Reverting that commit solves the issue.
> ...
> > Can you try this patch?
> 
> That seems to work great, thanks! I successfully unpugged/replugged CPU1
> about 200 times, whereas without the patch I'd usually see the problem
> about 10% of replug attempts.
> 
> Tested-by: Stephen Warren <swarren@nvidia.com>
> 

Thomas, here's the full patch:

---8<----
Subject: [PATCH] tick: Fix hotplug confusing the broadcast mode

On ARM systems the dummy clockevent is registered with the cpu
hotplug notifier chain before any other per-cpu clockevent. This
has the side-effect of causing the dummy clockevent to be
registered first in every hotplug sequence. Because the dummy is
first, we'll try to turn the broadcast source on but the code in
tick_device_uses_broadcast() assumes the broadcast source is in
periodic mode and calls tick_broadcast_start_periodic()
unconditionally.

On boot this isn't a problem because we typically haven't
switched into oneshot mode yet (if at all). During hotplug, if
the broadcast source isn't in periodic mode we'll replace the
broadcast oneshot handler with the broadcast periodic handler and
start emulating oneshot mode when we shouldn't. Due to the way
the broadcast oneshot handler programs the next_event it's
possible for it to contain KTIME_MAX and cause us to hang the
system when the periodic handler tries to program the next tick.
Fix this by using the appropriate function to start the broadcast
source.

Reported-by: Stephen Warren <swarren@nvidia.com>
Tested-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 kernel/time/tick-broadcast.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation



-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
