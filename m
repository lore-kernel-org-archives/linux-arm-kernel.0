From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Mon, 22 Jan 2018 15:13:06 +0000
Subject: [PATCH v2 1/6] arm64: cpufeature: Allow early detect of specific
 features
In-Reply-To: <5cafee50-c2ee-6c04-756c-785cdf822b27@arm.com>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
 <1516190084-18978-2-git-send-email-julien.thierry@arm.com>
 <ce6469ab-b864-fec7-7d97-d44340f5b2e0@arm.com>
 <2f2a406b-fddf-6c30-4052-650f57ac317a@arm.com>
 <2fa17395-d268-5ec9-6033-08ecb7eba44a@arm.com>
 <5cafee50-c2ee-6c04-756c-785cdf822b27@arm.com>
Message-ID: <4a8dc4ec-2762-e1cd-8126-ff44abcb67f2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/01/18 15:01, Julien Thierry wrote:
> 
> 
> On 22/01/18 14:45, Suzuki K Poulose wrote:
>> On 22/01/18 12:21, Julien Thierry wrote:
>>>
>>>
>>> On 22/01/18 12:05, Suzuki K Poulose wrote:
>>>> On 17/01/18 11:54, Julien Thierry wrote:
>>>>> From: Daniel Thompson <daniel.thompson@linaro.org>
>>>>>
>>>>> Currently it is not possible to detect features of the boot CPU
>>>>> until the other CPUs have been brought up.
>>>>>
>>>>> This prevents us from reacting to features of the boot CPU until
>>>>> fairly late in the boot process. To solve this we allow a subset
>>>>> of features (that are likely to be common to all clusters) to be
>>>>> detected based on the boot CPU alone.
>>>>>
>>>>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>>>>> [julien.thierry at arm.com: check non-boot cpu missing early features, avoid
>>>>> ???????????? duplicates between early features and normal
>>>>> ???????????? features]
>>>>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>> ---
>>>>> ? arch/arm64/kernel/cpufeature.c | 69 ++++++++++++++++++++++++++++--------------
>>>>> ? 1 file changed, 47 insertions(+), 22 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>>>> index a73a592..6698404 100644
>>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>>> @@ -52,6 +52,8 @@
>>>>> ? DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>>>>> ? EXPORT_SYMBOL(cpu_hwcaps);
>>>>>
>>>>> +static void __init setup_early_feature_capabilities(void);
>>>>> +
>>>>> ? /*
>>>>> ?? * Flag to indicate if we have computed the system wide
>>>>> ?? * capabilities based on the boot time active CPUs. This
>>>>> @@ -542,6 +544,8 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
>>>>> ????????? init_cpu_ftr_reg(SYS_ZCR_EL1, info->reg_zcr);
>>>>> ????????? sve_init_vq_map();
>>>>> ????? }
>>>>> +
>>>>> +??? setup_early_feature_capabilities();
>>>>> ? }
>>>>>
>>>>> ? static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
>>>>> @@ -846,7 +850,7 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
>>>>> ????????????????????? ID_AA64PFR0_FP_SHIFT) < 0;
>>>>> ? }
>>>>>
>>>>> -static const struct arm64_cpu_capabilities arm64_features[] = {
>>>>> +static const struct arm64_cpu_capabilities arm64_early_features[] = {
>>>>> ????? {
>>>>> ????????? .desc = "GIC system register CPU interface",
>>>>> ????????? .capability = ARM64_HAS_SYSREG_GIC_CPUIF,
>>>>> @@ -857,6 +861,10 @@ static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unus
>>>>> ????????? .sign = FTR_UNSIGNED,
>>>>> ????????? .min_field_value = 1,
>>>>> ????? },
>>>>> +??? {}
>>>>> +};
>>>>> +
>>>>
>>>>
>>>> Julien,
>>>>
>>>> One potential problem with this is that we don't have a way
>>>> to make this work on a "theoretical" system with and without
>>>> GIC system reg interface. i.e, if we don't have the CONFIG
>>>> enabled for using ICC system regs for IRQ flags, the kernel
>>>> could still panic. I understand this is not a "normal" configuration
>>>> but, may be we could make the panic option based on whether
>>>> we actually use the system regs early enough ?
>>>>
>>>
>>> I see, however I'm not sure what happens in the GIC drivers if we have a CPU running with a GICv3 and other CPUs with something else... But of course this is not technically limited by the arm64 capabilities handling.
>>>
>>> What behaviour would you be looking for? A way to prevent the CPU to be brought up instead of panicking?
>>>
>>
>> If we have the CONFIG enabled for using system regs, we can continue
>> to panic the system. Otherwise, we should ignore the mismatch early,
>> as we don't use the system register access unless all boot time active
>> CPUs have it.
>>
> 
> Hmmm, we use the CPUIF (if available) in the first CPU pretty much as soon as we re-enable interrupts in the GICv3 driver, which is way before the other CPUs are brought up.

Isn't this CPUIF access an alternative, patched only when CPUIF feature
enabled ? (which is done only after all the allowed SMP CPUs are brought up )
> 
> other CPUs get to die_early().

Really ? I thought only late CPUs are sent to die_early().

> 
>> In a nutshell, this is an early feature only if the CONFIG is enabled,
>> otherwise should fall back to the normal behavior.
>>
> 
> Maybe we should just not panic and let the mismatching CPUs die.
> It's a system wide feature and linux will try to make the other CPUs match the boot CPU's config anyway.
> 

Suzuki
