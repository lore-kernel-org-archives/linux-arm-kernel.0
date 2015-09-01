From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 01 Sep 2015 22:46:21 +0200
Subject: [PATCH v4 03/16] drm: bridge: analogix/dp: split exynos dp driver
 to bridge dir
In-Reply-To: <1441086598-24995-1-git-send-email-ykk@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441086598-24995-1-git-send-email-ykk@rock-chips.com>
Message-ID: <2618155.E00Pak1qvi@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 1. September 2015, 13:49:58 schrieb Yakir Yang:
> Split the dp core driver from exynos directory to bridge
> directory, and rename the core driver to analogix_dp_*,
> leave the platform code to analogix_dp-exynos.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>

[...]

> diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c
> b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c similarity index 50%
> rename from drivers/gpu/drm/exynos/exynos_dp_core.c
> rename to drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index bed0252..7d62f22 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c

[...]

>  	connector->polled = DRM_CONNECTOR_POLL_HPD;
> 
>  	ret = drm_connector_init(dp->drm_dev, connector,
> -				 &exynos_dp_connector_funcs,
> +				 &analogix_dp_connector_funcs,
>  				 DRM_MODE_CONNECTOR_eDP);
>  	if (ret) {
>  		DRM_ERROR("Failed to initialize connector with drm\n");
>  		return ret;
>  	}
> 
> -	drm_connector_helper_add(connector, &exynos_dp_connector_helper_funcs);
> +	drm_connector_helper_add(connector,
> +				 &analogix_dp_connector_helper_funcs);
>  	drm_connector_register(connector);

this should only run on exynos, as we're doing all our connector registration 
in the core driver after all components are bound, so I guess something like 
the following is needed:

       if (dp->plat_data && dp->plat_data->dev_type == EXYNOS_DP)
               drm_connector_register(connector);



>  	drm_mode_connector_attach_encoder(connector, encoder);
> 

[...]

> @@ -1301,7 +1239,10 @@ static int exynos_dp_bind(struct device *dev, struct
> device *master, void *data) if (IS_ERR(dp->reg_base))
>  		return PTR_ERR(dp->reg_base);
> 
> -	dp->hpd_gpio = of_get_named_gpio(dev->of_node, "samsung,hpd-gpio", 0);
> +	dp->hpd_gpio = of_get_named_gpio(dev->of_node, "hpd-gpios", 0);
> +	if (gpio_is_valid(dp->hpd_gpio))

this should be !gpio_is_valid ... i.e. only check the old property if the new 
one is _not_ valid


> +		dp->hpd_gpio = of_get_named_gpio(dev->of_node,
> +						 "samsung,hpd-gpio", 0);
> 
>  	if (gpio_is_valid(dp->hpd_gpio)) {
>  		/*
