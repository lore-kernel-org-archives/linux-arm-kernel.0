From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 22 Jul 2013 06:36:46 +0200
Subject: [PATCH 2/4] ARM: exynos: cpuidle: Use the common cpuidle register
 routine
In-Reply-To: <4097491.3y6BBYmzze@amdc1032>
References: <1374152070-21008-1-git-send-email-daniel.lezcano@linaro.org>
 <1374152070-21008-2-git-send-email-daniel.lezcano@linaro.org>
 <4097491.3y6BBYmzze@amdc1032>
Message-ID: <51ECB6DE.9060701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2013 06:03 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Thursday, July 18, 2013 02:54:28 PM Daniel Lezcano wrote:
>> Now we have the same routine than the one handled by the cpuidle framework.
> 
> Small nitpick:
> 
> To be exact the routine is not the same, on error cpuidle_register() does
> complete unregister operation of the cpuidle driver, exynos4_init_cpuidle()
> just stops the registration procedure. 
> 
> The change itself is okay but the patch description could be better.

Ok, I will fix the changelog.

> Anyway all patches (#1-4) look fine to me. Thanks for this work.

Thanks for the review. I assume it is an acked-by right ?

> Best regards,

Kukjin,

shall I take the patchset in my tree ?

Thanks
  -- Daniel

> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>  
>> Let's use it.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  arch/arm/mach-exynos/cpuidle.c |   24 +-----------------------
>>  1 file changed, 1 insertion(+), 23 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
>> index cc4b097..d8fc1a2 100644
>> --- a/arch/arm/mach-exynos/cpuidle.c
>> +++ b/arch/arm/mach-exynos/cpuidle.c
>> @@ -41,8 +41,6 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
>>  				struct cpuidle_driver *drv,
>>  				int index);
>>  
>> -static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
>> -
>>  static struct cpuidle_driver exynos4_idle_driver = {
>>  	.name			= "exynos4_idle",
>>  	.owner			= THIS_MODULE,
>> @@ -188,29 +186,9 @@ static void __init exynos5_core_down_clk(void)
>>  
>>  static int __init exynos4_init_cpuidle(void)
>>  {
>> -	int cpu_id, ret;
>> -	struct cpuidle_device *device;
>> -
>>  	if (soc_is_exynos5250())
>>  		exynos5_core_down_clk();
>>  
>> -	ret = cpuidle_register_driver(&exynos4_idle_driver);
>> -	if (ret) {
>> -		printk(KERN_ERR "CPUidle failed to register driver\n");
>> -		return ret;
>> -	}
>> -
>> -	for_each_online_cpu(cpu_id) {
>> -		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
>> -		device->cpu = cpu_id;
>> -
>> -		ret = cpuidle_register_device(device);
>> -		if (ret) {
>> -			printk(KERN_ERR "CPUidle register device failed\n");
>> -			return ret;
>> -		}
>> -	}
>> -
>> -	return 0;
>> +	return cpuidle_register(&exynos4_idle_driver, NULL);
>>  }
>>  device_initcall(exynos4_init_cpuidle);
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
