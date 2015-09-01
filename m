From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 01 Sep 2015 23:00:09 +0200
Subject: [PATCH v4 08/16] drm: rockchip/dp: add rockchip platform dp driver
In-Reply-To: <1441087288-25404-1-git-send-email-ykk@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441087288-25404-1-git-send-email-ykk@rock-chips.com>
Message-ID: <4774646.g5GnBEuWb9@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

Am Dienstag, 1. September 2015, 14:01:28 schrieb Yakir Yang:
> Rockchip have three clocks for dp controller, we leave pclk_edp
> to analogix_dp driver control, and keep the sclk_edp_24m and
> sclk_edp in platform driver.
> 
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
> Changes in v4:
> - Remove some deprecated DT properties in rockchip dp document.
> 
> Changes in v3:
> - Take Thierry Reding and Heiko suggest, leave "sclk_edp_24m" to rockchip
>   dp phy driver which name to "24m", and leave "sclk_edp" to analogix dp
>   core driver which name to "dp", and leave "pclk_edp" to rockchip dp
> platform driver which name to "pclk".
> - Take Heiko suggest, add devicetree binding document.
> - Take Heiko suggest, remove "rockchip,panel" DT property, take use of
> remote point to get panel node.
> - Add the new function point analogix_dp_platdata.get_modes init.
> 
> Changes in v2:
> - Take Heiko suggest, get panel node with remote-endpoint method,
>   and create devicetree binding for driver.
> - Remove the clock enable/disbale with "sclk_edp" & "sclk_edp_24m",
>   leave those clock to rockchip dp phy driver.
> 
>  .../bindings/video/analogix_dp-rockchip.txt        |  74 ++++
>  drivers/gpu/drm/rockchip/Kconfig                   |   9 +
>  drivers/gpu/drm/rockchip/Makefile                  |   1 +
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 389
> +++++++++++++++++++++ 4 files changed, 473 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt create
> mode 100644 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> 
> diff --git
> a/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
> b/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt new file
> mode 100644
> index 0000000..502483e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/analogix_dp-rockchip.txt
> @@ -0,0 +1,74 @@
> +Rockchip RK3288 specific extensions to the Analogix Display Port
> +================================
> +
> +Required properties:
> +- compatible: "rockchip,rk3288-edp";
> +
> +- reg: physical base address of the controller and length
> +
> +- clocks: from common clock binding: handle to dp clock.
> +	  of memory mapped region.
> +
> +- clock-names: from common clock binding:
> +	       Required elements: "dp" "pclk"
> +
> +- resets: Must contain an entry for each entry in reset-names.
> +	  See ../reset/reset.txt for details.
> +
> +- reset-names: Must include the name "dp"
> +
> +- rockchip,grf: this soc should set GRF regs, so need get grf here.
> +
> +- ports: contain a port node with endpoint definitions as defined in
> +  Documentation/devicetree/bindings/media/video-interfaces.txt.
> +
> +
> +For the below properties, please refer to Analogix DP binding document:
> + * Documentation/devicetree/bindings/drm/bridge/analogix_dp.txt
> +- phys (required)
> +- phy-names (required)
> +- hpd-gpios (optional)
> +---------------------------------------------------------------------------
> ---- +
> +Example:
> +	dp-controller: dp at ff970000 {
> +		compatible = "rockchip,rk3288-dp";
> +		reg = <0xff970000 0x4000>;
> +		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_EDP>, <&cru PCLK_EDP_CTRL>;
> +		clock-names = "dp", "pclk";
> +		phys = <&dp_phy>;
> +		phy-names = "dp";
> +
> +		rockchip,grf = <&grf>;
> +		resets = <&cru 111>;
> +		reset-names = "dp";
> +
> +		status = "disabled";
> +
> +		ports {

#address-cells = <1>;
#size-cells = <0>;

> +			edp_in: port {

edp_in: port at 0
	reg = <0>;

> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				edp_in_vopb: endpoint at 0 {
> +					reg = <0>;
> +					remote-endpoint = <&vopb_out_edp>;
> +				};
> +				edp_in_vopl: endpoint at 1 {
> +					reg = <1>;
> +					remote-endpoint = <&vopl_out_edp>;
> +				};
> +			};
> +
> +			edp_out: port at 1 {
> +				reg = <1>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				edp_out_panel: endpoint {
> +					reg = <0>;
> +					remote-endpoint = <&panel_in_edp>
> +				};
> +			};
> +		};
> +	};
> +
> diff --git a/drivers/gpu/drm/rockchip/Kconfig
> b/drivers/gpu/drm/rockchip/Kconfig index 35215f6..c2ba945 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -25,3 +25,12 @@ config ROCKCHIP_DW_HDMI
>  	  for the Synopsys DesignWare HDMI driver. If you want to
>  	  enable HDMI on RK3288 based SoC, you should selet this
>  	  option.
> +
> +config ROCKCHIP_ANALOGIX_DP
> +        tristate "Rockchip specific extensions for Analogix DP driver"
> +        depends on DRM_ROCKCHIP
> +        select DRM_ANALOGIX_DP
> +        help
> +	  This selects support for Rockchip SoC specific extensions
> +	  for the Analogix Core DP driver. If you want to enable DP
> +	  on RK3288 based SoC, you should selet this option.
> diff --git a/drivers/gpu/drm/rockchip/Makefile
> b/drivers/gpu/drm/rockchip/Makefile index f3d8a19..8ad01fb 100644
> --- a/drivers/gpu/drm/rockchip/Makefile
> +++ b/drivers/gpu/drm/rockchip/Makefile
> @@ -6,5 +6,6 @@ rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o
> rockchip_drm_fbdev.o \ rockchip_drm_gem.o
> 
>  obj-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
> +obj-$(CONFIG_ROCKCHIP_ANALOGIX_DP) += analogix_dp-rockchip.o
> 
>  obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o rockchip_drm_vop.o
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c new file mode 100644
> index 0000000..cebff9e
> --- /dev/null
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -0,0 +1,389 @@
> +/*
> + * Rockchip SoC DP (Display Port) interface driver.
> + *
> + * Copyright (C) Fuzhou Rockchip Electronics Co., Ltd.
> + * Author: Andy Yan <andy.yan@rock-chips.com>
> + *         Yakir Yang <ykk@rock-chips.com>
> + *         Jeff Chen <jeff.chen@rock-chips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +#include <drm/drmP.h>
> +#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_panel.h>
> +#include <drm/drm_of.h>
> +#include <drm/drm_dp_helper.h>
> +
> +#include <linux/component.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_graph.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/clk.h>
> +
> +#include <video/of_videomode.h>
> +#include <video/videomode.h>
> +
> +#include <drm/bridge/analogix_dp.h>
> +
> +#include "rockchip_drm_drv.h"
> +#include "rockchip_drm_vop.h"
> +
> +#define encoder_to_dp(c) \
> +		container_of(c, struct rockchip_dp_device, encoder)
> +
> +#define plat_data_to_dp(pd) \
> +		container_of(pd, struct rockchip_dp_device, plat_data)
> +
> +/* dp grf register offset */
> +#define GRF_GPIO7B_IOMUX                        0x0070
> +#define GPIO7B3_SEL_MASK                        (0x03 << 6)
> +#define GPIO7B3_SEL_EDP_HOTPLUG                 BIT(7)

