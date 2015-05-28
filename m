From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Fri, 29 May 2015 05:10:32 +0800
Subject: [PATCH 1/1] ARM: dts: imx7d: add cortex-a7 coresignt component
Message-ID: <1432847432-30133-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Added etm, etb, funnel and replicator

usage example:

    echo 1 >/sys/bus/coresight/devices/30086000.etr/enable_sink
    echo 1 >/sys/bus/coresight/devices/3007c000.etm/enable_source

        coresight-tmc 30086000.etr: TMC enabled
        coresight-replicator replicator.1: REPLICATOR enabled
        coresight-tmc 30084000.tmc: TMC enabled
        coresight-funnel 30083000.funnel: FUNNEL inport 0 enabled
        coresight-funnel 30041000.funnel: FUNNEL inport 0 enabled
        coresight-etm3x 3007c000.etm: ETM tracing enabled

    etm enable here.
    trace data save at /dev/30086000.etr

    cat /dev/30086000.etr > trace.data

        coresight-tmc 30086000.etr: TMC read start
        coresight-tmc 30086000.etr: TMC read end

    use ptm2human(https://github.com/hwangcc23/ptm2human) to show trace data

    ptm2human -i trace.data

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 194 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index b4cd8fd..5347f05 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -121,6 +121,200 @@
 		clock-output-names = "osc";
 	};
 
+	etr at 0,30086000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0x30086000 0x1000>;
+
+		coresight-default-sink;
+		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
+		clock-names = "apb_pclk";
+
+		port {
+			etr_in_port: endpoint {
+				slave-mode;
+				remote-endpoint = <&replicator_out_port1>;
+			};
+		};
+	};
+
+	tpiu at 0,30087000 {
+		compatible = "arm,coresight-tpiu", "arm,primecell";
+		reg = <0x30087000 0x1000>;
+
+		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
+		clock-names = "apb_pclk";
+		port {
+			tpiu_in_port: endpoint at 0 {
+				slave-mode;
+				remote-endpoint = <&replicator_out_port1>;
+			};
+		};
+	};
+
+	replicator {
+		/* non-configurable replicators don't show up on the
+		 * AMBA bus.  As such no need to add "arm,primecell"
+		 */
+		compatible = "arm,coresight-replicator";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* replicator output ports */
+			port at 0 {
+				reg = <0>;
+				replicator_out_port0: endpoint {
+					remote-endpoint = <&tpiu_in_port>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				replicator_out_port1: endpoint {
+					remote-endpoint = <&etr_in_port>;
+				};
+			};
+
+			/* replicator input port */
+			port at 2 {
+				reg = <0>;
+				replicator_in_port0: endpoint {
+					slave-mode;
+					remote-endpoint = <&etf_out_port>;
+				};
+			};
+		};
+	};
+
+	etf at 0,30084000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0x30084000 0x1000>;
+		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
+		clock-names = "apb_pclk";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				etf_in_port: endpoint {
+					slave-mode;
+					remote-endpoint = <&hugo_funnel_out_port0>;
+				};
+			};
+
+			port at 1 {
+				reg = <0>;
+				etf_out_port: endpoint {
+					remote-endpoint = <&replicator_in_port0>;
+				};
+			};
+		};
+	};
+
+	funnel at 1,30083000 {
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0x30083000 0x1000>;
+		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
+		clock-names = "apb_pclk";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* funnel input ports */
+			port at 0 {
+				reg = <0>;
+				hugo_funnel_in_port0: endpoint {
+					slave-mode;
+					remote-endpoint = <&ca_funnel_out_port0>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				hugo_funnel_in_port1: endpoint {
+					slave-mode; /* M4 input */
+				};
+			};
+
+			port at 2 {
+				reg = <0>;
+				hugo_funnel_out_port0: endpoint {
+					remote-endpoint = <&etf_in_port>;
+				};
+			};
+		};
+	};
+
+	funnel at 0,30041000 {
+		compatible = "arm,coresight-funnel", "arm,primecell";
+		reg = <0x30041000 0x1000>;
+		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
+		clock-names = "apb_pclk";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* funnel input ports */
+			port at 0 {
+				reg = <0>;
+				ca_funnel_in_port0: endpoint {
+					slave-mode;
+					remote-endpoint = <&etm0_out_port>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				ca_funnel_in_port1: endpoint {
+					slave-mode;
+					remote-endpoint = <&etm1_out_port>;
+				};
+			};
+
+			/* funnel output port */
+			port at 2 {
+				reg = <0>;
+				ca_funnel_out_port0: endpoint {
+					remote-endpoint = <&hugo_funnel_in_port0>;
+				};
+			};
+		};
+	};
+
+	etm at 0,3007c000 {
+		compatible = "arm,coresight-etm3x", "arm,primecell";
+		reg = <0x3007c000 0x1000>;
+		cpu = <&cpu0>;
+		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
+		clock-names = "apb_pclk";
+
+		port {
+			etm0_out_port: endpoint {
+				remote-endpoint = <&ca_funnel_in_port0>;
+			};
+		};
+	};
+
+	etm at 1,3007d000 {
+		compatible = "arm,coresight-etm3x", "arm,primecell";
+		reg = <0x3007d000 0x1000>;
+		arm,primecell-periphid =  <0xbb956>;
+		cpu = <&cpu1>;
+		clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
+		clock-names = "apb_pclk";
+
+		port {
+			etm1_out_port: endpoint {
+				remote-endpoint = <&ca_funnel_in_port1>;
+			};
+		};
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.9.1
