From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 09 Apr 2014 15:33:57 +0200
Subject: [PATCH V3 11/17] ARM: exynos: cpuidle: Move the power sequence
 call in the cpu_pm notifier
In-Reply-To: <53453A4A.1000704@samsung.com>
References: <1396959579-18268-1-git-send-email-daniel.lezcano@linaro.org>
 <1396959579-18268-12-git-send-email-daniel.lezcano@linaro.org>
 <53453A4A.1000704@samsung.com>
Message-ID: <53454C45.8070004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2014 02:17 PM, Tomasz Figa wrote:
> Hi Daniel,
>
> On 08.04.2014 14:19, Daniel Lezcano wrote:
>> The code to initiate and exit the powerdown sequence is the same in
>> pm.c and
>> cpuidle.c.
>>
>> Let's split the common part in the pm.c and reuse it from the cpu_pm
>> notifier.
>>
>> That is one more step forward to make the cpuidle driver arch
>> indenpendant.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>   arch/arm/mach-exynos/cpuidle.c |   21 ---------------------
>>   arch/arm/mach-exynos/pm.c      |   22 ++++++++++++++++++----
>>   2 files changed, 18 insertions(+), 25 deletions(-)
>
> [snip]
>
>> -static int exynos_pm_suspend(void)
>> +static void exynos_pm_central_suspend(void)
>>   {
>>       unsigned long tmp;
>>
>>       /* Setting Central Sequence Register for power down mode */
>> -
>>       tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
>>       tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
>>       __raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
>> +}
>> +
>> +static int exynos_pm_suspend(void)
>> +{
>> +    unsigned long tmp;
>>
>
> Shouldn't exynos_pm_central_suspend() be called here in place of the
> code being moved to that function?

Right. Good catch !

Thanks

   -- Daniel



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
