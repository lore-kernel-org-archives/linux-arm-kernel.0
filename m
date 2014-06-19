From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Thu, 19 Jun 2014 17:53:53 +0530
Subject: [PATCH] arm: exynos: Support cluster power off on exynos5420/5800
In-Reply-To: <alpine.LFD.2.11.1406181132110.16842@knanqh.ubzr>
References: <1403104722-14848-1-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1406181132110.16842@knanqh.ubzr>
Message-ID: <CAM4voameJ+zbMSr+OhSVbp=nAX9MzBJWrZaB-o3S6nuN=X09xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Wed, Jun 18, 2014 at 9:10 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Wed, 18 Jun 2014, Abhilash Kesavan wrote:
>
>> Turning off a cluster when all 4 cores of the cluster are powered off
>> saves power significantly. Powering off the A15 L2 alone gives around
>> 100mW in savings. Add support for powering off the A15/A7 clusters on
>> exynos5420/5800.
>>
>> The patch enables specific register bits which ensure that:
>>    - cluster L2 will be turned on before the first man is powered up.
>>    - last man will be turned off before the cluster L2 is turned off.
>>    - core is powered down before powering it up.
>>
>> Remove the exynos_cluster_power_control function completely as we can
>> rely on the above mentioned bits rather than polling the cluster power
>> status register.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>
> Minor nit below:
>
>> @@ -342,6 +318,26 @@ static int __init exynos_mcpm_init(void)
>>       pr_info("Exynos MCPM support installed\n");
>>
>>       /*
>> +      * On Exynos5420/5800 for the A15 and A7 clusters:
>> +      *
>> +      * EXYNOS5420_ENABLE_AUTOMATIC_CORE_DOWN ensures that all the cores
>> +      * in a cluster are turned off before turning off the cluster L2.
>> +      *
>> +      * EXYNOS5420_USE_ARM_CORE_DOWN_STATE ensures that a cores is powered
>> +      * off before waking it up.
>> +      *
>> +      * EXYNOS5420_USE_L2_COMMON_UP_STATE ensures that cluster L2 will be
>> +      * turned on before the first man is powered up.
>> +      */
>> +     for (i = 0; i < EXYNOS5420_NR_CLUSTERS; i++) {
>> +             value = __raw_readl(EXYNOS_COMMON_CONFIGURATION(i) + 0x8);
>> +             value |= EXYNOS5420_ENABLE_AUTOMATIC_CORE_DOWN |
>> +                      EXYNOS5420_USE_ARM_CORE_DOWN_STATE    |
>> +                      EXYNOS5420_USE_L2_COMMON_UP_STATE;
>> +             __raw_writel(value, EXYNOS_COMMON_CONFIGURATION(i) + 0x8);
>
> Surely you can add another define in mach-exynos/regs-pmu.h to better
> identify this register instead of EXYNOS_COMMON_CONFIGURATION()+8 ?
>
> After that, you may add:
>
> Acked-by: Nicolas Pitre <nico@linaro.org>
Thanks. Will fix and post v2 with your ack.

Regards,
Abhilash
>
>
> Nicolas
