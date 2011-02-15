From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Feb 2011 14:42:06 +0000
Subject: [RFC PATCH 2/2] ARMv7: Invalidate the TLB before freeing page
	tables
In-Reply-To: <20110215121437.GG4152@n2100.arm.linux.org.uk>
References: <20110214173958.21717.30746.stgit@e102109-lin.cambridge.arm.com>
	<20110215103127.GC4152@n2100.arm.linux.org.uk>
	<1297767748.14691.15.camel@e102109-lin.cambridge.arm.com>
	<20110215113242.GD4152@n2100.arm.linux.org.uk>
	<20110215121437.GG4152@n2100.arm.linux.org.uk>
Message-ID: <1297780926.14691.164.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-02-15 at 12:14 +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 15, 2011 at 11:32:42AM +0000, Russell King - ARM Linux wrote:
> > The point of TLB shootdown is that we unmap the entries from the page
> > tables, then issue the TLB flushes, and then free the pages and page
> > tables after that.  All that Peter's patch tries to do is to get ARM to
> > use the generic stuff.
> 
> As Peter's patch preserves the current behaviour, that's not sufficient.
> So, let's do this our own way and delay pages and page table frees on
> ARMv6 and v7.  Untested.

ARMv7 should be enough, I'm not aware of any pre-v7 with this behaviour.

> Note that the generic code doesn't allow us to delay frees on UP as it
> assumes that if there's no TLB entry, the CPU won't speculatively
> prefetch.  This seems to be where ARM differs from the rest of the
> planet.  Please confirm that this is indeed the case.

The CPU can speculatively prefetch instructions and access data as long
as there is a valid mapping in the page tables. There is no need to have
a TLB entry for the speculative access, this can be created
speculatively from existing page table entries. That's not the issue
(ARM has been doing this for ages, probably other architectures too).

With newer cores, apart from the TLB (which stores a virtual to physical
translation), the CPU is allowed to cache entries in the higher page
table levels. This is important especially for LPAE where the 1st level
covers 1GB and can be easily cached to avoid 3 levels of page table walk
(or 2 levels for the classic page tables).

So even when we clear a page table entry in RAM (pmd_clear), the
processor still has it in its page table cache (pretty much part of the
TLB, different from the D-cache) and that's why we need the TLB
invalidation before freeing the lower page table.
> 
> diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
> index f41a6f5..1ca3e16 100644
> --- a/arch/arm/include/asm/tlb.h
> +++ b/arch/arm/include/asm/tlb.h
> @@ -30,6 +30,16 @@
>  #include <asm/pgalloc.h>
> 
>  /*
> + * As v6 and v7 speculatively prefetch, which can drag new entries into the
> + * TLB, we need to delay freeing pages and page tables.
> + */
> +#if defined(CONFIG_CPU_32v6) || defined(CONFIG_CPU_32v7)
> +#define tlb_fast_mode(tlb)     0
> +#else
> +#define tlb_fast_mode(tlb)     1
> +#endif

We could make this v7 only. If you want it to be more dynamic, we can
check the MMFR0[3:0] bits (Cortex-A15 sets them to 4). But
architecturally we should assume that intermediate page table levels may
be cached.

> -#define tlb_remove_page(tlb,page)      free_page_and_swap_cache(page)
> -#define pte_free_tlb(tlb, ptep, addr)  pte_free((tlb)->mm, ptep)
> +#define pte_free_tlb(tlb, ptep, addr)  __pte_free_tlb(tlb, ptep, addr)
>  #define pmd_free_tlb(tlb, pmdp, addr)  pmd_free((tlb)->mm, pmdp)

With LPAE, we'll need a __pmd_free_tlb() but I can add this as part of
my patches.

Apart from the need for ARMv6, the patch looks fine (I'll give it a try
as well).

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
