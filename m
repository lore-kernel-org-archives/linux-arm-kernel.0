From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 11 Dec 2014 21:21:40 +0100
Subject: [RFC 1/3] devicetree: bindings: Add SoCFpga HPS bridges
In-Reply-To: <1418329302-20813-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1418329302-20813-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1418329302-20813-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From the datasheet:

	The HPS-FPGA bridges allow masters in the FPGA fabric to
	communicate with slaves in the HPS logic and vice versa.
	For example, you can instantiate additional memories or
	peripherals in the FPGA fabric, and master interfaces
	belonging to components in the HPS logic can access them.
	You can also instantiate components such as a NiosII
	processor in the FPGA fabric and their master interfaces
	can access memories or peripherals in the HPS logic

This patch adds bindings for the three bridges on SoCFPGA:
	- hps2fpga (buswidths: 32, 64, 128 bits)
	- fpga2hps (buswidths: 32, 64, 128 bits)
	- lwhps2fpga (buswidth: 32 bits)

Two of the bridges have a configurable buswidth (via bitstream).
The bridges depend on the L3 NIC to be able to set bus visibility.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 .../soc/socfpga/altr,fpga2hps-axi-bridge.txt       | 32 +++++++++++++
 .../soc/socfpga/altr,hps2fpga-axi-bridge.txt       | 54 ++++++++++++++++++++++
 .../soc/socfpga/altr,lwhps2fpga-axi-bridge.txt     | 31 +++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/socfpga/altr,fpga2hps-axi-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/soc/socfpga/altr,hps2fpga-axi-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/soc/socfpga/altr,lwhps2fpga-axi-bridge.txt

diff --git a/Documentation/devicetree/bindings/soc/socfpga/altr,fpga2hps-axi-bridge.txt b/Documentation/devicetree/bindings/soc/socfpga/altr,fpga2hps-axi-bridge.txt
new file mode 100644
index 000000000000..0df0cfbe350d
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socfpga/altr,fpga2hps-axi-bridge.txt
@@ -0,0 +1,32 @@
+Altera SoCFPGA FPGA2HPS AXI Bridge
+----------------------------------
+
+Required properties:
+  - compatible : "altr,fpga2hps-axi-bridge"
+  - reg : Must contain one range:
+    - the register space for the bridge module configuration
+  - resets : The reset line for the module
+  - reset-names : Must include "fpga2hps"
+  - bus-width : the configured bus width of the bridge
+    - allowed values : 32, 64, 128
+
+Optional properties:
+  - altr,bridge-gpv : a pointer to the GPV master for configuration purposes
+  - fpgamgr : A pointer to the FPGA-Manager. This is needed, if the FPGA
+	      needs to be loaded before the bridges can be enabled.
+
+Example:
+
+	fpga2hps: axibridge at ff600000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "altr,fpga2hps-axi-bridge", "simple-bus";
+		reg = <0xff600000 0x100000>;
+		clocks = <&l4_mp_clk>, <&l3_main_clk>;
+		clock-names = "gpv_clk", "data_clk";
+		resets = <&rst FPGA2HPS_RESET>;
+		reset-names = "fpga2hps";
+		altr,bridge-gpv = <&lwhps2fpga>;
+		bus-width = <64>;
+		status = "disabled";
+	};
diff --git a/Documentation/devicetree/bindings/soc/socfpga/altr,hps2fpga-axi-bridge.txt b/Documentation/devicetree/bindings/soc/socfpga/altr,hps2fpga-axi-bridge.txt
new file mode 100644
index 000000000000..e5230639e5e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socfpga/altr,hps2fpga-axi-bridge.txt
@@ -0,0 +1,54 @@
+Altera SoCFPGA HPS2FPGA AXI Bridge
+----------------------------------
+
+Required properties:
+  - compatible : "altr,hps2fpga-axi-bridge"
+  - reg : Must contain two ranges:
+	1. the register space for the bridge module configuration
+	2. the address space for the bridge domain
+  - reg-names : Must include the entries:
+	"data" : Address space
+	"gpv" : Global Programmers View registers
+  - resets : The reset line for the module
+  - reset-names : Must include "hps2fpga"
+  - altr,l3-gpv : a pointer to the L3 NIC used for configuration
+  - bus-width : the configured bus width of the bridge
+    - allowed values : 32, 64, 128
+
+Optional properties:
+  - altr,bridge-gpv : a pointer to the bridge GPV master for configuration
+  - fpgamgr : A pointer to the FPGA-Manager. This is needed, if the FPGA
+	      needs to be loaded before the bridges can be enabled.
+
+Example:
+
+	hps2fpga: axibridge at ff500000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "altr,hps2fpga-axi-bridge";
+		reg = <0xff500000 0x100000>,
+		      <0xc0000000 0x3c000000>;
+		clocks = <&l4_mp_clk>, <&l3_main_clk>;
+		clock-names = "gpv_clk", "data_clk";
+		resets = <&rst HPS2FPGA_RESET>;
+		reset-names = "hps2fpga";
+		altr,gpv-master = <&lwhps2fpga>;
+		altr,l3-gpv = <&l3regs>;
+		bus-width = <64>;
+		status = "disabled";
+		ranges;
+	};
+
+Board file example:
+
+	&hps2fpga {
+		bus-width = <32>;
+		status = "okay";
+
+		axi-ip: axi-ip at c0000000 {
+			compatible = "axi-ip";
+			reg = <0xc0000000 0x10000>;
+			clocks = <&h2f_usr2_clk>;
+			status = "okay";
+		};
+	};
diff --git a/Documentation/devicetree/bindings/soc/socfpga/altr,lwhps2fpga-axi-bridge.txt b/Documentation/devicetree/bindings/soc/socfpga/altr,lwhps2fpga-axi-bridge.txt
new file mode 100644
index 000000000000..e5664792a6f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/socfpga/altr,lwhps2fpga-axi-bridge.txt
@@ -0,0 +1,31 @@
+Altera SoCFPGA LWHPS2FPGA AXI Bridge
+------------------------------------
+
+Required properties:
+  - compatible : "altr,lwhps2fpga-axi-bridge"
+  - reg : Must contain two ranges:
+	1. the register space for the bridge module configuration
+	2. the address space for the bridge domain
+  - resets : The reset line for the module
+  - reset-names : Must include "lwhps2fpga"
+  - altr,l3-gpv : A pointer to the L3 NIC used for configuration
+Optional properties:
+  - fpgamgr : A pointer to the FPGA-Manager. This is needed, if the
+	      FPGA needs to be loaded before the bridges can be
+	      enabled.
+
+Example:
+
+	lwhps2fpga: axibridge at ff400000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "altr,lwhps2fpga-axi-bridge", "simple-bus";
+		reg = <0xff400000 0x100000>,
+		      <0xff200000 0x200000>;
+		clocks = <&l4_mp_clk>;
+		resets = <&rst LWHPS2FPGA_RESET>;
+		reset-names = "lwhps2fpga";
+		altr,l3-gpv = <&l3regs>;
+		status = "disabled";
+		ranges;
+	};
-- 
2.1.3
