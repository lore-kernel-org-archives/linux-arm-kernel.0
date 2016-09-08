From: khilman@baylibre.com (Kevin Hilman)
Date: Thu,  8 Sep 2016 11:33:24 -0700
Subject: [PATCH v2] ARM: dts: da850-lcdk: Add NAND to DT
Message-ID: <20160908183324.32389-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Karl Beldan <kbeldan@baylibre.com>

This adds DT support for the NAND connected to the SoC AEMIF.
Passed torture hashing a 40MB file on top of UBIFS using subpages.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
[khilman: add back default partitions from an earlier patch]
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
Applies on Sekhar's v4.9/dts branch.

Sekhar, feel free to edit the comment text for the partitions as you see fit.

 arch/arm/boot/dts/da850-lcdk.dts | 83 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 7563260e95d1..7b8ab21fed6c 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -63,6 +63,27 @@
 			0x04 0x00000110 0x00000ff0
 		>;
 	};
+
+	nand_pins: nand_pins {
+		pinctrl-single,bits = <
+			/* EMA_WAIT[0], EMA_OE, EMA_WE, EMA_CS[3] */
+			0x1c 0x10110010  0xf0ff00f0
+			/*
+			 * EMA_D[0], EMA_D[1], EMA_D[2],
+			 * EMA_D[3], EMA_D[4], EMA_D[5],
+			 * EMA_D[6], EMA_D[7]
+			 */
+			0x24 0x11111111  0xffffffff
+			/*
+			 * EMA_D[8],  EMA_D[9],  EMA_D[10],
+			 * EMA_D[11], EMA_D[12], EMA_D[13],
+			 * EMA_D[14], EMA_D[15]
+			 */
+			0x20 0x11111111  0xffffffff
+			/* EMA_A[1], EMA_A[2] */
+			0x30 0x01100000  0x0ff00000
+		>;
+	};
 };
 
 &serial2 {
@@ -136,3 +157,65 @@
 	tx-num-evt = <32>;
 	rx-num-evt = <32>;
 };
+
+&aemif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nand_pins>;
+	status = "okay";
+	cs3 {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		clock-ranges;
+		ranges;
+
+		ti,cs-chipselect = <3>;
+
+		nand at 2000000,0 {
+			compatible = "ti,davinci-nand";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0 0x02000000 0x02000000
+			       1 0x00000000 0x00008000>;
+
+			ti,davinci-chipselect = <1>;
+			ti,davinci-mask-ale = <0>;
+			ti,davinci-mask-cle = <0>;
+			ti,davinci-mask-chipsel = <0>;
+
+			ti,davinci-nand-buswidth = <16>;
+			ti,davinci-ecc-mode = "hw";
+			ti,davinci-ecc-bits = <4>;
+			ti,davinci-nand-use-bbt;
+
+			/*
+			 * The OMAP-L132/L138 Bootloader doc SPRAB41E reads:
+			 * "To boot from NAND Flash, the AIS should be written
+			 * to NAND block 1 (NAND block 0 is not used by default)".
+			 * The same doc mentions that for ROM "Silicon Revision 2.1",
+			 * "Updated NAND boot mode to offer boot from block 0 or block 1".
+			 * However the limitaion is left here by default for compatibility
+			 * with older silicon and because it needs new boot pin settings
+			 * not possible in stock LCDK.
+			 */
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition at 0 {
+					label = "u-boot env";
+					reg = <0 0x020000>;
+				};
+				partition at 0x020000 {
+					/* The LCDK defaults to booting from this partition */
+					label = "u-boot";
+					reg = <0x020000 0x080000>;
+				};
+				partition at 0x0a0000 {
+					label = "free space";
+					reg = <0x0a0000 0>;
+				};
+			};
+		};
+	};
+};
-- 
2.9.3
