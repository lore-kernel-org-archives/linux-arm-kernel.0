From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 7 Dec 2015 19:28:04 +0100 (CET)
Subject: [RFC PATCH] irq: allow percpu_devid interrupts to be requested
 with target mask
In-Reply-To: <20151207173835.GF26191@arm.com>
References: <1448624376-15570-1-git-send-email-will.deacon@arm.com>
 <alpine.DEB.2.11.1511271622170.3572@nanos> <20151207173835.GF26191@arm.com>
Message-ID: <alpine.DEB.2.11.1512071915060.3595@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Mon, 7 Dec 2015, Will Deacon wrote:
> On Fri, Nov 27, 2015 at 08:15:52PM +0100, Thomas Gleixner wrote:
> >    Now you want to use the same Linux irq number for the local timer
> >    or whatever on all CPUs independent of the cluster, right?
> > 
> >    So the per cpu timer interrupt is requested once as a per cpu
> >    interrupt with the linux irq number of cluster 0. But when you call
> >    enable_per_cpu_irq() on a cpu from cluster 1 you want to use the
> >    same linux irq number. But with the current scheme this ends up at
> >    the wrong hw irq.
> > 
> >    That's why you introduced that cpumask stuff.
> 
> There's a slight niggle here, which I didn't communicate in the commit
> log (because my use-case is indeed per-cluster). Interrupts can also
> be wired on a per-cpu basis, but where you have multiple device/driver
> instances and therefore can't use a single call to request_percpu_irq.
> An example of this is Freescale's watchdog:
> 
>   http://www.spinics.net/lists/arm-kernel/msg464000.html
> 
> which is why I added Bhupesh to Cc. They seem to have 1 watchdog per
> core, but signalling the same PPI number...

You can create both a PerCluster and a PerCPU domain.

But in that particular case it's the same as the local timer which
signals the same PPI on all CPUs, right? So the existing percpu irq
stuff should just work for that watchdog thingy.

> >   enable_percpu_irq(12) <- On cluster 1
> >   	enable_irq(irq13) -> hwirq20
> > 
> > We can do that, because all operations have to be invoked on the
> > target cpu.
> 
> Ok, but what about existing callers? I think we either need a new
> function or flag to indicate that the irq is per-cluster, otherwise we
> run the risk of breaking things where the hwirq is actually the same.

That's what I wrote a few lines up:

> > enable/disable_percpu_irq() does:
> > 
> >     struct irq_desc *desc = irq_to_desc(irq);
> >     struct irqdomain *domain = irq_desc_get_domain(desc);
> > 
> >     if (domain && domain->nr_clusters > 1)
> >         desc = irq_to_desc(irq + domain->get_cluster(smp_processor_id());
> > 
> >     enable/disable(desc);


> At the moment, the ARM perf binding in device-tree has an optional
> "interrupt-affinity" field that describes the set of CPUs which use
> the PPI number described elsewhere in the node. Perhaps we could parse
> this when we create the new domain and selectively map irqs there.
> 
> Dunno -- needs prototyping!

My device tree foo is close to zero, so I let the DT wizards come up
with a solution. But you need some decription of this in the DT
anyway, right?

> > So far so good. Now we have the interrupt entry code which wants to
> > translate hwirqX to a linux irq number. So we need some modification
> > to irq_find_mapping() as well. We could do a domain specific
> > find_mapping() callback, or add something to the core code.
> > 
> > 	if (domain->is_clustered_mapped) {
> > 	      map = domain->map[domain->get_cluster(cpuid)];
> > 	      return map[hwirq];
> > 	}			  
> > 
> > works for a linear domain. A domain specific find_mapping() callback
> > might be better suited, but thats a detail.
> 
> It's a little scary to tie the device-tree topology description (which
> is usually used for scheduling and power management afaiu) directly
> to the IRQ routing, but then if this does end up being per-cpu, there's
> no real issue.

Well, if your hardware is wired in scary ways, i.e. PPIs have a
different meaning on different clusters/cpus, then you need some
description in DT anyway. Translating that into a mapping is pretty
much straight forward I guess.
 
Thanks,

	tglx
