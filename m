From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 20 Nov 2012 18:41:50 +0900
Subject: [PATCH 1/5] ARM: EXYNOS: fix the hotplug for Cortex-A15
In-Reply-To: <20121106135502.GE30439@e102568-lin.cambridge.arm.com>
References: <1352182356-28989-1-git-send-email-a.kesavan@samsung.com>
 <1352182356-28989-2-git-send-email-a.kesavan@samsung.com>
 <5098FFBE.4080604@ti.com>
 <20121106135502.GE30439@e102568-lin.cambridge.arm.com>
Message-ID: <0c4c01cdc703$43deda00$cb9c8e00$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo Pieralisi wrote:
> 
> On Tue, Nov 06, 2012 at 12:17:02PM +0000, Santosh Shilimkar wrote:
> > On Tuesday 06 November 2012 12:12 AM, Abhilash Kesavan wrote:
> > > The sequence of cpu_enter_lowpower() for Cortex-A15
> > > is different from the sequence for Cortex-A9.
> > Are you sure ? Apart from integrated cache vs external, there
> > should be no change. And L2 doesn't need to come into picture
> > while powering down just a CPU.
> 
> Reiterating Santosh point in here. v7 shutdown procedure is and has to
> be identical across all v7 cores. There is not such a thing as "A15
> specific" shutdown procedure.
> 
BTW, it's true that current codes cannot support A15. So we need a separate
A15 func. And a A9 func. Now, cpu_enter_lowpower_a9() on A15 does NOT
work...also cpu_enter_lowpower_a15() on A9 does NOT work as well...

> Embedded L2 will come into the picture on multi-cluster systems, for the
> time being L2 must not be flushed when hotplugging a CPU in a single
> cluster
> so the LoUIS API is to be used here.
> 
OK.

> > > This patch implements cpu_enter_lowpower() for EXYNOS5
> > > SoC which has Cortex-A15 cores.

[...]

> > >
> > > +static inline void cpu_enter_lowpower_a15(void)
> > > +{
> > > +	unsigned int v;
> > > +
> > > +	asm volatile(
> > > +	"	mrc	p15, 0, %0, c1, c0, 0\n"
> > > +	"	bic	%0, %0, %1\n"
> > > +	"	mcr	p15, 0, %0, c1, c0, 0\n"
> > > +	  : "=&r" (v)
> > > +	  : "Ir" (CR_C)
> > > +	  : "cc");
> > > +
> > > +	flush_cache_all();
> > > +
> > Why are flushing all the cache levels ?
> > flush_kern_louis() should be enough for CPU power
> > down.
> 
> Agree with Santosh again.
> 
Yes, agree. I will replace as per your suggestion when I apply this. And as
I know, Abhilash already tested it on the boards and it works fine.

> >
> > > +	asm volatile(
> > > +	/*
> > > +	* Turn off coherency
> > > +	*/
> > > +	"	mrc	p15, 0, %0, c1, c0, 1\n"
> > > +	"	bic	%0, %0, %1\n"
> > > +	"	mcr	p15, 0, %0, c1, c0, 1\n"
> > > +	: "=&r" (v)
> > > +	: "Ir" (0x40)
> > > +	: "cc");
> > > +
> > > +	isb();
> > > +	dsb();
> > > +}
> > > +
> > The above sequence should work on A9 as well. In general you should have
> > CPU power down code under one code block and avoid making use of stack
> > in between. Otherwise you will end up with stack corruption because of
> > the memory view change after C bit is disabled.
> >
> > Regards
> > Santosh
> 
> The above sequence does not work on A9 since A9 does not look-up the
> caches when the C bit is cleared. It is an accident waiting to happen,
> as Santosh explained.
> 
> The sequence:
> 
> - clear C bit
> - clean L1
> - exit SMP
> 
> must be written in assembly with no access to any data whatsoever, no
> stack,
> _nothing_.
> 
> There is some code in the works to consolidate this procedure once for all
> but
> all bits and pieces are already in the kernel.
> 
I see, so it means, at this moment, exynos stuff needs this patch until
finishing common implementation you said. Then, I think, if any common codes
are available, we can use new codes instead.

K-Gene <kgene@kernel.org>
