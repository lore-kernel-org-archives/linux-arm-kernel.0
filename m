From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Nov 2015 10:32:15 +0000
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <20151105044014.GB20374@js1304-P5Q-DELUXE>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
 <20151105044014.GB20374@js1304-P5Q-DELUXE>
Message-ID: <20151105103214.GP7637@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 01:40:14PM +0900, Joonsoo Kim wrote:
> On Tue, Sep 22, 2015 at 07:59:48PM +0200, Robert Richter wrote:
> > From: Tirumalesh Chalamarla <tchalamarla@cavium.com>
> > 
> > Increase the standard cacheline size to avoid having locks in the same
> > cacheline.
> > 
> > Cavium's ThunderX core implements cache lines of 128 byte size. With
> > current granulare size of 64 bytes (L1_CACHE_SHIFT=6) two locks could
> > share the same cache line leading a performance degradation.
> > Increasing the size fixes that.
> 
> Beside, slab-side bug, I don't think this argument is valid.
> Even if this change is applied, statically allocated spinlock could
> share the same cache line.

The benchmarks didn't show any difference with or without this patch
applied. What convinced me to apply it was this email:

http://lkml.kernel.org/g/CAOZdJXUiRMAguDV+HEJqPg57MyBNqEcTyaH+ya=U93NHb-pdJA at mail.gmail.com

On ARM we have a notion of cache writeback granule (CWG) which tells us
"the maximum size of memory that can be overwritten as a result of the
eviction of a cache entry that has had a memory location in it
modified". What we actually needed was ARCH_DMA_MINALIGN to be 128
(currently defined to the L1_CACHE_BYTES value). However, this wouldn't
have fixed the KMALLOC_MIN_SIZE, unless we somehow generate different
kmalloc_caches[] and kmalloc_dma_caches[] and probably introduce a
size_dma_index[].

> If two locks should not share the same cache line, you'd better to use
> compiler attribute such as ____cacheline_aligned_in_smp in appropriate
> place.

We could decouple SMP_CACHE_BYTES from L1_CACHE_BYTES but see above for
the other issue we had to solve.

-- 
Catalin
