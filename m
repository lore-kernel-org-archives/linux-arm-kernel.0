From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 7 Mar 2013 15:26:19 +0000
Subject: [BUG] ARM Architected timers appear broken in 3.9-rc1
In-Reply-To: <1362654289.3323.18.camel@linaro1.home>
References: <1362654289.3323.18.camel@linaro1.home>
Message-ID: <20130307152619.GA24366@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 11:04:49AM +0000, Jon Medhurst (Tixy) wrote:
> Hi Mark

Hi,

> 
> When booting Versatile Express TC2 I am getting a null pointer
> dereference which appears to be related to the recent changes in
> architected timer support. 
> 
> The interesting part of the call stack is below (the full log is
> attached). It shows that whilst entering CPU idle the code is calling
> the NULL set_next_event function on the dummy timer setup by
> broadcast_timer_setup.

As you say, we're calling the NULL set_next_event on the dummy timer,
because the dummy is registered as the broadcast device, which makes no
sense (as that means it's responsible for broadcasting to itself).

As far as I can see, the issue is that the dummy timer has a higher
rating (400) than the sp804 (300) that would otherwise be used as the
broadcast source, and tick_check_broadcast_device does not reject clocks
with CLOCK_EVT_FEAT_DUMMY (which should *never* be used as a broadcast
source). 

Giving the dummy timer a lower rating than the sp804 would prevent this,
but it might make more sense to do something like the below and
explicitly prevent dummy timers from being registered as broadcast
sources (this seems to work for me with your kernel, though I hit an
unrelated BUG() later due to bL_platform_power_ops *power_ops not being
set).

Thomas, what do you think?

Thanks,
Mark.
---->8----
>From 7432019cdfea9b2808e3b04489cd71a89266ca8f Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 7 Mar 2013 15:09:24 +0000
Subject: [PATCH] clockevents: don't allow dummy broadcast timers

Currently tick_check_broadcast_device doesn't reject clock_event_devices
with CLOCK_EVT_FEAT_DUMMY, and may select them in preference to real
hardware if they have a higher rating value. In this situation, the
dummy timer is responsible for broadcasting to itself, and the core
clockevents code may attempt to call non-existent callbacks for
programming the dummy, eventually leading to a panic.

This patch makes tick_check_broadcast_device always reject dummy timers,
preventing this problem.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 kernel/time/tick-broadcast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 2fb8cb8..7f32fe0 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -67,7 +67,8 @@ static void tick_broadcast_start_periodic(struct clock_event_device *bc)
  */
 int tick_check_broadcast_device(struct clock_event_device *dev)
 {
-	if ((tick_broadcast_device.evtdev &&
+	if ((dev->features & CLOCK_EVT_FEAT_DUMMY) ||
+	    (tick_broadcast_device.evtdev &&
 	     tick_broadcast_device.evtdev->rating >= dev->rating) ||
 	     (dev->features & CLOCK_EVT_FEAT_C3STOP))
 		return 0;
-- 
1.8.1.1
