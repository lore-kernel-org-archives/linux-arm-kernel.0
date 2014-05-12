From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Mon, 12 May 2014 11:57:50 +0100
Subject: [PATCH v8 3/3] dt-bindings: pci: rcar pcie device tree bindings
In-Reply-To: <1399892270-25021-1-git-send-email-phil.edworthy@renesas.com>
References: <1399892270-25021-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1399892270-25021-4-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the bindings for the R-Car PCIe driver. The driver
resides under drivers/pci/host/pcie-rcar.c

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

v8:
 - Split interrupt bindings into separate cells
 - Add explicit bus number range

v7:
 - Change binding description of clocks to 'clock specifiers'

v6:
 - Correct DT bindings description for reg and clocks

v5:
 - Add PCIe bus clock reference
 - Add additional interrupt bindings
 - Use dma-ranges property to specify inbound memory regions

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
new file mode 100644
index 0000000..29d3b98
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -0,0 +1,47 @@
+* Renesas RCar PCIe interface
+
+Required properties:
+- compatible: should contain one of the following
+	"renesas,pcie-r8a7779", "renesas,pcie-r8a7790", "renesas,pcie-r8a7791"
+- reg: base address and length of the pcie controller registers.
+- #address-cells: set to <3>
+- #size-cells: set to <2>
+- bus-range: PCI bus numbers covered
+- device_type: set to "pci"
+- ranges: ranges for the PCI memory and I/O regions.
+- dma-ranges: ranges for the inbound memory regions.
+- interrupts: two interrupt sources for MSI interrupts, followed by interrupt
+	source for hardware related interrupts (e.g. link speed change).
+- #interrupt-cells: set to <1>
+- interrupt-map-mask and interrupt-map: standard PCI properties
+	to define the mapping of the PCIe interface to interrupt
+	numbers.
+- clocks: from common clock binding: clock specifiers for the PCIe controller
+	and PCIe bus clocks.
+- clock-names: from common clock binding: should be "pcie" and "pcie_bus".
+
+Example:
+
+SoC specific DT Entry:
+
+	pcie: pcie at fe000000 {
+		compatible = "renesas,pcie-r8a7791";
+		reg = <0 0xfe000000 0 0x80000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x00 0xff>;
+		device_type = "pci";
+		ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
+			  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
+			  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
+			  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
+		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000
+			      0x42000000 2 0x00000000 2 0x00000000 0 0x40000000>;
+		interrupts = <0 116 4>, <0 117 4>, <0 118 4>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic 0 116 4>;
+		clocks = <&mstp3_clks R8A7791_CLK_PCIE>, <&pcie_bus_clk>;
+		clock-names = "pcie", "pcie_bus";
+		status = "disabled";
+	};
-- 
1.9.1
