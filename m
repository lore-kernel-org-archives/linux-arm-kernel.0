From: stefan@agner.ch (Stefan Agner)
Date: Wed, 22 Oct 2014 18:27:54 +0200
Subject: [PATCH v2 1/4] ARM: dts: vf610: assign oscillator to clock module
In-Reply-To: <1413995277-2844-1-git-send-email-stefan@agner.ch>
References: <1413995277-2844-1-git-send-email-stefan@agner.ch>
Message-ID: <1413995277-2844-2-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock controller module (CCM) has several clock inputs, which
are connected to external crystal oscillators. To reflect this,
assign these fixed clocks to the CCM node directly.

This especially resolves initialization order dependencies we had
with the earlier initialization code: When resolving of the fixed
clocks failed in clk-vf610, the code created fixed clocks with a
rate of 0.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 .../devicetree/bindings/clock/vf610-clock.txt      | 15 +++++++++++++
 arch/arm/boot/dts/vf610-cosmic.dts                 | 14 ++++++------
 arch/arm/boot/dts/vf610-twr.dts                    | 25 ++++++++++++----------
 arch/arm/boot/dts/vf610.dtsi                       | 25 ++++++++++------------
 4 files changed, 48 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/vf610-clock.txt b/Documentation/devicetree/bindings/clock/vf610-clock.txt
index c80863d..63f9f1a 100644
--- a/Documentation/devicetree/bindings/clock/vf610-clock.txt
+++ b/Documentation/devicetree/bindings/clock/vf610-clock.txt
@@ -5,6 +5,19 @@ Required properties:
 - reg: Address and length of the register set
 - #clock-cells: Should be <1>
 
+Optional properties:
+- clocks: list of clock identifiers which are external input clocks to the
+	given clock controller. Please refer the next section to find
+	the input clocks for a given controller.
+- clock-names: list of names of clocks which are exteral input clocks to the
+	given clock controller.
+
+Input clocks for top clock controller:
+	- sxosc (external crystal oscillator 32KHz, recommended)
+	- fxosc (external crystal oscillator 24MHz, recommended)
+	- audio_ext
+	- enet_ext
+
 The clock consumer should specify the desired clock by having the clock
 ID in its "clocks" phandle cell. See include/dt-bindings/clock/vf610-clock.h
 for the full list of VF610 clock IDs.
@@ -15,6 +28,8 @@ clks: ccm at 4006b000 {
 	compatible = "fsl,vf610-ccm";
 	reg = <0x4006b000 0x1000>;
 	#clock-cells = <1>;
+	clocks = <&sxosc>, <&fxosc>;
+	clock-names = "sxosc", "fxosc";
 };
 
 uart1: serial at 40028000 {
diff --git a/arch/arm/boot/dts/vf610-cosmic.dts b/arch/arm/boot/dts/vf610-cosmic.dts
index 3fd1b74..b0ce8b8 100644
--- a/arch/arm/boot/dts/vf610-cosmic.dts
+++ b/arch/arm/boot/dts/vf610-cosmic.dts
@@ -23,14 +23,16 @@
 		reg = <0x80000000 0x10000000>;
 	};
 
-	clocks {
-		enet_ext {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <50000000>;
-		};
+	enet_ext: enet_ext {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
 	};
+};
 
+&clks {
+	clocks = <&sxosc>, <&fxosc>, <&enet_ext>;
+	clock-names = "sxosc", "fxosc", "enet_ext";
 };
 
 &fec1 {
diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 189b697..7d06d1a 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -22,18 +22,16 @@
 		reg = <0x80000000 0x8000000>;
 	};
 
-	clocks {
-		audio_ext {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <24576000>;
-		};
+	audio_ext: mclk_osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
 
-		enet_ext {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <50000000>;
-		};
+	enet_ext: eth_osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <50000000>;
 	};
 
 	regulators {
@@ -95,6 +93,11 @@
 	status = "okay";
 };
 
+&clks {
+	clocks = <&sxosc>, <&fxosc>, <&enet_ext>, <&audio_ext>;
+	clock-names = "sxosc", "fxosc", "enet_ext", "audio_ext";
+};
+
 &dspi0 {
 	bus-num = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 699da48..ed12d9a 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -44,21 +44,16 @@
 		};
 	};
 
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		sxosc {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-		};
+	fxosc: fxosc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
 
-		fxosc {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <24000000>;
-		};
+	sxosc: sxosc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
 	};
 
 	soc {
@@ -358,6 +353,8 @@
 			clks: ccm at 4006b000 {
 				compatible = "fsl,vf610-ccm";
 				reg = <0x4006b000 0x1000>;
+				clocks = <&sxosc>, <&fxosc>;
+				clock-names = "sxosc", "fxosc";
 				#clock-cells = <1>;
 			};
 
-- 
2.1.2
