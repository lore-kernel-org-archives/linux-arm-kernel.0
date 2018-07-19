From: manish.narani@xilinx.com (Manish Narani)
Date: Thu, 19 Jul 2018 15:35:45 +0530
Subject: [PATCH 2/4] dt: bindings: Document ZynqMP DDRC in Synopsys
 documentation
In-Reply-To: <1531994747-15196-1-git-send-email-manish.narani@xilinx.com>
References: <1531994747-15196-1-git-send-email-manish.narani@xilinx.com>
Message-ID: <1531994747-15196-3-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch documents Synopsys EDAC driver which reports the single bit
errors that are corrected and the double bit errors that are detected.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../bindings/memory-controllers/synopsys.txt       | 25 ++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
index a43d26d..5d20b76 100644
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys.txt
@@ -1,15 +1,32 @@
 Binding for Synopsys IntelliDDR Multi Protocol Memory Controller
 
-This controller has an optional ECC support in half-bus width (16-bit)
-configuration. The ECC controller corrects one bit error and detects
+Synopsys EDAC driver, it does reports the DDR ECC single bit errors
+that are corrected and double bit ecc errors that are detected by the DDR
+ECC controller.
+
+The Zynq DDR ECC controller has an optional ECC support in half-bus width
+(16-bit) configuration. The ECC controller corrects one bit error and detects
 two bit errors.
 
 Required properties:
- - compatible: Should be 'xlnx,zynq-ddrc-a05'
- - reg: Base address and size of the controllers memory area
+ - compatible: One of:
+	- 'xlnx,zynq-ddrc-a05' : Zynq DDR ECC controller
+	- 'xlnx,zynqmp-ddrc-2.40a' : ZynqMP DDR ECC controller
+ - reg: Should contain DDR controller registers location and length.
+
+Required properties for "xlnx,zynqmp-ddrc-2.40a":
+ - interrupt-parent: Should be core interrupt controller.
+ - interrupts: Property with a value describing the interrupt number.
 
 Example:
 	memory-controller at f8006000 {
 		compatible = "xlnx,zynq-ddrc-a05";
 		reg = <0xf8006000 0x1000>;
 	};
+
+	mc: memory-controller at fd070000 {
+		compatible = "xlnx,zynqmp-ddrc-2.40a";
+		reg = <0x0 0xfd070000 0x0 0x30000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 112 4>;
+	};
-- 
2.1.1
