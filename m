From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 20 Feb 2014 15:57:18 +0100
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7778/r8a7779 dtsi: Improve and
 correct HSPI bindings
Message-ID: <1392908239-22645-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Binding documentation:
  - Add future-proof "renesas,hspi-<soctype>" compatible values,
  - Add "interrupt-parent", "#address-cells" and "#size-cells" properties,
  - Add reference to pinctrl documentation,
  - Add example bindings.

r8a7778 and r8a7779 dtsi:
  - Add "renesas,hspi-r8a7778" resp. "renesas,hspi-r8a7779" compatible
    values,
  - Correct reference to parent interrupt controller
    (use "interrupt-parent" instead of "interrupt-controller"),
  - Add missing "#address-cells" and "#size-cells" properties, which are
    needed when populating the SPI buses.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [HSPI/BockW]
Cc: Mark Brown <broonie@linaro.org>
---
v2:
  - Add Tested-by
  - List full example compatible properties with soctypes instead of just
    the soctypes, so checkpatch can validate DTSes.

 Documentation/devicetree/bindings/spi/sh-hspi.txt |   28 ++++++++++++++++++---
 arch/arm/boot/dts/r8a7778.dtsi                    |   18 ++++++++-----
 arch/arm/boot/dts/r8a7779.dtsi                    |   18 ++++++++-----
 3 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-hspi.txt b/Documentation/devicetree/bindings/spi/sh-hspi.txt
index 30b57b1c8a13..319bad4af875 100644
--- a/Documentation/devicetree/bindings/spi/sh-hspi.txt
+++ b/Documentation/devicetree/bindings/spi/sh-hspi.txt
@@ -1,7 +1,29 @@
 Renesas HSPI.
 
 Required properties:
-- compatible : 	"renesas,hspi"
-- reg : Offset and length of the register set for the device
-- interrupts : interrupt line used by HSPI
+- compatible       : "renesas,hspi-<soctype>", "renesas,hspi" as fallback.
+		     Examples with soctypes are:
+		       - "renesas,hspi-r8a7778" (R-Car M1)
+		       - "renesas,hspi-r8a7779" (R-Car H1)
+- reg              : Offset and length of the register set for the device
+- interrupt-parent : The phandle for the interrupt controller that
+		     services interrupts for this device
+- interrupts       : Interrupt specifier
+- #address-cells   : Must be <1>
+- #size-cells      : Must be <0>
+
+Pinctrl properties might be needed, too.  See
+Documentation/devicetree/bindings/pinctrl/renesas,*.
+
+Example:
+
+	hspi0: spi at fffc7000 {
+		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
+		reg = <0xfffc7000 0x18>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
 
diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 85c5b3b99f5e..3c6fab5c9702 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -204,26 +204,32 @@
 	};
 
 	hspi0: spi at fffc7000 {
-		compatible = "renesas,hspi";
+		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
 		reg = <0xfffc7000 0x18>;
-		interrupt-controller = <&gic>;
+		interrupt-parent = <&gic>;
 		interrupts = <0 63 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
 	hspi1: spi at fffc8000 {
-		compatible = "renesas,hspi";
+		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
 		reg = <0xfffc8000 0x18>;
-		interrupt-controller = <&gic>;
+		interrupt-parent = <&gic>;
 		interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
 	hspi2: spi at fffc6000 {
-		compatible = "renesas,hspi";
+		compatible = "renesas,hspi-r8a7778", "renesas,hspi";
 		reg = <0xfffc6000 0x18>;
-		interrupt-controller = <&gic>;
+		interrupt-parent = <&gic>;
 		interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 };
diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index d0561d4c7c46..8b1a336ee401 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -256,26 +256,32 @@
 	};
 
 	hspi0: spi at fffc7000 {
-		compatible = "renesas,hspi";
+		compatible = "renesas,hspi-r8a7779", "renesas,hspi";
 		reg = <0xfffc7000 0x18>;
-		interrupt-controller = <&gic>;
+		interrupt-parent = <&gic>;
 		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
 	hspi1: spi at fffc8000 {
-		compatible = "renesas,hspi";
+		compatible = "renesas,hspi-r8a7779", "renesas,hspi";
 		reg = <0xfffc8000 0x18>;
-		interrupt-controller = <&gic>;
+		interrupt-parent = <&gic>;
 		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 
 	hspi2: spi at fffc6000 {
-		compatible = "renesas,hspi";
+		compatible = "renesas,hspi-r8a7779", "renesas,hspi";
 		reg = <0xfffc6000 0x18>;
-		interrupt-controller = <&gic>;
+		interrupt-parent = <&gic>;
 		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
 		status = "disabled";
 	};
 };
-- 
1.7.9.5
