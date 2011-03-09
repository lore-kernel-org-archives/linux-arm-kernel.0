From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Mar 2011 15:40:05 +0000
Subject: [RFC PATCH 2/2] ARMv7: Invalidate the TLB before freeing page
	tables
In-Reply-To: <20110215121437.GG4152@n2100.arm.linux.org.uk>
References: <20110214173958.21717.30746.stgit@e102109-lin.cambridge.arm.com>
	<20110215103127.GC4152@n2100.arm.linux.org.uk>
	<1297767748.14691.15.camel@e102109-lin.cambridge.arm.com>
	<20110215113242.GD4152@n2100.arm.linux.org.uk>
	<20110215121437.GG4152@n2100.arm.linux.org.uk>
Message-ID: <AANLkTindKihW3Hv4gdWakPcBAfFCrnd5wzSXN7K=Ac0h@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 February 2011 12:14, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Note that the generic code doesn't allow us to delay frees on UP as it
> assumes that if there's no TLB entry, the CPU won't speculatively
> prefetch. ?This seems to be where ARM differs from the rest of the
> planet. ?Please confirm that this is indeed the case.
>
> ?arch/arm/include/asm/tlb.h | ? 79 +++++++++++++++++++++++++++++++++++++-------
> ?1 files changed, 67 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
> index f41a6f5..1ca3e16 100644
> --- a/arch/arm/include/asm/tlb.h
> +++ b/arch/arm/include/asm/tlb.h
[...]
> +static inline void tlb_add_flush(struct mmu_gather *tlb, unsigned long addr)
> +{
> + ? ? ? if (!tlb->fullmm) {
> + ? ? ? ? ? ? ? if (addr < tlb->range_start)
> + ? ? ? ? ? ? ? ? ? ? ? tlb->range_start = addr;
> + ? ? ? ? ? ? ? if (addr + PAGE_SIZE > tlb->range_end)
> + ? ? ? ? ? ? ? ? ? ? ? tlb->range_end = addr + PAGE_SIZE;
> + ? ? ? }
> +}
[...]
> +static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
> + ? ? ? unsigned long addr)
> +{
> + ? ? ? pgtable_page_dtor(pte);
> + ? ? ? tlb_add_flush(addr);
> + ? ? ? tlb_remove_page(tlb, pte);
> ?}

The above call to tlb_add_flush() would only add a PAGE_SIZE. But
since we free an entire PTE, shouldn't the range cover addr ..
addr+PTRS_PER_PTE*PAGE_SIZE?

-- 
Catalin
