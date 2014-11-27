From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 28 Nov 2014 10:36:17 +1100
Subject: linux-next: manual merge of the sunxi tree with the arm-soc tree
Message-ID: <20141128103617.13a1821c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Today's linux-next merge of the sunxi tree got a conflict in
arch/arm/boot/dts/sun6i-a31.dtsi between commit 3fd0c05da46c ("Revert
"ARM: dts: sunxi: Use sun4i-a10-apb1-clk for sun6i/sun8i apb2
clocks."") from the arm-soc tree and commit 74c947ab33c9 ("ARM: dts:
sunxi: Use sun4i-a10-apb1-clk for sun6i/sun8i apb2 clocks") from the
sunxi tree.

I fixed it up (I just used the arm-soc version for now) and can carry
the fix as necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/sun6i-a31.dtsi
index 529c73803976,f47156b6572b..000000000000
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@@ -217,19 -229,11 +229,19 @@@
  					"apb1_daudio1";
  		};
  
 -		apb2: clk at 01c20058 {
 +		apb2_mux: apb2_mux at 01c20058 {
 +			#clock-cells = <0>;
 +			compatible = "allwinner,sun4i-a10-apb1-mux-clk";
 +			reg = <0x01c20058 0x4>;
 +			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
 +			clock-output-names = "apb2_mux";
 +		};
 +
 +		apb2: apb2 at 01c20058 {
  			#clock-cells = <0>;
- 			compatible = "allwinner,sun6i-a31-apb2-div-clk";
+ 			compatible = "allwinner,sun4i-a10-apb1-clk";
  			reg = <0x01c20058 0x4>;
- 			clocks = <&apb2_mux>;
+ 			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
  			clock-output-names = "apb2";
  		};
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/5803187a/attachment.sig>
