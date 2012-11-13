From: Frank.Li@freescale.com (Frank Li)
Date: Tue, 13 Nov 2012 16:53:56 +0800
Subject: [PATCH 1/2] ARM: dts: imx6q-sabresd: add i2c1 device and mma8451
Message-ID: <1352796836-24180-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add i2c1 device and mma8451 for sabresd board

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabresd.dts |   24 ++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi        |    5 +++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabresd.dts b/arch/arm/boot/dts/imx6q-sabresd.dts
index e596c28..aefdee4 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dts
+++ b/arch/arm/boot/dts/imx6q-sabresd.dts
@@ -42,6 +42,7 @@
 							1410 0x80000000	/* MX6Q_PAD_NANDF_D1__GPIO_2_1 */
 							1418 0x80000000	/* MX6Q_PAD_NANDF_D2__GPIO_2_2 */
 							1426 0x80000000	/* MX6Q_PAD_NANDF_D3__GPIO_2_3 */
+							160 0x80000000 /* MX6Q_PAD_EIM_EB3__GPIO_2_31 */
 						>;
 					};
 				};
@@ -71,6 +72,29 @@
 				wp-gpios = <&gpio2 1 0>;
 				status = "okay";
 			};
+
+			i2c at 021a0000 { /* I2C1 */
+				status = "okay";
+				clock-frequency = <100000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_i2c1_2>;
+
+				mma8451 at 1c {
+					compatible = "fsl,mma8451";
+					reg = <0x1c>;
+					vdd-supply = <&sensor>;
+					vddio-supply = <&sensor>;
+				};
+			};
 		};
 	};
+	sensor: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "sensor-supply";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio2 31 1>;
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
 };
diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index f3990b0..b637c70 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -637,6 +637,11 @@
 							196 0x4001b8b1	/* MX6Q_PAD_EIM_D28__I2C1_SDA */
 						>;
 					};
+					pinctrl_i2c1_2: i2c1grp-2 {
+						fsl,pins = <
+							1125 0x4001b8b1 /* MX6Q_PAD_CSI0_DAT8__I2C1_SDA */
+							1133 0x4001b8b1 /* MX6Q_PAD_CSI0_DAT9__I2C1_SCL */						>;
+					};
 				};
 
 				uart1 {
-- 
1.7.1
