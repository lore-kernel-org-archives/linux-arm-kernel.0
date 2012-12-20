From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Dec 2012 20:18:18 +0200
Subject: [PATCH 3/9] ARM: tegra: # of CPU cores detection w/ & w/o
 HAVE_ARM_SCU
In-Reply-To: <20121220.132136.1599315430686323669.hdoyu@nvidia.com>
References: <1355996654-6579-1-git-send-email-hdoyu@nvidia.com>
 <1355996654-6579-4-git-send-email-hdoyu@nvidia.com>
 <20121220100625.GB24693@arwen.pp.htv.fi>
 <20121220.132136.1599315430686323669.hdoyu@nvidia.com>
Message-ID: <20121220181818.GA26861@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 20, 2012 at 12:21:36PM +0100, Hiroshi Doyu wrote:
> Felipe Balbi <balbi@ti.com> wrote @ Thu, 20 Dec 2012 11:06:25 +0100:
> ...
> > > @@ -149,7 +154,26 @@ done:
> > >   */
> > >  static void __init tegra_smp_init_cpus(void)
> > >  {
> > > -	unsigned int i, ncores = scu_get_core_count(scu_base);
> > > +	unsigned int i, cpu_id, ncores;
> > > +	u32 l2ctlr;
> > > +	phys_addr_t pa;
> > > +
> > > +	cpu_id = read_cpuid(CPUID_ID) & CPU_MASK;
> > > +	switch (cpu_id) {
> > > +	case CPU_CORTEX_A15:
> > > +		asm("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
> > > +		ncores = ((l2ctlr >> 24) & 3) + 1;
> > > +		break;
> > > +	case CPU_CORTEX_A9:
> > > +		/* Get SCU physical base */
> > > +		asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (pa));
> > > +		scu_base = IO_ADDRESS(pa);
> > > +		ncores = scu_get_core_count(scu_base);
> > > +		break;
> > > +	default:
> > > +		BUG();
> > 
> > instead of bugging out, how about setting ncores to 1 instead ?
> 
> Maybe that would be useful in the case of adding new ARM core in the
> future.

right, kernel would at least boot in that case.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121220/9aa1e17c/attachment.sig>
