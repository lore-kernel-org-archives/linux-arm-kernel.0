From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 26 Oct 2018 09:42:58 +0100
Subject: [PATCH] arm64: Don't flush tlb while clearing the accessed bit
In-Reply-To: <1540483944-22718-1-git-send-email-amhetre@nvidia.com>
References: <1540483944-22718-1-git-send-email-amhetre@nvidia.com>
Message-ID: <20181026084258.sjp2vmarmsfj2wbz@blommer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 09:42:24PM +0530, Ashish Mhetre wrote:
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

To save others the time, the relevant x86 commit is:

  b13b1d2d8692b437 ("x86/mm: In the PTE swapout page reclaim case clear the accessed bit instead of flushing the TLB")

That does call out the fact that this means page aging will be imprecise, and
hot pages might be reclaimed, with the claim being that the chance of this is
relatively low.

Do we have any numbers for other workloads?

> 
> Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 2ab2031..42931f6 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -652,6 +652,13 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>  	return __ptep_test_and_clear_young(ptep);
>  }
>  
> +#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
> +static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
> +					 unsigned long address, pte_t *ptep)
> +{
> +	return ptep_test_and_clear_young(vma, address, ptep);
> +}

As with the x86 commit, we should comment why we're not flushing the TLB here.

Thanks,
Mark.

> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
>  static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> -- 
> 2.7.4
> 
