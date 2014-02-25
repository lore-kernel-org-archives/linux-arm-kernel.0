From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 25 Feb 2014 17:09:44 +1100
Subject: linux-next: manual merge of the staging tree with the arm-soc tree
Message-ID: <20140225170944.d322d9868871bc2f669b92e5@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Today's linux-next merge of the staging tree got a conflict in
arch/arm/boot/dts/imx53-qsb.dts between commit d5eb195f26fa ("ARM: dts:
i.MX53: move common QSB nodes to new file") from the arm-soc tree and
commit 17b5001b5143 ("imx-drm: convert to componentised device support")
from the staging tree.

I fixed it up (see at bottom) and can carry the fix as necessary (no
action is required).  I also added the following fix up patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 25 Feb 2014 17:07:01 +1100
Subject: [PATCH] ARM: dts: i.MX53: merge fix patch

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/boot/dts/imx53-qsb-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index 2dca98b79f48..5dd37c7c38b8 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -17,7 +17,7 @@
 		reg = <0x70000000 0x40000000>;
 	};
 
-	display at di0 {
+	display0: display at di0 {
 		compatible = "fsl,imx-parallel-display";
 		crtcs = <&ipu 0>;
 		interface-pix-fmt = "rgb565";
-- 
1.9.0

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/imx53-qsb.dts
index dec4b073ceb1,3cb4f7791a91..000000000000
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@@ -16,6 -16,182 +16,11 @@@
  / {
  	model = "Freescale i.MX53 Quick Start Board";
  	compatible = "fsl,imx53-qsb", "fsl,imx53";
 -
 -	memory {
 -		reg = <0x70000000 0x40000000>;
 -	};
 -
 -	display0: display at di0 {
 -		compatible = "fsl,imx-parallel-display";
 -		crtcs = <&ipu 0>;
 -		interface-pix-fmt = "rgb565";
 -		pinctrl-names = "default";
 -		pinctrl-0 = <&pinctrl_ipu_disp0_1>;
 -		status = "disabled";
 -		display-timings {
 -			claawvga {
 -				native-mode;
 -				clock-frequency = <27000000>;
 -				hactive = <800>;
 -				vactive = <480>;
 -				hback-porch = <40>;
 -				hfront-porch = <60>;
 -				vback-porch = <10>;
 -				vfront-porch = <10>;
 -				hsync-len = <20>;
 -				vsync-len = <10>;
 -				hsync-active = <0>;
 -				vsync-active = <0>;
 -				de-active = <1>;
 -				pixelclk-active = <0>;
 -			};
 -		};
 -	};
 -
 -	gpio-keys {
 -		compatible = "gpio-keys";
 -
 -		power {
 -			label = "Power Button";
 -			gpios = <&gpio1 8 0>;
 -			linux,code = <116>; /* KEY_POWER */
 -		};
 -
 -		volume-up {
 -			label = "Volume Up";
 -			gpios = <&gpio2 14 0>;
 -			linux,code = <115>; /* KEY_VOLUMEUP */
 -			gpio-key,wakeup;
 -		};
 -
 -		volume-down {
 -			label = "Volume Down";
 -			gpios = <&gpio2 15 0>;
 -			linux,code = <114>; /* KEY_VOLUMEDOWN */
 -			gpio-key,wakeup;
 -		};
 -	};
 -
+ 	imx-drm {
+ 		compatible = "fsl,imx-drm";
+ 		crtcs = <&ipu 0>;
+ 		connectors = <&display0>;
+ 	};
 -
 -	leds {
 -		compatible = "gpio-leds";
 -		pinctrl-names = "default";
 -		pinctrl-0 = <&led_pin_gpio7_7>;
 -
 -		user {
 -			label = "Heartbeat";
 -			gpios = <&gpio7 7 0>;
 -			linux,default-trigger = "heartbeat";
 -		};
 -	};
 -
 -	regulators {
 -		compatible = "simple-bus";
 -
 -		reg_3p2v: 3p2v {
 -			compatible = "regulator-fixed";
 -			regulator-name = "3P2V";
 -			regulator-min-microvolt = <3200000>;
 -			regulator-max-microvolt = <3200000>;
 -			regulator-always-on;
 -		};
 -
 -		reg_usb_vbus: usb_vbus {
 -			compatible = "regulator-fixed";
 -			regulator-name = "usb_vbus";
 -			regulator-min-microvolt = <5000000>;
 -			regulator-max-microvolt = <5000000>;
 -			gpio = <&gpio7 8 0>;
 -			enable-active-high;
 -		};
 -	};
 -
 -	sound {
 -		compatible = "fsl,imx53-qsb-sgtl5000",
 -			     "fsl,imx-audio-sgtl5000";
 -		model = "imx53-qsb-sgtl5000";
 -		ssi-controller = <&ssi2>;
 -		audio-codec = <&sgtl5000>;
 -		audio-routing =
 -			"MIC_IN", "Mic Jack",
 -			"Mic Jack", "Mic Bias",
 -			"Headphone Jack", "HP_OUT";
 -		mux-int-port = <2>;
 -		mux-ext-port = <5>;
 -	};
 -};
 -
 -&esdhc1 {
 -	pinctrl-names = "default";
 -	pinctrl-0 = <&pinctrl_esdhc1_1>;
 -	status = "okay";
 -};
 -
 -&ssi2 {
 -	fsl,mode = "i2s-slave";
 -	status = "okay";
 -};
 -
 -&esdhc3 {
 -	pinctrl-names = "default";
 -	pinctrl-0 = <&pinctrl_esdhc3_1>;
 -	cd-gpios = <&gpio3 11 0>;
 -	wp-gpios = <&gpio3 12 0>;
 -	bus-width = <8>;
 -	status = "okay";
 -};
 -
 -&iomuxc {
 -	pinctrl-names = "default";
 -	pinctrl-0 = <&pinctrl_hog>;
 -
 -	hog {
 -		pinctrl_hog: hoggrp {
 -			fsl,pins = <
 -				MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK 0x80000000
 -				MX53_PAD_GPIO_8__GPIO1_8          0x80000000
 -				MX53_PAD_PATA_DATA14__GPIO2_14    0x80000000
 -				MX53_PAD_PATA_DATA15__GPIO2_15    0x80000000
 -				MX53_PAD_EIM_DA11__GPIO3_11       0x80000000
 -				MX53_PAD_EIM_DA12__GPIO3_12       0x80000000
 -				MX53_PAD_PATA_DA_0__GPIO7_6       0x80000000
 -				MX53_PAD_PATA_DA_2__GPIO7_8	  0x80000000
 -				MX53_PAD_GPIO_16__GPIO7_11        0x80000000
 -			>;
 -		};
 -
 -		led_pin_gpio7_7: led_gpio7_7 at 0 {
 -			fsl,pins = <
 -				MX53_PAD_PATA_DA_1__GPIO7_7 0x80000000
 -			>;
 -		};
 -	};
 -
 -};
 -
 -&uart1 {
 -	pinctrl-names = "default";
 -	pinctrl-0 = <&pinctrl_uart1_1>;
 -	status = "okay";
 -};
 -
 -&i2c2 {
 -	pinctrl-names = "default";
 -	pinctrl-0 = <&pinctrl_i2c2_1>;
 -	status = "okay";
 -
 -	sgtl5000: codec at 0a {
 -		compatible = "fsl,sgtl5000";
 -		reg = <0x0a>;
 -		VDDA-supply = <&reg_3p2v>;
 -		VDDIO-supply = <&reg_3p2v>;
 -		clocks = <&clks 150>;
 -	};
  };
  
  &i2c1 {
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140225/d2987943/attachment-0001.sig>
