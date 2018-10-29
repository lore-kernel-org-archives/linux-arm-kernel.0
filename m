From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Oct 2018 10:55:16 +0000
Subject: [PATCH V3] arm64: Don't flush tlb while clearing the accessed bit
In-Reply-To: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
References: <1540805158-618-1-git-send-email-amhetre@nvidia.com>
Message-ID: <20181029105515.GD14127@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 02:55:58PM +0530, Ashish Mhetre wrote:
> From: Alex Van Brunt <avanbrunt@nvidia.com>
> 
> Accessed bit is used to age a page and in generic implementation there is
> flush_tlb while clearing the accessed bit.
> Flushing a TLB is overhead on ARM64 as access flag faults don't get
> translation table entries cached into TLB's. Flushing TLB is not necessary
> for this. Clearing the accessed bit without flushing TLB doesn't cause data
> corruption on ARM64.
> In our case with this patch, speed of reading from fast NVMe/SSD through
> PCIe got improved by 10% ~ 15% and writing got improved by 20% ~ 40%.
> So for performance optimisation don't flush TLB when clearing the accessed
> bit on ARM64.
> x86 made the same optimization even though their TLB invalidate is much
> faster as it doesn't broadcast to other CPUs.

Ok, but they may end up using IPIs so lets avoid these vague performance
claims in the log unless they're backed up with numbers.

> Please refer to:
> 'commit b13b1d2d8692 ("x86/mm: In the PTE swapout page reclaim case clear
> the accessed bit instead of flushing the TLB")'
> 
> Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 2ab2031..080d842 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -652,6 +652,26 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>  	return __ptep_test_and_clear_young(ptep);
>  }
>  
> +#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
> +static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
> +					 unsigned long address, pte_t *ptep)
> +{
> +	/*
> +	 * On ARM64 CPUs, clearing the accessed bit without a TLB flush
> +	 * doesn't cause data corruption. [ It could cause incorrect
> +	 * page aging and the (mistaken) reclaim of hot pages, but the
> +	 * chance of that should be relatively low. ]
> +	 *
> +	 * So as a performance optimization don't flush the TLB when
> +	 * clearing the accessed bit, it will eventually be flushed by
> +	 * a context switch or a VM operation anyway. [ In the rare
> +	 * event of it not getting flushed for a long time the delay
> +	 * shouldn't really matter because there's no real memory
> +	 * pressure for swapout to react to. ]

This is blindly copied from x86 and isn't true for us: we don't invalidate
the TLB on context switch. That means our window for keeping the stale
entries around is potentially much bigger and might not be a great idea.

If we roll a TLB invalidation routine without the trailing DSB, what sort of
performance does that get you?

Will
