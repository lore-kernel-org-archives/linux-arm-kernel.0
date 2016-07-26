From: stefan@agner.ch (Stefan Agner)
Date: Mon, 25 Jul 2016 23:42:35 -0700
Subject: [PATCH 1/2] ARM: dts: imx7d: move ARM platform peripherals inside soc
 node
Message-ID: <20160726064236.11034-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have a SoC level node we should make use of it and have
all nodes which are within the SoC, inside that node. This also
saves an extra interrupt-parent properties. While at it, also
order the Coresight nodes according to register addresses.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Hi Shawn,

Not sure if there was a reasoning behind having all these nodes
not within the soc subnode, but it seems to me somewhat uncommon
in the i.MX world...

If possible this patchset should go into v4.8 since 2/2 is a fix,
however, I understand that 1/2 is not really post rc1 material...
What do you think?

--
Stefan

 arch/arm/boot/dts/imx7d.dtsi |  32 ++---
 arch/arm/boot/dts/imx7s.dtsi | 301 +++++++++++++++++++++----------------------
 2 files changed, 167 insertions(+), 166 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 51c13cb..3d77d95 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -52,23 +52,25 @@
 		};
 	};
 
-	etm at 3007d000 {
-		compatible = "arm,coresight-etm3x", "arm,primecell";
-		reg = <0x3007d000 0x1000>;
+	soc {
+		etm at 3007d000 {
+			compatible = "arm,coresight-etm3x", "arm,primecell";
+			reg = <0x3007d000 0x1000>;
 
-		/*
-		 * System will hang if added nosmp in kernel command line
-		 * without arm,primecell-periphid because amba bus try to
-		 * read id and core1 power off at this time.
-		 */
-		arm,primecell-periphid = <0xbb956>;
-		cpu = <&cpu1>;
-		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
-		clock-names = "apb_pclk";
+			/*
+			 * System will hang if added nosmp in kernel command line
+			 * without arm,primecell-periphid because amba bus try to
+			 * read id and core1 power off at this time.
+			 */
+			arm,primecell-periphid = <0xbb956>;
+			cpu = <&cpu1>;
+			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
+			clock-names = "apb_pclk";
 
-		port {
-			etm1_out_port: endpoint {
-				remote-endpoint = <&ca_funnel_in_port1>;
+			port {
+				etm1_out_port: endpoint {
+					remote-endpoint = <&ca_funnel_in_port1>;
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 1e90bdb..d89587a 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -95,16 +95,6 @@
 		};
 	};
 
-	intc: interrupt-controller at 31001000 {
-		compatible = "arm,cortex-a7-gic";
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		reg = <0x31001000 0x1000>,
-		      <0x31002000 0x1000>,
-		      <0x31004000 0x2000>,
-		      <0x31006000 0x2000>;
-	};
-
 	ckil: clock-cki {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -119,195 +109,204 @@
 		clock-output-names = "osc";
 	};
 
-	timer {
-		compatible = "arm,armv7-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
 		interrupt-parent = <&intc>;
-	};
+		ranges;
 
-	etr at 30086000 {
-		compatible = "arm,coresight-tmc", "arm,primecell";
-		reg = <0x30086000 0x1000>;
-		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
-		clock-names = "apb_pclk";
+		funnel at 30041000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0x30041000 0x1000>;
+			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
+			clock-names = "apb_pclk";
+
+			ca_funnel_ports: ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* funnel input ports */
+				port at 0 {
+					reg = <0>;
+					ca_funnel_in_port0: endpoint {
+						slave-mode;
+						remote-endpoint = <&etm0_out_port>;
+					};
+				};
+
+				/* funnel output port */
+				port at 2 {
+					reg = <0>;
+					ca_funnel_out_port0: endpoint {
+						remote-endpoint = <&hugo_funnel_in_port0>;
+					};
+				};
 
-		port {
-			etr_in_port: endpoint {
-				slave-mode;
-				remote-endpoint = <&replicator_out_port1>;
+				/* the other input ports are not connect to anything */
 			};
 		};
-	};
 
-	tpiu at 30087000 {
-		compatible = "arm,coresight-tpiu", "arm,primecell";
-		reg = <0x30087000 0x1000>;
-		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
-		clock-names = "apb_pclk";
+		etm at 3007c000 {
+			compatible = "arm,coresight-etm3x", "arm,primecell";
+			reg = <0x3007c000 0x1000>;
+			cpu = <&cpu0>;
+			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
+			clock-names = "apb_pclk";
 
-		port {
-			tpiu_in_port: endpoint {
-				slave-mode;
-				remote-endpoint = <&replicator_out_port1>;
+			port {
+				etm0_out_port: endpoint {
+					remote-endpoint = <&ca_funnel_in_port0>;
+				};
 			};
 		};
-	};
 
-	replicator {
-		/*
-		 * non-configurable replicators don't show up on the
-		 * AMBA bus.  As such no need to add "arm,primecell"
-		 */
-		compatible = "arm,coresight-replicator";
+		funnel at 30083000 {
+			compatible = "arm,coresight-funnel", "arm,primecell";
+			reg = <0x30083000 0x1000>;
+			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
+			clock-names = "apb_pclk";
 
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
 
-			/* replicator output ports */
-			port at 0 {
-				reg = <0>;
-				replicator_out_port0: endpoint {
-					remote-endpoint = <&tpiu_in_port>;
+				/* funnel input ports */
+				port at 0 {
+					reg = <0>;
+					hugo_funnel_in_port0: endpoint {
+						slave-mode;
+						remote-endpoint = <&ca_funnel_out_port0>;
+					};
 				};
-			};
 
-			port at 1 {
-				reg = <1>;
-				replicator_out_port1: endpoint {
-					remote-endpoint = <&etr_in_port>;
+				port at 1 {
+					reg = <1>;
+					hugo_funnel_in_port1: endpoint {
+						slave-mode; /* M4 input */
+					};
 				};
-			};
 
-			/* replicator input port */
-			port at 2 {
-				reg = <0>;
-				replicator_in_port0: endpoint {
-					slave-mode;
-					remote-endpoint = <&etf_out_port>;
+				port at 2 {
+					reg = <0>;
+					hugo_funnel_out_port0: endpoint {
+						remote-endpoint = <&etf_in_port>;
+					};
 				};
+
+				/* the other input ports are not connect to anything */
 			};
 		};
-	};
 
-	etf at 30084000 {
-		compatible = "arm,coresight-tmc", "arm,primecell";
-		reg = <0x30084000 0x1000>;
-		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
-		clock-names = "apb_pclk";
+		etf at 30084000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x30084000 0x1000>;
+			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
+			clock-names = "apb_pclk";
 
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
 
-			port at 0 {
-				reg = <0>;
-				etf_in_port: endpoint {
-					slave-mode;
-					remote-endpoint = <&hugo_funnel_out_port0>;
+				port at 0 {
+					reg = <0>;
+					etf_in_port: endpoint {
+						slave-mode;
+						remote-endpoint = <&hugo_funnel_out_port0>;
+					};
 				};
-			};
 
-			port at 1 {
-				reg = <0>;
-				etf_out_port: endpoint {
-					remote-endpoint = <&replicator_in_port0>;
+				port at 1 {
+					reg = <0>;
+					etf_out_port: endpoint {
+						remote-endpoint = <&replicator_in_port0>;
+					};
 				};
 			};
 		};
-	};
 
-	funnel at 30083000 {
-		compatible = "arm,coresight-funnel", "arm,primecell";
-		reg = <0x30083000 0x1000>;
-		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
-		clock-names = "apb_pclk";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
+		etr at 30086000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x30086000 0x1000>;
+			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
+			clock-names = "apb_pclk";
 
-			/* funnel input ports */
-			port at 0 {
-				reg = <0>;
-				hugo_funnel_in_port0: endpoint {
+			port {
+				etr_in_port: endpoint {
 					slave-mode;
-					remote-endpoint = <&ca_funnel_out_port0>;
+					remote-endpoint = <&replicator_out_port1>;
 				};
 			};
+		};
 
-			port at 1 {
-				reg = <1>;
-				hugo_funnel_in_port1: endpoint {
-					slave-mode; /* M4 input */
-				};
-			};
+		tpiu at 30087000 {
+			compatible = "arm,coresight-tpiu", "arm,primecell";
+			reg = <0x30087000 0x1000>;
+			clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
+			clock-names = "apb_pclk";
 
-			port at 2 {
-				reg = <0>;
-				hugo_funnel_out_port0: endpoint {
-					remote-endpoint = <&etf_in_port>;
+			port {
+				tpiu_in_port: endpoint {
+					slave-mode;
+					remote-endpoint = <&replicator_out_port1>;
 				};
 			};
-
-			/* the other input ports are not connect to anything */
 		};
-	};
 
-	funnel at 30041000 {
-		compatible = "arm,coresight-funnel", "arm,primecell";
-		reg = <0x30041000 0x1000>;
-		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
-		clock-names = "apb_pclk";
+		replicator {
+			/*
+			 * non-configurable replicators don't show up on the
+			 * AMBA bus.  As such no need to add "arm,primecell"
+			 */
+			compatible = "arm,coresight-replicator";
 
-		ca_funnel_ports: ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
 
-			/* funnel input ports */
-			port at 0 {
-				reg = <0>;
-				ca_funnel_in_port0: endpoint {
-					slave-mode;
-					remote-endpoint = <&etm0_out_port>;
+				/* replicator output ports */
+				port at 0 {
+					reg = <0>;
+					replicator_out_port0: endpoint {
+						remote-endpoint = <&tpiu_in_port>;
+					};
 				};
-			};
 
-			/* funnel output port */
-			port at 2 {
-				reg = <0>;
-				ca_funnel_out_port0: endpoint {
-					remote-endpoint = <&hugo_funnel_in_port0>;
+				port at 1 {
+					reg = <1>;
+					replicator_out_port1: endpoint {
+						remote-endpoint = <&etr_in_port>;
+					};
 				};
-			};
 
-			/* the other input ports are not connect to anything */
+				/* replicator input port */
+				port at 2 {
+					reg = <0>;
+					replicator_in_port0: endpoint {
+						slave-mode;
+						remote-endpoint = <&etf_out_port>;
+					};
+				};
+			};
 		};
-	};
 
-	etm at 3007c000 {
-		compatible = "arm,coresight-etm3x", "arm,primecell";
-		reg = <0x3007c000 0x1000>;
-		cpu = <&cpu0>;
-		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
-		clock-names = "apb_pclk";
-
-		port {
-			etm0_out_port: endpoint {
-				remote-endpoint = <&ca_funnel_in_port0>;
-			};
+		intc: interrupt-controller at 31001000 {
+			compatible = "arm,cortex-a7-gic";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x31001000 0x1000>,
+			      <0x31002000 0x1000>,
+			      <0x31004000 0x2000>,
+			      <0x31006000 0x2000>;
 		};
-	};
 
-	soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "simple-bus";
-		interrupt-parent = <&intc>;
-		ranges;
+		timer {
+			compatible = "arm,armv7-timer";
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		};
 
 		aips1: aips-bus at 30000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
-- 
2.9.0
