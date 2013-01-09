From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 9 Jan 2013 15:17:00 +0000
Subject: [v2 3/9] ARM: tegra: # of CPU cores detection w/ & w/o
 HAVE_ARM_SCU
In-Reply-To: <20130109.134641.1582472136842052082.hdoyu@nvidia.com>
References: <20130108.165342.1996373920678167735.hdoyu@nvidia.com>
 <20130108162056.GA28618@e106331-lin.cambridge.arm.com>
 <20130108171103.GA7417@e102568-lin.cambridge.arm.com>
 <20130109.134641.1582472136842052082.hdoyu@nvidia.com>
Message-ID: <20130109151700.GB22147@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 11:46:41AM +0000, Hiroshi Doyu wrote:
> Hi Lorenzo,
> 
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote @ Tue, 8 Jan 2013 18:11:03 +0100:
> 
> > On Tue, Jan 08, 2013 at 04:21:38PM +0000, Mark Rutland wrote:
> > > On Tue, Jan 08, 2013 at 02:53:42PM +0000, Hiroshi Doyu wrote:
> > 
> > [...]
> > 
> > > > > >  static void __init tegra_smp_init_cpus(void)
> > > > > >  {
> > > > > > -	unsigned int i, ncores = scu_get_core_count(scu_base);
> > > > > > +	unsigned int i, cpu_id, ncores;
> > > > > > +	u32 l2ctlr;
> > > > > > +	phys_addr_t pa;
> > > > > > +
> > > > > > +	cpu_id = read_cpuid(CPUID_ID) & CPU_MASK;
> > > > > > +	switch (cpu_id) {
> > > > > > +	case CPU_CORTEX_A15:
> > > > > > +		asm("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
> > > > > > +		ncores = ((l2ctlr >> 24) & 3) + 1;
> > > > > > +		break;
> > > > > 
> > > > > [...]
> > > > > 
> > > > > As mentioned last time [1], you should get this information from the dt
> > > > > instead.
> > > > 
> > > > Most of platsmp.c:.smp_init_cpus() implementations seem just to
> > > > overwrite # of cores by SCU/MRC detection. Is there any implementation
> > > > to use the DT's # and skip SCU/MRC detection in .smp_init_cpus()?
> > > 
> > > As far as I can see, there's no other platform which just relies on
> > > arm_dt_init_cpu_maps. Until recently, it didn't exist, so that makes some
> > > sense. As far as I can see, for the Tegra 114 you only need your smp_init_cpus
> > > to call set_smp_cross_call(gic_raise_softirq). Everything else you do seems to
> > > be handled by arm_dt_init_cpus.
> > > 
> > > I think the best option would be to have a separate smp_ops for your dt
> > > platforms where we know cpu nodes are populated (e.g. Tegra 114), where
> > > smp_init_cpus is different to that for non-dt platforms. That way non dt
> > > platforms can keep the SCU hack for now, and won't be broken, and the dt
> > > platforms are far removed from the SCU hack and just use common infrastructure.
> > > 
> > > Maybe someone else has a better idea?
> > 
> > Have a look at mach-vexpress/platsmp.c (keeping in mind that the
> > GENERIC_SCU case will be refactored/removed since arm_dt_init_cpu_maps() is
> > doing most of the required steps), please let me know what you think.
> 
> In tegra, we don't support non-DT. What about falling back SCU/MRC
> based detection only when arm_dt_init_cpu_maps() fails?
> 
> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> index 68e76ef..51d24ae 100644
> --- a/arch/arm/mach-tegra/platsmp.c
> +++ b/arch/arm/mach-tegra/platsmp.c
> @@ -152,7 +152,7 @@ done:
>   * Initialise the CPU possible map early - this describes the CPUs
>   * which may be present or become present in the system.
>   */
> -static void __init tegra_smp_init_cpus(void)
> +static void __init tegra_smp_detect_cores(void)
>  {
>  	unsigned int i, cpu_id, ncores;
>  	u32 l2ctlr;
> @@ -183,6 +183,12 @@ static void __init tegra_smp_init_cpus(void)
>  
>  	for (i = 0; i < ncores; i++)
>  		set_cpu_possible(i, true);
> +}
> +
> +static void __init tegra_smp_init_cpus(void)
> +{
> +	if (!num_possible_cpus())
> +		tegra_smp_detect_cores();

Thought about this, I would prefer writing an inline function that
provides this information (DT missing /cpu information or parsing failure)
instead of relying on num_possible_cpus to be == 0 as a way to check that.

Lorenzo
