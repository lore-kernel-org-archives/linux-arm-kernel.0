From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 06 Aug 2017 15:55:50 +0200
Subject: [PATCH v2 4/5] arm64: dts: rockchip: add rk3399 mipi nodes
In-Reply-To: <1500301019-9960-5-git-send-email-jacob-chen@iotwrt.com>
References: <1500301019-9960-1-git-send-email-jacob-chen@iotwrt.com>
 <1500301019-9960-5-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1762581.zRg8RSfhNk@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 17. Juli 2017, 22:16:58 CEST schrieb Jacob Chen:
> Add an mipi node, and also add mipi endpoints to vopb and vopl
> output port nodes.
> 
> Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 44 ++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index c0371af..5c5c9d9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1475,6 +1475,11 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> +			vopl_out_mipi: endpoint at 0 {
> +				reg = <0>;
> +				remote-endpoint = <&mipi_in_vopl>;
> +			};
> +
>  			vopl_out_edp: endpoint at 1 {
>  				reg = <1>;
>  				remote-endpoint = <&edp_in_vopl>;
> @@ -1516,6 +1521,11 @@
>  				remote-endpoint = <&edp_in_vopb>;
>  			};
>  
> +			vopb_out_mipi: endpoint at 1 {
> +				reg = <1>;
> +				remote-endpoint = <&mipi_in_vopb>;
> +			};
> +
>  		};
>  	};
>  
> @@ -1531,6 +1541,40 @@
>  		status = "disabled";
>  	};
>  
> +	mipi_dsi: mipi at ff960000 {
> +		compatible = "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi";
> +		reg = <0x0 0xff960000 0x0 0x8000>;
> +		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks = <&cru SCLK_MIPIDPHY_REF>, <&cru PCLK_MIPI_DSI0>,
> +			 <&cru SCLK_DPHY_TX0_CFG>;
> +		clock-names = "ref", "pclk", "phy_cfg";
> +		power-domains = <&power RK3399_PD_VIO>;
> +		rockchip,grf = <&grf>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;

I've dropped these, as the ports node does not need a regs property.
Similar to edp and hdmi.

> +		status = "disabled";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <1>;

dropped this reg as well - see above

and applied the rest for 4.14


Thanks
Heiko
