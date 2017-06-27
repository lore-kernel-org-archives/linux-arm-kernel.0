From: opendmb@gmail.com (Doug Berger)
Date: Tue, 27 Jun 2017 09:57:17 -0700
Subject: [PATCH] ARM: memblock limit must be pmd-aligned
In-Reply-To: <20170627105912.GE30002@leverpostej>
References: <20170626172315.26369-1-opendmb@gmail.com>
 <48116220-b89b-7413-ea62-c78dfb0594a2@redhat.com>
 <129544df-5461-a877-84c9-9889bd5e9dc0@gmail.com>
 <20170627105912.GE30002@leverpostej>
Message-ID: <b55726c8-0e36-fa50-78cb-6e488ef9bf31@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2017 03:59 AM, Mark Rutland wrote:
> On Mon, Jun 26, 2017 at 05:50:03PM -0700, Doug Berger wrote:
>> On 06/26/2017 04:43 PM, Laura Abbott wrote:
>>> On 06/26/2017 10:23 AM, Doug Berger wrote:
>>>> There is a path through the adjust_lowmem_bounds() routine where if all
>>>> memory regions start and end on pmd-aligned addresses the memblock_limit
>>>> will be set to arm_lowmem_limit.
>>>>
>>>> However, since arm_lowmem_limit can be affected by the vmalloc early
>>>> parameter, the value of arm_lowmem_limit may not be pmd-aligned. This
>>>> commit corrects this oversight such that memblock_limit is always rounded
>>>> down to pmd-alignment.
>>>>
>>>> The pmd containing arm_lowmem_limit is cleared by prepare_page_table()
>>>> and without this commit it is possible for early_alloc() to allocate
>>>> unmapped memory in that range when mapping the lowmem.
>>>>
>>>
>>> Do you have an example system or configuration where you see this
>>> crash?
>> I have observed this crash occur on systems like the bcm7445 when a
>> customer uses the vmalloc boot parameter to specify an odd number of
>> Megabytes of VMALLOC space (e.g. vmalloc=751m).  This seems to be a
>> popular way for them to set the low memory boundary.
>>
>> As long as vmalloc is a multiple of the pmd (e.g. 2MB) there isn't a
>> problem, so documenting this constraint is another possible solution.
>> However, educating the user is more difficult in this case than working
>> around a questionable value to allow the boot to succeed.
> 
> It sounds like this leads to the same issue as we tried to fix in
> commit:
> 
>   965278dcb8ab0b1f ("ARM: 8356/1: mm: handle non-pmd-aligned end of RAM")
> 
> ... where with !LPAE page tables, we don't map the last section (as we
> can't map the whole PMD containig it), but arm_lowmem_limit doesn't
> account for this, and we try to access memroy from the unmapped section,
> blowing up.
> 
> We're just failing to account for this where we don't have an inital
> memblock_limit.
> 
That is exactly right.

>>
>> -Doug
>>>
>>> Thanks,
>>> Laura
>>>
>>>> Signed-off-by: Doug Berger <opendmb@gmail.com>
>>>> ---
>>>>  arch/arm/mm/mmu.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>>>> index 31af3cb59a60..2ae4f9c9d757 100644
>>>> --- a/arch/arm/mm/mmu.c
>>>> +++ b/arch/arm/mm/mmu.c
>>>> @@ -1226,7 +1226,7 @@ void __init adjust_lowmem_bounds(void)
>>>>  	if (memblock_limit)
>>>>  		memblock_limit = round_down(memblock_limit, PMD_SIZE);
>>>>  	if (!memblock_limit)
>>>> -		memblock_limit = arm_lowmem_limit;
>>>> +		memblock_limit = round_down(arm_lowmem_limit, PMD_SIZE);
>>>>  
> 
> Given we're always going to do the rounding, how about we move that out
> of the existing conditional, i.e. get rid of the first if, and have:
> 
> 	if (!memblock_limit)
> 		memblock_limit = arm_lowmem_limit;
> 
> 	/*
> 	 * Round the memblock limit down to a pmd size.  This
> 	 * helps to ensure that we will allocate memory from the
> 	 * last full pmd, which should be mapped.
> 	 */
> 	memblock_limit = round_down(memblock_limit, PMD_SIZE);
> 
> Thanks,
> Mark.
That makes perfect sense to me.  I will submit a v2 with this code
change.  Should I add your Signed-off-by since it is your change?

Thanks!
    Doug
