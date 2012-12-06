From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 6 Dec 2012 17:34:47 +0800
Subject: [PATCH v2 1/4] ARM: imx: allow timer counter to roll over
In-Reply-To: <20121205120900.GN14363@n2100.arm.linux.org.uk>
References: <1354632915-27134-1-git-send-email-shawn.guo@linaro.org>
 <1354632915-27134-2-git-send-email-shawn.guo@linaro.org>
 <20121204154459.GG14363@n2100.arm.linux.org.uk>
 <20121205121449.GA26180@S2100-06.ap.freescale.net>
 <20121205120900.GN14363@n2100.arm.linux.org.uk>
Message-ID: <20121206093445.GA27003@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 05, 2012 at 12:09:00PM +0000, Russell King - ARM Linux wrote:
> Well, let's look at the maths here.
> 
> Let's say that the counter value is at 0xfffffff0, and the desired timeout
> is 32.  This makes tcmp 0x00000010.  Let's say that the counter has only
> incremented a small amount to 0xfffffff8:
> 
> (int)(tcmp - __raw_readl(timer_base + MX1_2_TCN)
> 
> So this becomes 0x10 - 0xfffffff8, which will be 0x18.  So the return value
> in this case will be zero.
> 
> Now lets consider what happens if the timer has wrapped to 0x00000008.  The
> calculation becomes 0x10 - 0x08, which is 0x08.  Again, this is still
> positive, so the resulting return value will still be zero.
> 
> Now for the boundary condition.  Lets say the timer has incremented to 0x10.
> 0x10 - 0x10 is 0x00, which is still positive, so the return value will be
> zero.  But the next count, 0x11 produces a difference.  0x10 - 0x11 is
> negative, so the return value will be -ETIME.
> 
> It appears that the original code here is doing the right thing: it's
> returning -ETIME if the event which has been programmed has already passed.

This is a helpful explanation.  I was indeed fix my problem in a wrong
way.

> > > That to me sounds 100% correct.  Your replacement code of always returning
> > > zero looks wrong.
> > 
> > The code change is fixing a problem seen with WAIT mode support, without
> > introducing any regression from what I've seen.
> > 
> > Enabling WAIT mode support with the original code, we will easily run
> > into an infinite loop in tick_handle_oneshot_broadcast() - "goto again;"
> > This happens because when global event did not expire any CPU local
> > events, the broadcast device will be rearmed to a CPU local next_event,
> > which could be far away from now and result in a max_delta_tick
> > programming in set_next_event().
> 
> Ah, so it's not a wrap of the counter caused by too small an increment,
> but a wrap of the timeout value causing the timeout value to potentially
> appear wrapped.  That's a slightly more complex case to deal with; how
> sa11x0 and PXA deals with this by restricting the max_delta_tick to avoid
> the problem:
> 
>         ckevt_sa1100_osmr0.max_delta_ns =
>                 clockevent_delta2ns(0x7fffffff, &ckevt_sa1100_osmr0);
>         ckevt_pxa_osmr0.max_delta_ns =
>                 clockevent_delta2ns(0x7fffffff, &ckevt_pxa_osmr0);
> 
> Another solution which avoids restricting max_delta_tick would be to
> detect the large increment and avoid the check in that case, so:
> 
> 	return evt < ((u32)~0) / 2 &&
> 		(int)(tcmp - __raw_readl(timer_base + MX1_2_TCN)) < 0 ?
> 				-ETIME : 0;
> 
I will go for this one, since it keeps max_delta_tick stay as big as
possible.

> > One thing I do not understand is why tick_broadcast_set_event() is being
> > called with parameter "force" being 0 in tick_handle_oneshot_broadcast().
> 
> Presumably because the design of the code is to detect whenever the
> requested event has passed, and recalculate the expiry time, rather
> than just trying to set a timeout that will occur immediately.

Thanks for help understand all these, Russell.

Shawn
