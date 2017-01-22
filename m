From: zyw@rock-chips.com (Chris Zhong)
Date: Sun, 22 Jan 2017 16:22:11 +0800
Subject: [PATCH v2 12/26] drm/rockchip: dw-mipi-dsi: prepare panel after
 phy init
In-Reply-To: <20170121163128.22240-13-john@metanate.com>
References: <20170121163128.22240-1-john@metanate.com>
 <20170121163128.22240-13-john@metanate.com>
Message-ID: <58846BB3.5060500@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John

Reviewed-by: Chris Zhong <zyw@rock-chips.com>

On 01/22/2017 12:31 AM, John Keeping wrote:
> Some panels need to be configured with commands sent over the MIPI link,
> which they will do in the prepare hook.  Call this after the PHY has
> been initialized so that we are able to send commands to the panel.
>
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> Unchanged in v2
> ---
>   drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index ddbc037e7ced..7ada6d8ed143 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -896,12 +896,14 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
>   	dw_mipi_dsi_dphy_timing_config(dsi);
>   	dw_mipi_dsi_dphy_interface_config(dsi);
>   	dw_mipi_dsi_clear_err(dsi);
> -	if (drm_panel_prepare(dsi->panel))
> -		dev_err(dsi->dev, "failed to prepare panel\n");
>   
>   	dw_mipi_dsi_phy_init(dsi);
>   	dw_mipi_dsi_wait_for_two_frames(mode);
>   
> +	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_CMD_MODE);
> +	if (drm_panel_prepare(dsi->panel))
> +		dev_err(dsi->dev, "failed to prepare panel\n");
> +
>   	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_VID_MODE);
>   	drm_panel_enable(dsi->panel);
>   
