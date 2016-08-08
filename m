From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 8 Aug 2016 11:50:26 +0100
Subject: [PATCH 1/1] irqchip: irq-gic: forward SGI to itself for
 cortex-a7 single core
In-Reply-To: <1470642594-30455-1-git-send-email-peter.chen@nxp.com>
References: <1470642594-30455-1-git-send-email-peter.chen@nxp.com>
Message-ID: <20160808105026.GA12649@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2016 at 03:49:54PM +0800, Peter Chen wrote:
> According to Cortex-A7 MPCore TRM, ch8.3.1, Distributor register summary,
> GICD_ITARGETSRn:
> 
> 	The register that contains the SGI and PPI interrupts is
>        	read-only and the value is implementation defined. For
>        	Cortex-A7 configurations with only one processor, these
>        	registers are RAZ/WI.
> 
> So, the GICD_ITARGETSR[0..7] is read-only, and the value is 0 for
> cortex-a7 single core platform if the SoC is cortex-a7 mpcore version.
> So the cupmask from gic_get_cpumask is 0.
> 
> At ARM Generic Interrupt Controller Architecture version 2.0,
> ch4.3.15 Software Generated Interrupt Register, GICD_SGIR,
> The distributor will process the requested SGI according to
> register TargetListFilter and CPUTargetList. At current gic code,
> it takes TargetListFilter as 0b00, and forward the interrupt to
> cpumask (variable map at gic_raise_softirq) getting from gic_get_cpumask.
> but cpumask is 0 according to above explanation for cortex-a7 single core
> platform, so, both TargetListFilter and CPUTargetList are 0, and the
> distributor does not forward the interrupt to any CPU interface according
> to gic documentation, then the SGI can't be occurred.
> 
> We have found this problem at nxp imx6ul platform, which is a cortex-a7
> single core platform, the irq work (triggered by SGI at ARM) can't be
> occurred which is needed for cpufreq, then the system has failed to boot
> and reboot [1].
> 
> In this commit, we set TargetListFilter as 0b10 to fix this problem, it
> forwards the interrupt only to CPU0 and only cortex-a7 single core platform
> uses this setting currently.

This is a generic property of the GIC architecture in UP systems, and is
not specific to Cortex-A7. So checking for Cortex-A7 specifically
doesn't solve the problem.

As Russell pointed out in [2], this is a generic infrastructure problem,
and there are other systems where HW might not have a self-IPI. I note
that core code already handles that in some cases, e.g. in
generic_exec_single where we just disable interrupts and run the work
locally rather than sending a self-IPI.

How/where exactly is this self-IPI raised? Can we follow the example of
generic_exec_single there?

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-May/430545.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-May/430849.html

> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Jason Liu <jason.hui.liu@nxp.com>
> Cc: Anson Huang <anson.huang@nxp.com>
> Cc: Frank Li <frank.li@nxp.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Ping Bai <ping.bai@nxp.com>
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  drivers/irqchip/irq-gic.c | 39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index c2cab57..625ae6d 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -764,6 +764,23 @@ static int gic_pm_init(struct gic_chip_data *gic)
>  #endif
>  
>  #ifdef CONFIG_SMP
> +static void gic_raise_softirq_itself(const struct cpumask *mask,
> +				     unsigned int irq)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&irq_controller_lock, flags);
> +
> +	/*
> +	 * Forward the interrupt only to the CPU interface of the processor
> +	 * that requested the interrupt.
> +	 */
> +	writel_relaxed(0x2000000 | irq, gic_data_dist_base(&gic_data[0])
> +					+ GIC_DIST_SOFTINT);
> +
> +	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
> +}
> +
>  static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  {
>  	int cpu;
> @@ -1162,9 +1179,6 @@ static int __init __gic_init_bases(struct gic_chip_data *gic,
>  		 */
>  		for (i = 0; i < NR_GIC_CPU_IF; i++)
>  			gic_cpu_map[i] = 0xff;
> -#ifdef CONFIG_SMP
> -		set_smp_cross_call(gic_raise_softirq);
> -#endif
>  		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
>  					  "AP_IRQ_GIC_STARTING",
>  					  gic_starting_cpu, NULL);
> @@ -1336,6 +1350,16 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
>  	gic_set_kvm_info(&gic_v2_kvm_info);
>  }
>  
> +static bool __init gic_is_a7_singlecore(struct gic_chip_data *gic,
> +					struct device_node *node)
> +{
> +	if (!of_device_is_compatible(node, "arm,cortex-a7-gic"))
> +		return false;
> +
> +	return !(readl_relaxed(gic_data_dist_base(gic) + GIC_DIST_CTR) & 0xe0);
> +
> +}
> +
>  int __init
>  gic_of_init(struct device_node *node, struct device_node *parent)
>  {
> @@ -1367,6 +1391,15 @@ gic_of_init(struct device_node *node, struct device_node *parent)
>  		return ret;
>  	}
>  
> +	if (gic == &gic_data[0]) {
> +#ifdef CONFIG_SMP
> +		if (gic_is_a7_singlecore(gic, node))
> +			set_smp_cross_call(gic_raise_softirq_itself);
> +		else
> +			set_smp_cross_call(gic_raise_softirq);
> +#endif
> +	}
> +
>  	if (!gic_cnt) {
>  		gic_init_physaddr(node);
>  		gic_of_setup_kvm_info(node);
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
