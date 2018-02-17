From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Sun, 18 Feb 2018 03:54:44 +0800
Subject: [PATCH v3 09/15] arm64: dts: mt7622: add flash related device nodes
In-Reply-To: <cover.1518895232.git.sean.wang@mediatek.com>
References: <cover.1518895232.git.sean.wang@mediatek.com>
Message-ID: <beb719f3772b3dba25a026a8cfc7b477eb624b85.1518895232.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

add nodes for NOR flash, parallel Nand flash with error correction code
support.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: RogerCC Lin <rogercc.lin@mediatek.com>
Cc: Guochun Mao <guochun.mao@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 21 +++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 34 ++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index ba6a79c..48c5ba4 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -235,6 +235,10 @@
 	};
 };
 
+&bch {
+	status = "disabled";
+};
+
 &btif {
 	status = "okay";
 };
@@ -257,6 +261,23 @@
 	status = "okay";
 };
 
+&nandc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&parallel_nand_pins>;
+	status = "disabled";
+};
+
+&nor_flash {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_nor_pins>;
+	status = "disabled";
+
+	flash at 0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+	};
+};
+
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm7_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 448cd36..d287d75 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -468,6 +468,40 @@
 		status = "disabled";
 	};
 
+	nandc: nfi at 1100d000 {
+		compatible = "mediatek,mt7622-nfc";
+		reg = <0 0x1100D000 0 0x1000>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_NFI_PD>,
+			 <&pericfg CLK_PERI_SNFI_PD>;
+		clock-names = "nfi_clk", "pad_clk";
+		ecc-engine = <&bch>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	bch: ecc at 1100e000 {
+		compatible = "mediatek,mt7622-ecc";
+		reg = <0 0x1100e000 0 0x1000>;
+		interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_NFIECC_PD>;
+		clock-names = "nfiecc_clk";
+		status = "disabled";
+	};
+
+	nor_flash: spi at 11014000 {
+		compatible = "mediatek,mt7622-nor",
+			     "mediatek,mt8173-nor";
+		reg = <0 0x11014000 0 0xe0>;
+		clocks = <&pericfg CLK_PERI_FLASH_PD>,
+			 <&topckgen CLK_TOP_FLASH_SEL>;
+		clock-names = "spi", "sf";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	spi1: spi at 11016000 {
 		compatible = "mediatek,mt7622-spi";
 		reg = <0 0x11016000 0 0x100>;
-- 
2.7.4
