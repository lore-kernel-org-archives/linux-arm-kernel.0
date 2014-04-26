From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 26 Apr 2014 13:42:11 +0900
Subject: [PATCH v2 01/10] ARM: EXYNOS: Make exynos machine_ops as static
In-Reply-To: <535ACE25.5020503@gmail.com>
References: <1396425058-4012-1-git-send-email-pankaj.dubey@samsung.com>
 <1398429166-5539-1-git-send-email-pankaj.dubey@samsung.com>
 <1398429166-5539-2-git-send-email-pankaj.dubey@samsung.com>
 <535ACE25.5020503@gmail.com>
Message-ID: <CAGcde9GJbHySUo=j1a-SYyRoNEyFrU6tjEE_AV6dLOEJfC-Sjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Tomasz,

Thanks for review and suggestions.

On Sat, Apr 26, 2014 at 6:05 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Pankaj,
>
>
> On 25.04.2014 14:32, Pankaj Dubey wrote:
>>
>> As machine function ops are used only in this file let's make
>> them static.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   arch/arm/mach-exynos/exynos.c |    6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
>> index b32a907..2388ee4 100644
>> --- a/arch/arm/mach-exynos/exynos.c
>> +++ b/arch/arm/mach-exynos/exynos.c
>> @@ -198,7 +198,7 @@ static struct map_desc exynos5_iodesc[] __initdata = {
>>         },
>>   };
>>
>> -void exynos_restart(enum reboot_mode mode, const char *cmd)
>> +static void exynos_restart(enum reboot_mode mode, const char *cmd)
>>   {
>>         struct device_node *np;
>>         u32 val = 0x1;
>> @@ -235,7 +235,7 @@ void __init exynos_cpufreq_init(void)
>>         platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
>>   }
>>
>> -void __init exynos_init_late(void)
>> +static void __init exynos_init_late(void)
>>   {
>>         if (of_machine_is_compatible("samsung,exynos5440"))
>>                 /* to be supported later */
>> @@ -296,7 +296,7 @@ static void __init exynos_map_io(void)
>>                 iotable_init(exynos5250_iodesc,
>> ARRAY_SIZE(exynos5250_iodesc));
>>   }
>>
>> -void __init exynos_init_io(void)
>> +static void __init exynos_init_io(void)
>>   {
>>         debug_ll_io_init();
>>
>>
>
> This patch seems to be irrelevant to the rest of this series. Anyway, the
> changes itself are fine, except that I can see more functions that could be
> made static as well:
>  - exynos_cpuidle_init(),
>  - exynos_cpufreq_init().
>
> In fact, they both could be probably eliminated, as they are just oneliners
> doing things that could be done in exynos_dt_machine_init() directly.
>
> So, if you are doing this kind of cleanup, you could do this as well and
> probably also replace platform_device + platform_device_register() with
> platform_device_register_simple() for cpuidle, to reduce line count and make
> it consistent with cpufreq.
>

OK, I will take care of this.
Also will separate these patches from PMU series.

Thanks,
Pankaj Dubey

> Best regards,
> Tomasz
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
