From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Jul 2013 15:53:28 +0100
Subject: [PATCH 2/4] arm64: KVM: add missing dsb before invalidating
 Stage-2 TLBs
In-Reply-To: <20130719143229.GG18139@mudshark.cambridge.arm.com>
References: <1374242035-13199-1-git-send-email-marc.zyngier@arm.com>
 <1374242035-13199-3-git-send-email-marc.zyngier@arm.com>
 <20130719143229.GG18139@mudshark.cambridge.arm.com>
Message-ID: <51E952E8.6020503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/07/13 15:32, Will Deacon wrote:
> On Fri, Jul 19, 2013 at 02:53:53PM +0100, Marc Zyngier wrote:
>> When performing a Stage-2 TLB invalidation, it is necessary to
>> make sure the write to the page tables is observable by all CPUs.
>>
>> For this purpose, add a dsb instruction to __kvm_tlb_flush_vmid_ipa
>> before doing the TLB invalidation itself.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/kvm/hyp.S | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
>> index 218802f..e1ccfcc 100644
>> --- a/arch/arm64/kvm/hyp.S
>> +++ b/arch/arm64/kvm/hyp.S
>> @@ -604,6 +604,8 @@ END(__kvm_vcpu_run)
>>  
>>  // void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
>>  ENTRY(__kvm_tlb_flush_vmid_ipa)
>> +	dsb	ishst	// Make sure previous writes are observable
>> +
>>  	kern_hyp_va	x0
>>  	ldr	x2, [x0, #KVM_VTTBR]
>>  	msr	vttbr_el2, x2
>> -- 
>> 1.8.2.3
> 
> I don't think the comment adds anything to this code. Also, why don't you
> need similar barriers for the cases where you clobber the entire TLB (e.g.
> __kvm_flush_vm_context)?

I think they are required as well. I'll respin the patch.

	M.
-- 
Jazz is not dead. It just smells funny...
