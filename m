From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Tue, 6 Feb 2018 17:53:01 +0800
Subject: [PATCH v2 12/16] arm64: dts: mt7622: add SATA device nodes
In-Reply-To: <cover.1517910489.git.sean.wang@mediatek.com>
References: <cover.1517910489.git.sean.wang@mediatek.com>
Message-ID: <3d66224f4423d8bf9d3c5dc12763c489fea05c41.1517910489.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryder Lee <ryder.lee@mediatek.com>

This patch adds SATA support fot MT7622.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts |  8 ++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 40 ++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 1007932..87b6080 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -323,6 +323,14 @@
 	status = "okay";
 };
 
+&sata {
+	status = "okay";
+};
+
+&sata_phy {
+	status = "okay";
+};
+
 &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spic0_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index f0f18b3..d5ca0a8 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/mt7622-clk.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/power/mt7622-power.h>
 #include <dt-bindings/reset/mt7622-reset.h>
 
@@ -543,6 +544,45 @@
 		};
 	};
 
+	sata: sata at 1a200000 {
+		compatible = "mediatek,mt7622-ahci",
+			     "mediatek,mtk-ahci";
+		reg = <0 0x1a200000 0 0x1100>;
+		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "hostc";
+		clocks = <&pciesys CLK_SATA_AHB_EN>,
+			 <&pciesys CLK_SATA_AXI_EN>,
+			 <&pciesys CLK_SATA_ASIC_EN>,
+			 <&pciesys CLK_SATA_RBC_EN>,
+			 <&pciesys CLK_SATA_PM_EN>;
+		clock-names = "ahb", "axi", "asic", "rbc", "pm";
+		phys = <&sata_port PHY_TYPE_SATA>;
+		phy-names = "sata-phy";
+		ports-implemented = <0x1>;
+		power-domains = <&scpsys MT7622_POWER_DOMAIN_HIF0>;
+		resets = <&pciesys MT7622_SATA_AXI_BUS_RST>,
+			 <&pciesys MT7622_SATA_PHY_SW_RST>,
+			 <&pciesys MT7622_SATA_PHY_REG_RST>;
+		reset-names = "axi", "sw", "reg";
+		mediatek,phy-mode = <&pciesys>;
+		status = "disabled";
+	};
+
+	sata_phy: sata-phy at 1a243000 {
+		compatible = "mediatek,generic-tphy-v1";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		sata_port: sata-phy at 1a243000 {
+			reg = <0 0x1a243000 0 0x0100>;
+			clocks = <&topckgen CLK_TOP_ETH_500M>;
+			clock-names = "ref";
+			#phy-cells = <1>;
+		};
+	};
+
 	ethsys: syscon at 1b000000 {
 		compatible = "mediatek,mt7622-ethsys",
 			     "syscon";
-- 
2.7.4
