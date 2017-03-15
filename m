From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 15 Mar 2017 18:23:27 +0100
Subject: [PATCH v3] drm/rockchip: Refactor the component match logic.
In-Reply-To: <19101003.9xjQ92OS5C@phil>
References: <1489573247-9628-1-git-send-email-jeffy.chen@rock-chips.com>
 <19101003.9xjQ92OS5C@phil>
Message-ID: <2110531.OeyX13mlk5@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 15. M?rz 2017, 18:00:04 CET schrieb Heiko Stuebner:
> Am Mittwoch, 15. M?rz 2017, 18:20:47 CET schrieb Jeffy Chen:
> > Currently we are adding all components from the dts, if one of their
> > drivers been disabled, we would not be able to bring up others.
> > 
> > Refactor component match logic, follow exynos drm.
> > 
> > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> > Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> 
> This reliably produces null pointer dereference errors in
> 	__platform_driver_register called from rockchip_drm_init
> on at least rk3036 and rk3288 (probably more) when applied on top of
> Linus' tree from today. Log attached and Rockchip drm compiled as module.
> 
> I'm currently dug into other areas, so hadn't have time to investigate
> further yet.

> +#define DRV_PTR(drv, cond) (IS_ENABLED(cond) ? &drv : NULL)
> +
> +static struct platform_driver *rockchip_drm_comp_drvs[] = {
> +	&vop_platform_driver,
> +	DRV_PTR(rockchip_dp_driver, CONFIG_ROCKCHIP_ANALOGIX_DP),
> +	DRV_PTR(cdn_dp_driver, CONFIG_ROCKCHIP_CDN_DP),
> +	DRV_PTR(dw_hdmi_rockchip_pltfm_driver, CONFIG_ROCKCHIP_DW_HDMI),
> +	DRV_PTR(dw_mipi_dsi_driver, CONFIG_ROCKCHIP_DW_MIPI_DSI),
> +	DRV_PTR(inno_hdmi_driver, CONFIG_ROCKCHIP_INNO_HDMI),
> +};

[...]

> +static int rockchip_drm_register_drivers(void)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(rockchip_drm_comp_drvs); i++) {
> +		ret = platform_driver_register(rockchip_drm_comp_drvs[i]);
> +		if (ret)
> +			goto err_unreg;
> +	}

This of course won't work in the NULL case, as platform_driver_register always 
dereferences its parameter [0], so you should only call it for the actual non-
null array elements - of course same for unregister.


Heiko

[0] http://lxr.free-electrons.com/source/drivers/base/platform.c#L617
