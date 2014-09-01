From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 1 Sep 2014 10:29:40 +0200
Subject: [RFC PATCH 4/7] iommu: provide helper function to configure an
 IOMMU for an of master
In-Reply-To: <1409327670-3495-5-git-send-email-will.deacon@arm.com>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
 <1409327670-3495-5-git-send-email-will.deacon@arm.com>
Message-ID: <20140901082939.GC24430@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 04:54:27PM +0100, Will Deacon wrote:
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
>  #include <linux/of.h>
>  #include <linux/of_iommu.h>
>  
> @@ -90,6 +91,41 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
>  }
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
> +
> +		ret = ops->add_device_master_ids(dev, iommu_spec.args_count,
> +						 iommu_spec.args, data);
> +		if (ret)
> +			break;

I think this could use a bit more formalization. As I said in another
reply earlier, there's very little standardization in the IOMMU API.
That certainly gives us a lot of flexibility but it also has the
downside that it's difficult to handle these abstractions in the core,
which is really what the core is all about, isn't it?

One method that worked really well for this in the past for other
subsystems is to allow drivers to specify an .of_xlate() function that
takes the controller device and a struct of_phandle_args. It is that
function's responsibility to take the information in an of_phandle_args
structure and use that to create some subsystem specific handle that
represents this information in a way that it can readily be used.

So I think it would really be helpful if IOMMU gained support for
something similar. We could create a struct iommu to represent an
instance of an IOMMU. IOMMU drivers can embed this structure and add
device-specific fields that they need. That way we can easily pass
around instances and upcast in the driver in a type-safe way.

At the same time, a struct iommu_master could provide the basis to
represent a single master interface on an IOMMU. Drivers can again embed
that in driver-specific structures with additional fields required for
the particular IOMMU implementation. .of_xlate() could return such an
IOMMU master for the core to use.

With such structures in place we should be able to eliminate many of the
loops in IOMMU drivers that serve no other purpose than to find the
master context from a struct device * and some parameters. It will also
allow us to keep a central registry of IOMMUs and masters rather than
duplicating that in every driver.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140901/5f29f373/attachment.sig>
