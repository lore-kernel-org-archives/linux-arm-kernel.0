From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Thu, 1 Dec 2011 21:37:07 +0100
Subject: [PATCH 2/3] ARM: mach-shmobile: Use common always on power domain
 governor
In-Reply-To: <1322765339-29879-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1322765339-29879-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <201112012137.08119.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday, December 01, 2011, Mark Brown wrote:
> Saves a tiny amount of code.

How so?

> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  arch/arm/mach-shmobile/pm-sh7372.c |   43 +----------------------------------
>  1 files changed, 2 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
> index adf1765..5f7d575 100644
> --- a/arch/arm/mach-shmobile/pm-sh7372.c
> +++ b/arch/arm/mach-shmobile/pm-sh7372.c
> @@ -162,45 +162,6 @@ static bool pd_active_wakeup(struct device *dev)
>  	return active_wakeup ? active_wakeup(dev) : true;
>  }
>  
> -static bool sh7372_power_down_forbidden(struct dev_pm_domain *domain)
> -{
> -	return false;
> -}
> -
> -struct dev_power_governor sh7372_always_on_gov = {
> -	.power_down_ok = sh7372_power_down_forbidden,
> -	.stop_ok = default_stop_ok,
> -};
> -
> -static int sh7372_stop_dev(struct device *dev)
> -{
> -	int (*stop)(struct device *dev);
> -
> -	stop = dev_gpd_data(dev)->ops.stop;
> -	if (stop) {
> -		int ret = stop(dev);
> -		if (ret)
> -			return ret;
> -	}
> -	return pm_clk_suspend(dev);
> -}
> -
> -static int sh7372_start_dev(struct device *dev)
> -{
> -	int (*start)(struct device *dev);
> -	int ret;
> -
> -	ret = pm_clk_resume(dev);
> -	if (ret)
> -		return ret;
> -
> -	start = dev_gpd_data(dev)->ops.start;
> -	if (start)
> -		ret = start(dev);
> -
> -	return ret;
> -}
> -

The above functions are actually necessary, please don't remove them
without introducing replacements.

>  void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd)
>  {
>  	struct generic_pm_domain *genpd = &sh7372_pd->genpd;
> @@ -246,7 +207,7 @@ struct sh7372_pm_domain sh7372_d4 = {
>  
>  struct sh7372_pm_domain sh7372_a4r = {
>  	.bit_shift = 5,
> -	.gov = &sh7372_always_on_gov,
> +	.gov = &pm_domain_always_on_gov,
>  	.suspend = sh7372_a4r_suspend,
>  	.resume = sh7372_intcs_resume,
>  	.stay_on = true,
> @@ -262,7 +223,7 @@ struct sh7372_pm_domain sh7372_a3ri = {
>  
>  struct sh7372_pm_domain sh7372_a3sp = {
>  	.bit_shift = 11,
> -	.gov = &sh7372_always_on_gov,
> +	.gov = &pm_domain_always_on_gov,
>  	.no_debug = true,
>  };

Thanks,
Rafael
