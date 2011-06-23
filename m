From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 Jun 2011 18:02:42 +0100
Subject: parallel load of modules on an ARM multicore
In-Reply-To: <20110623153424.GA22786@1n450.cable.virginmedia.net>
References: <274124B9C6907D4B8CE985903EAA19E9185A92923E@SI-MBX06.de.bosch.com>
	<20110621155030.GA21245@1n450.cable.virginmedia.net>
	<274124B9C6907D4B8CE985903EAA19E9185A92978D@SI-MBX06.de.bosch.com>
	<20110623145229.GA18409@1n450.cable.virginmedia.net>
	<20110623151249.GA23234@n2100.arm.linux.org.uk>
	<20110623153424.GA22786@1n450.cable.virginmedia.net>
Message-ID: <20110623170242.GA23285@1n450.cable.virginmedia.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2011 at 04:34:24PM +0100, Catalin Marinas wrote:
> On Thu, Jun 23, 2011 at 04:12:49PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Jun 23, 2011 at 03:52:29PM +0100, Catalin Marinas wrote:
> > > Peter,
> > > 
> > > On Thu, Jun 23, 2011 at 04:39:01PM +0200, EXTERNAL Waechtler Peter (Fa. TCP, CM-AI/PJ-CF31) wrote:
> > > > it's interesting that you almost agree with me.
> > > > 
> > > > But isn't it really expensive to flush the icache on switch_mm?
> > > > Is that meant as a test to see if the problem goes away?
> > > 
> > > Who said anything about flushing the icache on switch_mm()? My patch
> > > doesn't do this, it actually reduces the amount of cache flushing on
> > > ARM11MPCore.
> > 
> > Ahem, your patch does:
> > 
> > --- a/arch/arm/include/asm/mmu_context.h
> > +++ b/arch/arm/include/asm/mmu_context.h
> > @@ -114,7 +114,8 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
> >  #ifdef CONFIG_SMP
> >         /* check for possible thread migration */
> >         if (!cpumask_empty(mm_cpumask(next)) &&
> > -           !cpumask_test_cpu(cpu, mm_cpumask(next)))
> > +           (cache_ops_need_broadcast() ||
> > +            !cpumask_test_cpu(cpu, mm_cpumask(next))))
> >                 __flush_icache_all();
> >  #endif
> >         if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next) {
> > 
> > This means that if cache_ops_need_broadcast() is true, we will flush
> > the I-cache at every MM context switch as very few MMs will have an
> > empty mm_cpumask().
> 
> Ah, I forgot about this. That's left over from some earlier version of
> the patch where cache_ops_need_broadcast() was set to 0 for ARMv6 SMP
> but then I realised that it is still needed for some ptrace stuff and
> re-instated it.
> 
> So this hunk is definitely not needed.

BTW, do we actually need the I-cache invalidation during thread
migration with cache ops broadcasting in hardware?

-- 
Catalin
