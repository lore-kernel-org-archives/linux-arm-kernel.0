From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 8 Nov 2018 12:31:34 +0000
Subject: [PATCH 6/7] arm64: Do not apply vector harderning for hyp entries
 from EL2
In-Reply-To: <20181107215926.GH12248@brain-police>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
 <1537970184-44348-7-git-send-email-julien.thierry@arm.com>
 <20181107215926.GH12248@brain-police>
Message-ID: <3da632e3-d6e2-7595-2c39-587b81852e89@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/11/18 21:59, Will Deacon wrote:
> On Wed, Sep 26, 2018 at 02:56:23PM +0100, Julien Thierry wrote:
>> When an EL2 entry of __kvm_hyp_vector is taken, it means an entry from a
>> lower EL was previously taken to exit the guest. Taking that lower EL entry
>> already applied vector hardening if needed, so there is no need to do it
>> again.
>>
>> Only apply vector hardening for exception coming from lower EL.
>>
>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>> Cc: kvmarm at lists.cs.columbia.edu
>> ---
>>   arch/arm64/kvm/hyp/hyp-entry.S | 17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/hyp/hyp-entry.S b/arch/arm64/kvm/hyp/hyp-entry.S
>> index 24b4fba..da31386 100644
>> --- a/arch/arm64/kvm/hyp/hyp-entry.S
>> +++ b/arch/arm64/kvm/hyp/hyp-entry.S
>> @@ -257,7 +257,15 @@ ENTRY(__kvm_hyp_vector)
>>   ENDPROC(__kvm_hyp_vector)
>>
>>   #ifdef CONFIG_KVM_INDIRECT_VECTORS
>> -.macro hyp_ventry
>> +.macro hyp_el2_ventry
>> +	.align 7
>> +1:	b	__kvm_hyp_vector + (1b - 0b)
>> +	.rept 31
>> +	nop
>> +	.endr
>> +.endm
>> +
>> +.macro hyp_el1_ventry
>>   	.align 7
>>   1:	.rept 27
>>   	nop
>> @@ -290,8 +298,11 @@ alternative_cb_end
> 
> I think it would be cleaner to take the EL as a macro parameter, but again,
> I defer to Marc and Christoffer.

I'd argue they don't have much in common here. Unless I put the branch 
for the el2 ventry after 27 nops like for the el1, we wouldn't gain much 
from putting the two in the same macro IMO.

I'll see what Marc and Christoffer think about it.

Thanks,

-- 
Julien Thierry
