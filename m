From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue,  4 Apr 2017 17:50:58 +0800
Subject: [PATCH v4 3/5] arm64: allwinner: a64: add r_ccu node
In-Reply-To: <20170404095100.18649-1-icenowy@aosc.io>
References: <20170404095100.18649-1-icenowy@aosc.io>
Message-ID: <20170404095100.18649-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.xyz>

A64 SoC have a CCU (r_ccu) in PRCM block.

Add the device node for it.

The mux 3 of R_CCU is an internal oscillator, which is 16MHz according
to the user manual, and has only 30% accuracy based on our experience
on older SoCs. The real mesaured value of it on two Pine64 boards is
around 11MHz, which is around 70% of 16MHz.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v4:
- Temporarily dropped the CCU headers.
Changes in v3:
- Change osc32000 to iosc, which is 16MHz plus minus 30%, according to the
  RTC chapter of the user manual and our experiences on A33.
Changes in v2:
- Add osc32000.

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1c64ea2d23f9..1d4e5bcced0c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -98,6 +98,14 @@
 		clock-output-names = "osc32k";
 	};
 
+	iosc: internal-osc-clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <16000000>;
+		clock-accuracy = <300000000>;
+		clock-output-names = "iosc";
+	};
+
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
@@ -392,5 +400,14 @@
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		r_ccu: clock at 1f01400 {
+			compatible = "allwinner,sun50i-a64-r-ccu";
+			reg = <0x01f01400 0x100>;
+			clocks = <&osc24M>, <&osc32k>, <&iosc>;
+			clock-names = "hosc", "losc", "iosc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
2.12.2
