From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 23 Oct 2012 20:22:04 +0200
Subject: [PATCH v2] ARM: EXYNOS: Add support for secondary CPU bring-up on
 Exynos4412
In-Reply-To: <01d101cdb115$965b0730$c3111590$%kim@samsung.com>
References: <1393767.3tjq8gL245@amdc1227>
 <01d101cdb115$965b0730$c3111590$%kim@samsung.com>
Message-ID: <2080548.MLAjJ6UEE5@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

On Tuesday 23 of October 2012 20:57:33 Kukjin Kim wrote:
> Tomasz Figa wrote:
> > Exynos4412 uses different information register for each core. This
> > patch adjusts the bring-up code to take that into account.
> > 
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > 
> >  arch/arm/mach-exynos/platsmp.c | 27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-
> > exynos/platsmp.c
> > index 36c3984..816a27d 100644
> > --- a/arch/arm/mach-exynos/platsmp.c
> > +++ b/arch/arm/mach-exynos/platsmp.c
> > @@ -34,8 +34,19 @@
> > 
> >  extern void exynos4_secondary_startup(void);
> > 
> > -#define CPU1_BOOT_REG		(samsung_rev() == EXYNOS4210_REV_1_1
> 
> ? \
> 
> > -				S5P_INFORM5 : S5P_VA_SYSRAM)
> > +static inline void __iomem *cpu_boot_reg_base(void)
> > +{
> > +	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
> > +		return S5P_INFORM5;
> > +	return S5P_VA_SYSRAM;
> > +}
> > +
> > +static inline void __iomem *cpu_boot_reg(int cpu)
> > +{
> > +	if (soc_is_exynos4412())
> > +		return cpu_boot_reg_base() + 4*cpu;
> > +	return cpu_boot_reg_base();
> > +}
> > 
> >  /*
> >  
> >   * control for which core is the next to come out of the secondary
> > 
> > @@ -89,6 +100,7 @@ void __cpuinit platform_secondary_init(unsigned int
> 
> cpu)
> 
> >  int __cpuinit boot_secondary(unsigned int cpu, struct task_struct
> >  *idle) {
> >  
> >  	unsigned long timeout;
> > 
> > +	unsigned long phys_cpu = cpu_logical_map(cpu);
> > 
> >  	/*
> >  	
> >  	 * Set synchronisation state between this boot processor
> > 
> > @@ -104,7 +116,7 @@ int __cpuinit boot_secondary(unsigned int cpu,
> > struct task_struct *idle)
> > 
> >  	 * Note that "pen_release" is the hardware CPU ID, whereas
> >  	 * "cpu" is Linux's internal ID.
> >  	 */
> > 
> > -	write_pen_release(cpu_logical_map(cpu));
> > +	write_pen_release(phys_cpu);
> > 
> >  	if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
> >  	
> >  		__raw_writel(S5P_CORE_LOCAL_PWR_EN,
> > 
> > @@ -138,7 +150,7 @@ int __cpuinit boot_secondary(unsigned int cpu,
> > struct task_struct *idle)
> > 
> >  		smp_rmb();
> >  		
> >  		__raw_writel(virt_to_phys(exynos4_secondary_startup),
> > 
> > -			CPU1_BOOT_REG);
> > +
> 
> cpu_boot_reg(phys_cpu));
> 
> >  		gic_raise_softirq(cpumask_of(cpu), 1);
> >  		
> >  		if (pen_release == -1)
> > 
> > @@ -186,6 +198,8 @@ void __init smp_init_cpus(void)
> > 
> >  void __init platform_smp_prepare_cpus(unsigned int max_cpus)
> >  {
> > 
> > +	int i;
> > +
> > 
> >  	if (!soc_is_exynos5250())
> >  	
> >  		scu_enable(scu_base_addr());
> > 
> > @@ -195,6 +209,7 @@ void __init platform_smp_prepare_cpus(unsigned int
> > max_cpus)
> > 
> >  	 * until it receives a soft interrupt, and then the
> >  	 * secondary CPU branches to this address.
> >  	 */
> > 
> > -	__raw_writel(virt_to_phys(exynos4_secondary_startup),
> > -			CPU1_BOOT_REG);
> > +	for (i = 1; i < max_cpus; ++i)
> > +		__raw_writel(virt_to_phys(exynos4_secondary_startup),
> > +					cpu_boot_reg(cpu_logical_map(i)));
> > 
> >  }
> > 
> > --
> > 1.7.12
> 
> Looks ok to me, applied.
> 
> Thanks.

This is an old version of the patch. A new one was posted as a part of the 
series adding support for firmware ops, with corrections for received 
comments.

Best regards,
Tomasz Figa
