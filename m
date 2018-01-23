From: briannorris@chromium.org (Brian Norris)
Date: Tue, 23 Jan 2018 12:49:40 -0800
Subject: [PATCH v3] drm/bridge/synopsys: dsi: add optional pixel clock
In-Reply-To: <20180123170806.5282-1-philippe.cornu@st.com>
References: <20180123170806.5282-1-philippe.cornu@st.com>
Message-ID: <20180123204939.qirvr34mlwgiwmqz@ban.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Philippe asked me to review the last version. I'm not sure I have a lot
to contribute. Maybe Rockchip folks who wrote this stuff in the first
place might. I've CC'd some.

On Tue, Jan 23, 2018 at 06:08:06PM +0100, Philippe Cornu wrote:
> The pixel clock is optional. When available, it offers a better
> preciseness for timing computations and allows to reduce the extra dsi
> bandwidth in burst mode (from ~20% to ~10-12%, hw platform dependant).
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
> Changes in v3: Simplify px_clk probing thanks to Andrzej Hajda comments
> 
> Changes in v2: Improve px_clk probing in case of ENOENT dt returned value
> (thanks to Philipp Zabel & Andrzej Hajda comments)
> 
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index ed8af32f8e52..9fb35385c348 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -217,6 +217,7 @@ struct dw_mipi_dsi {
>  	void __iomem *base;
>  
>  	struct clk *pclk;
> +	struct clk *px_clk;
>  
>  	unsigned int lane_mbps; /* per lane */
>  	u32 channel;
> @@ -703,24 +704,28 @@ static void dw_mipi_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  	struct dw_mipi_dsi *dsi = bridge_to_dsi(bridge);
>  	const struct dw_mipi_dsi_phy_ops *phy_ops = dsi->plat_data->phy_ops;
>  	void *priv_data = dsi->plat_data->priv_data;
> +	struct drm_display_mode px_clk_mode = *mode;
>  	int ret;
>  
>  	clk_prepare_enable(dsi->pclk);
>  
> -	ret = phy_ops->get_lane_mbps(priv_data, mode, dsi->mode_flags,
> +	if (dsi->px_clk)
> +		px_clk_mode.clock = clk_get_rate(dsi->px_clk) / 1000;
> +
> +	ret = phy_ops->get_lane_mbps(priv_data, &px_clk_mode, dsi->mode_flags,
>  				     dsi->lanes, dsi->format, &dsi->lane_mbps);
>  	if (ret)
>  		DRM_DEBUG_DRIVER("Phy get_lane_mbps() failed\n");
>  
>  	pm_runtime_get_sync(dsi->dev);
>  	dw_mipi_dsi_init(dsi);
> -	dw_mipi_dsi_dpi_config(dsi, mode);
> +	dw_mipi_dsi_dpi_config(dsi, &px_clk_mode);
>  	dw_mipi_dsi_packet_handler_config(dsi);
>  	dw_mipi_dsi_video_mode_config(dsi);
> -	dw_mipi_dsi_video_packet_config(dsi, mode);
> +	dw_mipi_dsi_video_packet_config(dsi, &px_clk_mode);
>  	dw_mipi_dsi_command_mode_config(dsi);
> -	dw_mipi_dsi_line_timer_config(dsi, mode);
> -	dw_mipi_dsi_vertical_timing_config(dsi, mode);
> +	dw_mipi_dsi_line_timer_config(dsi, &px_clk_mode);
> +	dw_mipi_dsi_vertical_timing_config(dsi, &px_clk_mode);
>  
>  	dw_mipi_dsi_dphy_init(dsi);
>  	dw_mipi_dsi_dphy_timing_config(dsi);
> @@ -734,7 +739,7 @@ static void dw_mipi_dsi_bridge_mode_set(struct drm_bridge *bridge,
>  
>  	dw_mipi_dsi_dphy_enable(dsi);
>  
> -	dw_mipi_dsi_wait_for_two_frames(mode);
> +	dw_mipi_dsi_wait_for_two_frames(&px_clk_mode);
>  
>  	/* Switch to cmd mode for panel-bridge pre_enable & panel prepare */
>  	dw_mipi_dsi_set_mode(dsi, 0);
> @@ -828,6 +833,14 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
>  		return ERR_PTR(ret);
>  	}
>  
> +	dsi->px_clk = devm_clk_get(dev, "px_clk");

Did you write a device tree binding document update for this anywhere?

Brian

> +	if (IS_ERR(dsi->px_clk)) {
> +		ret = PTR_ERR(dsi->px_clk);
> +		if (ret != ENOENT)
> +			dev_err(dev, "Unable to get opt. px_clk: %d\n", ret);
> +		dsi->px_clk = NULL;
> +	}
> +
>  	/*
>  	 * Note that the reset was not defined in the initial device tree, so
>  	 * we have to be prepared for it not being found.
> -- 
> 2.15.1
> 
