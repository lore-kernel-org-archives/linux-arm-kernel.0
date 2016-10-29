From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sat, 29 Oct 2016 10:50:56 +0800
Subject: [PATCH v2 3/4] arm64: arch_timer: Work around Erratum
 Hisilicon-161601
In-Reply-To: <8267644f-c488-2d02-3dd0-c7d0ed23babf@arm.com>
References: <1477553651-13428-1-git-send-email-dingtianhong@huawei.com>
 <1477553651-13428-3-git-send-email-dingtianhong@huawei.com>
 <16d8f329-3413-11da-6f2a-8b1a95c85352@arm.com>
 <44cf2916-7c81-5cdf-d113-f99326eae2c6@huawei.com>
 <8267644f-c488-2d02-3dd0-c7d0ed23babf@arm.com>
Message-ID: <437358ac-fea5-80ff-220d-01d35f150d08@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/10/27 20:23, Marc Zyngier wrote:
> On 27/10/16 13:17, Ding Tianhong wrote:
>>
>>
>> On 2016/10/27 18:58, Marc Zyngier wrote:
>>> On 27/10/16 08:34, Ding Tianhong wrote:
>>>> Erratum Hisilicon-161601 says that the ARM generic timer counter "has the
>>>> potential to contain an erroneous value when the timer value changes".
>>>> Accesses to TVAL (both read and write) are also affected due to the implicit counter
>>>> read.  Accesses to CVAL are not affected.
>>>>
>>>> The workaround is to reread the system count registers until the value of the second
>>>> read is larger than the first one by less than 32, the system counter can be guaranteed
>>>> not to return wrong value twice by back-to-back read and the error value is always larger
>>>> than the correct one by 32. Writes to TVAL are replaced with an equivalent write to CVAL.
>>>>
>>>> The workaround is enabled if the hisilicon,erratum-161601 property is found in
>>>> the timer node in the device tree.  This can be overridden with the
>>>> clocksource.arm_arch_timer.hisilicon-161601 boot parameter, which allows KVM
>>>> users to enable the workaround until a mechanism is implemented to
>>>> automatically communicate this information.
>>>>
>>>> Fix some description for fsl erratum a008585.
>>>>
>>>> v2: Significant rework based on feedback, including seperate the fsl erratum a008585
>>>>     to another patch, update the erratum name and remove unwanted code.
>>>>
>>>> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
>>>> ---
>>>>  Documentation/arm64/silicon-errata.txt |  1 +
>>>>  Documentation/kernel-parameters.txt    |  9 ++++
>>>>  arch/arm64/include/asm/arch_timer.h    | 28 ++++++++++-
>>>>  drivers/clocksource/Kconfig            | 14 +++++-
>>>>  drivers/clocksource/arm_arch_timer.c   | 88 ++++++++++++++++++++++++++--------
>>>>  5 files changed, 118 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
>>>> index 405da11..70c5d5e 100644
>>>> --- a/Documentation/arm64/silicon-errata.txt
>>>> +++ b/Documentation/arm64/silicon-errata.txt
>>>> @@ -63,3 +63,4 @@ stable kernels.
>>>>  | Cavium         | ThunderX SMMUv2 | #27704          | N/A		       |
>>>>  |                |                 |                 |                         |
>>>>  | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585     |
>>>> +| Hisilicon      | Hip05/Hip06/Hip07 | #161601       | HISILICON_ERRATUM_161601|
>>>
>>> I've already commented on the alignment. Please read my initial review.
>>>
>>
>> It sees misunderstood, fix it this time.
>>
>>>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
>>>> index 6fa1d8a..735b4b6 100644
>>>> --- a/Documentation/kernel-parameters.txt
>>>> +++ b/Documentation/kernel-parameters.txt
>>>> @@ -707,6 +707,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>>>>  			erratum.  If unspecified, the workaround is
>>>>  			enabled based on the device tree.
>>>>  
>>>> +	clocksource.arm_arch_timer.hisilicon-161601=
>>>> +			[ARM64]
>>>> +			Format: <bool>
>>>> +			Enable/disable the workaround of Hisilicon
>>>> +			erratum 161601.  This can be useful for KVM
>>>> +			guests, if the guest device tree doesn't show the
>>>> +			erratum.  If unspecified, the workaround is
>>>> +			enabled based on the device tree.
>>>> +
>>>>  	clearcpuid=BITNUM [X86]
>>>>  			Disable CPUID feature X for the kernel. See
>>>>  			arch/x86/include/asm/cpufeatures.h for the valid bit
>>>> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
>>>> index 118719d8..49b3041 100644
>>>> --- a/arch/arm64/include/asm/arch_timer.h
>>>> +++ b/arch/arm64/include/asm/arch_timer.h
>>>> @@ -29,7 +29,7 @@
>>>>  
>>>>  #include <clocksource/arm_arch_timer.h>
>>>>  
>>>> -#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585)
>>>> +#if IS_ENABLED(CONFIG_FSL_ERRATUM_A008585) || IS_ENABLED(CONFIG_HISILICON_ERRATUM_161601)
>>>>  extern struct static_key_false arch_timer_read_ool_enabled;
>>>>  #define needs_timer_erratum_workaround() \
>>>>  	static_branch_unlikely(&arch_timer_read_ool_enabled)
>>>> @@ -65,11 +65,35 @@ extern struct arch_timer_erratum_workaround *erratum_workaround;
>>>>  	_new;						\
>>>>  })
>>>>  
>>>> +
>>>> +
>>>> +/*
>>>> + * The number of retries is an arbitrary value well beyond the highest number
>>>> + * of iterations the loop has been observed to take.
>>>> + * Verify whether the value of the second read is larger than the first by
>>>> + * less than 32 is the only way to confirm the value is correct, the system
>>>> + * counter can be guaranteed not to return wrong value twice by back-to-back read
>>>> + * and the error value is always larger than the correct one by 32.
>>>> + */
>>>> +#define __hisi_161601_read_reg(reg) ({				\
>>>> +	u64 _old, _new;						\
>>>> +	int _retries = 200;					\
>>>
>>> Please document how this value was found (either in the code or in the
>>> commit message).
>>
>> It really difficult to give the accurate standard, theoretically the error should not happened
>> twice together, so maybe 2 is enough here, I just give a arbitrary value.
>>
>>>
>>>> +								\
>>>> +	do {							\
>>>> +		_old = read_sysreg(reg);			\
>>>> +		_new = read_sysreg(reg);			\
>>>> +		_retries--;					\
>>>> +	} while (unlikely((_new - _old) >> 5) && _retries);	\
>>>> +								\
>>>> +	WARN_ON_ONCE(!_retries);				\
>>>> +	_new;							\
>>>> +})
>>>
>>> Same remark as in the previous patch.
>>>
>>
>> I think the sentence *Verify whether the value of the second read is larger than the first by
>> less than 32 is the only way to confirm the value is correct* could explain why should *(_new - _old) >> 5*.
>> it is the same as (_new - _old)/32, also mean the _new should never bigger than _old more than 32.
> 
> This is not about the explanation of the erratum, but about the location
> of the #define, which can be made private to the .c file instead of
> being globally visible.
> 

Ok, update it .

Thanks
Ding

> Thanks,
> 
> 	M.
> 
