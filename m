From: yang.zheng@rock-chips.com (Zheng Yang)
Date: Fri, 28 Sep 2018 15:52:38 +0800
Subject: Fwd: [PATCH v5 4/6] drm/rockchip: dw_hdmi: allow including
 external phys
In-Reply-To: <4187b1f6-9682-6c3e-741e-0374e3e9165b@rock-chips.com>
References: <20180912124740.20343-5-heiko@sntech.de>
 <4187b1f6-9682-6c3e-741e-0374e3e9165b@rock-chips.com>
Message-ID: <e9f9b542-9865-5832-3829-086ec6a59e3a@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Heiko:

Reviewed-by: zhengyang <zhengyang@rock-chips.com>

> Some variants of the dw-hdmi on Rockchip socs use a separate phy block
> accessed via the generic phy framework, so allow them to be included
> if such a phy reference is found.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Robin Murphy <robin.murphy@arm.com>
> ---
> ?drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 10 ++++++++++
> ?1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c 
> b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index b09c3531305b..57e76dfd5f6d 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -11,6 +11,7 @@
> ?#include <linux/mfd/syscon.h>
> ?#include <linux/module.h>
> ?#include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
> ?#include <linux/regmap.h>
> ? #include <drm/drm_of.h>
> @@ -49,6 +50,7 @@ struct rockchip_hdmi {
> ???? struct clk *vpll_clk;
> ???? struct clk *grf_clk;
> ???? struct dw_hdmi *hdmi;
> +??? struct phy *phy;
> ?};
> ? #define to_rockchip_hdmi(x)??? container_of(x, struct rockchip_hdmi, x)
> @@ -376,6 +378,14 @@ static int dw_hdmi_rockchip_bind(struct device 
> *dev, struct device *master,
> ???????? return ret;
> ???? }
> ?+??? hdmi->phy = devm_phy_optional_get(dev, "hdmi");
> +??? if (IS_ERR(hdmi->phy)) {
> +??????? ret = PTR_ERR(hdmi->phy);
> +??????? if (ret != -EPROBE_DEFER)
> +??????????? DRM_DEV_ERROR(hdmi->dev, "failed to get phy\n");
> +??????? return ret;
> +??? }
> +
> ???? drm_encoder_helper_add(encoder, 
> &dw_hdmi_rockchip_encoder_helper_funcs);
> ???? drm_encoder_init(drm, encoder, &dw_hdmi_rockchip_encoder_funcs,
> ????????????? DRM_MODE_ENCODER_TMDS, NULL);
