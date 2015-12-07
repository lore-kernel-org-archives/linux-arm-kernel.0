From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Dec 2015 17:38:35 +0000
Subject: [RFC PATCH] irq: allow percpu_devid interrupts to be requested
 with target mask
In-Reply-To: <alpine.DEB.2.11.1511271622170.3572@nanos>
References: <1448624376-15570-1-git-send-email-will.deacon@arm.com>
 <alpine.DEB.2.11.1511271622170.3572@nanos>
Message-ID: <20151207173835.GF26191@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 08:15:52PM +0100, Thomas Gleixner wrote:
> Will,

Hi Thomas,

Thanks for the comprehensive review. Comments inline.

> On Fri, 27 Nov 2015, Will Deacon wrote:
> 
> > On multi-cluster platforms, a per-cpu interrupt may actually be wired on
> > a per-cluster basis, meaning that different devices may have the same
> > interrupt number depending on the CPU.
> > 
> > This is problematic for drivers using the percpu_device interface as
> > there is currently no way to request an interrupt of this type for a
> > subset of CPUs. Furthermore, interrupt sharing is not permitted.
> > 
> > This patch adds the ability to provide a CPU mask to the percpu
> > interrupt request/free functions such that the interrupt is only enabled
> > on those CPUs set in the mask. Each irqaction has a copy of the mask to
> > allow the percpu_devid flow handler to dispatch to the correct driver
> > when an interrupt occurs. Whilst interrupt sharing is still forbidden
> > in the usual sense, multiple actions are permitted providing that their
> > target CPU masks do not intersect.
> 
> I'm not too excited about this approach. That looks pretty much bolted
> on the existing percpu_irq machinery and you add the overhead of the
> action loop plus the mask check to each per cpu interrupt. Not really
> efficient.

Sure -- I largely just lifted the IRQF_SHARED code to get discussion
started.

> I assume that 
> 
> > meaning that different devices may have the same interrupt number
> > depending on the CPU.
> 
> means: They have the same HW interrupt number and therefor the same
> linux irq number due to the way percpu_irq works today.

Right.

> So the scenario is:
> 
> |----------------------|   |--------------------|
> |Cluster 0             |   |Cluster1            |
> |----------------------|   |--------------------|
> |PerCPU irqs 	       |   |PerCPU irqs         |
> |----------------------|   |--------------------|
> |PerClusterPerCPU irqs |   |PerCluster irqs     |
> |----------------------|   |--------------------|
> |Global shared irqs    |   |Global shared irqs  |
> |----------------------|   |--------------------|
> 
> 1) PerCPU irqs:
> 
>    Same HWirq number on all CPUs. Interrupt is raised locally on the
>    CPU from a CPU local facility (local timer, IPI receive, perf ...)
> 
>    Covered by the existing percpu interface.
> 
> 2) Shared irqs:
> 
>    Unique HWirq number for a single device interrupt. Used by globally
>    available devices. irq can be routed to any CPU.
> 
> 3) PerCluster irqs:
> 
>    Similar to PerCPU irqs, but the same HWirq number is only shared on
>    a per cluster basis.
> 
>    So we might end up with hwirqX on cluster 0 wired to the local
>    timer while it is wired to perf on cluster 1 and vice versa.
> 
>    Now you want to use the same Linux irq number for the local timer
>    or whatever on all CPUs independent of the cluster, right?
> 
>    So the per cpu timer interrupt is requested once as a per cpu
>    interrupt with the linux irq number of cluster 0. But when you call
>    enable_per_cpu_irq() on a cpu from cluster 1 you want to use the
>    same linux irq number. But with the current scheme this ends up at
>    the wrong hw irq.
> 
>    That's why you introduced that cpumask stuff.

There's a slight niggle here, which I didn't communicate in the commit
log (because my use-case is indeed per-cluster). Interrupts can also
be wired on a per-cpu basis, but where you have multiple device/driver
instances and therefore can't use a single call to request_percpu_irq.
An example of this is Freescale's watchdog:

  http://www.spinics.net/lists/arm-kernel/msg464000.html

which is why I added Bhupesh to Cc. They seem to have 1 watchdog per
core, but signalling the same PPI number...

> We can do better than that. Hierarchical irq domains to the rescue.

... so would we want a per-cpu domain instead?

