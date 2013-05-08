From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 08 May 2013 11:46:25 +0100
Subject: [PATCH v2 1/5] ARM: KVM: be more thorough when invalidating TLBs
In-Reply-To: <20130502151302.GG20730@arm.com>
References: <1367505542-2231-1-git-send-email-marc.zyngier@arm.com>
 <1367505542-2231-2-git-send-email-marc.zyngier@arm.com>
 <20130502151302.GG20730@arm.com>
Message-ID: <518A2D01.1070904@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/13 16:13, Catalin Marinas wrote:
> On Thu, May 02, 2013 at 03:38:58PM +0100, Marc Zyngier wrote:
>> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
>> index f7793df..9e2d906c 100644
>> --- a/arch/arm/kvm/interrupts.S
>> +++ b/arch/arm/kvm/interrupts.S
> ...
>> -static void clear_pte_entry(pte_t *pte)
>> +static void clear_pte_entry(struct kvm *kvm, pte_t *pte, phys_addr_t addr)
>>  {
>>  	if (pte_present(*pte)) {
>>  		kvm_set_pte(pte, __pte(0));
>>  		put_page(virt_to_page(pte));
>> +		kvm_tlb_flush_vmid_ipa(kvm, addr);
>>  	}
>>  }
> ...
>>  static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
>>  {
>> -	unmap_range(kvm->arch.pgd, start, size);
>> +	unmap_range(kvm, kvm->arch.pgd, start, size);
>>  }
>>  
>>  /**
>> @@ -413,6 +425,7 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
>>  		return;
>>  
>>  	unmap_stage2_range(kvm, 0, KVM_PHYS_SIZE);
>> +	kvm_tlb_flush_vmid_ipa(kvm, 0);	/* Invalidate TLB ALL */
> 
> Do you still need this here if you invalidated each individual pte in
> clear_pte_entry()? I think you can remove it from clear_pte_entry() and
> just leave it here (more efficient probably) since you wouldn't free the
> actual pages pointed at by the pte before unmapping.

There is two cases we're trying to cater for:
- unmapping a single page from stage2 (page being swapped out, for example)
- unmapping the whole of stage2 (VM exiting)

We cannot loose the "local" operations, but the last one can indeed go.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
