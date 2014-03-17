From: anup@brainfault.org (Anup Patel)
Date: Mon, 17 Mar 2014 11:47:20 +0530
Subject: [PATCH v4 09/10] ARM/ARM64: KVM: Fix CPU_ON emulation for PSCI
 v0.2
In-Reply-To: <20140317034121.GJ20648@cbox>
References: <1391686302-19451-1-git-send-email-anup.patel@linaro.org>
 <1391686302-19451-10-git-send-email-anup.patel@linaro.org>
 <20140317034121.GJ20648@cbox>
Message-ID: <CAAhSdy3gwZ-z4bqXRp0aT7c5osHtOztTXNQSmaWL3FV5EZp1Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 9:11 AM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Thu, Feb 06, 2014 at 05:01:41PM +0530, Anup Patel wrote:
>> As-per PSCI v0.2, the source CPU provides physical address of
>> "entry point" and "context id" for starting a target CPU.
>>
>> Current emulation of CPU_ON function does not consider physical
>> address of "context id" hence this patch updates kvm_psci_vcpu_on()
>> such that it works for both PSCI v0.1 and PSCI v0.2.
>>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> ---
>>  arch/arm/kvm/psci.c |   11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
>> index 75447a3..675866e 100644
>> --- a/arch/arm/kvm/psci.c
>> +++ b/arch/arm/kvm/psci.c
>> @@ -32,12 +32,14 @@ static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
>>       vcpu->arch.pause = true;
>>  }
>>
>> -static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>> +static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu,
>> +                                   int psci_version)
>
> I thought this would be what you have kvm_psci_version() for?

Good point. I will use kvm_psci_version() here.

--
Anup

>
>>  {
>>       struct kvm *kvm = source_vcpu->kvm;
>>       struct kvm_vcpu *vcpu = NULL, *tmp;
>>       wait_queue_head_t *wq;
>>       unsigned long cpu_id;
>> +     unsigned long context_id;
>>       unsigned long mpidr;
>>       phys_addr_t target_pc;
>>       int i;
>> @@ -62,6 +64,7 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>>               return KVM_PSCI_RET_INVAL;
>>
>>       target_pc = *vcpu_reg(source_vcpu, 2);
>> +     context_id = *vcpu_reg(source_vcpu, 3);
>>
>>       kvm_reset_vcpu(vcpu);
>>
>> @@ -76,6 +79,8 @@ static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
>>               kvm_vcpu_set_be(vcpu);
>>
>>       *vcpu_pc(vcpu) = target_pc;
>> +     if (psci_version != KVM_ARM_PSCI_0_1)
>> +             *vcpu_reg(vcpu, 0) = context_id;
>>       vcpu->arch.pause = false;
>>       smp_mb();               /* Make sure the above is visible */
>>
>> @@ -180,7 +185,7 @@ static int kvm_psci_0_2_call(struct kvm_vcpu *vcpu)
>>               break;
>>       case KVM_PSCI_0_2_FN_CPU_ON:
>>       case KVM_PSCI_0_2_FN64_CPU_ON:
>> -             val = kvm_psci_vcpu_on(vcpu);
>> +             val = kvm_psci_vcpu_on(vcpu, KVM_ARM_PSCI_0_2);
>>               break;
>>       case KVM_PSCI_0_2_FN_AFFINITY_INFO:
>>       case KVM_PSCI_0_2_FN64_AFFINITY_INFO:
>> @@ -234,7 +239,7 @@ static int kvm_psci_0_1_call(struct kvm_vcpu *vcpu)
>>               val = KVM_PSCI_RET_SUCCESS;
>>               break;
>>       case KVM_PSCI_FN_CPU_ON:
>> -             val = kvm_psci_vcpu_on(vcpu);
>> +             val = kvm_psci_vcpu_on(vcpu, KVM_ARM_PSCI_0_1);
>>               break;
>>       case KVM_PSCI_FN_CPU_SUSPEND:
>>       case KVM_PSCI_FN_MIGRATE:
>> --
>> 1.7.9.5
>>
>
> otherwise:
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
