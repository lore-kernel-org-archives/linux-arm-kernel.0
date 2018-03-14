From: architt@codeaurora.org (Archit Taneja)
Date: Wed, 14 Mar 2018 11:37:36 +0530
Subject: [PATCH v5 10/36] drm/bridge: analogix_dp: Retry bridge enable
 when it failed
In-Reply-To: <20180309222327.18689-11-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
 <20180309222327.18689-11-enric.balletbo@collabora.com>
Message-ID: <1c2ca228-4f3b-d582-6258-8608c7f731f1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 10 March 2018 03:53 AM, Enric Balletbo i Serra wrote:
> From: zain wang <wzz@rock-chips.com>
> 
> When we enable bridge failed, we have to retry it, otherwise we would get
> the abnormal display.
> 

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit

> Cc: St?phane Marchesin <marcheu@chromium.org>
> Signed-off-by: zain wang <wzz@rock-chips.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> 
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 65 +++++++++++++++++-----
>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  3 +-
>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  |  5 +-
>   3 files changed, 56 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index ea7a80a989c6..c81733b8185e 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -43,8 +43,10 @@ struct bridge_init {
>   	struct device_node *node;
>   };
>   
> -static void analogix_dp_init_dp(struct analogix_dp_device *dp)
> +static int analogix_dp_init_dp(struct analogix_dp_device *dp)
>   {
> +	int ret;
> +
>   	analogix_dp_reset(dp);
>   
>   	analogix_dp_swreset(dp);
> @@ -56,10 +58,13 @@ static void analogix_dp_init_dp(struct analogix_dp_device *dp)
>   	analogix_dp_enable_sw_function(dp);
>   
>   	analogix_dp_config_interrupt(dp);
> -	analogix_dp_init_analog_func(dp);
> +	ret = analogix_dp_init_analog_func(dp);
> +	if (ret)
> +		return ret;
>   
>   	analogix_dp_init_hpd(dp);
>   	analogix_dp_init_aux(dp);
> +	return 0;
>   }
>   
>   static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
> @@ -918,7 +923,7 @@ static irqreturn_t analogix_dp_irq_thread(int irq, void *arg)
>   	return IRQ_HANDLED;
>   }
>   
> -static void analogix_dp_commit(struct analogix_dp_device *dp)
> +static int analogix_dp_commit(struct analogix_dp_device *dp)
>   {
>   	int ret;
>   
> @@ -928,11 +933,10 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
>   			DRM_ERROR("failed to disable the panel\n");
>   	}
>   
> -	ret = readx_poll_timeout(analogix_dp_train_link, dp, ret, !ret, 100,
> -				 DP_TIMEOUT_TRAINING_US * 5);
> +	ret = analogix_dp_train_link(dp);
>   	if (ret) {
>   		dev_err(dp->dev, "unable to do link train, ret=%d\n", ret);
> -		return;
> +		return ret;
>   	}
>   
>   	analogix_dp_enable_scramble(dp, 1);
> @@ -953,6 +957,7 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
>   	dp->psr_enable = analogix_dp_detect_sink_psr(dp);
>   	if (dp->psr_enable)
>   		analogix_dp_enable_sink_psr(dp);
> +	return 0;
>   }
>   
>   /*
> @@ -1149,12 +1154,9 @@ static void analogix_dp_bridge_pre_enable(struct drm_bridge *bridge)
>   		DRM_ERROR("failed to setup the panel ret = %d\n", ret);
>   }
>   
> -static void analogix_dp_bridge_enable(struct drm_bridge *bridge)
> +static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
>   {
> -	struct analogix_dp_device *dp = bridge->driver_private;
> -
> -	if (dp->dpms_mode == DRM_MODE_DPMS_ON)
> -		return;
> +	int ret;
>   
>   	pm_runtime_get_sync(dp->dev);
>   
> @@ -1162,11 +1164,46 @@ static void analogix_dp_bridge_enable(struct drm_bridge *bridge)
>   		dp->plat_data->power_on(dp->plat_data);
>   
>   	phy_power_on(dp->phy);
> -	analogix_dp_init_dp(dp);
> +
> +	ret = analogix_dp_init_dp(dp);
> +	if (ret)
> +		goto out_dp_init;
> +
> +	ret = analogix_dp_commit(dp);
> +	if (ret)
> +		goto out_dp_init;
> +
>   	enable_irq(dp->irq);
> -	analogix_dp_commit(dp);
> +	return 0;
>   
> -	dp->dpms_mode = DRM_MODE_DPMS_ON;
> +out_dp_init:
> +	phy_power_off(dp->phy);
> +	if (dp->plat_data->power_off)
> +		dp->plat_data->power_off(dp->plat_data);
> +	pm_runtime_put_sync(dp->dev);
> +
> +	return ret;
> +}
> +
> +static void analogix_dp_bridge_enable(struct drm_bridge *bridge)
> +{
> +	struct analogix_dp_device *dp = bridge->driver_private;
> +	int timeout_loop = 0;
> +
> +	if (dp->dpms_mode == DRM_MODE_DPMS_ON)
> +		return;
> +
> +	while (timeout_loop < MAX_PLL_LOCK_LOOP) {
> +		if (analogix_dp_set_bridge(dp) == 0) {
> +			dp->dpms_mode = DRM_MODE_DPMS_ON;
> +			return;
> +		}
> +		dev_err(dp->dev, "failed to set bridge, retry: %d\n",
> +			timeout_loop);
> +		timeout_loop++;
> +		usleep_range(10, 11);
> +	}
> +	dev_err(dp->dev, "too many times retry set bridge, give it up\n");
>   }
>   
>   static void analogix_dp_bridge_disable(struct drm_bridge *bridge)
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> index 403ff853464b..769255dc6e99 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> @@ -19,6 +19,7 @@
>   #define DP_TIMEOUT_LOOP_COUNT 100
>   #define MAX_CR_LOOP 5
>   #define MAX_EQ_LOOP 5
> +#define MAX_PLL_LOCK_LOOP 5
>   
>   /* Training takes 22ms if AUX channel comm fails. Use this as retry interval */
>   #define DP_TIMEOUT_TRAINING_US			22000
> @@ -197,7 +198,7 @@ void analogix_dp_set_pll_power_down(struct analogix_dp_device *dp, bool enable);
>   void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
>   				       enum analog_power_block block,
>   				       bool enable);
> -void analogix_dp_init_analog_func(struct analogix_dp_device *dp);
> +int analogix_dp_init_analog_func(struct analogix_dp_device *dp);
>   void analogix_dp_init_hpd(struct analogix_dp_device *dp);
>   void analogix_dp_force_hpd(struct analogix_dp_device *dp);
>   enum dp_irq_type analogix_dp_get_irq_type(struct analogix_dp_device *dp);
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> index e78c861b9e06..b47c5af43560 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -333,7 +333,7 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
>   	}
>   }
>   
> -void analogix_dp_init_analog_func(struct analogix_dp_device *dp)
> +int analogix_dp_init_analog_func(struct analogix_dp_device *dp)
>   {
>   	u32 reg;
>   	int timeout_loop = 0;
> @@ -355,7 +355,7 @@ void analogix_dp_init_analog_func(struct analogix_dp_device *dp)
>   			timeout_loop++;
>   			if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
>   				dev_err(dp->dev, "failed to get pll lock status\n");
> -				return;
> +				return -ETIMEDOUT;
>   			}
>   			usleep_range(10, 20);
>   		}
> @@ -366,6 +366,7 @@ void analogix_dp_init_analog_func(struct analogix_dp_device *dp)
>   	reg &= ~(SERDES_FIFO_FUNC_EN_N | LS_CLK_DOMAIN_FUNC_EN_N
>   		| AUX_FUNC_EN_N);
>   	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_2);
> +	return 0;
>   }
>   
>   void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp)
> 
