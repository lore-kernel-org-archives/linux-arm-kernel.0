From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 18 Apr 2012 17:15:10 -0700
Subject: [PATCH 01/12] ARM: Exynos: Remove a new bus_type instance for
 Exynos5
In-Reply-To: <1334641595-25301-2-git-send-email-thomas.abraham@linaro.org>
References: <1334641595-25301-1-git-send-email-thomas.abraham@linaro.org>
 <1334641595-25301-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4F8F590E.1000602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> A seperate bus_type instance is not required for Exynos5. The existing bus_type
> instance used with Exynos4 is sufficient for both Exynos4 and Exynos5. This
> also solves issue of uninitialized usage of exynos4_subsys in Exynos4 power

Yes, could be. BTW could you please check that with Jongpill's PM patch
for EXYNOS5? If just single bus_type supports EXYNOS4 and EXYNOS5, I'd
like to change its name to exynos_subsys.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> management code that is reused for Exynos5 also.
> 
> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
> ---
>   arch/arm/mach-exynos/common.c |   19 ++-----------------
>   1 files changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index e9e353b..636d5f8 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -557,25 +557,13 @@ struct bus_type exynos4_subsys = {
>   	.dev_name	= "exynos4-core",
>   };
> 
> -struct bus_type exynos5_subsys = {
> -	.name		= "exynos5-core",
> -	.dev_name	= "exynos5-core",
> -};
> -
>   static struct device exynos4_dev = {
>   	.bus	=&exynos4_subsys,
>   };
> 
> -static struct device exynos5_dev = {
> -	.bus	=&exynos5_subsys,
> -};
> -
>   static int __init exynos_core_init(void)
>   {
> -	if (soc_is_exynos5250())
> -		return subsys_system_register(&exynos5_subsys, NULL);
> -	else
> -		return subsys_system_register(&exynos4_subsys, NULL);
> +	return subsys_system_register(&exynos4_subsys, NULL);
>   }
>   core_initcall(exynos_core_init);
> 
> @@ -662,10 +650,7 @@ static int __init exynos_init(void)
>   {
>   	printk(KERN_INFO "EXYNOS: Initializing architecture\n");
> 
> -	if (soc_is_exynos5250())
> -		return device_register(&exynos5_dev);
> -	else
> -		return device_register(&exynos4_dev);
> +	return device_register(&exynos4_dev);
>   }
> 
>   /* uart registration process */
