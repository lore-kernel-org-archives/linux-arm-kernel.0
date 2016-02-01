From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 1 Feb 2016 12:24:44 +0000
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <1454324093-15998-8-git-send-email-ard.biesheuvel@linaro.org>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454324093-15998-8-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160201122444.GD15514@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 11:54:52AM +0100, Ard Biesheuvel wrote:
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -53,6 +53,10 @@ u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
>  unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
>  EXPORT_SYMBOL(empty_zero_page);
>  
> +static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
> +static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
> +static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss;

I applied a fixup locally to keep the compiler quiet:

--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -57,8 +57,8 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_
 EXPORT_SYMBOL(empty_zero_page);
 
 static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
-static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss;
-static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss;
+static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
+static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
 
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)

-- 
Catalin
