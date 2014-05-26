From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 26 May 2014 15:43:31 +1000
Subject: linux-next: manual merge of the clockevents tree with the arm-soc tree
Message-ID: <20140526154331.7fc6b30c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Today's linux-next merge of the clockevents tree got a conflict in
arch/arm/boot/dts/vf610.dtsi between commit 0517fe6aa880 ("ARM: dts:
vf610-twr: Add support for sdhc1") from the arm-soc tree and commit
07513e1330a9 ("ARM: dts: vf610: Add Freescale FlexTimer Module timer
node") from the clockevents tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/vf610.dtsi
index 73355ddc5186,3c91b84066a1..000000000000
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@@ -360,17 -347,19 +360,30 @@@
  				status = "disabled";
  			};
  
 +			esdhc1: esdhc at 400b2000 {
 +				compatible = "fsl,imx53-esdhc";
 +				reg = <0x400b2000 0x4000>;
 +				interrupts = <0 28 0x04>;
 +				clocks = <&clks VF610_CLK_IPG_BUS>,
 +					<&clks VF610_CLK_PLATFORM_BUS>,
 +					<&clks VF610_CLK_ESDHC1>;
 +				clock-names = "ipg", "ahb", "per";
 +				status = "disabled";
 +			};
 +
+ 			ftm: ftm at 400b8000 {
+ 				compatible = "fsl,ftm-timer";
+ 				reg = <0x400b8000 0x1000 0x400b9000 0x1000>;
+ 				interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>;
+ 				clock-names = "ftm-evt", "ftm-src",
+ 					"ftm-evt-counter-en", "ftm-src-counter-en";
+ 				clocks = <&clks VF610_CLK_FTM2>,
+ 					<&clks VF610_CLK_FTM3>,
+ 					<&clks VF610_CLK_FTM2_EXT_FIX_EN>,
+ 					<&clks VF610_CLK_FTM3_EXT_FIX_EN>;
+ 				status = "disabled";
+ 			};
+ 
  			fec0: ethernet at 400d0000 {
  				compatible = "fsl,mvf600-fec";
  				reg = <0x400d0000 0x1000>;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140526/e2592070/attachment.sig>
