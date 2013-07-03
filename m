From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 03 Jul 2013 14:59:56 +0100
Subject: [PATCH] arm64: KVM: Support Cortex-A57 guest CPU on APM X-Gene
 host
In-Reply-To: <CAFEAcA_9mfYT6pPOT3dmqGoFAeJpQACO4FZp_971XUSowxoBaA@mail.gmail.com>
References: <1372840923-12808-1-git-send-email-anup.patel@linaro.org>
 <CAFEAcA_9mfYT6pPOT3dmqGoFAeJpQACO4FZp_971XUSowxoBaA@mail.gmail.com>
Message-ID: <51D42E5C.6050209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/13 11:54, Peter Maydell wrote:
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

There is no such thing in the KVM/arm64 code. The guest sees the real
host, and I really don't lie the idea of lying to userspace by
pretending that we're going to emulate an A57.

Anup: I suggest you rework that patch to present a X-Gene vcpu. You can
implement it by declaring a new target and implementing it in terms of
the generic backend one if that's convenient. But just pretending this
is an A57 is not going to fly, sorry.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
