From: m.smarduch@samsung.com (Mario Smarduch)
Date: Fri, 07 Nov 2014 12:50:37 -0800
Subject: [PATCH 2/3] arm64: Add HYP interface to flush VM Stage 1/2 TLB
 entires
In-Reply-To: <20141107202032.GG22848@cbox>
References: <1412908447-28247-1-git-send-email-m.smarduch@samsung.com>
 <1412908447-28247-3-git-send-email-m.smarduch@samsung.com>
 <20141107202032.GG22848@cbox>
Message-ID: <545D309D.2010908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2014 12:20 PM, Christoffer Dall wrote:
> On Thu, Oct 09, 2014 at 07:34:06PM -0700, Mario Smarduch wrote:
>> This patch adds HYP VM TLB FLush function.
>>
>> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
>> ---
>>  arch/arm64/kvm/hyp.S | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
>> index b0d1512..117a91c 100644
>> --- a/arch/arm64/kvm/hyp.S
>> +++ b/arch/arm64/kvm/hyp.S
>> @@ -645,6 +645,28 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
>>  	ret
>>  ENDPROC(__kvm_tlb_flush_vmid_ipa)
>>  
>> +/**
>> + * void __kvm_tlb_flush_vmid(struct kvm *kvm) - Flush per-VMID TLBs
>> + * @struc kvm *kvm - pointer to kvm structure
> 
> struct

Got it.
> 
>> + *
>> + * Invalidates all Stage 1 and 2 TLB entries for current VMID.
>> + */
>> +ENTRY(__kvm_tlb_flush_vmid)
>> +	dsb     ishst
>> +
>> +	kern_hyp_va     x0
>> +	ldr     x2, [x0, #KVM_VTTBR]
>> +	msr     vttbr_el2, x2
>> +	isb
>> +
>> +	tlbi    vmalls12e1is
>> +	dsb     ish
>> +	isb
>> +
>> +	msr     vttbr_el2, xzr
>> +	ret
>> +ENDPROC(__kvm_tlb_flush_vmid)
>> +
>>  ENTRY(__kvm_flush_vm_context)
>>  	dsb	ishst
>>  	tlbi	alle1is
>> -- 
>> 1.9.1
>>
> Looks good to me:
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
