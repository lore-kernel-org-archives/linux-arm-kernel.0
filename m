From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 06 Apr 2012 16:32:09 +0400
Subject: [PATCH] ARM: Exynos4: read initial state of power domain from
 hw registers
In-Reply-To: <1333699222-16270-1-git-send-email-m.szyprowski@samsung.com>
References: <1333699222-16270-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4F7EE249.30002@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06-04-2012 12:00, Marek Szyprowski wrote:

> Some bootloadered

    Bootloaders?

> disable unused power domains, so kernel code should
> read the actual state from the hardware registers instead of assuming
> that their initial state is 'on'.

> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
> ---
>   arch/arm/mach-exynos/pm_domains.c |    8 +++++---
>   1 files changed, 5 insertions(+), 3 deletions(-)

> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> index 13b3068..b5b92e8 100644
> --- a/arch/arm/mach-exynos/pm_domains.c
> +++ b/arch/arm/mach-exynos/pm_domains.c
> @@ -151,9 +151,11 @@ static __init int exynos4_pm_init_power_domain(void)
>   	if (of_have_populated_dt())
>   		return exynos_pm_dt_parse_domains();
>
> -	for (idx = 0; idx<  ARRAY_SIZE(exynos4_pm_domains); idx++)
> -		pm_genpd_init(&exynos4_pm_domains[idx]->pd, NULL,
> -				exynos4_pm_domains[idx]->is_off);
> +	for (idx = 0; idx<  ARRAY_SIZE(exynos4_pm_domains); idx++) {
> +		struct exynos_pm_domain *pd = exynos4_pm_domains[idx];
> +		int on = __raw_readl(pd->base + 0x4)&  S5P_INT_LOCAL_PWR_EN;

    Empty line wouldn't hurt here.

> +		pm_genpd_init(&pd->pd, NULL, !on);
> +	}

WBR, Sergei
