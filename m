From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 17 Aug 2017 13:20:23 +0200
Subject: [RFC 2/4] arm64: dts: realtek: Add clock nodes for RTD1295
In-Reply-To: <20170817112026.24062-1-afaerber@suse.de>
References: <20170817112026.24062-1-afaerber@suse.de>
Message-ID: <20170817112026.24062-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 27 MHz oscillator and two clock controller nodes.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index 77063e984db9..078a11506876 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -81,6 +81,13 @@
 			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	osc27M: osc {
+		compatible = "fixed-clock";
+		clock-frequency = <27000000>;
+		#clock-cells = <0>;
+		clock-output-names = "osc27M";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -88,6 +95,13 @@
 		/* Exclude up to 2 GiB of RAM */
 		ranges = <0x80000000 0x80000000 0x80000000>;
 
+		clkc: clock-controller at 98000000 {
+			compatible = "realtek,rtd1295-clk";
+			reg = <0x98000000 0x1000>;
+			clocks = <&osc27M>;
+			#clock-cells = <1>;
+		};
+
 		reset1: reset-controller at 98000000 {
 			compatible = "realtek,rtd1295-reset";
 			reg = <0x98000000 0x4>;
@@ -112,6 +126,13 @@
 			#reset-cells = <1>;
 		};
 
+		iso_clkc: clock-controller at 98007000 {
+			compatible = "realtek,rtd1295-iso-clk";
+			reg = <0x98007000 0x100>;
+			clocks = <&osc27M>;
+			#clock-cells = <1>;
+		};
+
 		iso_irq_mux: interrupt-controller at 98007000 {
 			compatible = "realtek,rtd1295-iso-irq-mux";
 			reg = <0x98007000 0x100>;
-- 
2.12.3
