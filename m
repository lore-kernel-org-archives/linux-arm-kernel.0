From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 30 May 2018 18:31:42 +0100
Subject: arch_wb_cache_pmem on ARM64
In-Reply-To: <alpine.LRH.2.02.1805301254340.25056@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1805301254340.25056@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <92b97864-52af-88d1-f18d-c6f6764072b0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/18 18:00, Mikulas Patocka wrote:
> Hi
> 
> I'd like to ask what's the purpose of dmb(osh) in the function
> arch_wb_cache_pmem in arch/arm64/mm/flush.c?
> 
> void arch_wb_cache_pmem(void *addr, size_t size)
> {
>          /* Ensure order against any prior non-cacheable writes */
>          dmb(osh);
>          __clean_dcache_area_pop(addr, size);
> }
> 
> The processor may flush the cache spontaneously, that means that all the
> flushing may actually happen before the dmb(osh) instruction - so what
> does that dmb instruction guard against?

IIRC the (very subtle) problem was to do with the odd case of a 
transparent (i.e. beyond the PoC) system cache - if data has been 
written to the pmem region via some non-cacheable alias, then the 
barrier was necessary to ensure that cache maintenance via the 
inner-shareable kernel mapping can push any data already at the PoC 
further along to the PoP.

Robin.
