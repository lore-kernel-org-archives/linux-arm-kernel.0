From: anup@brainfault.org (Anup Patel)
Date: Tue, 16 Jul 2013 22:12:25 +0530
Subject: [PATCH V2] arm64: KVM: Support X-Gene guest VCPU on APM X-Gene
 host
In-Reply-To: <20130716091417.GC14486@e106331-lin.cambridge.arm.com>
References: <1373957734-21482-1-git-send-email-anup.patel@linaro.org>
 <20130716091417.GC14486@e106331-lin.cambridge.arm.com>
Message-ID: <CAAhSdy3B8HVAixeLt2rRnFFvGLepkxfW86gnbr6CMw+LfJw_Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 2:44 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Jul 16, 2013 at 07:55:34AM +0100, Anup Patel wrote:
>> This patch allows us to have X-Gene guest VCPU when using KVM arm64
>> on APM X-Gene host.
>>
>> We add KVM_ARM_TARGET_XGENE_POTENZA for X-Gene Potenza compatible
>> guest VCPU and we return KVM_ARM_TARGET_XGENE_POTENZA in kvm_target_cpu()
>> when running on X-Gene host with Potenza core.
>>
>> V2:
>>  - Renamed KVM_ARM_TARGET_XGENE_V8 to KVM_ARM_TARGET_XGENE_POTENZA
>>
>> V1:
>>  - Initial patch with target named as KVM_ARM_TARGET_XGENE_V8
>>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> ---
>>  arch/arm64/include/uapi/asm/kvm.h    |    3 ++-
>>  arch/arm64/kvm/guest.c               |   34 ++++++++++++++++++++++------------
>>  arch/arm64/kvm/sys_regs_generic_v8.c |    3 +++
>>  3 files changed, 27 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>> index 5031f42..d9f026b 100644
>> --- a/arch/arm64/include/uapi/asm/kvm.h
>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>> @@ -55,8 +55,9 @@ struct kvm_regs {
>>  #define KVM_ARM_TARGET_AEM_V8                0
>>  #define KVM_ARM_TARGET_FOUNDATION_V8 1
>>  #define KVM_ARM_TARGET_CORTEX_A57    2
>> +#define KVM_ARM_TARGET_XGENE_POTENZA 3
>>
>> -#define KVM_ARM_NUM_TARGETS          3
>> +#define KVM_ARM_NUM_TARGETS          4
>>
>>  /* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
>>  #define KVM_ARM_DEVICE_TYPE_SHIFT    0
>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>> index 2c3ff67..a466244 100644
>> --- a/arch/arm64/kvm/guest.c
>> +++ b/arch/arm64/kvm/guest.c
>> @@ -207,19 +207,29 @@ int __attribute_const__ kvm_target_cpu(void)
>>       unsigned long implementor = read_cpuid_implementor();
>>       unsigned long part_number = read_cpuid_part_number();
>>
>> -     if (implementor != ARM_CPU_IMP_ARM)
>> -             return -EINVAL;
>> -
>> -     switch (part_number) {
>> -     case ARM_CPU_PART_AEM_V8:
>> -             return KVM_ARM_TARGET_AEM_V8;
>> -     case ARM_CPU_PART_FOUNDATION:
>> -             return KVM_ARM_TARGET_FOUNDATION_V8;
>> -     case ARM_CPU_PART_CORTEX_A57:
>> -             /* Currently handled by the generic backend */
>> -             return KVM_ARM_TARGET_CORTEX_A57;
>> +     switch (implementor) {
>> +     case ARM_CPU_IMP_ARM:
>> +             switch (part_number) {
>> +             case ARM_CPU_PART_AEM_V8:
>> +                     return KVM_ARM_TARGET_AEM_V8;
>> +             case ARM_CPU_PART_FOUNDATION:
>> +                     return KVM_ARM_TARGET_FOUNDATION_V8;
>> +             case ARM_CPU_PART_CORTEX_A57:
>> +                     return KVM_ARM_TARGET_CORTEX_A57;
>> +             default:
>> +                     return -EINVAL;
>> +             }
>> +             break;
>> +     case ARM_CPU_IMP_APM:
>> +             switch (part_number) {
>> +             case APM_CPU_PART_POTENZA:
>> +                     return KVM_ARM_TARGET_XGENE_POTENZA;
>> +             default:
>> +                     return -EINVAL;
>> +             }
>> +             break;
>>       default:
>> -             return -EINVAL;
>> +             return -EINVAL;
>>       }
>
> Why not place a return -EINVAL here, outside of the outer switch
> statement? That way you don't need to duplicate it for an unknown
> implementor or a known implementor's unknown CPU, as long as you keep
> the break at the end of each implementor's case.

Sure, I will update the switch statement accordingly.

>
> Thanks,
> Mark.
>
>>  }
>>
>> diff --git a/arch/arm64/kvm/sys_regs_generic_v8.c b/arch/arm64/kvm/sys_regs_generic_v8.c
>> index 4268ab9..8fe6f76 100644
>> --- a/arch/arm64/kvm/sys_regs_generic_v8.c
>> +++ b/arch/arm64/kvm/sys_regs_generic_v8.c
>> @@ -90,6 +90,9 @@ static int __init sys_reg_genericv8_init(void)
>>                                         &genericv8_target_table);
>>       kvm_register_target_sys_reg_table(KVM_ARM_TARGET_CORTEX_A57,
>>                                         &genericv8_target_table);
>> +     kvm_register_target_sys_reg_table(KVM_ARM_TARGET_XGENE_POTENZA,
>> +                                       &genericv8_target_table);
>> +
>>       return 0;
>>  }
>>  late_initcall(sys_reg_genericv8_init);
>> --
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Regards,
Anup
