From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 4 Jan 2018 17:41:00 +0800
Subject: [PATCH 10/12] arm64: dts: mt7622: add ethernet device nodes
In-Reply-To: <cover.1515057696.git.sean.wang@mediatek.com>
References: <cover.1515057696.git.sean.wang@mediatek.com>
Message-ID: <fcb6981ef688bed54b097139d2b03a3641af5ed3.1515057696.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

add ethernet device nodes which enable GMAC1 with SGMII interface

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 22 ++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 31 ++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 20b1160..d4609a1 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -249,6 +249,28 @@
 	status = "okay";
 };
 
+&eth {
+	pinctrl-names = "default";
+	pinctrl-0 = <&eth_pins>;
+	status = "okay";
+
+	gmac1: mac at 1 {
+		compatible = "mediatek,eth-mac";
+		reg = <1>;
+		phy-handle = <&phy5>;
+	};
+
+	mdio-bus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy5: ethernet-phy at 5 {
+			reg = <5>;
+			phy-mode = "sgmii";
+		};
+	};
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 540d2fe..04a047e 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -477,6 +477,37 @@
 		#reset-cells = <1>;
 	};
 
+	eth: ethernet at 1b100000 {
+		compatible = "mediatek,mt7622-eth",
+			     "mediatek,mt2701-eth",
+			     "syscon";
+		reg = <0 0x1b100000 0 0x20000>;
+		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 224 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 225 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_ETH_SEL>,
+			 <&ethsys CLK_ETH_ESW_EN>,
+			 <&ethsys CLK_ETH_GP0_EN>,
+			 <&ethsys CLK_ETH_GP1_EN>,
+			 <&ethsys CLK_ETH_GP2_EN>,
+			 <&sgmiisys CLK_SGMII_TX250M_EN>,
+			 <&sgmiisys CLK_SGMII_RX250M_EN>,
+			 <&sgmiisys CLK_SGMII_CDR_REF>,
+			 <&sgmiisys CLK_SGMII_CDR_FB>,
+			 <&topckgen CLK_TOP_SGMIIPLL>,
+			 <&apmixedsys CLK_APMIXED_ETH2PLL>;
+		clock-names = "ethif", "esw", "gp0", "gp1", "gp2",
+			      "sgmii_tx250m", "sgmii_rx250m",
+			      "sgmii_cdr_ref", "sgmii_cdr_fb", "sgmii_ck",
+			      "eth2pll";
+		power-domains = <&scpsys MT7622_POWER_DOMAIN_ETHSYS>;
+		mediatek,ethsys = <&ethsys>;
+		mediatek,sgmiisys = <&sgmiisys>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	sgmiisys: sgmiisys at 1b128000 {
 		compatible = "mediatek,mt7622-sgmiisys",
 			     "syscon";
-- 
2.7.4
