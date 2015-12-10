From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Dec 2015 14:11:08 +0000
Subject: [RFC PATCH 06/20] arm64: mm: place empty_zero_page in bss
In-Reply-To: <1449665095-20774-7-git-send-email-mark.rutland@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
 <1449665095-20774-7-git-send-email-mark.rutland@arm.com>
Message-ID: <20151210141107.GF21134@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 12:44:41PM +0000, Mark Rutland wrote:
> Currently the zero page is set up in paging_init, and thus we cannot use
> the zero page earlier. We use the zero page as a reserved TTBR value
> from which no TLB entries may be allocated (e.g. when uninstalling the
> idmap). To enable such usage earlier (as may be required for invasive
> changes to the kernel page tables), and to minimise the time that the
> idmap is active, we need to be able to use the zero page before
> paging_init.
> 
> This patch follows the example set by x86, by allocating the zero page
> at compile time, in .bss. This means that the zero page itself is
> available immediately upon entry to start_kernel (as we zero .bss before
> this), and also means that the zero page takes up no space in the raw
> Image binary. The associated struct page is allocated in bootmem_init,
> and remains unavailable until this time.
> 
> Outside of arch code, the only users of empty_zero_page assume that the
> empty_zero_page symbol refers to the zeroed memory itself, and that
> ZERO_PAGE(x) must be used to acquire the associated struct page,
> following the example of x86. This patch also brings arm64 inline with
> these assumptions.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Laura Abbott <labbott@fedoraproject.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/mmu_context.h | 2 +-
>  arch/arm64/include/asm/pgtable.h     | 4 ++--
>  arch/arm64/mm/mmu.c                  | 9 +--------
>  3 files changed, 4 insertions(+), 11 deletions(-)

[...]

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 304ff23..7559c22 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -48,7 +48,7 @@ u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
>   * Empty_zero_page is a special page that is used for zero-initialized data
>   * and COW.
>   */
> -struct page *empty_zero_page;
> +unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
>  EXPORT_SYMBOL(empty_zero_page);

I've been looking at this, and it was making me feel uneasy because it's
full of junk before the bss is zeroed. Working that through, it's no
worse than what we currently have but I then realised that (a) we don't
have a dsb after zeroing the zero page (which we need to make sure the
zeroes are visible to the page table walker and (b) the zero page is
never explicitly cleaned to the PoC.

There may be cases where the zero-page is used to back read-only,
non-cacheable mappings (something to do with KVM?), so I'd sleep better
if we made sure that it was clean.

Thoughts?

Will
