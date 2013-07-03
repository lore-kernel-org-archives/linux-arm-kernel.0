From: anup@brainfault.org (Anup Patel)
Date: Wed, 3 Jul 2013 19:30:54 +0530
Subject: [PATCH] arm64: KVM: Support Cortex-A57 guest CPU on APM X-Gene
 host
In-Reply-To: <CAFEAcA_9mfYT6pPOT3dmqGoFAeJpQACO4FZp_971XUSowxoBaA@mail.gmail.com>
References: <1372840923-12808-1-git-send-email-anup.patel@linaro.org>
 <CAFEAcA_9mfYT6pPOT3dmqGoFAeJpQACO4FZp_971XUSowxoBaA@mail.gmail.com>
Message-ID: <CAAhSdy1eVTk2ztzir3yZ_GZMC1+D9Co+J2UZAFWKMoZnpAg_+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 3, 2013 at 4:24 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 3 July 2013 09:42, Anup Patel <anup.patel@linaro.org> wrote:
>> Update kvm_target_cpu() to allow Cortex-A57 guest CPU on APM X-Gene.
>>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> ---
>>  arch/arm64/kvm/guest.c |   10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> index 2c3ff67..765f56f 100644
>> --- a/arch/arm64/kvm/guest.c
>> +++ b/arch/arm64/kvm/guest.c
>> @@ -207,8 +207,13 @@ int __attribute_const__ kvm_target_cpu(void)
>>         unsigned long implementor = read_cpuid_implementor();
>>         unsigned long part_number = read_cpuid_part_number();
>>
>> -       if (implementor != ARM_CPU_IMP_ARM)
>> -               return -EINVAL;
>> +       switch (implementor) {
>> +       case ARM_CPU_IMP_ARM:
>> +       case ARM_CPU_IMP_APM:
>> +               break;
>> +       default:
>> +               return -EINVAL;
>> +       }
>
> Doesn't this change mean we now accept the below part
> numbers for all implementors? That doesn't look right.

Sure, we can use nested switch case instead of two separate
switch cases.

>
>>         switch (part_number) {
>>         case ARM_CPU_PART_AEM_V8:
>> @@ -216,6 +221,7 @@ int __attribute_const__ kvm_target_cpu(void)
>>         case ARM_CPU_PART_FOUNDATION:
>>                 return KVM_ARM_TARGET_FOUNDATION_V8;
>>         case ARM_CPU_PART_CORTEX_A57:
>> +       case APM_CPU_PART_POTENZA:
>>                 /* Currently handled by the generic backend */
>>                 return KVM_ARM_TARGET_CORTEX_A57;
>>         default:
>
> Do we really model all the system registers and so on correctly
> sufficiently to be able to present the guest with an A57 vcpu
> on an APM X-Gene host? (ie without accidentally leaking the
> host ID registers/system registers/impdef registers to the
> guest).

Yes, there are very few APM impdef registers. For now A57 vcpu
is not allowed to access these impdef registers.

For rest of the registers, A57 vcpu will see:
1. MIDR and MPIDR as expected on a A57 vcpu.
2. Cache configuration related registers will be same as that
    of underlying host so that cache operations work fine in guest

>
> thanks
> -- PMM
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm

--Anup
