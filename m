From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 10 Jan 2013 13:47:23 +0000
Subject: [v2 3/9] ARM: tegra: # of CPU cores detection w/ & w/o
 HAVE_ARM_SCU
In-Reply-To: <20130110.145813.1159140334089730421.hdoyu@nvidia.com>
References: <20130108171103.GA7417@e102568-lin.cambridge.arm.com>
 <20130109.134641.1582472136842052082.hdoyu@nvidia.com>
 <20130109151700.GB22147@e102568-lin.cambridge.arm.com>
 <20130110.145813.1159140334089730421.hdoyu@nvidia.com>
Message-ID: <20130110134723.GF4728@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 12:58:13PM +0000, Hiroshi Doyu wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote @ Wed, 9 Jan 2013 16:17:00 +0100:
> 
> ....
> 
> > > diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> > > index 68e76ef..51d24ae 100644
> > > --- a/arch/arm/mach-tegra/platsmp.c
> > > +++ b/arch/arm/mach-tegra/platsmp.c
> > > @@ -152,7 +152,7 @@ done:
> > >   * Initialise the CPU possible map early - this describes the CPUs
> > >   * which may be present or become present in the system.
> > >   */
> > > -static void __init tegra_smp_init_cpus(void)
> > > +static void __init tegra_smp_detect_cores(void)
> > >  {
> > >  	unsigned int i, cpu_id, ncores;
> > >  	u32 l2ctlr;
> > > @@ -183,6 +183,12 @@ static void __init tegra_smp_init_cpus(void)
> > >  
> > >  	for (i = 0; i < ncores; i++)
> > >  		set_cpu_possible(i, true);
> > > +}
> > > +
> > > +static void __init tegra_smp_init_cpus(void)
> > > +{
> > > +	if (!num_possible_cpus())
> > > +		tegra_smp_detect_cores();
> > 
> > Thought about this, I would prefer writing an inline function that
> > provides this information (DT missing /cpu information or parsing failure)
> > instead of relying on num_possible_cpus to be == 0 as a way to check that.
> 
> With your "[PATCH] ARM: kernel: DT cpu map validity check helper
> function", my original patch gets as below. I think that the following
> "smp_detect_ncores()" function may be so generic that it could be
> moved in some common place than platform?

Possibly, but I have still some comments to add.

> 
> From f5f2a43952ce75fe061b3808b994c3ceb07f1af1 Mon Sep 17 00:00:00 2001
> From: Hiroshi Doyu <hdoyu@nvidia.com>
> Date: Mon, 26 Nov 2012 12:25:14 +0200
> Subject: [PATCH 1/1] ARM: tegra: # of CPU cores detection w/ & w/o
>  HAVE_ARM_SCU
> 
> The method to detect the number of CPU cores on Cortex-A9 MPCore and
> Cortex-A15 MPCore is different. On Cortex-A9 MPCore we can get this
> information from the Snoop Control Unit(SCU). On Cortex-A15 MPCore we
> have to read it from the system coprocessor(CP15), because the SCU on
> Cortex-A15 MPCore does not have software readable registers. This
> patch selects the correct method at runtime based on the CPU ID.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>  arch/arm/mach-tegra/platsmp.c |   54 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> index 6867030..9a1324a 100644
> --- a/arch/arm/mach-tegra/platsmp.c
> +++ b/arch/arm/mach-tegra/platsmp.c
> @@ -24,6 +24,8 @@
>  #include <asm/mach-types.h>
>  #include <asm/smp_scu.h>
>  #include <asm/smp_plat.h>
> +#include <asm/cputype.h>
> +#include <asm/prom.h>
>  
>  #include <mach/powergate.h>
>  
> @@ -38,7 +40,7 @@
>  extern void tegra_secondary_startup(void);
>  
>  static cpumask_t tegra_cpu_init_mask;
> -static void __iomem *scu_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE);
> +static void __iomem *scu_base;
>  
>  #define EVP_CPU_RESET_VECTOR \
>  	(IO_ADDRESS(TEGRA_EXCEPTION_VECTORS_BASE) + 0x100)
> @@ -177,23 +179,52 @@ done:
>  	return status;
>  }
>  
> +static int __init smp_detect_ncores(void)
> +{
> +	unsigned int ncores, mpidr;
> +	u32 l2ctlr;
> +	phys_addr_t pa;
> +
> +	mpidr = read_cpuid_mpidr();
> +	switch (mpidr) {
> +	case ARM_CPU_PART_CORTEX_A15:
> +		asm("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
> +		ncores = ((l2ctlr >> 24) & 3) + 1;
> +		break;

I do not want to see the case above merged. We keep the existing legacy
methods there for legacy reasons and as a fall-back mechanism but I am not
keen on adding new HW probing code to detect the number of cores.

>From A15/A7 onwards DT-only cpu map initialization is the way to go.

Lorenzo

> +	case ARM_CPU_PART_CORTEX_A9:
> +		/* Get SCU physical base */
> +		asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (pa));
> +		scu_base = IO_ADDRESS(pa);
> +		ncores = scu_get_core_count(scu_base);
> +		break;
> +	default:
> +		pr_warn("Unsupported mpidr\n");
> +		ncores = 1;
> +		break;
> +	}
> +
> +	return ncores;
> +}
> +
>  /*
>   * Initialise the CPU possible map early - this describes the CPUs
>   * which may be present or become present in the system.
>   */
>  static void __init tegra_smp_init_cpus(void)
>  {
> -	unsigned int i, ncores = scu_get_core_count(scu_base);
> -
> -	if (ncores > nr_cpu_ids) {
> -		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
> -			ncores, nr_cpu_ids);
> -		ncores = nr_cpu_ids;
> +	if (!arm_dt_cpu_map_valid()) {
> +		unsigned int i, ncores;
> +
> +		ncores = smp_detect_ncores();
> +		if (ncores > nr_cpu_ids) {
> +			pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
> +				ncores, nr_cpu_ids);
> +			ncores = nr_cpu_ids;
> +		}
> +		for (i = 0; i < ncores; i++)
> +			set_cpu_possible(i, true);
>  	}
>  
> -	for (i = 0; i < ncores; i++)
> -		set_cpu_possible(i, true);
> -
>  	set_smp_cross_call(gic_raise_softirq);
>  }
>  
> @@ -202,7 +233,8 @@ static void __init tegra_smp_prepare_cpus(unsigned int max_cpus)
>  	/* Always mark the boot CPU (CPU0) as initialized. */
>  	cpumask_set_cpu(0, &tegra_cpu_init_mask);
>  
> -	scu_enable(scu_base);
> +	if (scu_base)
> +		scu_enable(scu_base);
>  }
>  
>  struct smp_operations tegra_smp_ops __initdata = {
> -- 
> 1.7.9.5
> 
> 
> 
> 
