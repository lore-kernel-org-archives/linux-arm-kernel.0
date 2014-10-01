From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 01 Oct 2014 18:18:58 +0200
Subject: [PATCH v2 2/4] ARM: exynos: Ensure PM domains are powered at
 initialization
In-Reply-To: <1412174494-15346-3-git-send-email-ulf.hansson@linaro.org>
References: <1412174494-15346-1-git-send-email-ulf.hansson@linaro.org>
 <1412174494-15346-3-git-send-email-ulf.hansson@linaro.org>
Message-ID: <542C2972.9070002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/14 16:41, Ulf Hansson wrote:
> At ->probe() it's common practice for drivers/subsystems to bring their
> devices to full power and without depending on CONFIG_PM_RUNTIME.
> 
> We could also expect that drivers/subsystems requires their device's
> corresponding PM domains to be powered, to successfully complete a
> ->probe() sequence.
> 
> Align to the behavior above, by ensuring all PM domains are powered
> prior initialization of a generic PM domain.
> 
> Do note, since the generic PM domain will try to power off unused PM
> domains at late_init, there should be no increased power consumption
> over time, but potentially during boot.

Wouldn't it be a better idea to power on the power domains which are
turned off only when CONFIG_PM_RUNTIME is not enabled ? I had a plan
to submit a patch doing that but unfortunately this has fallen through
the cracks. At the moment mach-exynos/pm_domains.c is not even built in
when CONFIG_PM_RUNTIME is disabled.

I don't like the behaviour introduced in this patch to be the default,
i.e. turning all possible power domains during boot sequence, even if
some are not used and not needed. While we're trying to decrease the
power consumption in any possible way this doesn't help at all.

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  arch/arm/mach-exynos/pm_domains.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/pm_domains.c b/arch/arm/mach-exynos/pm_domains.c
> index 20f2671..58e18e9 100644
> --- a/arch/arm/mach-exynos/pm_domains.c
> +++ b/arch/arm/mach-exynos/pm_domains.c
> @@ -112,7 +112,7 @@ static __init int exynos4_pm_init_power_domain(void)
>  
>  	for_each_compatible_node(np, NULL, "samsung,exynos4210-pd") {
>  		struct exynos_pm_domain *pd;
> -		int on, i;
> +		int i;
>  		struct device *dev;
>  
>  		pdev = of_find_device_by_node(np);
> @@ -155,9 +155,10 @@ static __init int exynos4_pm_init_power_domain(void)
>  			clk_put(pd->oscclk);
>  
>  no_clk:
> -		on = __raw_readl(pd->base + 0x4) & INT_LOCAL_PWR_EN;
> +		if (!(__raw_readl(pd->base + 0x4) & INT_LOCAL_PWR_EN))
> +			exynos_pd_power_on(&pd->pd);
>  
> -		pm_genpd_init(&pd->pd, NULL, !on);
> +		pm_genpd_init(&pd->pd, NULL, false);
>  		of_genpd_add_provider_simple(np, &pd->pd);
>  	}

--
Thanks,
Sylwester
