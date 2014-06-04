From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 03 Jun 2014 17:56:34 -0700
Subject: [PATCHv2 1/4] arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support
In-Reply-To: <20140603152201.GP23149@arm.com>
References: <1401742658-11841-1-git-send-email-lauraa@codeaurora.org>
 <1401742658-11841-2-git-send-email-lauraa@codeaurora.org>
 <20140603152201.GP23149@arm.com>
Message-ID: <538E6EC2.5000004@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/3/2014 8:22 AM, Will Deacon wrote:
> Hi Laura,
> 
> This is looking better, but comments inline.
> 
> On Mon, Jun 02, 2014 at 09:57:35PM +0100, Laura Abbott wrote:
>>
>> In a similar fashion to other architecture, add the infrastructure
>> and Kconfig to enable DEBUG_SET_MODULE_RONX support. When
>> enabled, module ranges will be marked read-only/no-execute as
>> appropriate.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>>  arch/arm64/Kconfig.debug            |  11 ++++
>>  arch/arm64/include/asm/cacheflush.h |   4 ++
>>  arch/arm64/mm/Makefile              |   2 +-
>>  arch/arm64/mm/pageattr.c            | 121 ++++++++++++++++++++++++++++++++++++
>>  4 files changed, 137 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm64/mm/pageattr.c
> 
> [...]
> 
>>  obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> new file mode 100644
>> index 0000000..d8ab747
>> --- /dev/null
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -0,0 +1,121 @@
>> +/*
>> + * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/mm.h>
>> +#include <linux/sched.h>
>> +
>> +#include <asm/pgtable.h>
>> +#include <asm/tlbflush.h>
>> +
>> +static pte_t clear_pte_bit(pte_t pte, pgprot_t prot)
>> +{
>> +	pte_val(pte) &= ~pgprot_val(prot);
>> +	return pte;
>> +}
>> +
>> +static pte_t set_pte_bit(pte_t pte, pgprot_t prot)
>> +{
>> +	pte_val(pte) |= pgprot_val(prot);
>> +	return pte;
>> +}
> 
> We could actually re-use these for building our pte_mk* functions in
> pgtable.h. Care to move them there?
> 

Fine.

>> +static int __change_memory(pte_t *ptep, pgtable_t token, unsigned long addr,
>> +			pgprot_t prot, bool set)
>> +{
>> +	pte_t pte;
>> +
>> +	if (set)
>> +		pte = set_pte_bit(*ptep, prot);
>> +	else
>> +		pte = clear_pte_bit(*ptep, prot);
>> +	set_pte(ptep, pte);
>> +	return 0;
>> +}
>> +
>> +static int set_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
>> +			void *data)
>> +{
>> +	pgprot_t prot = (pgprot_t)data;
>> +
>> +	return __change_memory(ptep, token, addr, prot, true);
>> +}
>> +
>> +static int clear_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
>> +			void *data)
>> +{
>> +	pgprot_t prot = (pgprot_t)data;
>> +
>> +	return __change_memory(ptep, token, addr, prot, false);
>> +}
>> +
>> +static int change_memory_common(unsigned long addr, int numpages,
>> +				pgprot_t prot, bool set)
>> +{
>> +	unsigned long start = addr;
>> +	unsigned long size = PAGE_SIZE*numpages;
>> +	unsigned long end = start + size;
>> +	int ret;
>> +
>> +	if (start < MODULES_VADDR || start >= MODULES_END)
>> +		return -EINVAL;
>> +
>> +	if (end < MODULES_VADDR || end >= MODULES_END)
>> +		return -EINVAL;
> 
> Can you use is_module_address here, or do you need to change the page
> attributes for areas where no modules are currently loaded too?
> 

Yes, I think is_module_address should work fine.

>> +	if (set)
>> +		ret = apply_to_page_range(&init_mm, start, size,
>> +					set_page_range, (void *)prot);
>> +	else
>> +		ret = apply_to_page_range(&init_mm, start, size,
>> +					clear_page_range, (void *)prot);
>> +
>> +	flush_tlb_kernel_range(start, end);
>> +	isb();
>> +	return ret;
> 
> We already have an isb in flush_tlb_kernel_range.
> 

Yes, I'll drop the isb here.

>> +static int change_memory_set_bit(unsigned long addr, int numpages,
>> +					pgprot_t prot)
>> +{
>> +	return change_memory_common(addr, numpages, prot, true);
>> +}
>> +
>> +static int change_memory_clear_bit(unsigned long addr, int numpages,
>> +					pgprot_t prot)
>> +{
>> +	return change_memory_common(addr, numpages, prot, false);
>> +}
>> +
>> +int set_memory_ro(unsigned long addr, int numpages)
>> +{
>> +	return change_memory_set_bit(addr, numpages, __pgprot(PTE_RDONLY));
>> +}
>> +EXPORT_SYMBOL_GPL(set_memory_ro);
>> +
>> +int set_memory_rw(unsigned long addr, int numpages)
>> +{
>> +	return change_memory_clear_bit(addr, numpages, __pgprot(PTE_RDONLY));
>> +}
>> +EXPORT_SYMBOL_GPL(set_memory_rw);
> 
> I'm slightly worried about the interaction with this and PTE_WRITE (see
> linux-next). If the kernel pages are marked as PTE_DIRTY | PTE_WRITE, then
> setting read-only is a weird contradiction. Can you take PTE_WRITE into
> account for these two please?
>

It sounds like the solution should be to set/clear PTE_WRITE as appropriate
here, is my understanding correct?

> Will
> 

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
