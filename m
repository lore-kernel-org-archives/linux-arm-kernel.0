From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 30 Oct 2009 17:59:47 +0000
Subject: [RFC 02/11] ARM: Fix errata 411920 workarounds
In-Reply-To: <20091029191146.GC11460@n2100.arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<6af8ea18ac64a74700e374489751a63e643ac394.1256683230.git.rmk+kernel@arm.linux.org.uk>
	<1256743895.27121.39.camel@pc1117.cambridge.arm.com>
	<20091028173234.GA20040@n2100.arm.linux.org.uk>
	<1256841153.6874.85.camel@pc1117.cambridge.arm.com>
	<20091029191146.GC11460@n2100.arm.linux.org.uk>
Message-ID: <1256925587.27014.47.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-10-29 at 19:11 +0000, Russell King - ARM Linux wrote:
> On Thu, Oct 29, 2009 at 06:32:33PM +0000, Catalin Marinas wrote:
> > On Wed, 2009-10-28 at 17:32 +0000, Russell King - ARM Linux wrote:
> > > On Wed, Oct 28, 2009 at 03:31:35PM +0000, Catalin Marinas wrote:
> > > > On Sat, 2009-10-24 at 22:36 +0100, Russell King wrote:
> > > > > diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
> > > > > index 3147f75..af0624c 100644
> > > > > --- a/arch/arm/include/asm/cacheflush.h
> > > > > +++ b/arch/arm/include/asm/cacheflush.h
> > > > > @@ -412,9 +412,14 @@ extern void flush_dcache_page(struct page *);
> > > > >  
> > > > >  static inline void __flush_icache_all(void)
> > > > >  {
> > > > > +#ifdef CONFIG_ARM_ERRATA_411920
> > > > > +	extern void v6_icache_inval_all(void);
> > > > > +	v6_icache_inval_all();
> > > > > +#else
> > > > >         asm("mcr        p15, 0, %0, c7, c5, 0   @ invalidate I-cache\n"
> > > > >             :
> > > > >             : "r" (0));
> > > > > +#endif
> > > > >  }
> > > > 
> > > > For correctness, can we add a dsb() at the end of this function so that
> > > > the I-cache operation is guaranteed to complete?
> > > 
> > > Two reasons why not to in this patch:
> > > 
> > > 1. it changes the produced code, and therefore is another functional change.
> > > 2. it means we end up with a sequence like:
> > > 
> > > 	data cache maintainence
> > > 	dsb();
> > > 	instruction cache maintainence
> > > 	dsb();
> > > 
> > > The dsb() between the two operations probably isn't required.
> > 
> > That's described in B2.2.7 in the ARM ARM (make sure you use the latest
> > errata markup - 4.0).
> > 
> > The first DSB is needed to ensure the the D-cache op completed before
> > the I-cache op (in case we get speculative prefetches into the I-cache
> > before the D-cache op completed).
> > 
> > The second DSB would be needed to ensure the completion of the I-cache
> > maintenance operation. An ISB may be needed as well but the return from
> > exception has the same effect, so user code isn't affected.
> 
> Yes, it looks that way.
> 
> However, it looks like a DSB is not required for the work-around case -
> the I-cache invalidation must complete before any branch prediction
> occurs, and that's the purpose of the NOPs (to space other code well
> outside of the visibility of any prefetching which might interfere with
> the workaround.)

On ARM1136 where this erratum applies there isn't much prefetching, so
it should be fine without the first DSB.

But I was more thinking about placing only the second DSB in the
flush_icache_all() function while the first one is in the corresponding
D-cache flushing code.

-- 
Catalin
