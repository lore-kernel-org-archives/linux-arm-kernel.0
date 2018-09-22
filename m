From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Sat, 22 Sep 2018 19:11:48 +0530
Subject: [RFC PATCH v3 2/3] dt-bindings: fpga: Add bindings for ZynqMP nvmem
 driver
In-Reply-To: <20180922134149.5693-1-nava.manne@xilinx.com>
References: <20180922134149.5693-1-nava.manne@xilinx.com>
Message-ID: <20180922134149.5693-3-nava.manne@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation to describe Xilinx ZynqMP nvmem driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v3:
		-None.
Changes for v2:
                -Moved nvmem_firmware node as a child to
                 firwmare node.

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9bbe44..4b95fcc4dcb3 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -17,6 +17,19 @@ Required properties:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
 
+--------------------------------------------------------------------------
+=  Zynq UltraScale+ MPSoC nvmem firmware driver binding =
+--------------------------------------------------------------------------
+The nvmem_firmware node provides access to the hardware related data
+like soc revision, IDCODE... etc, By using the firmware interface.
+
+Required properties:
+- compatible: should be "xlnx,zynqmp-nvmem-fw"
+
+= Data cells =
+Are child nodes of silicon id, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
 -------
 Example
 -------
@@ -25,5 +38,27 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		nvmem_firmware {
+			compatible = "xlnx,zynqmp-nvmem-fw";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			/* Data cells */
+			soc_revision: soc_revision {
+				reg = <0x0 0x4>;
+			};
+		};
 	};
 };
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+For example:
+
+	pcap {
+		...
+		nvmem-cells = <&soc_revision>;
+		nvmem-cell-names = "soc_revision";
+	};
+
-- 
2.18.0
