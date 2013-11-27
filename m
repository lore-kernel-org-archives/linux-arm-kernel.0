From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Nov 2013 11:30:28 +0000
Subject: [RFC PATCH 2/2] arm64: Add 48-bit PA support for 64KB page size
In-Reply-To: <1385537665-5909-3-git-send-email-mohun106@gmail.com>
References: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
 <1385537665-5909-3-git-send-email-mohun106@gmail.com>
Message-ID: <20131127113028.GG5402@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

On Wed, Nov 27, 2013 at 07:34:25AM +0000, mohun106 at gmail.com wrote:
> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> 
> Extend the 48-bit physical address support to 64KB page size. The
> VA_BITS will be 48 and 3 levels of page tables are used for address
> translations.

Similarly to the 4k patch, has this been tested with hugepages?

What is the performance and memory impact over 40-bit addresses?

> 
> Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> ---
>  arch/arm64/include/asm/page.h                 |    2 +-
>  arch/arm64/include/asm/pgalloc.h              |    4 +-
>  arch/arm64/include/asm/pgtable-3level-hwdef.h |   34 +++++++++++++++++++++++++
>  arch/arm64/include/asm/pgtable-hwdef.h        |    2 +-
>  arch/arm64/include/asm/pgtable.h              |   29 +++++++++++---------
>  arch/arm64/include/asm/tlb.h                  |    2 -
>  arch/arm64/kernel/head.S                      |   24 +++++++++++++++++
>  arch/arm64/kernel/traps.c                     |    2 +
>  8 files changed, 80 insertions(+), 19 deletions(-)

This patches leaves arch/arm64/include/asm/pgtable-2level-*.h unused,
yet they are not removed...

> diff --git a/arch/arm64/include/asm/pgtable-3level-hwdef.h b/arch/arm64/include/asm/pgtable-3level-hwdef.h
> index 3dbf941..fb9c1da 100644
> --- a/arch/arm64/include/asm/pgtable-3level-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-3level-hwdef.h
> @@ -16,6 +16,7 @@
>  #ifndef __ASM_PGTABLE_3LEVEL_HWDEF_H
>  #define __ASM_PGTABLE_3LEVEL_HWDEF_H
> 
> +#ifndef CONFIG_ARM64_64K_PAGES

As far as I could tell the last patch made 4k pages always use 4 levels.
Given that, why this #ifndef?

>  /*
>   * With LPAE and 4KB pages, there are 3 levels of page tables. Each level has
>   * 512 entries of 8 bytes each, occupying a 4K page. The first level table
> @@ -47,4 +48,37 @@
>  #define SECTION_SIZE           (_AC(1, UL) << SECTION_SHIFT)
>  #define SECTION_MASK           (~(SECTION_SIZE-1))

[...]

> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -17,7 +17,7 @@
>  #define __ASM_PGTABLE_HWDEF_H
> 
>  #ifdef CONFIG_ARM64_64K_PAGES
> -#include <asm/pgtable-2level-hwdef.h>
> +#include <asm/pgtable-3level-hwdef.h>
>  #else
>  #include <asm/pgtable-4level-hwdef.h>
>  #endif

So 2-level-hwdef.h is no longer used, and 4k pages definitely only works
in 4-level configurations...


> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index cc764e5..2c67b79 100644
> +#ifdef CONFIG_ARM64_64K_PAGES
> +/*
> + * Macro to populate the PMD for the corresponding block entry in the next
> + * level (tbl) for the given virtual address.
> + *
> + * Preserves:   pmd, tbl, virt
> + * Corrupts:    tmp1, tmp2
> + */
> +       .macro  create_pmd_entry, pud, tbl, virt, tmp1, tmp2
> +       lsr     \tmp1, \virt, #PMD_SHIFT
> +       and     \tmp1, \tmp1, #PTRS_PER_PMD - 1 // PMD index
> +       orr     \tmp2, \tbl, #3                 // PMD entry table type
> +       str     \tmp2, [\pud, \tmp1, lsl #3]
> +       .endm

s/pud/pmd/

[...]

> @@ -489,7 +509,11 @@ __create_page_tables:
>          * later based earlyprintk kernel parameter.
>          */
>         ldr     x5, =EARLYCON_IOBASE            // UART virtual address
> +#ifndef CONFIG_ARM64_64K_PAGES
>         add     x0, x26, #PAGE_SIZE             // section table address
> +#else
> +       add     x0, x26, #2 * PAGE_SIZE         // section table address

That comment should explain what's going on here. Currently its
redundant and unhelpful.

[...]

> +#ifndef CONFIG_ARM64_64K_PAGES
>  void __pud_error(const char *file, int line, unsigned long val)
>  {
>         printk("%s:%d: bad pud %016lx.\n", file, line, val);
>  }
> +#endif

If __p*_error were unified we wouldn't need to #ifdef this here.

Thanks,
Mark.
