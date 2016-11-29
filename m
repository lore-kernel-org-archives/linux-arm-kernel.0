From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 Nov 2016 14:51:31 +0000
Subject: [PATCH] clocksource/arm_global_timer: reconfigure clockevents
 after cpufreq change
In-Reply-To: <alpine.DEB.2.20.1611291529520.4358@nanos>
References: <1480421716-30782-1-git-send-email-al.kochet@gmail.com>
 <1480421716-30782-2-git-send-email-al.kochet@gmail.com>
 <alpine.DEB.2.20.1611291432290.4358@nanos>
 <763a77c2-3d19-8d20-88df-27f0b8b80b8b@arm.com>
 <alpine.DEB.2.20.1611291529520.4358@nanos>
Message-ID: <54233c9e-d136-4b85-b2db-bf8658a164e7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/11/16 14:32, Thomas Gleixner wrote:
> On Tue, 29 Nov 2016, Marc Zyngier wrote:
>> On 29/11/16 13:42, Thomas Gleixner wrote:
>>> Assumptions w/o real impact are a perfect reason not to apply that
>>> patch. This want's a proper proof that the global timer really changes and
>>> this hackery is required, which I seriously doubt.
>>
>> Well, let's not underestimate the "creativity" [1] of A5/A9 when it
>> comes to the timer clocks, and it is a very sad fact that both the
>> global timer and the local timers are clocked by PERIPHCLK, which is
>> ticking at a fixed ratio N (N >= 2) of the main CPU clock (CLK):
>>
>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0407f/CIHGECHJ.html
>>
>> I'm not sure how feasible it is to change this ratio (the TRM seems to
>> be very silent on the subject).
> 
> The CRU documentation of the RK3188 suggests that you can adjust it as it
> has a seperate divider, but who knows.
> 
>> So short of being able to reconfigure it on the fly, this will probably
>> need some surgery similar to what we already do for the TWD (which this
>> patch mimics).
>>
>> Thankfully, we don't see that anymore on moderately recent HW (anything
>> since A15) and the advent of the arch timer, which is guaranteed to have
>> a fixed frequency.
> 
> Can we just disable that global timer on affected SoCs and use something
> else instead?

That'd be my preferred course of action. I've located some documentation
over there [1], and page 1126 seems to indicate a profusion of
additional timers, some of which are in an always-on domain. Seems like
a much better use of someone's time...

Thanks,

	M.

[1] http://rockchip.fr/Rockchip%20RK3188%20TRM%20V1.3.pdf
-- 
Jazz is not dead. It just smells funny...
