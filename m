From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Mar 2010 14:08:42 +0000
Subject: [PATCH 2/5] ARM: Implement read/write for ownership in
	theARMv6 DMA cache ops
In-Reply-To: <20100323213825.GI19572@n2100.arm.linux.org.uk>
References: <20100323213825.GI19572@n2100.arm.linux.org.uk>
Message-ID: <1269612522.807.71.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-23 at 21:38 +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 22, 2010 at 03:19:45PM +0000, Catalin Marinas wrote:
> > diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
> > index 9d89c67..b9f2cbd 100644
> > --- a/arch/arm/mm/cache-v6.S
> > +++ b/arch/arm/mm/cache-v6.S
> > @@ -211,6 +211,9 @@ v6_dma_inv_range:
> >       mcrne   p15, 0, r1, c7, c15, 1          @ clean & invalidate unified line
> >  #endif
> >  1:
> > +#ifdef CONFIG_SMP
> > +     str     r0, [r0]                        @ write for ownership
> > +#endif
> >  #ifdef HARVARD_CACHE
> >       mcr     p15, 0, r0, c7, c6, 1           @ invalidate D line
> >  #else
> > @@ -231,6 +234,9 @@ v6_dma_inv_range:
> >  v6_dma_clean_range:
> >       bic     r0, r0, #D_CACHE_LINE_SIZE - 1
> >  1:
> > +#ifdef CONFIG_SMP
> > +     ldr     r2, [r0]                        @ read for ownership
> > +#endif
> >  #ifdef HARVARD_CACHE
> >       mcr     p15, 0, r0, c7, c10, 1          @ clean D line
> >  #else
> > @@ -251,6 +257,10 @@ v6_dma_clean_range:
> >  ENTRY(v6_dma_flush_range)
> >       bic     r0, r0, #D_CACHE_LINE_SIZE - 1
> >  1:
> > +#ifdef CONFIG_SMP
> > +     ldr     r2, [r0]                        @ read for ownership
> > +     str     r2, [r0]                        @ write for ownership
> 
> What is the effect of using the register just loaded on ARMv6?  Does it
> stall like previous architectures?  If so, this str should use a different
> register.

Using the same register here is on purpose so that we do not override
the data already in the buffer (it's a flush operation). Yes, we have
interlocking, but the STR has to be executed before we issue the cache
cleaning operation.

The invalidate case uses a dummy STR but we just found that with the
latest DMA API, invalidating in the unmap functions would override the
transferred data. I need to revisit this.

> In any case, does reading then writing actually achieve anything over just
> a plain write?  read surely brings the cache line into shared mode, and
> a write to exclusive mode - so won't just a write do?

Yes, we need to preserve the data already in the buffer in some
situations.

> The converse argument is that with read allocate caches, this technique
> can result in faster code, so why don't we use it in dma_inv_range?

Only reading the data may put the cache line in shared mode and a local
cache invalidation only affects the current CPU, leaving the data in
cache on the other CPUs. It's true that we won't have dirty cache lines
that may be evicted during the DMA transfer but if a different CPU uses
the data at a later time, it may get the stale cache entries.

Issuing a write would invalidate the cache lines on the other CPUs so
they'll need to be read from L2 again when accessed.

-- 
Catalin
