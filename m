From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 8 Jan 2016 20:45:23 +0800
Subject: Armada XP (MV78460): BUG in netdevice.h with maxcpus=2
In-Reply-To: <20160108105721.GG19062@n2100.arm.linux.org.uk>
References: <568F6A47.6010905@gmail.com>	<20160108182537.0a68630c@xhacker>
 <20160108105721.GG19062@n2100.arm.linux.org.uk>
Message-ID: <20160108204523.43b4d473@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

On Fri, 8 Jan 2016 10:57:21 +0000 Russell King - ARM Linux wrote:

> On Fri, Jan 08, 2016 at 06:25:37PM +0800, Jisheng Zhang wrote:
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> > index ed622fa..e1242f4 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -2446,7 +2446,7 @@ static void mvneta_start_dev(struct mvneta_port *pp)
> >  	mvneta_port_enable(pp);
> >  
> >  	/* Enable polling on the port */
> > -	for_each_present_cpu(cpu) {
> > +	for_each_online_cpu(cpu) {
> >  		struct mvneta_pcpu_port *port = per_cpu_ptr(pp->ports, cpu);
> >  
> >  		napi_enable(&port->napi);
> > @@ -2472,7 +2472,7 @@ static void mvneta_stop_dev(struct mvneta_port *pp)
> >  
> >  	phy_stop(pp->phy_dev);
> >  
> > -	for_each_present_cpu(cpu) {
> > +	for_each_online_cpu(cpu) {
> >  		struct mvneta_pcpu_port *port = per_cpu_ptr(pp->ports, cpu);
> >  
> >  		napi_disable(&port->napi);
> > @@ -2907,7 +2907,7 @@ static int mvneta_stop(struct net_device *dev)
> >  	mvneta_stop_dev(pp);
> >  	mvneta_mdio_remove(pp);
> >  	unregister_cpu_notifier(&pp->cpu_notifier);
> > -	for_each_present_cpu(cpu)
> > +	for_each_online_cpu(cpu)
> >  		smp_call_function_single(cpu, mvneta_percpu_disable, pp, true);
> >  	free_percpu_irq(dev->irq, pp->ports);
> >  	mvneta_cleanup_rxqs(pp);  
> 
> I'm not convinced that this isn't racy - what happens if a CPU is
> brought online between unregister_cpu_notifier(&pp->cpu_notifier)
> and the following loop?  We'll end up calling mvneta_percpu_disable()
> for the new CPU - is that harmless?
> 
> Similarly, what if the online CPUs change between mvneta_stop_dev()
> and mvneta_stop(), and also what about hotplug CPU changes during
> the startup path?
> 
> Secondly, is there a reason for:
> 
> 	for_each_online_cpu(cpu)
> 		smp_call_function_single(cpu, ...)
> 
> as opposed to:
> 
> 	smp_call_function(mvneta_percpu_disable, pp, true);
> 

Yep, thanks for pointing out the race. Before sending out the patch, I prepared
another *wrong*(IMHO) patch to patch smp_prepare_cpus() in arch/arm/kernel/smp.c.

Here is the background:
I can reproduce this issue on arm but failed to reproduce it on arm64. The key
is what's present cpu.

let's assume a quad core system, boot with maxcpus=2, after booting.

on arm64, present cpus is cpu0, cpu1

on arm, present cpus is cpu0, cpu1, cpu2 and cpu3.

the arm core code requires every platform to update the present map in
platforms' smp_prepare_cpus(), but only two or three platforms do so.

Then get back to mvneta issue, during startup, mvneta_start_dev() calls
napi_enable() for each present cpu's port. If userspace ask for online
cpu2, mvneta_percpu_notifier() will call napi_enable() for cpu2 again,
so BUG_ON() is triggered.

I have two solutions:

1. as the above patch did, then prevent the race as pointed out by
get_online_cpus().

2. make arm platforms smp_prepare_cpus to update the present map or even
patch arm core smp_prepare_cpus().

What's the better solution? Could you please guide me?

Thanks in advance,
Jisheng
