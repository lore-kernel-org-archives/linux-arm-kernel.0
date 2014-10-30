From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 30 Oct 2014 10:12:34 -0700
Subject: [PATCHv4 7/7] arm64: add better page protections to arm64
In-Reply-To: <20141028112949.GA7978@linaro.org>
References: <1414440752-9411-1-git-send-email-lauraa@codeaurora.org>
 <1414440752-9411-8-git-send-email-lauraa@codeaurora.org>
 <20141028112949.GA7978@linaro.org>
Message-ID: <54527182.7040702@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2014 4:29 AM, Steve Capper wrote:
> On Mon, Oct 27, 2014 at 01:12:32PM -0700, Laura Abbott wrote:
>> Add page protections for arm64 similar to those in arm.
>> This is for security reasons to prevent certain classes
>> of exploits. The current method:
>>
>> - Map all memory as either RWX or RW. We round to the nearest
>>    section to avoid creating page tables before everything is mapped
>> - Once everything is mapped, if either end of the RWX section should
>>    not be X, we split the PMD and remap as necessary
>> - When initmem is to be freed, we change the permissions back to
>>    RW (using stop machine if necessary to flush the TLB)
>> - If CONFIG_DEBUG_RODATA is set, the read only sections are set
>>    read only.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>
> Hi Laura,
> I have some comments below.
>
...
>> @@ -156,29 +195,52 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
>>   	} while (pte++, addr += PAGE_SIZE, addr != end);
>>   }
>>
>> -static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>> +void __ref split_pud(pud_t *old_pud, pmd_t *pmd)
>> +{
>> +	unsigned long pfn = pud_pfn(*old_pud);
>> +        const pmdval_t mask = PMD_SECT_USER | PMD_SECT_PXN | PMD_SECT_UXN |
>> +                              PMD_SECT_RDONLY | PMD_SECT_PROT_NONE |
>> +                              PMD_SECT_VALID;
>> +	pgprot_t prot = __pgprot(pud_val(*old_pud) & mask);
>
> This looks a little fragile, if I've understood things correctly then
> all we want to do is create a set of pmds with the same pgprot_t as the
> original pud?
>
> In that case it would probably be easier to simply mask out the pfn
> from our pud to create the pgprot rather than mask in a set of
> attributes (that may change in future)?
>

Good suggestion. I'll check that in the next version.

>> +	int i = 0;
>> +
>> +	do {
>> +		set_pmd(pmd, pfn_pmd(pfn, prot));
>> +		pfn++;
>> +	} while (pmd++, i++, i < PTRS_PER_PMD);
>> +}
>> +
>> +static void __ref alloc_init_pmd(pud_t *pud, unsigned long addr,
>>   				  unsigned long end, phys_addr_t phys,
>> -				  int map_io)
>> +				  pgprot_t sect_prot, pgprot_t pte_prot,
>> +				  bool early, int map_io)
>>   {
>>   	pmd_t *pmd;
>>   	unsigned long next;
>> -	pmdval_t prot_sect;
>> -	pgprot_t prot_pte;
>>
>>   	if (map_io) {
>> -		prot_sect = PROT_SECT_DEVICE_nGnRE;
>> -		prot_pte = __pgprot(PROT_DEVICE_nGnRE);
>> -	} else {
>> -		prot_sect = PROT_SECT_NORMAL_EXEC;
>> -		prot_pte = PAGE_KERNEL_EXEC;
>> +		sect_prot = PROT_SECT_DEVICE_nGnRE;
>> +		pte_prot = __pgprot(PROT_DEVICE_nGnRE);
>>   	}
>
> I think we should wipe out map_io from all these functions as it's
> causing too much complexity. It's enough to have just sect_prot and
> pte_prot. I posted some similar feedback to Ard:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/296918.html
>

Sounds fine. I think my series would conflict with Ard's so I should
give that series a review and see if it makes sense to base this
series off of that series. Part of this work might also be relevent
for adding DEBUG_PAGEALLOC for arm64 so I might split that out into
a separate patch as well.

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
