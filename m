From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 2 Apr 2018 08:59:03 +0200
Subject: [PATCH v5 4/5] arm64: introduce pfn_valid_region()
In-Reply-To: <1522636236-12625-5-git-send-email-hejianet@gmail.com>
References: <1522636236-12625-1-git-send-email-hejianet@gmail.com>
 <1522636236-12625-5-git-send-email-hejianet@gmail.com>
Message-ID: <CAKv+Gu9x9bCvrHtXULtvk=bef3Yz0KsdQ8am7GuZj40cohodmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 April 2018 at 04:30, Jia He <hejianet@gmail.com> wrote:
> This is the preparation for further optimizing in early_pfn_valid
> on arm and arm64.
>

Same as before
- please share the code between ARM and arm64. if necessary, you can
invent a new HAVE_ARCH_xxx symbol that is only defined by ARM and
arm64
- please explain what the patch does and more importantly, why

> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
> ---
>  arch/arm/include/asm/page.h   |  3 ++-
>  arch/arm/mm/init.c            | 24 ++++++++++++++++++++++++
>  arch/arm64/include/asm/page.h |  3 ++-
>  arch/arm64/mm/init.c          | 24 ++++++++++++++++++++++++
>  4 files changed, 52 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
> index f38909c..3bd810e 100644
> --- a/arch/arm/include/asm/page.h
> +++ b/arch/arm/include/asm/page.h
> @@ -158,9 +158,10 @@ typedef struct page *pgtable_t;
>
>  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>  extern int early_region_idx;
> -extern int pfn_valid(unsigned long);
> +extern int pfn_valid(unsigned long pfn);
>  extern unsigned long memblock_next_valid_pfn(unsigned long pfn);
>  #define skip_to_last_invalid_pfn(pfn) (memblock_next_valid_pfn(pfn) - 1)
> +extern int pfn_valid_region(unsigned long pfn);
>  #endif
>
>  #include <asm/memory.h>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 06ed190..bdcbf58 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -201,6 +201,30 @@ int pfn_valid(unsigned long pfn)
>  }
>  EXPORT_SYMBOL(pfn_valid);
>
> +int pfn_valid_region(unsigned long pfn)
> +{
> +       unsigned long start_pfn, end_pfn;
> +       struct memblock_type *type = &memblock.memory;
> +       struct memblock_region *regions = type->regions;
> +
> +       if (early_region_idx != -1) {
> +               start_pfn = PFN_DOWN(regions[early_region_idx].base);
> +               end_pfn = PFN_DOWN(regions[early_region_idx].base +
> +                                       regions[early_region_idx].size);
> +
> +               if (pfn >= start_pfn && pfn < end_pfn)
> +                       return !memblock_is_nomap(
> +                                       &regions[early_region_idx]);
> +       }
> +
> +       early_region_idx = memblock_search_pfn_regions(pfn);
> +       if (early_region_idx == -1)
> +               return false;
> +
> +       return !memblock_is_nomap(&regions[early_region_idx]);
> +}
> +EXPORT_SYMBOL(pfn_valid_region);
> +
>  /* HAVE_MEMBLOCK is always enabled on arm */
>  unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
>  {
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> index f0d8c8e5..7087b63 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -39,9 +39,10 @@ typedef struct page *pgtable_t;
>
>  #ifdef CONFIG_HAVE_ARCH_PFN_VALID
>  extern int early_region_idx;
> -extern int pfn_valid(unsigned long);
> +extern int pfn_valid(unsigned long pfn);
>  extern unsigned long memblock_next_valid_pfn(unsigned long pfn);
>  #define skip_to_last_invalid_pfn(pfn) (memblock_next_valid_pfn(pfn) - 1)
> +extern int pfn_valid_region(unsigned long pfn);
>  #endif
>
>  #include <asm/memory.h>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 342e4e2..a1646b6 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -293,6 +293,30 @@ int pfn_valid(unsigned long pfn)
>  }
>  EXPORT_SYMBOL(pfn_valid);
>
> +int pfn_valid_region(unsigned long pfn)
> +{
> +       unsigned long start_pfn, end_pfn;
> +       struct memblock_type *type = &memblock.memory;
> +       struct memblock_region *regions = type->regions;
> +
> +       if (early_region_idx != -1) {
> +               start_pfn = PFN_DOWN(regions[early_region_idx].base);
> +               end_pfn = PFN_DOWN(regions[early_region_idx].base +
> +                               regions[early_region_idx].size);
> +
> +               if (pfn >= start_pfn && pfn < end_pfn)
> +                       return !memblock_is_nomap(
> +                                       &regions[early_region_idx]);
> +       }
> +
> +       early_region_idx = memblock_search_pfn_regions(pfn);
> +       if (early_region_idx == -1)
> +               return false;
> +
> +       return !memblock_is_nomap(&regions[early_region_idx]);
> +}
> +EXPORT_SYMBOL(pfn_valid_region);
> +
>  /* HAVE_MEMBLOCK is always enabled on arm64 */
>  unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
>  {
> --
> 2.7.4
>
