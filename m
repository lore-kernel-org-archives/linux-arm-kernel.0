From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Sun, 22 Jul 2018 07:59:01 +0200
Subject: [linux-sunxi] [PATCH 4/5] arm64: allwinner: h6: add EMAC device
 nodes
In-Reply-To: <20180722053955.25266-5-icenowy@aosc.io>
References: <20180722053955.25266-1-icenowy@aosc.io>
 <20180722053955.25266-5-icenowy@aosc.io>
Message-ID: <20180722055901.GA8055@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 22, 2018 at 01:39:54PM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC has an EMAC like the one in A64.
> 
> Add device tree nodes for the H6 DTSI file.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 30 ++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 3ab6cf0256ca..c65311de301a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -149,6 +149,14 @@
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
>  
> +			ext_rgmii_pins: rgmii_pins {
> +				pins = "PD0", "PD1", "PD2", "PD3", "PD4",
> +				       "PD5", "PD7", "PD8", "PD9", "PD10",
> +				       "PD11", "PD12", "PD13", "PD19", "PD20";
> +				function = "emac";
> +				drive-strength = <40>;
> +			};
> +
>  			mmc0_pins: mmc0-pins {
>  				pins = "PF0", "PF1", "PF2", "PF3",
>  				       "PF4", "PF5";
> @@ -258,6 +266,28 @@
>  			status = "disabled";
>  		};
>  
> +		emac: ethernet at 5020000 {
> +			compatible = "allwinner,sun50i-a64-emac",
> +				     "allwinner,sun50i-h6-emac";
> +			syscon = <&syscon>;
> +			reg = <0x05020000 0x10000>;
> +			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			resets = <&ccu RST_BUS_EMAC>;
> +			reset-names = "stmmaceth";
> +			clocks = <&ccu CLK_BUS_EMAC>;
> +			clock-names = "stmmaceth";
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;

#address-cells and #size-cells is unnecessary in emac node.

Regards
