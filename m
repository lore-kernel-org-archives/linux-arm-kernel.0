From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 21 Dec 2016 03:49:36 -0800
Subject: [PATCH 2/5] ARM: dts: qcom: apq8064: Add riva-pil node
In-Reply-To: <20161221114939.19973-1-bjorn.andersson@linaro.org>
References: <20161221114939.19973-1-bjorn.andersson@linaro.org>
Message-ID: <20161221114939.19973-2-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the Riva PIL, IRIS RF module, BT and WiFI services exposed
by the Riva firmware and the related memory reserve.

Also provides pinctrl nodes for devices enabling the riva-pil.

Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-pins.dtsi | 18 +++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi      | 69 +++++++++++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
index 6b801e7e57a2..5c023e649882 100644
--- a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
@@ -284,4 +284,22 @@
 			bias-disable = <0>;
 		};
 	};
+
+	riva_fm_pin_a: riva-fm-active {
+		pins = "gpio14", "gpio15";
+		function = "riva_fm";
+	};
+
+	riva_bt_pin_a: riva-bt-active {
+		pins = "gpio16", "gpio17";
+		function = "riva_bt";
+	};
+
+	riva_wlan_pin_a: riva-wlan-active {
+		pins = "gpio64", "gpio65", "gpio66", "gpio67", "gpio68";
+		function = "riva_wlan";
+
+		drive-strength = <6>;
+		bias-pull-down;
+	};
 };
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 78bf155a52f3..3dc7a7aa3450 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -21,6 +21,11 @@
 			reg = <0x80000000 0x200000>;
 			no-map;
 		};
+
+		wcnss_mem: wcnss at 8f000000 {
+			reg = <0x8f000000 0x700000>;
+			no-map;
+		};
 	};
 
 	cpus {
@@ -179,7 +184,7 @@
 	};
 
 	clocks {
-		cxo_board {
+		cxo_board: cxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <19200000>;
@@ -1419,6 +1424,68 @@
 				};
 			};
 		};
+
+		riva: riva-pil at 3204000 {
+			compatible = "qcom,riva-pil";
+
+			reg = <0x03200800 0x1000>, <0x03202000 0x2000>, <0x03204000 0x100>;
+			reg-names = "ccu", "dxe", "pmu";
+
+			interrupts-extended = <&intc GIC_SPI 199 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smsm 6 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal";
+
+			memory-region = <&wcnss_mem>;
+
+			vddcx-supply = <&pm8921_s3>;
+			vddmx-supply = <&pm8921_l24>;
+			vddpx-supply = <&pm8921_s4>;
+
+			status = "disabled";
+
+			iris {
+				compatible = "qcom,wcn3660";
+
+				clocks = <&cxo_board>;
+				clock-names = "xo";
+
+				vddxo-supply = <&pm8921_l4>;
+				vddrfa-supply = <&pm8921_s2>;
+				vddpa-supply = <&pm8921_l10>;
+				vdddig-supply = <&pm8921_lvs2>;
+			};
+
+			smd-edge {
+				interrupts = <GIC_SPI 198 IRQ_TYPE_EDGE_RISING>;
+
+				qcom,ipc = <&l2cc 8 25>;
+				qcom,smd-edge = <6>;
+
+				label = "riva";
+
+				wcnss {
+					compatible = "qcom,wcnss";
+					qcom,smd-channels = "WCNSS_CTRL";
+
+					qcom,mmio = <&riva>;
+
+					bt {
+						compatible = "qcom,wcnss-bt";
+					};
+
+					wifi {
+						compatible = "qcom,wcnss-wlan";
+
+						interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
+							     <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
+						interrupt-names = "tx", "rx";
+
+						qcom,smem-states = <&apps_smsm 10>, <&apps_smsm 9>;
+						qcom,smem-state-names = "tx-enable", "tx-rings-empty";
+					};
+				};
+			};
+		};
 	};
 };
 #include "qcom-apq8064-pins.dtsi"
-- 
2.11.0
