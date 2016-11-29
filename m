From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 Nov 2016 14:14:09 +0000
Subject: [PATCH] clocksource/arm_global_timer: reconfigure clockevents
 after cpufreq change
In-Reply-To: <alpine.DEB.2.20.1611291432290.4358@nanos>
References: <1480421716-30782-1-git-send-email-al.kochet@gmail.com>
 <1480421716-30782-2-git-send-email-al.kochet@gmail.com>
 <alpine.DEB.2.20.1611291432290.4358@nanos>
Message-ID: <763a77c2-3d19-8d20-88df-27f0b8b80b8b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/11/16 13:42, Thomas Gleixner wrote:
> On Tue, 29 Nov 2016, Alexander Kochetkov wrote:
> 
>> After a cpufreq transition, update the clockevent's frequency
>> by fetching the new clock rate from the clock framework and
>> reprogram the next clock event.
> 
> The frequency change would not only affect the clockevent device, it also
> would affect the clocksource. So the patch is incomplete, but see below.
> 
>> The clock supplying the arm-global-timer on the rk3188 is coming
>> from the the cpu clock itself and thus changes its rate everytime
>> cpufreq adjusts the cpu frequency.
> 
> That's broken and the clk framework should keep the CORE_PERI clock at a
> constant rate by reprogramming the divider of the CPU clock.
> 
>> Found by code review, real impact not known. Assume what actual
>> HZ value will be different from expected on platforms using
>> arm-global-timer as clockevent.
> 
> Assumptions w/o real impact are a perfect reason not to apply that
> patch. This want's a proper proof that the global timer really changes and
> this hackery is required, which I seriously doubt.

Well, let's not underestimate the "creativity" [1] of A5/A9 when it
comes to the timer clocks, and it is a very sad fact that both the
global timer and the local timers are clocked by PERIPHCLK, which is
ticking at a fixed ratio N (N >= 2) of the main CPU clock (CLK):

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0407f/CIHGECHJ.html

I'm not sure how feasible it is to change this ratio (the TRM seems to
be very silent on the subject). So short of being able to reconfigure it
on the fly, this will probably need some surgery similar to what we
already do for the TWD (which this patch mimics).

Thankfully, we don't see that anymore on moderately recent HW (anything
since A15) and the advent of the arch timer, which is guaranteed to have
a fixed frequency.

Thanks,

	M.

[1] I wanted to write something else, but common decency prevents me
from being more explicit...
-- 
Jazz is not dead. It just smells funny...
