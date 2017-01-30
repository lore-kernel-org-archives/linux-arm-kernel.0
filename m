From: seanpaul@chromium.org (Sean Paul)
Date: Mon, 30 Jan 2017 15:25:10 -0500
Subject: [PATCH v3 13/24] drm/rockchip: dw-mipi-dsi: fix escape clock rate
In-Reply-To: <20170129132444.25251-14-john@metanate.com>
References: <20170129132444.25251-1-john@metanate.com>
 <20170129132444.25251-14-john@metanate.com>
Message-ID: <20170130202510.GP20076@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 01:24:33PM +0000, John Keeping wrote:
> This clock rate is derived from the PHY PLL, so it should be calculated
> dynamically.  Use the same calculation as the vendor kernel to derive
> the escape clock speed.
> 

Nit below, but

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> Signed-off-by: John Keeping <john@metanate.com>
> Reviewed-by: Chris Zhong <zyw@rock-chips.com>
> ---
> v3:
> - Improve the commit message a bit
> - Add Chris' Reviewed-by
> Unchanged in v2
> 
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index 290282e86d16..c2e0ba96e0a0 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -710,11 +710,13 @@ static void dw_mipi_dsi_disable(struct dw_mipi_dsi *dsi)
>  
>  static void dw_mipi_dsi_init(struct dw_mipi_dsi *dsi)
>  {

Nit: It would be nice to add a comment to the effect of "You are not meant to
understand this, it comes from the vendor kernel"

> +	u32 esc_clk_division = (dsi->lane_mbps >> 3) / 20 + 1;
> +
>  	dsi_write(dsi, DSI_PWR_UP, RESET);
>  	dsi_write(dsi, DSI_PHY_RSTZ, PHY_DISFORCEPLL | PHY_DISABLECLK
>  		  | PHY_RSTZ | PHY_SHUTDOWNZ);
>  	dsi_write(dsi, DSI_CLKMGR_CFG, TO_CLK_DIVIDSION(10) |
> -		  TX_ESC_CLK_DIVIDSION(7));
> +		  TX_ESC_CLK_DIVIDSION(esc_clk_division));
>  }
>  
>  static void dw_mipi_dsi_dpi_config(struct dw_mipi_dsi *dsi,
> -- 
> 2.11.0.197.gb556de5.dirty
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
