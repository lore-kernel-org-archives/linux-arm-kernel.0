From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 24 May 2016 16:59:28 +0100
Subject: [RFC 8/9] drivers: of: call iommu_bus_add_dev after
 iommu_configure_ops
In-Reply-To: <1461599894-1969-9-git-send-email-sricharan@codeaurora.org>
References: <1461599894-1969-1-git-send-email-sricharan@codeaurora.org>
 <1461599894-1969-9-git-send-email-sricharan@codeaurora.org>
Message-ID: <57447A60.4060805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/04/16 16:58, Sricharan R wrote:
> Now that the device's iommu ops are configured at probe time,
> the device has to be added to the iommu late.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>   drivers/of/device.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 57a5f2d..722115c 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -6,6 +6,7 @@
>   #include <linux/of_iommu.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/init.h>
> +#include <linux/iommu.h>
>   #include <linux/module.h>
>   #include <linux/mod_devicetable.h>
>   #include <linux/slab.h>
> @@ -154,6 +155,9 @@ int of_dma_configure_ops(struct device *dev, struct device_node *np)
>   	dev_dbg(dev, "device is%sbehind an iommu\n",
>   		iommu ? " " : " not ");
>
> +	if (iommu)
> +		iommu_bus_add_dev(dev);

This (in conjunction with the previous patch) seems unnecessarily 
convoluted - if of_iommu_configure() has found some iommu_ops for a 
device, why not just call .add_device() directly there and then? There 
are already systems that could warrant having two different IOMMU 
drivers active simultaneously (but thankfully don't _need_ to), so 
trying to escape from per-bus IOMMU ops makes more sense than 
entrenching the horrible notion of "the" IOMMU on "the" platform bus any 
further.

Robin.

> +
>   	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
>
>   	return 0;
>
