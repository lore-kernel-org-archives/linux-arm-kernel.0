From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 03 Sep 2015 09:58:41 +0900
Subject: [PATCH v4 03/16] drm: bridge: analogix/dp: split exynos dp driver
 to bridge dir
In-Reply-To: <1441086598-24995-1-git-send-email-ykk@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441086598-24995-1-git-send-email-ykk@rock-chips.com>
Message-ID: <55E79B41.6010301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.09.2015 14:49, Yakir Yang wrote:
> Split the dp core driver from exynos directory to bridge
> directory, and rename the core driver to analogix_dp_*,
> leave the platform code to analogix_dp-exynos.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
> Changes in v4:
> - Take Rob suggest, update "analogix,hpd-gpios" to "hpd-gpios" DT propery.
> - Take Jingoo suggest, rename "analogix_dp-exynos.c" file name to "exynos_dp.c"
> - Take Archit suggest, create a separate folder for analogix code in bridge/
> 
> Changes in v3:
> - Take Thierry Reding suggest, move exynos's video_timing code
>   to analogix_dp-exynos platform driver, add get_modes method
>   to struct analogix_dp_plat_data.
> - Take Heiko suggest, rename some "samsung*" dts propery to "analogix*".
> 
> Changes in v2:
> - Take Jingoo Han suggest, remove new copyright
> - Fix compiled failed dut to analogix_dp_device misspell
> 
>  drivers/gpu/drm/bridge/Kconfig                     |    2 +
>  drivers/gpu/drm/bridge/Makefile                    |    1 +
>  drivers/gpu/drm/bridge/analogix/Kconfig            |    4 +
>  drivers/gpu/drm/bridge/analogix/Makefile           |    1 +
>  .../analogix/analogix_dp_core.c}                   |  817 ++++++-------
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  283 +++++
>  drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 1265 ++++++++++++++++++++
>  .../analogix/analogix_dp_reg.h}                    |  258 ++--
>  drivers/gpu/drm/exynos/Kconfig                     |    3 +-
>  drivers/gpu/drm/exynos/Makefile                    |    2 +-
>  drivers/gpu/drm/exynos/exynos_dp.c                 |  306 +++++
>  drivers/gpu/drm/exynos/exynos_dp_core.h            |  282 -----
>  drivers/gpu/drm/exynos/exynos_dp_reg.c             | 1259 -------------------
>  include/drm/bridge/analogix_dp.h                   |   24 +
>  14 files changed, 2357 insertions(+), 2150 deletions(-)
>  create mode 100644 drivers/gpu/drm/bridge/analogix/Kconfig
>  create mode 100644 drivers/gpu/drm/bridge/analogix/Makefile
>  rename drivers/gpu/drm/{exynos/exynos_dp_core.c => bridge/analogix/analogix_dp_core.c} (50%)
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>  create mode 100644 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
>  rename drivers/gpu/drm/{exynos/exynos_dp_reg.h => bridge/analogix/analogix_dp_reg.h} (64%)
>  create mode 100644 drivers/gpu/drm/exynos/exynos_dp.c
>  delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_core.h
>  delete mode 100644 drivers/gpu/drm/exynos/exynos_dp_reg.c
>  create mode 100644 include/drm/bridge/analogix_dp.h
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index 2de52a5..7b5b77a 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -29,4 +29,6 @@ config DRM_PARADE_PS8622
>  	---help---
>  	  Parade eDP-LVDS bridge chip driver.
>  
> +source "drivers/gpu/drm/bridge/analogix/Kconfig"
> +
>  endmenu
> diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
> index e2eef1c..5366c6b 100644
> --- a/drivers/gpu/drm/bridge/Makefile
> +++ b/drivers/gpu/drm/bridge/Makefile
> @@ -3,3 +3,4 @@ ccflags-y := -Iinclude/drm
>  obj-$(CONFIG_DRM_DW_HDMI) += dw_hdmi.o
>  obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
>  obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
> +obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
> diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
> new file mode 100644
> index 0000000..5ff6551
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
> @@ -0,0 +1,4 @@
> +config DRM_ANALOGIX_DP
> +	tristate
> +	depends on DRM
> +	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/bridge/analogix/Makefile b/drivers/gpu/drm/bridge/analogix/Makefile
> new file mode 100644
> index 0000000..9107b86
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/analogix/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix_dp_core.o analogix_dp_reg.o
> diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> similarity index 50%
> rename from drivers/gpu/drm/exynos/exynos_dp_core.c
> rename to drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index bed0252..7d62f22 100644
> --- a/drivers/gpu/drm/exynos/exynos_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1,14 +1,14 @@
>  /*
> - * Samsung SoC DP (Display Port) interface driver.
> - *
> - * Copyright (C) 2012 Samsung Electronics Co., Ltd.
> - * Author: Jingoo Han <jg1.han@samsung.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License as published by the
> - * Free Software Foundation; either version 2 of the License, or (at your
> - * option) any later version.
> - */
> +* Analogix DP (Display Port) core interface driver.
> +*
> +* Copyright (C) 2012 Samsung Electronics Co., Ltd.
> +* Author: Jingoo Han <jg1.han@samsung.com>
> +*
> +* This program is free software; you can redistribute it and/or modify it
> +* under the terms of the GNU General Public License as published by the
> +* Free Software Foundation; either version 2 of the License, or (at your
> +* option) any later version.
> +*/
>  
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -18,12 +18,9 @@
>  #include <linux/interrupt.h>
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
> -#include <linux/of_graph.h>
>  #include <linux/gpio.h>
>  #include <linux/component.h>
>  #include <linux/phy/phy.h>
> -#include <video/of_display_timing.h>
> -#include <video/of_videomode.h>
>  
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc.h>
> @@ -31,52 +28,42 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_panel.h>
>  
> -#include "exynos_dp_core.h"
> -#include "exynos_drm_crtc.h"
> +#include <drm/bridge/analogix_dp.h>
>  
> -#define ctx_from_connector(c)	container_of(c, struct exynos_dp_device, \
> -					connector)
> +#include "analogix_dp_core.h"
>  
> -static inline struct exynos_drm_crtc *dp_to_crtc(struct exynos_dp_device *dp)
> -{
> -	return to_exynos_crtc(dp->encoder.crtc);
> -}
> -
> -static inline struct exynos_dp_device *encoder_to_dp(
> -						struct drm_encoder *e)
> -{
> -	return container_of(e, struct exynos_dp_device, encoder);
> -}
> +#define connector_to_dp(c) \
> +	container_of(c, struct analogix_dp_device, connector)
>  
>  struct bridge_init {
>  	struct i2c_client *client;
>  	struct device_node *node;
>  };
>  
> -static void exynos_dp_init_dp(struct exynos_dp_device *dp)
> +static void analogix_dp_init_dp(struct analogix_dp_device *dp)
>  {
> -	exynos_dp_reset(dp);
> +	analogix_dp_reset(dp);
>  
> -	exynos_dp_swreset(dp);
> +	analogix_dp_swreset(dp);
>  
> -	exynos_dp_init_analog_param(dp);
> -	exynos_dp_init_interrupt(dp);
> +	analogix_dp_init_analog_param(dp);
> +	analogix_dp_init_interrupt(dp);
>  
>  	/* SW defined function Normal operation */
> -	exynos_dp_enable_sw_function(dp);
> +	analogix_dp_enable_sw_function(dp);
>  
> -	exynos_dp_config_interrupt(dp);
> -	exynos_dp_init_analog_func(dp);
> +	analogix_dp_config_interrupt(dp);
> +	analogix_dp_init_analog_func(dp);
>  
> -	exynos_dp_init_hpd(dp);
> -	exynos_dp_init_aux(dp);
> +	analogix_dp_init_hpd(dp);
> +	analogix_dp_init_aux(dp);
>  }
>  
> -static int exynos_dp_detect_hpd(struct exynos_dp_device *dp)
> +static int analogix_dp_detect_hpd(struct analogix_dp_device *dp)
>  {
>  	int timeout_loop = 0;
>  
> -	while (exynos_dp_get_plug_in_status(dp) != 0) {
> +	while (analogix_dp_get_plug_in_status(dp) != 0) {
>  		timeout_loop++;
>  		if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
>  			dev_err(dp->dev, "failed to get hpd plug status\n");
> @@ -88,7 +75,7 @@ static int exynos_dp_detect_hpd(struct exynos_dp_device *dp)
>  	return 0;
>  }
>  
> -static unsigned char exynos_dp_calc_edid_check_sum(unsigned char *edid_data)
> +static unsigned char analogix_dp_calc_edid_check_sum(unsigned char *edid_data)
>  {
>  	int i;
>  	unsigned char sum = 0;
> @@ -99,7 +86,7 @@ static unsigned char exynos_dp_calc_edid_check_sum(unsigned char *edid_data)
>  	return sum;
>  }
>  
> -static int exynos_dp_read_edid(struct exynos_dp_device *dp)
> +static int analogix_dp_read_edid(struct analogix_dp_device *dp)
>  {
>  	unsigned char edid[EDID_BLOCK_LENGTH * 2];
>  	unsigned int extend_block = 0;
> @@ -114,9 +101,9 @@ static int exynos_dp_read_edid(struct exynos_dp_device *dp)
>  	 */
>  
>  	/* Read Extension Flag, Number of 128-byte EDID extension blocks */
> -	retval = exynos_dp_read_byte_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
> -					      EDID_EXTENSION_FLAG,
> -					      &extend_block);
> +	retval = analogix_dp_read_byte_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
> +						EDID_EXTENSION_FLAG,
> +						&extend_block);

Hi,

What was the point of patch 1 (checkpatch -f --subjective) if you
have to re-align the parameters again? It's meaningless.

I could understand that idea if this patch touched only first
line - name of the function. This would result in small
and effective diff, like:

-	retval = exynos_dp_read_byte_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
+	retval = SAME_LEGNTH____byte_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
 					      EDID_EXTENSION_FLAG,

But this is not the case. The reviewer have to look at 6 lines
of changes instead of two. You fixed the alignment just for two
patches and then you re-written it. It's meaningless.

Nope. Please drop all changes from patch 1 which:  
(all conditions apply):
1. change alignment,
2. are immediately changed in next patches (e.g. like here),

and fix the alignment while renaming the function.

This is actually another point for not accepting commits where
the reason is "checkpatch told me".



>  	if (retval)
>  		return retval;
>  
> @@ -124,7 +111,7 @@ static int exynos_dp_read_edid(struct exynos_dp_device *dp)
>  		dev_dbg(dp->dev, "EDID data includes a single extension!\n");
>  
>  		/* Read EDID data */
> -		retval = exynos_dp_read_bytes_from_i2c(
> +		retval = analogix_dp_read_bytes_from_i2c(
>  					dp, I2C_EDID_DEVICE_ADDR,
>  					EDID_HEADER_PATTERN,
>  					EDID_BLOCK_LENGTH,
> @@ -133,14 +120,14 @@ static int exynos_dp_read_edid(struct exynos_dp_device *dp)

(...)

> @@ -871,218 +862,204 @@ static irqreturn_t exynos_dp_irq_handler(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> -static void exynos_dp_hotplug(struct work_struct *work)
> +static void analogix_dp_hotplug(struct work_struct *work)
>  {
> -	struct exynos_dp_device *dp;
> +	struct analogix_dp_device *dp;
>  
> -	dp = container_of(work, struct exynos_dp_device, hotplug_work);
> +	dp = container_of(work, struct analogix_dp_device, hotplug_work);
>  
>  	if (dp->drm_dev)
>  		drm_helper_hpd_irq_event(dp->drm_dev);
>  }
>  
> -static void exynos_dp_commit(struct drm_encoder *encoder)
> +static void analogix_dp_commit(struct analogix_dp_device *dp)
>  {
> -	struct exynos_dp_device *dp = encoder_to_dp(encoder);
>  	int ret;
>  
>  	/* Keep the panel disabled while we configure video */
> -	if (dp->panel) {
> -		if (drm_panel_disable(dp->panel))
> +	if (dp->plat_data && dp->plat_data->panel) {
> +		if (drm_panel_disable(dp->plat_data->panel))
>  			DRM_ERROR("failed to disable the panel\n");
>  	}
>  
> -	ret = exynos_dp_detect_hpd(dp);
> +	ret = analogix_dp_detect_hpd(dp);
>  	if (ret) {
>  		/* Cable has been disconnected, we're done */
>  		return;
>  	}
>  
> -	ret = exynos_dp_handle_edid(dp);
> +	ret = analogix_dp_handle_edid(dp);
>  	if (ret) {
>  		dev_err(dp->dev, "unable to handle edid\n");
>  		return;
>  	}
>  
> -	ret = exynos_dp_set_link_train(dp, dp->video_info->lane_count,
> -				       dp->video_info->link_rate);
> +	ret = analogix_dp_set_link_train(dp, dp->video_info->lane_count,
> +					 dp->video_info->link_rate);
>  	if (ret) {
>  		dev_err(dp->dev, "unable to do link train\n");
>  		return;
>  	}
>  
> -	exynos_dp_enable_scramble(dp, 1);
> -	exynos_dp_enable_rx_to_enhanced_mode(dp, 1);
> -	exynos_dp_enable_enhanced_mode(dp, 1);
> +	analogix_dp_enable_scramble(dp, 1);
> +	analogix_dp_enable_rx_to_enhanced_mode(dp, 1);
> +	analogix_dp_enable_enhanced_mode(dp, 1);
>  
> -	exynos_dp_set_lane_count(dp, dp->video_info->lane_count);
> -	exynos_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
> +	analogix_dp_set_lane_count(dp, dp->video_info->lane_count);
> +	analogix_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
>  
> -	exynos_dp_init_video(dp);
> -	ret = exynos_dp_config_video(dp);
> +	analogix_dp_init_video(dp);
> +	ret = analogix_dp_config_video(dp);
>  	if (ret)
>  		dev_err(dp->dev, "unable to config video\n");
>  
>  	/* Safe to enable the panel now */
> -	if (dp->panel) {
> -		if (drm_panel_enable(dp->panel))
> +	if (dp->plat_data && dp->plat_data->panel) {
> +		if (drm_panel_enable(dp->plat_data->panel))
>  			DRM_ERROR("failed to enable the panel\n");
>  	}
>  
>  	/* Enable video */
> -	exynos_dp_start_video(dp);
> +	analogix_dp_start_video(dp);
>  }
>  
>  static enum drm_connector_status
> -exynos_dp_detect(struct drm_connector *connector, bool force)
> +analogix_dp_detect(struct drm_connector *connector, bool force)
>  {
>  	return connector_status_connected;
>  }
>  
> -static void exynos_dp_connector_destroy(struct drm_connector *connector)
> +static void analogix_dp_connector_destroy(struct drm_connector *connector)
>  {
>  	drm_connector_unregister(connector);
>  	drm_connector_cleanup(connector);
>  }
>  
> -static struct drm_connector_funcs exynos_dp_connector_funcs = {
> +static struct drm_connector_funcs analogix_dp_connector_funcs = {
>  	.dpms = drm_atomic_helper_connector_dpms,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
> -	.detect = exynos_dp_detect,
> -	.destroy = exynos_dp_connector_destroy,
> +	.detect = analogix_dp_detect,
> +	.destroy = analogix_dp_connector_destroy,
>  	.reset = drm_atomic_helper_connector_reset,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
> -static int exynos_dp_get_modes(struct drm_connector *connector)
> +static int analogix_dp_get_modes(struct drm_connector *connector)
>  {
> -	struct exynos_dp_device *dp = ctx_from_connector(connector);
> -	struct drm_display_mode *mode;
> -
> -	if (dp->panel)
> -		return drm_panel_get_modes(dp->panel);
> +	struct analogix_dp_device *dp = connector_to_dp(connector);
> +	struct analogix_dp_plat_data *plat_data = dp->plat_data;
> +	int num_modes = 0;
>  
> -	mode = drm_mode_create(connector->dev);
> -	if (!mode) {
> -		DRM_ERROR("failed to create a new display mode.\n");
> -		return 0;
> -	}
> -
> -	drm_display_mode_from_videomode(&dp->priv.vm, mode);
> -	mode->width_mm = dp->priv.width_mm;
> -	mode->height_mm = dp->priv.height_mm;
> -	connector->display_info.width_mm = mode->width_mm;
> -	connector->display_info.height_mm = mode->height_mm;
> +	if (plat_data && plat_data->panel)
> +		num_modes += drm_panel_get_modes(plat_data->panel);
>  
> -	mode->type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> -	drm_mode_set_name(mode);
> -	drm_mode_probed_add(connector, mode);
> +	if (plat_data && plat_data->get_modes)
> +		 num_modes += plat_data->get_modes(plat_data, connector);
>  
> -	return 1;
> +	return num_modes;
>  }
>  
>  static struct drm_encoder *
> -exynos_dp_best_encoder(struct drm_connector *connector)
> +analogix_dp_best_encoder(struct drm_connector *connector)
>  {
> -	struct exynos_dp_device *dp = ctx_from_connector(connector);
> +	struct analogix_dp_device *dp = connector_to_dp(connector);
>  
> -	return &dp->encoder;
> +	return dp->encoder;
>  }
>  
> -static struct drm_connector_helper_funcs exynos_dp_connector_helper_funcs = {
> -	.get_modes = exynos_dp_get_modes,
> -	.best_encoder = exynos_dp_best_encoder,
> +static struct drm_connector_helper_funcs analogix_dp_connector_helper_funcs = {
> +	.get_modes = analogix_dp_get_modes,
> +	.best_encoder = analogix_dp_best_encoder,
>  };
>  
> -/* returns the number of bridges attached */
> -static int exynos_drm_attach_lcd_bridge(struct exynos_dp_device *dp,
> -					struct drm_encoder *encoder)
> -{
> -	int ret;
> -
> -	encoder->bridge->next = dp->ptn_bridge;
> -	dp->ptn_bridge->encoder = encoder;
> -	ret = drm_bridge_attach(encoder->dev, dp->ptn_bridge);
> -	if (ret) {
> -		DRM_ERROR("Failed to attach bridge to drm\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int exynos_dp_bridge_attach(struct drm_bridge *bridge)
> +static int analogix_dp_bridge_attach(struct drm_bridge *bridge)
>  {
> -	struct exynos_dp_device *dp = bridge->driver_private;
> -	struct drm_encoder *encoder = &dp->encoder;
> +	struct analogix_dp_device *dp = bridge->driver_private;
> +	struct drm_encoder *encoder = dp->encoder;
>  	struct drm_connector *connector = &dp->connector;
>  	int ret;
>  
> -	/* Pre-empt DP connector creation if there's a bridge */
> -	if (dp->ptn_bridge) {
> -		ret = exynos_drm_attach_lcd_bridge(dp, encoder);
> -		if (!ret)
> -			return 0;
> +	if (!bridge->encoder) {
> +		DRM_ERROR("Parent encoder object not found");
> +		return -ENODEV;
>  	}
>  
> +	encoder->bridge = bridge;
> +
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
>  	drm_mode_connector_attach_encoder(connector, encoder);
>  
> -	if (dp->panel)
> -		ret = drm_panel_attach(dp->panel, &dp->connector);
> +	if (dp->plat_data && dp->plat_data->panel) {
> +		ret = drm_panel_attach(dp->plat_data->panel, &dp->connector);
> +		if (ret) {
> +			DRM_ERROR("Failed to attach panel\n");
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * This should be the end of attach function, caused
> +	 * we should ensure dp bridge could attach first.
> +	 */
> +	 if (dp->plat_data && dp->plat_data->attach) {
> +		 ret = dp->plat_data->attach(dp->plat_data, bridge);
> +		 if (ret) {
> +			 DRM_ERROR("Failed at platform attch func\n");

Two new error paths appeared here and above. Don't you have to
cleanup something? I don't know, just wondering...

(...)

> @@ -1345,22 +1286,9 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
>  	disable_irq(dp->irq);
>  
>  	dp->drm_dev = drm_dev;
> +	dp->encoder = encoder;
>  
> -	pipe = exynos_drm_crtc_get_pipe_from_type(drm_dev,
> -						  EXYNOS_DISPLAY_TYPE_LCD);
> -	if (pipe < 0)
> -		return pipe;
> -
> -	encoder->possible_crtcs = 1 << pipe;
> -
> -	DRM_DEBUG_KMS("possible_crtcs = 0x%x\n", encoder->possible_crtcs);
> -
> -	drm_encoder_init(drm_dev, encoder, &exynos_dp_encoder_funcs,
> -			 DRM_MODE_ENCODER_TMDS);
> -
> -	drm_encoder_helper_add(encoder, &exynos_dp_encoder_helper_funcs);
> -
> -	ret = exynos_dp_create_connector(encoder);
> +	ret = analogix_dp_create_bridge(drm_dev, dp);
>  	if (ret) {
>  		DRM_ERROR("failed to create connector ret = %d\n", ret);
>  		drm_encoder_cleanup(encoder);
> @@ -1369,103 +1297,36 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(analogix_dp_bind);

Ooo, a new export symbol. I suppose it is necessary for the split
but the commit message does not mention exporting
anything nor the reason for doing it. Could you extend the commit
message describing more tha changes here and rationale for it?

(...)

> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> new file mode 100644
> index 0000000..b879d8c
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -0,0 +1,1265 @@
> +/*
> + * Analogix DP (Display port) core register interface driver.
> + *
> + * Copyright (C) 2012 Samsung Electronics Co., Ltd.
> + * Author: Jingoo Han <jg1.han@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +
> +#include "analogix_dp_core.h"
> +#include "analogix_dp_reg.h"
> +
> +#define COMMON_INT_MASK_1	0
> +#define COMMON_INT_MASK_2	0
> +#define COMMON_INT_MASK_3	0
> +#define COMMON_INT_MASK_4	(HOTPLUG_CHG | HPD_LOST | PLUG)
> +#define INT_STA_MASK		INT_HPD
> +
> +void analogix_dp_enable_video_mute(struct analogix_dp_device *dp, bool enable)
> +{
> +	u32 reg;
> +
> +	if (enable) {
> +		reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
> +		reg |= HDCP_VIDEO_MUTE;
> +		writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
> +	} else {
> +		reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
> +		reg &= ~HDCP_VIDEO_MUTE;
> +		writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
> +	}
> +}
> +
> +void analogix_dp_stop_video(struct analogix_dp_device *dp)
> +{
> +	u32 reg;
> +
> +	reg = readl(dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
> +	reg &= ~VIDEO_EN;
> +	writel(reg, dp->reg_base + ANALOGIX_DP_VIDEO_CTL_1);
> +}
> +
> +void analogix_dp_lane_swap(struct analogix_dp_device *dp, bool enable)
> +{
> +	u32 reg;
> +
> +	if (enable)
> +		reg = LANE3_MAP_LOGIC_LANE_0 | LANE2_MAP_LOGIC_LANE_1 |
> +			LANE1_MAP_LOGIC_LANE_2 | LANE0_MAP_LOGIC_LANE_3;
> +	else
> +		reg = LANE3_MAP_LOGIC_LANE_3 | LANE2_MAP_LOGIC_LANE_2 |
> +			LANE1_MAP_LOGIC_LANE_1 | LANE0_MAP_LOGIC_LANE_0;

Here and in few other places with new code: no alignment?

You spent some time fixing these in patch 1, so I would assume
that new code already comes after "checkpatch -f --subjective".
That's actually the only valid reason for using checkpatch - new code.
However my mail reader could corrupt the output so maybe this is aligned?

Code seems fine after looking at it but review was rather shallow.
I don't know the Exynos DP driver.

Best regards,
Krzysztof
