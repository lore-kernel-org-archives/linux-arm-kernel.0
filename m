From: slash.tmp@free.fr (Mason)
Date: Wed, 05 Aug 2015 10:40:01 +0200
Subject: IRQ setup on multicore systems (routing, balancing, etc)
In-Reply-To: <55C0C102.7050600@free.fr>
References: <55C0C102.7050600@free.fr>
Message-ID: <55C1CBE1.1040009@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2015 15:41, Mason wrote:

> I have a few very naive questions about interrupts.
> 
> How are interrupts set up on multicore systems?
> 
> If I write a device tree node for some peripheral, am I supposed
> to specify which core each interrupt should be routed to?
> 
> On my system, there is a custom interrupt controller, but the ARM
> chip also provides a Generic Interrupt Controller (GIC).
> 
> Am I supposed to use both, or can I use just the GIC?
> (I suspect the answer is very platform-dependent.)
> 
> I've seen a lot of articles discussing interrupt "management"
> on x86 (with APIC) but my search-foo is failing me for more
> generic Linux "Howto set up". Are there good references?
> 
> I suppose I should take a look at these?
> Documentation/devicetree/bindings/interrupt-controller/*
> Documentation/devicetree/bindings/arm/gic.txt
> 
> 
> For my own reference:
> 
> ARM Generic Interrupt Controller Architecture Specification v1.0 (IHI0048A)
> Cortex-A9 MPCore (Revision: r3p0) Technical Reference Manual

This thread seems relevant:

[RFC] ARM: Let GIC to route IRQs to any allowed CPUs
http://thread.gmane.org/gmane.linux.ports.arm.kernel/102251

Russell's answer particularly so:
http://article.gmane.org/gmane.linux.ports.arm.kernel/102289

On 2011-01-12, Russell King wrote:

> There's quite a bit of history behind interrupt balancing across CPU
> cores, and it's not a simple issue to get to grips with.
> 
> I believe the x86 kernel uses software to balance interrupts across the
> cores using an algorithm in the kernel.  This tries to distribute the
> interrupts between the cores.  When this was tried on ARM, although it
> moved interrupts around the cores, it was no better than having all
> interrupts routed to one core.
> 
> On x86 they now do away with their kernel algorithm, and instead run a
> boot-time utility (irqbalance) which does a one-time distribution of
> interrupts across the cores.  The idea is that it is more important to
> keep an interrupt handler running on the same core than it is to
> constantly switch it between the cores.
> 
> If a handler keeps switching between the cores, you have to migrate cache
> lines between the cores, which adds to the cache coherency traffic, and
> on x86 results in a reduction in performance.
> 
> So, with all that in mind, when I was sorting out the initial SMP merging,
> I tried out various algorithms for automatic interrupt distribution, and
> never got any of them to work satisfactorily.  In light of discussions with
> x86 folk, particularly Arjan van de Ven, I decided not to merge any of them
> and leave it as a matter for userspace policy to control how interrupts are
> distributed to the cores - just like the majority of x86 platforms now do.
> 
> AFAIK, there's nothing stopping anyone running 'irqbalance' (the x86
> utility) on ARM - it should just be accessing procfs files.  See
> http://irqbalance.org/ for more information on the program, and on the
> issues surrounding IRQ distribution in SMP systems.

Regards.
