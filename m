From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 08 Jul 2014 23:15:21 +0900
Subject: [PATCH 6/6] ARM: EXYNOS: Register cpuidle device only on
 Exynos4210 and 5250
In-Reply-To: <1403618235-19353-7-git-send-email-t.figa@samsung.com>
References: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
 <1403618235-19353-7-git-send-email-t.figa@samsung.com>
Message-ID: <038b01cf9ab7$0de5a440$29b0ecc0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Currently, the Exynos cpuidle driver works correctly only on Exynos4210
> and 5250. Trying to use it with just one CPU online on any other Exynos
> SoC will lead to system failure, due to unsupported AFTR mode on other
> SoCs. This patch fixes the problem by registering the driver only on
> supported SoCs and letting others simply use default WFI mode until
> support for them is added.
> 
Hmm...I thought other SoCs have no problem on cpuidle except exynos5420 and
exynos5440....something like this would be helpful to avoid system failure.
But unfortunately this conflicts with Pankaj's cleanup cpufreq_init() and
cpuidle_init() patch you've reviewed and I've applied in my local...

I'm going to check which exynos is ok on cpuidle and then sort them out.

Thanks,
Kukjin

> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/mach-exynos/exynos.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
> index f38cf7c..176bbf5 100644
> --- a/arch/arm/mach-exynos/exynos.c
> +++ b/arch/arm/mach-exynos/exynos.c
> @@ -173,10 +173,8 @@ static struct platform_device exynos_cpuidle = {
> 
>  void __init exynos_cpuidle_init(void)
>  {
> -	if (soc_is_exynos5440())
> -		return;
> -
> -	platform_device_register(&exynos_cpuidle);
> +	if (soc_is_exynos4210() || soc_is_exynos5250())
> +		platform_device_register(&exynos_cpuidle);
>  }
> 
>  void __init exynos_cpufreq_init(void)
> --
> 1.9.3
