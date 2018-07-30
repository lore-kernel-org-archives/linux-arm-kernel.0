From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Mon, 30 Jul 2018 14:40:07 +0300
Subject: [PATCH v6 2/3] ARM: dts: at91: sama5d2: add nodes for I2S controllers
In-Reply-To: <20180730114008.30464-1-codrin.ciubotariu@microchip.com>
References: <20180730114008.30464-1-codrin.ciubotariu@microchip.com>
Message-ID: <20180730114008.30464-3-codrin.ciubotariu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyrille Pitchen <cyrille.pitchen@atmel.com>

This patch adds DT nodes for I2S0 and I2S1. It also adds an alias for
each I2S node.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
[codrin.ciubotariu at microchip.com: removed unnecessary clock phandles]
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v6:
	- removed unnecessary phandles to audio PLL clock from the I2S nodes;
	- using assigned clocks to set gclk as parent of i2smuxclk;

 arch/arm/boot/dts/sama5d2.dtsi | 38 ++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index eeb6afa1cda7..bf71dc00223a 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -58,6 +58,8 @@
 		serial1 = &uart3;
 		tcb0 = &tcb0;
 		tcb1 = &tcb1;
+		i2s0 = &i2s0;
+		i2s1 = &i2s1;
 	};
 
 	cpus {
@@ -1313,6 +1315,24 @@
 				clocks = <&clk32k>;
 			};
 
+			i2s0: i2s at f8050000 {
+				compatible = "atmel,sama5d2-i2s";
+				reg = <0xf8050000 0x100>;
+				interrupts = <54 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(31))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(32))>;
+				dma-names = "tx", "rx";
+				clocks = <&i2s0_clk>, <&i2s0_gclk>;
+				clock-names = "pclk", "gclk";
+				assigned-clocks = <&i2s0muxck>;
+				assigned-clock-parents = <&i2s0_gclk>;
+				status = "disabled";
+			};
+
 			can0: can at f8054000 {
 				compatible = "bosch,m_can";
 				reg = <0xf8054000 0x4000>, <0x210000 0x4000>;
@@ -1506,6 +1526,24 @@
 				status = "disabled";
 			};
 
+			i2s1: i2s at fc04c000 {
+				compatible = "atmel,sama5d2-i2s";
+				reg = <0xfc04c000 0x100>;
+				interrupts = <55 IRQ_TYPE_LEVEL_HIGH 7>;
+				dmas = <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(33))>,
+				       <&dma0
+					(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
+					 AT91_XDMAC_DT_PERID(34))>;
+				dma-names = "tx", "rx";
+				clocks = <&i2s1_clk>, <&i2s1_gclk>;
+				clock-names = "pclk", "gclk";
+				assigned-clocks = <&i2s1muxck>;
+				assigned-parrents = <&i2s1_gclk>;
+				status = "disabled";
+			};
+
 			can1: can at fc050000 {
 				compatible = "bosch,m_can";
 				reg = <0xfc050000 0x4000>, <0x210000 0x4000>;
-- 
2.17.1
