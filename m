From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Wed, 21 May 2014 17:57:02 +0300
Subject: [PATCH v1 1/4] ARM: dts: qcom: Add APQ8084 SoC support
In-Reply-To: <1400684225-21381-1-git-send-email-gdjakov@mm-sol.com>
References: <1400684225-21381-1-git-send-email-gdjakov@mm-sol.com>
Message-ID: <1400684225-21381-2-git-send-email-gdjakov@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Qualcomm Snapdragon 805 APQ8084 SoC. It is
used on APQ8084-MTP and other boards.

Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi |  180 +++++++++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8084.dtsi

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
new file mode 100644
index 0000000..a771b3b
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -0,0 +1,180 @@
+/dts-v1/;
+
+#include "skeleton.dtsi"
+
+/ {
+	model = "Qualcomm APQ 8084";
+	compatible = "qcom,apq8084";
+	interrupt-parent = <&intc>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "qcom,krait";
+			reg = <0>;
+			enable-method = "qcom,kpss-acc-v2";
+			next-level-cache = <&L2>;
+			qcom,acc = <&acc0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "qcom,krait";
+			reg = <1>;
+			enable-method = "qcom,kpss-acc-v2";
+			next-level-cache = <&L2>;
+			qcom,acc = <&acc1>;
+		};
+
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "qcom,krait";
+			reg = <2>;
+			enable-method = "qcom,kpss-acc-v2";
+			next-level-cache = <&L2>;
+			qcom,acc = <&acc2>;
+		};
+
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "qcom,krait";
+			reg = <3>;
+			enable-method = "qcom,kpss-acc-v2";
+			next-level-cache = <&L2>;
+			qcom,acc = <&acc3>;
+		};
+
+		L2: l2-cache {
+			compatible = "qcom,arch-cache";
+			cache-level = <2>;
+			interrupts = <0 2 0x4>;
+			qcom,saw = <&saw_l2>;
+		};
+	};
+
+	cpu-pmu {
+		compatible = "qcom,krait-pmu";
+		interrupts = <1 7 0xf04>;
+	};
+
+	soc: soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		compatible = "simple-bus";
+
+		intc: interrupt-controller at f9000000 {
+			compatible = "qcom,msm-qgic2";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0xf9000000 0x1000>,
+			      <0xf9002000 0x1000>;
+		};
+
+		timer {
+			compatible = "arm,armv7-timer";
+			interrupts = <1 2 0xf08>,
+				     <1 3 0xf08>,
+				     <1 4 0xf08>,
+				     <1 1 0xf08>;
+			clock-frequency = <19200000>;
+		};
+
+		timer at f9020000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			compatible = "arm,armv7-timer-mem";
+			reg = <0xf9020000 0x1000>;
+			clock-frequency = <19200000>;
+
+			frame at f9021000 {
+				frame-number = <0>;
+				interrupts = <0 8 0x4>,
+					     <0 7 0x4>;
+				reg = <0xf9021000 0x1000>,
+				      <0xf9022000 0x1000>;
+			};
+
+			frame at f9023000 {
+				frame-number = <1>;
+				interrupts = <0 9 0x4>;
+				reg = <0xf9023000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at f9024000 {
+				frame-number = <2>;
+				interrupts = <0 10 0x4>;
+				reg = <0xf9024000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at f9025000 {
+				frame-number = <3>;
+				interrupts = <0 11 0x4>;
+				reg = <0xf9025000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at f9026000 {
+				frame-number = <4>;
+				interrupts = <0 12 0x4>;
+				reg = <0xf9026000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at f9027000 {
+				frame-number = <5>;
+				interrupts = <0 13 0x4>;
+				reg = <0xf9027000 0x1000>;
+				status = "disabled";
+			};
+
+			frame at f9028000 {
+				frame-number = <6>;
+				interrupts = <0 14 0x4>;
+				reg = <0xf9028000 0x1000>;
+				status = "disabled";
+			};
+		};
+
+		saw_l2: regulator at f9012000 {
+			compatible = "qcom,saw2";
+			reg = <0xf9012000 0x1000>;
+			regulator;
+		};
+
+		acc0: clock-controller at f9088000 {
+			compatible = "qcom,kpss-acc-v2";
+			reg = <0xf9088000 0x1000>,
+			      <0xf9008000 0x1000>;
+		};
+
+		acc1: clock-controller at f9098000 {
+			compatible = "qcom,kpss-acc-v2";
+			reg = <0xf9098000 0x1000>,
+			      <0xf9008000 0x1000>;
+		};
+
+		acc2: clock-controller at f90a8000 {
+			compatible = "qcom,kpss-acc-v2";
+			reg = <0xf90a8000 0x1000>,
+			      <0xf9008000 0x1000>;
+		};
+
+		acc3: clock-controller at f90b8000 {
+			compatible = "qcom,kpss-acc-v2";
+			reg = <0xf90b8000 0x1000>,
+			      <0xf9008000 0x1000>;
+		};
+
+		restart at fc4ab000 {
+			compatible = "qcom,pshold";
+			reg = <0xfc4ab000 0x4>;
+		};
+	};
+};
-- 
1.7.9.5
