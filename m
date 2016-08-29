From: kbeldan@baylibre.com (Karl Beldan)
Date: Mon, 29 Aug 2016 15:32:42 +0000
Subject: [PATCH] ARM: dts: da850-lcdk: Add NAND to DT
Message-ID: <20160829153242.18615-1-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds DT support for the NAND connected to the SoC AEMIF.
Passed torture hashing a 40MB file on top of UBIFS using subpages.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
v2:

- Removed comments pertaining to the BSP the LCDK ships with (Sekhar)
- s/"ok"/"okay"/
- Removed partitions since it relates to the BSP the LCDK ships with and
  also removed the references to the shortcomings of davinci_nand wrt DT
  parsing vs scan_ident (use of ti,davinci-ecc* vs nand-ecc*)
- use 4-bit ECC (since I have sent a fix for the driver)

 arch/arm/boot/dts/da850-lcdk.dts | 53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 7563260..1665eee 100644
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
@@ -136,3 +157,35 @@
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
+		};
+	};
+};
-- 
2.9.2
