From: seanpaul@chromium.org (Sean Paul)
Date: Mon, 30 Jan 2017 15:16:56 -0500
Subject: [PATCH v3 11/24] drm/rockchip: dw-mipi-dsi: prepare panel after
 phy init
In-Reply-To: <20170129132444.25251-12-john@metanate.com>
References: <20170129132444.25251-1-john@metanate.com>
 <20170129132444.25251-12-john@metanate.com>
Message-ID: <20170130201656.GN20076@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 01:24:31PM +0000, John Keeping wrote:
> Some panels need to be configured with commands sent over the MIPI link,
> which they will do in the prepare hook.  Call this after the PHY has
> been initialized so that we are able to send commands to the panel.
> 

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> Signed-off-by: John Keeping <john@metanate.com>
> Reviewed-by: Chris Zhong <zyw@rock-chips.com>
> ---
> v3:
> - Add Chris' Reviewed-by
> Unchanged in v2
> 
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index ddbc037e7ced..7ada6d8ed143 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -896,12 +896,14 @@ static void dw_mipi_dsi_encoder_enable(struct drm_encoder *encoder)
>  	dw_mipi_dsi_dphy_timing_config(dsi);
>  	dw_mipi_dsi_dphy_interface_config(dsi);
>  	dw_mipi_dsi_clear_err(dsi);
> -	if (drm_panel_prepare(dsi->panel))
> -		dev_err(dsi->dev, "failed to prepare panel\n");
>  
>  	dw_mipi_dsi_phy_init(dsi);
>  	dw_mipi_dsi_wait_for_two_frames(mode);
>  
> +	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_CMD_MODE);
> +	if (drm_panel_prepare(dsi->panel))
> +		dev_err(dsi->dev, "failed to prepare panel\n");
> +
>  	dw_mipi_dsi_set_mode(dsi, DW_MIPI_DSI_VID_MODE);
>  	drm_panel_enable(dsi->panel);
>  
> -- 
> 2.11.0.197.gb556de5.dirty
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
