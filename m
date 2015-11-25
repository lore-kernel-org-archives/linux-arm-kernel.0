From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 25 Nov 2015 15:04:48 +0000
Subject: [PATCH] arm64: calculate the various pages number to show
In-Reply-To: <1448458872-39897-1-git-send-email-zhongjiang@huawei.com>
References: <1448458872-39897-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <20151125150448.GD12434@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 09:41:12PM +0800, zhongjiang wrote:
> This patch add the interface to show the number of 4KB or 64KB page,
> aims to statistics the number of different types of pages.

What is this useful for? Why do we want it?

What does it account for, just the swapper?

> Signed-off-by: zhongjiang <zhongjiang@huawei.com>
> ---
>  arch/arm64/include/asm/pgtable-types.h |   24 ++++++++++++++++++++++++
>  arch/arm64/mm/mmu.c                    |   28 ++++++++++++++++++++++++++++
>  arch/arm64/mm/pageattr.c               |   31 +++++++++++++++++++++++++++++++
>  3 files changed, 83 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-types.h b/arch/arm64/include/asm/pgtable-types.h
> index 2b1bd7e..aa52546 100644
> --- a/arch/arm64/include/asm/pgtable-types.h
> +++ b/arch/arm64/include/asm/pgtable-types.h
> @@ -86,6 +86,30 @@ typedef pteval_t pgprot_t;
>  
>  #endif /* STRICT_MM_TYPECHECKS */
>  
> +struct seq_file;
> +extern void arch_report_meminfo(struct seq_file *m);
> +
> +enum pg_level {
> +	PG_LEVEL_NONE,
> +#ifdef CONFIG_ARM64_4K_PAGES
> +	PG_LEVEL_4K,
> +	PG_LEVEL_2M,
> +	PG_LEVEL_1G,
> +#else
> +	PG_LEVEL_64K,
> +	PG_LEVEL_512M,
> +#endif
> +	PG_LEVEL_NUM
> +};

This doesn't account for 16K pages, and it means each call site has to
handle the various page sizes directly.

It would be better to simply count PTE/PMD/PUD/PGD, then handle the size
conversion at the end when logging.

> @@ -85,6 +86,11 @@ void split_pmd(pmd_t *pmd, pte_t *pte)
>  		set_pte(pte, pfn_pte(pfn, prot));
>  		pfn++;
>  	} while (pte++, i++, i < PTRS_PER_PTE);
> +#ifdef CONFIG_ARM64_4K_PAGES
> +	split_page_count(PG_LEVEL_2M);
> +#else
> +	split_page_count(PG_LEVEL_512M);
> +#endif
>  }

e.g. here you'd just count PG_LEVEL_PMD, which would work regardless of
page size.

> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 7a5ff11..c1888b9 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -15,12 +15,43 @@
>  #include <linux/module.h>
>  #include <linux/sched.h>
>  
> +#include <linux/seq_file.h>
>  #include <asm/pgalloc.h>
>  #include <asm/pgtable.h>
>  #include <asm/tlbflush.h>
>  
>  #include "mm.h"
>  
> +static unsigned long direct_pages_count[PG_LEVEL_NUM];

This doesn't match reality by the time we start executing the kernel,
given we created page tables in head.S.

> +
> +void update_page_count(int level, unsigned long pages)
> +{
> +	direct_pages_count[level] += pages;
> +}
> +
> +void split_page_count(int level)
> +{
> +	direct_pages_count[level]--;
> +	direct_pages_count[level-1] += PTRS_PER_PTE;
> +}
> +
> +void arch_report_meminfo(struct seq_file *m)
> +{
> +#ifdef CONFIG_ARM64_4K_PAGES
> +	seq_printf(m, "DirectMap4k:     %8lu kB\n",
> +			direct_pages_count[PG_LEVEL_4K] << 2);
> +	seq_printf(m, "DirectMap2M:     %8lu kB\n",
> +			direct_pages_count[PG_LEVEL_2M] << 11);
> +	seq_printf(m, "DirectMap1G:     %8lu kB\n",
> +			direct_pages_count[PG_LEVEL_1G] << 20);
> +#else
> +	seq_printf(m, "DirectMap64k:     %8lu kB\n",
> +			direct_pages_count[PG_LEVEL_64K] << 6);
> +	seq_printf(m, "DirectMap512M:     %8lu kB\n",
> +			direct_pages_count[PG_LEVEL_512M] << 19);
> +#endif
> +}

You could dynamuically determine the sizes here for each field, and not
have to have #ifdefs.

That all said, I don't see what this is useful for, and it looks very
fragile.

Thanks,
Mark.
