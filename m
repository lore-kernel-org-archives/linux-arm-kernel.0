From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 12 Sep 2016 14:56:42 +0200
Subject: [PATCH V2 10/10] PM / Domains: Add support for removing nested PM
 domains by provider
In-Reply-To: <1473678074-15126-11-git-send-email-jonathanh@nvidia.com>
References: <1473678074-15126-1-git-send-email-jonathanh@nvidia.com>
 <1473678074-15126-11-git-send-email-jonathanh@nvidia.com>
Message-ID: <CAPDyKFomhNiC1CeeVCnYX5DOtT2tXYdAU30XTY9gnUSeos8uQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 September 2016 at 13:01, Jon Hunter <jonathanh@nvidia.com> wrote:
> If a device supports PM domains that are subdomains of another PM
> domain, then the PM domains should be removed in reverse order to
> ensure that the subdomains are removed first. Furthermore, if there is
> more than one provider, then there needs to be a way to remove the
> domains in reverse order for a specific provider.
>
> Add the function of_genpd_remove_last() to remove the last PM domain
> added by a given PM domain provider and return the generic_pm_domain
> structure for the PM domain that was removed.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  7 +++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 7481e3e316a2..b0cf46dcae73 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1745,6 +1745,41 @@ int of_genpd_add_subdomain(struct of_phandle_args *parent_spec,
>  EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
>
>  /**
> + * of_genpd_remove_last - Remove the last PM domain registered for a provider
> + * @provider: Pointer to device structure associated with provider
> + *
> + * Find the last PM domain that was added by a particular provider and
> + * remove this PM domain from the list of PM domains. The provider is
> + * identified by the 'provider' device structure that is passed. The PM
> + * domain will only be removed, if the provider associated with domain
> + * has been removed.
> + *
> + * Returns a valid pointer to struct generic_pm_domain on success or
> + * ERR_PTR() on failure.
> + */
> +struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
> +{
> +       struct generic_pm_domain *gpd, *genpd = ERR_PTR(-ENOENT);
> +       int ret;
> +
> +       if (IS_ERR_OR_NULL(np))
> +               return ERR_PTR(-EINVAL);
> +
> +       mutex_lock(&gpd_list_lock);
> +       list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
> +               if (gpd->provider == &np->fwnode) {
> +                       ret = genpd_remove(gpd);
> +                       genpd = ret ? ERR_PTR(ret) : gpd;
> +                       break;
> +               }
> +       }
> +       mutex_unlock(&gpd_list_lock);
> +
> +       return genpd;
> +}
> +EXPORT_SYMBOL_GPL(of_genpd_remove_last);
> +
> +/**
>   * genpd_dev_pm_detach - Detach a device from its PM domain.
>   * @dev: Device to detach.
>   * @power_off: Currently not used
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 85f7d53a9827..a09fe5c009c8 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -204,6 +204,7 @@ extern int of_genpd_add_device(struct of_phandle_args *args,
>                                struct device *dev);
>  extern int of_genpd_add_subdomain(struct of_phandle_args *parent,
>                                   struct of_phandle_args *new_subdomain);
> +extern struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
>
>  int genpd_dev_pm_attach(struct device *dev);
>  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
> @@ -237,6 +238,12 @@ static inline int genpd_dev_pm_attach(struct device *dev)
>  {
>         return -ENODEV;
>  }
> +
> +static inline
> +struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
> +{
> +       return ERR_PTR(-ENOTSUPP);
> +}
>  #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
>
>  #ifdef CONFIG_PM
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
