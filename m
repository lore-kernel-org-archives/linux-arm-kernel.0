From: yang.zheng@rock-chips.com (Zheng Yang)
Date: Fri, 28 Sep 2018 15:52:46 +0800
Subject: Fwd: [PATCH v5 5/6] drm/rockchip: dw_hdmi: store rockchip_hdmi
 reference in phy_data object
In-Reply-To: <3a8b88a3-ec0c-cf39-0a97-a941068318c2@rock-chips.com>
References: <20180912124740.20343-6-heiko@sntech.de>
 <3a8b88a3-ec0c-cf39-0a97-a941068318c2@rock-chips.com>
Message-ID: <25eb567a-50b1-cac6-e09c-278af6c95250@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Heiko:

Reviewed-by: zhengyang <zhengyang@rock-chips.com>

>
> When using special phy handling operations we'll often need access to
> the rockchip_hdmi struct.
>
> As the chip-data that occupies the phy_data pointer initially gets
> assigned to the rockchip_hdmi struct, we can now re-use this phy_data
> pointer to hold the reference to the rockchip_hdmi struct and use this
> reference later on.
>
> Inspiration for this comes from meson and sunxi dw-hdmi, which are using
> the same method.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Robin Murphy <robin.murphy@arm.com>
>
> changes in v3:
> - reword commit message
> ---
> ?drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 9 +++++++--
> ?1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c 
> b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index 57e76dfd5f6d..19f002fa0a09 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -335,7 +335,7 @@ static int dw_hdmi_rockchip_bind(struct device 
> *dev, struct device *master,
> ????????????????? void *data)
> ?{
> ???? struct platform_device *pdev = to_platform_device(dev);
> -??? const struct dw_hdmi_plat_data *plat_data;
> +??? struct dw_hdmi_plat_data *plat_data;
> ???? const struct of_device_id *match;
> ???? struct drm_device *drm = data;
> ???? struct drm_encoder *encoder;
> @@ -350,9 +350,14 @@ static int dw_hdmi_rockchip_bind(struct device 
> *dev, struct device *master,
> ???????? return -ENOMEM;
> ????? match = of_match_node(dw_hdmi_rockchip_dt_ids, pdev->dev.of_node);
> -??? plat_data = match->data;
> +??? plat_data = devm_kmemdup(&pdev->dev, match->data,
> +???????????????????????? sizeof(*plat_data), GFP_KERNEL);
> +??? if (!plat_data)
> +??????? return -ENOMEM;
> +
> ???? hdmi->dev = &pdev->dev;
> ???? hdmi->chip_data = plat_data->phy_data;
> +??? plat_data->phy_data = hdmi;
> ???? encoder = &hdmi->encoder;
> ????? encoder->possible_crtcs = drm_of_find_possible_crtcs(drm, 
> dev->of_node);
