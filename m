From: martyn.welch@collabora.co.uk (Martyn Welch)
Date: Tue, 16 Aug 2016 16:40:40 +0100
Subject: [PATCH V4 1/4] drm/imx-ldb: Add support to drm-bridge
In-Reply-To: <81f3fd13ea909e6442d6fde8693c8e991a2a50f8.1470346720.git.peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
 <cover.1470346720.git.peter.senna@collabora.com>
 <81f3fd13ea909e6442d6fde8693c8e991a2a50f8.1470346720.git.peter.senna@collabora.com>
Message-ID: <474dea2a-47c7-13ba-86c1-1184937351fb@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/08/16 23:36, Peter Senna Tschudin wrote:
> Add support to attach a drm_bridge to imx-ldb in addition to
> existing support to attach a LVDS panel.
>
> This patch does a simple code refactoring by moving code
> from for_each_child_of_node iterator to a new function named
> imx_ldb_panel_ddc(). This was necessary to allow the panel ddc
> code to run only when the imx_ldb is not attached to a bridge.
>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>

Acked-by: Martyn Welch <martyn.welch@collabora.co.uk>

> ---
> Changes from V3:
>  - The connector is created when there is no bridge instead of only when
>    there is a pannel
>  - Tested on next-20160804
>
> Changes from V2:
>  - Updated to be aplied on top of Liu Ying changes that made imx-ldb atomic
>  - Tested on next-20160729
>
> Changes from V1:
>  - Reanmed ext_bridge to bridge
>  - Removed empty entry point imx_ldb_encoder_enable()
>  - Adapted the code to apply to the latest linux next: next-20160609
>
>  drivers/gpu/drm/imx/imx-ldb.c | 118 ++++++++++++++++++++++++++++--------------
>  1 file changed, 78 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
> index b03919e..4a33077 100644
> --- a/drivers/gpu/drm/imx/imx-ldb.c
> +++ b/drivers/gpu/drm/imx/imx-ldb.c
> @@ -57,7 +57,11 @@ struct imx_ldb_channel {
>  	struct imx_ldb *ldb;
>  	struct drm_connector connector;
>  	struct drm_encoder encoder;
> +
> +	/* Defines what is connected to the ldb, only one at a time */
>  	struct drm_panel *panel;
> +	struct drm_bridge *bridge;
> +
>  	struct device_node *child;
>  	struct i2c_adapter *ddc;
>  	int chno;
> @@ -466,10 +470,30 @@ static int imx_ldb_register(struct drm_device *drm,
>  	drm_encoder_init(drm, encoder, &imx_ldb_encoder_funcs,
>  			 DRM_MODE_ENCODER_LVDS, NULL);
>
> -	drm_connector_helper_add(&imx_ldb_ch->connector,
> -			&imx_ldb_connector_helper_funcs);
> -	drm_connector_init(drm, &imx_ldb_ch->connector,
> -			   &imx_ldb_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
> +	if (imx_ldb_ch->bridge) {
> +		imx_ldb_ch->bridge->encoder = encoder;
> +
> +		imx_ldb_ch->encoder.bridge = imx_ldb_ch->bridge;
> +		ret = drm_bridge_attach(drm, imx_ldb_ch->bridge);
> +		if (ret) {
> +			DRM_ERROR("Failed to initialize bridge with drm\n");
> +			return ret;
> +		}
> +	} else {
> +		/*
> +		 * We want to add the connector whenever there is no bridge
> +		 * that brings its own, not only when there is a panel. For
> +		 * historical reasons, the ldb driver can also work without
> +		 * a panel.
> +		 */
> +		drm_connector_helper_add(&imx_ldb_ch->connector,
> +				&imx_ldb_connector_helper_funcs);
> +		drm_connector_init(drm, &imx_ldb_ch->connector,
> +				&imx_ldb_connector_funcs,
> +				DRM_MODE_CONNECTOR_LVDS);
> +		drm_mode_connector_attach_encoder(&imx_ldb_ch->connector,
> +				encoder);
> +	}
>
>  	if (imx_ldb_ch->panel) {
>  		ret = drm_panel_attach(imx_ldb_ch->panel,
> @@ -478,8 +502,6 @@ static int imx_ldb_register(struct drm_device *drm,
>  			return ret;
>  	}
>
> -	drm_mode_connector_attach_encoder(&imx_ldb_ch->connector, encoder);
> -
>  	return 0;
>  }
>
> @@ -548,6 +570,45 @@ static const struct of_device_id imx_ldb_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, imx_ldb_dt_ids);
>
> +static int imx_ldb_panel_ddc(struct device *dev,
> +		struct imx_ldb_channel *channel, struct device_node *child)
> +{
> +	struct device_node *ddc_node;
> +	const u8 *edidp;
> +	int ret;
> +
> +	ddc_node = of_parse_phandle(child, "ddc-i2c-bus", 0);
> +	if (ddc_node) {
> +		channel->ddc = of_find_i2c_adapter_by_node(ddc_node);
> +		of_node_put(ddc_node);
> +		if (!channel->ddc) {
> +			dev_warn(dev, "failed to get ddc i2c adapter\n");
> +			return -EPROBE_DEFER;
> +		}
> +	}
> +
> +	if (!channel->ddc) {
> +		/* if no DDC available, fallback to hardcoded EDID */
> +		dev_dbg(dev, "no ddc available\n");
> +
> +		edidp = of_get_property(child, "edid",
> +					&channel->edid_len);
> +		if (edidp) {
> +			channel->edid = kmemdup(edidp,
> +						channel->edid_len,
> +						GFP_KERNEL);
> +		} else if (!channel->panel) {
> +			/* fallback to display-timings node */
> +			ret = of_get_drm_display_mode(child,
> +						      &channel->mode,
> +						      OF_USE_NATIVE_MODE);
> +			if (!ret)
> +				channel->mode_valid = 1;
> +		}
> +	}
> +	return 0;
> +}
> +
>  static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
>  {
>  	struct drm_device *drm = data;
> @@ -555,7 +616,6 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
>  	const struct of_device_id *of_id =
>  			of_match_device(imx_ldb_dt_ids, dev);
>  	struct device_node *child;
> -	const u8 *edidp;
>  	struct imx_ldb *imx_ldb;
>  	int dual;
>  	int ret;
> @@ -605,7 +665,6 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
>
>  	for_each_child_of_node(np, child) {
>  		struct imx_ldb_channel *channel;
> -		struct device_node *ddc_node;
>  		struct device_node *ep;
>  		int bus_format;
>
> @@ -638,46 +697,25 @@ static int imx_ldb_bind(struct device *dev, struct device *master, void *data)
>
>  			remote = of_graph_get_remote_port_parent(ep);
>  			of_node_put(ep);
> -			if (remote)
> +			if (remote) {
>  				channel->panel = of_drm_find_panel(remote);
> -			else
> +				channel->bridge = of_drm_find_bridge(remote);
> +			} else
>  				return -EPROBE_DEFER;
>  			of_node_put(remote);
> -			if (!channel->panel) {
> -				dev_err(dev, "panel not found: %s\n",
> -					remote->full_name);
> -				return -EPROBE_DEFER;
> -			}
> -		}
>
> -		ddc_node = of_parse_phandle(child, "ddc-i2c-bus", 0);
> -		if (ddc_node) {
> -			channel->ddc = of_find_i2c_adapter_by_node(ddc_node);
> -			of_node_put(ddc_node);
> -			if (!channel->ddc) {
> -				dev_warn(dev, "failed to get ddc i2c adapter\n");
> +			if (!channel->panel && !channel->bridge) {
> +				dev_err(dev, "panel/bridge not found: %s\n",
> +					remote->full_name);
>  				return -EPROBE_DEFER;
>  			}
>  		}
>
> -		if (!channel->ddc) {
> -			/* if no DDC available, fallback to hardcoded EDID */
> -			dev_dbg(dev, "no ddc available\n");
> -
> -			edidp = of_get_property(child, "edid",
> -						&channel->edid_len);
> -			if (edidp) {
> -				channel->edid = kmemdup(edidp,
> -							channel->edid_len,
> -							GFP_KERNEL);
> -			} else if (!channel->panel) {
> -				/* fallback to display-timings node */
> -				ret = of_get_drm_display_mode(child,
> -							      &channel->mode,
> -							      OF_USE_NATIVE_MODE);
> -				if (!ret)
> -					channel->mode_valid = 1;
> -			}
> +		/* panel ddc only if there is no bridge */
> +		if (!channel->bridge) {
> +			ret = imx_ldb_panel_ddc(dev, channel, child);
> +			if (ret)
> +				return ret;
>  		}
>
>  		bus_format = of_get_bus_format(dev, child);
>
