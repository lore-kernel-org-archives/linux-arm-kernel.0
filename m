From: daniel@ffwll.ch (Daniel Vetter)
Date: Wed, 19 Oct 2016 09:27:19 +0200
Subject: [PATCH] gpu: Remove depends on RESET_CONTROLLER when not a
 provider
In-Reply-To: <20161018205719.20575-1-stephen.boyd@linaro.org>
References: <20161018205719.20575-1-stephen.boyd@linaro.org>
Message-ID: <20161019072719.GE20761@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 01:57:19PM -0700, Stephen Boyd wrote:
> These GPU drivers only depend on the RESET_CONTROLLER config
> option to fix build issues that existed when there weren't stub
> reset APIs for reset controller consumers. Given that these
> drivers aren't providing any reset controllers themselves, they
> don't actually depend on the API to build (just to function) so
> they don't need to depend on it. Remove the dependency to fix
> recursive build errors like the following:
> 
> drivers/usb/Kconfig:39:error: recursive dependency detected!
> drivers/usb/Kconfig:39: symbol USB is selected by MOUSE_APPLETOUCH
> drivers/input/mouse/Kconfig:187:        symbol MOUSE_APPLETOUCH depends on INPUT
> drivers/input/Kconfig:8:        symbol INPUT is selected by VT
> drivers/tty/Kconfig:12: symbol VT is selected by FB_STI
> drivers/video/fbdev/Kconfig:674:        symbol FB_STI depends on FB
> drivers/video/fbdev/Kconfig:5:  symbol FB is selected by DRM_KMS_FB_HELPER
> drivers/gpu/drm/Kconfig:42:     symbol DRM_KMS_FB_HELPER is selected by DRM_KMS_CMA_HELPER
> drivers/gpu/drm/Kconfig:98:     symbol DRM_KMS_CMA_HELPER is selected by DRM_IMX
> drivers/gpu/drm/imx/Kconfig:1:  symbol DRM_IMX depends on IMX_IPUV3_CORE
> drivers/gpu/ipu-v3/Kconfig:1:   symbol IMX_IPUV3_CORE depends on RESET_CONTROLLER
> drivers/reset/Kconfig:4:        symbol RESET_CONTROLLER is selected by USB_CHIPIDEA
> drivers/usb/chipidea/Kconfig:1: symbol USB_CHIPIDEA depends on USB_EHCI_HCD
> drivers/usb/host/Kconfig:84:    symbol USB_EHCI_HCD depends on USB
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: <dri-devel@lists.freedesktop.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Mark Yao <mark.yao@rock-chips.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>

Yay for proper stubbing! Applied to drm-misc, thanks.
-Daniel

> ---
> 
> This has come out of some USB chipidea patches I've been working on. Please see
> http://lkml.kernel.org/r/20160907213519.27340-1-stephen.boyd at linaro.org for
> more details.
> 
> I'm resending with the ack from Philipp picked up.
> 
>  drivers/gpu/drm/rockchip/Kconfig | 1 -
>  drivers/gpu/drm/tegra/Kconfig    | 1 -
>  drivers/gpu/ipu-v3/Kconfig       | 1 -
>  3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index 3c58669a06ce..6f7f9c59f05b 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -1,7 +1,6 @@
>  config DRM_ROCKCHIP
>  	tristate "DRM Support for Rockchip"
>  	depends on DRM && ROCKCHIP_IOMMU
> -	depends on RESET_CONTROLLER
>  	select DRM_GEM_CMA_HELPER
>  	select DRM_KMS_HELPER
>  	select DRM_PANEL
> diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
> index 63ebb154b9b5..bbf5a4b7e0b6 100644
> --- a/drivers/gpu/drm/tegra/Kconfig
> +++ b/drivers/gpu/drm/tegra/Kconfig
> @@ -3,7 +3,6 @@ config DRM_TEGRA
>  	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
>  	depends on COMMON_CLK
>  	depends on DRM
> -	depends on RESET_CONTROLLER
>  	select DRM_KMS_HELPER
>  	select DRM_MIPI_DSI
>  	select DRM_PANEL
> diff --git a/drivers/gpu/ipu-v3/Kconfig b/drivers/gpu/ipu-v3/Kconfig
> index aefdff95356d..08766c6e7856 100644
> --- a/drivers/gpu/ipu-v3/Kconfig
> +++ b/drivers/gpu/ipu-v3/Kconfig
> @@ -1,7 +1,6 @@
>  config IMX_IPUV3_CORE
>  	tristate "IPUv3 core support"
>  	depends on SOC_IMX5 || SOC_IMX6Q || ARCH_MULTIPLATFORM
> -	depends on RESET_CONTROLLER
>  	select GENERIC_IRQ_CHIP
>  	help
>  	  Choose this if you have a i.MX5/6 system and want to use the Image
> -- 
> 2.10.0.297.gf6727b0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
