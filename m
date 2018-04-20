From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 20 Apr 2018 15:38:11 +0800
Subject: [PATCH V3 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz clock
 source
In-Reply-To: <1524209891-14146-1-git-send-email-Anson.Huang@nxp.com>
References: <1524209891-14146-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1524209891-14146-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6SX SabreAuto board, there is external 24MHz clock
source for analog clock2, add this clock source to clock tree
and remove "clocks" container for all input clocks.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V2:
	remove "clocks" container and use new way for all input clocks definition.
 arch/arm/boot/dts/imx6sx-sabreauto.dts |  4 ++
 arch/arm/boot/dts/imx6sx.dtsi          | 71 ++++++++++++++++++----------------
 2 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 72da5ac..57d1ea0 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -37,6 +37,10 @@
 	};
 };
 
+&anaclk2 {
+	clock-frequency = <24576000>;
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 49c7205..7e463d2 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -104,41 +104,46 @@
 		interrupt-parent = <&intc>;
 	};
 
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <0>;
+	ckil: clock-ckil {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "ckil";
+	};
 
-		ckil: clock at 0 {
-			compatible = "fixed-clock";
-			reg = <0>;
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-			clock-output-names = "ckil";
-		};
+	osc: clock-osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "osc";
+	};
 
-		osc: clock at 1 {
-			compatible = "fixed-clock";
-			reg = <1>;
-			#clock-cells = <0>;
-			clock-frequency = <24000000>;
-			clock-output-names = "osc";
-		};
+	ipp_di0: clock-ipp-di0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "ipp_di0";
+	};
 
-		ipp_di0: clock at 2 {
-			compatible = "fixed-clock";
-			reg = <2>;
-			#clock-cells = <0>;
-			clock-frequency = <0>;
-			clock-output-names = "ipp_di0";
-		};
+	ipp_di1: clock-ipp-di1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "ipp_di1";
+	};
 
-		ipp_di1: clock at 3 {
-			compatible = "fixed-clock";
-			reg = <3>;
-			#clock-cells = <0>;
-			clock-frequency = <0>;
-			clock-output-names = "ipp_di1";
-		};
+	anaclk1: clock-anaclk1 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "anaclk1";
+	};
+
+	anaclk2: clock-anaclk2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+		clock-output-names = "anaclk2";
 	};
 
 	tempmon: tempmon {
@@ -575,8 +580,8 @@
 				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 				#clock-cells = <1>;
-				clocks = <&ckil>, <&osc>, <&ipp_di0>, <&ipp_di1>;
-				clock-names = "ckil", "osc", "ipp_di0", "ipp_di1";
+				clocks = <&ckil>, <&osc>, <&ipp_di0>, <&ipp_di1>, <&anaclk1>, <&anaclk2>;
+				clock-names = "ckil", "osc", "ipp_di0", "ipp_di1", "anaclk1", "anaclk2";
 			};
 
 			anatop: anatop at 20c8000 {
-- 
2.7.4
