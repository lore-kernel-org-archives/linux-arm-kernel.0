From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 3 Sep 2010 17:39:52 +0530
Subject: [PATCH 1/6] ARM: Add inline function smp_on_up() for early init
	testing
In-Reply-To: <20100902174244.GU11597@atomide.com>
References: <20100819073810.GR12184@atomide.com>
	<4C6CFBAF.6020407@canonical.com> <20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902161846.GK11597@atomide.com>
	<20100902170830.GW26319@n2100.arm.linux.org.uk>
	<20100902174244.GU11597@atomide.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A2@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Thursday, September 02, 2010 11:13 PM
> To: Russell King - ARM Linux
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> Bryan Wu; Will Deacon
> Subject: Re: [PATCH 1/6] ARM: Add inline function smp_on_up() for early
> init testing
> 
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 10:00]:
> > On Thu, Sep 02, 2010 at 09:18:47AM -0700, Tony Lindgren wrote:
> >
> > > --- a/arch/arm/include/asm/smp_plat.h
> > > +++ b/arch/arm/include/asm/smp_plat.h
> > > @@ -39,4 +39,20 @@ static inline int cache_ops_need_broadcast(void)
> > >  #define UP(instr...)	_str(instr)
> > >  #endif
> > >
> > > +static inline int smp_on_up(void)
> > > +{
> > > +#ifdef CONFIG_SMP_ON_UP
> > > +	int smp_on_up;
> > > +
> > > +	asm(							\
> > > +		SMP(mov	%0, #0)					\
> > > +		UP(mov	%0, #1)					\
> > > +		: "=r" (smp_on_up));
> > > +
> > > +	return smp_on_up;
> > > +#else
> > > +	return 0;
> > > +#endif
> >
> > I think this is the wrong approach - rather than a function which tells
> us
> > just if we are a SMP kernel running on UP, why not something which
> returns
> > whether we're running on SMP and use that to eliminate some of these
> ifdefs?
> 
> Sure. Will has something like this in his patches:
> 
> static inline int cpu_is_part_of_mp_system(void)
> {
> 	u32 mpidr;
> 	asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (mpidr));
> 	return (mpidr >> 31) ? !(mpidr >> 30) : 0;
> }

I guess this register is only available on MP Core extensions.

Regards,
Santosh
