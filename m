From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 11 Oct 2012 17:15:18 +0800
Subject: [PATCH 3/7] ARM: tegra30: cpuidle: add LP2 driver for
 secondary CPUs
In-Reply-To: <5074A74A.8010803@wwwdotorg.org>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-4-git-send-email-josephl@nvidia.com>
 <5074A74A.8010803@wwwdotorg.org>
Message-ID: <1349946918.19413.130.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-10-10 at 06:38 +0800, Stephen Warren wrote:
> On 10/08/2012 04:26 AM, Joseph Lo wrote:
> > This supports power-gated (LP2) idle on secondary CPUs for Tegra30.
> > The secondary CPUs can go into LP2 state independently. When CPU goes
> > into LP2 state, it saves it's state and puts itself to flow controlled
> > WFI state. After that, it will been power gated.
> 
> > diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
> 
> >  static struct cpuidle_driver tegra_idle_driver = {
> >  	.name = "tegra_idle",
> >  	.owner = THIS_MODULE,
> >  	.en_core_tk_irqen = 1,
> > -	.state_count = 1,
> > +	.state_count = 2,
> 
> Doesn't that assignment need to be ifdef'd just like the array entry
> setup below:
> 
> >  	.states = {
> >  		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
> > +#ifdef CONFIG_PM_SLEEP
> > +		[1] = {
> > +			.enter			= tegra30_idle_lp2,
> > +			.exit_latency		= 2000,
> > +			.target_residency	= 2200,
> > +			.power_usage		= 0,
> > +			.flags			= CPUIDLE_FLAG_TIME_VALID,
> > +			.name			= "LP2",
> > +			.desc			= "CPU power-gate",
> > +		},
> > +#endif
> >  	},
> >  };
> 
> > @@ -41,6 +114,10 @@ int __init tegra30_cpuidle_init(void)
> >  	struct cpuidle_device *dev;
> >  	struct cpuidle_driver *drv = &tegra_idle_driver;
> >  
> > +#ifndef CONFIG_PM_SLEEP
> > +	drv->state_count = 1;	/* support clockgating only */
> > +#endif
> 
> Oh, I see it's done here. Just fixing the static initialization seems a
> lot simpler?
> 
OK. Will do.

> > diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
> 
> > +void __cpuinit tegra_clear_cpu_in_lp2(int cpu)
> > +{
> > +	spin_lock(&tegra_lp2_lock);
> > +	BUG_ON(!cpumask_test_cpu(cpu, &tegra_in_lp2));
> > +	cpumask_clear_cpu(cpu, &tegra_in_lp2);
> > +
> > +	/*
> > +	 * Update the IRAM copy used by the reset handler. The IRAM copy
> > +	 * can't use used directly by cpumask_clear_cpu() because it uses
> > +	 * LDREX/STREX which requires the addressed location to be inner
> > +	 * cacheable and sharable which IRAM isn't.
> > +	 */
> > +	writel(tegra_in_lp2.bits[0], tegra_cpu_lp2_mask);
> > +	dsb();
> 
> Why not /just/ store the data in IRAM, and read/write directly to it,
> rather than maintaining an SDRAM-based copy of it?
> 
> Then, wouldn't the body of this function be simply:
> 
> spin_lock();
> BUG_ON(!(tegra_cpu_lp2_mask & BIT(cpu)));
> tegra_cpu_lp2_mask |= BIT(cpu);
> spin_unlock();
> 

It may not simple like this. To maintain it identical to a cpumask. It
may look likes below. Because I need to compare it with cpu_online_mask.

void __cpuinit tegra_clear_cpu_in_lp2(int phy_cpu_id)
{
	cpumask_t *iram_cpu_lp2_mask = tegra_cpu_lp2_mask;
	unsigned long *addr;

	spin_lock(&tegra_lp2_lock);

	addr = cpumask_bits(iram_cpu_lp2_mask);
	BUG_ON(!(1UL &
		(addr[BIT_WORD(phy_cpu_id)]
		 >> (phy_cpu_id & (BITS_PER_LONG-1)))));

	*(addr + BIT_WORD(phy_cpu_id)) &= ~BIT_MASK(phy_cpu_id);

	spin_unlock(&tegra_lp2_lock);
}

> > +bool __cpuinit tegra_set_cpu_in_lp2(int cpu)
> 
> Similar comment here.

bool __cpuinit tegra_set_cpu_in_lp2(int phy_cpu_id)
{ 
	bool last_cpu = false;
	cpumask_t *iram_cpu_lp2_mask = tegra_cpu_lp2_mask;
	unsigned long *addr;

	spin_lock(&tegra_lp2_lock);

	addr = cpumask_bits(iram_cpu_lp2_mask);
	BUG_ON((1UL &
		(addr[BIT_WORD(phy_cpu_id)]
		 >> (phy_cpu_id & (BITS_PER_LONG-1)))));

	*(addr + BIT_WORD(phy_cpu_id)) |= BIT_MASK(phy_cpu_id);

	if ((phy_cpu_id == 0) && 
	     cpumask_equal(iram_cpu_lp2_mask, cpu_online_mask))
		last_cpu = true;

	spin_unlock(&tegra_lp2_lock);
	return last_cpu;
}

So I think the original version should more easy to understand. How do
you think?

Thanks,
Joseph
