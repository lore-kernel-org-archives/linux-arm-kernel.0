From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 15 Nov 2013 15:29:52 +0000
Subject: [PATCH 1/6] arm64: mm: Add __virt_to_idmap() to keep kvm build
 happy
In-Reply-To: <52863CE5.3070906@ti.com>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-2-git-send-email-santosh.shilimkar@ti.com>
 <5286384A.5050105@arm.com> <52863CE5.3070906@ti.com>
Message-ID: <52863DF0.9070200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/13 15:25, Santosh Shilimkar wrote:
> On Friday 15 November 2013 10:05 AM, Marc Zyngier wrote:
>> On 14/11/13 19:37, Santosh Shilimkar wrote:
>>> ARM kvm code will make use of __virt_to_idmap() on arm32
>>> machines as hardware interconnect supported alias of physical
>>> memory for idmap purposes. The same code is shared with arm64
>>> bit and hence will break the builds. So we add __virt_to_idmap()
>>> which is just __virt_to_phys() on arm64 bit to keep build happy.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> ---
>>>  arch/arm64/include/asm/memory.h |    8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
>>> index 3776217..d9341ee 100644
>>> --- a/arch/arm64/include/asm/memory.h
>>> +++ b/arch/arm64/include/asm/memory.h
>>> @@ -75,6 +75,14 @@
>>>  #define __phys_to_virt(x)	((unsigned long)((x) - PHYS_OFFSET + PAGE_OFFSET))
>>>  
>>>  /*
>>> + * Added to keep arm64 kvm build working which shares code with
>>> + * 32bit port. ARM kvm code makes use of __virt_to_idmap() on arm32
>>> + * machines as hardware interconnect supported alias of physical
>>> + * memory for idmap purposes.
>>> + */
>>> +#define virt_to_idmap(x)	__virt_to_phys(x)
>>> +
>>> +/*
>>>   * Convert a physical address to a Page Frame Number and back
>>>   */
>>>  #define	__phys_to_pfn(paddr)	((unsigned long)((paddr) >> PAGE_SHIFT))
>>>
>>
>> I'd rather have a kvm_virt_to_phys() in kvm_mmu.h. That's how we've
>> dealt with that kind of difference so far.
>>
> Are you suggesting something like below ?

Yes, I like it a lot more.

Catalin, what do you think?

	M.

> 
> ---
>  arch/arm/include/asm/kvm_mmu.h   |    1 +
>  arch/arm/kvm/mmu.c               |    8 ++++----
>  arch/arm64/include/asm/kvm_mmu.h |    1 +
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index 9b28c41..fd90efa 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -129,6 +129,7 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
>  }
>  
>  #define kvm_flush_dcache_to_poc(a,l)	__cpuc_flush_dcache_area((a), (l))
> +#define kvm_virt_to_phys(x)		virt_to_idmap((unsigned long)(x))
>  
>  #endif	/* !__ASSEMBLY__ */
>  
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index b0de86b..071e535 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -747,9 +747,9 @@ int kvm_mmu_init(void)
>  {
>  	int err;
>  
> -	hyp_idmap_start = virt_to_phys(__hyp_idmap_text_start);
> -	hyp_idmap_end = virt_to_phys(__hyp_idmap_text_end);
> -	hyp_idmap_vector = virt_to_phys(__kvm_hyp_init);
> +	hyp_idmap_start = kvm_virt_to_phys(__hyp_idmap_text_start);
> +	hyp_idmap_end = kvm_virt_to_phys(__hyp_idmap_text_end);
> +	hyp_idmap_vector = kvm_virt_to_phys(__kvm_hyp_init);
>  
>  	if ((hyp_idmap_start ^ hyp_idmap_end) & PAGE_MASK) {
>  		/*
> @@ -776,7 +776,7 @@ int kvm_mmu_init(void)
>  		 */
>  		kvm_flush_dcache_to_poc(init_bounce_page, len);
>  
> -		phys_base = virt_to_phys(init_bounce_page);
> +		phys_base = kvm_virt_to_phys(init_bounce_page);
>  		hyp_idmap_vector += phys_base - hyp_idmap_start;
>  		hyp_idmap_start = phys_base;
>  		hyp_idmap_end = phys_base + len;
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index efe609c..9ce7c88 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -130,6 +130,7 @@ static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
>  }
>  
>  #define kvm_flush_dcache_to_poc(a,l)	__flush_dcache_area((a), (l))
> +#define kvm_virt_to_phys(x)		__virt_to_phys((unsigned long)(x))
>  
>  #endif /* __ASSEMBLY__ */
>  #endif /* __ARM64_KVM_MMU_H__ */
> 


-- 
Jazz is not dead. It just smells funny...
