From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 23 Feb 2015 21:16:22 +0100
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150223181448.GQ9714@leverpostej>
References: <20150211151237.GN9154@leverpostej>
 <1487331.cgC9j5u0aF@vostro.rjw.lan>
 <20150211155720.GQ9154@leverpostej>
 <20150211171515.55d5066f@bbrezillon>
 <20150211163231.GR9154@leverpostej>
 <20150211173823.30c42c6a@bbrezillon>
 <20150220142208.GJ13659@leverpostej>
 <20150220155347.1477b02d@bbrezillon>
 <20150220151655.GK13659@leverpostej>
 <20150223180057.513b069c@bbrezillon>
 <20150223181448.GQ9714@leverpostej>
Message-ID: <20150223211622.37cf3ca1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Feb 2015 18:14:48 +0000
Mark Rutland <mark.rutland@arm.com> wrote:


[...]

> > This is because irq_may_run [1], which is called to decide whether we
> > should handle this irq or just wake the system up [2], will always
> > return true if at least one of the shared action has tagged the irq
> > line as a wakeup source.
> 
> I assume you mean we return false in this case (having triggered the
> wakeup within irq_pm_check_wakeup, which returned true), but otherwise
> agreed.

Yep, I meant 'return false'.


> 
> I can envisage problems if the irq handler of a wakeup device can't be
> run safely until resume time, though I'm not sure if that happens in
> practice given the device is necessarily going to be active.

Isn't that the purpose of the
IRQF_NO_SUSPEND_SAFE/IRQF_SHARED_TIMER_OK/IRQF_SHARED_WAKEUP_SIBLING_OK
flag ? 

> 
> > Sorry for summarizing things you most likely already know, but I want
> > to be sure I'm actually understanding it correctly.
> > 
> > Now, let's look at how this could be solved.
> > Here is a proposal [3] that does the following:
> 
> This would be a lot easier to follow/review as an RFC post to the
> mailing list.

Yep, that was the plan, just wanted to make sure I had correctly
understood the problem before posting an RFC.

> Otherwise I have some high-level comments on the stuff
> below, which I think matches the shape of what we discussed on IRC.
> 
> >  1/ prevent a system wakeup when at least one of the action handler
> >     has set the IRQF_NO_SUSPEND flag
> 
> We might need to add some logic to enable_irq_wake and
> irq_pm_install_action to prevent some of the horrible mismatch cases we
> can get here (e.g. if we have a wakeup handler, a IRQF_NO_SUSPEND
> handler, and another handler which is neither). We may need to
> reconsider temporarily stashing the other potential interrupts.

Actually if we force users to pass the IRQF_XXX_SAFE (I'm tired writing
all the potential names :-)), when mixing IRQF_NO_SUSPEND
and !IRQF_NO_SUSPEND handlers, we shouldn't bother deactivating normal
handlers (those without IRQF_NO_SUSPEND), 'cause they claimed they could
safely be called in suspended state.

> 
> Do we perhaps need an IRQF_SHARED_WAKEUP_SIBLING_OK for timer drivers to
> assert their handlers are safe for the whole suspend period rather than
> just the period they expect to be enabled for? Or do those always
> happen to be safe in practice?

I thought they were always safe...

> 
> >  2/ Add a few helpers to deal with system wakeup from drivers code
> 
> The irq_pm_force_wakeup part looks like what I had in mind.
> 
> >  3/ Rework the at91 RTC driver to show how such weird cases could be
> >     handled
> 
> It might be simpler to do this with a PM notifier within the driver
> rather than having to traverse all the irq_descs, though perhaps not.

I'm not sure to understand that one. Where am I traversing irq_descs
(irq_to_desc, which is called when testing wakeup_armed status, is a
direct table indexing operation) ?
Moreover, I'm not sure when the PM_POST_SUSPEND event is sent, and
testing the WAKEUP_ARMED flag should be safe in all cases, right ?

> 
> > Of course, I'll need the IRQF_SHARED_TIMER_OK patch to prevent the
> > WARN_ON backtrace.
> 
> That should be fine; it's backed up in the list archive ;)
> 
> > Please, let me know if I missed anything important, share your opinion
> > on this proposal, and feel free to propose any other solution.
> 
> Hopefully the above covers that!

Yes it does.
Thanks for the review.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
