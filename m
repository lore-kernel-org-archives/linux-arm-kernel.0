From: aneesh.kumar@linux.vnet.ibm.com (Aneesh Kumar K.V)
Date: Mon, 10 Aug 2015 11:31:12 +0530
Subject: [PATCH v4 2/7] mm: kasan: introduce generic
 kasan_populate_zero_shadow()
In-Reply-To: <1437756119-12817-3-git-send-email-a.ryabinin@samsung.com>
References: <1437756119-12817-1-git-send-email-a.ryabinin@samsung.com>
 <1437756119-12817-3-git-send-email-a.ryabinin@samsung.com>
Message-ID: <87mvxzptqv.fsf@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrey Ryabinin <a.ryabinin@samsung.com> writes:

> Introduce generic kasan_populate_zero_shadow(start, end).
> This function maps kasan_zero_page to the [start, end] addresses.
>
> In follow on patches it will be used for ARMv8 (and maybe other
> architectures) and will replace x86_64 specific populate_zero_shadow().
>
> Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>

This assume that we can have shared pgtable_t in generic code ? Is that
true for generic code ? Even if it is we may want to allow some arch to
override this ? On ppc64, we store the hardware hash page table slot
number in pte_t, Hence we won't be able to share pgtable_t. 



> ---
>  arch/x86/mm/kasan_init_64.c |  14 ----
>  include/linux/kasan.h       |   8 +++
>  mm/kasan/Makefile           |   2 +-
>  mm/kasan/kasan_init.c       | 151 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 160 insertions(+), 15 deletions(-)
>  create mode 100644 mm/kasan/kasan_init.c
>
> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> index e1840f3..812086c 100644
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -12,20 +12,6 @@
>  extern pgd_t early_level4_pgt[PTRS_PER_PGD];
>  extern struct range pfn_mapped[E820_X_MAX];
>  
> -static pud_t kasan_zero_pud[PTRS_PER_PUD] __page_aligned_bss;
> -static pmd_t kasan_zero_pmd[PTRS_PER_PMD] __page_aligned_bss;
> -static pte_t kasan_zero_pte[PTRS_PER_PTE] __page_aligned_bss;
> -
> -/*

-aneesh