please remove, see comment near pre_init


> +
> +#define GRF_SOC_CON6                            0x025c
> +#define GRF_EDP_LCD_SEL_MASK                    BIT(5)
> +#define GRF_EDP_SEL_VOP_LIT                     BIT(5)
> +#define GRF_EDP_SEL_VOP_BIG                     0
> +
> +struct rockchip_dp_device {
> +	struct drm_device        *drm_dev;
> +	struct device            *dev;
> +	struct drm_encoder       encoder;
> +	struct drm_display_mode  mode;
> +
> +	struct clk               *pclk;
> +	struct regmap            *grf;
> +	struct reset_control     *rst;
> +
> +	struct analogix_dp_plat_data plat_data;
> +};
> +
> +static int rockchip_dp_pre_init(struct rockchip_dp_device *dp)
> +{
> +	u32 val;
> +	int ret;
> +
> +	val = GPIO7B3_SEL_EDP_HOTPLUG | (GPIO7B3_SEL_MASK << 16);
> +	ret = regmap_write(dp->grf, GRF_GPIO7B_IOMUX, val);

this is just a regular pinctrl setting. Please don't write onto other 
components registers. Use a regular pinctrl setting in the devicetree instead.


> +	if (ret != 0) {
> +		dev_err(dp->dev, "Could not config GRF edp hpd: %d\n", ret);
> +		return ret;
> +	}
> +
> +	reset_control_assert(dp->rst);
> +	usleep_range(10, 20);
> +	reset_control_deassert(dp->rst);
> +
> +	return 0;
> +}


Heiko
