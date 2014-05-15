From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 May 2014 17:12:48 +0200
Subject: [PATCH] ARM: dt: imx28-cfa10036: introduce a regulator for mmc0
Message-ID: <1400166768-18801-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PWM3 pinmux configuration conflicts with gpio 3.28. Introduce a regulator
for mmc0 so that it conflicts with the pwm driver and fails gracefully. The
kernel will then able to access mmc0 normally.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10036.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
index cabb6171a19d..cd5fab8efa76 100644
--- a/arch/arm/boot/dts/imx28-cfa10036.dts
+++ b/arch/arm/boot/dts/imx28-cfa10036.dts
@@ -53,6 +53,17 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				mmc_pwr_cfa10036: mmc_pwr_cfa10036 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x31c3 /*
+						MX28_PAD_PWM3__GPIO_3_28 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 			};
 
 			ssp0: ssp at 80010000 {
@@ -60,6 +71,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&mmc0_4bit_pins_a
 					&mmc0_cd_cfg &mmc0_sck_cfg>;
+				vmmc-supply = <&reg_vddio_sd0>;
 				bus-width = <4>;
 				status = "okay";
 			};
@@ -114,4 +126,14 @@
 			default-state = "on";
 		};
 	};
+
+	reg_vddio_sd0: vddio-sd0 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&mmc_pwr_cfa10036>;
+		regulator-name = "vddio-sd0";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio3 28 0>;
+	};
 };
-- 
1.9.1
