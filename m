From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Tue, 22 Jan 2013 03:12:55 -0300
Subject: [PATCH 2/3] arm: sunxi: Add clock definitions for the new clock driver
In-Reply-To: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
References: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1358835176-7197-3-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces proper clock definitions on sunxi.dtsi, to be used
with the new clock driver for sunxi.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sunxi.dtsi | 55 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
index 8bbc2bf..e2cef13 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -24,13 +24,56 @@
 
 	clocks {
 		#address-cells = <1>;
-		#size-cells = <0>;
+		#size-cells = <1>;
+		ranges;
 
-		osc: oscillator {
+		osc24M: osc24M at 01c20050 {
 			#clock-cells = <0>;
-			compatible = "fixed-clock";
+			compatible = "allwinner,sunxi-osc-clk";
+			reg = <0x01c20050 0x4>;
 			clock-frequency = <24000000>;
 		};
+
+		osc32k: osc32k {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+		};
+
+		pll1: pll1 at 01c20000 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sunxi-pll1-clk";
+			reg = <0x01c20000 0x4>;
+			clocks = <&osc24M>;
+		};
+
+		cpu: cpu at 01c20054 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sunxi-cpu-clk";
+			reg = <0x01c20054 0x4>;
+			clocks = <&osc32k>, <&osc24M>, <&pll1>;
+		};
+
+		axi: axi at 01c20054 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sunxi-axi-clk";
+			reg = <0x01c20054 0x4>;
+			clocks = <&cpu>;
+		};
+
+		ahb: ahb at 01c20054 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sunxi-ahb-clk";
+			reg = <0x01c20054 0x4>;
+			clocks = <&axi>;
+		};
+
+		apb0: apb0 at 01c20054 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sunxi-apb0-clk";
+			reg = <0x01c20054 0x4>;
+			clocks = <&ahb>;
+		};
 	};
 
 	soc {
@@ -44,7 +87,7 @@
 			compatible = "allwinner,sunxi-timer";
 			reg = <0x01c20c00 0x90>;
 			interrupts = <22>;
-			clocks = <&osc>;
+			clocks = <&osc24M>;
 		};
 
 		wdt: watchdog at 01c20c90 {
@@ -64,7 +107,7 @@
 			reg = <0x01c28000 0x400>;
 			interrupts = <1>;
 			reg-shift = <2>;
-			clock-frequency = <24000000>;
+			clocks = <&osc24M>;
 			status = "disabled";
 		};
 
@@ -73,7 +116,7 @@
 			reg = <0x01c28400 0x400>;
 			interrupts = <2>;
 			reg-shift = <2>;
-			clock-frequency = <24000000>;
+			clocks = <&osc24M>;
 			status = "disabled";
 		};
 	};
-- 
1.8.1.1
