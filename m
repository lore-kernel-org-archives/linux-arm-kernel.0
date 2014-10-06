From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 6 Oct 2014 10:15:19 +0200
Subject: [PATCH v8] ARM: EXYNOS: Use MCPM call-backs to support S2R on
 Exynos5420
In-Reply-To: <CAM4voa=oZmqCf5=nD54cbi_fa4iHYh1nvOC0nt9hE=mQmhb3yw@mail.gmail.com>
References: <1412089142-12056-1-git-send-email-a.kesavan@samsung.com>
 <CAM4voa=oZmqCf5=nD54cbi_fa4iHYh1nvOC0nt9hE=mQmhb3yw@mail.gmail.com>
Message-ID: <CABxcv==nvb2HtxdEU-WBkXM1sSQVuawjHenZ42D2ZhHzu_VZpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Abhilash,

On Mon, Oct 6, 2014 at 5:40 AM, Abhilash Kesavan
<kesavan.abhilash@gmail.com> wrote:
> Hi Javier,
>
> [...]
>
>> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
>> index adb36a8..222aa3c 100644
>> --- a/arch/arm/mach-exynos/platsmp.c
>> +++ b/arch/arm/mach-exynos/platsmp.c
>> @@ -137,6 +137,18 @@ void exynos_cpu_power_down(int cpu)
>>   */
>>  void exynos_cpu_power_up(int cpu)
>>  {
>> +       if (cpu == 0 && (of_machine_is_compatible("samsung,exynos5420") ||
>> +               of_machine_is_compatible("samsung,exynos5800"))) {
>> +               /*
>> +                * Bypass power down for CPU0 during suspend. Check for
>> +                * the SYS_PWR_REG value to decide if we are suspending
>> +                * the system.
>> +                */
>> +               int val = __raw_readl(pmu_base_addr +
>> +                               EXYNOS5_ARM_CORE0_SYS_PWR_REG);
>> +               if (!(val & S5P_CORE_LOCAL_PWR_EN))
>> +                       return;
>> +       }
>>         pmu_raw_writel(S5P_CORE_LOCAL_PWR_EN,
>>                         EXYNOS_ARM_CORE_CONFIGURATION(cpu));
>>  }
>
> The above block of code should be in exynos_cpu_power_down(). Can you
> re-test s2r after modifying it ? I have to convert a __raw_readl to
> pmu_raw_readl in this patch as well. Once Vikas re-works the base s2r
> patch I will re-post a v9.
>

Thanks, for the information but unfortunately even after this change I
still have the issue reported in [0]. I also removed the lines from
exynos5420_pm_resume() that you asked Vikash [1].

Which __raw_readl() you had to convert? That is only for consistency
right? Since I see that the __raw_readl() calls are using
pmu_base_addr + offset so it seems to be correct.

I'll test again once you both re-spin your patches then.

> Regards,
> Abhilash

Best regards,
Javier

[0]: http://www.spinics.net/lists/arm-kernel/msg367615.html
[1]: http://www.spinics.net/lists/linux-samsung-soc/msg37561.html
