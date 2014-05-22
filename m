From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 23 May 2014 01:08:04 +0200
Subject: [PATCH 1/2] ARM: shmobile: r8a7779 dtsi: Correct
 #address-cells/#size-cells for clocks
In-Reply-To: <1400761997-13512-2-git-send-email-geert+renesas@glider.be>
References: <1400761997-13512-1-git-send-email-geert+renesas@glider.be>
 <1400761997-13512-2-git-send-email-geert+renesas@glider.be>
Message-ID: <155646478.xj0lyDQ1cd@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Thursday 22 May 2014 14:33:16 Geert Uytterhoeven wrote:
> Warning (ranges_format): /clocks has empty "ranges" property but its
> #address-cells (2) differs from / (1) Warning (ranges_format): /clocks has
> empty "ranges" property but its #size-cells (2) differs from / (1)
> 
> As r8a7779 doesn't support LPAE, change #address-cells and #size-cells from
> "<2>" to "<1>" to fix this.
> 
> Also correct the unit-address for the cpg_clocks node, and add missing
> unit-addresses for the mstp*_clks nodes.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> ---
> Is it correct that r8a7779 doesn't support LPAE? I don't have the datasheet,
> but the similar r8a7778 doesn't.
> 
>  arch/arm/boot/dts/r8a7779.dtsi | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> index 038c16a18373..dc624e0d7506 100644
> --- a/arch/arm/boot/dts/r8a7779.dtsi
> +++ b/arch/arm/boot/dts/r8a7779.dtsi
> @@ -284,8 +284,8 @@
>  	};
> 
>  	clocks {
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;

This looks good to me.

>  		ranges;
> 
>  		/* External root clock */
> @@ -298,9 +298,9 @@
>  		};
> 
>  		/* Special CPG clocks */
> -		cpg_clocks: cpg_clocks at 0xe6150000 {
> +		cpg_clocks: cpg_clocks at 0xffc80000 {

No need for a 0x prefix.

>  			compatible = "renesas,r8a7779-cpg-clocks";
> -			reg = <0 0xffc80000 0 0x30>;
> +			reg = <0xffc80000 0x30>;

This looks good.

>  			clocks = <&extal_clk>;
>  			#clock-cells = <1>;
>  			clock-output-names = "plla", "z", "zs", "s",
> @@ -342,10 +342,10 @@
>  		};
> 
>  		/* Gate clocks */
> -		mstp0_clks: mstp0_clks {
> +		mstp0_clks: mstp0_clks at ffc80030 {

The @address is only mandatory to differentiate between nodes with identical 
names. As the node name is supposed to describe the device function, maybe we 
could rename it to clocks at ffc80030 ? As you modify the CPG node address above 
it might make sense to rename it to clocks at ffc80000 too.

I'm not advocating for a rename now, but as your patch touches the names, I 
think they should be fixed properly (or not at all).

>  			compatible = "renesas,r8a7779-mstp-clocks",
>  			             "renesas,cpg-mstp-clocks";
> -			reg = <0 0xffc80030 0 4>;
> +			reg = <0xffc80030 4>;
>  			clocks = <&cpg_clocks R8A7779_CLK_S>,
>  			         <&cpg_clocks R8A7779_CLK_P>,
>  				 <&cpg_clocks R8A7779_CLK_P>,
> @@ -379,10 +379,10 @@
>  				"scif1", "scif0", "i2c3", "i2c2", "i2c1",
>  				"i2c0";
>  		};
> -		mstp1_clks: mstp1_clks {
> +		mstp1_clks: mstp1_clks at ffc80034 {
>  			compatible = "renesas,r8a7779-mstp-clocks",
>  			             "renesas,cpg-mstp-clocks";
> -			reg = <0 0xffc80034 0 4>, <0 0xffc80044 0 4>;
> +			reg = <0xffc80034 4>, <0xffc80044 4>;
>  			clocks = <&cpg_clocks R8A7779_CLK_P>,
>  				 <&cpg_clocks R8A7779_CLK_P>,
>  				 <&cpg_clocks R8A7779_CLK_S>,
> @@ -408,10 +408,10 @@
>  				"ether", "sata",
>  				"pcie", "vin3";
>  		};
> -		mstp3_clks: mstp3_clks {
> +		mstp3_clks: mstp3_clks at ffc8003c {
>  			compatible = "renesas,r8a7779-mstp-clocks",
>  			             "renesas,cpg-mstp-clocks";
> -			reg = <0 0xffc8003c 0 4>;
> +			reg = <0xffc8003c 4>;
>  			clocks = <&s4_clk>, <&s4_clk>, <&s4_clk>, <&s4_clk>,
>  				 <&s4_clk>, <&s4_clk>;
>  			#clock-cells = <1>;

-- 
Regards,

Laurent Pinchart
