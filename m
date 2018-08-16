From: jolly.shah@xilinx.com (Jolly Shah)
Date: Thu, 16 Aug 2018 12:21:42 -0700
Subject: [PATCH v2 1/3] dt-bindings: power: Add ZynqMP power domain bindings
In-Reply-To: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
References: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
Message-ID: <1534447304-12919-2-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Add documentation to describe ZynqMP power domain bindings.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index d215d15..5fa10a0 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -64,6 +64,29 @@ Output clocks are registered based on clock information received
 from firmware. Output clocks indexes are mentioned in
 include/dt-bindings/clock/xlnx,zynqmp-clk.h.
 
+-----------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
+-----------------------------------------------------------
+The binding for zynqmp-power-controller follow the common
+generic PM domain binding[1].
+
+[1] Documentation/devicetree/bindings/power/power_domain.txt
+
+== Zynq MPSoC Generic PM Domain Node ==
+
+Required properties:
+ - compatible:	Must be: "xlnx,zynqmp-power-controller"
+
+This node contains a number of subnodes, each representing a single PM domain
+that PM domain consumer devices reference.
+
+== PM Domain Nodes ==
+
+Required properties:
+ - #power-domain-cells:	Number of cells in a PM domain specifier. Must be 0.
+ - pd-id:		Domain identifier as defined by platform firmware.
+			This identifier is passed to the PM firmware.
+
 -------
 Example
 -------
@@ -78,5 +101,29 @@ firmware {
 			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
 			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
 		};
+		zynqmp-power-controller {
+			compatible = "xlnx,zynqmp-power-controller";
+
+			pd_usb0: pd-usb0 {
+				pd-id = <22>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_sata: pd-sata {
+				pd-id = <28>;
+				#power-domain-cells = <0>;
+			};
+
+			pd_gpu : pd-gpu {
+				pd-id = <58 20 21>;
+				#power-domain-cells = <0>;
+			};
+		};
 	};
 };
+
+sata0: ahci at SATA_AHCI_HBA {
+	...
+	power-domains = <&pd_sata>;
+	...
+};
-- 
2.7.4
