From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 29 Nov 2012 11:17:29 +0100
Subject: [PATCH 1/1] ARM: tegra: bus_notifier registers IOMMU
 devices(was: How to specify IOMMU'able devices in DT)
In-Reply-To: <20121128.154832.539666140149950229.hdoyu@nvidia.com>
References: <20120924124452.41070ed2ee9944d930cffffc@nvidia.com>
 <054901cd9a45$db1a7ea0$914f7be0$%szyprowski@samsung.com>
 <20120924.145014.1452596970914043018.hdoyu@nvidia.com>
 <20121128.154832.539666140149950229.hdoyu@nvidia.com>
Message-ID: <20121129101729.GA6150@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 02:48:32PM +0100, Hiroshi Doyu wrote:
[...]
> From: Hiroshi Doyu <hdoyu@nvidia.com>
> Date: Wed, 28 Nov 2012 14:47:04 +0200
> Subject: [PATCH 1/1] ARM: tegra: bus_notifier registers IOMMU devices
> 
> platform_bus notifier registers IOMMU devices if dma-window is
> specified.
> 
> Its format is:
>   dma-window = <"start" "size">;
> ex)
>   dma-window = <0x12345000 0x8000>;
> 
> Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
> ---
>  arch/arm/mach-tegra/board-dt-tegra30.c |   40 ++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
> index a2b6cf1..570d718 100644
> --- a/arch/arm/mach-tegra/board-dt-tegra30.c
> +++ b/arch/arm/mach-tegra/board-dt-tegra30.c
> @@ -30,9 +30,11 @@
>  #include <linux/of_fdt.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> +#include <linux/of_iommu.h>
>  
>  #include <asm/mach/arch.h>
>  #include <asm/hardware/gic.h>
> +#include <asm/dma-iommu.h>
>  
>  #include "board.h"
>  #include "clock.h"
> @@ -86,10 +88,48 @@ static __initdata struct tegra_clk_init_table tegra_dt_clk_init_table[] = {
>  	{ NULL,		NULL,		0,		0},
>  };
>  
> +#ifdef CONFIG_ARM_DMA_USE_IOMMU
> +static int tegra_iommu_device_notifier(struct notifier_block *nb,
> +				       unsigned long event, void *_dev)
> +{
> +	struct dma_iommu_mapping *map = NULL;
> +	struct device *dev = _dev;
> +	dma_addr_t base;
> +	size_t size;
> +	int err;
> +
> +	switch (event) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		err = of_get_dma_window(dev->of_node, NULL, 0, NULL, &base,
> +					&size);
> +		if (!err)
> +			map = arm_iommu_create_mapping(&platform_bus_type,
> +						       base, size, 0);
> +		if (IS_ERR_OR_NULL(map))
> +			break;
> +		if (arm_iommu_attach_device(dev, map))
> +			dev_err(dev, "Failed to attach %s\n", dev_name(dev));
> +		dev_dbg(dev, "Attached %s to map %p\n", dev_name(dev), map);
> +		break;
> +	}
> +	return NOTIFY_DONE;
> +}
> +#else
> +#define tegra_iommu_device_notifier NULL
> +#endif
> +
> +static struct notifier_block tegra_iommu_device_nb = {
> +	.notifier_call = tegra_iommu_device_notifier,
> +};

You don't need this extra protection since you use IS_ENABLED below and
these are all static variables. The whole point of IS_ENABLED is to
allow full compile coverage while leaving it up to the compiler to
eliminate dead code.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121129/82ad6f64/attachment-0001.sig>
