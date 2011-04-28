From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 28 Apr 2011 11:22:46 +0100
Subject: Prefetching on Cortex-A8
In-Reply-To: <02B259EBC9134A47B143131FCAF2FEA30D6596@039-SN1MPN1-004.039d.mgd.msft.net>
References: <02B259EBC9134A47B143131FCAF2FEA30D6596@039-SN1MPN1-004.039d.mgd.msft.net>
Message-ID: <BANLkTikV3dZnZ_GqxDion4v1n0jePkw3OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 March 2011 16:00, Trivedi Anish-R6AAKA <R6AAKA@freescale.com> wrote:
> Recently, we encountered a cache coherency issue on a Cortex-A8 based SOC
> (using DMA on a read from a device to a buffer in memory) on kernel version
> 2.6.31. After some debugging, we found that to fix the coherency problem we
> needed to port a patch found in kernel 2.6.35 related to prefetching fix for
> ARMv6 and v7 platforms that you co-authored:
>
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=2ffe2da3e71652d4f4cae19539b5c78c2a239136
>
> However, according to ARM, Cortex-A8 only performs instruction prefetching,
> it does not ?prefetch data into the cache. I am confused, then, as to why
> your patch comments that prefetching applies to DMA data. Am I missing
> something?

Even if it only prefetch instructions, it may have a unified L2 cache
that gets populated with data just because of instruction prefetching.

> Secondly, a portion of the v7 cache code is mysterious. In the following
> file:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/mm/cache-v7.S;h=bcd64f265870804532dc6012274bca6e398a0622;hb=2ffe2da3e71652d4f4cae19539b5c78c2a239136
>
> The v7_dma_inv_range function that is part of the patch above does an
> invalidation of the cache lines with line 230:
>
> mcr?????p15,?0,?r0,?c7,?c6,?1???????????@?invalidate?D?/?U?line
>
> However, according to ARM, this only performs a cache line invalidation for
> L1, it does not invalidate L2 cache lines (there is no invalidate operation
> for L1 and L2 cache lines, there is only a clean and invalidate if both L1
> and L2 cache lines are to be invalidated).

The above operation is "invalidate data cache line by MVA to PoC" (to
the point of coherency). If the L2 is an inner cache (as it may be the
case on Cortex-A8), the point of coherency is beyond L2, so the above
operations invalidates both L1 and L2 caches.

If we only specify PoU (unification), that L2 would not be invalidated.

When the L2 is an outer cache (like on some Cortex-A9 system with
PL310), Linux does explicit cache maintenance at the L2 controller
level (see the cache-l2x0.c file).

-- 
Catalin
