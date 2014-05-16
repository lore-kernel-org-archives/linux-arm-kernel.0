From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 17 May 2014 08:44:42 +0900
Subject: [PATCH v3] cpufreq: exynos: Fix the compile error
In-Reply-To: <5376A12C.5010407@gmail.com>
References: <000001cf70f0$2e48f930$8adaeb90$@samsung.com>
 <CAKohponFCpNThX1m9n+_96vN=WqN5zqA-+GWMLMLO_z-3p5okA@mail.gmail.com>
 <53769EBD.2000201@samsung.com> <5376A12C.5010407@gmail.com>
Message-ID: <5376A2EA.9050906@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/14 08:37, Tomasz Figa wrote:
> On 17.05.2014 01:26, Kukjin Kim wrote:
>> On 05/16/14 20:07, Viresh Kumar wrote:
>>> On 16 May 2014 15:48, Jonghwan Choi<jhbird.choi@samsung.com>   wrote:
>>>> Commit 7da83a80 ("ARM: EXYNOS: Migrate Exynos specific macros from
>>>> plat to mach") which lands in samsung tree causes build breakage
>>>> for cpufreq-exynos like following:
>>>>
>>>> drivers/cpufreq/exynos-cpufreq.c: In function 'exynos_cpufreq_probe':
>>>> drivers/cpufreq/exynos-cpufreq.c:166:2: error: implicit declaration
>>>> of function 'soc_is_exynos4210'
>>>> [-Werror=implicit-function-declaration]
>>>> drivers/cpufreq/exynos-cpufreq.c:168:2: error: implicit declaration
>>>> of function 'soc_is_exynos4212'
>>>> [-Werror=implicit-function-declaration]
>>>> drivers/cpufreq/exynos-cpufreq.c:168:2: error: implicit declaration
>>>> of function 'soc_is_exynos4412'
>>>> [-Werror=implicit-function-declaration]
>>>> drivers/cpufreq/exynos-cpufreq.c:170:2: error: implicit declaration
>>>> of function 'soc_is_exynos5250'
>>>> [-Werror=implicit-function-declaration]
>>>> cc1: some warnings being treated as errors
>>>> make[2]: *** [drivers/cpufreq/exynos-cpufreq.o] Error 1
>>>> make[2]: *** Waiting for unfinished jobs....
>>>> drivers/cpufreq/exynos4x12-cpufreq.c: In function
>>>> 'exynos4x12_set_clkdiv':
>>>> drivers/cpufreq/exynos4x12-cpufreq.c:118:2: error: implicit
>>>> declaration of function 'soc_is_exynos4212'
>>>> [-Werror=implicit-function-declaration]
>>>> cc1: some warnings being treated as errors
>>>> make[2]: *** [drivers/cpufreq/exynos4x12-cpufreq.o] Error 1
>>>> make[1]: *** [drivers/cpufreq] Error 2
>>>
>>> Blank line here..
>>>
>>>> This fixes above error with getting SoC information via
>>>> of_machine_is_compatible() instead of soc_is_exynosXXXX().
>>>>
>>>> Signed-off-by: Jonghwan Choi<jhbird.choi@samsung.com>
>>>> ---
>>>>    drivers/cpufreq/exynos-cpufreq.c     |   20 +++++++++++++++++---
>>>>    drivers/cpufreq/exynos-cpufreq.h     |    8 ++++++++
>>>>    drivers/cpufreq/exynos4x12-cpufreq.c |   11 ++++-------
>>>>    3 files changed, 29 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/cpufreq/exynos-cpufreq.c
>>>> b/drivers/cpufreq/exynos-cpufreq.c
>>>> index f99cfe2..9aecffef 100644
>>>> --- a/drivers/cpufreq/exynos-cpufreq.c
>>>> +++ b/drivers/cpufreq/exynos-cpufreq.c
>>>> @@ -17,6 +17,7 @@
>>>>    #include<linux/regulator/consumer.h>
>>>>    #include<linux/cpufreq.h>
>>>>    #include<linux/platform_device.h>
>>>> +#include<linux/of.h>
>>>>
>>>>    #include<plat/cpu.h>
>>>>
>>>> @@ -163,11 +164,24 @@ static int exynos_cpufreq_probe(struct
>>>> platform_device *pdev)
>>>>           if (!exynos_info)
>>>>                   return -ENOMEM;
>>>>
>>>> -       if (soc_is_exynos4210())
>>>> +       if (of_machine_is_compatible("samsung,exynos4210")) {
>>>> +               exynos_info->type = EXYNOS_SOC_4210;
>>>> +       } else if (of_machine_is_compatible("samsung,exynos4212")) {
>>>> +               exynos_info->type = EXYNOS_SOC_4212;
>>>> +       } else if (of_machine_is_compatible("samsung,exynos4412")) {
>>>> +               exynos_info->type = EXYNOS_SOC_4212;
>>>
>>> 4412 ?
>>>
>> Yes, I will fix when I apply.
>>
>>>> +       } else if (of_machine_is_compatible("samsung,exynos5250")) {
>>>> +               exynos_info->type = EXYNOS_SOC_5250;
>>>> +       } else {
>>>> +               pr_err("%s: Unknown SoC type\n", __func__);
>>>> +               return -ENODEV;
>>>> +       }
>>>> +
>>>> +       if (exynos_info->type == EXYNOS_SOC_4210)
>>>>                   ret = exynos4210_cpufreq_init(exynos_info);
>>>> -       else if (soc_is_exynos4212() || soc_is_exynos4412())
>>>> +       else if (exynos_info->type == EXYNOS_SOC_4212 ||
>>>> exynos_info->type == EXYNOS_SOC_4412)
>>>>                   ret = exynos4x12_cpufreq_init(exynos_info);
>>>> -       else if (soc_is_exynos5250())
>>>> +       else if (exynos_info->type == EXYNOS_SOC_5250)
>>>>                   ret = exynos5250_cpufreq_init(exynos_info);
>>>>           else
>>>>                   return 0;
>>>
>>> Do this in the first if/else only..
>>
>> Probably, you mean following in above?
>>
>>>> -       if (soc_is_exynos4210())
>>
>> I've applied this with fixing typo you mentioned just now, if any
>> concerns, please kindly let me know.
>
> I think Viresh meant merging the two if/else blocks together, as follows:
>
> 	if (of_machine_is_compatible("samsung,exynos4210")) {
> 		exynos_info->type = EXYNOS_SOC_4210;
> 		ret = exynos4210_cpufreq_init(exynos_info);
> 	} else if (of_machine_is_compatible("samsung,exynos4212")) {
> 		exynos_info->type = EXYNOS_SOC_4212;
> 		ret = exynos4x12_cpufreq_init(exynos_info);
> 	} else if (of_machine_is_compatible("samsung,exynos4412")) {
> 		exynos_info->type = EXYNOS_SOC_4412;
> 		ret = exynos4x12_cpufreq_init(exynos_info);
> 	} else if (of_machine_is_compatible("samsung,exynos5250")) {
> 		exynos_info->type = EXYNOS_SOC_5250;
> 		ret = exynos5250_cpufreq_init(exynos_info);
> 	} else {
> 		pr_err("%s: Unknown SoC type\n", __func__);
> 		return -ENODEV;
> 	}
>
Yeah, I just now realized same thing :(

looks better, the SoC type is only used for 4212/4412 in other place 
though...I will modify as per Viresh's suggestion.

Thanks,
Kukjin
