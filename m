From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Tue, 12 Jan 2016 10:56:38 +0530
Subject: [PATCH 4/5] PCI: xilinx: Updating Zynq PCI binding documentation with
 Microblaze node.
In-Reply-To: <1452576399-1513-1-git-send-email-bharatku@xilinx.com>
References: <1452576399-1513-1-git-send-email-bharatku@xilinx.com>
Message-ID: <1452576399-1513-5-git-send-email-bharatku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updated Zynq PCI binding documentation with Microblaze node.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
---
Changes:
Adding Microblaze device tree node Documnetation.
---
 .../devicetree/bindings/pci/xilinx-pcie.txt        | 36 ++++++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-pcie.txt b/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
index 02f979a..d207bf4 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/xilinx-pcie.txt
@@ -17,7 +17,10 @@ Required properties:
 	Please refer to the standard PCI bus binding document for a more
 	detailed explanation
 
-Optional properties:
+Optional properties for Zynq:
+- bus-range: PCI bus numbers covered
+
+Required property for Microblaze:
 - bus-range: PCI bus numbers covered
 
 Interrupt controller child node
@@ -38,13 +41,13 @@ the four INTx interrupts in ISR and route them to this domain.
 
 Example:
 ++++++++
-
+Zynq:
 	pci_express: axi-pcie at 50000000 {
 		#address-cells = <3>;
 		#size-cells = <2>;
 		#interrupt-cells = <1>;
 		compatible = "xlnx,axi-pcie-host-1.00.a";
-		reg = < 0x50000000 0x10000000 >;
+		reg = < 0x50000000 0x1000000 >;
 		device_type = "pci";
 		interrupts = < 0 52 4 >;
 		interrupt-map-mask = <0 0 0 7>;
@@ -60,3 +63,30 @@ Example:
 			#interrupt-cells = <1>;
 		};
 	};
+
+
+Microblaze:
+	pci_express: axi-pcie at 10000000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		compatible = "xlnx,axi-pcie-host-1.00.a";
+		reg = <0x10000000 0x4000000>;
+		device_type = "pci";
+		interrupt-parent = <&microbalze_0_intc>;
+		interrupts = <1 2>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie_intc 1>,
+				<0 0 0 2 &pcie_intc 2>,
+				<0 0 0 3 &pcie_intc 3>,
+				<0 0 0 4 &pcie_intc 4>;
+		ranges = <0x02000000 0x00000000 0x80000000 0x80000000 0x00000000 0x10000000>;
+		bus-range = <0x00 0xff>;
+
+		pcie_intc: interrupt-controller {
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+		};
+
+	};
-- 
2.1.1
