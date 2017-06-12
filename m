From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Mon, 12 Jun 2017 11:24:01 -0700
Subject: [PATCH 08/11] ARM: dts: imx6-sabreauto: create i2cmux for i2c3
In-Reply-To: <1497291844-14632-1-git-send-email-steve_longerbeam@mentor.com>
References: <1497291844-14632-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1497291844-14632-9-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sabreauto uses a steering pin to select between the SDA signal on
i2c3 bus, and a data-in pin for an SPI NOR chip. Use i2cmux to control
this steering pin. Idle state of the i2cmux selects SPI NOR. This is not
a classic way to use i2cmux, since one side of the mux selects something
other than an i2c bus, but it works and is probably the cleanest
solution. Note that if one thread is attempting to access SPI NOR while
another thread is accessing i2c3, the SPI NOR access will fail since the
i2cmux has selected the SDA pin rather than SPI NOR data-in. This couldn't
be avoided in any case, the board is not designed to allow concurrent
i2c3 and SPI NOR functions (and the default device-tree does not enable
SPI NOR anyway).

Devices hanging off i2c3 should now be defined under i2cmux, so
that the steering pin can be properly controlled to access those
devices. The port expanders (MAX7310) are thus moved into i2cmux.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 65 +++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index a2a714d..c8e35c4 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -108,6 +108,44 @@
 		default-brightness-level = <7>;
 		status = "okay";
 	};
+
+	i2cmux {
+		compatible = "i2c-mux-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c3mux>;
+		mux-gpios = <&gpio5 4 0>;
+		i2c-parent = <&i2c3>;
+		idle-state = <0>;
+
+		i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			max7310_a: gpio at 30 {
+				compatible = "maxim,max7310";
+				reg = <0x30>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			max7310_b: gpio at 32 {
+				compatible = "maxim,max7310";
+				reg = <0x32>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			max7310_c: gpio at 34 {
+				compatible = "maxim,max7310";
+				reg = <0x34>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+	};
 };
 
 &clks {
@@ -290,27 +328,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
-
-	max7310_a: gpio at 30 {
-		compatible = "maxim,max7310";
-		reg = <0x30>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	max7310_b: gpio at 32 {
-		compatible = "maxim,max7310";
-		reg = <0x32>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
-	max7310_c: gpio at 34 {
-		compatible = "maxim,max7310";
-		reg = <0x34>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
 };
 
 &iomuxc {
@@ -418,6 +435,12 @@
 			>;
 		};
 
+		pinctrl_i2c3mux: i2c3muxgrp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_A24__GPIO5_IO04 0x0b0b1
+			>;
+		};
+
 		pinctrl_pwm3: pwm1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD4_DAT1__PWM3_OUT		0x1b0b1
-- 
2.7.4
