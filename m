From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 30 May 2018 18:56:52 +0100
Subject: arch_wb_cache_pmem on ARM64
In-Reply-To: <92b97864-52af-88d1-f18d-c6f6764072b0@arm.com>
References: <alpine.LRH.2.02.1805301254340.25056@file01.intranet.prod.int.rdu2.redhat.com>
 <92b97864-52af-88d1-f18d-c6f6764072b0@arm.com>
Message-ID: <20180530175652.fapzlssmkncusier@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 06:31:42PM +0100, Robin Murphy wrote:
> On 30/05/18 18:00, Mikulas Patocka wrote:
> > Hi
> > 
> > I'd like to ask what's the purpose of dmb(osh) in the function
> > arch_wb_cache_pmem in arch/arm64/mm/flush.c?
> > 
> > void arch_wb_cache_pmem(void *addr, size_t size)
> > {
> >          /* Ensure order against any prior non-cacheable writes */
> >          dmb(osh);
> >          __clean_dcache_area_pop(addr, size);
> > }
> > 
> > The processor may flush the cache spontaneously, that means that all the
> > flushing may actually happen before the dmb(osh) instruction - so what
> > does that dmb instruction guard against?
> 
> IIRC the (very subtle) problem was to do with the odd case of a transparent
> (i.e. beyond the PoC) system cache - if data has been written to the pmem
> region via some non-cacheable alias, then the barrier was necessary to
> ensure that cache maintenance via the inner-shareable kernel mapping can
> push any data already at the PoC further along to the PoP.

I think it's simpler than that: the cache maintenance operations
naturally hazard against cacheable memory accesses, but they don't
hazard against non-cacheable accesses.

Thus, we need a barrier between the two to ensure ordering.

Non-cacheable accesses are Outer Shareable, so thus the barrier must be
at least Outer Shareable.

We *might* be able to get away with OSHST, though.

For example, Without the barrier, prior non-cacheable stores could sit
in a store buffer while the cache maintenance was performed, and could
subsequently be written out after the cache maintenance was complete.

Thanks,
Mark.
