From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 25 Feb 2014 17:09:53 +1100
Subject: linux-next: manual merge of the staging tree with the arm-soc tree
Message-ID: <20140225170953.673cf5073d5682a54c1a1771@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Today's linux-next merge of the staging tree got a conflict in
arch/arm/boot/dts/imx53-mba53.dts between commit a4a2aa9b038c ("ARM: dts:
imx53-mba53: create a container for fixed regulators") from the arm-soc
tree and commit 17b5001b5143 ("imx-drm: convert to componentised device
support") from the staging tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/imx53-mba53.dts
index 55af11037a00,9b6e76980a74..000000000000
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@@ -35,27 -43,18 +35,33 @@@
  		status = "disabled";
  	};
  
+ 	imx-drm {
+ 		compatible = "fsl,imx-drm";
+ 		crtcs = <&ipu 1>;
+ 		connectors = <&disp1>, <&tve>;
+ 	};
+ 
 -	reg_3p2v: 3p2v {
 -		compatible = "regulator-fixed";
 -		regulator-name = "3P2V";
 -		regulator-min-microvolt = <3200000>;
 -		regulator-max-microvolt = <3200000>;
 -		regulator-always-on;
 +	regulators {
 +		compatible = "simple-bus";
 +		#address-cells = <1>;
 +		#size-cells = <0>;
 +
 +		reg_backlight: regulator at 0 {
 +			compatible = "regulator-fixed";
 +			reg = <0>;
 +			regulator-name = "lcd-supply";
 +			gpio = <&gpio2 5 0>;
 +			startup-delay-us = <5000>;
 +		};
 +
 +		reg_3p2v: regulator at 1 {
 +			compatible = "regulator-fixed";
 +			reg = <1>;
 +			regulator-name = "3P2V";
 +			regulator-min-microvolt = <3200000>;
 +			regulator-max-microvolt = <3200000>;
 +			regulator-always-on;
 +		};
  	};
  
  	sound {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140225/7a9ed161/attachment-0001.sig>
