From: yang.zheng@rock-chips.com (Zheng Yang)
Date: Fri, 28 Sep 2018 15:51:53 +0800
Subject: [PATCH v5 1/6] drm/bridge: dw-hdmi: allow forcing vendor phy-type
In-Reply-To: <1851d56f-b628-2d10-0da7-72c1075b2b9a@rock-chips.com>
References: <20180912124740.20343-2-heiko@sntech.de>
 <1851d56f-b628-2d10-0da7-72c1075b2b9a@rock-chips.com>
Message-ID: <9004bd11-02f3-92dc-9cf2-23b589efd29b@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Heiko:

Reviewed-by: zhengyang <zhengyang@rock-chips.com>

>
> In some IP implementations the reading of the phy-type may be broken.
> One example are the Rockchip rk3228 and rk3328 socs that use a separate
> vendor-type phy from Innosilicon but still report the HDMI20_TX type.
>
> So allow the glue driver to force the vendor-phy for these cases.
> In the future it may be necessary to allow forcing other types, but
> for now we'll keep it simply to the case actually seen in the wild.
>
> changes in v3:
> - only allow forcing vendor type, as suggested by Laurent
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Robin Murphy <robin.murphy@arm.com>
> ---
> ?drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 +++-
> ?include/drm/bridge/dw_hdmi.h????????????? | 1 +
> ?2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c 
> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 5971976284bf..ac37c50d6c4b 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2205,7 +2205,9 @@ static int dw_hdmi_detect_phy(struct dw_hdmi *hdmi)
> ???? unsigned int i;
> ???? u8 phy_type;
> ?-??? phy_type = hdmi_readb(hdmi, HDMI_CONFIG2_ID);
> +??? phy_type = hdmi->plat_data->phy_force_vendor ?
> +??????????????? DW_HDMI_PHY_VENDOR_PHY :
> +??????????????? hdmi_readb(hdmi, HDMI_CONFIG2_ID);
> ????? if (phy_type == DW_HDMI_PHY_VENDOR_PHY) {
> ???????? /* Vendor PHYs require support from the glue layer. */
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index ccb5aa8468e0..6ef3236bb6dd 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -133,6 +133,7 @@ struct dw_hdmi_plat_data {
> ???? const struct dw_hdmi_phy_ops *phy_ops;
> ???? const char *phy_name;
> ???? void *phy_data;
> +??? bool phy_force_vendor;
> ????? /* Synopsys PHY support */
> ???? const struct dw_hdmi_mpll_config *mpll_cfg;
