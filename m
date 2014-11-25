From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 25 Nov 2014 08:35:08 +0100
Subject: [PATCH RFC v2 07/12] PM / Domains: export pm_genpd_lookup_name
In-Reply-To: <1416834256-11225-7-git-send-email-amit.daniel@samsung.com>
References: <1416833572-6880-1-git-send-email-amit.daniel@samsung.com>
 <1416834256-11225-1-git-send-email-amit.daniel@samsung.com>
 <1416834256-11225-7-git-send-email-amit.daniel@samsung.com>
Message-ID: <CAPDyKFqE_qhrRs3X9s9juyPH_Zcq8vdE_amqKM3VUnMjHtL2Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 November 2014 at 14:04, Amit Daniel Kachhap
<amit.daniel@samsung.com> wrote:
> This API may be needed to set the power domain parent/child relationship
> in the power domain platform driver. The parent relationship is
> generally set after the child power domain is registered with the power
> domain subsystem. In this case, pm_genpd_lookup_name API might be
> useful.

I think this is a step in the wrong direction. Instead we should be
working on removing the "name" based APIs from genpd.

The proper way should be to pass the PM domain as a parameter to the
APIs instead.

Kind regards
Uffe

>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  drivers/base/power/domain.c |    3 ++-
>  include/linux/pm_domain.h   |    7 +++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index fb83d4a..b0e1c2f 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -49,7 +49,7 @@
>  static LIST_HEAD(gpd_list);
>  static DEFINE_MUTEX(gpd_list_lock);
>
> -static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
> +struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
>  {
>         struct generic_pm_domain *genpd = NULL, *gpd;
>
> @@ -66,6 +66,7 @@ static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
>         mutex_unlock(&gpd_list_lock);
>         return genpd;
>  }
> +EXPORT_SYMBOL_GPL(pm_genpd_lookup_name);
>
>  struct generic_pm_domain *dev_to_genpd(struct device *dev)
>  {
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 2e0e06d..aedcec3 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -150,6 +150,8 @@ extern int pm_genpd_name_poweron(const char *domain_name);
>
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> +
> +extern struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name);
>  #else
>
>  static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
> @@ -221,6 +223,11 @@ static inline int pm_genpd_name_poweron(const char *domain_name)
>  {
>         return -ENOSYS;
>  }
> +static inline
> +struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
> +{
> +       return NULL;
> +}
>  #define simple_qos_governor NULL
>  #define pm_domain_always_on_gov NULL
>  #endif
> --
> 1.7.9.5
>
