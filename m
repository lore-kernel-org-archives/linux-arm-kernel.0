From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 6 Apr 2018 23:18:06 +0300
Subject: [PATCH 2/3] arm64: dts: renesas: r8a77980: add PCIEC support
In-Reply-To: <f07e6173-75b3-fe10-81d6-915942a5f4fe@cogentembedded.com>
References: <f07e6173-75b3-fe10-81d6-915942a5f4fe@cogentembedded.com>
Message-ID: <463a1435-4d94-97be-4f63-da2cb0871d91@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe PCIEC and PCIe bus clock in the R8A77980 device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77980.dtsi |   39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -51,6 +51,13 @@
 		clock-frequency = <0>;
 	};
 
+	/* External PCIe clock - can be overridden by the board */
+	pcie_bus_clk: pcie_bus {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
@@ -376,6 +383,38 @@
 			resets = <&cpg 408>;
 		};
 
+		pciec: pcie at fe000000 {
+			compatible = "renesas,pcie-r8a77980",
+				     "renesas,pcie-rcar-gen3";
+			reg = <0 0xfe000000 0 0x80000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x00 0xff>;
+			device_type = "pci";
+			ranges = <
+				0x01000000 0 0x00000000 0 0xfe100000 0 0x0100000
+				0x02000000 0 0xfe200000 0 0xfe200000 0 0x0200000
+				0x02000000 0 0x30000000 0 0x30000000 0 0x8000000
+				0x42000000 0 0x38000000 0 0x38000000 0 0x8000000
+			>;
+			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000
+				      0 0x80000000>;
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 148
+					 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
+			clock-names = "pcie", "pcie_bus";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 319>;
+			phys = <&pcie_phy>;
+			phy-names = "pcie";
+			status = "disabled";
+		};
+
 		prr: chipid at fff00044 {
 			compatible = "renesas,prr";
 			reg = <0 0xfff00044 0 4>;
