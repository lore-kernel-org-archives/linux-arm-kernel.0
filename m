From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 22 May 2017 14:25:51 +0800
Subject: [PATCH 5/6] ARM: sun8i: a83t: Add device node for SPDIF transmitter
In-Reply-To: <20170522062552.19026-1-wens@csie.org>
References: <20170522062552.19026-1-wens@csie.org>
Message-ID: <20170522062552.19026-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T SoC has an SPDIF transmitter block. According to the vendor
BSP kernel, it is compatible with the one found on the H3 SoC.

Add a device node and pinmux setting for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 47196feda26b..1dc4cfe81534 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -202,6 +202,11 @@
 				bias-pull-up;
 			};
 
+			spdif_tx_pin: spdif-tx-pin {
+				pins = "PE18";
+				function = "spdif";
+			};
+
 			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB9", "PB10";
 				function = "uart0";
@@ -228,6 +233,22 @@
 			clocks = <&osc24M>;
 		};
 
+		spdif: spdif at 1c21000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-a83t-spdif",
+				     "allwinner,sun8i-h3-spdif";
+			reg = <0x01c21000 0x400>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu 44>, <&ccu 76>;
+			resets = <&ccu 32>;
+			clock-names = "apb", "spdif";
+			dmas = <&dma 2>;
+			dma-names = "tx";
+			pinctrl-names = "default";
+			pinctrl-0 = <&spdif_tx_pin>;
+			status = "disabled";
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.11.0
