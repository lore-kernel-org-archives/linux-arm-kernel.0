From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 10 May 2012 18:09:08 +0900
Subject: [PATCH v2] ARM: Exynos4: read initial state of power domain from
 hw registers
In-Reply-To: <1334061579-8492-1-git-send-email-m.szyprowski@samsung.com>
References: <4F7EE249.30002@mvista.com>
 <1334061579-8492-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <034001cd2e8c$8ed252e0$ac76f8a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Some bootloaders disable unused power domains, so kernel code should
> read the actual state from the hardware registers instead of assuming
> that their initial state is 'on'.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/mach-exynos/pm_domains.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-
> exynos/pm_domains.c
> index 13b3068..26fc47d 100644
> --- a/arch/arm/mach-exynos/pm_domains.c
> +++ b/arch/arm/mach-exynos/pm_domains.c
> @@ -151,9 +151,12 @@ static __init int exynos4_pm_init_power_domain(void)
>  	if (of_have_populated_dt())
>  		return exynos_pm_dt_parse_domains();
> 
> -	for (idx = 0; idx < ARRAY_SIZE(exynos4_pm_domains); idx++)
> -		pm_genpd_init(&exynos4_pm_domains[idx]->pd, NULL,
> -				exynos4_pm_domains[idx]->is_off);
> +	for (idx = 0; idx < ARRAY_SIZE(exynos4_pm_domains); idx++) {
> +		struct exynos_pm_domain *pd = exynos4_pm_domains[idx];
> +		int on = __raw_readl(pd->base + 0x4) & S5P_INT_LOCAL_PWR_EN;
> +
> +		pm_genpd_init(&pd->pd, NULL, !on);
> +	}
> 
>  #ifdef CONFIG_S5P_DEV_FIMD0
>  	exynos_pm_add_dev_to_genpd(&s5p_device_fimd0, &exynos4_pd_lcd0);
> --
> 1.7.1.569.g6f426

As you said, if bootloader changed some hardware setting which is not
expected value in kernel, it should be notified to kernel. But for
pm_domaine->is_off, it should be via DT on EXYNOS now. As you know, the
functionality has been already implemented on dt.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
