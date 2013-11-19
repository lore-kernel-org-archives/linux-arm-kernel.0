From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 19 Nov 2013 11:25:07 +0100
Subject: [PATCHv5 2/9] driver/core: populate devices in order for IOMMUs
In-Reply-To: <1384853593-32202-3-git-send-email-hdoyu@nvidia.com>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com>
 <1384853593-32202-3-git-send-email-hdoyu@nvidia.com>
Message-ID: <20131119102506.GG31504@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 11:33:06AM +0200, Hiroshi Doyu wrote:
> IOMMU devices on the bus need to be poplulated first, then iommu
> master devices are done later.
> 
> With CONFIG_OF_IOMMU, "iommus=" DT binding would be used to identify
> whether a device can be an iommu msater or not. If a device can, we'll
> defer to populate that device till an iommu device is populated. Once
> an iommu device is populated, "dev->bus->iommu_ops" is set in the
> bus. Then, those defered iommu master devices are populated and
> configured for IOMMU with help of the already populated iommu device
> via iommu_ops->add_device(). Multiple IOMMUs can be listed on this
> "iommus" binding so that a device can have multiple IOMMUs attached.
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
> v5:
> Use "iommus=" binding instread of arm,smmu's "#stream-id-cells".
> 
> v4:
> This is newly added, and the successor of the following RFC:
>   [RFC][PATCHv3+ 1/2] driver/core: Add of_iommu_attach()
>   http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006914.html
> ---
>  drivers/base/dd.c        |  5 +++++
>  drivers/iommu/of_iommu.c | 22 ++++++++++++++++++++++
>  include/linux/of_iommu.h |  7 +++++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 35fa368..6e892d4 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -25,6 +25,7 @@
>  #include <linux/async.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/devinfo.h>
> +#include <linux/of_iommu.h>
>  
>  #include "base.h"
>  #include "power/power.h"
> @@ -273,6 +274,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  
>  	dev->driver = drv;
>  
> +	ret = of_iommu_attach(dev);
> +	if (ret)
> +		goto probe_failed;
> +
>  	/* If using pinctrl, bind pins now before probing */
>  	ret = pinctrl_bind_pins(dev);
>  	if (ret)
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index ee249bc..4aef2b2 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -20,6 +20,8 @@
>  #include <linux/export.h>
>  #include <linux/limits.h>
>  #include <linux/of.h>
> +#include <linux/device.h>
> +#include <linux/iommu.h>
>  
>  /**
>   * of_get_dma_window - Parse *dma-window property and returns 0 if found.
> @@ -88,3 +90,23 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_get_dma_window);
> +
> +int of_iommu_attach(struct device *dev)
> +{
> +	int i;
> +	struct of_phandle_args args;
> +	struct iommu_ops *ops = dev->bus->iommu_ops;
> +
> +	of_property_for_each_phandle_with_args(dev->of_node, "iommus",
> +					       "#iommu-cells", i, &args) {
> +		pr_debug("%s(i=%d) ops=%p %s\n",
> +			 __func__, i, ops, dev_name(dev));
> +
> +		if (!ops)
> +			return -EPROBE_DEFER;
> +	}
> +
> +	if (i && ops->add_device)
> +		return ops->add_device(dev);
> +	return 0;
> +}

I don't think this does what it's supposed to do. As far as I can tell
there's no way the above loop won't run to parse all phandles and their
arguments unless the DT is actually wrong.

>From earlier discussions I thought the goal was to actually defer this
until all nodes referred to by the iommus property were actually
registered. The above only checks that the phandles can be resolved to
valid struct device_node:s. That doesn't mean that an actual IOMMU has
been registered for it, only that the devices have been created.

I think within that loop you need to look up the IOMMU corresponding to
the struct device_node in args.np. If no match is found, then return
-EPROBE_DEFER.

If you really only rely on dev->bus->iommu_ops to be present, then there
is no need to go through the loop in the first place, since you have
access to it immediately through the struct device that's passed into
the function.

Furthermore, relying on dev->bus->iommu_ops will prevent multiple IOMMUs
from being used at all, since only one IOMMU can register iommu_ops with
the bus, right? So I think what we really need here is a way to resolve
the IOMMU using a phandle and return the associated struct iommu_ops.

I also have some trouble understanding how the current IOMMU framework
is supposed to work together with multiple IOMMUs for one device. The
.add_device() callback seems to be missing crucial information to help
decide whether the device to be added is actually one that it covers.
Also with an of_iommu_attach() function, doesn't that become more or
less redundant?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131119/dac87db1/attachment.sig>
