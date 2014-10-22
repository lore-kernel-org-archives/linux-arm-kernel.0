From: chaiw.fnst@cn.fujitsu.com (Chai Wen)
Date: Wed, 22 Oct 2014 19:22:52 +0800
Subject: [PATCH 2/2] ARM: perf: armv7: wrap unsupported arch init functions
 via micro
In-Reply-To: <20141022110128.GE22642@leverpostej>
References: <1413966107-11881-1-git-send-email-chaiw.fnst@cn.fujitsu.com>
 <1413966107-11881-2-git-send-email-chaiw.fnst@cn.fujitsu.com>
 <20141022110128.GE22642@leverpostej>
Message-ID: <5447938C.5010304@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2014 07:01 PM, Mark Rutland wrote:

> Hi,
> 
> On Wed, Oct 22, 2014 at 09:21:47AM +0100, chai wen wrote:
>> Signed-off-by: chai wen <chaiw.fnst@cn.fujitsu.com>
>> ---
>>  arch/arm/kernel/perf_event_v7.c |   52 +++++++++-----------------------------
>>  1 files changed, 13 insertions(+), 39 deletions(-)
> 
> I'm currently in the process of decoupling perf_event_{xscale,v6,v7}.c,
> which will result in the removal of these stubs and for the ARMv7,
> ARMv6, and XScale perf backends.
> 
> I haven't yet posted all the patches, but the basic idea is to make the
> arm_pmu code stateless and turn it into a library used by each of the
> three backends mentioned above. Each would have their own pmu_probe_info
> table (introduced in [1]), and would support the platform device IDs
> introduced in commit 253d8c3d2518ca6f (arm: perf: add more specific
> platform device IDs). The stubs would no longer be necessary.
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-October/295822.html


Hi Mark

Got it.

Thanks for your information.
Your patches looks reasonable, I am OK with it.

thanks
chai wen

> 
> Thanks,
> Mark.
> 
>>
>> diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
>> index f66a9b8..6c088e8 100644
>> --- a/arch/arm/kernel/perf_event_v7.c
>> +++ b/arch/arm/kernel/perf_event_v7.c
>> @@ -1459,43 +1459,17 @@ static int krait_pmu_init(struct arm_pmu *cpu_pmu)
>>  	return 0;
>>  }
>>  #else
>> -static inline int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
>> -{
>> -	return -ENODEV;
>> -}
>> -
>> -static inline int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
>> -{
>> -	return -ENODEV;
>> -}
>> -
>> -static inline int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
>> -{
>> -	return -ENODEV;
>> -}
>> -
>> -static inline int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
>> -{
>> -	return -ENODEV;
>> -}
>> -
>> -static inline int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
>> -{
>> -	return -ENODEV;
>> -}
>> -
>> -static inline int armv7_a12_pmu_init(struct arm_pmu *cpu_pmu)
>> -{
>> -	return -ENODEV;
>> -}
>> -
>> -static inline int armv7_a17_pmu_init(struct arm_pmu *cpu_pmu)
>> -{
>> -	return -ENODEV;
>> -}
>> -
>> -static inline int krait_pmu_init(struct arm_pmu *cpu_pmu)
>> -{
>> -	return -ENODEV;
>> -}
>> +#define WRAP_UNSUPPORTED_INIT(__FUNC)                           \
>> +static inline int __FUNC(struct arm_pmu *cpu_pmu)               \
>> +{                                                               \
>> +        return -ENODEV;                                         \
>> +}
>> +WRAP_UNSUPPORTED_INIT(armv7_a8_pmu_init);
>> +WRAP_UNSUPPORTED_INIT(armv7_a9_pmu_init);
>> +WRAP_UNSUPPORTED_INIT(armv7_a5_pmu_init);
>> +WRAP_UNSUPPORTED_INIT(armv7_a15_pmu_init);
>> +WRAP_UNSUPPORTED_INIT(armv7_a7_pmu_init);
>> +WRAP_UNSUPPORTED_INIT(armv7_a12_pmu_init);
>> +WRAP_UNSUPPORTED_INIT(armv7_a17_pmu_init);
>> +WRAP_UNSUPPORTED_INIT(krait_pmu_init);
>>  #endif	/* CONFIG_CPU_V7 */
>> -- 
>> 1.7.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> .
> 



-- 
Regards

Chai Wen
