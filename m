From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Fri,  9 Oct 2015 15:11:08 +0530
Subject: [PATCH v4 6/8] arm: dts: apq8064: Add thermal zones,
 tsens and qfprom nodes
In-Reply-To: <1444383670-32693-1-git-send-email-rnayak@codeaurora.org>
References: <1444383670-32693-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1444383670-32693-7-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TSENS is part of GCC, hence add TSENS properties as part of GCC node.
Also add thermal zones and qfprom nodes.
Update GCC bindings doc to mention the possibility of optional TSENS
properties that can be part of GCC node.

Cc: Andy Gross <agross@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 .../devicetree/bindings/clock/qcom,gcc.txt         |  20 ++++
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 101 +++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.txt b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
index 54c23f3..f1cf499 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.txt
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.txt
@@ -18,6 +18,13 @@ Required properties :
 - #clock-cells : shall contain 1
 - #reset-cells : shall contain 1
 
+Optional properties:
+- Qualcomm TSENS (thermal sensor device) on some devices can
+be part of GCC and hence the TSENS properties can also be
+part of the GCC/clock-controller node.
+For more details on the TSENS properties please refer
+Documentation/devicetree/bindings/thermal/qcom-tsens.txt
+
 Example:
 	clock-controller at 900000 {
 		compatible = "qcom,gcc-msm8960";
@@ -25,3 +32,16 @@ Example:
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};
+
+Example of GCC with TSENS properties:
+	clock-controller at 900000 {
+		compatible = "qcom,gcc-apq8064";
+		reg = <0x00900000 0x4000>;
+		nvmem-cells = <&tsens_calib>, <&tsens_backup>;
+		nvmem-cell-names = "calib", "calib_backup";
+		qcom,tsens-slopes = <1176 1176 1154 1176 1111
+				1132 1132 1199 1132 1199 1132>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+		#thermal-sensor-cells = <1>;
+	};
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index d2e94d6..6a0866b 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -75,6 +75,88 @@
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal0 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&gcc 7>;
+
+			trips {
+				cpu_alert0: trip at 0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit0: trip at 1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-thermal1 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&gcc 8>;
+
+			trips {
+				cpu_alert1: trip at 0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit1: trip at 1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-thermal2 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&gcc 9>;
+
+			trips {
+				cpu_alert2: trip at 0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit2: trip at 1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu-thermal3 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&gcc 10>;
+
+			trips {
+				cpu_alert3: trip at 0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit3: trip at 1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	cpu-pmu {
 		compatible = "qcom,krait-pmu";
 		interrupts = <1 10 0x304>;
@@ -364,11 +446,30 @@
 			};
 		};
 
+		qfprom: qfprom at 00700000 {
+			compatible	= "qcom,qfprom";
+			reg		= <0x00700000 0x1000>;
+			#address-cells	= <1>;
+			#size-cells	= <1>;
+			ranges;
+			tsens_calib: calib {
+				reg = <0x404 0x10>;
+			};
+			tsens_backup: backup_calib {
+				reg = <0x414 0x10>;
+			};
+		};
+
 		gcc: clock-controller at 900000 {
 			compatible = "qcom,gcc-apq8064";
 			reg = <0x00900000 0x4000>;
+			nvmem-cells = <&tsens_calib>, <&tsens_backup>;
+			nvmem-cell-names = "calib", "calib_backup";
+			qcom,tsens-slopes = <1176 1176 1154 1176 1111
+				1132 1132 1199 1132 1199 1132>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#thermal-sensor-cells = <1>;
 		};
 
 		lcc: clock-controller at 28000000 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
