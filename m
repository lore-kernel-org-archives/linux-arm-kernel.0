From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 19 Feb 2018 18:59:02 +0200
Subject: [PATCH v2 3/8] drm/bridge: dw-hdmi: allow overriding of phy-type
 reading
In-Reply-To: <20180216204158.29839-4-heiko@sntech.de>
References: <20180216204158.29839-1-heiko@sntech.de>
 <20180216204158.29839-4-heiko@sntech.de>
Message-ID: <3905607.btOD7ERYi5@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

Thank you for the patch.

On Friday, 16 February 2018 22:41:53 EET Heiko Stuebner wrote:
> In some IP implementations the reading of the phy-type may be broken.
> One example are the Rockchip rk3228 and rk3328 socs that use a separate
> phy from Innosilicon but still report the HDMI20_TX type.
> 
> So allow the glue driver to force a specific type, like the vendor-phy
> for these cases.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 +++-
>  include/drm/bridge/dw_hdmi.h              | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> f9802399cc0d..50d231626c4d 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2218,7 +2218,9 @@ static int dw_hdmi_detect_phy(struct dw_hdmi *hdmi)
>  	unsigned int i;
>  	u8 phy_type;
> 
> -	phy_type = hdmi_readb(hdmi, HDMI_CONFIG2_ID);
> +	phy_type = (hdmi->plat_data->phy_force_type) ?
> +				hdmi->plat_data->phy_force_type :
> +				hdmi_readb(hdmi, HDMI_CONFIG2_ID);

No need for parentheses. You could even write this

        phy_type = hdmi->plat_data->phy_force_type ? 
                 : hdmi_readb(hdmi, HDMI_CONFIG2_ID);

but that's up to you.

What if a driver wants to force the PHY type to DW_HDMI_PHY_DWC_HDMI_TX_PHY ? 
Or do you expect only the DW_HDMI_PHY_VENDOR_PHY type to be forced ? If so, we 
could also use a force_vendor_phy boolean field instead of phy_force_type.

>  	if (phy_type == DW_HDMI_PHY_VENDOR_PHY) {
>  		/* Vendor PHYs require support from the glue layer. */
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index dd2a8cf7d20b..3c1dddb09b95 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -133,6 +133,7 @@ struct dw_hdmi_plat_data {
>  	const struct dw_hdmi_phy_ops *phy_ops;
>  	const char *phy_name;
>  	void *phy_data;
> +	u8 phy_force_type;
> 
>  	/* Synopsys PHY support */
>  	const struct dw_hdmi_mpll_config *mpll_cfg;

-- 
Regards,

Laurent Pinchart
