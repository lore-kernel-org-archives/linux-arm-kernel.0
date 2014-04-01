From: anup@brainfault.org (Anup Patel)
Date: Tue, 1 Apr 2014 10:44:22 +0530
Subject: [PATCH v6 11/12] ARM/ARM64: KVM: Emulate PSCI v0.2 CPU_SUSPEND
In-Reply-To: <20140331174018.GC4756@lvm>
References: <1396262773-7723-1-git-send-email-anup.patel@linaro.org>
 <1396262773-7723-12-git-send-email-anup.patel@linaro.org>
 <20140331174018.GC4756@lvm>
Message-ID: <CAAhSdy3uF7o6vVnx95H2HzBXPBj=Zo009-oZ7HiUC3zB-9ZDog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 11:10 PM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Mon, Mar 31, 2014 at 04:16:12PM +0530, Anup Patel wrote:
>> This patch adds emulation of PSCI v0.2 CPU_SUSPEND function call for
>> KVM ARM/ARM64. This is a CPU-level function call which can suspend
>> current CPU or current CPU cluster. We don't have VCPU clusters in
>> KVM so for KVM we simply suspend the current VCPU.
>>
>> The CPU_SUSPEND emulation is not tested much because currently there
>> is no CPUIDLE driver in Linux kernel that uses PSCI CPU_SUSPEND. The
>> PSCI CPU_SUSPEND implementation in ARM64 kernel was tested using a
>> Simple CPUIDLE driver which is not published due to unstable DT-bindings
>> for PSCI.
>> (For more info, http://lwn.net/Articles/574950/)
>>
>> Even if we had stable DT-bindings for PSCI and CPUIDLE driver that
>> uses PSCI CPU_SUSPEND then still we need to define SUSPEND states
>> and WAKEUP events for KVM ARM/ARM64.
>>
>> Due to this, we implement CPU_SUSPEND emulation similar to WFI
>> (Wait-for-interrupt) emulation.
>>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> ---
>>  arch/arm/kvm/psci.c |   29 +++++++++++++++++++++++++----
>>  1 file changed, 25 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
>> index 85bf896..f414fd3 100644
>> --- a/arch/arm/kvm/psci.c
>> +++ b/arch/arm/kvm/psci.c
>> @@ -52,6 +52,27 @@ static unsigned long psci_affinity_mask(unsigned long affinity_level)
>>       return affinity_mask;
>>  }
>>
>> +static unsigned long kvm_psci_vcpu_suspend(struct kvm_vcpu *vcpu)
>> +{
>> +     /*
>> +      * NOTE: Currently, we don't have any wakeup events for KVM
>> +      * so for simplicity we make VCPU suspend emulation same-as
>> +      * WFI (Wait-for-interrupt) emulation.
>
> If you implement it like WFI, we do have wake-up events: Namely
> interrupts.
>
>> +      *
>> +      * To do this we simply update VCPU registers as-per state
>> +      * info provided via r1 - r3 (or x1 - x3) and block the
>> +      * VCPU for irqs.
>> +      */
>> +     if (*vcpu_reg(vcpu, 1) & (0x1UL << 16)) {
>> +             /* Update return pc and r0 for power-down state. */
>> +             *vcpu_pc(vcpu) = *vcpu_reg(vcpu, 2);
>> +             *vcpu_reg(vcpu, 0) = *vcpu_reg(vcpu, 3);
>> +     }
>
>
> Hmm, this looks wrong.  This looks like you're respecting the power-down
> state request but not resetting the CPU.  What I was saying before was
> that if you implement this as kvm_vcpu_block(), just like WFI, then you
> need to preserve all state, ignore power-down state requests and treat
> them as suspend states, implement them as WFI, and put a big fat comment
> here explaining why this is architecturally valid (by referring to the
> PSCI 0.2 spec) and what the semantics of doing that is.

Actually, I was more inclined towards preserving the VCPU context for
power-down request but as-per section 5.4.2 clause 3 we can treat
power-down request to be same as suspend request.

I update this patch accordingly.

Regards,
Anup

>
> -Christoffer
>
>
>> +     kvm_vcpu_block(vcpu);
>> +
>> +     return PSCI_RET_SUCCESS;
>> +}
>> +
>>  static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
>>  {
>>       vcpu->arch.pause = true;
>> @@ -195,6 +216,10 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>>                */
>>               val = 2;
>>               break;
>> +     case PSCI_0_2_FN_CPU_SUSPEND:
>> +     case PSCI_0_2_FN64_CPU_SUSPEND:
>> +             val = kvm_psci_vcpu_suspend(vcpu);
>> +             break;
>>       case PSCI_0_2_FN_CPU_OFF:
>>               kvm_psci_vcpu_off(vcpu);
>>               val = PSCI_RET_SUCCESS;
>> @@ -232,10 +257,6 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>>               val = PSCI_RET_SUCCESS;
>>               ret = 0;
>>               break;
>> -     case PSCI_0_2_FN_CPU_SUSPEND:
>> -     case PSCI_0_2_FN64_CPU_SUSPEND:
>> -             val = PSCI_RET_NOT_SUPPORTED;
>> -             break;
>>       default:
>>               return -EINVAL;
>>       }
>> --
>> 1.7.9.5
>>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
