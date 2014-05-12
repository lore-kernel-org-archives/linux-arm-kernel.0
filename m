From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 12 May 2014 11:22:11 +0900
Subject: [PATCH v3 3/6] ARM: EXYNOS: Remove soc_is_exynos4/5 from exynos.c
In-Reply-To: <CAOesGMgfHLKLG=O=4kxtpFcMn-U3zmCuYRXdUyB8Xq6FALqc8Q@mail.gmail.com>
References: <1399706287-13919-1-git-send-email-y@samsung.com>
 <1399706287-13919-4-git-send-email-y@samsung.com>
 <CAOesGMgfHLKLG=O=4kxtpFcMn-U3zmCuYRXdUyB8Xq6FALqc8Q@mail.gmail.com>
Message-ID: <53703053.2090404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2014 03:52 PM, Olof Johansson wrote:
> On Sat, May 10, 2014 at 12:18 AM,  <y@samsung.com> wrote:
>> From: Pankaj Dubey <pankaj.dubey@samsung.com>
>>
>> This patch removes usage of soc_is_exynos4/5 from exynos.c.
>> For this we need to separate machine descriptors for exynos4
>> and exynos5. While doing this patch does some consolidation also.
>>
>> CC: Russell King <linux@arm.linux.org.uk>
>> CC: Thomas Abraham <thomas.abraham@linaro.org>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   arch/arm/mach-exynos/exynos.c            |   52 +++++++++++++++++++-----------
>>   arch/arm/plat-samsung/include/plat/cpu.h |    3 --
>>   2 files changed, 33 insertions(+), 22 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
>> index 09063ee..9902e52 100644
>> --- a/arch/arm/mach-exynos/exynos.c
>> +++ b/arch/arm/mach-exynos/exynos.c
>> @@ -202,20 +202,6 @@ static const struct of_device_id exynos_dt_pmu_match[] = {
>>          {},
>>   };
>>
>> -/*
>> - * exynos_map_io
>> - *
>> - * register the standard cpu IO areas
>> - */
>> -static void __init exynos_map_io(void)
>> -{
>> -       if (soc_is_exynos4())
>> -               iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
>> -
>> -       if (soc_is_exynos5())
>> -               iotable_init(exynos5_iodesc, ARRAY_SIZE(exynos5_iodesc));
>> -}
>> -
>>   static void __init exynos_init_io(void)
>>   {
>>          debug_ll_io_init();
>> @@ -224,8 +210,18 @@ static void __init exynos_init_io(void)
>>
>>          /* detect cpu id and rev. */
>>          s5p_init_cpu(S5P_VA_CHIPID);
>> +}
>> +
>> +static void __init exynos5_init_io(void)
>> +{
>> +       exynos_init_io();
>> +       iotable_init(exynos5_iodesc, ARRAY_SIZE(exynos5_iodesc));
>> +}
>>
>> -       exynos_map_io();
>> +static void __init exynos4_init_io(void)
>> +{
>> +       exynos_init_io();
>> +       iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
>>   }
>>
>>   struct bus_type exynos_subsys = {
>> @@ -293,11 +289,15 @@ static void __init exynos_dt_machine_init(void)
>>          of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>   }
>>
>> -static char const *exynos_dt_compat[] __initconst = {
>> +static char const *exynos4_dt_compat[] __initconst = {
>>          "samsung,exynos4",
>>          "samsung,exynos4210",
>>          "samsung,exynos4212",
>>          "samsung,exynos4412",
>> +       NULL
>> +};
>> +
>> +static char const *exynos5_dt_compat[] __initconst = {
>>          "samsung,exynos5",
>>          "samsung,exynos5250",
>>          "samsung,exynos5420",
>> @@ -321,15 +321,29 @@ static void __init exynos_reserve(void)
>>   #endif
>>   }
>>
>> -DT_MACHINE_START(EXYNOS_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
>> +DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
> SAMSUNG EXYNOS5
>
>> +       /* Maintainer: Thomas Abraham <thomas.abraham@linaro.org> */
>> +       /* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
>> +       .smp            = smp_ops(exynos_smp_ops),
>> +       .map_io         = exynos5_init_io,
>> +       .init_early     = exynos_firmware_init,
>> +       .init_machine   = exynos_dt_machine_init,
>> +       .init_late      = exynos_init_late,
>> +       .dt_compat      = exynos5_dt_compat,
>> +       .restart        = exynos_restart,
>> +       .reserve        = exynos_reserve,
>> +MACHINE_END
>> +
>> +
>> +DT_MACHINE_START(EXYNOS4_DT, "SAMSUNG EXYNOS (Flattened Device Tree)")
> SAMSUNG EXYNOS4
>
> ... so you can tell the difference if you for some reason probed with
> the wrong one.
>
> Also, you should order these with 4 before 5.
>

Thanks for review. I will take care of this in next revision.

> -Olof
>


-- 
Best Regards,
Pankaj Dubey