> |------------|
> | GIC domain |<--- Global PerCPU irqs
> |	     |
> |	     |<--- Global shared irqs
> |	     |
> |	     |<--- [ITS domain] <--- [MSI domain]
> |	     |
> |	     |<--- [PerCluster PerCPU domain]
> |------------|
>  
> Now that PerCluster PerCPU domain does the following:
> 
> When the irq is allocated and mapped it requests N consective Linux
> irq numbers, where N is the number of clusters. The return value is
> the first irq number, i.e. the one which maps to cluster 0.
> 
> The allocater/mapping sets up irq + 0 for cluster 0, irq + 1 for
> cluster 1,.... Each irq has a different irq to hwirq mapping.
> 
> The domain also needs a cluster aware mapping mechanism. See further
> below.
> 
> All handling functions setup/request/free/remove_percpu_irq()
> now do:
> 
>     struct irq_desc *desc = irq_to_desc(irq);
>     struct irqdomain *domain = irq_desc_get_domain(desc);
>     int i;
> 
>     __setup_irq(desc, handler);
> 
>     if (!domain->is_clustered)
>        return;
> 
>     for (i = 1; i < domain->nr_clusters: i++) {
>     	desc = irq_to_desc(irq + i);
> 	desc->handler = handler;
>     }
> 
>     This might also require some special handling in your domains
>     activate() callback, which is invoked from __setup_irq() but that's
>     a detail.
> 
> enable/disable_percpu_irq() does:
> 
>     struct irq_desc *desc = irq_to_desc(irq);
>     struct irqdomain *domain = irq_desc_get_domain(desc);
> 
>     if (domain && domain->nr_clusters > 1)
> 	  desc = irq_to_desc(irq + domain->get_cluster(smp_processor_id());
> 
>     enable/disable(desc);
> 
> So lets look at an example
> 
> setup_local_timer()
>   irq = map_irq();
>       	 Allocates irq10 and irq11, returns irq 10
> 	 Maps irq10 to hwirq 20 and irq11 to hwirq 21
>   ...
> 
>   request_percpu_irq(10, timer_handler)
>   	irq10->handler = timer_handler;
>   	irq11->handler = timer_handler;
> 
>   enable_percpu_irq(10) <- On cluster 0
>   	enable_irq(irq10) -> hwirq20
> 
>   enable_percpu_irq(10) <- On cluster 1
>   	enable_irq(irq11) -> hwirq21
> 
> setup_perf()
>   irq = map_irq();
>       	 Allocates irq12 and irq13, returns irq 12
> 	 Maps irq12 to hwirq 21 and irq13 to hwirq 20
>   ...
> 
>   request_percpu_irq(12, perf_handler)
>   	irq12->handler = perf_handler;
>   	irq12->handler = perf_handler;
> 
>   enable_percpu_irq(12) <- On cluster 0
>   	enable_irq(irq12) -> hwirq21
> 
>   enable_percpu_irq(12) <- On cluster 1
>   	enable_irq(irq13) -> hwirq20
> 
> We can do that, because all operations have to be invoked on the
> target cpu.

Ok, but what about existing callers? I think we either need a new
function or flag to indicate that the irq is per-cluster, otherwise we
run the risk of breaking things where the hwirq is actually the same.

At the moment, the ARM perf binding in device-tree has an optional
"interrupt-affinity" field that describes the set of CPUs which use
the PPI number described elsewhere in the node. Perhaps we could parse
this when we create the new domain and selectively map irqs there.

Dunno -- needs prototyping!

> So far so good. Now we have the interrupt entry code which wants to
> translate hwirqX to a linux irq number. So we need some modification
> to irq_find_mapping() as well. We could do a domain specific
> find_mapping() callback, or add something to the core code.
> 
> 	if (domain->is_clustered_mapped) {
> 	      map = domain->map[domain->get_cluster(cpuid)];
> 	      return map[hwirq];
> 	}			  
> 
> works for a linear domain. A domain specific find_mapping() callback
> might be better suited, but thats a detail.

It's a little scary to tie the device-tree topology description (which
is usually used for scheduling and power management afaiu) directly
to the IRQ routing, but then if this does end up being per-cpu, there's
no real issue.

> That might be nice counterpart to the work Qais is doing:
> 
>    http://marc.info/?l=linux-kernel&m=144845325611158&w=2
> 
> The way MIPS sets up IPIs and per cpu irqs is not clustered as in your
> case. It needs one hwirq per CPU, but we still want to operate from a
> single base irq. It's a bit different, as it does not need that extra
> reverse mapping function because he operates on a globally unique
> hwirq number, but still needs to setup N irq descriptors/handlers per
> PERCPU irq as in your cluster scenario. So we might be able to share
> that part and just handle the IPI allocation/send mechanism in Qais
> new code.

Thanks, I'll take a look.

Will
