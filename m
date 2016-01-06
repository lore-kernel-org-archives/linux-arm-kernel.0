From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 06 Jan 2016 14:30:19 +0800
Subject: [PATCH v7 3/5] drm: rockchip: Support Synopsys DW MIPI DSI
In-Reply-To: <1452053038-32098-4-git-send-email-zyw@rock-chips.com>
References: <1452053038-32098-1-git-send-email-zyw@rock-chips.com>
 <1452053038-32098-4-git-send-email-zyw@rock-chips.com>
Message-ID: <568CB47B.1010205@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris

Looks good for me except some tiny issues.


On 2016?01?06? 12:03, Chris Zhong wrote:
> +struct dw_mipi_dsi {
> +	struct drm_encoder encoder;
> +	struct drm_connector connector;
> +	struct mipi_dsi_host dsi_host;
> +	struct drm_panel *panel;
> +	struct device *dev;
> +	struct regmap *grf_regmap;
> +	void __iomem *base;
> +
> +	struct clk *pllref_clk;
> +	struct clk *pclk;
> +
> +	unsigned int lane_mbps; /* per lane */
> +	u32 channel;
> +	u32 lanes;
> +	u32 format;
> +	u16 input_div;
> +	u16 feedback_div;
> +	struct drm_display_mode *mode;
> +
> +	const struct dw_mipi_dsi_plat_data *pdata;
> +

remove this blank line.

> +};
> +

[...]

> +static void dw_mipi_dsi_encoder_mode_set(struct drm_encoder *encoder,
> +					struct drm_display_mode *mode,
> +					struct drm_display_mode *adjusted_mode)
> +{
> +	struct dw_mipi_dsi *dsi = encoder_to_dsi(encoder);
> +	int ret;
> +
> +	dsi->mode = adjusted_mode;
> +
> +	ret = dw_mipi_dsi_get_lane_bps(dsi);
> +	if (ret < 0)
> +		return;
> +
> +	if (clk_prepare_enable(dsi->pclk)) {
> +		dev_err(dsi->dev, "%s: Failed to enable pclk\n", __func__);
> +		return;
> +	}
> +
> +	dw_mipi_dsi_init(dsi);
> +	dw_mipi_dsi_dpi_config(dsi, mode);
> +	dw_mipi_dsi_packet_handler_config(dsi);
> +	dw_mipi_dsi_video_mode_config(dsi);
> +	dw_mipi_dsi_video_packet_config(dsi, mode);
> +	dw_mipi_dsi_command_mode_config(dsi);
> +	dw_mipi_dsi_line_timer_config(dsi);
> +	dw_mipi_dsi_vertical_timing_config(dsi);
> +	dw_mipi_dsi_dphy_timing_config(dsi);
> +	dw_mipi_dsi_dphy_interface_config(dsi);
> +	dw_mipi_dsi_clear_err(dsi);
> +	if (drm_panel_prepare(dsi->panel)) {
> +		dev_err(dsi->dev, "failed to prepare panel\n");

Don't forget doing clk_disable_unprepare when run into error path.

> +		return;
> +	}
> +	clk_disable_unprepare(dsi->pclk);
> +}
> +


-- 
?ark Yao
