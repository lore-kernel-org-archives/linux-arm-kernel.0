From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Dec 2014 09:35:26 +0000
Subject: Help on kvm_tlb_flush_vmid_ipa usage
In-Reply-To: <5493314C.8010400@samsung.com>
References: <54932A97.3060103@samsung.com> <54932D1F.5060209@arm.com>
 <5493314C.8010400@samsung.com>
Message-ID: <5493F15E.1030403@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/12/14 19:55, Mario Smarduch wrote:
> On 12/18/2014 11:38 AM, Marc Zyngier wrote:
>> On 18/12/14 19:27, Mario Smarduch wrote:
>>> When this function is called IPA address is used. Looking at the HYP
>>> implementation it uses the IPA directly in tlbi instructions. But
>>> reading the TLB maintnance instruction syntax, bit [35:0] should be
>>> set to IPA[47:12]. I traced the source code but don't see the
>>> adjustment. I must be missing something given this function is
>>> fundamental to KVM MMU.
>>
>> Ermmm... Someone (that is, I) needs a brown paper back again.
>>
>> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
>> index b72aa9f..a767f6a 100644
>> --- a/arch/arm64/kvm/hyp.S
>> +++ b/arch/arm64/kvm/hyp.S
>> @@ -1014,6 +1014,7 @@ ENTRY(__kvm_tlb_flush_vmid_ipa)
>>  	 * Instead, we invalidate Stage-2 for this IPA, and the
>>  	 * whole of Stage-1. Weep...
>>  	 */
>> +	lsr	x1, x1, #12
>>  	tlbi	ipas2e1is, x1
>>  	/*
>>  	 * We have to ensure completion of the invalidation at Stage-2,
>>
>> 	M.
>>
> 
> Marc,
>   thanks.
> 
> Another question, is how do you handle a huge tlb do you need to zero
> out any PMD/PUD mask bits or just pass it in as is. The manual says 
> MMU can figure out which bits are treated as 0 for 16/64KB pages, can
> same thing be assumed for huge pages?

Indeed. The MMU will simply try to match the address with the TLBs,
taking into account how much the actual entry is covering (1G, 2M, 4K).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
