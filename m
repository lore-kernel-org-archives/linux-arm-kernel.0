From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Wed, 15 Jul 2015 15:05:48 +0800
Subject: [PATCH] arm64: dts: sprd: adding ETM entries to Spreadtrum SC9836
Message-ID: <1436943948-14489-1-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since ETMv4 driver has been merged, this patch adds ETM nodes for SC9836,
and four funnel input ports to connect with ETM output ports.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc9836.dtsi | 99 ++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9836.dtsi b/arch/arm64/boot/dts/sprd/sc9836.dtsi
index ee34e1a..63894c4 100644
--- a/arch/arm64/boot/dts/sprd/sc9836.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9836.dtsi
@@ -16,28 +16,28 @@
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 		};
 
-		cpu at 1 {
+		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 		};
 
-		cpu at 2 {
+		cpu2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 		};
 
-		cpu at 3 {
+		cpu3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x3>;
@@ -75,14 +75,103 @@
 				};
 			};
 
-			/* funnel input port 0~3 is reserved for ETMs */
+			/* funnel input port 0-4 */
 			port at 1 {
+				reg = <0>;
+				funnel_in_port0: endpoint {
+					slave-mode;
+					remote-endpoint = <&etm0_out>;
+				};
+			};
+
+			port at 2 {
+				reg = <1>;
+				funnel_in_port1: endpoint {
+					slave-mode;
+					remote-endpoint = <&etm1_out>;
+				};
+			};
+
+			port at 3 {
+				reg = <2>;
+				funnel_in_port2: endpoint {
+					slave-mode;
+					remote-endpoint = <&etm2_out>;
+				};
+			};
+
+			port at 4 {
+				reg = <3>;
+				funnel_in_port3: endpoint {
+					slave-mode;
+					remote-endpoint = <&etm3_out>;
+				};
+			};
+
+			port at 5 {
 				reg = <4>;
 				funnel_in_port4: endpoint {
 					slave-mode;
 					remote-endpoint = <&stm_out>;
 				};
 			};
+			/* Other input ports aren't connected to anyone */
+		};
+	};
+
+	etm at 10440000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x10440000 0 0x1000>;
+
+		cpu = <&cpu0>;
+		clocks = <&clk26mhz>;
+		clock-names = "apb_pclk";
+		port {
+			etm0_out: endpoint {
+				remote-endpoint = <&funnel_in_port0>;
+			};
+		};
+	};
+
+	etm at 10540000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x10540000 0 0x1000>;
+
+		cpu = <&cpu1>;
+		clocks = <&clk26mhz>;
+		clock-names = "apb_pclk";
+		port {
+			etm1_out: endpoint {
+				remote-endpoint = <&funnel_in_port1>;
+			};
+		};
+	};
+
+	etm at 10640000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x10640000 0 0x1000>;
+
+		cpu = <&cpu2>;
+		clocks = <&clk26mhz>;
+		clock-names = "apb_pclk";
+		port {
+			etm2_out: endpoint {
+				remote-endpoint = <&funnel_in_port2>;
+			};
+		};
+	};
+
+	etm at 10740000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x10740000 0 0x1000>;
+
+		cpu = <&cpu3>;
+		clocks = <&clk26mhz>;
+		clock-names = "apb_pclk";
+		port {
+			etm3_out: endpoint {
+				remote-endpoint = <&funnel_in_port3>;
+			};
 		};
 	};
 
-- 
1.9.1
