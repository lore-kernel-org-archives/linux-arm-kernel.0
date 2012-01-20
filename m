From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Jan 2012 20:25:39 +0800
Subject: [PATCH 05/31] ARM: amba: mxs: convert to use amba_device_alloc
In-Reply-To: <E1RoAhZ-0005EY-BZ@rmk-PC.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAhZ-0005EY-BZ@rmk-PC.arm.linux.org.uk>
Message-ID: <20120120122535.GA25917@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 09:24:05AM +0000, Russell King - ARM Linux wrote:
> Convert MXS to use the new amba_device_alloc APIs.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-mxs/devices.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/devices.c b/arch/arm/mach-mxs/devices.c
> index fe3e847..052d8dd 100644
> --- a/arch/arm/mach-mxs/devices.c
> +++ b/arch/arm/mach-mxs/devices.c
> @@ -77,16 +77,18 @@ struct platform_device *__init mxs_add_platform_device_dmamask(
>  
>  int __init mxs_add_amba_device(const struct amba_device *dev)
>  {
> -	struct amba_device *adev = kmalloc(sizeof(*adev), GFP_KERNEL);
> +	struct amba_device *adev = amba_device_alloc(dev->init_name,

The 'dev->init_name' needs to be 'dev->dev.init_name'.  Otherwise, we
see the compile error below.

  CC      arch/arm/mach-mxs/devices.o
arch/arm/mach-mxs/devices.c: In function ?mxs_add_amba_device?:
arch/arm/mach-mxs/devices.c:80:50: error: ?const struct amba_device? has no member named ?init_name?

Other than that,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn

> +		dev->res.start, resource_size(&dev->res));
>  
>  	if (!adev) {
>  		pr_err("%s: failed to allocate memory", __func__);
>  		return -ENOMEM;
>  	}
>  
> -	*adev = *dev;
> +	adev->irq[0] = dev->irq[0];
> +	adev->irq[1] = dev->irq[1];
>  
> -	return amba_device_register(adev, &iomem_resource);
> +	return amba_device_add(adev, &iomem_resource);
>  }
>  
>  struct device mxs_apbh_bus = {
> -- 
