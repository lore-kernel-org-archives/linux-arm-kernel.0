From: seanpaul@chromium.org (Sean Paul)
Date: Tue, 31 Jan 2017 13:45:05 -0500
Subject: [PATCH v3 18/24] drm/rockchip: dw-mipi-dsi: use specific poll
 helper
In-Reply-To: <20170129132444.25251-19-john@metanate.com>
References: <20170129132444.25251-1-john@metanate.com>
 <20170129132444.25251-19-john@metanate.com>
Message-ID: <20170131184505.GA20076@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 01:24:38PM +0000, John Keeping wrote:
> As the documentation for readx_poll_timeout says, we want to use the
> specialized macro for readl rather than using the generic version
> directly.
> 

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> Signed-off-by: John Keeping <john@metanate.com>
> Reviewed-by: Chris Zhong <zyw@rock-chips.com>
> ---
> v3:
> - Add Chris' Reviewed-by
> Unchanged in v2
> 
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index dcb66a21e1f1..be395c3c5c06 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -474,14 +474,14 @@ static int dw_mipi_dsi_phy_init(struct dw_mipi_dsi *dsi)
>  				     PHY_UNRSTZ | PHY_UNSHUTDOWNZ);
>  
>  
> -	ret = readx_poll_timeout(readl, dsi->base + DSI_PHY_STATUS,
> +	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
>  				 val, val & LOCK, 1000, PHY_STATUS_TIMEOUT_US);
>  	if (ret < 0) {
>  		dev_err(dsi->dev, "failed to wait for phy lock state\n");
>  		return ret;
>  	}
>  
> -	ret = readx_poll_timeout(readl, dsi->base + DSI_PHY_STATUS,
> +	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
>  				 val, val & STOP_STATE_CLK_LANE, 1000,
>  				 PHY_STATUS_TIMEOUT_US);
>  	if (ret < 0) {
> @@ -597,7 +597,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
>  	int ret;
>  	u32 val, mask;
>  
> -	ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
> +	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>  				 val, !(val & GEN_CMD_FULL), 1000,
>  				 CMD_PKT_STATUS_TIMEOUT_US);
>  	if (ret < 0) {
> @@ -608,7 +608,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
>  	dsi_write(dsi, DSI_GEN_HDR, hdr_val);
>  
>  	mask = GEN_CMD_EMPTY | GEN_PLD_W_EMPTY;
> -	ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
> +	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>  				 val, (val & mask) == mask,
>  				 1000, CMD_PKT_STATUS_TIMEOUT_US);
>  	if (ret < 0) {
> @@ -667,7 +667,7 @@ static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
>  			len -= pld_data_bytes;
>  		}
>  
> -		ret = readx_poll_timeout(readl, dsi->base + DSI_CMD_PKT_STATUS,
> +		ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>  					 val, !(val & GEN_PLD_W_FULL), 1000,
>  					 CMD_PKT_STATUS_TIMEOUT_US);
>  		if (ret < 0) {
> -- 
> 2.11.0.197.gb556de5.dirty
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
