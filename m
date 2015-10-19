From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Oct 2015 15:04:47 +0200
Subject: [PATCH 2/4] vfio: platform: reset: calxedaxgmac: add reset
 function registration
In-Reply-To: <1445184015-24414-3-git-send-email-eric.auger@linaro.org>
References: <1445184015-24414-1-git-send-email-eric.auger@linaro.org>
 <1445184015-24414-3-git-send-email-eric.auger@linaro.org>
Message-ID: <3829716.dW4OHEgDOa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 18 October 2015 18:00:13 Eric Auger wrote:
> diff --git a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
> index 619dc7d..4f76b17 100644
> --- a/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
> +++ b/drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c
> @@ -29,8 +29,7 @@
>  #define DRIVER_VERSION  "0.1"
>  #define DRIVER_AUTHOR   "Eric Auger <eric.auger@linaro.org>"
>  #define DRIVER_DESC     "Reset support for Calxeda xgmac vfio platform device"
> -
> -#define CALXEDAXGMAC_COMPAT "calxeda,hb-xgmac"
> +#define COMPAT		"calxeda,hb-xgmac"

Why the rename?

>  /* XGMAC Register definitions */
>  #define XGMAC_CONTROL           0x00000000      /* MAC Configuration */
> @@ -80,6 +79,43 @@ int vfio_platform_calxedaxgmac_reset(struct vfio_platform_device *vdev)
>  }
>  EXPORT_SYMBOL_GPL(vfio_platform_calxedaxgmac_reset);
>  
> +static int __init vfio_platform_calxedaxgmac_init(void)
> +{
> +	int (*register_reset)(struct module *, char*,
> +				vfio_platform_reset_fn_t);
> +	int ret;
> +
> +	register_reset = symbol_get(vfio_platform_register_reset);
> +	if (!register_reset)
> +		return -EINVAL;

I don't understand what you do the symbol_get() here for.
Why not just call that function directly?

> +	ret = register_reset(THIS_MODULE, COMPAT,
> +	vfio_platform_calxedaxgmac_reset);

This is whitespace damaged, the second line needs to be indented
to the opening braces.

I would also suggest defining register_reset as a macro that
implicitly passes the THIS_MODULE argument, as other subsystems
do.

	Arnd
