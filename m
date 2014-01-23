From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 22 Jan 2014 17:19:34 -0700
Subject: [PATCH v2 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
In-Reply-To: <52E05C4E.9060709@gmail.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233537.GS18269@obsidianresearch.com>
 <20140122164904.GB27273@localhost>
 <20140122173417.GT18269@obsidianresearch.com>
 <52E02AB6.7040104@gmail.com>
 <20140122205213.GW18269@obsidianresearch.com>
 <20140122221237.GA30763@localhost>
 <20140122223117.GX18269@obsidianresearch.com>
 <52E05C4E.9060709@gmail.com>
Message-ID: <20140123001934.GY18269@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 01:03:26AM +0100, Sebastian Hesselbarth wrote:
> >Sebastian:
> >I looked at the irq-orion driver a bit more and noticed this:
> >
> >         ret = irq_alloc_domain_generic_chips(domain, nrirqs, 1, np->name,
> >                              handle_level_irq, clr, 0, IRQ_GC_INIT_MASK_CACHE);
> >                            ^^^^^^^^^^^^^^^^^^^^^
> >Shouldn't it be handle_edge_irq? Otherwise who is calling irq_ack? How
> >does this work at all? :)
> 
> I can tell you that it comes from arch/arm/plat-orion/irq.c and I
> blindly copied it. I never really checked the differences in handling
> level/edge irqs. Besides, if it wasn't working, we wouldn't get far
> in booting the kernel without timer irqs.

Ezequiel found the ack call I missed, so it makes sense it works.

I think the difference in routines only starts to matter when you can
get another incoming edge IRQ while already handling one (due to SMP?
threaded interrupts? RealTime? not sure)

> It also remains asserted if you clear the actual cause of the interrupt
> and is only asserted again on the next low-to-high transition.

Which is why Ezequiel's patch is the right approach: we need to clear
the interrupt latched in the cause register after the watchdog driver
disable but before enabling/unmasking the interrupt.

Remember, the BRIDGE_MASK register has no effect on the BRIDGE_CAUSE,
it only effects which bits propogate to the main cause register.

> *BUT*, I will double-check how Linux deals with level/edge irqs and if
> Orion SoCs have edge or level triggered cause registers. That should
> reveal, if it is more sane to use handle_edge_irq here and possibly in
> the main interrupt controller, too.

There is a mixture.

Any cause bit documented to be clearable is edge triggered, all others
are level.

On Kirkwood this means all of the main interrupt controller bits are
level and all the bridge bits are edge. Which means edge is
definitely correct for the bridge handler, and level correct for the
main handler.

Jason
