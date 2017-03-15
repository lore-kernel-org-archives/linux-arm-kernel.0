From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 16 Mar 2017 01:28:06 +0800
Subject: [PATCH v2 3/5] arm64: allwinner: a64: add r_ccu node
In-Reply-To: <20170315172808.64011-1-icenowy@aosc.xyz>
References: <20170315172808.64011-1-icenowy@aosc.xyz>
Message-ID: <20170315172808.64011-4-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A64 SoC have a CCU (r_ccu) in PRCM block.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v2:
- Add osc32000.

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1c64ea2d23f9..dbeba43386f6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -43,8 +43,10 @@
  */
 
 #include <dt-bindings/clock/sun50i-a64-ccu.h>
+#include <dt-bindings/clock/sun8i-r-ccu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/sun50i-a64-ccu.h>
+#include <dt-bindings/reset/sun8i-r-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -98,6 +100,13 @@
 		clock-output-names = "osc32k";
 	};
 
+	osc32000: osc32000_clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32000>;
+		clock-output-names = "osc32000";
+	};
+
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
@@ -392,5 +401,14 @@
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		r_ccu: clock at 1f01400 {
+			compatible = "allwinner,sun50i-a64-r-ccu";
+			reg = <0x01f01400 0x100>;
+			clocks = <&osc24M>, <&osc32k>, <&osc32000>;
+			clock-names = "hosc", "losc", "iosc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
2.12.0
