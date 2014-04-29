From: ddutile@redhat.com (Don Dutile)
Date: Tue, 29 Apr 2014 10:34:40 -0400
Subject: [PATCH] Fix for the arm64 kern_addr_valid() function
In-Reply-To: <20140429142542.GI17007@arm.com>
References: <1397584404-28762-1-git-send-email-anderson@redhat.com>
 <20140416075144.GA29754@arm.com> <20140429142542.GI17007@arm.com>
Message-ID: <535FB880.6040601@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2014 10:25 AM, Catalin Marinas wrote:
> On Wed, Apr 16, 2014 at 08:51:44AM +0100, Will Deacon wrote:
>> On Tue, Apr 15, 2014 at 06:53:24PM +0100, Dave Anderson wrote:
>>>   Fix for the arm64 kern_addr_valid() function to recognize
>>>   virtual addresses in the kernel logical memory map.  The
>>>   function fails as written because it does not check whether
>>>   the addresses in that region are mapped at the pmd level to
>>>   2MB or 512MB pages, continues the page table walk to the
>>>   pte level, and issues a garbage value to pfn_valid().
>>>
>>>   Tested on 4K-page and 64K-page kernels.
>>>
>>> Signed-off-by: Dave Anderson <anderson@redhat.com>
>>> ---
>>>   arch/arm64/mm/mmu.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 6b7e895..0a472c4 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -374,6 +374,9 @@ int kern_addr_valid(unsigned long addr)
>>>   	if (pmd_none(*pmd))
>>>   		return 0;
>>>
>>> +	if (pmd_sect(*pmd))
>>> +		return pfn_valid(pmd_pfn(*pmd));
>>> +
>>>   	pte = pte_offset_kernel(pmd, addr);
>>>   	if (pte_none(*pte))
>>>   		return 0;
>>
>> Whilst this patch looks fine to me, I wonder whether walking the page tables
>> is really necessary for this function? The only user is fs/proc/kcore.c,
>> which basically wants to know if a lowmem address is actually backed by
>> physical memory. Our current implementation of kern_addr_valid will return
>> true even for MMIO mappings,
>
> There is still a pfn_valid() check, so MMIO mappings wouldn't return
> true.
>
>> whilst I think we could actually just do
>> something like:
>>
>>
>> 	if ((((long)addr) >> VA_BITS) != -1UL)
>> 		return 0;
>>
>> 	return pfn_valid(__pa(addr) >> PAGE_SHIFT);
>>
>> Am I missing something here?
>
> __pa(addr) isn't valid for vmalloc/ioremap addresses (which would pass
> the VA_BITS test above).
>
> I would go with Dave's original patch for now. We've discussing change
> the memory map a bit for the kernel at some point in the future with
> PHYS_OFFSET always 0 and the kernel text/data mapped at a different
> address from PAGE_OFFSET (similar to x86_64). If we get there, this
> function would work unmodified.
>
+1.
I would prefer Dave's cleaner solution that is not dependent on
current assumptions.
