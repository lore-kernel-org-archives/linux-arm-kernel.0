From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  6 Dec 2017 11:22:34 +0100
Subject: [PATCH 39/61] ARM: dts: r8a7743: Add PCIe Controller device node
In-Reply-To: <cover.1512555546.git.horms+renesas@verge.net.au>
References: <cover.1512555546.git.horms+renesas@verge.net.au>
Message-ID: <4c5c952e61190e5a0e06128156eef84d290a0045.1512555546.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index de4b8c64d56b..9e26c40976ff 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1164,6 +1164,34 @@
 				phy-names = "usb";
 			};
 		};
+
+		pciec: pcie at fe000000 {
+			compatible = "renesas,pcie-r8a7743",
+				     "renesas,pcie-rcar-gen2";
+			reg = <0 0xfe000000 0 0x80000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x00 0xff>;
+			device_type = "pci";
+			ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
+				  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
+				  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
+				  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
+			/* Map all possible DDR as inbound ranges */
+			dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000
+				      0x43000000 2 0x00000000 2 0x00000000 1 0x00000000>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
+			clock-names = "pcie", "pcie_bus";
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 319>;
+			status = "disabled";
+		};
 	};
 
 	/* External root clock */
-- 
2.11.0
