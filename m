From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 29 Oct 2014 15:23:05 -0700
Subject: [PATCH v0] ARMv8:mm:Support the DEBUG_PAGEALLOC
In-Reply-To: <544F338A.2060600@linaro.org>
References: <1414382488-916-1-git-send-email-zhichang.yuan@linaro.org>
 <544EC65E.4060009@codeaurora.org> <544F338A.2060600@linaro.org>
Message-ID: <545168C9.4010206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 11:11 PM, zhichang.yuan wrote:
> Hi, Laura,
>
> Thanks for your comments!
>
>
>
...
>>> +}
>>> +
>>> +void kernel_map_pages(struct page *page, int numpages, int enable)
>>> +{
>>> +    unsigned long start_addr, end_addr, addr;
>>> +    unsigned int level;
>>> +
>>> +    pte_t *kpte;
>>> +    pteval_t old_pval, new_pval;
>>> +
>>> +    int i, counter = 0;
>>> +
>>> +    /*no highmem in ARMv8. */
>>> +    addr = start_addr = (unsigned long)page_address(page);
>>> +    end_addr = start_addr + (numpages << PAGE_SHIFT);
>>> +
>>> +    for (i = 0; i < numpages; addr += PAGE_SIZE, i++) {
>>> +        kpte = lookup_kaddress(addr, &level);
>>> +        /*
>>> +        * skip the memory holes. it is impossible if the input
>>> +        * parameter is valid.
>>> +        */
>>> +        if (unlikely(!kpte || pte_none(*kpte))) {
>>> +            pr_err("Have no kernel linear mapping for 0x%0lx\n", addr);
>>> +            break;
>>> +        }
>>> +
>>> +        if (level != PG_LEVEL_PAGE) {
>>> +            pr_err("Page entry for 0x%0lx is not PAGE LEVEL(%d)\n",
>>> +                addr, level);
>>> +            break;
>>> +        }
>>> +
>>> +        old_pval = pte_val(*kpte);
>>> +        new_pval = (enable) ? (old_pval | PTE_VALID) :
>>> +            (old_pval & (~PTE_VALID));
>>> +        if (unlikely(new_pval == old_pval)) {
>>> +            pr_warn("Page %s: same pte value at 0x%llx",
>>> +                (enable) ? "alloc" : "free", old_pval);
>>> +            continue;
>>> +        }
>>> +
>>> +        set_pte(kpte, __pte(new_pval));
>>> +        counter++;
>>> +    }
>>> +
>>> +    if (counter)
>>> +        flush_tlb_kernel_range(start_addr, end_addr);
>>> +}
>>
>> We already have some of this infrastructure to set page attributes
>> in arch/arm64/mm/pageattr.c . We should be leveraging that for
>> kernel_map_pages.
>>
> There is no pageattr.c for ARMv8. In X86, it exists.
> Do you mean pmd_modify?
>

It was added to the kernel fairly recently

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=11d91a770f1fff44dafdf88d6089a3451f99c9b6


Thanks,
Laura


-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
