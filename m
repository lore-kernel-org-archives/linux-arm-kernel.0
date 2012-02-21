From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 21 Feb 2012 22:02:32 +0800
Subject: [PATCH] ARM: perf: do not handle deleted counter in irq handler
 to avoid oops
In-Reply-To: <20120221133228.GK19696@mudshark.cambridge.arm.com>
References: <1329799058-27082-1-git-send-email-tom.leiming@gmail.com>
 <20120221133228.GK19696@mudshark.cambridge.arm.com>
Message-ID: <CACVXFVMxpRDsG_hNn_WaX17uEdZCJmcraOvDwCL6JQ7Xyz5nig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Feb 21, 2012 at 9:32 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Ming Lei,
>
> Thanks for the patch. I looked at this in the past since there was a buggy
> FPGA flying about that could fire spurious overflows but I didn't get round
> to doing anything with the patches.
>
> On Tue, Feb 21, 2012 at 04:37:38AM +0000, Ming Lei wrote:
>> The patch adds one check in irq handler to skip handling deleted
>> counter for avoiding oops.
>>
>> When one counter is deleted, event reference(hw_events->events[idx])
>> will be cleared but the hw overflow status may be kept, so the
>> hw event may be handled and oops will be triggered in irq handler if
>> pmu irq from other events come.
>
> Interesting, I'd not considered the case where the counter overflows while
> we are in the process of disabling it. That needs fixing.
>
>> The another candidate fix is to clear the overflow status for the
>> event in arm_pmu->disable(), but looks it is a bit more complicated
>> and has no obvious advantage than the fix in this patch.
>
> It's not much more complicated and it does have the advantage that we avoid
> taking an extra interrupt and also avoid the unlikely case where we take an

The extra interrupt may not be triggered since it has been disabled in
->disable().
Even though it is routed to gic before disabling, the check added can handle the
case well.

> interrupt in the context of a task using perf different from the one in which
> the counter overflowed, leading to false accounting.

I have thought about the case. Even the first irq is triggered after the new
counter is added on a new task context, there is still very few count accounted
since the count read from hw counter is sure to be very similar with
count written
to hw counter. That is why I mentioned clearing overflow flag in
->disable has no
obvious advantage.

But you can do it if you like, :-)

In fact, I have tried to clear overflow in armpmu->disable() on OMAP4 and found
it is surely capable of fixing the oops.

>
>> ---
>> ?arch/arm/kernel/perf_event_v7.c ? ? | ? ?3 ++-
>> ?arch/arm/kernel/perf_event_xscale.c | ? ?2 +-
>> ?2 files changed, 3 insertions(+), 2 deletions(-)
>
> I have a couple of patches that solve this by (a) clearing the overflow flag
> when disabling the counter for ARMv7 and (b) adding the event checks to the

Maybe ARMv6 and xscale need to be fixed too if the overflow flag will be kept
even after the counter is disabled.

> interrupt handlers in case the hardware is misbehaving.


thanks,
-- 
Ming Lei
