From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jan 2016 10:57:21 +0000
Subject: Armada XP (MV78460): BUG in netdevice.h with maxcpus=2
In-Reply-To: <20160108182537.0a68630c@xhacker>
References: <568F6A47.6010905@gmail.com>
 <20160108182537.0a68630c@xhacker>
Message-ID: <20160108105721.GG19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 06:25:37PM +0800, Jisheng Zhang wrote:
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index ed622fa..e1242f4 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -2446,7 +2446,7 @@ static void mvneta_start_dev(struct mvneta_port *pp)
>  	mvneta_port_enable(pp);
>  
>  	/* Enable polling on the port */
> -	for_each_present_cpu(cpu) {
> +	for_each_online_cpu(cpu) {
>  		struct mvneta_pcpu_port *port = per_cpu_ptr(pp->ports, cpu);
>  
>  		napi_enable(&port->napi);
> @@ -2472,7 +2472,7 @@ static void mvneta_stop_dev(struct mvneta_port *pp)
>  
>  	phy_stop(pp->phy_dev);
>  
> -	for_each_present_cpu(cpu) {
> +	for_each_online_cpu(cpu) {
>  		struct mvneta_pcpu_port *port = per_cpu_ptr(pp->ports, cpu);
>  
>  		napi_disable(&port->napi);
> @@ -2907,7 +2907,7 @@ static int mvneta_stop(struct net_device *dev)
>  	mvneta_stop_dev(pp);
>  	mvneta_mdio_remove(pp);
>  	unregister_cpu_notifier(&pp->cpu_notifier);
> -	for_each_present_cpu(cpu)
> +	for_each_online_cpu(cpu)
>  		smp_call_function_single(cpu, mvneta_percpu_disable, pp, true);
>  	free_percpu_irq(dev->irq, pp->ports);
>  	mvneta_cleanup_rxqs(pp);

I'm not convinced that this isn't racy - what happens if a CPU is
brought online between unregister_cpu_notifier(&pp->cpu_notifier)
and the following loop?  We'll end up calling mvneta_percpu_disable()
for the new CPU - is that harmless?

Similarly, what if the online CPUs change between mvneta_stop_dev()
and mvneta_stop(), and also what about hotplug CPU changes during
the startup path?

Secondly, is there a reason for:

	for_each_online_cpu(cpu)
		smp_call_function_single(cpu, ...)

as opposed to:

	smp_call_function(mvneta_percpu_disable, pp, true);

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
