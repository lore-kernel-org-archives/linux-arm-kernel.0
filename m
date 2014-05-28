From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 28 May 2014 10:59:51 -0700
Subject: [PATCH v6 3/4] live migration support for VM dirty log management
In-Reply-To: <20140528090834.GK16428@lvm>
References: <1400178451-4984-1-git-send-email-m.smarduch@samsung.com>
 <1400178451-4984-4-git-send-email-m.smarduch@samsung.com>
 <20140527201244.GC16428@lvm> <538509C9.8070403@samsung.com>
 <20140528090834.GK16428@lvm>
Message-ID: <53862417.9040107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2014 02:08 AM, Christoffer Dall wrote:
> On Tue, May 27, 2014 at 02:55:21PM -0700, Mario Smarduch wrote:
>> On 05/27/2014 01:12 PM, Christoffer Dall wrote:
>>> On Thu, May 15, 2014 at 11:27:30AM -0700, Mario Smarduch wrote:
> 
> [...]
> 
>>>> +
>>>> +	/* If pgd, pud, pmd not present and you cross pmd range check next
>>>> +	 * index.
>>>> +	 */
>>>> +	pgd = pgdp + pgd_index(ipa);
>>>> +	if (unlikely(crosses_pmd && !pgd_present(*pgd))) {
>>>> +		pgd = pgdp + pgd_index(next);
>>>> +		if (!pgd_present(*pgd))
>>>> +			return;
>>>> +	}
>>>> +
>>>> +	pud = pud_offset(pgd, ipa);
>>>> +	if (unlikely(crosses_pmd && !pud_present(*pud))) {
>>>> +		pud = pud_offset(pgd, next);
>>>> +		if (!pud_present(*pud))
>>>> +			return;
>>>> +	}
>>>> +
>>>> +	pmd = pmd_offset(pud, ipa);
>>>> +	if (unlikely(crosses_pmd && !pmd_present(*pmd))) {
>>>> +		pmd = pmd_offset(pud, next);
>>>> +		if (!pmd_present(*pmd))
>>>> +			return;
>>>> +	}
>>>> +
>>>> +	for (;;) {
>>>> +		pte = pte_offset_kernel(pmd, ipa);
>>>> +		if (!pte_present(*pte))
>>>> +			goto next_ipa;
>>>> +
>>>> +		if (kvm_s2pte_readonly(pte))
>>>> +			goto next_ipa;
>>>> +		kvm_set_s2pte_readonly(pte);
>>>> +next_ipa:
>>>> +		mask &= mask - 1;
>>>> +		if (!mask)
>>>> +			break;
>>>> +
>>>> +		/* find next page */
>>>> +		ipa = (gfnofst + __ffs(mask)) << PAGE_SHIFT;
>>>> +
>>>> +		/* skip upper page table lookups */
>>>> +		if (!crosses_pmd)
>>>> +			continue;
>>>> +
>>>> +		pgd = pgdp + pgd_index(ipa);
>>>> +		if (unlikely(!pgd_present(*pgd)))
>>>> +			goto next_ipa;
>>>> +		pud = pud_offset(pgd, ipa);
>>>> +		if (unlikely(!pud_present(*pud)))
>>>> +			goto next_ipa;
>>>> +		pmd = pmd_offset(pud, ipa);
>>>> +		if (unlikely(!pmd_present(*pmd)))
>>>> +			goto next_ipa;
>>>> +	}
>>>
>>> So I think the reason this is done separately on x86 is that they have
>>> an rmap structure for their gfn mappings so that they can quickly lookup
>>> ptes based on a gfn and write-protect it without having to walk the
>>> stage-2 page tables.
>>
>> Yes, they also use rmapps for mmu notifiers, invalidations on huge VMs and 
>> large ranges resulted in excessive times. 
>>>
>>> Unless you want to introduce this on ARM, I think you will be much
>>
>> Eventually yes but that would also require reworking mmu notifiers.  I had 
>> two step approach in mind. Initially get the dirty page marking to work, 
>> TLB flushing, GIC/arch-timer migration, validate migration under various 
>> stress loads (page reclaim) with mmu notifiers, test several VMs and migration 
>> times. 
>>
>> Then get rmapp (or something similar) working - eventually for huge VMs it's
>> needed. In short two phases.
>>
>>> better off just having a single (properly written) iterating
>>> write-protect function, that takes a start and end IPA and a bitmap for
>>> which pages to actually write-protect, which can then handle the generic
>>> case (either NULL or all-ones bitmap) or a specific case, which just
>>> traverses the IPA range given as input.  Such a function should follow
>>> the model of page table walk functions discussed previously
>>> (separate functions: wp_pgd_enties(), wp_pud_entries(),
>>> wp_pmd_entries(), wp_pte_entries()).
>>>
>>> However, you may want to verify my assumption above with the x86 people
>>> and look at sharing the rmap logic between architectures.
>>>
>>> In any case, this code is very difficult to read and understand, and it
>>> doesn't look at all like the other code we have to walk page tables.  I
>>> understand you are trying to optimize for performance (by skipping some
>>> intermediate page table level lookups), but you never declare that goal
>>> anywhere in the code or in the commit message.
>>
>> Marc's comment noticed I was walking a small range (128k), using upper table
>> iterations that covered 1G, 2MB ranges. As you mention the code tries to
>> optimize upper table lookups. Yes the function is too bulky, but I'm not sure how 
>> to remove the upper table checks since page tables may change between the 
>> time pages are marked dirty and the log is retrieved. And if a memory slot 
>> is very dirty walking upper tables will impact performance. I'll think some 
>> more on this function.
>>
> I think you should aim at the simplest possible implementation that
> functionally works, first.  Let's verify that this thing works, have
> clean working code that implementation-wise is as minimal as possible.
> 
> Then we can run perf on that and see if our migrations are very slow,
> where we are actually spending time, and only then optimize it.
> 
> The solution to this specific problem for the time being appears quite
> clear to me: Follow the exact same scheme as for unmap_range (the one I
> sent out here:
> https://lists.cs.columbia.edu/pipermail/kvmarm/2014-May/009592.html, the
> diff is hard to read, so I recommend you apply the patch and look at the
> resulting code).  Have a similar scheme, call it wp_ipa_range() or
> something like that, and use that for now.

Ok I'll reuse that code. I'll need to apply that patch given I need
to test various host conditions during migration.

> 
> -Christoffer
> 
