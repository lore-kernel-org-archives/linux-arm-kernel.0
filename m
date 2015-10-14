From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Oct 2015 12:42:48 +0100
Subject: [PATCHv3 01/11] arm64: Move swapper pagetable definitions
In-Reply-To: <1444821634-1689-2-git-send-email-suzuki.poulose@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151014114247.GA2150@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 12:20:24PM +0100, Suzuki K. Poulose wrote:
> Move the kernel pagetable (both swapper and idmap) definitions
> from the generic asm/page.h to a new file, asm/kernel-pgtable.h.
> 
> This is mostly a cosmetic change, to clean up the asm/page.h to
> get rid of the arch specific details which are not needed by the
> generic code.
> 
> Also renames the symbols to prevent conflicts. e.g,
>  	BLOCK_SHIFT => SWAPPER_BLOCK_SHIFT

This sounds sensible to be, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I have a couple of minor nits below, though.

> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/kernel-pgtable.h |   65 +++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/page.h           |   18 ---------
>  arch/arm64/kernel/head.S                |   37 ++++--------------
>  arch/arm64/kernel/vmlinux.lds.S         |    1 +
>  4 files changed, 74 insertions(+), 47 deletions(-)
>  create mode 100644 arch/arm64/include/asm/kernel-pgtable.h
> 
> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
> new file mode 100644
> index 0000000..622929d
> --- /dev/null
> +++ b/arch/arm64/include/asm/kernel-pgtable.h
> @@ -0,0 +1,65 @@
> +/*
> + * asm/kernel-pgtable.h : Kernel page table mapping

Drop the filename from the comment. It's redundant and ends up being
painful when refactoring and moving things around.

> + * Copyright (C) 2015 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __ASM_KERNEL_PGTABLE_H
> +#define __ASM_KERNEL_PGTABLE_H
> +
> +/*
> + * The idmap and swapper page tables need some space reserved in the kernel
> + * image. Both require pgd, pud (4 levels only) and pmd tables to (section)
> + * map the kernel. With the 64K page configuration, swapper and idmap need to
> + * map to pte level. The swapper also maps the FDT (see __create_page_tables
> + * for more information). Note that the number of ID map translation levels
> + * could be increased on the fly if system RAM is out of reach for the default
> + * VA range, so 3 pages are reserved in all cases.
> + */
> +#ifdef CONFIG_ARM64_64K_PAGES
> +#define SWAPPER_PGTABLE_LEVELS	(CONFIG_PGTABLE_LEVELS)
> +#else
> +#define SWAPPER_PGTABLE_LEVELS	(CONFIG_PGTABLE_LEVELS - 1)
> +#endif
> +
> +#define SWAPPER_DIR_SIZE	(SWAPPER_PGTABLE_LEVELS * PAGE_SIZE)
> +#define IDMAP_DIR_SIZE		(3 * PAGE_SIZE)
> +
> +/* Initial memory map size */
> +#ifdef CONFIG_ARM64_64K_PAGES
> +#define SWAPPER_BLOCK_SHIFT	PAGE_SHIFT
> +#define SWAPPER_BLOCK_SIZE	PAGE_SIZE
> +#define SWAPPER_TABLE_SHIFT	PMD_SHIFT
> +#else
> +#define SWAPPER_BLOCK_SHIFT	SECTION_SHIFT
> +#define SWAPPER_BLOCK_SIZE	SECTION_SIZE
> +#define SWAPPER_TABLE_SHIFT	PUD_SHIFT
> +#endif
> +
> +
> +/*
> + * Initial memory map attributes.
> + */
> +#define SWAPPER_PTE_FLAGS	PTE_TYPE_PAGE | PTE_AF | PTE_SHARED
> +#define SWAPPER_PMD_FLAGS	PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S
> +
> +#ifdef CONFIG_ARM64_64K_PAGES
> +#define SWAPPER_MM_MMUFLAGS	PTE_ATTRINDX(MT_NORMAL) | SWAPPER_PTE_FLAGS
> +#else
> +#define SWAPPER_MM_MMUFLAGS	PMD_ATTRINDX(MT_NORMAL) | SWAPPER_PMD_FLAGS
> +#endif
> +
> +
> +#endif

It would be nice to have the usual comment here for what this is ending,
i.e.

#endif /* __ASM_KERNEL_PGTABLE_H */

Thanks,
Mark.
