From: zhichang.yuan@linaro.org (zhichang.yuan)
Date: Sat, 29 Nov 2014 10:20:55 +0800
Subject: [PATCH] arm64:mm: free the useless initial page table
In-Reply-To: <20141127122627.GH11511@e104818-lin.cambridge.arm.com>
References: <1416558460-7257-1-git-send-email-zhichang.yuan@linaro.org>
 <20141124143208.GE15872@e104818-lin.cambridge.arm.com>
 <5474951F.8050809@linaro.org>
 <20141127122627.GH11511@e104818-lin.cambridge.arm.com>
Message-ID: <54792D87.8080809@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2014?11?27? 20:26, Catalin Marinas wrote:
> On Tue, Nov 25, 2014 at 02:41:35PM +0000, zhichang.yuan wrote:
>> On 2014?11?24? 22:32, Catalin Marinas wrote:
>>> On Fri, Nov 21, 2014 at 08:27:40AM +0000, zhichang.yuan at linaro.org wrote:
>>>> From: "zhichang.yuan" <zhichang.yuan@linaro.org>
>>>>
>>>> For 64K page system, after mapping a PMD section, the corresponding initial
>>>> page table is not needed any more. That page can be freed.
>>>>
>>>> Signed-off-by: Zhichang Yuan <zhichang.yuan@linaro.org>
>>>> ---
>>>>  arch/arm64/mm/mmu.c |    5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index f4f8b50..12a336b 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -191,8 +191,11 @@ static void __init alloc_init_pmd(pud_t *pud, unsigned long addr,
>>>>  			 * Check for previous table entries created during
>>>>  			 * boot (__create_page_tables) and flush them.
>>>>  			 */
>>>> -			if (!pmd_none(old_pmd))
>>>> +			if (!pmd_none(old_pmd)) {
>>>>  				flush_tlb_all();
>>>> +				if (pmd_table(old_pmd))
>>>> +					memblock_free(pte_pfn(pmd_pte(old_pmd)) << PAGE_SHIFT, PAGE_SIZE);
>>>> +			}
>>> For consistency with alloc_init_pud(), could you do:
>>>
>>> 	phys_addr_t table = __pa(pte_offset(&old_pmd, 0));
>>> 	memblock_free(table, PAGE_SIZE);
>> Just as Laura comments, the pte_offset will convert the PA to VA, and
>> then convert  VA to PA. It seems to be verbose. That is why i use
>> pte_pfn. Anyway, the consistency is better, i will revise it.
>>
>>> Since you are at this, for alloc_init_pud() could you please move the
>>> flush_tlb_all() before memblock_free()? Theoretical problem really but
>>> it's nice for consistency.
>> As for this issue, i have a small question.  Since the new PMD entry
>> had been set by set_pmd, why not do the tlb flush as soon as we can?
> So we need to flush the tlb shortly _after_ the new PMD or PUD has been
> set to guarantee that a TLB load will see the new page table value. In
> theory, we also need to flush it _before_ the old one is freed in case
> the freed page is used by some other CPU (not a problem for boot code)
> or some debug code poisons the freed page with a value that happens to
> match a valid translation.
>
I misunderstood your comment before. I thought you ask me to make alloc_init_pmd consistent to alloc_init_pud.
sorry for that!

I will adjust the line sequence in alloc_init_pud too.

Thanks!
