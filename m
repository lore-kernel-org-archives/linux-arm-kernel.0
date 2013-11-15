From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Nov 2013 16:59:53 +0000
Subject: [PATCH] arm/arm64: KVM: introduce new mapping API for percpu
 mappings
In-Reply-To: <20131115164340.GC26376@cbox>
References: <1384530008-18181-1-git-send-email-marc.zyngier@arm.com>
 <20131115161004.GA25051@cbox> <52864CC3.2050201@arm.com>
 <20131115164340.GC26376@cbox>
Message-ID: <52865309.4090203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/13 16:43, Christoffer Dall wrote:
> On Fri, Nov 15, 2013 at 04:33:07PM +0000, Marc Zyngier wrote:
>> On 15/11/13 16:10, Christoffer Dall wrote:
>>> On Fri, Nov 15, 2013 at 03:40:08PM +0000, Marc Zyngier wrote:
>>>> Using virt_to_phys on percpu mappings is horribly wrong (my own bad).
>>>> Thankfully, the kernel offers a way to obtain the physical address
>>>> of such a mapping.
>>>>
>>>> Add a new create_hyp_percpu_mappings function to deal with those.
>>>>
>>>> Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>
>>>
>>> So, I find this nicer, somehow, what do you think:
>>>
>>>
>>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>>> index 3719583..dd531ba 100644
>>> --- a/arch/arm/kvm/mmu.c
>>> +++ b/arch/arm/kvm/mmu.c
>>> @@ -334,6 +334,15 @@ out:
>>>  	return err;
>>>  }
>>>  
>>> +static phys_addr_t kvm_kaddr_to_phys(void *kaddr)
>>> +{
>>> +	if (!is_vmalloc_addr(kaddr))
>>> +		return __pa(kaddr);
>>> +	else
>>> +		return page_to_phys(vmalloc_to_page(kaddr)) +
>>> +		       offset_in_page(kaddr);
>>> +}
>>> +
>>>  /**
>>>   * create_hyp_mappings - duplicate a kernel virtual address range in Hyp mode
>>>   * @from:	The virtual kernel start address of the range
>>> @@ -345,16 +354,24 @@ out:
>>>   */
>>>  int create_hyp_mappings(void *from, void *to)
>>>  {
>>> -	unsigned long phys_addr = virt_to_phys(from);
>>> +	phys_addr_t phys_addr;
>>> +	unsigned long virt_addr;
>>>  	unsigned long start = KERN_TO_HYP((unsigned long)from);
>>>  	unsigned long end = KERN_TO_HYP((unsigned long)to);
>>>  
>>> -	/* Check for a valid kernel memory mapping */
>>> -	if (!virt_addr_valid(from) || !virt_addr_valid(to - 1))
>>> -		return -EINVAL;
>>> +	for (virt_addr = start; virt_addr < end; virt_addr += PAGE_SIZE) {
>>> +		int err;
>>>  
>>> -	return __create_hyp_mappings(hyp_pgd, start, end,
>>> -				     __phys_to_pfn(phys_addr), PAGE_HYP);
>>> +		phys_addr = kvm_kaddr_to_phys(from + virt_addr - start);
>>> +		err = __create_hyp_mappings(hyp_pgd, virt_addr,
>>> +					    virt_addr + PAGE_SIZE,
>>
>> I think I've introduced a bug here. It probably should read:
>>
>> 	err = __create_hyp_mappings(hyp_pgd, virt_addr & PAGE_MASK,
>> 				    (virt_addr + PAGE_SIZE) & PAGE_MASK,
>> 				    [...]
>>
>>> +					    __phys_to_pfn(phys_addr),
>>> +					    PAGE_HYP);
>>> +		if (err)
>>> +			return err;
>>> +	}
>>> +
>>> +	return 0;
>>>  }
>>>  
>>>  /**
>>>
>>
>> So that would work, but I'm slightly uncomfortable with what is
>> basically an open-coded version of per_cpu_ptr_to_phys, and I think
>> there is some value in having an explicit function for dealing with
>> percpu mappings, at least for educational purpose.
> 
> I'm not concerned about the open-coded; this is a pretty fundamental
> functionality to distinguish between a vmalloc and a kmalloc and do the
> virt_to_phys translation accordingly - that's not specific to percpu
> allocated memory - they only add more complexity as an optimization.
> After all, this is a single if-statement that I'm sure we can master.

Hey, I've been seen messing up that kind of code very easily! ;-)

> I think it's slightly more strange to have a call to map memory that
> depends on how you allocated it, and would prefer having something that
> just works, regardless.  But maybe that's utopian.  However, would we
> end up potentially having a create_vmalloc_hyp_mappings as well then?
> 
> Another concern with your proposal is that it duplicates more code and
> makes it a bit harder to track what's going on (who calls what when to
> allocate something, etc.).
> 
>>
>> Also, we loose the virt_addr_valid() check, which has been a valuable
>> debugging tool for me in the past.
>>
>> But maybe that's just me being a chicken... ;-)
>>
> Of course it is.  No, but really, virt_addr_valid just checks that it's
> linearly mapped mapped memory.  So we're checking that it's not
> highmeme, and assuming it's linearly mapped now.  We can add a
> BUG_ON(!virt_addr_valid(x)) in the (!is_vmalloc_addr(kaddr)) case to
> make sure nobody is passing module addresses or DMA memory or something
> else crazy here, but I doubt that's a bug we need to concerne ourselves
> about.

Fair enough. Do you write the patch, or do I update mine? Don't mind
either way.

	M.
-- 
Jazz is not dead. It just smells funny...
