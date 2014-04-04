From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 04 Apr 2014 17:28:08 +0200
Subject: [PATCH V2 02/17] ARM: exynos: cpuidle: use cpuidle_register
In-Reply-To: <1396618989-2897-3-git-send-email-daniel.lezcano@linaro.org>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
 <1396618989-2897-3-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <4570358.K4hZOIqT9V@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 04, 2014 03:42:54 PM Daniel Lezcano wrote:
> Use the cpuidle generic function 'cpuidle_register'. That saves us from some
> extra lines of code and unneeded variables.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/mach-exynos/cpuidle.c |   18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
> index 9623a05..b7cd75b 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -59,8 +59,6 @@
>  #define PWR_CTRL2_CORE2_UP_RATIO		(1 << 4)
>  #define PWR_CTRL2_CORE1_UP_RATIO		(1 << 0)
>  
> -static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
> -
>  /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
>  static void exynos4_set_wakeupmask(void)
>  {
> @@ -211,8 +209,7 @@ static struct cpuidle_driver exynos4_idle_driver = {
>  
>  static int exynos_cpuidle_probe(struct platform_device *pdev)
>  {
> -	int cpu_id, ret;
> -	struct cpuidle_device *device;
> +	int ret;
>  
>  	if (soc_is_exynos5250())
>  		exynos5_core_down_clk();
> @@ -220,23 +217,12 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
>  	if (soc_is_exynos5440())
>  		exynos4_idle_driver.state_count = 1;
>  
> -	ret = cpuidle_register_driver(&exynos4_idle_driver);
> +	ret = cpuidle_register(&exynos4_idle_driver, NULL);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register cpuidle driver\n");
>  		return ret;
>  	}
>  
> -	for_each_online_cpu(cpu_id) {

cpuidle_register() does setup for_each_possible_cpu().  This is a good
thing and your patch has a nice bugfix side effect that is worth mentioning
in the patch description IMHO.

> -		device = &per_cpu(exynos4_cpuidle_device, cpu_id);
> -		device->cpu = cpu_id;
> -
> -		ret = cpuidle_register_device(device);
> -		if (ret) {
> -			dev_err(&pdev->dev, "failed to register cpuidle device\n");
> -			return ret;
> -		}
> -	}
> -
>  	return 0;
>  }

Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
