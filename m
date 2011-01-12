From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jan 2011 10:56:59 +0000
Subject: [RFC] ARM: Let GIC to route IRQs to any allowed CPUs
In-Reply-To: <AANLkTim3BUvnMsH=oW1cxmzT2wmwpxPFLjrP39TGbuhx@mail.gmail.com>
References: <AANLkTimNMcs_6-NMTSY+yZuDUSB2eC2R_NX35gq00f7E@mail.gmail.com>
	<20110112085110.GR11039@n2100.arm.linux.org.uk>
	<AANLkTim3BUvnMsH=oW1cxmzT2wmwpxPFLjrP39TGbuhx@mail.gmail.com>
Message-ID: <20110112105658.GA2365@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 05:04:43PM +0800, TAO HU wrote:
> Hi, Russell King
> 
> Thanks.
> 
> For "The result will be CPUs fighting over servicing such interrupts."
> What's the consequence? The performance downgrade?

It means you'll have the same interrupt trying to be serviced on two
CPUs at the same time.  One will succeed and service it.  The other
will waste time just finding out that there's nothing for it to do,
competing with resources and wasting time that it could otherwise have
spent executing userspace or whatever.

> Does it imply a design flaw in GIC or in ARM SMP?

No.  The hardware is doing what you're asking it to.  Some OSes may want
this behaviour so it would be wrong for the hardware to deny it.

There's quite a bit of history behind interrupt balancing across CPU
cores, and it's not a simple issue to get to grips with.

I believe the x86 kernel uses software to balance interrupts across the
cores using an algorithm in the kernel.  This tries to distribute the
interrupts between the cores.  When this was tried on ARM, although it
moved interrupts around the cores, it was no better than having all
interrupts routed to one core.

On x86 they now do away with their kernel algorithm, and instead run a
boot-time utility (irqbalance) which does a one-time distribution of
interrupts across the cores.  The idea is that it is more important to
keep an interrupt handler running on the same core than it is to
constantly switch it between the cores.

If a handler keeps switching between the cores, you have to migrate cache
lines between the cores, which adds to the cache coherency traffic, and
on x86 results in a reduction in performance.

So, with all that in mind, when I was sorting out the initial SMP merging,
I tried out various algorithms for automatic interrupt distribution, and
never got any of them to work satisfactorily.  In light of discussions with
x86 folk, particularly Arjan van de Ven, I decided not to merge any of them
and leave it as a matter for userspace policy to control how interrupts are
distributed to the cores - just like the majority of x86 platforms now do.

AFAIK, there's nothing stopping anyone running 'irqbalance' (the x86
utility) on ARM - it should just be accessing procfs files.  See
http://irqbalance.org/ for more information on the program, and on the
issues surrounding IRQ distribution in SMP systems.
