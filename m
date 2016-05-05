From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu,  5 May 2016 14:21:48 +0530
Subject: [PATCH v6 10/11] arm64: dts: msm8916: Add thermal zones,
 tsens and qfprom nodes
In-Reply-To: <1462438309-11196-1-git-send-email-rnayak@codeaurora.org>
References: <1462438309-11196-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1462438309-11196-11-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add thermal zones, tsens and qfprom nodes

Cc: Andy Gross <agross@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 64 +++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index af25110..505cf3a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -98,6 +98,49 @@
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal0 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 4>;
+
+			trips {
+				cpu_alert0: trip at 0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit0: trip at 1 {
+					temperature = <110000>;
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
+			thermal-sensors = <&tsens 3>;
+
+			trips {
+				cpu_alert1: trip at 0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				cpu_crit1: trip at 1 {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
@@ -544,6 +587,27 @@
 			clocks = <&gcc GCC_PRNG_AHB_CLK>;
 			clock-names = "core";
 		};
+
+		qfprom: qfprom at 5c000 {
+			compatible = "qcom,qfprom";
+			reg = <0x5c000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			tsens_caldata: caldata at d0 {
+				reg = <0xd0 0x8>;
+			};
+			tsens_calsel: calsel at ec {
+				reg = <0xec 0x4>;
+			};
+		};
+
+		tsens: thermal-sensor at 4a8000 {
+			compatible = "qcom,msm8916-tsens";
+			reg = <0x4a8000 0x2000>;
+			nvmem-cells = <&tsens_caldata>, <&tsens_calsel>;
+			nvmem-cell-names = "calib", "calib_sel";
+			#thermal-sensor-cells = <1>;
+		};
 	};
 
 	smd {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
