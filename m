From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  6 Jul 2015 14:21:45 -0600
Subject: [PATCH] arm64: Juno: Add support for coresight
Message-ID: <1436214105-3147-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for coresight components.  More specifically
it has definitions for the A53/57 tracers, the A53/57 cluster funnels,
the main funnel and the ETF configured in circular buffer mode.

Support for other coresight IP blocks have not been addressed yet.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 241 +++++++++++++++++++++++++++++++++
 1 file changed, 241 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index e3ee96036eca..b787f8a9304d 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -152,3 +152,244 @@
 
 		/include/ "juno-motherboard.dtsi"
 	};
+
+	etf at 20010000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0 0x20010000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		port {
+			etf_in_port: endpoint {
+				slave-mode;
+				remote-endpoint = <&main_funnel_out_port>;
+			};
+		};
+	};
+
+	main_funnel at 20040000 {
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0 0x20040000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* output port */
+			port at 0 {
+				reg = <0>;
+				main_funnel_out_port: endpoint {
+					remote-endpoint =
+						<&etf_in_port>;
+				};
+			};
+
+			/*
+			 * input ports:
+			 * port 0: Funnel Cortex-A57
+			 * port 1: Funnel Cortex-A53
+			 * port 2: STM
+			 * port 3: Funnel SCP
+			 * port 4: System profiler
+			 * port 5: ATB extension interfaces
+			 * port 6: ATB extension interfaces
+			 */
+			port at 1 {
+				reg = <0>;
+				main_funnel_in_port0: endpoint {
+					slave-mode;
+					remote-endpoint =
+							<&A57_funnel_out_port>;
+				};
+			};
+
+			port at 2 {
+				reg = <1>;
+				main_funnel_in_port1: endpoint {
+					slave-mode;
+					remote-endpoint = <&A53_etm0_out_port>;
+				};
+			};
+
+		};
+	};
+
+	A57_funnel at 220c0000 {
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0 0x220c0000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* output port */
+			port at 0 {
+				reg = <0>;
+				A57_funnel_out_port: endpoint {
+					remote-endpoint =
+						<&main_funnel_in_port0>;
+				};
+			};
+
+			/* input ports */
+			port at 1 {
+				reg = <0>;
+				A57_funnel_in_port0: endpoint {
+					slave-mode;
+					remote-endpoint = <&A57_etm0_out_port>;
+				};
+			};
+
+			port at 2 {
+				reg = <1>;
+				A57_funnel_in_port1: endpoint {
+					slave-mode;
+					remote-endpoint = <&A57_etm1_out_port>;
+				};
+			};
+
+			/* input port 2 to 6 are not connected */
+		};
+	};
+
+	A53_funnel at 220c0000 {
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0 0x230c0000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* output port */
+			port at 0 {
+				reg = <0>;
+				A53_funnel_out_port: endpoint {
+					remote-endpoint =
+						<&main_funnel_in_port1>;
+				};
+			};
+
+			/* input port */
+			port at 1 {
+				reg = <0>;
+				A53_funnel_in_port0: endpoint {
+					slave-mode;
+					remote-endpoint = <&A53_etm0_out_port>;
+				};
+			};
+
+			port at 2 {
+				reg = <1>;
+				A53_funnel_in_port1: endpoint {
+					slave-mode;
+					remote-endpoint = <&A53_etm1_out_port>;
+				};
+			};
+			port at 3 {
+				reg = <2>;
+				A53_funnel_in_port2: endpoint {
+					slave-mode;
+					remote-endpoint = <&A53_etm2_out_port>;
+				};
+			};
+			port at 4 {
+				reg = <3>;
+				A53_funnel_in_port3: endpoint {
+					slave-mode;
+					remote-endpoint = <&A53_etm3_out_port>;
+				};
+			};
+
+			/* input port 4 to 6 are not connected */
+		};
+	};
+
+	etm at 22040000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x22040000 0 0x1000>;
+
+		cpu = <&A57_0>;
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		port {
+			A57_etm0_out_port: endpoint {
+				remote-endpoint = <&A57_funnel_in_port0>;
+			};
+		};
+	};
+
+	etm at 22140000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x22140000 0 0x1000>;
+
+		cpu = <&A57_1>;
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		port {
+			A57_etm1_out_port: endpoint {
+				remote-endpoint = <&A57_funnel_in_port1>;
+			};
+		};
+	};
+
+	etm at 23040000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x23040000 0 0x1000>;
+
+		cpu = <&A53_0>;
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		port {
+			A53_etm0_out_port: endpoint {
+				remote-endpoint = <&A53_funnel_in_port0>;
+			};
+		};
+	};
+
+	etm at 23140000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x23140000 0 0x1000>;
+
+		cpu = <&A53_1>;
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		port {
+			A53_etm1_out_port: endpoint {
+				remote-endpoint = <&A53_funnel_in_port1>;
+			};
+		};
+	};
+
+	etm at 23240000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x23240000 0 0x1000>;
+
+		cpu = <&A53_2>;
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		port {
+			A53_etm2_out_port: endpoint {
+				remote-endpoint = <&A53_funnel_in_port2>;
+			};
+		};
+	};
+
+	etm at 23340000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x23340000 0 0x1000>;
+
+		cpu = <&A53_3>;
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		port {
+			A53_etm3_out_port: endpoint {
+				remote-endpoint = <&A53_funnel_in_port3>;
+			};
+		};
+	};
-- 
1.9.1
