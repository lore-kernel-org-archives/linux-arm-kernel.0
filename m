From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 22 Jun 2017 12:08:31 +0800
Subject: [PATCH 4/6] ARM: sun8i: a83t: Add device node and pinmux setting for
 RSB controller
In-Reply-To: <20170622040833.15329-1-wens@csie.org>
References: <20170622040833.15329-1-wens@csie.org>
Message-ID: <20170622040833.15329-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T has an RSB controller for talking to the PMIC and audio codec.
Add a device node for it. Since there is only one usable pinmux setting,
for it, add that as well.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 21439d0aa55d..420b1484e17d 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -45,6 +45,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include <dt-bindings/clock/sun8i-r-ccu.h>
+#include <dt-bindings/reset/sun8i-r-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -309,6 +310,27 @@
 			#gpio-cells = <3>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
+
+			r_rsb_pins: r-rsb-pins {
+				pins = "PL0", "PL1";
+				function = "s_rsb";
+				drive-strength = <20>;
+				bias-pull-up;
+			};
+		};
+
+		r_rsb: rsb at 1f03400 {
+			compatible = "allwinner,sun8i-a23-rsb";
+			reg = <0x01f03400 0x400>;
+			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_APB0_RSB>;
+			clock-frequency = <3000000>;
+			resets = <&r_ccu RST_APB0_RSB>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_rsb_pins>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 	};
 };
-- 
2.11.0
