From: atull@opensource.altera.com (Alan Tull)
Date: Tue, 12 Jul 2016 14:36:41 -0500
Subject: [PATCH v18 2/6] ARM: socfpga: add bindings document for fpga bridge
 drivers
In-Reply-To: <20160712193645.9098-1-atull@opensource.altera.com>
References: <20160712193645.9098-1-atull@opensource.altera.com>
Message-ID: <20160712193645.9098-3-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings documentation for Altera SOCFPGA bridges:
 * fpga2sdram
 * fpga2hps
 * hps2fpga
 * lwhps2fpga

Signed-off-by: Alan Tull <atull@opensource.altera.com>
Signed-off-by: Matthew Gerlach <mgerlach@altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
v2:  separate into 2 documents for the 2 drivers
v12: bump version to line up with simple-fpga-bus version
     remove Linux specific notes such as references to sysfs
     move non-DT specific documentation elsewhere
     remove bindings that would have been used to pass configuration
     clean up formatting
v13: Remove 'label' property
     Change property from init-val to bridge-enable
     Fix email address
v14: Add resets
     Change order of bridges to put lw bridge (controlling bridge) first
v15: No change in this patch for v15 of this patch set
v16: Added regs property, cleaned up unit addresses
v17: No change to this patch in v17 of patch set
v18: Changed to not need reset-names property
     node names as fpga-bridge at ...
     labels as fpga_bridge
     Add address of fpgaportrst to give and address for f2s bridge
---
 .../bindings/fpga/altera-fpga2sdram-bridge.txt     | 16 +++++++++
 .../bindings/fpga/altera-hps2fpga-bridge.txt       | 39 ++++++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt

diff --git a/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
new file mode 100644
index 0000000..817a8d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
@@ -0,0 +1,16 @@
+Altera FPGA To SDRAM Bridge Driver
+
+Required properties:
+- compatible		: Should contain "altr,socfpga-fpga2sdram-bridge"
+
+Optional properties:
+- bridge-enable		: 0 if driver should disable bridge at startup
+			  1 if driver should enable bridge at startup
+			  Default is to leave bridge in current state.
+
+Example:
+	fpga_bridge3: fpga-bridge at ffc25080 {
+		compatible = "altr,socfpga-fpga2sdram-bridge";
+		reg = <0xffc25080 0x4>;
+		bridge-enable = <0>;
+	};
diff --git a/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
new file mode 100644
index 0000000..6406f93
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
@@ -0,0 +1,39 @@
+Altera FPGA/HPS Bridge Driver
+
+Required properties:
+- regs		: base address and size for AXI bridge module
+- compatible	: Should contain one of:
+		  "altr,socfpga-lwhps2fpga-bridge",
+		  "altr,socfpga-hps2fpga-bridge", or
+		  "altr,socfpga-fpga2hps-bridge"
+- resets	: Phandle and reset specifier for this bridge's reset
+- clocks	: Clocks used by this module.
+
+Optional properties:
+- bridge-enable	: 0 if driver should disable bridge at startup.
+		  1 if driver should enable bridge at startup.
+		  Default is to leave bridge in its current state.
+
+Example:
+	fpga_bridge0: fpga-bridge at ff400000 {
+		compatible = "altr,socfpga-lwhps2fpga-bridge";
+		reg = <0xff400000 0x100000>;
+		resets = <&rst LWHPS2FPGA_RESET>;
+		clocks = <&l4_main_clk>;
+		bridge-enable = <0>;
+	};
+
+	fpga_bridge1: fpga-bridge at ff500000 {
+		compatible = "altr,socfpga-hps2fpga-bridge";
+		reg = <0xff500000 0x10000>;
+		resets = <&rst HPS2FPGA_RESET>;
+		clocks = <&l4_main_clk>;
+		bridge-enable = <1>;
+	};
+
+	fpga_bridge2: fpga-bridge at ff600000 {
+		compatible = "altr,socfpga-fpga2hps-bridge";
+		reg = <0xff600000 0x100000>;
+		resets = <&rst FPGA2HPS_RESET>;
+		clocks = <&l4_main_clk>;
+	};
-- 
2.9.1
