From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 4 Jan 2018 17:41:01 +0800
Subject: [PATCH 11/12] arm64: dts: mt7622: add PCIe device nodes
In-Reply-To: <cover.1515057696.git.sean.wang@mediatek.com>
References: <cover.1515057696.git.sean.wang@mediatek.com>
Message-ID: <20a5d83c732226efca9f0672523adc7e8347e333.1515057696.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryder Lee <ryder.lee@mediatek.com>

This patch adds PCIe support fot MT7622.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 10 ++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 76 ++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index d4609a1..53d4efd 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -54,6 +54,16 @@
 	};
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_pins>;
+	status = "okay";
+
+	pcie at 0,0 {
+		status = "okay";
+	};
+};
+
 &pio {
 	/* eMMC is shared pin with parallel NAND */
 	emmc_pins_default: emmc-pins-default {
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 04a047e..2801b7d 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -469,6 +469,82 @@
 		#reset-cells = <1>;
 	};
 
+	pcie: pcie at 1a140000 {
+		compatible = "mediatek,mt7622-pcie";
+		device_type = "pci";
+		reg = <0 0x1a140000 0 0x1000>,
+		      <0 0x1a143000 0 0x1000>,
+		      <0 0x1a145000 0 0x1000>;
+		reg-names = "subsys", "port0", "port1";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pciesys CLK_PCIE_P0_MAC_EN>,
+			 <&pciesys CLK_PCIE_P1_MAC_EN>,
+			 <&pciesys CLK_PCIE_P0_AHB_EN>,
+			 <&pciesys CLK_PCIE_P0_AHB_EN>,
+			 <&pciesys CLK_PCIE_P0_AUX_EN>,
+			 <&pciesys CLK_PCIE_P1_AUX_EN>,
+			 <&pciesys CLK_PCIE_P0_AXI_EN>,
+			 <&pciesys CLK_PCIE_P1_AXI_EN>,
+			 <&pciesys CLK_PCIE_P0_OBFF_EN>,
+			 <&pciesys CLK_PCIE_P1_OBFF_EN>,
+			 <&pciesys CLK_PCIE_P0_PIPE_EN>,
+			 <&pciesys CLK_PCIE_P1_PIPE_EN>;
+		clock-names = "sys_ck0", "sys_ck1", "ahb_ck0", "ahb_ck1",
+			      "aux_ck0", "aux_ck1", "axi_ck0", "axi_ck1",
+			      "obff_ck0", "obff_ck1", "pipe_ck0", "pipe_ck1";
+		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
+		bus-range = <0x00 0xff>;
+		ranges = <0x82000000 0 0x20000000 0x0 0x20000000 0 0x10000000>;
+		status = "disabled";
+
+		pcie0: pcie at 0,0 {
+			device_type = "pci";
+			reg = <0x0000 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			num-lanes = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
+					<0 0 0 2 &pcie_intc0 1>,
+					<0 0 0 3 &pcie_intc0 2>,
+					<0 0 0 4 &pcie_intc0 3>;
+			pcie_intc0: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		pcie1: pcie at 1,0 {
+			device_type = "pci";
+			reg = <0x0800 0 0 0 0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			num-lanes = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
+					<0 0 0 2 &pcie_intc1 1>,
+					<0 0 0 3 &pcie_intc1 2>,
+					<0 0 0 4 &pcie_intc1 3>;
+			pcie_intc1: interrupt-controller {
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+
 	ethsys: syscon at 1b000000 {
 		compatible = "mediatek,mt7622-ethsys",
 			     "syscon";
-- 
2.7.4
