From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Oct 2015 17:38:35 +0200
Subject: [PATCH] VFIO: platform: AMD xgbe reset module
In-Reply-To: <1444836792-2405-1-git-send-email-eric.auger@linaro.org>
References: <1444836792-2405-1-git-send-email-eric.auger@linaro.org>
Message-ID: <22278785.Xzxnmu2YlU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 October 2015 15:33:12 Eric Auger wrote:
> --- a/drivers/vfio/platform/vfio_platform_common.c
> +++ b/drivers/vfio/platform/vfio_platform_common.c
> @@ -31,6 +31,11 @@ static const struct vfio_platform_reset_combo reset_lookup_table[] = {
>                 .reset_function_name = "vfio_platform_calxedaxgmac_reset",
>                 .module_name = "vfio-platform-calxedaxgmac",
>         },
> +       {
> +               .compat = "amd,xgbe-seattle-v1a",
> +               .reset_function_name = "vfio_platform_amdxgbe_reset",
> +               .module_name = "vfio-platform-amdxgbe",
> +       },
>  };
>  
>  static void vfio_platform_get_reset(struct vfio_platform_device *vdev,
> 

This is causing build errors for me when CONFIG_MODULES is disabled.

Could this please be restructured so vfio_platform_get_reset does
not attempt to call __symbol_get() but instead has the drivers
register themselves properly to a subsystem?

I don't see any way this could be fixed otherwise. The problem
of course showed up with calxedaxgmac already, but I'd prefer not
to see anything added there until the common code has been improved.

	Arnd
