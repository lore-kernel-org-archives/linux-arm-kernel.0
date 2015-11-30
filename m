From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 30 Nov 2015 15:19:09 -0800
Subject: [PATCH 1/3] power: domain: add pm_genpd_uninit
In-Reply-To: <1447956490-22930-2-git-send-email-alex.aring@gmail.com>
 (Alexander Aring's message of "Thu, 19 Nov 2015 19:08:08 +0100")
References: <1447956490-22930-1-git-send-email-alex.aring@gmail.com>
 <1447956490-22930-2-git-send-email-alex.aring@gmail.com>
Message-ID: <7h7fkz9itu.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Aring <alex.aring@gmail.com> writes:

> This patch adds function pm_genpd_uninit for undo a pm_genpd_init. This
> is useful for multiple power domains while probing. If the probing fails
> after one pm_genpd_init was called we need to undo all previous
> registrations of generic pm domains inside the gpd_list list.
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
>  drivers/base/power/domain.c | 22 ++++++++++++++++++++++
>  include/linux/pm_domain.h   |  4 ++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index e03b1ad..24f54b8 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1509,6 +1509,28 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>  }
>  EXPORT_SYMBOL_GPL(pm_genpd_init);
>  
> +/**
> + * pm_genpd_uninit - Uninitialize a generic I/O PM domain object.
> + * @genpd: PM domain object to initialize.
> + */
> +void pm_genpd_uninit(struct generic_pm_domain *genpd)
> +{
> +	if (IS_ERR_OR_NULL(genpd))
> +		return;
> +
> +	/* check if domain is still in registered inside the pm subsystem */
> +	WARN_ON_ONCE(!list_empty(&genpd->master_links) ||
> +		     !list_empty(&genpd->slave_links) ||
> +		     !list_empty(&genpd->dev_list));

So we WARN if there are parents/children/devices, but shouldn't this
return an error instead of continuing to remove/uninit the genpd?

The caller of _uninit should probably also be removing any
parents/children and removing devices before calling _uninit, no?

> +	mutex_lock(&gpd_list_lock);
> +	list_del(&genpd->gpd_list_node);
> +	mutex_unlock(&gpd_list_lock);
> +
> +	mutex_destroy(&genpd->lock);
> +}
> +EXPORT_SYMBOL_GPL(pm_genpd_uninit);

Kevin
