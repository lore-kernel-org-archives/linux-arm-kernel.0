From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 10 Jan 2013 15:59:24 +0100
Subject: [v2 3/9] ARM: tegra: # of CPU cores detection w/ & w/o
 HAVE_ARM_SCU
In-Reply-To: <20130110143334.GG4728@e102568-lin.cambridge.arm.com>
References: <20130110134723.GF4728@e102568-lin.cambridge.arm.com><20130110.160350.1128715111526546076.hdoyu@nvidia.com><20130110143334.GG4728@e102568-lin.cambridge.arm.com>
Message-ID: <20130110.165924.1755055417480491967.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote @ Thu, 10 Jan 2013 15:33:34 +0100:

> On Thu, Jan 10, 2013 at 02:03:50PM +0000, Hiroshi Doyu wrote:
> > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote @ Thu, 10 Jan 2013 14:47:23 +0100:
> 
> [...]
> 
> > > > +static int __init smp_detect_ncores(void)
> > > > +{
> > > > +	unsigned int ncores, mpidr;
> > > > +	u32 l2ctlr;
> > > > +	phys_addr_t pa;
> > > > +
> > > > +	mpidr = read_cpuid_mpidr();
> > > > +	switch (mpidr) {
> > > > +	case ARM_CPU_PART_CORTEX_A15:
> > > > +		asm("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
> > > > +		ncores = ((l2ctlr >> 24) & 3) + 1;
> > > > +		break;
> > > 
> > > I do not want to see the case above merged. We keep the existing legacy
> > > methods there for legacy reasons and as a fall-back mechanism but I am not
> > > keen on adding new HW probing code to detect the number of cores.
> > > 
> > > From A15/A7 onwards DT-only cpu map initialization is the way to go.
> > 
> > Ok, then, smp_detect_ncores(void) could be...
> > 
> > static int __init smp_detect_ncores(void)
> > {
> > 	unsigned int ncores, mpidr;
> > 	phys_addr_t pa;
> > 
> > 	mpidr = read_cpuid_mpidr();
> 
> Careful, MPIDR is not at all what you want. MIDR is.
> 
> > 	switch (mpidr) {
> > 	case ARM_CPU_PART_CORTEX_A9:
> > 		/* Get SCU physical base */
> > 		asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (pa));
> > 		scu_base = IO_ADDRESS(pa);
> > 		ncores = scu_get_core_count(scu_base);
> > 		break;
> > 	case ARM_CPU_PART_CORTEX_A15:
> 
> Remove the ARM_CPU_PART_CORTEX_A15 case, I do not see how it helps.
> 
> And be careful with the case matching, if I am not mistaken read_cpuid_id()
> (which is the function you have to use) will return the full MIDR, you need
> to mask the return value.

Oops, I'll fix.

> > 	default:
> > 		pr_warn("Unsupported MPIDR %x\n", mpidr);
> > 		ncores = 1;
> > 		break;
> 
> This is reasonable.

Ok, thank you for your reivew, I'll keep this func,
"smp_detect_ncores()" in this file since it's mostly for the backward
compatibility. Not necessary to be relocated in common place newly..
