From: labbott@redhat.com (Laura Abbott)
Date: Thu, 12 Nov 2015 08:31:54 -0800
Subject: [PATCHv2 2/2] arm64: Allow changing of attributes outside of
 modules
In-Reply-To: <56447E42.7050002@huawei.com>
References: <1447207057-11323-1-git-send-email-labbott@fedoraproject.org>
 <1447207057-11323-3-git-send-email-labbott@fedoraproject.org>
 <56447E42.7050002@huawei.com>
Message-ID: <5644BEFA.9040400@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2015 03:55 AM, zhong jiang wrote:
> On 2015/11/11 9:57, Laura Abbott wrote:
>> Currently, the set_memory_* functions that are implemented for arm64
>> are restricted to module addresses only. This was mostly done
>> because arm64 maps normal zone memory with larger page sizes to
>> improve TLB performance. This has the side effect though of making it
>> difficult to adjust attributes at the PAGE_SIZE granularity. There are
>> an increasing number of use cases related to security where it is
>> necessary to change the attributes of kernel memory. Add functionality
>> to the page attribute changing code under a Kconfig to let systems
>> designers decide if they want to make the trade off of security for TLB
>> pressure.
>>
>> Signed-off-by: Laura Abbott <labbott@fedoraproject.org>
>> ---
>> v2: Re-worked to account for the full range of addresses. Will also just
>> update the section blocks instead of splitting if the addresses are aligned
>> properly.
>> ---
>>   arch/arm64/Kconfig       |  12 ++++
>>   arch/arm64/mm/mm.h       |   3 +
>>   arch/arm64/mm/mmu.c      |   2 +-
>>   arch/arm64/mm/pageattr.c | 174 +++++++++++++++++++++++++++++++++++++++++------
>>   4 files changed, 170 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 851fe11..46725e8 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -521,6 +521,18 @@ config ARCH_HAS_CACHE_LINE_SIZE
>>
>>   source "mm/Kconfig"
>>
>> +config DEBUG_CHANGE_PAGEATTR
>> +	bool "Allow all kernel memory to have attributes changed"
>> +	default y
>> +	help
>> +	  If this option is selected, APIs that change page attributes
>> +	  (RW <-> RO, X <-> NX) will be valid for all memory mapped in
>> +	  the kernel space. The trade off is that there may be increased
>> +	  TLB pressure from finer grained page mapping. Turn on this option
>> +	  if security is more important than performance
>> +
>> +	  If in doubt, say Y
>> +
>>   config SECCOMP
>>   	bool "Enable seccomp to safely compute untrusted bytecode"
>>   	---help---
>> diff --git a/arch/arm64/mm/mm.h b/arch/arm64/mm/mm.h
>> index ef47d99..7b0dcc4 100644
>> --- a/arch/arm64/mm/mm.h
>> +++ b/arch/arm64/mm/mm.h
>> @@ -1,3 +1,6 @@
>>   extern void __init bootmem_init(void);
>>
>>   void fixup_init(void);
>> +
>> +void split_pud(pud_t *old_pud, pmd_t *pmd);
>> +void split_pmd(pmd_t *pmd, pte_t *pte);
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 496c3fd..9353e3c 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -73,7 +73,7 @@ static void __init *early_alloc(unsigned long sz)
>>   /*
>>    * remap a PMD into pages
>>    */
>> -static void split_pmd(pmd_t *pmd, pte_t *pte)
>> +void split_pmd(pmd_t *pmd, pte_t *pte)
>>   {
>>   	unsigned long pfn = pmd_pfn(*pmd);
>>   	unsigned long addr = pfn << PAGE_SHIFT;
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index 3571c73..4a95fed 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -15,25 +15,162 @@
>>   #include <linux/module.h>
>>   #include <linux/sched.h>
>>
>> +#include <asm/pgalloc.h>
>>   #include <asm/pgtable.h>
>>   #include <asm/tlbflush.h>
>>
>> -struct page_change_data {
>> -	pgprot_t set_mask;
>> -	pgprot_t clear_mask;
>> -};
>> +#include "mm.h"
>>
>> -static int change_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
>> -			void *data)
>> +static int update_pte_range(struct mm_struct *mm, pmd_t *pmd,
>> +				unsigned long addr, unsigned long end,
>> +				pgprot_t clear, pgprot_t set)
>>   {
>> -	struct page_change_data *cdata = data;
>> -	pte_t pte = *ptep;
>> +	pte_t *pte;
>> +	int err = 0;
>> +
>> +	if (pmd_sect(*pmd)) {
>> +		if (!IS_ENABLED(CONFIG_DEBUG_CHANGE_PAGEATTR)) {
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>> +		pte = pte_alloc_one_kernel(&init_mm, addr);
>> +		if (!pte) {
>> +			err = -ENOMEM;
>> +			goto out;
>> +		}
>> +		split_pmd(pmd, pte);
>> +		__pmd_populate(pmd, __pa(pte), PMD_TYPE_TABLE);
>> +	}
>> +
>> +
>> +	pte = pte_offset_kernel(pmd, addr);
>> +	if (pte_none(*pte)) {
>> +		err = -EFAULT;
>> +		goto out;
>> +	}
>> +
>> +	do {
>> +		pte_t p = *pte;
>> +
>> +		p = clear_pte_bit(p, clear);
>> +		p = set_pte_bit(p, set);
>> +		set_pte(pte, p);
>> +
>> +	} while (pte++, addr += PAGE_SIZE, addr != end);
>> +
>> +out:
>> +	return err;
>> +}
>> +
>> +
>> +static int update_pmd_range(struct mm_struct *mm, pud_t *pud,
>> +				unsigned long addr, unsigned long end,
>> +				pgprot_t clear, pgprot_t set)
>> +{
>> +	pmd_t *pmd;
>> +	unsigned long next;
>> +	int err = 0;
>> +
>> +	if (pud_sect(*pud)) {
>> +		if (!IS_ENABLED(CONFIG_DEBUG_CHANGE_PAGEATTR)) {
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>> +		pmd = pmd_alloc_one(&init_mm, addr);
>> +		if (!pmd) {
>> +			err = -ENOMEM;
>> +			goto out;
>> +		}
>> +		split_pud(pud, pmd);
>> +		pud_populate(&init_mm, pud, pmd);
>> +	}
>> +
>>
>> -	pte = clear_pte_bit(pte, cdata->clear_mask);
>> -	pte = set_pte_bit(pte, cdata->set_mask);
>> +	pmd = pmd_offset(pud, addr);
>> +	if (pmd_none(*pmd)) {
>> +		err = -EFAULT;
>> +		goto out;
>> +	}
>> +
>
> we try to preserve the section area, but the addr | end does not ensure that
> physical memory is alignment. In addtion, if numpages cross section area, and
> addr points to the physical memory is alignment to the section. In this case,
> we should consider to retain the section.
>

I'm not sure what physical memory you are referring to here. The mapping is
already set up so if there is a section mapping we know the physical memory
is going to be set up to be a section size. We aren't setting up a new mapping
for the physical address so there is no need to check that again. The only
way to get the physical address would be to read it out of the section
entry which wouldn't give any more information.

I'm also not sure what you are referring to with numpages crossing a section
area. In update_pud_range and update_pmd_range there are checks if a
section can be used. If it can, it updates. The split action is only called
if it isn't aligned. The loop ensures this will happen across all possible
sections.

Thanks,
Laura
