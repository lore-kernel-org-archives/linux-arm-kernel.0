From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 5 Nov 2015 10:01:32 +0100
Subject: [RFCv2 1/2] power: domain: add pm_genpd_uninit
In-Reply-To: <1446590711-18928-2-git-send-email-alex.aring@gmail.com>
References: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
 <1446590711-18928-2-git-send-email-alex.aring@gmail.com>
Message-ID: <CAPDyKFrkzMZZjFRM7EbqDqmW8EXzV22O_tp8a45LVGQYSn6b3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 November 2015 at 23:45, Alexander Aring <alex.aring@gmail.com> wrote:
> This patch adds function pm_genpd_uninit for undo a pm_genpd_init. This
> is useful for multiple power domains while probing. If the probing fails
> after one pm_genpd_init was called we need to undo all previous
> registrations of generic pm domains inside the gpd_list list.

Yes, agree. Although I think it's a bit mote complicated than what you
suggest in this simple approach. :-)

>
> There is a check on IS_ERR_OR_NULL(genpd) which is useful to check again
> registered power domains and not registered domains, the driver can use
> this mechanism to have an array with registered and non-registered power
> domains, where non-registered power domains are NULL.
>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
>  drivers/base/power/domain.c | 15 +++++++++++++++
>  include/linux/pm_domain.h   |  4 ++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 16550c6..65b9d1a 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1730,6 +1730,21 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_init);
>
> +/**
> + * pm_genpd_uninit - Uninitialize a generic I/O PM domain object.
> + * @genpd: PM domain object to initialize.
> + */
> +void pm_genpd_uninit(struct generic_pm_domain *genpd)
> +{
> +       if (IS_ERR_OR_NULL(genpd))
> +               return;
> +
> +       mutex_lock(&gpd_list_lock);
> +       list_del(&genpd->gpd_list_node);
> +       mutex_unlock(&gpd_list_lock);

This is too fragile. You don't protect from the cases below.

1. The genpd may have devices attached to it.
2. The genpd may have subdomains.

To deal with these case, that's when it becomes more complex which I
guess is the reason to why nobody really cared until now.

Moreover, I think there are some more structures to "uninitialize"
besides just unlinking the genpd struct from the gpd list. For example
a mutex_destroy() should be done.

> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_uninit);
> +
>  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>  /*
>   * Device Tree based PM domain providers.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index b1cf7e7..45d4f7a 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -143,6 +143,7 @@ extern int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd);
>  extern int pm_genpd_name_detach_cpuidle(const char *name);
>  extern void pm_genpd_init(struct generic_pm_domain *genpd,
>                           struct dev_power_governor *gov, bool is_off);
> +extern void pm_genpd_uninit(struct generic_pm_domain *genpd);
>
>  extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
>  extern int pm_genpd_name_poweron(const char *domain_name);
> @@ -212,6 +213,9 @@ static inline void pm_genpd_init(struct generic_pm_domain *genpd,
>                                  struct dev_power_governor *gov, bool is_off)
>  {
>  }
> +static inline void pm_genpd_uninit(struct generic_pm_domain *genpd)
> +{
> +}
>  static inline int pm_genpd_poweron(struct generic_pm_domain *genpd)
>  {
>         return -ENOSYS;
> --
> 2.6.1
>

Kind regards
Uffe
