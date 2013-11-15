From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Nov 2013 16:33:07 +0000
Subject: [PATCH] arm/arm64: KVM: introduce new mapping API for percpu
 mappings
In-Reply-To: <20131115161004.GA25051@cbox>
References: <1384530008-18181-1-git-send-email-marc.zyngier@arm.com>
 <20131115161004.GA25051@cbox>
Message-ID: <52864CC3.2050201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/13 16:10, Christoffer Dall wrote:
> On Fri, Nov 15, 2013 at 03:40:08PM +0000, Marc Zyngier wrote:
>> Using virt_to_phys on percpu mappings is horribly wrong (my own bad).
>> Thankfully, the kernel offers a way to obtain the physical address
>> of such a mapping.
>>
>> Add a new create_hyp_percpu_mappings function to deal with those.
>>
>> Reported-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
> 
> 
> So, I find this nicer, somehow, what do you think:
> 
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 3719583..dd531ba 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -334,6 +334,15 @@ out:
>  	return err;
>  }
>  
> +static phys_addr_t kvm_kaddr_to_phys(void *kaddr)
> +{
> +	if (!is_vmalloc_addr(kaddr))
> +		return __pa(kaddr);
> +	else
> +		return page_to_phys(vmalloc_to_page(kaddr)) +
> +		       offset_in_page(kaddr);
> +}
> +
>  /**
>   * create_hyp_mappings - duplicate a kernel virtual address range in Hyp mode
>   * @from:	The virtual kernel start address of the range
> @@ -345,16 +354,24 @@ out:
>   */
>  int create_hyp_mappings(void *from, void *to)
>  {
> -	unsigned long phys_addr = virt_to_phys(from);
> +	phys_addr_t phys_addr;
> +	unsigned long virt_addr;
>  	unsigned long start = KERN_TO_HYP((unsigned long)from);
>  	unsigned long end = KERN_TO_HYP((unsigned long)to);
>  
> -	/* Check for a valid kernel memory mapping */
> -	if (!virt_addr_valid(from) || !virt_addr_valid(to - 1))
> -		return -EINVAL;
> +	for (virt_addr = start; virt_addr < end; virt_addr += PAGE_SIZE) {
> +		int err;
>  
> -	return __create_hyp_mappings(hyp_pgd, start, end,
> -				     __phys_to_pfn(phys_addr), PAGE_HYP);
> +		phys_addr = kvm_kaddr_to_phys(from + virt_addr - start);
> +		err = __create_hyp_mappings(hyp_pgd, virt_addr,
> +					    virt_addr + PAGE_SIZE,

I think I've introduced a bug here. It probably should read:

	err = __create_hyp_mappings(hyp_pgd, virt_addr & PAGE_MASK,
				    (virt_addr + PAGE_SIZE) & PAGE_MASK,
				    [...]

> +					    __phys_to_pfn(phys_addr),
> +					    PAGE_HYP);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
>  }
>  
>  /**
> 

So that would work, but I'm slightly uncomfortable with what is
basically an open-coded version of per_cpu_ptr_to_phys, and I think
there is some value in having an explicit function for dealing with
percpu mappings, at least for educational purpose.

Also, we loose the virt_addr_valid() check, which has been a valuable
debugging tool for me in the past.

But maybe that's just me being a chicken... ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
