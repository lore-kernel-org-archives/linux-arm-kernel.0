From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 01 Jun 2017 22:18:02 +0200
Subject: [PATCH 4/4] phy: rockchip-inno-usb2: add support of usb2-phy for
 rk322x SoCs
In-Reply-To: <1495078982-2555-5-git-send-email-frank.wang@rock-chips.com>
References: <1495078982-2555-1-git-send-email-frank.wang@rock-chips.com>
 <1495078982-2555-5-git-send-email-frank.wang@rock-chips.com>
Message-ID: <2655472.BTSNDfobEl@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

Am Donnerstag, 18. Mai 2017, 11:43:02 CEST schrieb Frank Wang:
> This adds support usb2-phy for rk322x SoCs and amend phy Documentation.
> 
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>

this adds a devicetree binding, so you should include devicetree people in
the recipient list:

Rob Herring <robh+dt@kernel.org>
Mark Rutland <mark.rutland@arm.com>
devicetree at vger.kernel.org

as they should Ack such binding additions.


> ---
>  .../bindings/phy/phy-rockchip-inno-usb2.txt        |  1 +
>  drivers/phy/phy-rockchip-inno-usb2.c               | 60 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> index e71a8d2..b4ce12e 100644
> --- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
> @@ -2,6 +2,7 @@ ROCKCHIP USB2.0 PHY WITH INNO IP BLOCK
>  
>  Required properties (phy (parent) node):
>   - compatible : should be one of the listed compatibles:
> +	* "rockchip,rk322x-usb2phy"

devicetree compatibles should not contain wildcards, so please name that
"rockchip,rk3228-usb2phy"

here and in the driver as well.


Heiko


>  	* "rockchip,rk3328-usb2phy"
>  	* "rockchip,rk3366-usb2phy"
>  	* "rockchip,rk3399-usb2phy"
> diff --git a/drivers/phy/phy-rockchip-inno-usb2.c b/drivers/phy/phy-rockchip-inno-usb2.c
> index d026b4cf..b9d4e23 100644
> --- a/drivers/phy/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/phy-rockchip-inno-usb2.c
> @@ -1144,6 +1144,65 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static const struct rockchip_usb2phy_cfg rk322x_phy_cfgs[] = {
> +	{
> +		.reg = 0x760,
> +		.num_ports	= 2,
> +		.clkout_ctl	= { 0x0768, 4, 4, 1, 0 },
> +		.port_cfgs	= {
> +			[USB2PHY_PORT_OTG] = {
> +				.phy_sus	= { 0x0760, 15, 0, 0, 0x1d1 },
> +				.bvalid_det_en	= { 0x0680, 3, 3, 0, 1 },
> +				.bvalid_det_st	= { 0x0690, 3, 3, 0, 1 },
> +				.bvalid_det_clr	= { 0x06a0, 3, 3, 0, 1 },
> +				.ls_det_en	= { 0x0680, 2, 2, 0, 1 },
> +				.ls_det_st	= { 0x0690, 2, 2, 0, 1 },
> +				.ls_det_clr	= { 0x06a0, 2, 2, 0, 1 },
> +				.utmi_bvalid	= { 0x0480, 4, 4, 0, 1 },
> +				.utmi_ls	= { 0x0480, 3, 2, 0, 1 },
> +			},
> +			[USB2PHY_PORT_HOST] = {
> +				.phy_sus	= { 0x0764, 15, 0, 0, 0x1d1 },
> +				.ls_det_en	= { 0x0680, 4, 4, 0, 1 },
> +				.ls_det_st	= { 0x0690, 4, 4, 0, 1 },
> +				.ls_det_clr	= { 0x06a0, 4, 4, 0, 1 }
> +			}
> +		},
> +		.chg_det = {
> +			.opmode		= { 0x0760, 3, 0, 5, 1 },
> +			.cp_det		= { 0x0884, 4, 4, 0, 1 },
> +			.dcp_det	= { 0x0884, 3, 3, 0, 1 },
> +			.dp_det		= { 0x0884, 5, 5, 0, 1 },
> +			.idm_sink_en	= { 0x0768, 8, 8, 0, 1 },
> +			.idp_sink_en	= { 0x0768, 7, 7, 0, 1 },
> +			.idp_src_en	= { 0x0768, 9, 9, 0, 1 },
> +			.rdm_pdwn_en	= { 0x0768, 10, 10, 0, 1 },
> +			.vdm_src_en	= { 0x0768, 12, 12, 0, 1 },
> +			.vdp_src_en	= { 0x0768, 11, 11, 0, 1 },
> +		},
> +	},
> +	{
> +		.reg = 0x800,
> +		.num_ports	= 2,
> +		.clkout_ctl	= { 0x0808, 4, 4, 1, 0 },
> +		.port_cfgs	= {
> +			[USB2PHY_PORT_OTG] = {
> +				.phy_sus	= { 0x800, 15, 0, 0, 0x1d1 },
> +				.ls_det_en	= { 0x0684, 0, 0, 0, 1 },
> +				.ls_det_st	= { 0x0694, 0, 0, 0, 1 },
> +				.ls_det_clr	= { 0x06a4, 0, 0, 0, 1 }
> +			},
> +			[USB2PHY_PORT_HOST] = {
> +				.phy_sus	= { 0x804, 15, 0, 0, 0x1d1 },
> +				.ls_det_en	= { 0x0684, 1, 1, 0, 1 },
> +				.ls_det_st	= { 0x0694, 1, 1, 0, 1 },
> +				.ls_det_clr	= { 0x06a4, 1, 1, 0, 1 }
> +			}
> +		},
> +	},
> +	{ /* sentinel */ }
> +};
> +
>  static const struct rockchip_usb2phy_cfg rk3328_phy_cfgs[] = {
>  	{
>  		.reg = 0x100,
> @@ -1269,6 +1328,7 @@ static const struct rockchip_usb2phy_cfg rk3399_phy_cfgs[] = {
>  };
>  
>  static const struct of_device_id rockchip_usb2phy_dt_match[] = {
> +	{ .compatible = "rockchip,rk322x-usb2phy", .data = &rk322x_phy_cfgs },
>  	{ .compatible = "rockchip,rk3328-usb2phy", .data = &rk3328_phy_cfgs },
>  	{ .compatible = "rockchip,rk3366-usb2phy", .data = &rk3366_phy_cfgs },
>  	{ .compatible = "rockchip,rk3399-usb2phy", .data = &rk3399_phy_cfgs },
> 
