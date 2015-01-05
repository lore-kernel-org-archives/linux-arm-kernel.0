From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 05 Jan 2015 15:36:44 +0530
Subject: [PATCH] ARM: EXYNOS: do not try to map PMU for exynos5440
In-Reply-To: <1420451533.15910.19.camel@collabora.co.uk>
References: <1420449268-24707-1-git-send-email-pankaj.dubey@samsung.com>
 <1420451533.15910.19.camel@collabora.co.uk>
Message-ID: <54AA6234.400@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 05 January 2015 03:22 PM, Sjoerd Simons wrote:
> On Mon, 2015-01-05 at 14:44 +0530, Pankaj Dubey wrote:
>> Commit id: 2e94ac42898f84d76e3c21dd91bc is not taking care
>> of mapping of exynos5440 PMU register which will result in kernel panic
>> on exynos5440.
>>
>> As exynos5440 DTS does not have PMU node, and also we are skipping
>> exynos_pm_init in case of exynos5440, let's avoid mapping of exynos5440 PMU.
>
>
>> Reported-by: Ming Lei <tom.leiming@gmail.com>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   arch/arm/mach-exynos/exynos.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
>> index c13d083..1891b8c 100644
>> --- a/arch/arm/mach-exynos/exynos.c
>> +++ b/arch/arm/mach-exynos/exynos.c
>> @@ -208,7 +208,8 @@ static void __init exynos_init_irq(void)
>>   	 * DT is not unflatten so we can't use DT APIs before
>>   	 * init_irq
>>   	 */
>> -	exynos_map_pmu();
>> +	if (!of_machine_is_compatible("samsung,exynos5440"))
>> +		exynos_map_pmu();
>>   }
>>
>>   static void __init exynos_dt_machine_init(void)
>
> Why the blacklist approach rather then simply making exynos_map_pmu exit
> rather then panicing if it couldn't find a pmu node in the dts?
>

exynos_map_pmu is panicking if it fails to iomap PMU, as for most of 
exynos SoCs PMU based address is MUST for secondary core bootup in 
platsmp.c, but with exynos5440 it is not the same case. In-fact 
exynos_pm_init is also bypassed for exynos5440. For the same reason I 
adopted this approach rather removing panic from exynos_map_pmu.

Thanks,
Pankaj Dubey
>
