From: erin.lo@mediatek.com (Erin Lo)
Date: Fri, 13 Jan 2017 16:42:57 +0800
Subject: [PATCH v2 5/6] arm: dts: mt2701: Add ethernet device node.
In-Reply-To: <1484296978-18572-1-git-send-email-erin.lo@mediatek.com>
References: <1484296978-18572-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1484296978-18572-6-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add ethernet device node for MT2701.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm/boot/dts/mt2701-evb.dts | 40 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/mt2701.dtsi    | 22 ++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
index a483798..40abd3b 100644
--- a/arch/arm/boot/dts/mt2701-evb.dts
+++ b/arch/arm/boot/dts/mt2701-evb.dts
@@ -28,7 +28,47 @@
 	status = "okay";
 };
 
+&eth {
+	mac-address = [00 00 00 00 00 00];
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1_pins>;
+	gmac1: mac at 1 {
+		compatible = "mediatek,eth-mac";
+		reg = <1>;
+		phy-handle = <&phy5>;
+	};
+
+	mdio-bus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy5: ethernet-phy at 5 {
+			reg = <5>;
+			phy-mode = "rgmii-rxid";
+		};
+	};
+};
+
 &pio {
+	gmac1_pins: eth at 0 {
+		pins_eth {
+			pinmux = <MT2701_PIN_275_MDC__FUNC_MDC>,
+				 <MT2701_PIN_276_MDIO__FUNC_MDIO>,
+				 <MT2701_PIN_262_G2_TXEN__FUNC_G2_TXEN>,
+				 <MT2701_PIN_263_G2_TXD3__FUNC_G2_TXD3>,
+				 <MT2701_PIN_264_G2_TXD2__FUNC_G2_TXD2>,
+				 <MT2701_PIN_265_G2_TXD1__FUNC_G2_TXD1>,
+				 <MT2701_PIN_266_G2_TXD0__FUNC_G2_TXD0>,
+				 <MT2701_PIN_267_G2_TXC__FUNC_G2_TXC>,
+				 <MT2701_PIN_268_G2_RXC__FUNC_G2_RXC>,
+				 <MT2701_PIN_269_G2_RXD0__FUNC_G2_RXD0>,
+				 <MT2701_PIN_270_G2_RXD1__FUNC_G2_RXD1>,
+				 <MT2701_PIN_271_G2_RXD2__FUNC_G2_RXD2>,
+				 <MT2701_PIN_272_G2_RXD3__FUNC_G2_RXD3>,
+				 <MT2701_PIN_274_G2_RXDV__FUNC_G2_RXDV>;
+		};
+	};
+
 	spi_pins_a: spi0 at 0 {
 		pins_spi {
 			pinmux = <MT2701_PIN_53_SPI0_CSN__FUNC_SPI0_CS>,
diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 4f52019..3847f70 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -381,6 +381,28 @@
 		#clock-cells = <1>;
 	};
 
+	eth: ethernet at 1b100000 {
+		compatible = "mediatek,mt7623-eth";
+		reg = <0 0x1b100000 0 0x20000>;
+		interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 199 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 198 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&topckgen CLK_TOP_ETHIF_SEL>,
+			 <&apmixedsys CLK_APMIXED_TRGPLL>,
+			 <&ethsys CLK_ETHSYS_ESW>,
+			 <&ethsys CLK_ETHSYS_GP2>,
+			 <&ethsys CLK_ETHSYS_GP1>;
+		clock-names = "ethif", "trgpll", "esw", "gp2", "gp1";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_ETH>;
+		resets = <&watchdog MT2701_TOPRGU_ETHDMA_RST>;
+		reset-names = "eth";
+		mediatek,ethsys = <&ethsys>;
+		mediatek,pctl = <&syscfg_pctl_a>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	bdpsys: syscon at 1c000000 {
 		compatible = "mediatek,mt2701-bdpsys", "syscon";
 		reg = <0 0x1c000000 0 0x1000>;
-- 
1.9.1
