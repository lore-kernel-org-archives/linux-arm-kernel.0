From: kbeldan@baylibre.com (Karl Beldan)
Date: Tue, 16 Aug 2016 22:33:37 +0000
Subject: [PATCH v3 3/4] ARM: dts: da850,
 da850-evm: Add an aemif node and use it for the NAND
In-Reply-To: <20160816223338.20776-1-kbeldan@baylibre.com>
References: <20160816223338.20776-1-kbeldan@baylibre.com>
Message-ID: <20160816223338.20776-4-kbeldan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the davinci da8xx boards use the mach-davinci aemif code.
Instantiating an aemif node into the DT allows to use the ti-aemif
memory driver and is another step to better DT support.
This change adds an aemif node in the dtsi while retiring the nand_cs3
node. The NAND is now instantiated in the dts as a subnode of the aemif
one along with its pins.

Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
---
 arch/arm/boot/dts/da850-evm.dts | 49 ++++++++++++++++++++++++++++++++++++-----
 arch/arm/boot/dts/da850.dtsi    | 35 +++++++----------------------
 2 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 1a15db8..eedcc59 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -29,6 +29,20 @@
 					0x04 0x00011000 0x000ff000
 				>;
 			};
+			nand_pins: nand_pins {
+				pinctrl-single,bits = <
+					/* EMA_WAIT[0], EMA_OE, EMA_WE, EMA_CS[4], EMA_CS[3] */
+					0x1c 0x10110110  0xf0ff0ff0
+					/*
+					 * EMA_D[0], EMA_D[1], EMA_D[2],
+					 * EMA_D[3], EMA_D[4], EMA_D[5],
+					 * EMA_D[6], EMA_D[7]
+					 */
+					0x24 0x11111111  0xffffffff
+					/* EMA_A[1], EMA_A[2] */
+					0x30 0x01100000  0x0ff00000
+				>;
+			};
 		};
 		serial0: serial at 42000 {
 			status = "okay";
@@ -131,11 +145,6 @@
 			status = "okay";
 		};
 	};
-	nand_cs3 at 62000000 {
-		status = "okay";
-		pinctrl-names = "default";
-		pinctrl-0 = <&nand_cs3_pins>;
-	};
 	vbat: fixedregulator at 0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
@@ -250,3 +259,33 @@
 &edma1 {
 	ti,edma-reserved-slot-ranges = <32 90>;
 };
+
+&aemif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nand_pins>;
+	status = "ok";
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
+			ti,davinci-ecc-mode = "hw";
+			ti,davinci-ecc-bits = <4>;
+			ti,davinci-nand-use-bbt;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index bc10e7e..9ba018f 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -77,22 +77,6 @@
 					0x10 0x00220000 0x00ff0000
 				>;
 			};
-			nand_cs3_pins: pinmux_nand_pins {
-				pinctrl-single,bits = <
-					/* EMA_OE, EMA_WE */
-					0x1c 0x00110000  0x00ff0000
-					/* EMA_CS[4],EMA_CS[3]*/
-					0x1c 0x00000110  0x00000ff0
-					/*
-					 * EMA_D[0], EMA_D[1], EMA_D[2],
-					 * EMA_D[3], EMA_D[4], EMA_D[5],
-					 * EMA_D[6], EMA_D[7]
-					 */
-					0x24 0x11111111  0xffffffff
-					/* EMA_A[1], EMA_A[2] */
-					0x30 0x01100000  0x0ff00000
-				>;
-			};
 			i2c0_pins: pinmux_i2c0_pins {
 				pinctrl-single,bits = <
 					/* I2C0_SDA,I2C0_SCL */
@@ -411,17 +395,14 @@
 			dma-names = "tx", "rx";
 		};
 	};
-	nand_cs3@62000000 {
-		compatible = "ti,davinci-nand";
-		reg = <0x62000000 0x807ff
-		       0x68000000 0x8000>;
-		ti,davinci-chipselect = <1>;
-		ti,davinci-mask-ale = <0>;
-		ti,davinci-mask-cle = <0>;
-		ti,davinci-mask-chipsel = <0>;
-		ti,davinci-ecc-mode = "hw";
-		ti,davinci-ecc-bits = <4>;
-		ti,davinci-nand-use-bbt;
+	aemif: aemif at 68000000 {
+		compatible = "ti,da850-aemif";
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		reg = <0x68000000 0x00008000>;
+		ranges = <0 0 0x60000000 0x08000000
+			  1 0 0x68000000 0x00008000>;
 		status = "disabled";
 	};
 };
-- 
2.9.2
