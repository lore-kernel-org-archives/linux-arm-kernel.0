From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jul 2011 16:37:59 +0100
Subject: [PATCH v8 14/14] ARM: gic: add gic_ppi_map_on_cpu()
In-Reply-To: <20110710161038.46770f08@taxman.wild-wind.fr.eu.org>
References: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
	<1309855755-6261-15-git-send-email-marc.zyngier@arm.com>
	<20110708195708.GR4812@n2100.arm.linux.org.uk>
	<20110710161038.46770f08@taxman.wild-wind.fr.eu.org>
Message-ID: <20110710153759.GI4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 04:10:38PM +0100, Marc Zyngier wrote:
> On Fri, 8 Jul 2011 20:57:08 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Tue, Jul 05, 2011 at 09:49:15AM +0100, Marc Zyngier wrote:
> > > It is sometimes usefull to compute the mapping of a PPI on a CPU
> > > that is not the one handling the interrupt (in the probe function
> > > of a driver, for example).
> > 
> > This is unsafe.  Firstly, smp_processor_id() in preemptible contexts
> > is not valid as you can be migrated to another CPU at any moment.
> 
> Point taken. I think I can solve this by having a per-cpu variable
> instead of hijacking the gic_chip_data structure.

I think you miss the point.

	global_irq = gic_ppi_map(ppi_irq);

is broken, no matter what kind of implementation you have behind it.

To illustrate it, lets define gic_ppi_map() as the following:

	(ppi_irq * NR_CPUS + cpu_nr)

And you have this code:

	irq = gic_ppi_map(2);
	ret = request_irq(irq, ...);

Now, lets say that when you call this, you're running on CPU1, you
have 4 CPUs and you want PPI 2.  global_irq will be 2 * 4 + 1 = 9.

You intend to pass this to request_irq() to claim the PPI 2 for the
current CPU.  However, you're preempted by another thread, so you
stop executing on CPU1.

CPU3 is about to idle, and so you're migrated to CPU3 which now starts
executing your code.  You continue into request_irq(), still with
IRQ9.  You request the interrupt, and the unmask function is called.
The GIC now unmasks PPI 2 on CPU 3 - but this is IRQ11.

However, your IRQ handler is registered in IRQ9's slot but IRQ11 is
enabled instead.

Now, lets say you decide to disable preemption over this code section:

	preempt_disable();
	irq = gic_ppi_map(2);
	ret = request_irq(irq, ...);
	preempt_enable();

This is _still_ unsafe.  Instead of the explicit preemption, consider
what happens if the attempt to allocate memory inside request_irq()
blocks:

        action = kzalloc(sizeof(struct irqaction), GFP_KERNEL);

There is _still_ no guarantee that you will continue execution on the
same CPU as the one you were originally executing on.

> > Secondly, if you have a driver probe function, and you want to
> > register a PPI interrupt for a different CPU, while you can call the
> > request function, the resulting ->unmask will be called on the
> > calling CPU (assuming preempt is disabled and we don't schedule).
> > You might get lucky and it may be called on your intended CPU...
> 
> I think you're going way beyond than the intended use of this function.
> It is only there to be able to compute the PPI->IRQ mapping, *not* to
> register the IRQ, which of course only make sense on the target CPU.

No, my point is that this is not a useful function, period.  It should
not even exist, because it is *dangerous* for anyone to use it.  See
the examples above.

However, my point is more than that: the whole idea behind this patch
series is unsafe: it is _unsafe_ to assume that calling request_irq()
on any particular CPU will result in execution being bound solely to
that IRQ.

The only way to ensure that this code works as you've intended is:

1. save the threads affinity
2. set a new affinity for a single CPU for the thread
3. force execution to switch to that CPU
4. translate the IRQ and request it
5. restore the threads affinity

And to ensure that drivers do that safely, that would _have_ to be a
separate function which takes care of all that.  The code would look
something like this:

        cpumask_t cpus_allowed = current->cpus_allowed;
        set_cpus_allowed(current, cpumask_of_cpu(cpu));
        BUG_ON(cpu != smp_processor_id());
	irq = gic_ppi_map(ppi);
	ret = request_irq(irq, ...);
	set_cpus_allowed(current, cpus_allowed);

(But not this: this depends on CPUMASK_OFFSTACK not being set.)

In any case, this is _not_ what we want drivers to get involved with -
we'll get different implementations of this which are likely to be
buggy.  We need an interface which doesn't have this complexity.  So
we need something like this:

int request_ppi_irq(int ppi, irq_handler_t handler, void *dev);

which contains all this complexity.  At that point, we've _already_
moved away from the standard genirq interfaces to a GIC specific PPI
request interface.

So, all in all, I see _zero_ reason to use genirq for this ARM specific
oddity.
