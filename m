From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Nov 2010 23:31:29 +0000
Subject: [PATCH v2 02/20] ARM: LPAE: Factor out 2-level page table
	definitions into separate files
In-Reply-To: <1289584840-18097-3-git-send-email-catalin.marinas@arm.com>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <20101115233129.GG31421@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 12, 2010 at 06:00:22PM +0000, Catalin Marinas wrote:
> This patch moves page table definitions from asm/page.h, asm/pgtable.h
> and asm/ptgable-hwdef.h into corresponding *-2level* files.

This also introduces pteval_t.  It would be useful to have the
introduction of pteval_t as a separate patch, which not only
introduces the typedef, but also makes use of it.

> +#ifndef _ASM_PGTABLE_2LEVEL_TYPES_H
> +#define _ASM_PGTABLE_2LEVEL_TYPES_H
> +
> +#undef STRICT_MM_TYPECHECKS
> +
> +typedef unsigned long pteval_t;
> +
> +#ifdef STRICT_MM_TYPECHECKS
> +/*
> + * These are used to make use of C type-checking..
> + */
> +typedef struct { unsigned long pte; } pte_t;

This should become:

typedef struct { pteval_t pte; } pte_t;

L_PTE_* can then be declared using linux/const.h stuff to typedef them
to pteval_t.  shared_pte_mask also needs to be pteval_t.

As far as the __p*_error() functions, these should probably be passed
the pte/pmd/pgd value itself, rather than first passing them through
__pte_val() et.al.

Of couse, I now have patches for this and my other points... will sort
them out into a series in the next few days.
