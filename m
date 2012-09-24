From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Mon, 24 Sep 2012 13:28:01 +0400
Subject: How to specify IOMMU'able devices in DT (was: [RFC 0/5] ARM:
 dma-mapping: New dma_map_ops to control IOVA more precisely)
In-Reply-To: <20120924120415.8e6929a34c422185a98d3f82@nvidia.com>
References: <1346223335-31455-1-git-send-email-hdoyu@nvidia.com>
 <20120918124918.GK2505@amd.com>
 <20120919095843.d1db155e0f085f4fcf64ea32@nvidia.com>
 <201209190759.46174.arnd@arndb.de> <20120919125020.GQ2505@amd.com>
 <401E54CE964CD94BAE1EB4A729C7087E379FDC1EEB@HQMAIL04.nvidia.com>
 <505A7DB4.4090902@wwwdotorg.org>
 <401E54CE964CD94BAE1EB4A729C7087E379FDC1F2D@HQMAIL04.nvidia.com>
 <505B35F7.2080201@wwwdotorg.org>
 <401E54CE964CD94BAE1EB4A729C7087E379FDC2372@HQMAIL04.nvidia.com>
 <20120924120415.8e6929a34c422185a98d3f82@nvidia.com>
Message-ID: <1348478881.2467.27.camel@dabdike>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-09-24 at 12:04 +0300, Hiroshi Doyu wrote:
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index a1a7225..9eae3be 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -21,6 +21,8 @@
>  #include <linux/slab.h>
>  #include <linux/pm_runtime.h>
> 
> +#include <asm/dma-iommu.h>
> +
>  #include "base.h"
> 
>  #define to_platform_driver(drv)        (container_of((drv), struct
> platform_driver, \
> @@ -305,8 +307,19 @@ int platform_device_add(struct platform_device
> *pdev)
>                  dev_name(&pdev->dev), dev_name(pdev->dev.parent));
> 
>         ret = device_add(&pdev->dev);
> -       if (ret == 0)
> -               return ret;
> +       if (ret)
> +               goto failed;
> +
> +#ifdef CONFIG_PLATFORM_ENABLE_IOMMU
> +       if (platform_bus_type.map && !pdev->dev.archdata.mapping) {
> +               ret = arm_iommu_attach_device(&pdev->dev,
> +                                             platform_bus_type.map);
> +               if (ret)
> +                       goto failed;

This is horrible ... you're adding an architecture specific callback
into our generic code; that's really a no-no.  If the concept of
CONFIG_PLATFORM_ENABE_IOMMU is useful to more than just arm, then this
could become a generic callback.

James
