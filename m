From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Sep 2010 17:08:18 -0700
Subject: [PATCH 1/6] ARM: Add inline function smp_cpu() for early init
	testing
In-Reply-To: <20100902192659.GW11597@atomide.com>
References: <20100819095705.GU12184@atomide.com>
	<20100819102025.GA32151@n2100.arm.linux.org.uk>
	<20100820120622.GL25742@atomide.com>
	<20100830225527.GC11597@atomide.com>
	<20100902133637.GJ26319@n2100.arm.linux.org.uk>
	<20100902161659.GJ11597@atomide.com>
	<20100902161846.GK11597@atomide.com>
	<20100902170830.GW26319@n2100.arm.linux.org.uk>
	<20100902174244.GU11597@atomide.com>
	<20100902192659.GW11597@atomide.com>
Message-ID: <20100903000817.GG11597@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [100902 12:20]:
> * Tony Lindgren <tony@atomide.com> [100902 10:35]:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 10:00]:
> > > On Thu, Sep 02, 2010 at 09:18:47AM -0700, Tony Lindgren wrote:
> > > 
> > > > --- a/arch/arm/include/asm/smp_plat.h
> > > > +++ b/arch/arm/include/asm/smp_plat.h
> > > > @@ -39,4 +39,20 @@ static inline int cache_ops_need_broadcast(void)
> > > >  #define UP(instr...)	_str(instr)
> > > >  #endif
> > > >  
> > > > +static inline int smp_on_up(void)
> > > > +{
> > > > +#ifdef CONFIG_SMP_ON_UP
> > > > +	int smp_on_up;
> > > > +
> > > > +	asm(							\
> > > > +		SMP(mov	%0, #0)					\
> > > > +		UP(mov	%0, #1)					\
> > > > +		: "=r" (smp_on_up));
> > > > +
> > > > +	return smp_on_up;
> > > > +#else
> > > > +	return 0;
> > > > +#endif
> > > 
> > > I think this is the wrong approach - rather than a function which tells us
> > > just if we are a SMP kernel running on UP, why not something which returns
> > > whether we're running on SMP and use that to eliminate some of these ifdefs?
> > 
> > Sure. Will has something like this in his patches:
> > 
> > static inline int cpu_is_part_of_mp_system(void)
> > {
> > 	u32 mpidr;
> > 	asm volatile("mrc p15, 0, %0, c0, c0, 5" : "=r" (mpidr));
> > 	return (mpidr >> 31) ? !(mpidr >> 30) : 0;
> > }
> > 
> > BTW, so far looks like we should only need this during init to set up things.
> 
> Here's this one updated to replace smp_cpu() instead of smp_on_up().

Heh, turns out there's a bit of a bug in the code snippet above :) It should
be !((mpidr >> 30) & 1) instead, otherwise it always returns 0.

Regards,

Tony
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smp-cpu.patch
Type: text/x-diff
Size: 2048 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100902/08f99cc9/attachment.bin>
