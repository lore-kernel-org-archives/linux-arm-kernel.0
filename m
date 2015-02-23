From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 23 Feb 2015 18:00:57 +0100
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150220151655.GK13659@leverpostej>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <2437801.56xPyk3atd@vostro.rjw.lan>
 <20150211151237.GN9154@leverpostej>
 <1487331.cgC9j5u0aF@vostro.rjw.lan>
 <20150211155720.GQ9154@leverpostej>
 <20150211171515.55d5066f@bbrezillon>
 <20150211163231.GR9154@leverpostej>
 <20150211173823.30c42c6a@bbrezillon>
 <20150220142208.GJ13659@leverpostej>
 <20150220155347.1477b02d@bbrezillon>
 <20150220151655.GK13659@leverpostej>
Message-ID: <20150223180057.513b069c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Thanks for the clarification, and sorry if I've been a bit harsh to you
in my previous answer, but this whole shared irq thing is starting to
drive me crazy.

On Fri, 20 Feb 2015 15:16:56 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

[...]
 
> 
> An IRQ cannot be shared between a device with IRQF_NO_SUSPEND and a
> device that wishes to operate as a wakeup device, because the semantics
> don't align. One wishes to handle IRQs continuously and one wants to
> abort suspend at the first IRQ (waiting until part-way through the
> resume before handling it).
> 
> So those devices above which wish to operate as wakeup devices are
> either irrelevant or unsalvageable with the current approaches.
> 
> The flag or demux chip only happens to mask the problem in the absence
> of strict sanity checking.
> 
> If you want to be able to share the line then you will need to
> fundamentally rework the way wakeup interrupts work in order to be able
> to decide when you've encountered a real wakeup event.

Okay, I'll try to summarize the discussion we had on IRC regarding this
aspect.

On at91 platforms, irq line 1 is shared by a timer (PIT) and some
devices that can register themselves as wakeup sources (especially the
RTC IP).
I doubt at91 users will agree on dropping either of these features (the
timer or the wakeup on RTC/UART/...), so, can we try to find a solution
that would both make irq, DT and at91 guys happy (that doesn't sound
like an easy task :-)) ?

The whole problem here is that we can't have both IRQF_NO_SUSPEND flag
set on one of the shared action and others that are configuring the irq
as a wakeup source, because it would always lead to the system being
woken up (even when the only thing we were supposed to do is handle the
timer event).

This is because irq_may_run [1], which is called to decide whether we
should handle this irq or just wake the system up [2], will always
return true if at least one of the shared action has tagged the irq
line as a wakeup source.

Sorry for summarizing things you most likely already know, but I want
to be sure I'm actually understanding it correctly.

Now, let's look at how this could be solved.
Here is a proposal [3] that does the following:
 1/ prevent a system wakeup when at least one of the action handler
    has set the IRQF_NO_SUSPEND flag
 2/ Add a few helpers to deal with system wakeup from drivers code
 3/ Rework the at91 RTC driver to show how such weird cases could be
    handled

Of course, I'll need the IRQF_SHARED_TIMER_OK patch to prevent the
WARN_ON backtrace.

Please, let me know if I missed anything important, share your opinion
on this proposal, and feel free to propose any other solution.

[1]http://lxr.free-electrons.com/source/kernel/irq/chip.c#L348
[2]http://lxr.free-electrons.com/source/kernel/irq/chip.c#L386
[3]http://code.bulix.org/gboee1-87936


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
