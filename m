From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 14 Jun 2018 22:17:46 +0300
Subject: [PATCH v2 1/2] arm64: dts: renesas: r8a77980: add PCIe support
In-Reply-To: <b37d458c-071a-833a-2057-be8a07c880be@cogentembedded.com>
References: <b37d458c-071a-833a-2057-be8a07c880be@cogentembedded.com>
Message-ID: <7e8c70ae-5c85-1e73-1be9-a40901a345f0@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the PCIe PHY, PCIEC, and PCIe bus clock in the R8A77980 device
tree.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- merged in the PCIEC patch, renamed the patch, updated the description
  accordingly;
- used R8A77980_PD_ALWAYS_ON in the "power-domains" props
- mentioned Vladimir's original work and added his signoff.

 arch/arm64/boot/dts/renesas/r8a77980.dtsi |   49 ++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -98,6 +98,13 @@
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
@@ -402,6 +409,16 @@
 			status = "disabled";
 		};
 
+		pcie_phy: pcie-phy at e65d0000 {
+			compatible = "renesas,r8a77980-pcie-phy";
+			reg = <0 0xe65d0000 0 0x8000>;
+			#phy-cells = <0>;
+			clocks = <&cpg CPG_MOD 319>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 319>;
+			status = "disabled";
+		};
+
 		canfd: can at e66c0000 {
 			compatible = "renesas,r8a77980-canfd",
 				     "renesas,rcar-gen3-canfd";
@@ -653,6 +670,38 @@
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
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 319>;
+			phys = <&pcie_phy>;
+			phy-names = "pcie";
+			status = "disabled";
+		};
+
 		vspd0: vsp at fea20000 {
 			compatible = "renesas,vsp2";
 			reg = <0 0xfea20000 0 0x5000>;
