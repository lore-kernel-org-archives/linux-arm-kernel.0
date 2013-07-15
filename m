From: anup@brainfault.org (Anup Patel)
Date: Mon, 15 Jul 2013 20:07:03 +0530
Subject: [PATCH] arm64: KVM: Support X-Gene guest VCPU on APM X-Gene host
In-Reply-To: <03C760B4-A395-491C-B589-0689BC2C48BB@suse.de>
References: <1373888788-8055-1-git-send-email-anup.patel@linaro.org>
 <51E3ED7A.7050207@arm.com>
 <CAAhSdy25WVnynDyPcOMtqVNEepGGq9WFT3b1PV34P6iSBm-FUg@mail.gmail.com>
 <73A8FA0E-9F7F-4866-9544-57838F30BB91@suse.de>
 <CAAhSdy1tYsdm-2kJzoRfqb-FaPa0-t9x2+=jtMjgFqes+Pco6Q@mail.gmail.com>
 <03C760B4-A395-491C-B589-0689BC2C48BB@suse.de>
Message-ID: <CAAhSdy0JrJT0LnW7MEncHXKGb=qFUgjp43KSs70j_QEHSn3mfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Mon, Jul 15, 2013 at 7:51 PM, Alexander Graf <agraf@suse.de> wrote:
>
> On 15.07.2013, at 16:04, Anup Patel wrote:
>
>> On Mon, Jul 15, 2013 at 6:32 PM, Alexander Graf <agraf@suse.de> wrote:
>>>
>>> On 15.07.2013, at 14:56, Anup Patel wrote:
>>>
>>>> Hi Marc,
>>>>
>>>> On Mon, Jul 15, 2013 at 6:09 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>>> Hi Anup,
>>>>>
>>>>> On 15/07/13 12:46, Anup Patel wrote:
>>>>>> This patch allows us to have X-Gene guest VCPU when using
>>>>>> KVM arm64 on APM X-Gene host.
>>>>>>
>>>>>> We add KVM_ARM_TARGET_XGENE_V8 for X-Gene compatible guest VCPU
>>>>>> and we return KVM_ARM_TARGET_XGENE_V8 in kvm_target_cpu() when
>>>>>> running on X-Gene host.
>>>>>>
>>>>>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>>>>>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>>>>>> ---
>>>>>> arch/arm64/include/uapi/asm/kvm.h    |    3 ++-
>>>>>> arch/arm64/kvm/guest.c               |   34 ++++++++++++++++++++++------------
>>>>>> arch/arm64/kvm/sys_regs_generic_v8.c |    3 +++
>>>>>> 3 files changed, 27 insertions(+), 13 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>>>>>> index 5031f42..8194707 100644
>>>>>> --- a/arch/arm64/include/uapi/asm/kvm.h
>>>>>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>>>>>> @@ -55,8 +55,9 @@ struct kvm_regs {
>>>>>> #define KVM_ARM_TARGET_AEM_V8                0
>>>>>> #define KVM_ARM_TARGET_FOUNDATION_V8 1
>>>>>> #define KVM_ARM_TARGET_CORTEX_A57    2
>>>>>> +#define KVM_ARM_TARGET_XGENE_V8              3
>>>>>>
>>>>>> -#define KVM_ARM_NUM_TARGETS          3
>>>>>> +#define KVM_ARM_NUM_TARGETS          4
>>>>>>
>>>>>> /* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
>>>>>> #define KVM_ARM_DEVICE_TYPE_SHIFT    0
>>>>>> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
>>>>>> index 2c3ff67..e99b0a5 100644
>>>>>> --- a/arch/arm64/kvm/guest.c
>>>>>> +++ b/arch/arm64/kvm/guest.c
>>>>>> @@ -207,19 +207,29 @@ int __attribute_const__ kvm_target_cpu(void)
>>>>>>     unsigned long implementor = read_cpuid_implementor();
>>>>>>     unsigned long part_number = read_cpuid_part_number();
>>>>>>
>>>>>> -     if (implementor != ARM_CPU_IMP_ARM)
>>>>>> -             return -EINVAL;
>>>>>> -
>>>>>> -     switch (part_number) {
>>>>>> -     case ARM_CPU_PART_AEM_V8:
>>>>>> -             return KVM_ARM_TARGET_AEM_V8;
>>>>>> -     case ARM_CPU_PART_FOUNDATION:
>>>>>> -             return KVM_ARM_TARGET_FOUNDATION_V8;
>>>>>> -     case ARM_CPU_PART_CORTEX_A57:
>>>>>> -             /* Currently handled by the generic backend */
>>>>>> -             return KVM_ARM_TARGET_CORTEX_A57;
>>>>>> +     switch (implementor) {
>>>>>> +     case ARM_CPU_IMP_ARM:
>>>>>> +             switch (part_number) {
>>>>>> +             case ARM_CPU_PART_AEM_V8:
>>>>>> +                     return KVM_ARM_TARGET_AEM_V8;
>>>>>> +             case ARM_CPU_PART_FOUNDATION:
>>>>>> +                     return KVM_ARM_TARGET_FOUNDATION_V8;
>>>>>> +             case ARM_CPU_PART_CORTEX_A57:
>>>>>> +                     return KVM_ARM_TARGET_CORTEX_A57;
>>>>>> +             default:
>>>>>> +                     return -EINVAL;
>>>>>> +             }
>>>>>> +             break;
>>>>>> +     case ARM_CPU_IMP_APM:
>>>>>> +             switch (part_number) {
>>>>>> +             case APM_CPU_PART_POTENZA:
>>>>>> +                     return KVM_ARM_TARGET_XGENE_V8;
>>>>>
>>>>> Why don't we have KVM_ARM_TARGET_XGENE_POTENZA (or something similar)
>>>>> instead? I don't expect all the X-Gene CPUs to be the same forever...
>>>>
>>>> OK, I will rename it to KVM_ARM_TARGET_XGENE_POTENZA.
>>>>
>>>> Does this mean that with every new ARM64 CPU we will have to add a new
>>>> target for KVM ARM64 ?
>>>
>>> Only for different core types, no? Any Cortex-A57 should still behave the same.
>>>
>>>> If so then I think the list of targets will grow very fast.
>>>>
>>>> I also realized that if we add a new target type in KVM ARM64 then we have
>>>> to also update KVMTOOL to use the new target else KVMTOOL fails to
>>>> recognize the target provided by KVM ARM64.
>>>
>>> Right. It might make sense to have a fetch mechanism for the host cpu part. So you can ask KVM for the host cpu type and pass that back in here.
>>>
>>>> Do you think we can have KVM_ARM_TARGET_xxx to represent a common
>>>> target for a family of CPUs from given ARM64 vendor?
>>>
>>> Anything that is compatible is compatible :). I don't know the product roadmaps for X-Gene cores, but you will want to make the field here as coarse grained as possible, while maintaining the guarantee that a guest still behaves the same.
>>
>> Actually, I don't see X-Gene cores changing in-terms of register interface
>> available to EL1 and EL0 in near future. This is the reason why I had named
>> the target as KVM_ARM_TARGET_XGENE_V8.
>
> So where does the v8 come from? Is there any non-ARMv8 XGene? If not, this is v1 really, right? What if we just call it v1 instead? Then when a new core comes up that needs different treatment, we create a new target.
>
> But this really is Marc's call.

I like Alex's suggestion.

How about having KVM_ARM_TARGET_XGENE_V1 now and
KVM_ARM_TARGET_XGENE_V2 in future ?

>
>
> Alex
>

--Anup
