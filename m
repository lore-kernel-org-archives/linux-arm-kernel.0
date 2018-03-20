From: cpandya@codeaurora.org (Chintan Pandya)
Date: Tue, 20 Mar 2018 12:34:20 +0530
Subject: [PATCH v3 1/3] ioremap: Update pgtable free interfaces with addr
In-Reply-To: <1521486096.2693.202.camel@hpe.com>
References: <1521463256-19858-1-git-send-email-cpandya@codeaurora.org>
 <1521463256-19858-2-git-send-email-cpandya@codeaurora.org>
 <1521486096.2693.202.camel@hpe.com>
Message-ID: <472bb600-9387-7fc7-3a2e-26579d785ce6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 3/20/2018 12:31 AM, Kani, Toshi wrote:
> On Mon, 2018-03-19 at 18:10 +0530, Chintan Pandya wrote:
>> This patch ("mm/vmalloc: Add interfaces to free unmapped
>> page table") adds following 2 interfaces to free the page
>> table in case we implement huge mapping.
>>
>> pud_free_pmd_page() and pmd_free_pte_page()
>>
>> Some architectures (like arm64) needs to do proper TLB
>> maintanance after updating pagetable entry even in map.
>> Why ? Read this,
>> https://patchwork.kernel.org/patch/10134581/
>>
>> Pass 'addr' in these interfaces so that proper TLB ops
>> can be performed.
>>
>> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
>   :
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index 34cda7e..20b0322 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -710,7 +710,7 @@ int pmd_clear_huge(pmd_t *pmd)
>>    * Context: The pud range has been unmaped and TLB purged.
>>    * Return: 1 if clearing the entry succeeded. 0 otherwise.
>>    */
>> -int pud_free_pmd_page(pud_t *pud)
>> +int pud_free_pmd_page(pud_t *pud, unsigned long addr)
> 
> Please update the function header as well.  Same for pmd.
> 
> + * @addr: Virtual address associated with pud.
Noted.
> 
> --- a/include/asm-generic/pgtable.h
>> +++ b/include/asm-generic/pgtable.h
>> @@ -983,8 +983,8 @@ static inline int p4d_clear_huge(p4d_t *p4d)
>>   int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot);
>>   int pud_clear_huge(pud_t *pud);
>>   int pmd_clear_huge(pmd_t *pmd);
>> -int pud_free_pmd_page(pud_t *pud);
>> -int pmd_free_pte_page(pmd_t *pmd);
>> +int pud_free_pmd_page(pud_t *pud, unsigned long addr);
>> +int pmd_free_pte_page(pmd_t *pmd, unsigned long addr);
>>   #else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
>>   static inline int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t
> prot)
>>   {
>> @@ -1010,11 +1010,11 @@ static inline int pmd_clear_huge(pmd_t *pmd)
>>   {
>>   	return 0;
>>   }
>> -static inline int pud_free_pmd_page(pud_t *pud)
>> +static inline int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>>   {
>>   	return 0;
>>   }
>> -static inline int pmd_free_pte_page(pud_t *pmd)
>> +static inline int pmd_free_pte_page(pud_t *pmd, unsigned long addr)
> 
> Please base your patches on top of the mm tree or at least pick up
> 8cab93de994f6 in the mm tree.  Andrew fixed the typo; the 'pud_t' above
> should have been 'pmd_t'.

Right. Noted.

> 
> Thanks,
> -Toshi
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
