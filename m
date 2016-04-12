From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 12 Apr 2016 10:34:02 +0100
Subject: [PATCH v2 13/13] ARM: dts: db600c: add support to magnetometer
In-Reply-To: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1460453642-5809-14-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to on board LIS3MDLTR magnetometer.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi |  8 ++++++++
 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts       | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi
index 3b55bb9..a3efb97 100644
--- a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi
@@ -31,6 +31,14 @@
 			output-low;
 		};
 	};
+
+	magneto_pins: magneto-pins {
+		mux {
+			pins = "gpio31", "gpio48";
+			function = "gpio";
+			bias-disable;
+		};
+	};
 };
 
 &pm8921_mpps {
diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
index 34bb415..e01b27e 100644
--- a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
@@ -153,6 +153,19 @@
 				/* On Low speed expansion and Sensors */
 				label = "LS-I2C0";
 				status = "okay";
+				lis3mdl_mag at 1e {
+					compatible = "st,lis3mdl-magn";
+					reg = <0x1e>;
+					vdd-supply = <&vcc3v3>;
+					vddio-supply = <&pm8921_s4>;
+					pinctrl-names = "default";
+					pinctrl-0 = <&magneto_pins>;
+					interrupt-parent = <&tlmm_pinmux>;
+
+					st,drdy-int-pin = <2>;
+					interrupts = <48 IRQ_TYPE_EDGE_RISING>, /* DRDY line */
+						     <31 IRQ_TYPE_EDGE_RISING>; /* INT */
+				};
 			};
 		};
 
-- 
2.5.0
