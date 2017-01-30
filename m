From: seanpaul@chromium.org (Sean Paul)
Date: Mon, 30 Jan 2017 15:25:47 -0500
Subject: [PATCH v3 14/24] drm/rockchip: dw-mipi-dsi: ensure PHY is reset
In-Reply-To: <20170129132444.25251-15-john@metanate.com>
References: <20170129132444.25251-1-john@metanate.com>
 <20170129132444.25251-15-john@metanate.com>
Message-ID: <20170130202547.GQ20076@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 01:24:34PM +0000, John Keeping wrote:
> Also don't power up the DSI host at this point since this is not
> necessary in order to configure the PHY and we do so later when
> selecting video or command mode.
> 

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> Signed-off-by: John Keeping <john@metanate.com>
> Reviewed-by: Chris Zhong <zyw@rock-chips.com>
> ---
> v3:
> - Add Chris' Reviewed-by
> Unchanged in v2
> 
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index c2e0ba96e0a0..5b3068e9e8db 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -397,7 +397,10 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
>  		return testdin;
>  	}
>  
> -	dsi_write(dsi, DSI_PWR_UP, POWERUP);
> +	/* Start by clearing PHY state */
> +	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
> +	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_TESTCLR);
> +	dsi_write(dsi, DSI_PHY_TST_CTRL0, PHY_UNTESTCLR);
>  
>  	dw_mipi_dsi_phy_write(dsi, 0x10, BYPASS_VCO_RANGE |
>  					 VCO_RANGE_CON_SEL(vco) |
> -- 
> 2.11.0.197.gb556de5.dirty
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
