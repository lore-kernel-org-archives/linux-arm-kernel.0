From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 22 Apr 2015 16:46:42 -0600
Subject: [PATCH] coresight: Add support for Juno platform
Message-ID: <1429742802-13089-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for ARM's juno platform.  More
specifically it has definitions for the A53/57 tracers, the
A53/57 cluster funnels, the main funnel and the ETF in
circular buffer mode.

Support for the replicator, TPIU, ETR, CTI, CTM, ATM along with
all the coresight IP blocks found in the SPC sub-system have
not been addressed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm64/boot/dts/arm/juno.dts | 222 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 133ee59de2d7..0d0a9cbbb193 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -200,6 +200,228 @@
 		clock-names = "apb_pclk";
 	};
 
+	etf at 20010000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0 0x20010000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		port {
+			etf_in_port: endpoint at 0 {
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
+			port at 0 {
+				reg = <0>;
+				main_funnel_out_port: endpoint {
+					remote-endpoint =
+						<&etf_in_port>;
+				};
+			};
+
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
+			port at 0 {
+				reg = <0>;
+				A57_funnel_out_port: endpoint {
+					remote-endpoint =
+						<&main_funnel_in_port0>;
+				};
+			};
+
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
+			port at 0 {
+				reg = <0>;
+				A53_funnel_out_port: endpoint {
+					remote-endpoint =
+						<&main_funnel_in_port1>;
+				};
+			};
+
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
+
 	smb {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
1.9.1
