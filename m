From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 11 Jan 2013 12:56:28 +0100
Subject: [v2 3/9] ARM: tegra: # of CPU cores detection w/ & w/o
 HAVE_ARM_SCU
In-Reply-To: <20130111101134.GC30538@e102568-lin.cambridge.arm.com>
References: <20130110.145813.1159140334089730421.hdoyu@nvidia.com><50EEF235.7070200@wwwdotorg.org><20130111101134.GC30538@e102568-lin.cambridge.arm.com>
Message-ID: <20130111.135628.594268940275348411.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote @ Fri, 11 Jan 2013 11:11:34 +0100:

> On Thu, Jan 10, 2013 at 04:54:13PM +0000, Stephen Warren wrote:
> > On 01/10/2013 05:58 AM, Hiroshi Doyu wrote:
> > > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote @ Wed, 9 Jan 2013 16:17:00 +0100:
> > ...
> > > With your "[PATCH] ARM: kernel: DT cpu map validity check helper
> > > function", my original patch gets as below. I think that the following
> > > "smp_detect_ncores()" function may be so generic that it could be
> > > moved in some common place than platform?
> > > 
> > > From f5f2a43952ce75fe061b3808b994c3ceb07f1af1 Mon Sep 17 00:00:00 2001
> > > From: Hiroshi Doyu <hdoyu@nvidia.com>
> > > Date: Mon, 26 Nov 2012 12:25:14 +0200
> > > Subject: [PATCH 1/1] ARM: tegra: # of CPU cores detection w/ & w/o
> > >  HAVE_ARM_SCU
> > > 
> > > The method to detect the number of CPU cores on Cortex-A9 MPCore and
> > > Cortex-A15 MPCore is different. On Cortex-A9 MPCore we can get this
> > > information from the Snoop Control Unit(SCU). On Cortex-A15 MPCore we
> > > have to read it from the system coprocessor(CP15), because the SCU on
> > > Cortex-A15 MPCore does not have software readable registers. This
> > > patch selects the correct method at runtime based on the CPU ID.
> > 
> > > diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> > 
> > > +static int __init smp_detect_ncores(void)
> > > +{
> > > +	unsigned int ncores, mpidr;
> > > +	u32 l2ctlr;
> > > +	phys_addr_t pa;
> > > +
> > > +	mpidr = read_cpuid_mpidr();
> > > +	switch (mpidr) {
> > > +	case ARM_CPU_PART_CORTEX_A15:
> > > +		asm("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
> > > +		ncores = ((l2ctlr >> 24) & 3) + 1;
> > > +		break;
> > > +	case ARM_CPU_PART_CORTEX_A9:
> > > +		/* Get SCU physical base */
> > > +		asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (pa));
> > > +		scu_base = IO_ADDRESS(pa);
> > > +		ncores = scu_get_core_count(scu_base);
> > > +		break;
> > > +	default:
> > > +		pr_warn("Unsupported mpidr\n");
> > > +		ncores = 1;
> > > +		break;
> > > +	}
> > > +
> > > +	return ncores;
> > > +}
> > 
> > Why not just remove that function...
> > 
> > >  /*
> > >   * Initialise the CPU possible map early - this describes the CPUs
> > >   * which may be present or become present in the system.
> > >   */
> > >  static void __init tegra_smp_init_cpus(void)
> > >  {
> > > -	unsigned int i, ncores = scu_get_core_count(scu_base);
> > > -
> > > -	if (ncores > nr_cpu_ids) {
> > > -		pr_warn("SMP: %u cores greater than maximum (%u), clipping\n",
> > > -			ncores, nr_cpu_ids);
> > > -		ncores = nr_cpu_ids;
> > > +	if (!arm_dt_cpu_map_valid()) {
> > > +		unsigned int i, ncores;
> > > +
> > > +		ncores = smp_detect_ncores();
> > 
> > And just say "ncores = 1" here?
> > 
> > For Tegra, it's trivial to simply put the patch adding the required DT
> > nodes before this patch, and then there's no need for any
> > backwards-compatibility, since the nodes are guaranteed to be there.
> 
> If you are willing to accept that your code proposal is perfectly fine by me.

That's simple. I'll send ones to add cpu nodes, and then this without detection.
