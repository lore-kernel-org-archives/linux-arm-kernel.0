From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Wed, 25 Mar 2015 20:52:11 +0800
Subject: [PATCH v2] coresight: adding basic support for Spreadtrum SC9836
Message-ID: <1427287931-9363-1-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support only for ETF, FUNNEL, STM are included currently.
Support for ETM, TPIU and the replicator linked to it are not included in
this version patch.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
Change for v2:
 - Corrected the TMC whose space is wrongly used as ETB in v1.
 - Removed "coresight-default-sink" from the DT.
---
 arch/arm64/boot/dts/sprd/sc9836.dtsi | 55 ++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc9836.dtsi b/arch/arm64/boot/dts/sprd/sc9836.dtsi
index f92f1b4..ee34e1a 100644
--- a/arch/arm64/boot/dts/sprd/sc9836.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9836.dtsi
@@ -45,6 +45,61 @@
 		};
 	};
 
+	etf at 10003000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0 0x10003000 0 0x1000>;
+		clocks = <&clk26mhz>;
+		clock-names = "apb_pclk";
+		port {
+			etf_in: endpoint {
+				slave-mode;
+				remote-endpoint = <&funnel_out_port0>;
+			};
+		};
+	};
+
+	funnel at 10001000 {
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0 0x10001000 0 0x1000>;
+		clocks = <&clk26mhz>;
+		clock-names = "apb_pclk";
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* funnel output port */
+			port at 0 {
+				reg = <0>;
+				funnel_out_port0: endpoint {
+					remote-endpoint = <&etf_in>;
+				};
+			};
+
+			/* funnel input port 0~3 is reserved for ETMs */
+			port at 1 {
+				reg = <4>;
+				funnel_in_port4: endpoint {
+					slave-mode;
+					remote-endpoint = <&stm_out>;
+				};
+			};
+		};
+	};
+
+	stm at 10006000 {
+		compatible = "arm,coresight-stm", "arm,primecell";
+		reg = <0 0x10006000 0 0x1000>,
+		      <0 0x01000000 0 0x180000>;
+		reg-names = "stm-base", "stm-stimulus-base";
+		clocks = <&clk26mhz>;
+		clock-names = "apb_pclk";
+		port {
+			stm_out: endpoint {
+				remote-endpoint = <&funnel_in_port4>;
+			};
+		};
+	};
+
 	gic: interrupt-controller at 12001000 {
 		compatible = "arm,gic-400";
 		reg = <0 0x12001000 0 0x1000>,
-- 
1.9.1
