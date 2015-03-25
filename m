From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 25 Mar 2015 10:40:12 +0100
Subject: [PATCH RFC/RFT 5/6] ARM: Exynos: migrate DCSCB to the new MCPM
 backend abstraction
In-Reply-To: <alpine.LFD.2.11.1503241913040.27567@knanqh.ubzr>
References: <1426701893-25589-1-git-send-email-nicolas.pitre@linaro.org>
 <1426701893-25589-6-git-send-email-nicolas.pitre@linaro.org>
 <alpine.LFD.2.11.1503241913040.27567@knanqh.ubzr>
Message-ID: <5512827C.7020301@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2015 12:24 AM, Nicolas Pitre wrote:
> On Wed, 18 Mar 2015, Nicolas Pitre wrote:
>
>> The custom suspend callback is removed for this change. That includes
>> the dubious call to exynos_cpu_power_up(() that was present at the end
>> of exynos_suspend().
>
> After testing on actual hardware, it turns out that this call is
> important.  This patch is therefore amended with the following:
>
> diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
> index d4bbbfb5fe..9bdf54795f 100644
> --- a/arch/arm/mach-exynos/mcpm-exynos.c
> +++ b/arch/arm/mach-exynos/mcpm-exynos.c
> @@ -152,6 +152,12 @@ static int exynos_wait_for_powerdown(unsigned int cpu, unsigned int cluster)
>   	return -ETIMEDOUT; /* timeout */
>   }
>
> +static void exynos_cpu_is_up(unsigned int cpu, unsigned int cluster)
> +{
> +	/* especially when resuming: make sure power control is set */
> +	exynos_cpu_powerup(cpu, cluster);
> +}
> +
>   static const struct mcpm_platform_ops exynos_power_ops = {
>   	.cpu_powerup		= exynos_cpu_powerup,
>   	.cluster_powerup	= exynos_cluster_powerup,
> @@ -160,6 +166,7 @@ static const struct mcpm_platform_ops exynos_power_ops = {
>   	.cpu_cache_disable	= exynos_cpu_cache_disable,
>   	.cluster_cache_disable	= exynos_cluster_cache_disable,
>   	.wait_for_powerdown	= exynos_wait_for_powerdown,
> +	.cpu_is_up		= exynos_cpu_is_up,
>   };
>
>   /*
>
> The whole commit now appears as follows in my git tree:
>
> commit 0d86b0b4cf869fa48d96bde231b9d04ea68b6422
> Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date:   Mon Mar 16 17:16:07 2015 -0400
>
>      ARM: Exynos: migrate DCSCB to the new MCPM backend abstraction
>
>      The custom suspend callback is removed for this change. The extra call
>      to exynos_cpu_power_up(() that was present at the end of exynos_suspend()
>      is now relocated to the cpu_is_up callback.
>
>      Signed-off-by: Nicolas Pitre <nico@linaro.org>

Tested on exynos5800 (chromebook2).

Tested-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
