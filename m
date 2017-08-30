From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Thu, 31 Aug 2017 01:06:37 +0200
Subject: [PATCH v2] arm64: allwinner: a64: add SPI nodes
Message-ID: <20170830230637.13010-1-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 SPI controllers are register compatible to the h3/h5 SPI
controllers.

The A64 has two SPI controllers, each with a single chip select.
The handles for the DMA channels (23/24 for SPI0/SPI1) are omitted,
as the A64 DMA support is currently missing.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
v2: - order nodes by memory address
    - drop enabling of spi nodes for Pine64, spi pins are on external
      connector and some other function might be used

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index bd0f33b77f57..7be9eb2ad83c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -325,6 +325,16 @@
 				drive-strength = <40>;
 			};
 
+			spi0_pins: spi0 {
+				pins = "PC0", "PC1", "PC2", "PC3";
+				function = "spi0";
+			};
+
+			spi1_pins: spi1 {
+				pins = "PD0", "PD1", "PD2", "PD3";
+				function = "spi1";
+			};
+
 			uart0_pins_a: uart0 at 0 {
 				pins = "PB8", "PB9";
 				function = "uart0";
@@ -469,6 +479,36 @@
 			};
 		};
 
+		spi0: spi at 01c68000 {
+			compatible = "allwinner,sun8i-h3-spi";
+			reg = <0x01c68000 0x1000>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
+			clock-names = "ahb", "mod";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi0_pins>;
+			resets = <&ccu RST_BUS_SPI0>;
+			status = "disabled";
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi at 01c69000 {
+			compatible = "allwinner,sun8i-h3-spi";
+			reg = <0x01c69000 0x1000>;
+			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;
+			clock-names = "ahb", "mod";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_pins>;
+			resets = <&ccu RST_BUS_SPI1>;
+			status = "disabled";
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		gic: interrupt-controller at 1c81000 {
 			compatible = "arm,gic-400";
 			reg = <0x01c81000 0x1000>,
-- 
2.14.1
