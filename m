From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Dec 2012 12:09:00 +0000
Subject: [PATCH v2 1/4] ARM: imx: allow timer counter to roll over
In-Reply-To: <20121205121449.GA26180@S2100-06.ap.freescale.net>
References: <1354632915-27134-1-git-send-email-shawn.guo@linaro.org>
 <1354632915-27134-2-git-send-email-shawn.guo@linaro.org>
 <20121204154459.GG14363@n2100.arm.linux.org.uk>
 <20121205121449.GA26180@S2100-06.ap.freescale.net>
Message-ID: <20121205120900.GN14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 05, 2012 at 08:14:51PM +0800, Shawn Guo wrote:
> On Tue, Dec 04, 2012 at 03:44:59PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Dec 04, 2012 at 10:55:12PM +0800, Shawn Guo wrote:
> > > The timer is configured in free-run mode.  The counter should be
> > > allowed to roll over to 0 when reaching 0xffffffff.  Let's do that
> > > by always returning 0 in set_next_event.
> > 
> > Are you sure this is correct?  It looks wrong to me.
> > 
> > If the time set by the next event has passed, you must return -ETIME
> > from set_next_event() so that the generic timer code can compensate
> > for the missed event and recalculate it, otherwise you will end up
> > having to wait a full count cycle before receiving the next event.
> > 
> > If you find that you're being passed such a small increment that you're
> > constantly hitting that condition, you need to increase your minimum
> > waited interval.
> 
> I think we already have a proper min_delta_tick setting to ensure we
> will not run into the situation that the event will get expired in
> v2_set_next_event().  I guess that's the reason why most of the
> set_next_event() implementations under arch/arm can always return 0?

There are two cases here: there are those where there is a free-running
counter which continually increments/decrements, and it is compared to
a match value to trigger the next interrupt.

There are also those cases where you load the timer with the count value
and it counts towards the interrupt trigger value (either up or down).

With the former, you should check that the event has not passed before
returning, and if it has, you must return -ETIME, particularly if the
wrap takes several seconds.  With the latter, you're going to time out
reasonably close to the desired time anyway, so there's no need to do
any checking (you can't in any case.)  So in this case, you would always
return zero.

> > > diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
> > > index f017302..858098c 100644
> > > --- a/arch/arm/mach-imx/time.c
> > > +++ b/arch/arm/mach-imx/time.c
> > > @@ -139,8 +139,7 @@ static int mx1_2_set_next_event(unsigned long evt,
> > >  
> > >  	__raw_writel(tcmp, timer_base + MX1_2_TCMP);
> > >  
> > > -	return (int)(tcmp - __raw_readl(timer_base + MX1_2_TCN)) < 0 ?
> > > -				-ETIME : 0;
> > > +	return 0;
> > 
> > So what this code was doing is: tcmp is the counter value we expect with
> > the expected event time added.  This may wrap 32-bits.  We subtract the
> > current timer value after we've set the compare register.  If the current
> > timer value was larger than the expected event time, we return -ETIME.
> 
> >From what I have seen, it never happens in event expiring case but
> always in counter wrapping.  Since the timer is configured in free-run
> mode and can keep running after wrapping, it should be safe to always
> return zero.

Well, let's look at the maths here.

Let's say that the counter value is at 0xfffffff0, and the desired timeout
is 32.  This makes tcmp 0x00000010.  Let's say that the counter has only
incremented a small amount to 0xfffffff8:

(int)(tcmp - __raw_readl(timer_base + MX1_2_TCN)

So this becomes 0x10 - 0xfffffff8, which will be 0x18.  So the return value
in this case will be zero.

Now lets consider what happens if the timer has wrapped to 0x00000008.  The
calculation becomes 0x10 - 0x08, which is 0x08.  Again, this is still
positive, so the resulting return value will still be zero.

Now for the boundary condition.  Lets say the timer has incremented to 0x10.
0x10 - 0x10 is 0x00, which is still positive, so the return value will be
zero.  But the next count, 0x11 produces a difference.  0x10 - 0x11 is
negative, so the return value will be -ETIME.

It appears that the original code here is doing the right thing: it's
returning -ETIME if the event which has been programmed has already passed.

> > That to me sounds 100% correct.  Your replacement code of always returning
> > zero looks wrong.
> 
> The code change is fixing a problem seen with WAIT mode support, without
> introducing any regression from what I've seen.
> 
> Enabling WAIT mode support with the original code, we will easily run
> into an infinite loop in tick_handle_oneshot_broadcast() - "goto again;"
> This happens because when global event did not expire any CPU local
> events, the broadcast device will be rearmed to a CPU local next_event,
> which could be far away from now and result in a max_delta_tick
> programming in set_next_event().

Ah, so it's not a wrap of the counter caused by too small an increment,
but a wrap of the timeout value causing the timeout value to potentially
appear wrapped.  That's a slightly more complex case to deal with; how
sa11x0 and PXA deals with this by restricting the max_delta_tick to avoid
the problem:

        ckevt_sa1100_osmr0.max_delta_ns =
                clockevent_delta2ns(0x7fffffff, &ckevt_sa1100_osmr0);
        ckevt_pxa_osmr0.max_delta_ns =
                clockevent_delta2ns(0x7fffffff, &ckevt_pxa_osmr0);

Another solution which avoids restricting max_delta_tick would be to
detect the large increment and avoid the check in that case, so:

	return evt < ((u32)~0) / 2 &&
		(int)(tcmp - __raw_readl(timer_base + MX1_2_TCN)) < 0 ?
				-ETIME : 0;

> One thing I do not understand is why tick_broadcast_set_event() is being
> called with parameter "force" being 0 in tick_handle_oneshot_broadcast().

Presumably because the design of the code is to detect whenever the
requested event has passed, and recalculate the expiry time, rather
than just trying to set a timeout that will occur immediately.
