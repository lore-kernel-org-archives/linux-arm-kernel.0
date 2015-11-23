From: atx@atx.name (Josef Gajdusek)
Date: Mon, 23 Nov 2015 09:02:52 +0100
Subject: [PATCH v2 5/5] ARM: dts: sun8i: Add THS node to the H3 .dtsi
In-Reply-To: <cover.1448263428.git.atx@atx.name>
References: <cover.1448263428.git.atx@atx.name>
Message-ID: <0fff612e26bf9cda9027a4175e16d25a0c2cc62c.1448263428.git.atx@atx.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds nodes for the THS driver and the THS clock to the Allwinner
H3 .dtsi file.

Signed-off-by: Josef Gajdusek <atx@atx.name>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 58de718..48500d4 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -77,6 +77,14 @@
 		};
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu_thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&ths 0>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
@@ -236,6 +244,14 @@
 					"ahb1_ephy", "ahb1_dbg";
 		};
 
+		ths_clk: clk at 01c20074 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun8i-h3-ths-clk";
+			reg = <0x01c20074 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "ths";
+		};
+
 		mmc0_clk: clk at 01c20088 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun4i-a10-mmc-clk";
@@ -364,6 +380,10 @@
 			reg = <0x01c14000 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			ths_calibration: calib at 234 {
+				reg = <0x234 0x4>;
+			};
 		};
 
 		usbphy: phy at 01c19400 {
@@ -529,6 +549,19 @@
 			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		ths: ths at 01c25000 {
+			#thermal-sensor-cells = <0>;
+			compatible = "allwinner,sun8i-h3-ths";
+			reg = <0x01c25000 0x88>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&bus_rst 104>;
+			reset-names = "ahb";
+			clocks = <&bus_gates 72>, <&ths_clk>;
+			clock-names = "ahb", "ths";
+			nvmem-cells = <&ths_calibration>;
+			nvmem-cell-names = "calibration";
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.4.10
