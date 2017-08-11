From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 11 Aug 2017 17:38:31 +0200
Subject: [PATCH 1/3] dt-bindings: display: Add Document for Rockchip Soc
 LVDS
In-Reply-To: <1502272851-63997-1-git-send-email-hjc@rock-chips.com>
References: <1502272846-63941-1-git-send-email-hjc@rock-chips.com>
 <1502272851-63997-1-git-send-email-hjc@rock-chips.com>
Message-ID: <1502465911.2310.18.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-08-09 at 18:00 +0800, Sandy Huang wrote:
> This patch add Document for Rockchip Soc RK3288 LVDS,
> This based on the patches from Mark yao and Heiko Stuebner.
> 
> > Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> > Signed-off-by: Mark yao <mark.yao@rock-chips.com>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> ?.../bindings/display/rockchip/rockchip-lvds.txt????| 104 +++++++++++++++++++++
> ?1 file changed, 104 insertions(+)
> ?create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
> new file mode 100644
> index 0000000..bf934ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
> @@ -0,0 +1,104 @@
> +Rockchip RK3288 LVDS interface
> +================================
> +
> +Required properties:
> +- compatible: matching the soc type, one of
> > +	- "rockchip,rk3288-lvds";
> +
> +- reg: physical base address of the controller and length
> > +	of memory mapped region.
> +- clocks: must include clock specifiers corresponding to entries in the
> > +	clock-names property.
> +- clock-names: must contain "pclk_lvds"
> +
> +- avdd1v0-supply: regulator phandle for 1.0V analog power
> +- avdd1v8-supply: regulator phandle for 1.8V analog power
> +- avdd3v3-supply: regulator phandle for 3.3V analog power
> +
> +- rockchip,grf: phandle to the general register files syscon
> +
> +Optional properties
> +- pinctrl-names: must contain a "lcdc" entry.
> +- pinctrl-0: pin control group to be used for this controller.
> +
> +Required nodes:
> +
> +The lvds has two video ports as described by
> > +	Documentation/devicetree/bindings/media/video-interfaces.txt.
> +Their connections are modeled using the OF graph bindings specified in
> > +	Documentation/devicetree/bindings/graph.txt.
> +
> +- video port 0 for the VOP inputs
> +- video port 1 for either a panel or subsequent encoder
> +
> +the lvds panel described by
> > +	Documentation/devicetree/bindings/display/panel/simple-panel.txt
> +
> +- rockchip,data-mapping: should be "vesa" or "jeida",
> > +	This describes how the color bits are laid out in the
> > +	serialized LVDS signal.
> +- rockchip,data-width : should be <18> or <24>;

This can already be described by the panel itself, via the bus_format
property in the panel_desc for panel-simple, or via the existing panel
device tree property "data-mapping" in panel-lvds, which can be set to
"jeida-18", "jeida-24", or "vesa-24".

The LVDS driver can then read the panel bus information from the
panel's connector->display_info.bus_formats.

So if these properties are necessary at all, they at least should be
optional (overrides).

regards
Philipp
