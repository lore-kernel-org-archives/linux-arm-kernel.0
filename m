From: r.sh.open@gmail.com (Rahul Sharma)
Date: Fri, 3 Jan 2014 14:54:26 +0530
Subject: [PATCH 1/7] ARM: EXYNOS: initial board support for exynos5260 SoC
In-Reply-To: <2452273.S9E2sU17uX@amdc1227>
References: <1386345391-23482-1-git-send-email-rahul.sharma@samsung.com>
 <1386345391-23482-2-git-send-email-rahul.sharma@samsung.com>
 <2452273.S9E2sU17uX@amdc1227>
Message-ID: <CAPdUM4MHZz4z6D8VtyAAA0T1znQpeTeC-NR1shMBMJwmJ3_fqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

Sorry for responding late.

On 10 December 2013 21:27, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Pankaj, Rahul, Arun,
>
> In addition to issues already pointed by Sachin, please also see my
> comments inline.
>
> On Friday 06 of December 2013 21:26:25 Rahul Sharma wrote:
>> From: Pankaj Dubey <pankaj.dubey@samsung.com>
>>
>> This patch add basic arch side support for exynos5260 SoC.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
>> ---
>>  arch/arm/mach-exynos/Kconfig                 |    9 +++++++++
>>  arch/arm/mach-exynos/common.c                |   19 ++++++++++++++++++-
>>  arch/arm/mach-exynos/cpuidle.c               |    2 +-
>>  arch/arm/mach-exynos/include/mach/map.h      |    1 +
>>  arch/arm/mach-exynos/include/mach/regs-pmu.h |    4 ++++
>>  arch/arm/mach-exynos/mach-exynos5-dt.c       |    1 +
>>  arch/arm/plat-samsung/include/plat/cpu.h     |    8 ++++++++
>>  arch/arm/plat-samsung/include/plat/map-s5p.h |    1 +
>>  8 files changed, 43 insertions(+), 2 deletions(-)
> [snip]
>> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
>> index ddbfe87..405c11a 100644
>> --- a/arch/arm/mach-exynos/cpuidle.c
>> +++ b/arch/arm/mach-exynos/cpuidle.c
>> @@ -120,7 +120,7 @@ static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
>>       cpu_suspend(0, idle_finisher);
>>
>>  #ifdef CONFIG_SMP
>> -     if (!soc_is_exynos5250())
>> +     if (!soc_is_exynos5250() || soc_is_exynos5260())
>
> The added OR condition doesn't affect the if condition in any way, because
> when running on Exynos5260, soc_is_exynos5250() will return false and make
> the whole condition evaluate to true.
>
> Shouldn't it be
>
>         if (!soc_is_exynos5250() && !soc_is_exynos5260())
>
> if Exynos5260 doesn't need scu_enable(), or left as is if it needs?
>

Actually we don't need to call scu_enable() for 5260. Hence leaving it as it is.

>>               scu_enable(S5P_VA_SCU);
>>  #endif
>>       cpu_pm_exit();
>> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
>> index 7b046b5..bd6fa02 100644
>> --- a/arch/arm/mach-exynos/include/mach/map.h
>> +++ b/arch/arm/mach-exynos/include/mach/map.h
>> @@ -29,6 +29,7 @@
>>  #define EXYNOS4210_PA_SYSRAM_NS              0x0203F000
>>  #define EXYNOS4x12_PA_SYSRAM_NS              0x0204F000
>>  #define EXYNOS5250_PA_SYSRAM_NS              0x0204F000
>> +#define EXYNOS5260_PA_SYSRAM_NS              0x02073000
>>
>>  #define EXYNOS_PA_CHIPID             0x10000000
>>
>> diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
>> index 2cdb63e..09ae29a 100644
>> --- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
>> +++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
>> @@ -234,6 +234,10 @@
>>
>>  #define EXYNOS5_SYS_WDTRESET                                 (1 << 20)
>>
>> +#define EXYNOS5260_A7_WDTRST                                 (1 << 24)
>> +#define EXYNOS5260_A15_WDTRST                                        (1 << 23)
>> +#define EXYNOS5260_SYS_WDTRESET      (EXYNOS5260_A7_WDTRST || EXYNOS5260_A15_WDTRST)
>> +
>
> Are these definitions needed? I don't see any user in this patch.
>

Removed these definitions.

Regards,
Rahul Sharma.

> Best regards,
> Tomasz
>
