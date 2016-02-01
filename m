From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 1 Feb 2016 13:27:59 +0100
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <20160201122444.GD15514@e104818-lin.cambridge.arm.com>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454324093-15998-8-git-send-email-ard.biesheuvel@linaro.org>
 <20160201122444.GD15514@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu-4FAn-f3dTKPZbiNcs_kCFN+PuxQkHwTdWN24VWhrrOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 February 2016 at 13:24, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Feb 01, 2016 at 11:54:52AM +0100, Ard Biesheuvel wrote:
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -53,6 +53,10 @@ u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
>>  unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
>>  EXPORT_SYMBOL(empty_zero_page);
>>
>> +static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
>> +static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
>> +static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss;
>
> I applied a fixup locally to keep the compiler quiet:
>
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -57,8 +57,8 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_
>  EXPORT_SYMBOL(empty_zero_page);
>
>  static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
> -static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
> -static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss;
> +static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
> +static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
>

Ah yes, I dropped a memblock_free() against bm_pud in
early_fixmap_init(), since it occurred before the actual reservation,
so bm_pud may never be referenced. For bm_pmd, it should not be
required afaict.

If you prefer, I can keep the original code here:

#if CONFIG_PGTABLE_LEVELS > 2
static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
#endif
#if CONFIG_PGTABLE_LEVELS > 3
static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss;
#endif

-- 
Ard.
