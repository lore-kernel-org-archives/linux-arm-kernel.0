From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 16 Mar 2017 09:20:13 +0100
Subject: [PATCH v4] drm/rockchip: Refactor the component match logic.
In-Reply-To: <1489629956-32285-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1489629956-32285-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <4477033.icEzZGFJNF@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

Am Donnerstag, 16. M?rz 2017, 10:05:56 CET schrieb Jeffy Chen:
> Currently we are adding all components from the dts, if one of their
> drivers been disabled, we would not be able to bring up others.
> 
> Refactor component match logic, follow exynos drm.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

[...]

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c index b360e62..51433da 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -356,34 +356,42 @@ static const struct dev_pm_ops rockchip_drm_pm_ops = {
> rockchip_drm_sys_resume)
>  };
> 
> -static int compare_of(struct device *dev, void *data)
> -{
> -	struct device_node *np = data;
> +#define MAX_ROCKCHIP_DRM_DRVS 16
> +static struct platform_driver *rockchip_drm_drvs[MAX_ROCKCHIP_DRM_DRVS];
> +static int rockchip_drm_drvs_cnt;
> 
> -	return dev->of_node == np;
> +#define ROCKCHIP_DRM_DRV(drv, cond) { \
> +	if (IS_ENABLED(cond)) \
> +		rockchip_drm_drvs[rockchip_drm_drvs_cnt++] = &drv; \
>  }

[...]

> +static int __init rockchip_drm_init(void)
> +{
> +	int ret;
> +
> +	rockchip_drm_drvs_cnt = 0;
> +	ROCKCHIP_DRM_DRV(vop_platform_driver, CONFIG_DRM_ROCKCHIP);
> +	ROCKCHIP_DRM_DRV(rockchip_dp_driver, CONFIG_ROCKCHIP_ANALOGIX_DP);
> +	ROCKCHIP_DRM_DRV(cdn_dp_driver, CONFIG_ROCKCHIP_CDN_DP);
> +	ROCKCHIP_DRM_DRV(dw_hdmi_rockchip_pltfm_driver,
> +			 CONFIG_ROCKCHIP_DW_HDMI);
> +	ROCKCHIP_DRM_DRV(dw_mipi_dsi_driver, CONFIG_ROCKCHIP_DW_MIPI_DSI);
> +	ROCKCHIP_DRM_DRV(inno_hdmi_driver, CONFIG_ROCKCHIP_INNO_HDMI);
> +
> +	ret = platform_register_drivers(rockchip_drm_drvs,
> +					rockchip_drm_drvs_cnt);
> +	if (ret)
> +		return ret;

With the following config snippet

CONFIG_DRM_ROCKCHIP=m
CONFIG_ROCKCHIP_ANALOGIX_DP=y
# CONFIG_ROCKCHIP_CDN_DP is not set
CONFIG_ROCKCHIP_DW_HDMI=y
CONFIG_ROCKCHIP_DW_MIPI_DSI=y
CONFIG_ROCKCHIP_INNO_HDMI=y

I get these faults on arm32 (1 warning, 1 linker error):

  CC [M]  drivers/gpu/drm/rockchip/rockchip_drm_drv.o
  CC [M]  drivers/gpu/drm/rockchip/rockchip_drm_fb.o
  CC [M]  drivers/gpu/drm/rockchip/rockchip_drm_gem.o
  CC [M]  drivers/gpu/drm/rockchip/rockchip_drm_psr.o
  CC [M]  drivers/gpu/drm/rockchip/rockchip_drm_vop.o
  CC [M]  drivers/gpu/drm/rockchip/rockchip_vop_reg.o
../drivers/gpu/drm/rockchip/rockchip_vop_reg.c:407:31: warning: ?vop_platform_driver? defined but not used [-Wunused-variable]
 static struct platform_driver vop_platform_driver = {
                               ^~~~~~~~~~~~~~~~~~~
  CC [M]  drivers/gpu/drm/rockchip/rockchip_drm_fbdev.o
  CC [M]  drivers/gpu/drm/rockchip/analogix_dp-rockchip.o
  CC [M]  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.o
  CC [M]  drivers/gpu/drm/rockchip/dw-mipi-dsi.o
  CC [M]  drivers/gpu/drm/rockchip/inno_hdmi.o
  LD [M]  drivers/gpu/drm/rockchip/rockchipdrm.o
  Building modules, stage 2.
  MODPOST 352 modules
ERROR: "vop_platform_driver" [drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!
