From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Oct 2013 12:11:46 +0100
Subject: [PATCH 2/6] of: add function to check against a list of
 compatible strings
In-Reply-To: <201310151247.50408.heiko@sntech.de>
References: <201310151246.49402.heiko@sntech.de>
 <201310151247.50408.heiko@sntech.de>
Message-ID: <20131015111145.GE19196@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Tue, Oct 15, 2013 at 11:47:50AM +0100, Heiko St?bner wrote:
> The basic of functions already provide a of_device_is_compatible to check
> if a device's compatible property contains a specific one. But sometimes
> it's also necessary to check if the device is compatible to one out of a
> list of compatible devices.
> 
> Therefore add of_device_is_any_of that reuses the compatible check of
> of_device_is_compatible but checks against a list of compatible strings
> without the locking overhead of calling of_device_is_compatible multiple
> times.

I don't think we need this -- we already have of_match_node, and you can
use it to achieve the same result.

Thanks,
Mark.

> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/of/base.c  |   21 +++++++++++++++++++++
>  include/linux/of.h |    2 ++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 865d3f6..589f43e 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -366,6 +366,27 @@ int of_device_is_compatible(const struct device_node *device,
>  EXPORT_SYMBOL(of_device_is_compatible);
>  
>  /**
> + * Checks if any of the given "compat" strings matches one of the strings
> + * in the device's "compatible" property.
> + */
> +int of_device_is_any_of(const struct device_node *device,
> +			const char * const *compat, int num) {
> +	unsigned long flags;
> +	int res = 0, i;
> +
> +	raw_spin_lock_irqsave(&devtree_lock, flags);
> +	for (i = 0; i < num; i++) {
> +		if (__of_device_is_compatible(device, compat[i])) {
> +			res = 1;
> +			break;
> +		}
> +	}
> +	raw_spin_unlock_irqrestore(&devtree_lock, flags);
> +	return res;
> +}
> +EXPORT_SYMBOL(of_device_is_any_of);
> +
> +/**
>   * of_machine_is_compatible - Test root of device tree for a given compatible value
>   * @compat: compatible string to look for in root node's compatible property.
>   *
> diff --git a/include/linux/of.h b/include/linux/of.h
> index f95aee3..5bf7c9a 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -262,6 +262,8 @@ extern int of_property_count_strings(struct device_node *np,
>  				     const char *propname);
>  extern int of_device_is_compatible(const struct device_node *device,
>  				   const char *);
> +extern int of_device_is_any_of(const struct device_node *device,
> +			       const char * const *compat, int num);
>  extern int of_device_is_available(const struct device_node *device);
>  extern const void *of_get_property(const struct device_node *node,
>  				const char *name,
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
