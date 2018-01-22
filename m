From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 22 Jan 2018 14:20:28 +0000
Subject: [PATCH v2 1/6] arm64: cpufeature: Allow early detect of specific
 features
In-Reply-To: <973f14ae-df25-f8e0-56e6-0b65e62b64e2@arm.com>
References: <1516190084-18978-1-git-send-email-julien.thierry@arm.com>
 <1516190084-18978-2-git-send-email-julien.thierry@arm.com>
 <ce6469ab-b864-fec7-7d97-d44340f5b2e0@arm.com>
 <2f2a406b-fddf-6c30-4052-650f57ac317a@arm.com>
 <20180122133848.546zixs3crkwvuid@oak.lan>
 <65f82425-977d-49f5-b9c5-b678d90984cf@arm.com>
 <973f14ae-df25-f8e0-56e6-0b65e62b64e2@arm.com>
Message-ID: <cff5dc59-6782-60ab-7bf3-dfac69df8a31@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/01/18 14:14, Julien Thierry wrote:
> 
> 
> On 22/01/18 13:57, Marc Zyngier wrote:
>> On 22/01/18 13:38, Daniel Thompson wrote:
>>> On Mon, Jan 22, 2018 at 12:21:55PM +0000, Julien Thierry wrote:
>>>> On 22/01/18 12:05, Suzuki K Poulose wrote:
>>>>> On 17/01/18 11:54, Julien Thierry wrote:
>>>>>> From: Daniel Thompson <daniel.thompson@linaro.org>
>>>>>>
>>>>>> Currently it is not possible to detect features of the boot CPU
>>>>>> until the other CPUs have been brought up.
>>>>>>
>>>>>> This prevents us from reacting to features of the boot CPU until
>>>>>> fairly late in the boot process. To solve this we allow a subset
>>>>>> of features (that are likely to be common to all clusters) to be
>>>>>> detected based on the boot CPU alone.
>>>>>>
>>>>>> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>>>>>> [julien.thierry at arm.com: check non-boot cpu missing early features, avoid
>>>>>>               duplicates between early features and normal
>>>>>>               features]
>>>>>> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>>>> ---
>>>>>>    arch/arm64/kernel/cpufeature.c | 69
>>>>>> ++++++++++++++++++++++++++++--------------
>>>>>>    1 file changed, 47 insertions(+), 22 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/kernel/cpufeature.c
>>>>>> b/arch/arm64/kernel/cpufeature.c
>>>>>> index a73a592..6698404 100644
>>>>>> --- a/arch/arm64/kernel/cpufeature.c
>>>>>> +++ b/arch/arm64/kernel/cpufeature.c
>>>>>> @@ -52,6 +52,8 @@
>>>>>>    DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
>>>>>>    EXPORT_SYMBOL(cpu_hwcaps);
>>>>>>
>>>>>> +static void __init setup_early_feature_capabilities(void);
>>>>>> +
>>>>>>    /*
>>>>>>     * Flag to indicate if we have computed the system wide
>>>>>>     * capabilities based on the boot time active CPUs. This
>>>>>> @@ -542,6 +544,8 @@ void __init init_cpu_features(struct
>>>>>> cpuinfo_arm64 *info)
>>>>>>            init_cpu_ftr_reg(SYS_ZCR_EL1, info->reg_zcr);
>>>>>>            sve_init_vq_map();
>>>>>>        }
>>>>>> +
>>>>>> +    setup_early_feature_capabilities();
>>>>>>    }
>>>>>>
>>>>>>    static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
>>>>>> @@ -846,7 +850,7 @@ static bool has_no_fpsimd(const struct
>>>>>> arm64_cpu_capabilities *entry, int __unus
>>>>>>                        ID_AA64PFR0_FP_SHIFT) < 0;
>>>>>>    }
>>>>>>
>>>>>> -static const struct arm64_cpu_capabilities arm64_features[] = {
>>>>>> +static const struct arm64_cpu_capabilities arm64_early_features[] = {
>>>>>>        {
>>>>>>            .desc = "GIC system register CPU interface",
>>>>>>            .capability = ARM64_HAS_SYSREG_GIC_CPUIF,
>>>>>> @@ -857,6 +861,10 @@ static bool has_no_fpsimd(const struct
>>>>>> arm64_cpu_capabilities *entry, int __unus
>>>>>>            .sign = FTR_UNSIGNED,
>>>>>>            .min_field_value = 1,
>>>>>>        },
>>>>>> +    {}
>>>>>> +};
>>>>>> +
>>>>>
>>>>>
>>>>> Julien,
>>>>>
>>>>> One potential problem with this is that we don't have a way
>>>>> to make this work on a "theoretical" system with and without
>>>>> GIC system reg interface. i.e, if we don't have the CONFIG
>>>>> enabled for using ICC system regs for IRQ flags, the kernel
>>>>> could still panic. I understand this is not a "normal" configuration
>>>>> but, may be we could make the panic option based on whether
>>>>> we actually use the system regs early enough ?
>>>>>
>>>>
>>>> I see, however I'm not sure what happens in the GIC drivers if we have a CPU
>>>> running with a GICv3 and other CPUs with something else... But of course
>>>> this is not technically limited by the arm64 capabilities handling.
>>>
>>> Shouldn't each CPU be sharing the same GIC anyway? It so its not some
>>> have GICv3+ and some have GICv2. The theoretical system described above
>>> *has* a GICv3+ but some participants in the cluster are not able to
>>> talk to it as like a co-processor.
>>
>> There is some level of confusion between the GIC CPU interface (which is
>> really in the CPU) and the GIC itself. You can easily end-up in a
>> situation where you do have the HW, but it is configured in a way that
>> prevents you from using it. Case in point: GICv3 with GICv2
>> compatibility used in virtualization.
>>
>>> The ARM ARM is a little vague about whether, if a GIC implements a
>>> system register interface, then a core must provide access to it. Even
>>> so, first question is whether such a system is architecture compliant?
>>
>> Again, it is not the GIC that implements the system registers. And no,
>> these system registers are not required to be accessible (see
>> ICC_SRE_EL2.Enable == 0 for example).
>>
>> So I believe there is value in checking those as early as possible, and
>> set the expectations accordingly (such as in [1] and [2]).
>>
> 
> So in the end, if we boot on a CPU that can access ICC_CPUIF, it looks 
> like we'll prevent bringing up the CPUs that cannot access the 
> ICC_CPUIF, 

Correct.

> and if we boot on a CPU that cannot access ICC_CPUIF, 
> everything that gets brought up afterwards will be run on GICv2 
> compatibility mode?

Probably not, as I assume the firmware still gives you the description
of a GICv3, so things will grind to a halt at that point.

> We never run different GIC driver on different CPUs, right?

We don't. And please stop giving people horrible ideas! ;-)

Thanks,

	M.

> In the patch, check_early_cpu_features panics when features don't match, 
> but nothing really prevents us to use cpu_die_early instead.
> 
> Would that solve the issue Suzuki?
> 
> Cheers,
> 


-- 
Jazz is not dead. It just smells funny...
