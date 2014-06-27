From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 27 Jun 2014 12:04:20 -0600
Subject: [PATCH 8/9 v2] coresight: adding basic support for Vexpress TC2
In-Reply-To: <1403892261-25026-1-git-send-email-mathieu.poirier@linaro.org>
References: <1403892261-25026-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1403892261-25026-9-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Support for the 2 PTMs, 3 ETMs, funnel, TPIU and replicator
connected to the ETB are included.  Proper handling of the
ITM and the replicator linked to it along with the CTIs
and SWO are not included.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 174 +++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 15f98cb..390f2bb 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -334,6 +334,180 @@
 		};
 	};
 
+	etb: etb at 20010000 {
+		compatible = "arm,coresight-etb", "arm,primecell";
+		reg = <0 0x20010000 0 0x1000>;
+
+		coresight-default-sink;
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+		port {
+			etb_in_port: endpoint at 0 {
+				slave-mode;
+				remote-endpoint = <&funnel_out_port0>;
+			};
+		};
+	};
+
+	tpiu: tpiu at 20030000 {
+		compatible = "arm,coresight-tpiu", "arm,primecell";
+		reg = <0 0x20030000 0 0x1000>;
+
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+		port {
+			tpiu_in_port: endpoint at 0 {
+				slave-mode;
+				remote-endpoint = <&funnel_out_port1>;
+			};
+		};
+	};
+
+	funnel {
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0 0x20040000 0 0x1000>;
+
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* The funnel is connected to a replicator - since
+			 * replicators are hardwired we simply treat the
+			 * funnel as a multiple-in and multiple out component.
+			 * The following two ports really belong to the
+			 * repicator but configured as par of the funnel.
+			 */
+
+			/* replicator port */
+			port at 0 {
+				reg = <0>;
+				funnel_out_port0: endpoint {
+					remote-endpoint = <&etb_in_port>;
+				};
+			};
+
+			/* replicator port */
+			port at 1 {
+				reg = <1>;
+				funnel_out_port1: endpoint {
+					remote-endpoint = <&tpiu_in_port>;
+				};
+			};
+			/* funnel ports */
+			port at 2 {
+				reg = <0>;
+				funnel_in_port0: endpoint {
+					slave-mode;
+					remote-endpoint = <&ptm0_out_port>;
+				};
+			};
+
+			port at 3 {
+				reg = <1>;
+				funnel_in_port1: endpoint {
+					slave-mode;
+					remote-endpoint = <&ptm1_out_port>;
+				};
+			};
+
+			port at 4 {
+				reg = <2>;
+				funnel_in_port2: endpoint {
+					slave-mode;
+					remote-endpoint = <&etm0_out_port>;
+				};
+			};
+
+			port at 5 {
+				reg = <4>;
+				funnel_in_port4: endpoint {
+					slave-mode;
+					remote-endpoint = <&etm1_out_port>;
+				};
+			};
+
+			port at 6 {
+				reg = <5>;
+				funnel_in_port5: endpoint {
+					slave-mode;
+					remote-endpoint = <&etm2_out_port>;
+				};
+			};
+                };
+	};
+
+	ptm0: ptm at 2201c000 {
+		compatible = "arm,coresight-etm", "arm,primecell";
+		reg = <0 0x2201c000 0 0x1000>;
+
+		cpu = <&cpu0>;
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+		port {
+			ptm0_out_port: endpoint {
+				remote-endpoint = <&funnel_in_port0>;
+			};
+		};
+	};
+
+	ptm1: ptm at 2201d000 {
+		compatible = "arm,coresight-etm", "arm,primecell";
+		reg = <0 0x2201d000 0 0x1000>;
+
+		cpu = <&cpu1>;
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+		port {
+			ptm1_out_port: endpoint {
+				remote-endpoint = <&funnel_in_port1>;
+			};
+		};
+	};
+
+	etm0: etm at 2203c000 {
+		compatible = "arm,coresight-etm", "arm,primecell";
+		reg = <0 0x2203c000 0 0x1000>;
+
+		cpu = <&cpu2>;
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+		port {
+			etm0_out_port: endpoint {
+				remote-endpoint = <&funnel_in_port2>;
+			};
+		};
+	};
+
+	etm1: etm at 2203d000 {
+		compatible = "arm,coresight-etm", "arm,primecell";
+		reg = <0 0x2203d000 0 0x1000>;
+
+		cpu = <&cpu3>;
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+		port {
+			etm1_out_port: endpoint {
+				remote-endpoint = <&funnel_in_port4>;
+			};
+		};
+	};
+
+	etm2: etm at 2203e000 {
+		compatible = "arm,coresight-etm", "arm,primecell";
+		reg = <0 0x2203e000 0 0x1000>;
+
+		cpu = <&cpu4>;
+		clocks = <&oscclk6a>;
+		clock-names = "apb_pclk";
+		port {
+			etm2_out_port: endpoint {
+				remote-endpoint = <&funnel_in_port5>;
+			};
+		};
+	};
+
 	smb {
 		compatible = "simple-bus";
 
-- 
1.9.1
