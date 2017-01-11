From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Wed, 11 Jan 2017 17:50:21 +0200
Subject: [PATCH v3] ARM: dts: qcom: Add apq8064 CoreSight components
Message-ID: <20170111155021.28273-1-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>

Add initial set of CoreSight components found on Qualcomm apq8064 based
platforms, including the IFC6410 board.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
Changes since v2 (https://lkml.org/lkml/2016/11/21/522)
 * Rebase to linux-next

Changes since v1 (https://lkml.org/lkml/2016/11/17/474)
 * Moved everything into the SoC dtsi file as suggested by Stephen Boyd.
 * Updated commit message.
 * Got Ack from Mathieu.

 arch/arm/boot/dts/qcom-apq8064.dtsi | 189 +++++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 407a4610f4a7..4b77075ef731 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -28,7 +28,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		CPU0: cpu at 0 {
 			compatible = "qcom,krait";
 			enable-method = "qcom,kpss-acc-v1";
 			device_type = "cpu";
@@ -39,7 +39,7 @@
 			cpu-idle-states = <&CPU_SPC>;
 		};
 
-		cpu at 1 {
+		CPU1: cpu at 1 {
 			compatible = "qcom,krait";
 			enable-method = "qcom,kpss-acc-v1";
 			device_type = "cpu";
@@ -50,7 +50,7 @@
 			cpu-idle-states = <&CPU_SPC>;
 		};
 
-		cpu at 2 {
+		CPU2: cpu at 2 {
 			compatible = "qcom,krait";
 			enable-method = "qcom,kpss-acc-v1";
 			device_type = "cpu";
@@ -61,7 +61,7 @@
 			cpu-idle-states = <&CPU_SPC>;
 		};
 
-		cpu at 3 {
+		CPU3: cpu at 3 {
 			compatible = "qcom,krait";
 			enable-method = "qcom,kpss-acc-v1";
 			device_type = "cpu";
@@ -1420,6 +1420,187 @@
 				};
 			};
 		};
+
+		etb at 1a01000 {
+			compatible = "coresight-etb10", "arm,primecell";
+			reg = <0x1a01000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			port {
+				etb_in: endpoint {
+					slave-mode;
+					remote-endpoint = <&replicator_out0>;
+				};
+			};
+		};
+
+		tpiu at 1a03000 {
+			compatible = "arm,coresight-tpiu", "arm,primecell";
+			reg = <0x1a03000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			port {
+				tpiu_in: endpoint {
+					slave-mode;
+					remote-endpoint = <&replicator_out1>;
+				};
+			};
+		};
+
+		replicator {
+			compatible = "arm,coresight-replicator";
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					replicator_out0: endpoint {
+						remote-endpoint = <&etb_in>;
+					};
+				};
+				port at 1 {
+					reg = <1>;
+					replicator_out1: endpoint {
+						remote-endpoint = <&tpiu_in>;
+					};
+				};
+				port at 2 {
+					reg = <0>;
+					replicator_in: endpoint {
+						slave-mode;
+						remote-endpoint = <&funnel_out>;
+					};
+				};
+			};
+		};
+
+		funnel at 1a04000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0x1a04000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/*
+				 * Not described input ports:
+				 * 2 - connected to STM component
+				 * 3 - not-connected
+				 * 6 - not-connected
+				 * 7 - not-connected
+				 */
+				port at 0 {
+					reg = <0>;
+					funnel_in0: endpoint {
+						slave-mode;
+						remote-endpoint = <&etm0_out>;
+					};
+				};
+				port at 1 {
+					reg = <1>;
+					funnel_in1: endpoint {
+						slave-mode;
+						remote-endpoint = <&etm1_out>;
+					};
+				};
+				port at 4 {
+					reg = <4>;
+					funnel_in4: endpoint {
+						slave-mode;
+						remote-endpoint = <&etm2_out>;
+					};
+				};
+				port at 5 {
+					reg = <5>;
+					funnel_in5: endpoint {
+						slave-mode;
+						remote-endpoint = <&etm3_out>;
+					};
+				};
+				port at 8 {
+					reg = <0>;
+					funnel_out: endpoint {
+						remote-endpoint = <&replicator_in>;
+					};
+				};
+			};
+		};
+
+		etm at 1a1c000 {
+			compatible = "arm,coresight-etm3x", "arm,primecell";
+			reg = <0x1a1c000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU0>;
+
+			port {
+				etm0_out: endpoint {
+					remote-endpoint = <&funnel_in0>;
+				};
+			};
+		};
+
+		etm at 1a1d000 {
+			compatible = "arm,coresight-etm3x", "arm,primecell";
+			reg = <0x1a1d000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU1>;
+
+			port {
+				etm1_out: endpoint {
+					remote-endpoint = <&funnel_in1>;
+				};
+			};
+		};
+
+		etm at 1a1e000 {
+			compatible = "arm,coresight-etm3x", "arm,primecell";
+			reg = <0x1a1e000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU2>;
+
+			port {
+				etm2_out: endpoint {
+					remote-endpoint = <&funnel_in4>;
+				};
+			};
+		};
+
+		etm at 1a1f000 {
+			compatible = "arm,coresight-etm3x", "arm,primecell";
+			reg = <0x1a1f000 0x1000>;
+
+			clocks = <&rpmcc RPM_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			cpu = <&CPU3>;
+
+			port {
+				etm3_out: endpoint {
+					remote-endpoint = <&funnel_in5>;
+				};
+			};
+		};
 	};
 };
 #include "qcom-apq8064-pins.dtsi"
