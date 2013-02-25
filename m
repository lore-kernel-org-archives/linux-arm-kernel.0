From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 25 Feb 2013 11:44:27 -0300
Subject: [PATCH v2 2/3] arm: sunxi: Add clock definitions for the new clock
 driver
In-Reply-To: <1361803468-9899-1-git-send-email-emilio@elopez.com.ar>
References: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
 <1361803468-9899-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1361803468-9899-3-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces proper clock definitions on sunxi.dtsi, to be used
with the new clock driver for sunxi.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sunxi.dtsi | 83 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
index 8b36abe..acf7777 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -24,13 +24,90 @@
 
 	clocks {
 		#address-cells = <1>;
-		#size-cells = <0>;
+		#size-cells = <1>;
+		ranges;
 
-		osc: oscillator {
+		/*
+		 * This is a dummy clock, to be used as placeholder on
+		 * other mux clocks when a specific parent clock is not
+		 * yet implemented. It should be dropped when the driver
+		 * is complete.
+		 */
+		dummy: dummy {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <0>;
+		};
+
+		osc24M_fixed: osc24M_fixed {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
 		};
+
+		osc24M: osc24M at 01c20050 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sunxi-osc-clk";
+			reg = <0x01c20050 0x4>;
+			clocks = <&osc24M_fixed>;
+		};
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
+		/* dummy is 200M */
+		cpu: cpu at 01c20054 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sunxi-cpu-clk";
+			reg = <0x01c20054 0x4>;
+			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&dummy>;
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
+
+		/* dummy is pll62 */
+		apb1_mux: apb1_mux at 01c20058 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sunxi-apb1-mux-clk";
+			reg = <0x01c20058 0x4>;
+			clocks = <&osc24M>, <&dummy>, <&osc32k>;
+		};
+
+		apb1: apb1 at 01c20058 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sunxi-apb1-clk";
+			reg = <0x01c20058 0x4>;
+			clocks = <&apb1_mux>;
+		};
 	};
 
 	soc {
@@ -44,7 +121,7 @@
 			compatible = "allwinner,sunxi-timer";
 			reg = <0x01c20c00 0x90>;
 			interrupts = <22>;
-			clocks = <&osc>;
+			clocks = <&osc24M>;
 		};
 
 		wdt: watchdog at 01c20c90 {
-- 
1.8.2.rc0
