From: zyw@rock-chips.com (Chris Zhong)
Date: Sun, 22 Jan 2017 11:58:32 +0800
Subject: [PATCH v2 01/26] drm/rockchip: dw-mipi-dsi: don't configure
 hardware in mode_set for MIPI
In-Reply-To: <20170121163128.22240-2-john@metanate.com>
References: <20170121163128.22240-1-john@metanate.com>
 <20170121163128.22240-2-john@metanate.com>
Message-ID: <58842DE8.1080604@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John


On 01/22/2017 12:31 AM, John Keeping wrote:
> With atomic modesetting the hardware will be powered off when the
> mode_set function is called.  We should configure the hardware in the
> commit function (or even the enable function, but switching from commit
> to enable is left for a future patch).

I tend to merge the 2 patches into one.

>
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> v2:
> - also move dw_mipi_dsi_get_lane_bps into the commit function
> ---
>   drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 45 ++++++++++++++--------------------
>   1 file changed, 19 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index d9aa382bb629..8b83ae50c8f3 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -819,34 +819,8 @@ static void dw_mipi_dsi_encoder_mode_set(struct drm_encoder *encoder,
>   					struct drm_display_mode *adjusted_mode)
>   {
>   	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
> -	int ret;
>   
>   	dsi->mode = adjusted_mode;
> -
> -	ret = dw_mipi_dsi_get_lane_bps(dsi);
> -	if (ret < 0)
> -		return;
> -
> -	if (clk_prepare_enable(dsi->pclk)) {
> -		dev_err(dsi->dev, "%s: Failed to enable pclk\n", __func__);
> -		return;
> -	}
> -
> -	dw_mipi_dsi_init(dsi);
> -	dw_mipi_dsi_dpi_config(dsi, mode);
> -	dw_mipi_dsi_packet_handler_config(dsi);
> -	dw_mipi_dsi_video_mode_config(dsi);
> -	dw_mipi_dsi_video_packet_config(dsi, mode);
> -	dw_mipi_dsi_command_mode_config(dsi);
> -	dw_mipi_dsi_line_timer_config(dsi);
> -	dw_mipi_dsi_vertical_timing_config(dsi);
> -	dw_mipi_dsi_dphy_timing_config(dsi);
> -	dw_mipi_dsi_dphy_interface_config(dsi);
> -	dw_mipi_dsi_clear_err(dsi);
> -	if (drm_panel_prepare(dsi->panel))
> -		dev_err(dsi->dev, "failed to prepare panel\n");
> -
> -	clk_disable_unprepare(dsi->pclk);
>   }
>   
>   static void dw_mipi_dsi_encoder_disable(struct drm_encoder *encoder)
> @@ -880,12 +854,31 @@ static void dw_mipi_dsi_encoder_commit(struct drm_encoder *encoder)
>   	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
>   	int mux = drm_of_encoder_active_endpoint_id(dsi->dev->of_node, encoder);
>   	u32 val;
> +	int ret;
> +
> +	ret = dw_mipi_dsi_get_lane_bps(dsi);
> +	if (ret < 0)
> +		return;
>   
>   	if (clk_prepare_enable(dsi->pclk)) {
>   		dev_err(dsi->dev, "%s: Failed to enable pclk\n", __func__);
>   		return;
>   	}
>   
> +	dw_mipi_dsi_init(dsi);
> +	dw_mipi_dsi_dpi_config(dsi, dsi->mode);
> +	dw_mipi_dsi_packet_handler_config(dsi);
> +	dw_mipi_dsi_video_mode_config(dsi);
> +	dw_mipi_dsi_video_packet_config(dsi, dsi->mode);
> +	dw_mipi_dsi_command_mode_config(dsi);
> +	dw_mipi_dsi_line_timer_config(dsi);
> +	dw_mipi_dsi_vertical_timing_config(dsi);
> +	dw_mipi_dsi_dphy_timing_config(dsi);
> +	dw_mipi_dsi_dphy_interface_config(dsi);
> +	dw_mipi_dsi_clear_err(dsi);
> +	if (drm_panel_prepare(dsi->panel))
> +		dev_err(dsi->dev, "failed to prepare panel\n");
> +
>   	dw_mipi_dsi_phy_init(dsi);
>   	dw_mipi_dsi_wait_for_two_frames(dsi);
>   
