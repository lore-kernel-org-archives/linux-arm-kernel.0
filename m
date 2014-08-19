From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Aug 2014 13:11:42 +0100
Subject: [PATCHv3 2/2] arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support
In-Reply-To: <1407886667-16919-3-git-send-email-lauraa@codeaurora.org>
References: <1407886667-16919-1-git-send-email-lauraa@codeaurora.org>
 <1407886667-16919-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140819121142.GC23128@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Wed, Aug 13, 2014 at 12:37:47AM +0100, Laura Abbott wrote:
> In a similar fashion to other architecture, add the infrastructure
> and Kconfig to enable DEBUG_SET_MODULE_RONX support. When
> enabled, module ranges will be marked read-only/no-execute as
> appropriate.

[...]

> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> new file mode 100644
> index 0000000..13573da
> --- /dev/null
> +++ b/arch/arm64/mm/pageattr.c
> @@ -0,0 +1,118 @@
> +/*
> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +
> +#include <asm/pgtable.h>
> +#include <asm/tlbflush.h>
> +
> +static int __change_memory(pte_t *ptep, pgtable_t token, unsigned long addr,
> +			pgprot_t prot, bool set)
> +{
> +	pte_t pte;
> +
> +	if (set)
> +		pte = set_pte_bit(*ptep, prot);
> +	else
> +		pte = clear_pte_bit(*ptep, prot);
> +	set_pte(ptep, pte);
> +	return 0;
> +}

Why do we need to propagate the token this far?

> +static int set_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
> +			void *data)
> +{
> +	pgprot_t prot = (pgprot_t)data;
> +
> +	return __change_memory(ptep, token, addr, prot, true);
> +}
> +
> +static int clear_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
> +			void *data)
> +{
> +	pgprot_t prot = (pgprot_t)data;
> +
> +	return __change_memory(ptep, token, addr, prot, false);
> +}
> +
> +static int change_memory_common(unsigned long addr, int numpages,
> +				pgprot_t prot, bool set)
> +{
> +	unsigned long start = addr;
> +	unsigned long size = PAGE_SIZE*numpages;
> +	unsigned long end = start + size;
> +	int ret;
> +
> +	if (!is_module_address(start) || !is_module_address(end))
> +		return -EINVAL;
> +
> +	if (set)
> +		ret = apply_to_page_range(&init_mm, start, size,
> +					set_page_range, (void *)prot);
> +	else
> +		ret = apply_to_page_range(&init_mm, start, size,
> +					clear_page_range, (void *)prot);

What if addr isn't page-aligned?

> +	flush_tlb_kernel_range(start, end);
> +	return ret;
> +}
> +
> +static int change_memory_set_bit(unsigned long addr, int numpages,
> +					pgprot_t prot)
> +{
> +	return change_memory_common(addr, numpages, prot, true);
> +}
> +
> +static int change_memory_clear_bit(unsigned long addr, int numpages,
> +					pgprot_t prot)
> +{
> +	return change_memory_common(addr, numpages, prot, false);
> +}
> +
> +int set_memory_ro(unsigned long addr, int numpages)
> +{
> +	int ret;
> +
> +	ret = change_memory_clear_bit(addr, numpages, __pgprot(PTE_WRITE));
> +	if (ret)
> +		return ret;

I'm slightly uncomfortable with this. Can other cores make the pages
writable again here before we've set R/O? I think this would be neater if,
instead of explicit set/clear operations, we had a single function that
takes a set mask and a clear mask and writes the page table once (we also
avoid the extra TLBI that way)

> +	return change_memory_set_bit(addr, numpages, __pgprot(PTE_RDONLY));
> +}
> +EXPORT_SYMBOL_GPL(set_memory_ro);
> +
> +int set_memory_rw(unsigned long addr, int numpages)
> +{
> +	int ret;
> +
> +	ret = change_memory_set_bit(addr, numpages, __pgprot(PTE_WRITE));
> +	if (ret)
> +		return ret;
> +
> +	return change_memory_clear_bit(addr, numpages, __pgprot(PTE_RDONLY));
> +}
> +EXPORT_SYMBOL_GPL(set_memory_rw);
> +
> +int set_memory_nx(unsigned long addr, int numpages)
> +{
> +	return change_memory_set_bit(addr, numpages, __pgprot(PTE_PXN));
> +}
> +EXPORT_SYMBOL_GPL(set_memory_nx);
> +
> +int set_memory_x(unsigned long addr, int numpages)
> +{
> +	return change_memory_clear_bit(addr, numpages, __pgprot(PTE_PXN));
> +}

What about UXN? (I don't have the ARM ARM to hand, but we may want to set
both)

Will
