From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 4 Dec 2015 17:52:33 +0000
Subject: [PATCH] arm64: add a function to show the different types of
 pagetable
In-Reply-To: <1449229397-39900-1-git-send-email-zhongjiang@huawei.com>
References: <1449229397-39900-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <20151204175232.GA27672@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 07:43:17PM +0800, zhongjiang wrote:
> The patch is mainly to show  pagetable number of different level in the direct
> mapping. pagetable is created from pud to pte in arm64 , resulting in different
> resluts with x86. For instance, The kernel of two-level pages will produce three
> types of pagetable.
> 
> It can also be used to detect whether there is a large page spliting and merging.
> Large page will significantly reduce the TLB miss, and improve the system
> performance.

As I mentioned previously, I still think it makes more sense to expose
this via the pagetable dumping code.

Also, the EFI runtime pagetable code uses __create_mapping, and hence
alloc_init_{pud,pmd,pte}. This code doesn't seem to account for that, so it
looks like the values will be misleading.

> Signed-off-by: zhongjiang <zhongjiang@huawei.com>
> ---
>  arch/arm64/include/asm/pgtable-types.h |   19 +++++++++++++++++
>  arch/arm64/mm/mmu.c                    |   12 +++++++++++
>  arch/arm64/mm/pageattr.c               |   35 ++++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-types.h b/arch/arm64/include/asm/pgtable-types.h
> index 2b1bd7e..a0f58d0 100644
> --- a/arch/arm64/include/asm/pgtable-types.h
> +++ b/arch/arm64/include/asm/pgtable-types.h
> @@ -86,6 +86,25 @@ typedef pteval_t pgprot_t;
>  
>  #endif /* STRICT_MM_TYPECHECKS */
>  
> +struct seq_file;
> +extern void arch_report_meminfo(struct seq_file *m);
> +
> +enum pg_level {
> +	PG_LEVEL_NONE,

This is never used. It can go.

> +	PG_LEVEL_PTE,
> +	PG_LEVEL_PMD,
> +	PG_LEVEL_PUD,
> +	PG_LEVEL_NUM
> +};

[...]

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 0a7bee7..77aef0b 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -30,6 +30,7 @@
>  #include <linux/stop_machine.h>
>  #include <linux/bootmem.h>
>  
> +#include <asm/pgtable-types.h>
>  #include <asm/cputype.h>
>  #include <asm/fixmap.h>
>  #include <asm/sections.h>

Nit: please keep includes ordered alphabetically.

[...]

> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 7a5ff11..a8257a2 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -15,12 +15,47 @@
>  #include <linux/module.h>
>  #include <linux/sched.h>
>  
> +#include <linux/seq_file.h>
>  #include <asm/pgalloc.h>
>  #include <asm/pgtable.h>
>  #include <asm/tlbflush.h>

Nit: please keep includes ordered alphabetically.

[...]

> +void arch_report_meminfo(struct seq_file *m)
> +{
> +
> +	seq_printf(m, "DirectMap%ldk:     %8lu kB\n", PAGE_SIZE / SZ_1K,
> +			direct_pages_count[PG_LEVEL_PTE] * PAGE_SIZE / SZ_1K);
> +
> +#if CONFIG_PGTABLE_LEVELS == 2

You can change this to >= 2 ...

> +	seq_printf(m, "DirectMap%ldM:     %8lu kB\n", PMD_SIZE / SZ_1M,
> +			direct_pages_count[PG_LEVEL_PMD] * PMD_SIZE / SZ_1K);
> +
> +#endif
> +
> +#if CONFIG_PGTABLE_LEVELS > 2
> +	seq_printf(m, "DirectMap%ldM:     %8lu kB\n", PMD_SIZE / SZ_1M,
> +			direct_pages_count[PG_LEVEL_PMD] * PMD_SIZE / SZ_1K);

.... and get rid of this line.

> +	seq_printf(m, "DirectMap%ldG:     %8lu kB\n", PUD_SIZE / SZ_1G,
> +			direct_pages_count[PG_LEVEL_PUD] * PUD_SIZE  / SZ_1K);
> +
> +#endif
> +}

Thanks,
Mark.
