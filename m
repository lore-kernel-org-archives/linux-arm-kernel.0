From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 04 Apr 2014 11:03:14 +0200
Subject: [PATCH 08/17] ARM: exynos: cpuidle: Move scu_enable in the cpu_pm
 notifier
In-Reply-To: <CAKohpomqrOFL=D-1v40szizp0UsY=fdquthJbr9TuXdE4D8D0A@mail.gmail.com>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>	<1396597683-6969-9-git-send-email-daniel.lezcano@linaro.org>
 <CAKohpomqrOFL=D-1v40szizp0UsY=fdquthJbr9TuXdE4D8D0A@mail.gmail.com>
Message-ID: <533E7552.1080806@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2014 10:57 AM, Viresh Kumar wrote:
> On 4 April 2014 13:17, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> We make the cpuidle code less arch dependent.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   arch/arm/mach-exynos/cpuidle.c |    6 ------
>>   arch/arm/mach-exynos/pm.c      |    3 +++
>>   2 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
>> index 4b090cf..c63ad05 100644
>> --- a/arch/arm/mach-exynos/cpuidle.c
>> +++ b/arch/arm/mach-exynos/cpuidle.c
>> @@ -18,7 +18,6 @@
>>   #include <linux/platform_device.h>
>>
>>   #include <asm/proc-fns.h>
>> -#include <asm/smp_scu.h>
>>   #include <asm/suspend.h>
>>   #include <asm/unified.h>
>>   #include <asm/cpuidle.h>
>> @@ -94,11 +93,6 @@ static int exynos_enter_core0_aftr(struct cpuidle_device *dev,
>>
>>          cpu_pm_enter();
>>          cpu_suspend(0, idle_finisher);
>> -
>> -#ifdef CONFIG_SMP
>> -       if (!soc_is_exynos5250())
>> -               scu_enable(S5P_VA_SCU);
>> -#endif
>>          cpu_pm_exit();
>>
>>          /*
>> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
>> index b2a075e..f43a004 100644
>> --- a/arch/arm/mach-exynos/pm.c
>> +++ b/arch/arm/mach-exynos/pm.c
>> @@ -386,6 +386,9 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
>>                  break;
>>
>>          case CPU_PM_EXIT:
>> +#ifdef CONFIG_SMP
>> +               scu_enable(S5P_VA_SCU);
>
> We used to do this only when: !soc_is_exynos5250().
> Why this changed?

Because the pm_notifier is registered if !soc_is_exynos5250()

>> +#endif
>
> You don't need these #ifdefs here.. How would you reach here on a non
> SMP system?
>
>>                  exynos_cpu_restore_register();
>>                  break;
>>          }
>> --
>> 1.7.9.5
>>
>>
>> _______________________________________________
>> linaro-kernel mailing list
>> linaro-kernel at lists.linaro.org
>> http://lists.linaro.org/mailman/listinfo/linaro-kernel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
