From: will.deacon@arm.com (Will Deacon)
Date: Wed, 31 Jan 2018 16:17:39 +0000
Subject: [BUG] perf, arm64, acpi: sleeping function called from invalid
 context
In-Reply-To: <CACRpkdZUdOzGnhGxeZwHQEArQnttiXC=QPZBW9KLoxQtmaASXA@mail.gmail.com>
References: <20180129173054.GD794@hc> <20180130134836.GC28882@arm.com>
 <CACRpkdZUdOzGnhGxeZwHQEArQnttiXC=QPZBW9KLoxQtmaASXA@mail.gmail.com>
Message-ID: <20180131161738.GD18758@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Jan 30, 2018 at 04:34:07PM +0100, Linus Walleij wrote:
> On Tue, Jan 30, 2018 at 2:48 PM, Will Deacon <will.deacon@arm.com> wrote:
> 
> >> Changing the allocations in arm_pmu_alloc() to GFP_ATOMIC didn't help,
> >> as the interrupt request is also not happy in this context.
> >>
> >> Would it be possible to init the PMUs later?
> >
> > I know that Mark's had a good go at fixing this, but we ran into problems
> > having the fix co-exist with the IRQ bouncing workaround we perform for the
> > PMU on U8500 platforms. Frustratingly, those platforms don't appear to be
> > available any more, so we're being held up by something that we're unable
> > to test and might be considered dead.
> 
> Not any more dead than the OMAP3 based Nokia n900 or the
> Samsung S3C stuff I would say. Just these don't have weird PMU
> counter interrupts :D
> 
> The Ux500 Galaxy S Advance phone from Samsung was picked up by
> hobbyists from PostmarketOS as a hacking target, maybe that needs to
> become more accessible using just upstream, mea culpa.
> 
> I am willing to test any patches on the reference designs though.

Thanks, we might take you up on that kind offer!

> > Linus, Lee: do we still need to support PMU interrupts on U8500? It's
> > causing us real headaches with ACPI-based arm64 systems. [the answer might
> > be "yes", but I have to ask!]
> 
> Can we still use perf without the IRQs? I.e. I guess it will it fall
> back to some
> sampling method that is "good enough"? We don't do a lot of performance
> testing using perf admittedly.

Right, so perf will still work in counting mode, but sampling mode would be
disabled. This is the case for all other platforms with borked IRQs (e.g.
raspberry pi and imx6), so u8500 would be handled the same way.

> I do think it is unfair to have to support a bunch of weird
> workarounds just because ST Micro decided to connect these two IRQs
> to the same GIC line using an OR gate. IIRC that was the issue.

Yes, that's right and the current workaround of bouncing the IRQ around makes
it impossible to use per-cpu indirection for the IRQ dispatch code, which we
need in order to avoid atomic memory allocation issues with ACPI systems.

I think we'll go ahead and remove the workaround so that we can fix the ACPI
systems. If somebody complains that it breaks for them, then we should
strongly consider looking at falling back on a timer IRQ in the perf core
code when a sampling IRQ is not available.

Sound reasonable as a starting point?

Will
