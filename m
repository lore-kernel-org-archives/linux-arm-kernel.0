From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 02 Sep 2014 13:51:54 +0300
Subject: [RFC PATCH 4/7] iommu: provide helper function to configure an
 IOMMU for an of master
In-Reply-To: <1409327670-3495-5-git-send-email-will.deacon@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <1409327670-3495-5-git-send-email-will.deacon@arm.com>
Message-ID: <1485866.XbpZvVaUr8@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Thank you for the patch.

On Friday 29 August 2014 16:54:27 Will Deacon wrote:
> The generic IOMMU device-tree bindings can be used to add arbitrary OF
> masters to an IOMMU with a compliant binding.
> 
> This patch introduces of_iommu_configure, which does exactly that.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/iommu/Kconfig    |  2 +-
>  drivers/iommu/of_iommu.c | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/of_iommu.h |  6 ++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dd5112265cc9..6d13f962f156 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -15,7 +15,7 @@ if IOMMU_SUPPORT
> 
>  config OF_IOMMU
>         def_bool y
> -       depends on OF
> +       depends on OF && IOMMU_API
> 
>  config FSL_PAMU
>  	bool "Freescale IOMMU support"
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index f9209666157c..a7d3b3a13b83 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -19,6 +19,7 @@
> 
>  #include <linux/export.h>
>  #include <linux/limits.h>
> +#include <linux/iommu.h>

Pet peeve of mine, how about keeping the headers alphabetically sorted ?

>  #include <linux/of.h>
>  #include <linux/of_iommu.h>
> 
> @@ -90,6 +91,41 @@ int of_get_dma_window(struct device_node *dn, const char
> *prefix, int index, }
>  EXPORT_SYMBOL_GPL(of_get_dma_window);
> 
> +int of_iommu_configure(struct device *dev)
> +{
> +	struct of_phandle_args iommu_spec;
> +	struct bus_type *bus = dev->bus;
> +	const struct iommu_ops *ops = bus->iommu_ops;
> +	int ret = -EINVAL, idx = 0;
> +
> +	if (!iommu_present(bus))
> +		return -ENODEV;
> +
> +	/*
> +	 * We don't currently walk up the tree looking for a parent IOMMU.
> +	 * See the `Notes:' section of
> +	 * Documentation/devicetree/bindings/iommu/iommu.txt
> +	 */
> +	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
> +					   "#iommu-cells", idx,
> +					   &iommu_spec)) {
> +		void *data = of_iommu_get_data(iommu_spec.np);
> +
> +		of_node_put(iommu_spec.np);
> +		if (!ops->add_device_master_ids)
> +			return -ENODEV;

Can't you move this outside of the loop ?

> +
> +		ret = ops->add_device_master_ids(dev, iommu_spec.args_count,
> +						 iommu_spec.args, data);

I'm curious, how do you envision support for devices connected to multiple 
IOMMUs ? IOMMU drivers usually allocate a per-device archdata structure in the 
add_device operation and store it in the dev->archdata.iommu field. How would 
that work with multiple invocations of add_device or add_device_master_ids ?

> +		if (ret)
> +			break;
> +
> +		idx++;
> +	}
> +
> +	return ret;
> +}
> +
>  void __init of_iommu_init(void)
>  {
>  	struct device_node *np;
> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> index 29f2f3f88d6a..85c6d1152624 100644
> --- a/include/linux/of_iommu.h
> +++ b/include/linux/of_iommu.h
> @@ -1,6 +1,7 @@
>  #ifndef __OF_IOMMU_H
>  #define __OF_IOMMU_H
> 
> +#include <linux/device.h>
>  #include <linux/of.h>
> 
>  #ifdef CONFIG_OF_IOMMU
> @@ -10,6 +11,7 @@ extern int of_get_dma_window(struct device_node *dn, const
> char *prefix, size_t *size);
> 
>  extern void of_iommu_init(void);
> +extern int of_iommu_configure(struct device *dev);
> 
>  #else
> 
> @@ -21,6 +23,10 @@ static inline int of_get_dma_window(struct device_node
> *dn, const char *prefix, }
> 
>  static inline void of_iommu_init(void) { }
> +static inline int of_iommu_configure(struct device *dev)
> +{
> +	return -ENODEV;
> +}
> 
>  #endif	/* CONFIG_OF_IOMMU */

-- 
Regards,

Laurent Pinchart
