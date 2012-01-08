From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 8 Jan 2012 22:23:18 +0100
Subject: [PATCH v2 1/2] PM / Domains: Add OF support
In-Reply-To: <1325931055-14486-2-git-send-email-thomas.abraham@linaro.org>
References: <1325931055-14486-1-git-send-email-thomas.abraham@linaro.org>
 <1325931055-14486-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <201201082223.18603.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, January 07, 2012, Thomas Abraham wrote:
> A device node pointer is added to generic pm domain structure to associate
> the domain with a node in the device tree. The platform code parses the
> device tree to find available nodes representing the generic power domain,
> instantiates the available domains and initializes them by calling
> pm_genpd_init().
> 
> Nodes representing the devices include a phandle of the power domain to
> which it belongs. As these devices get instantiated, the driver code
> checkes for availability of a power domain phandle, converts the phandle
> to a device node and uses the new pm_genpd_of_add_device() api to
> associate the device with a power domain.
> 
> pm_genpd_of_add_device() runs through its list of registered power domains
> and matches the OF node of the domain with the one specified as the
> parameter. If a match is found, the device is associated with the matched
> domain.
> 
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

I can take this patch for 3.4, but your [2/2] depends on it, so I'm not
sure how to handle that.  If you want me to take the other patch too,
it'll need ACKs from the Exynos maintaniers.

Thanks,
Rafael


> ---
>  drivers/base/power/domain.c |   32 ++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |   12 ++++++++++++
>  2 files changed, 44 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 92e6a90..9ee1f7b 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1171,6 +1171,38 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>  }
>  
>  /**
> + * __pm_genpd_of_add_device - Add a device to an I/O PM domain.
> + * @genpd_node: Device tree node pointer representing a PM domain to which the
> + *   the device is added to.
> + * @dev: Device to be added.
> + * @td: Set of PM QoS timing parameters to attach to the device.
> + */
> +int __pm_genpd_of_add_device(struct device_node *genpd_node, struct device *dev,
> +			     struct gpd_timing_data *td)
> +{
> +	struct generic_pm_domain *genpd = NULL, *gpd;
> +
> +	dev_dbg(dev, "%s()\n", __func__);
> +
> +	if (IS_ERR_OR_NULL(genpd_node) || IS_ERR_OR_NULL(dev))
> +		return -EINVAL;
> +
> +	mutex_lock(&gpd_list_lock);
> +	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
> +		if (gpd->of_node == genpd_node) {
> +			genpd = gpd;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&gpd_list_lock);
> +
> +	if (!genpd)
> +		return -EINVAL;
> +
> +	return __pm_genpd_add_device(genpd, dev, td);
> +}
> +
> +/**
>   * pm_genpd_remove_device - Remove a device from an I/O PM domain.
>   * @genpd: PM domain to remove the device from.
>   * @dev: Device to be removed.
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index a03a0ad..e3ff875 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -11,6 +11,7 @@
>  
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/of.h>
>  
>  enum gpd_status {
>  	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
> @@ -70,6 +71,7 @@ struct generic_pm_domain {
>  	s64 break_even_ns;	/* Power break even for the entire domain. */
>  	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
>  	ktime_t power_off_time;
> +	struct device_node *of_node; /* Node in device tree */
>  };
>  
>  static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
> @@ -117,12 +119,22 @@ extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
>  				 struct device *dev,
>  				 struct gpd_timing_data *td);
>  
> +extern int __pm_genpd_of_add_device(struct device_node *genpd_node,
> +				    struct device *dev,
> +				    struct gpd_timing_data *td);
> +
>  static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
>  				      struct device *dev)
>  {
>  	return __pm_genpd_add_device(genpd, dev, NULL);
>  }
>  
> +static inline int pm_genpd_of_add_device(struct device_node *genpd_node,
> +					 struct device *dev)
> +{
> +	return __pm_genpd_of_add_device(genpd_node, dev, NULL);
> +}
> +
>  extern int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>  				  struct device *dev);
>  extern int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
> 
