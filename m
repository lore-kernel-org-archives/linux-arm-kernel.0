From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 18 Dec 2014 14:48:10 -0800
Subject: [PATCH v0] ARMv8:mm:Support the DEBUG_PAGEALLOC
In-Reply-To: <5490E123.8060904@linaro.org>
References: <1414382488-916-1-git-send-email-zhichang.yuan@linaro.org>
 <544EC65E.4060009@codeaurora.org> <544F338A.2060600@linaro.org>
 <545168C9.4010206@codeaurora.org> <5490E123.8060904@linaro.org>
Message-ID: <549359AA.8000006@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/16/2014 5:49 PM, zhichang.yuan wrote:
> Hi, Laura,
>
>
> On 2014?10?30? 06:23, Laura Abbott wrote:
>> On 10/27/2014 11:11 PM, zhichang.yuan wrote:
>>> Hi, Laura,
>>>
>>> Thanks for your comments!
>>>
>>>
>>>
>> ...
>>>>> +}
>>>>> +
>>>>> +void kernel_map_pages(struct page *page, int numpages, int enable)
>>>>> +{
>>>>> +    unsigned long start_addr, end_addr, addr;
>>>>> +    unsigned int level;
>>>>> +
>>>>> +    pte_t *kpte;
>>>>> +    pteval_t old_pval, new_pval;
>>>>> +
>>>>> +    int i, counter = 0;
>>>>> +
>>>>> +    /*no highmem in ARMv8. */
>>>>> +    addr = start_addr = (unsigned long)page_address(page);
>>>>> +    end_addr = start_addr + (numpages << PAGE_SHIFT);
>>>>> +
>>>>> +    for (i = 0; i < numpages; addr += PAGE_SIZE, i++) {
>>>>> +        kpte = lookup_kaddress(addr, &level);
>>>>> +        /*
>>>>> +        * skip the memory holes. it is impossible if the input
>>>>> +        * parameter is valid.
>>>>> +        */
>>>>> +        if (unlikely(!kpte || pte_none(*kpte))) {
>>>>> +            pr_err("Have no kernel linear mapping for 0x%0lx\n", addr);
>>>>> +            break;
>>>>> +        }
>>>>> +
>>>>> +        if (level != PG_LEVEL_PAGE) {
>>>>> +            pr_err("Page entry for 0x%0lx is not PAGE LEVEL(%d)\n",
>>>>> +                addr, level);
>>>>> +            break;
>>>>> +        }
>>>>> +
>>>>> +        old_pval = pte_val(*kpte);
>>>>> +        new_pval = (enable) ? (old_pval | PTE_VALID) :
>>>>> +            (old_pval & (~PTE_VALID));
>>>>> +        if (unlikely(new_pval == old_pval)) {
>>>>> +            pr_warn("Page %s: same pte value at 0x%llx",
>>>>> +                (enable) ? "alloc" : "free", old_pval);
>>>>> +            continue;
>>>>> +        }
>>>>> +
>>>>> +        set_pte(kpte, __pte(new_pval));
>>>>> +        counter++;
>>>>> +    }
>>>>> +
>>>>> +    if (counter)
>>>>> +        flush_tlb_kernel_range(start_addr, end_addr);
>>>>> +}
>>>>
>>>> We already have some of this infrastructure to set page attributes
>>>> in arch/arm64/mm/pageattr.c . We should be leveraging that for
>>>> kernel_map_pages.
>>>>
>>> There is no pageattr.c for ARMv8. In X86, it exists.
>>> Do you mean pmd_modify?
>>>
>>
>> It was added to the kernel fairly recently
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=11d91a770f1fff44dafdf88d6089a3451f99c9b6
>>
>
> I browsed the pageattr.c, the functions which modify the page table entry attributes are good. But the base
> function, change_memory_common, is limited for module memory space. It will make the relative functions are
> not common. Can we do some changes on it?
>
> thanks,
> -Zhichang
>

Yes, we should be able to adjust the bounds check there. The
checks there are currently broken[1] anyways. I'd suggest
changing it to something like this (to be folded in)

----8<----

 From 8cc4cd7c72fc5ada01e44d943d00e0209c4304aa Mon Sep 17 00:00:00 2001
From: Laura Abbott <lauraa@codeaurora.org>
Date: Thu, 18 Dec 2014 14:45:19 -0800
Subject: [PATCH] arm64: Update set memory_bounds_check

Change-Id: Id2f308c44d49117aca18fe725f8f2f33ae6a5075
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
  arch/arm64/mm/pageattr.c | 9 +++++++--
  1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index bb0ea94..0516cbc 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -51,8 +51,13 @@ static int change_memory_common(unsigned long addr, int numpages,
  		WARN_ON_ONCE(1);
  	}
  
-	if (!is_module_address(start) || !is_module_address(end - 1))
-		return -EINVAL;
+	if (!IS_ENABLED(DEBUG_PAGEALLOC)) {
+		if (start < MODULES_VADDR || start >= MODULES_END)
+			return -EINVAL;
+
+		if (end < MODULES_VADDR || end >= MODULES_END)
+			return -EINVAL;
+	}
  
  	data.set_mask = set_mask;
  	data.clear_mask = clear_mask;

--
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/307839.html  
--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
