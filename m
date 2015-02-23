From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 23 Feb 2015 18:14:48 +0000
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150223180057.513b069c@bbrezillon>
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
Message-ID: <20150223181448.GQ9714@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 23, 2015 at 05:00:57PM +0000, Boris Brezillon wrote:
> Hi Mark,
> 
> Thanks for the clarification, and sorry if I've been a bit harsh to you
> in my previous answer, but this whole shared irq thing is starting to
> drive me crazy.

No worries. Having lost a few days exploring the core and call sites,
and having seen how widesrpead IRQF_NO_SUSPEND misuse is, it's beginning
to grate on me too.

[...]

> On at91 platforms, irq line 1 is shared by a timer (PIT) and some
> devices that can register themselves as wakeup sources (especially the
> RTC IP).
> I doubt at91 users will agree on dropping either of these features (the
> timer or the wakeup on RTC/UART/...), so, can we try to find a solution
> that would both make irq, DT and at91 guys happy (that doesn't sound
> like an easy task :-)) ?

>From the DT side, I think all the necessary information is there. We
know how the interrupts are wired, so nothing needs to change w.r.t. the
topology description. I hope that we have sufficient information to when
a device may operate and raise interrupts during suspend.

So the fun part is how we solve this within Linux.

> The whole problem here is that we can't have both IRQF_NO_SUSPEND flag
> set on one of the shared action and others that are configuring the irq
> as a wakeup source, because it would always lead to the system being
> woken up (even when the only thing we were supposed to do is handle the
> timer event).
> 
> This is because irq_may_run [1], which is called to decide whether we
> should handle this irq or just wake the system up [2], will always
> return true if at least one of the shared action has tagged the irq
> line as a wakeup source.

I assume you mean we return false in this case (having triggered the
wakeup within irq_pm_check_wakeup, which returned true), but otherwise
agreed.

I can envisage problems if the irq handler of a wakeup device can't be
run safely until resume time, though I'm not sure if that happens in
practice given the device is necessarily going to be active.

> Sorry for summarizing things you most likely already know, but I want
> to be sure I'm actually understanding it correctly.
> 
> Now, let's look at how this could be solved.
> Here is a proposal [3] that does the following:

This would be a lot easier to follow/review as an RFC post to the
mailing list. Otherwise I have some high-level comments on the stuff
below, which I think matches the shape of what we discussed on IRC.

>  1/ prevent a system wakeup when at least one of the action handler
>     has set the IRQF_NO_SUSPEND flag

We might need to add some logic to enable_irq_wake and
irq_pm_install_action to prevent some of the horrible mismatch cases we
can get here (e.g. if we have a wakeup handler, a IRQF_NO_SUSPEND
handler, and another handler which is neither). We may need to
reconsider temporarily stashing the other potential interrupts.

Do we perhaps need an IRQF_SHARED_WAKEUP_SIBLING_OK for timer drivers to
assert their handlers are safe for the whole suspend period rather than
just the period they expect to be enabled for? Or do those always
happen to be safe in practice?

>  2/ Add a few helpers to deal with system wakeup from drivers code

The irq_pm_force_wakeup part looks like what I had in mind.

>  3/ Rework the at91 RTC driver to show how such weird cases could be
>     handled

It might be simpler to do this with a PM notifier within the driver
rather than having to traverse all the irq_descs, though perhaps not.

> Of course, I'll need the IRQF_SHARED_TIMER_OK patch to prevent the
> WARN_ON backtrace.

That should be fine; it's backed up in the list archive ;)

> Please, let me know if I missed anything important, share your opinion
> on this proposal, and feel free to propose any other solution.

Hopefully the above covers that!

Mark.
