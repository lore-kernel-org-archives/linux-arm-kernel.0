From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 4 Dec 2011 21:56:59 +0100
Subject: [PATCH 1/3] PM: Provide an always on power domain governor
In-Reply-To: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <201112042156.59990.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 01, 2011, Mark Brown wrote:
> Since systems are likely to have power domains that can't be turned off
> for various reasons at least temporarily while implementing power domain
> support provide a default governor which will always refuse to power off
> the domain, saving platforms having to implement their own.
> 
> Since the code is so tiny don't bother with a Kconfig symbol for it.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Looks good with the new version of [2/3].

Do you want me to takt it?

Rafael


> ---
>  drivers/base/power/domain_governor.c |   13 +++++++++++++
>  include/linux/pm_domain.h            |    2 ++
>  2 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index da78540..51527ee 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -141,3 +141,16 @@ struct dev_power_governor simple_qos_governor = {
>  	.stop_ok = default_stop_ok,
>  	.power_down_ok = default_power_down_ok,
>  };
> +
> +static bool always_on_power_down_ok(struct dev_pm_domain *domain)
> +{
> +	return false;
> +}
> +
> +/**
> + * pm_genpd_gov_always_on - A governor implementing an always-on policy
> + */
> +struct dev_power_governor pm_domain_always_on_gov = {
> +	.power_down_ok = always_on_power_down_ok,
> +	.stop_ok = default_stop_ok,
> +};
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index fbb81bc..fda14f1 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -139,6 +139,7 @@ extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
>  
>  extern bool default_stop_ok(struct device *dev);
>  
> +extern struct dev_power_governor pm_domain_always_on_gov;
>  #else
>  
>  static inline struct generic_pm_domain *dev_to_genpd(struct device *dev)
> @@ -192,6 +193,7 @@ static inline bool default_stop_ok(struct device *dev)
>  {
>  	return false;
>  }
> +#define pm_domain_always_on_gov NULL
>  #endif
>  
>  static inline int pm_genpd_remove_callbacks(struct device *dev)
> 
