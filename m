From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 27 Sep 2018 19:16:27 +0200
Subject: [PATCH 11/12] arm64: dts: allwinner: a64: Add DSI pipeline
In-Reply-To: <20180927114850.24565-12-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
 <20180927114850.24565-12-jagan@amarulasolutions.com>
Message-ID: <20180927171627.7svkvflamxrmjgve@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2018 at 05:18:49PM +0530, Jagan Teki wrote:
> The A64 has a MIPI-DSI block which is similar to A31
> without mod clock.
> 
> So, add dsi node with A64 compatible, dphy node with
> A31 compatible and finally connect dsi to tcon0 to
> make proper DSI pipeline.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index f3a66f888205..308eedc53150 100644
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
> +					};
>  				};
>  			};
>  		};
> @@ -818,6 +823,45 @@
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
> +			compatible = "allwinner,sun6i-a31-mipi-dphy";

You should add an A64 compatible there.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
