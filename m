From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 24 Oct 2018 19:10:48 +0100
Subject: [PATCH v2 14/15] arm64: dts: allwinner: a64: Add DSI pipeline
In-Reply-To: <20181023155035.9101-15-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-15-jagan@amarulasolutions.com>
Message-ID: <20181024181048.w4iwebtac6wzmgt4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 09:20:34PM +0530, Jagan Teki wrote:
> The A64 has a MIPI-DSI block which is similar to A31
> without mod clock.
> 
> So, add dsi node with A64 compatible, dphy node with
> A31 compatible and finally connect dsi to tcon0 to
> make proper DSI pipeline.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - use A64 dphy compatible
> 
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index f3a66f888205..f82e6b165d57 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -320,6 +320,11 @@
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					reg = <1>;
> +
> +					tcon0_out_dsi: endpoint at 1 {
> +						reg = <1>;
> +						remote-endpoint = <&dsi_in_tcon0>;

You need to set the allwinner,channel property there.

> +					};
>  				};
>  			};
>  		};
> @@ -818,6 +823,46 @@
>  			#interrupt-cells = <3>;
>  		};
>  
> +
> +		dsi: dsi at 1ca0000 {
> +			compatible = "allwinner,sun50i-a64-mipi-dsi";
> +			reg = <0x01ca0000 0x1000>;
> +			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_MIPI_DSI>;
> +			clock-names = "bus";
> +			resets = <&ccu RST_BUS_MIPI_DSI>;
> +			phys = <&dphy>;
> +			phy-names = "dphy";
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port at 0 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <0>;
> +
> +					dsi_in_tcon0: endpoint {
> +						remote-endpoint = <&tcon0_out_dsi>;
> +					};
> +				};
> +			};
> +		};
> +
> +		dphy: d-phy at 1ca1000 {
> +			compatible = "allwinner,sun50i-a64-mipi-dphy",
> +				     "allwinner,sun6i-a31-mipi-dphy";
> +			reg = <0x01ca1000 0x1000>;
> +			clocks = <&ccu CLK_BUS_MIPI_DSI>,
> +				 <&ccu CLK_DSI_DPHY>;
> +			clock-names = "bus", "mod";
> +			resets = <&ccu RST_BUS_MIPI_DSI>;
> +			status = "disabled";
> +			#phy-cells = <0>;
> +		};
> +

You have to order the nodes per ascending physical address ordering.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181024/58f9651b/attachment.sig>
