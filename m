From: alex@ghiti.fr (Alex Ghiti)
Date: Sun, 7 Oct 2018 18:59:44 +0000
Subject: [PATCH] hugetlb: fix ARM 3level page tables
In-Reply-To: <20181005161722.904274-1-arnd@arndb.de>
References: <20181005161722.904274-1-arnd@arndb.de>
Message-ID: <65728e32-d527-5f38-a93c-5a8d9cfbd492@ghiti.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Arnd, this change intervened in v5, that seemed straightforward 
enough...Sorry about that, and thanks for your fix.

Alex


On 10/05/2018 04:16 PM, Arnd Bergmann wrote:
> The check for __HAVE_ARCH_HUGE_PTEP_GET comes before the definition,
> leading to an extraneous definition of huge_ptep_get:
>
> In file included from arch/arm/include/asm/hugetlb.h:28,
>                   from include/linux/hugetlb.h:456,
>                   from arch/arm/kvm/../../../virt/kvm/arm/mmu.c:22:
> arch/arm/include/asm/hugetlb-3level.h:33:21: error: redefinition of 'huge_ptep_get'
>   static inline pte_t huge_ptep_get(pte_t *ptep)
>
> Change the header file inclusions to be in the correct order for
> this to work.
>
> Fixes: bb1d18ffc7ae ("hugetlb: introduce generic version of huge_ptep_get")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arm/include/asm/hugetlb.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
> index 3fcef21ff2c2..b67256c22b08 100644
> --- a/arch/arm/include/asm/hugetlb.h
> +++ b/arch/arm/include/asm/hugetlb.h
> @@ -23,9 +23,8 @@
>   #define _ASM_ARM_HUGETLB_H
>   
>   #include <asm/page.h>
> -#include <asm-generic/hugetlb.h>
> -
>   #include <asm/hugetlb-3level.h>
> +#include <asm-generic/hugetlb.h>
>   
>   static inline int is_hugepage_only_range(struct mm_struct *mm,
>   					 unsigned long addr, unsigned long len)
