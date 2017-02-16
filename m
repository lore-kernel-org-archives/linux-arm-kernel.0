From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 15 Feb 2017 18:19:11 -0800
Subject: [PATCH v4 09/36] ARM: dts: imx6-sabreauto: add reset-gpios property
 for max7310_b
In-Reply-To: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1487211578-11360-10-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The reset pin to the port expander chip (MAX7310) is controlled by a gpio,
so define a reset-gpios property to control it. There are three MAX7310's
on the SabreAuto CPU card (max7310_[abc]), but all use the same pin for
their reset. Since all can't acquire the same pin, assign it to max7310_b,
that chip is needed by more functions (usb and adv7180).

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index cace88c..967c3b8 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -136,6 +136,9 @@
 				reg = <0x32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_max7310>;
+				reset-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 			};
 
 			max7310_c: gpio at 34 {
@@ -442,6 +445,12 @@
 			>;
 		};
 
+		pinctrl_max7310: max7310grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_DAT0__GPIO1_IO15 0x1b0b0
+			>;
+		};
+
 		pinctrl_pwm3: pwm1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
-- 
2.7.4
