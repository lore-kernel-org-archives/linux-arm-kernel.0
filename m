From: r.sricharan@ti.com (Sricharan R)
Date: Fri, 15 Mar 2013 20:30:52 +0530
Subject: [PATCH v2 1/1] ARM: LPAE: Fix mapping in alloc_init_pte for
 unaligned addresses.
In-Reply-To: <51433533.3090408@codeaurora.org>
References: <1344238885-13683-1-git-send-email-r.sricharan@ti.com>
 <CAJ7qFSeoyVGie__3mJ8=edeEf7Jh7TQY8vcWgGdOtWVXa8TU0Q@mail.gmail.com>
 <CAJ7qFScGw8oA9y7gjoUTp6xCoLnQti2OXuVqCMrxJUeHDSRENA@mail.gmail.com>
 <CAHkRjk7tensn15DLqsaWbnZ-dfu0VdGQcL=Ha5hybz0SCM8E4g@mail.gmail.com>
 <514230C5.4010502@codeaurora.org> <5142C6AB.7030402@ti.com>
 <51433533.3090408@codeaurora.org>
Message-ID: <514337A4.8060706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013 08:20 PM, Laura Abbott wrote:
> On 3/14/2013 11:58 PM, Sricharan R wrote:
>> Hi,
>> On Friday 15 March 2013 01:49 AM, Laura Abbott wrote:
>>> On 3/13/2013 10:14 PM, Catalin Marinas wrote:
>>>> (sorry for if you got this message twice, gmail's new reply method
>>>> decided to send html)
>>>>
>>>> On 18 September 2012 12:52, R, Sricharan <r.sricharan@ti.com> wrote:
>>>>> Hi,
>>>>> On Fri, Aug 17, 2012 at 4:32 PM, R, Sricharan <r.sricharan@ti.com> wrote:
>>>>>> Hi,
>>>>>>
>>>>>>> With LPAE, When either the start address or end address
>>>>>>> or physical address to be mapped is unaligned,
>>>>>>> alloc_init_section creates page granularity mappings.
>>>>>>> alloc_init_section calls alloc_init_pte which populates
>>>>>>> one pmd entry and sets up the ptes. But if the size is
>>>>>>> greater than what can be mapped by one pmd entry,
>>>>>>> then the rest remains unmapped.
>>>>>>>
>>>>>>> The issue becomes visible when LPAE is enabled, where we have
>>>>>>> the 3 levels with seperate pgd and pmd's.
>>>>>>> When a static mapping for 3MB is requested, only 2MB is mapped
>>>>>>> and the remaining 1MB is unmapped. Fixing this here, by looping
>>>>>>> in to map the entire unaligned address range.
>>>>>>>
>>>>>>> Boot tested on OMAP5 evm with both LPAE enabled/disabled
>>>>>>> and verified that static mappings with unaligned addresses
>>>>>>> are properly mapped.
>>>>>>>
>>>>>>> Signed-off-by: R Sricharan <r.sricharan@ti.com>
>>>>>>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>>> ---
>>>>>>> [V2] Moved the loop to alloc_init_pte as per Russell's
>>>>>>>        feedback and changed the subject accordingly.
>>>>>>>        Using PMD_XXX instead of SECTION_XXX to avoid
>>>>>>>        different loop increments with/without LPAE.
>>>>>>>
>>>>>>>    arch/arm/mm/mmu.c |   22 ++++++++++++++++++----
>>>>>>>    1 file changed, 18 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>>>>>>> index cf4528d..0ed8808 100644
>>>>>>> --- a/arch/arm/mm/mmu.c
>>>>>>> +++ b/arch/arm/mm/mmu.c
>>>>>>> @@ -585,11 +585,25 @@ static void __init alloc_init_pte(pmd_t *pmd, unsigned long addr,
>>>>>>>                                     unsigned long end, unsigned long pfn,
>>>>>>>                                     const struct mem_type *type)
>>>>>>>    {
>>>>>>> -       pte_t *pte = early_pte_alloc(pmd, addr, type->prot_l1);
>>>>>>> +       unsigned long next;
>>>>>>> +       pte_t *pte;
>>>>>>> +       phys_addr_t phys;
>>>>>>> +
>>>>>>>           do {
>>>>>>> -               set_pte_ext(pte, pfn_pte(pfn, __pgprot(type->prot_pte)), 0);
>>>>>>> -               pfn++;
>>>>>>> -       } while (pte++, addr += PAGE_SIZE, addr != end);
>>>>>>> +               if ((end-addr) & PMD_MASK)
>>>>>>> +                       next = (addr + PMD_SIZE) & PMD_MASK;
>>>>>>> +               else
>>>>>>> +                       next = end;
>>>>>>> +
>>>>>>> +               pte = early_pte_alloc(pmd, addr, type->prot_l1);
>>>>>>> +               do {
>>>>>>> +                       set_pte_ext(pte, pfn_pte(pfn,
>>>>>>> +                                       __pgprot(type->prot_pte)), 0);
>>>>>>> +                       pfn++;
>>>>>>> +               } while (pte++, addr += PAGE_SIZE, addr != next);
>>>>>>> +
>>>>>>> +               phys += next - addr;
>>>>>>> +       } while (pmd++, addr = next, addr != end);
>>>>>>>    }
>>>>>>>
>>>>>>     ping..
>>>>>
>>>>>     Ping again.
>>>>>     The issue is reproducible in mainline with CMA + LPAE enabled.
>>>>>     CMA tries to reserve/map 16 MB with 2 level table entries and
>>>>>      crashes in alloc_init_pte.
>>>>>
>>>>>     This patch fixes that. Just posted a V3 of the same patch.
>>>>>
>>>>>            https://patchwork.kernel.org/patch/1472031/
>>>>
>>>> I thought there was another patch where the looping was in an
>>>> alloc_init_pmd() function, or there are just two different threads. I
>>>> acked the other but not this one as I don't think looping over pmd
>>>> inside the alloc_init_pte() function is the right thing.
>>>>
>>>
>>> I submitted a patch last week for what I think is the same issue ("arm: mm: Populate initial page tables across sections") but I don't think I ever saw any feedback on the patch. Do we have three patches floating around fixing the same issue?
>>>
>>> Laura
>>>
>>   your patch is looking like the intial version that i posted. So after some reviews,
>>   finally ended up with the below patch [1]. Can you please check if your issue gets
>>   fixed with this.
>>
>>   [1] http://permalink.gmane.org/gmane.linux.ports.arm.kernel/216880
>>
> 
> The patch does fix the problem for me as well. You are welcome to add
> 
> Tested-by Laura Abbott <lauraa@codeaurora.org>
> 
 Thanks for testing and will add .

Regards,
 Sricharan
