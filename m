From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Apr 2013 19:02:16 +0100
Subject: [PATCH 1/4] ARM: KVM: be more thorough when invalidating TLBs
In-Reply-To: <CAEDV+g+LKEj_XdeLvMwxJhVQ9FG9=U6eqO7dPU340xX2oMkS0A@mail.gmail.com>
References: <1367331446-28030-1-git-send-email-marc.zyngier@arm.com>
 <1367331446-28030-2-git-send-email-marc.zyngier@arm.com>
 <CAEDV+g+LKEj_XdeLvMwxJhVQ9FG9=U6eqO7dPU340xX2oMkS0A@mail.gmail.com>
Message-ID: <51800728.9050306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/04/13 18:17, Christoffer Dall wrote:
> On Tue, Apr 30, 2013 at 7:17 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> The KVM/ARM MMU code doesn't take care of invalidating TLBs before
>> freeing a {pte,pmd} table. This could cause problems if the page
>> is reallocated and then speculated into by another CPU.
>>
>> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm/kvm/interrupts.S |  2 ++
>>  arch/arm/kvm/mmu.c        | 36 +++++++++++++++++++++---------------
>>  2 files changed, 23 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
>> index f7793df..9e2d906c 100644
>> --- a/arch/arm/kvm/interrupts.S
>> +++ b/arch/arm/kvm/interrupts.S
>> @@ -37,6 +37,8 @@ __kvm_hyp_code_start:
>>   *
>>   * void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
>>   *
>> + * Invalidate TLB for the given IPA, or invalidate all if ipa is zero.
>> + *
>>   * We rely on the hardware to broadcast the TLB invalidation to all CPUs
>>   * inside the inner-shareable domain (which is the case for all v7
>>   * implementations).  If we come across a non-IS SMP implementation, we'll
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 9657065..71f2a57 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -43,7 +43,8 @@ static phys_addr_t hyp_idmap_vector;
>>
>>  static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>>  {
>> -       kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
>> +       if (kvm)
>> +               kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, kvm, ipa);
> 
> this feels slightly abusive? could we add a comment that hyp page
> table freeing don't need tlb flushing from these functions and don't
> have a struct kvm?
> 
> alternatively it may be more clear to have something like:
> 
> if (kvm) /* Check if Hyp or Stage-2 page table */
>     kvm_tlb_flush_vmid_ipa(kvm, addr);
> 
> in the callers, but, eh, maybe I'm over thinking this.

That code would be repeated three times, which feels a bit overkill.
I'll add a comment to the function so it is crystal clear.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
