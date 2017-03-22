From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 22 Mar 2017 11:42:12 +0100
Subject: [PATCH 39/41] drm/bridge: analogix_dp: Split the platform-specific
 poweron in two parts
In-Reply-To: <20170310043305.17216-40-seanpaul@chromium.org>
References: <20170310043305.17216-1-seanpaul@chromium.org>
 <CGME20170310045205epcas2p2bb638cfe42b9b97be0bad5af0922e98e@epcas2p2.samsung.com>
 <20170310043305.17216-40-seanpaul@chromium.org>
Message-ID: <f41b1cdf-0e69-df53-0532-d810b609e892@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.03.2017 05:32, Sean Paul wrote:
> From: Douglas Anderson <dianders@chromium.org>
>
> Some of the platform-specific stuff in rockchip_dp_poweron() needs to
> happen before the generic code.  Some needs to happen after.  Let's
> split the callback in two.
>
> Specifically we can't start doing PSR work until _after_ the whole
> controller is up, so don't set the enable until the end.
>
> Cc: Kristian H. Kristensen <hoegsberg@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> [seanpaul added exynos change]
> Signed-off-by: Sean Paul <seanpaul@chromium.org>

Sounds like mid-layer issue. I do not know bridge details so I can only
guess but probably passing full control to drivers and call generic code
via helpers could be better solution.
Anyway it can be done later.

For now:
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>


Regards
Andrzej

> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  7 +++++--
>  drivers/gpu/drm/exynos/exynos_dp.c                 |  2 +-
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 12 ++++++++++--
>  include/drm/bridge/analogix_dp.h                   |  3 ++-
>  4 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index a05bc0271188..bc9a0a28ab1d 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1254,8 +1254,8 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
>  		goto out_dp_clk_pre;
>  	}
>  
> -	if (dp->plat_data->power_on)
> -		dp->plat_data->power_on(dp->plat_data);
> +	if (dp->plat_data->power_on_start)
> +		dp->plat_data->power_on_start(dp->plat_data);
>  
>  	phy_power_on(dp->phy);
>  
> @@ -1278,6 +1278,9 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
>  		goto out_dp_init;
>  	}
>  
> +	if (dp->plat_data->power_on_end)
> +		dp->plat_data->power_on_end(dp->plat_data);
> +
>  	enable_irq(dp->irq);
>  	return 0;
>  
> diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
> index 1ef0be338b85..6b79c3b3802f 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp.c
> +++ b/drivers/gpu/drm/exynos/exynos_dp.c
> @@ -168,7 +168,7 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
>  	dp->drm_dev = drm_dev;
>  
>  	dp->plat_data.dev_type = EXYNOS_DP;
> -	dp->plat_data.power_on = exynos_dp_poweron;
> +	dp->plat_data.power_on_start = exynos_dp_poweron;
>  	dp->plat_data.power_off = exynos_dp_poweroff;
>  	dp->plat_data.attach = exynos_dp_bridge_attach;
>  	dp->plat_data.get_modes = exynos_dp_get_modes;
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 14f68e792e6f..07dd09e1e32f 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -127,7 +127,7 @@ static int rockchip_dp_pre_init(struct rockchip_dp_device *dp)
>  	return 0;
>  }
>  
> -static int rockchip_dp_poweron(struct analogix_dp_plat_data *plat_data)
> +static int rockchip_dp_poweron_start(struct analogix_dp_plat_data *plat_data)
>  {
>  	struct rockchip_dp_device *dp = to_dp(plat_data);
>  	int ret;
> @@ -145,6 +145,13 @@ static int rockchip_dp_poweron(struct analogix_dp_plat_data *plat_data)
>  		return ret;
>  	}
>  
> +	return ret;
> +}
> +
> +static int rockchip_dp_poweron_end(struct analogix_dp_plat_data *plat_data)
> +{
> +	struct rockchip_dp_device *dp = to_dp(plat_data);
> +
>  	return rockchip_drm_psr_activate(&dp->encoder);
>  }
>  
> @@ -399,7 +406,8 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
>  	dp->plat_data.encoder = &dp->encoder;
>  
>  	dp->plat_data.dev_type = dp->data->chip_type;
> -	dp->plat_data.power_on = rockchip_dp_poweron;
> +	dp->plat_data.power_on_start = rockchip_dp_poweron_start;
> +	dp->plat_data.power_on_end = rockchip_dp_poweron_end;
>  	dp->plat_data.power_off = rockchip_dp_powerdown;
>  	dp->plat_data.get_modes = rockchip_dp_get_modes;
>  	dp->plat_data.cleanup = rockchip_dp_cleanup;
> diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
> index c079ca1ffc76..1049ee56ae76 100644
> --- a/include/drm/bridge/analogix_dp.h
> +++ b/include/drm/bridge/analogix_dp.h
> @@ -30,7 +30,8 @@ struct analogix_dp_plat_data {
>  	struct drm_encoder *encoder;
>  	struct drm_connector *connector;
>  
> -	int (*power_on)(struct analogix_dp_plat_data *);
> +	int (*power_on_start)(struct analogix_dp_plat_data *);
> +	int (*power_on_end)(struct analogix_dp_plat_data *);
>  	int (*power_off)(struct analogix_dp_plat_data *);
>  	int (*attach)(struct analogix_dp_plat_data *, struct drm_bridge *,
>  		      struct drm_connector *);
