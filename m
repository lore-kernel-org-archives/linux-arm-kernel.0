From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Dec 2012 20:14:51 +0800
Subject: [PATCH v2 1/4] ARM: imx: allow timer counter to roll over
In-Reply-To: <20121204154459.GG14363@n2100.arm.linux.org.uk>
References: <1354632915-27134-1-git-send-email-shawn.guo@linaro.org>
 <1354632915-27134-2-git-send-email-shawn.guo@linaro.org>
 <20121204154459.GG14363@n2100.arm.linux.org.uk>
Message-ID: <20121205121449.GA26180@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 03:44:59PM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 04, 2012 at 10:55:12PM +0800, Shawn Guo wrote:
> > The timer is configured in free-run mode.  The counter should be
> > allowed to roll over to 0 when reaching 0xffffffff.  Let's do that
> > by always returning 0 in set_next_event.
> 
> Are you sure this is correct?  It looks wrong to me.
> 
> If the time set by the next event has passed, you must return -ETIME
> from set_next_event() so that the generic timer code can compensate
> for the missed event and recalculate it, otherwise you will end up
> having to wait a full count cycle before receiving the next event.
> 
> If you find that you're being passed such a small increment that you're
> constantly hitting that condition, you need to increase your minimum
> waited interval.

I think we already have a proper min_delta_tick setting to ensure we
will not run into the situation that the event will get expired in
v2_set_next_event().  I guess that's the reason why most of the
set_next_event() implementations under arch/arm can always return 0?

> > diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
> > index f017302..858098c 100644
> > --- a/arch/arm/mach-imx/time.c
> > +++ b/arch/arm/mach-imx/time.c
> > @@ -139,8 +139,7 @@ static int mx1_2_set_next_event(unsigned long evt,
> >  
> >  	__raw_writel(tcmp, timer_base + MX1_2_TCMP);
> >  
> > -	return (int)(tcmp - __raw_readl(timer_base + MX1_2_TCN)) < 0 ?
> > -				-ETIME : 0;
> > +	return 0;
> 
> So what this code was doing is: tcmp is the counter value we expect with
> the expected event time added.  This may wrap 32-bits.  We subtract the
> current timer value after we've set the compare register.  If the current
> timer value was larger than the expected event time, we return -ETIME.

>From what I have seen, it never happens in event expiring case but
always in counter wrapping.  Since the timer is configured in free-run
mode and can keep running after wrapping, it should be safe to always
return zero.

> That to me sounds 100% correct.  Your replacement code of always returning
> zero looks wrong.

The code change is fixing a problem seen with WAIT mode support, without
introducing any regression from what I've seen.

Enabling WAIT mode support with the original code, we will easily run
into an infinite loop in tick_handle_oneshot_broadcast() - "goto again;"
This happens because when global event did not expire any CPU local
events, the broadcast device will be rearmed to a CPU local next_event,
which could be far away from now and result in a max_delta_tick
programming in set_next_event().  This will certainly cause a counter
wrapping and then a -ETIME return, which in turn makes the execution
fall into the "goto again" loop.

One thing I do not understand is why tick_broadcast_set_event() is being
called with parameter "force" being 0 in tick_handle_oneshot_broadcast().
This will make clockevents_program_event() skip
clockevents_program_min_delta() call in that case.  Changing "force"
to 1 also fixes my problem, but I wouldn't be so aggressive to change
the clockevents core code when there is a fix that could be applied
at platform level.

Shawn
