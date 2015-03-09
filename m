From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 9 Mar 2015 17:28:06 +0800
Subject: [PATCH 1/3] ARM: imx6qdl-sabreauto.dtsi: add max7310 support
In-Reply-To: <1425893288-1517-1-git-send-email-peter.chen@freescale.com>
References: <1425893288-1517-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1425893288-1517-2-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

max7310 is an i2c interface gpio expander

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 009abd6..51acfec 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -28,6 +28,13 @@
 		};
 	};
 
+	max7310_reset: max7310-reset {
+		compatible = "gpio-reset";
+		reset-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+		reset-delay-us = <1>;
+		#reset-cells = <0>;
+	};
+
 	sound-spdif {
 		compatible = "fsl,imx-audio-spdif",
 			   "fsl,imx-sabreauto-spdif";
@@ -182,6 +189,35 @@
 	};
 };
 
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-assert-gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	max7310_a: gpio at 30 {
+		compatible = "maxim,max7310";
+		reg = <0x30>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		resets = <&max7310_reset>;
+	};
+
+	max7310_b: gpio at 32 {
+		compatible = "maxim,max7310";
+		reg = <0x32>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	max7310_c: gpio at 34 {
+		compatible = "maxim,max7310";
+		reg = <0x34>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
@@ -265,6 +301,13 @@
 			>;
 		};
 
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_3__I2C3_SCL  0x4001b8b1
+				MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
+			>;
+		};
+
 		pinctrl_pwm3: pwm1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
-- 
1.9.1
