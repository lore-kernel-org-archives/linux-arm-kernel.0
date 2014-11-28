From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Nov 2014 09:37:06 +0100
Subject: linux-next: manual merge of the sunxi tree with the arm-soc tree
In-Reply-To: <20141128103617.13a1821c@canb.auug.org.au>
References: <20141128103617.13a1821c@canb.auug.org.au>
Message-ID: <20141128083706.GT25249@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 28, 2014 at 10:36:17AM +1100, Stephen Rothwell wrote:
> Hi Maxime,
> 
> Today's linux-next merge of the sunxi tree got a conflict in
> arch/arm/boot/dts/sun6i-a31.dtsi between commit 3fd0c05da46c ("Revert
> "ARM: dts: sunxi: Use sun4i-a10-apb1-clk for sun6i/sun8i apb2
> clocks."") from the arm-soc tree and commit 74c947ab33c9 ("ARM: dts:
> sunxi: Use sun4i-a10-apb1-clk for sun6i/sun8i apb2 clocks") from the
> sunxi tree.
> 
> I fixed it up (I just used the arm-soc version for now) and can carry
> the fix as necessary (no action is required).
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au
> 
> diff --cc arch/arm/boot/dts/sun6i-a31.dtsi
> index 529c73803976,f47156b6572b..000000000000
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@@ -217,19 -229,11 +229,19 @@@
>   					"apb1_daudio1";
>   		};
>   
>  -		apb2: clk at 01c20058 {
>  +		apb2_mux: apb2_mux at 01c20058 {
>  +			#clock-cells = <0>;
>  +			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
>  +			reg = <0x01c20058 0x4>;
>  +			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
>  +			clock-output-names = "apb2_mux";
>  +		};
>  +
>  +		apb2: apb2 at 01c20058 {
>   			#clock-cells = <0>;
> - 			compatible = "allwinner,sun6i-a31-apb2-div-clk";
> + 			compatible = "allwinner,sun4i-a10-apb1-clk";
>   			reg = <0x01c20058 0x4>;
> - 			clocks = <&apb2_mux>;
> + 			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
>   			clock-output-names = "apb2";
>   		};
>   

I'm not exactly sure why there is still conflicts between my branches
and arm-soc, since the previous branch that generates these conflicts
was supposed to be dropped, but the correct fix is:

		apb2: clk at 01c20058 {
			#clock-cells = <0>;
			compatible = "allwinner,sun4i-a10-apb1-clk";
			reg = <0x01c20058 0x4>;
			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
			clock-output-names = "apb2";
		};

with the apb2_mux node dropped entirely.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/63f17231/attachment-0001.sig>
