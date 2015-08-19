From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 19 Aug 2015 12:20:07 +0800
Subject: [PATCH v3 6/8] ARM: dts: sun8i: Add Reduced Serial Bus controller
 device node to A23/A33 dtsi
In-Reply-To: <1439958009-14056-1-git-send-email-wens@csie.org>
References: <1439958009-14056-1-git-send-email-wens@csie.org>
Message-ID: <1439958009-14056-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a device node for the Reduced Serial Bus (RSB)
controller and the defacto pinmux setting to the A23/A33 dtsi.

Since there is only one possible pinmux setting for RSB, just
set it in the dtsi.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 27a925ec17d2..db3671382cb2 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -661,6 +661,13 @@
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
+			r_rsb_pins: r_rsb {
+				allwinner,pins = "PL0", "PL1";
+				allwinner,function = "s_rsb";
+				allwinner,drive = <SUN4I_PINCTRL_20_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+			};
+
 			r_uart_pins_a: r_uart at 0 {
 				allwinner,pins = "PL2", "PL3";
 				allwinner,function = "s_uart";
@@ -668,5 +675,19 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 		};
+
+		r_rsb: i2c at 01f03400 {
+			compatible = "allwinner,sun8i-a23-rsb";
+			reg = <0x01f03400 0x400>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb0_gates 3>;
+			clock-frequency = <3000000>;
+			resets = <&apb0_rst 3>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_rsb_pins>;
+			status = "disabled";
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
 	};
 };
-- 
2.5.0
