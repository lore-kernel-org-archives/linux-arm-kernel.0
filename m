From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 12 Jul 2016 16:27:40 +0200
Subject: [PATCH v1 5/6] drm/rockchip: dw_hdmi: introduce the VPLL clock
 setting
In-Reply-To: <1468235149-29625-1-git-send-email-ykk@rock-chips.com>
References: <1468235079-29152-1-git-send-email-ykk@rock-chips.com>
 <1468235149-29625-1-git-send-email-ykk@rock-chips.com>
Message-ID: <3636683.EuFECY2EQB@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

Am Montag, 11. Juli 2016, 19:05:49 schrieb Yakir Yang:
> For RK3399 HDMI, there is an external clock need for HDMI PHY,
> and it should keep the same clock rate with VOP DCLK.
> 
> VPLL have supported the clock for HDMI PHY, but there is no
> clock divider bewteen VPLL and HDMI PHY. So we need to set the
> VPLL rate manually in HDMI driver.

I don't think reserving the vpll for the hdmi at all times is the right way to 
go. 

While I do agree that reserving the VPLL (and NPLL on the rk3288) for graphics 
use looks like the right way, I think the core Rockchip drm driver should be 
responsible for managing it and also for deciding which output encoder gets to 
use it.

While true that on the Chromebook device-types the edp is static and hdmi 
needs the broad range of dynamic frequencies, this is not necessarily the case 
for all future device types and/or socs.

In the other thread we discussed adding that as rockchip,dclk-pll = <&...>; to 
the base display-subsystem node, Doug didn't manage to find time to respond yet 
though - and is on vacation right now.

I still believe that would be the best solution :-) .


That property could list 1 or even 2 plls, depending on the soc or board 
layout - maybe someone frees up the cpll in some special layout or something.
If none are listed, then the drm driver would need to cope with its available 
clocks.

Implementation-wise you could even still keep your shortcut until we encounter 
a device with different , let the drm use the pll for hdmi only until someone 
comes up with a better concept, but still the binding should be correct and 
versatile from the start.


Heiko

> ---
>  .../bindings/display/rockchip/dw_hdmi-rockchip.txt |  3 ++-
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        | 25
> +++++++++++++++++++++- 2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> index 4e573d2..4e23ca4 100644
> ---
> a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> +++
> b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> @@ -17,7 +17,8 @@ Required properties:
> 
>  Optional properties
>  - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
> -- clocks, clock-names: phandle to the HDMI CEC clock, name should be "cec"
> +- clocks, clock-names: phandle to the HDMI CEC clock, name should be "cec",
> +		       phandle to the VPLL clock, name should be "vpll".
> 
>  Example:
>  hdmi: hdmi at ff980000 {
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c index 329099b..701bb73 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -7,10 +7,12 @@
>   * (at your option) any later version.
>   */
> 
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> -#include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> +
>  #include <drm/drm_of.h>
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -33,6 +35,7 @@ struct rockchip_hdmi {
>  	struct regmap *regmap;
>  	struct drm_encoder encoder;
>  	enum dw_hdmi_devtype dev_type;
> +	struct clk *vpll_clk;
>  };
> 
>  #define to_rockchip_hdmi(x)	container_of(x, struct rockchip_hdmi, x)
> @@ -145,6 +148,7 @@ static const struct dw_hdmi_phy_config
> rockchip_phy_config[] = { static int rockchip_hdmi_parse_dt(struct
> rockchip_hdmi *hdmi)
>  {
>  	struct device_node *np = hdmi->dev->of_node;
> +	int ret;
> 
>  	hdmi->regmap = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
>  	if (IS_ERR(hdmi->regmap)) {
> @@ -152,6 +156,22 @@ static int rockchip_hdmi_parse_dt(struct rockchip_hdmi
> *hdmi) return PTR_ERR(hdmi->regmap);
>  	}
> 
> +	hdmi->vpll_clk = devm_clk_get(hdmi->dev, "vpll");
> +	if (PTR_ERR(hdmi->vpll_clk) == -ENOENT) {
> +		hdmi->vpll_clk = NULL;
> +	} else if (PTR_ERR(hdmi->vpll_clk) == -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(hdmi->vpll_clk)) {
> +		dev_err(hdmi->dev, "failed to get grf clock\n");
> +		return PTR_ERR(hdmi->vpll_clk);
> +	}
> +
> +	ret = clk_prepare_enable(hdmi->vpll_clk);
> +	if (ret) {
> +		dev_err(hdmi->dev, "Failed to enable HDMI vpll: %d\n", ret);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
> 
> @@ -194,6 +214,9 @@ static void dw_hdmi_rockchip_encoder_mode_set(struct
> drm_encoder *encoder, struct drm_display_mode *mode,
>  					      struct drm_display_mode *adj_mode)
>  {
> +	struct rockchip_hdmi *hdmi = to_rockchip_hdmi(encoder);
> +
> +	clk_set_rate(hdmi->vpll_clk, adj_mode->clock * 1000);
>  }
> 
>  static void dw_hdmi_rockchip_encoder_enable(struct drm_encoder *encoder)
