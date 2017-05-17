From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 17 May 2017 21:52:57 +0800
Subject: [PATCH] ARM: sun8i: v3s: enable SPI
Message-ID: <20170517135257.1674-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner V3s SoC has a SPI controller, muxed with the MMC2 controller
at PC bank. The controller itself is identical to the one in H3 SoC.

Add device tree node and the only pinmux node for it.

Tested with a Winbond W25Q128FV SPI NOR soldered on the Lichee Pi
early sample.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 6ff50665e5e6..a49ebef53c91 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -234,6 +234,11 @@
 				drive-strength = <30>;
 				bias-pull-up;
 			};
+
+			spi0_pins: spi0 {
+				pins = "PC0", "PC1", "PC2", "PC3";
+				function = "spi0";
+			};
 		};
 
 		timer at 01c20c00 {
@@ -314,6 +319,20 @@
 			#size-cells = <0>;
 		};
 
+		spi0: spi at 1c68000 {
+			compatible = "allwinner,sun8i-h3-spi";
+			reg = <0x01c68000 0x1000>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
+			clock-names = "ahb", "mod";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi0_pins>;
+			resets = <&ccu RST_BUS_SPI0>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		gic: interrupt-controller at 01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-- 
2.12.2
