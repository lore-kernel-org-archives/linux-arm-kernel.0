From: codekipper@gmail.com (codekipper at gmail.com)
Date: Mon, 29 Jan 2018 10:18:59 +0100
Subject: [linux-sunxi][PATCH v2 1/5] arm64: allwinner: a64: Add the SPDIF
 block and pin
In-Reply-To: <20180129091903.12319-1-codekipper@gmail.com>
References: <20180129091903.12319-1-codekipper@gmail.com>
Message-ID: <20180129091903.12319-2-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Add the SPDIF transceiver controller block and pin to the A64 dtsi.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index d783d164b9c3..43c54a2133f0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -336,6 +336,11 @@
 				drive-strength = <40>;
 			};
 
+			spdif_tx_pin: spdif {
+				pins = "PH8";
+				function = "spdif";
+			};
+
 			spi0_pins: spi0 {
 				pins = "PC0", "PC1", "PC2", "PC3";
 				function = "spi0";
@@ -382,6 +387,22 @@
 			};
 		};
 
+		spdif: spdif at 1c21000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun50i-a64-spdif",
+				     "allwinner,sun8i-h3-spdif";
+			reg = <0x01c21000 0x400>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_SPDIF>, <&ccu CLK_SPDIF>;
+			resets = <&ccu RST_BUS_SPDIF>;
+			clock-names = "apb", "spdif";
+			dmas = <&dma 2>;
+			dma-names = "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spdif_tx_pin>;
+			status = "disabled";
+		};
+
 		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.16.1
